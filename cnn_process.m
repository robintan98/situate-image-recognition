function data = cnn_process( image, all_layers )
%CNN_PROCESS Uses a pre-trained CNN to extract features from an image. 
    global net layer;

    % load and preprocess an image
    im_ = single(image) ; % note: 0-255 range
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
    im_ = bsxfun(@minus, im_, net.meta.normalization.averageImage) ;

    if isa(net, 'dagnn.DagNN')
        % run the CNN
        net.eval({'data', im_});
        
        if nargin >= 2 && all_layers
            scores = map(net.vars, @(x) gather(x.value));
            data = scores;%map(scores, @(x) x(:));
            data = filt(data, @(x) size(x,1) <= 50000000);
        else
            scores = gather(net.vars(layer).value);
            data = scores(:);
        end
    else
        % run the CNN
        res = vl_simplenn(net, im_);
        
        if nargin >= 2 && all_layers
            data = map(res, @(x) x.x(:));
            data = filt(data, @(x) size(x,1) <= 50000000);
        else
            data = res(layer).x(:);
        end
    end
end


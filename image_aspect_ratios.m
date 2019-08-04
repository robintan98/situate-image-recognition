figure;
spid = 1;
for i={'Dog', 'DogWalker', 'Leash'}
    files = [];
    for j={'Positive', 'Negative'}
        path = ['Crops/' i{1} '/' j{1} '/'];
        files = [files; map(dir([path '*.jpg']), @(x) [path x.name])];
    end
    image_infos = map(files, @(x) imfinfo(x));
    sizes = map(image_infos, @(x) [x.Width, x.Height]);
    aspect_ratios = map(image_infos, @(x) log2(x.Width/x.Height), true);
    subplot(3,1,spid);
    spid = spid+1;
    %hist(cell2mat(sizes), 100);
    hist(aspect_ratios, 100);
    title(i{1});
end

function apprx_rat_matrix = applyFractionConvert(matrix)
    % Get the size of the matrix
    [row, col] = size(matrix);

    % Initialize the result matrix
    apprx_rat_matrix = cell(row, col);

    % Loop over rows
    for i = 1:row
        % Loop over columns
        for j = 1:col
            % Apply fractionconvert to each element of the matrix
            apprx_rat_matrix{i, j} = fractionconvert(matrix(i, j));
        end
    end
end
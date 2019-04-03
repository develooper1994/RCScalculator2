function db = todbsmall(E_)
rcs=4*pi*abs(E_).^2;
db=10*log10(rcs);
end

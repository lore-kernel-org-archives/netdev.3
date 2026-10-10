Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167F377A94
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649674; cv=none; b=QeOJfR52VYiUonT8dv7XR2A4n0KKJ4he6clVH/cWjV+LGPkx3J0uvMcm3pLKJFv93GEbYdwQTKb3E5S3+O4FICB3XyA8TW3+DUF0rJsc606LHhN0btKOB0pC+3OnfDAxA0jQ+Um6zf74PkYcCD0zlaMFHpSsFjnvcohrAPFjqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649674; c=relaxed/simple;
	bh=SZnjtIBKL1hdvA8/K3thIvkJHfNjrGKGyksa/PcBVzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ31MBaAiCaQJrTGw7hLGqQ+9h/EFuHge0vO9yOjnilrX30odmMYT8nlzCPytQSL2vqq4pMWw9tfuhTRA3acZrTVz4BCKSIXS/1apJ2KZmu0bBW57AsqjOvQ+DZ8UUe1ouIydukPwUrB3Ic3f5Dbo68ASQt/JIHc7Tguu5HkrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=xkrxJL6u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="xkrxJL6u"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so204642a12.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791649672; x=1792254472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DXAcsQcMb0rpwsXjv7XvaNNDyUfIbkRwoU5NHe4eL4=;
        b=xkrxJL6uYxrDtzHh2Ww+3cexW+5pBepH0qXLlNtd/hhS5vRFMDkZlIuxY/9/SU9J31
         Ly6xFK9wDQKCWNJNFQXiEZsghZsQJQmMyKOESLCMMpnPqjhAvV0B5tkbdXkHc2QNTbjz
         ALv3IMkVbRkxuQgmIBEtFD44uicoIqwMd9DBDTuy33Z/aeKXm+Pmpo8v2BFOWp0Stxjb
         Q24dYuj3d51iqpbropOOC1P6tazjLsJ3hiXSrQ3MGVZC3IibA29joNlIXE+sCwZ7dVn1
         skkFSfRYYQXtvueCLgrAo8n07NhBZn2erS2kCPLsZoQ6O2Zoql9u9ppMq6DVqWTVM3Ss
         Gfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649672; x=1792254472;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DXAcsQcMb0rpwsXjv7XvaNNDyUfIbkRwoU5NHe4eL4=;
        b=DDxsvjIzROcj1jnAvjQDGMQX0FS/8ABCo/weWF8xFK2zyd2zTU1IfuZSz3LiiqOm8o
         5kmXYvOJFXiM3uSrZy51oz60DCwPtpsLc0Wy6sA9p5GLpZPqXt9nKTq360E2Vl2TYnb3
         KRtkuAM9VIB6WJ8l/rhJIPmIMK1lghzRuiL7WTdeblFf3YXH3NIgWXQWkZdz1TB8OOyN
         DQmg8OHam/b/39m45OSaLzhSl/8ReNUVpnD4Kpw+Rx7HNfrK5bzWjgugT0LbVm3jNvg3
         Amt4vvbGXp8NK1KFT2fqELAaO2AbZNQkNV4EDgI3zdwxlQ7+Vp92giinmCjyDk2wHqvC
         yRiw==
X-Gm-Message-State: AFq9FYJTk0F+t5lUMQWYYwoYxxHhSvxERx0/pmoR1caxZihMFisZzObP
	eevcYz742LdLgginQs35kjFvGjesD6eamppmIL5eYL4w0UO3TKGQaVSgalRPFR8ddYg=
X-Gm-Gg: AYBFou1W7Yld1dArJv2w/7qGisKCSnH+C93mCHrNbiOnrx4/jmDYf6Z7Zj4SUvEELLl
	RAMxwQGzLrLOOBCMsbLQdV4tQYJuCnNWLl8nReJZa2dP+ZS2RpvRr9NbauwB/rGu63pBt8I1RaZ
	rqpuMFamx2n8R4tghjtn8fZ4sgmzu6SjAgn+nIiHU3bacbu+W4vPH/dUE2h2zTKpCW1G/RQCxwe
	uF+Vyd+wC+Z5/6v0f3ICuuClMssYyjPoKR+pyYWkZp4bmvEpHGAO22tFcw1EJ823n6R9Tu+V2gU
	UdObcpxe0F/EzNeL7h4kfi5rY9qB0oof0nwkgKzgIUWODNKLXyPDUVOe34+ZhodGBvooNnxK5EA
	w3g2NhrngLLfhP0KksdHl7DVkS1QGMgCi30uxa6S1lz/v5JqyiOmG0ubNBKgUuNRo3QYgcayM0C
	Cugn+hY/OyegDCME/CBcYytPGJRnBbEshJgvGMNrWyT3j5ZzBmMf4APf5lGMor4V+EKLg6bN3KL
	R3bJ0yuLFjuG6Cs4ARsIqfnkvqfWyOj9iy2tgNr
X-Received: by 2002:a17:90b:1d48:b0:3a6:582e:5e17 with SMTP id 98e67ed59e1d1-3ab3ab25b70mr2906005a91.48.1791649672479;
        Sat, 10 Oct 2026 09:27:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab339684f0sm4573627a91.1.2026.10.10.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:27:52 -0700 (PDT)
Date: Sat, 10 Oct 2026 09:27:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, horatiu.vultur@microchip.com, bridge@lists.linux.dev
Subject: Re: [PATCH iproute2-next 2/2] bridge: add cfm command
Message-ID: <20261010092749.6bfd087e@phoenix.local>
In-Reply-To: <20261004041307.2683990-3-w453y.me@gmail.com>
References: <20261004041307.2683990-1-w453y.me@gmail.com>
	<20261004041307.2683990-3-w453y.me@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Oct 2026 04:13:07 +0000
Abdul Wasey <w453y.me@gmail.com> wrote:

> +static int cfm_parse_interval(const char *str)
> +{
> +	if (!strcmp(str, "none"))
> +		return BR_CFM_CCM_INTERVAL_NONE;
> +	if (!strcmp(str, "3ms3") || !strcmp(str, "3.3ms"))
> +		return BR_CFM_CCM_INTERVAL_3_3_MS;
> +	if (!strcmp(str, "10ms"))
> +		return BR_CFM_CCM_INTERVAL_10_MS;
> +	if (!strcmp(str, "100ms"))
> +		return BR_CFM_CCM_INTERVAL_100_MS;
> +	if (!strcmp(str, "1s"))
> +		return BR_CFM_CCM_INTERVAL_1_SEC;
> +	if (!strcmp(str, "10s"))
> +		return BR_CFM_CCM_INTERVAL_10_SEC;
> +	if (!strcmp(str, "1m"))
> +		return BR_CFM_CCM_INTERVAL_1_MIN;
> +	if (!strcmp(str, "10m"))
> +		return BR_CFM_CCM_INTERVAL_10_MIN;
> +	return -1;
> +}
> +
> +static const char *cfm_interval_str(__u32 interval)
> +{
> +	switch (interval) {
> +	case BR_CFM_CCM_INTERVAL_NONE:
> +		return "none";
> +	case BR_CFM_CCM_INTERVAL_3_3_MS:
> +		return "3ms3";
> +	case BR_CFM_CCM_INTERVAL_10_MS:
> +		return "10ms";
> +	case BR_CFM_CCM_INTERVAL_100_MS:
> +		return "100ms";
> +	case BR_CFM_CCM_INTERVAL_1_SEC:
> +		return "1s";
> +	case BR_CFM_CCM_INTERVAL_10_SEC:
> +		return "10s";
> +	case BR_CFM_CCM_INTERVAL_1_MIN:
> +		return "1m";
> +	case BR_CFM_CCM_INTERVAL_10_MIN:
> +		return "10m";
> +	default:
> +		return "unknown";
> +	}
> +}

Iproute2 already has helpers get_time and print_time.

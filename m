Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB342048D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237546; cv=none; b=gDhgvYaAKKIuGAxCfRAH8fC8bQyadRb/3+xKmij/Dp4Ibqj3RDpIWWjyeANRpQn9eAY4gPxLw6tgYl0Dg/XFuHoavGrHqWicuD0fVgC4C7fnPStmWYVNW1Z0yIO2Buj7PwY6SoKXtdighbCcbvhmlWhYOVoQL/xHy0WjejjdLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237546; c=relaxed/simple;
	bh=98mgw/U1oy2W08Ldsrk5JbOeApkv3va3FWc5iGX1eRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BzVdCV4KhFB1IWxJzIzEHG4P5FB739l+wENykeZ7HLljrAK4cHcJYMHHK/szgEQAs9VD4KDWI2CavmPTWJOqUbwKLL/9b9xIC9OiUtAbKv/Vtj2actMwEzemV4Ztqh6vf5tjJZFXWwLkMqcfasIU7yd07MDvWslj86lXedSM/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDHIa4Q2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJekVYfE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDHIa4Q2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJekVYfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785237544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fNd2vS4oPJ9o8eQmr9a5wVsI0gNjkKY4kjgjH6Yoc8=;
	b=JDHIa4Q242h92kgyPnK5KO8qMxZl0g805yZ5fDaToqlhEoIhC5/qDbayj6bWykcmfTUxfo
	l9m6yL5MO91wUCuKpqXA0JIloXnSHs7kGXAYEAS+bIyQUAYzsbW+FRFshXUeNa/eXt03gK
	0F4Dtz+fyNagGIkx3qOwO7XAXKblXbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-TcD2dDRHOviurAE20avdXg-1; Tue, 28 Jul 2026 07:19:02 -0400
X-MC-Unique: TcD2dDRHOviurAE20avdXg-1
X-Mimecast-MFC-AGG-ID: TcD2dDRHOviurAE20avdXg_1785237541
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f4bff865cso1960627f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785237541; x=1785842341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/fNd2vS4oPJ9o8eQmr9a5wVsI0gNjkKY4kjgjH6Yoc8=;
        b=YJekVYfEIvbpmDhiCXXpS89/9t3zuOyASPbFP8qJsyQYN6lcD1gy5uW8KqewjWybyn
         IDAJvtj8LXOQ8cqadKGvzmPhwrqeXdNBWqROI9xqVSmvBSSMiLOe/c4/TU1guM4VsGrU
         UpmfABx7deXbwJTb2zWO2xZBOOtIbrAxMnSoAmCVXJFifEojMhk4z3DkHDl5viF3TXlc
         25ru3o2+3mbsYhJ14bh5bKb73H7GaWFVFoXX5rQNa3w4efE70LKy/zbvZrym/YaG0c5f
         jx9QqouLABs4i90Kecs3IwyulmUNL6xSkf5CFj1yXxiNmq366jaRleTZpojQno2Ls833
         Qiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785237541; x=1785842341;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/fNd2vS4oPJ9o8eQmr9a5wVsI0gNjkKY4kjgjH6Yoc8=;
        b=bAQGamJXBMESLNwUvvh0WtyT5YQibddg5q22BGRhIFduoMst25T8B4MsikaXFsWAqY
         DTY0G3EX3S73DFR9csd0RNjLJlKrUDn1anmo99dygdu35vuM9EhlM5Jw6mgs62Cs5KQW
         qoEuGv9f4VQQBmiWSBvqZG9mxtA99KZirLjEGIW5Jf5lb+nMfChCVsNmWniAZWXInA6F
         sC9wv4ekLS8VwIMqNSKKTPy9L7EI9QIXpV4CO2qqvadnmz5kDu7vbPui7+nCIZ2eBzMX
         rwmnRmTy7shBjd+XCUdbZuUwmNnxEx1HR2MrQHgpVee+qe5a3vn7yKoM+/dQxZ4bBe7v
         aV7g==
X-Forwarded-Encrypted: i=1; AHgh+Rq/m8CMcwyAA5kfPbxSETPQYC/RJsx1z2AIdQyYHSx9pNZBgMAt8sigoTiDPlfxNdjm7tlyoJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8j+aGgrzGhCzf1lCo2xvQE2g6WegPO7Mh6CW/N3omqq6OAZk
	byZ6cMBeXy/zjRZneEatAeZR4a55oNFBmMEMi2JohdkO2VgdWTYE4R9s9oiE7dsdxr0fMk0gOdy
	HIAZeNO6p5XrHR6NnlsJuJizaadDDBRCwBCc+aFqUmvacKZiVp1QL9hXdAw==
X-Gm-Gg: AR+sD11ejzFp3fR6HIxcUmScN1lbJ/+teSZ18RM4aIsUWkc7aQ1Upuq8zcu9TLsaUKi
	H6l5K/uftsiSepM7dtdsBETAPnDQZGxxHuMITlPpmAsv8mQBJC+AUuNhhcYJ7GEy/CdU8vpdmnV
	ZlVYrypTZyHIY17TcjtpEhz0exVVxSpnHJ69P2BFrlTv9hwlhSXjWe2b9GO4JEL3Ty68HkWy2VE
	pmK+03/PaSgqtbmlpSseBExWMSvhv5Z1MEgPkO7g1yHcgHhrIqQ31SnDsFQGsek6qIb7PEh/MJj
	eMqEPqU1pZgeyEjEMjxiSxkchvXARtaB1/2fAsdcMAdk1lsK7Y+sCjAOE5KjppEmCNNreKpQ9sV
	oqrtzLbJZikBeSMw219cl9dD356IF8Flf05NQZYxVtwtypRpEL3jEHIb5UUo1aPLWwPqi2NGfiV
	u3/g==
X-Received: by 2002:a05:6000:2dc4:b0:47d:ed1d:e0e6 with SMTP id ffacd0b85a97d-47fb1f2a08dmr2304733f8f.55.1785237541432;
        Tue, 28 Jul 2026 04:19:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc4:b0:47d:ed1d:e0e6 with SMTP id ffacd0b85a97d-47fb1f2a08dmr2304674f8f.55.1785237540945;
        Tue, 28 Jul 2026 04:19:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5d9sm55613162f8f.5.2026.07.28.04.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 04:19:00 -0700 (PDT)
Message-ID: <1ee51bd7-3667-4184-b018-8a8cf29512c0@redhat.com>
Date: Tue, 28 Jul 2026 13:18:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/3] ptp: Add driver for R-Car Gen4
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260721132936.1331318-1-niklas.soderlund+renesas@ragnatech.se>
 <20260721132936.1331318-3-niklas.soderlund+renesas@ragnatech.se>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260721132936.1331318-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/26 3:29 PM, Niklas Söderlund wrote:
> +static int ptp_rcar_gen4_probe(struct platform_device *pdev)
> +{
> +	struct ptp_rcar_gen4_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	unsigned long rate;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	rate = clk_get_rate(priv->clk);
> +	if (!rate)
> +		return -ENODEV;
> +
> +	spin_lock_init(&priv->lock);
> +
> +	priv->info = ptp_rcar_gen4_info;
> +
> +	/* Default timer increment in ns.
> +	 * bit[31:27] - integer
> +	 * bit[26:0]  - decimal
> +	 * increment[ns] = perid[ns] * 2^27 => (1ns * 2^27) / rate[hz]
> +	 */
> +
> +	priv->default_addend = div_s64(1000000000LL << 27, rate);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

Both sashikos agrees pm_runtime_resume_and_get() should be used instead.
This was already raised in v4, with no reply.

/P


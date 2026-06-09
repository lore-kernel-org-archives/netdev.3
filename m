Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17134E762
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033520; cv=none; b=qkn3btx2PHrPp2jh2STBIDNwIh779cSvM1NFnKnlReA1gFm25QNa4S4THvUmS2pZ6bwu9rrth513QzwRux/3OxHxLmUzMZ6zPgZLKAdnxlI+VtFlQ5vQysdctqFXLpqm1OXcF0LMtBw/p0pP4nddAyOvHNVOetfvgIEYvJ2nzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033520; c=relaxed/simple;
	bh=siQdt2hkhW3iAMO5kNOKMav5d04Hqm+XiTImGFfTjnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELmxJk97/6JR7RG+JBHz6xwcN0hOxYmcEM4FB2FkvU0/F7EgC1vqyMnu6jPfWfcG6ZW9or/wO/9iQu21OlO7mQqc4UUxuouDYPqvXeSHr9B/UXM7+Ac4/JKfYklu28FqTxea7+KcJSNhbEDo89CZ21P4FCukwarq03id8gcSe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=QmZriRxT; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="QmZriRxT"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-441b5b4af7aso1324419fac.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1781033518; x=1781638318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SB0hkJoV0gPF+mcJ/isTFdgNlIuPqjaVKGVPd+vcG44=;
        b=QmZriRxT3/aOV4I7QK7srMxpTS+gOqS84p76nY/earcSBKTPoXzB/ZkbziD4DQs6cv
         Z013rNBJ+GmCiYIv+51PGtmcaNbQT05zn5Qfx21/ibT9NIh5+pD6fP/rc9+kInOC6e8S
         +CmmRj93evzLK2z5+LKwrNGP8qoFovQ1bX1dPGmLqDUD8mKhIdaiYd5Fgv2vD+izVt/x
         IIAjOAjMDKQHLNM6p1+AU2DYqhAba9+M1YPf1vAuqr85PXi7cjF5T/sUPqJV6IvGrBFw
         w0QD4b9QGLYmdwM3qg1vw6E/+2o3UXNll+nJVTowAOgkmof2Y8phEB+dOnQHBZ/lHDLG
         5Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033518; x=1781638318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB0hkJoV0gPF+mcJ/isTFdgNlIuPqjaVKGVPd+vcG44=;
        b=EtHmYwUX4xs1kP3Ik6p/wIZMHlXGQlG42RWj7tjUliTWc3aiNSWZ4S0XvJ8gK7/IEn
         n/Jy+Thb9dCXRKZYpKL6wQeBMMAY6hsPvTpBk23sH70niorQIqQWjZrMyK+XFUKKHMzU
         AaAkZe+upszUGTOQ1epeDo0Xnk2elMESo6EqDf8ZKuFZbYvQblIXuvyVe/znWpUfQ4ze
         4s7+HfEWrQnbg7dUBCSIrADajepkWzzUOfaWgItqJlbeUiJDXV7LMsUFa8NUZJ6HSGYm
         LaYjV6xUjvIkcQF9xdeMyOhUrCZg+h/2+x4yvFqy/XPbSYulVqThtn1IqK5EWEOIdGpN
         O4Tw==
X-Forwarded-Encrypted: i=1; AFNElJ+MPT53cleNKLreqag7LlXO5GIIA7pwdjcM9eODCzul+8WOBzqnI8+hTu5zPoDit8fSr5uX3BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4rD2oJ+4Dl1GHuzV3wYaUdDcKefOHoSOabH1xF5BwmFzc6Mzl
	snzamo7exaEKVzMFnFI+XYrs7doecccckpxoBV7VTZFuKN/PhZqgqaZ64O/3CZ+G/i8=
X-Gm-Gg: Acq92OFhCroGILoXNfejcz69nckCxM9fL1YyljPUSagawrzV4OTR4Koo7OmYbLMfTse
	yGzN0j3ZOVp97KhmCTrj3WckNL+sE9lrqbUzRbMrUoevLFTtglMsUdOP/MKzFxO0xh+UUBgG8AU
	F1/XNDubXu1UZV4g0YrU6SCFmdgh7s+5ioTbyeNPzKiOQYS/7UeSHpfUEQCs0bpypCMI363v+pT
	5VIXj6GCMPXvvjRf40RBCZN5t2XRbaTPuQvVAklDfa2LDxxbcFsmyOF1X/D6vUudvdVrITUW2cW
	NF8uak/DiQOs5dhfEDUm1FXFT5a+gxNeFzF6ST9SRHpOsap/dkD7G+RVlhjbq+xdvnmbIShQ3Cu
	BM48gJ7G3/6nOYw82aF6sFxsZXrlN61xaCw6Rs5xhL/VilkWS4/hJ59J+qKQ8H+TAo+SKIVjv9g
	dg9wBiX8iiGbD2UBvEdAMYrIwKljaHMB27lw==
X-Received: by 2002:a05:6808:2448:b0:467:eccb:b788 with SMTP id 5614622812f47-4868dddb842mr13686943b6e.9.1781033517995;
        Tue, 09 Jun 2026 12:31:57 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b32f372sm16507092b6e.0.2026.06.09.12.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 12:31:57 -0700 (PDT)
Message-ID: <6e289973-53c7-4008-baff-d7f31edf6910@riscstar.com>
Date: Tue, 9 Jun 2026 14:31:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/14] net: pcs: pcs-xpcs-regmap: support XPCS
 memory-mapped MDIO bus via regmap
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rmk+kernel@armlinux.org.uk, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com,
 a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, chenhuacai@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com,
 inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com,
 livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-4-elder@riscstar.com>
 <566af63b-05a9-43f8-94e9-19af737c848a@bootlin.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <566af63b-05a9-43f8-94e9-19af737c848a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/26 10:35 AM, Maxime Chevallier wrote:
>> +					  const struct xpcs_regmap_config *config)
>> +{
>> +	static atomic_t id = ATOMIC_INIT(-1);
>> +	struct dw_xpcs_regmap *pxpcs;
>> +	struct dw_xpcs *xpcs;
>> +	int ret;
>> +
>> +	pxpcs = devm_kzalloc(dev, sizeof(*pxpcs), GFP_KERNEL);
>> +	if (!pxpcs)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pxpcs->dev = dev;
>> +	pxpcs->regmap = config->regmap;
>> +	pxpcs->reg_indir = config->reg_indir;
> Looking at the overall series, is there any reason for this flag ?
> 
> Looks like the reg_indir=false path isn't used at all in this series.
> 
> Maybe just drop it and let anyone add it back should the need arise ?

You're right that it's always true (in this one case it's used).

I think it's fine to get rid of the reg_indir flag, and that
will simplify a lot of things.  It eliminates the need for the
xpcs_regmap_config structure (just register with regmap pointer
instead).

The "pcs-xpcs-regmap.h" header could be removed too if we declared
devm_xpcs_regmap_register() in "drivers/net/pcs/pcs-xpcs.h".  (I
won't do this unless you or someone else suggests it though.)

I will rearrange the code to support only the indirect access
method for this code.

					-Alex

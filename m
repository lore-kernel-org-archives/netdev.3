Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800735;
	b=ZdP/yfB5j2tG674uik9NlKl9lWTtCKMuQdjYcqTd3hgs5VDS227tfM+uUkBCjzpxNWC6
	 IOFj+Heu40ELgUrZtNGcdmnyaHwtUx4eFUwV3yzaPB4FWnaCnTwv2ZvZznzji8ApdpjHD
	 gHrTSMSYBNhxK7zlAaP4vTkayDKDabaXRwq/GY3ePHxixT8fziqezi+Y6jgebNcsQB5gW
	 kDyeVWAsmWBixZkOMg/0BjSttUHPEg7pTbtRUztSpUBtw5YcuToA3bHEyIDfZavY5WdsN
	 iz3xI8JyWPjam5c5NmfLSq6bT7inkqObNSU/vBlmOcuTO1ACCQII4Qubq3bbj1V2bWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800735;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=o4EIHpxl57I6a94RuHg0e1sZQ5iF0hUORfBXfBn7tP4=;
	b=P8CBmGbVQqYFN5EwVHViq+bAen/aZp07Rz30ixhCzBLOZOfNbiMy9xc5zzNeT8eOIFid
	 gfbK36cPGX0CLDIUI42fJU/7spE9lEg0cV2aRei+YkuQaxPZW1Ei3JlvakmJILeT/f+Fp
	 gSTYhhZvP67LH9DllwvQnC6P1UiYgWMwCv/b+W6llCO5bMHcmVw4FmA3ivS0PBXnNA14S
	 JYDDF+owdgjQ5Zkjhgat5zsKCczKotn+YYTUB+R9AkB0iw5aP6tZ1kAueNFsj5qSbdDVy
	 CSa/xWIq4FinGHIgg35UzaRdvRrCbKLWIe7Ag6Qvlk8xX4Wz58A5I0qPR3SogW1HrNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D8606D80C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B28D8606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso893511a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800733; cv=none;
        d=google.com; s=arc-20260327;
        b=LBUXXdd37az2J3atc2GpeeWj1nu4U3RPEG5gHWXIxiTJXHsWkGYdq58wvlkI9WehpC
         Et++SmYCVjo6wDpgGNqBDa12i+OuusfRq2iqWtGHzx+qX4hMcJ6D7KSSouqFK1PiE25o
         K3Q+i0g7B9G6AWb7PTliG7Yi9XiTtL1dVOAZKEpGbFl5OyfP+oI3d4mrp9Wefba5Ppg2
         zkf0ArYY85Z/s1sPZIfoeiolrt2DjVDStKXKdoDzNzjOaovHFTkY7yC3Q3035FUqYxy+
         mOGHXH+WFp/IffBJCK5adWbaXgOuCidMqdMx1APl02G4PfuetFZwJ2LWRMHzHdo2yYDE
         cHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=o4EIHpxl57I6a94RuHg0e1sZQ5iF0hUORfBXfBn7tP4=;
        fh=6xcr8MPMOfRhtmWf391bS+ua7NId2YVSSJB1zqCoGKc=;
        b=EzmveQUnjVfrcgeaWGGdOJ/2IfKisjdBrglEHGY2ENISQlDAhfRsrrcUjGRirs41lA
         RF7e7bdJ++o2S/A+1Z9CCRAzChZVNklYZ7rRPeI+g/qrbb+f0S8jhuGnX/nmiiV9ViAd
         MvwrdpAoQXNjT7CsgQXsKKUvud9lAg3S+lwyFEGIA6vTNn7/COcQKFdWYoIyDvGWodIv
         u7DpK9Uv1EKuT5sD6lOdK6WWMl1t3fvQ10dHDy8WnduK1VCUp+JGCDZwvHm//nAzgKQn
         huEtvSJdn7SQ72dACO55T1+5l4+3vLqLeTLItEApqKEmqlcXsY1r6rTgkONUY+UhXN15
         PKBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800733; x=1794405533;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o4EIHpxl57I6a94RuHg0e1sZQ5iF0hUORfBXfBn7tP4=;
        b=dXfE/G8O1hS2Hli69rA3t1BnBKJf5pTLOJPJT9waviuIym2HtNABkLJ1Y2fyncRpV7
         Rkff/NdCN0mIL491Mjz2d2pGVHKLBA1T27p9Ql+ZXUo0VrxYqTTlH0zjg3O6VpHSw9mB
         GQYHOSLVVzQXFSzIV1jpogG2ANRKy/KAN2LlRAHZBY1PGAJT+hcZbYxiMfr1kPfSfkeC
         7aH1qXdmmMpCOCoKKo82o3nAp7FlaoB9URiw8uf6QlZpjemXykaNhfJQvzwwsz7uUGUi
         8FnVNh1VCxrFWU73VCLMORLKo6j4/svRuwm+nez5D0KYOXjMhtoQ/R5HnMQlt/wOM6Qd
         wD3A==
X-Gm-Message-State: APuU4Z+4v/gSDqnAKAtC3C7405H//6e3R8h7DkE3iASQBcJjQsbAMNGx
	2QdBmj36s6P0hInahr9GUufLz8MFOTmM2dGMeSYG3Nw2vjbt4ge3qW51P4zdx42IvLZirGSQXP/
	ofEv0TwpMOMvbXICC+jZ4ROVQYM05bNJpcGX95mD2jg==
X-Gm-Gg: AYBFou0u6T+OgixQ7nlTQrP5PUAam/lYqRHVPyIFRmjSgY2lxOVUP9q6hlZ69RjcK7e
	5WVy4FhC1SevlFixzGicnhQTaM5MQRozgCgvw6ajQXVnGjU7FnbV/MOexstZLL/5QFlXs+tzDKn
	amLCW737MIL/ohtI/5fe6Q7P65E6l3tML54qyWhGTvoHcB2720sdqFzLaMLZgaecSiF6VYwqyD6
	VY/1yD2nmaAkF2YbFUD3+WfKeOeZkKSG+/jS0swTcEnel1Va0Qc4ElsoJXzPIu3y5ShTIu9K/jh
	iWU3J2AwcB8vkvcqEQtK3PAN5ZwYfa2p0QWkV4xGdzudGyMWQB95IB/HUQZibyXIWL6JZcbtpnt
	/hTDzHMHj2z8PI0TaBx4cddcz9Nja8Vijdv9+
X-Received: by 2002:a05:6402:10c4:b0:6b1:d439:5c5 with SMTP id
 4fb4d7f45d1cf-6b4d3374024mr8489250a12.3.1793800733137; Wed, 04 Nov 2026
 05:58:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020190319.884375-4-opensource@grische.xyz> <179279532482.3134.8732796861806998047@kernel.org>
In-Reply-To: <179279532482.3134.8732796861806998047@kernel.org>
From: opensource@grische.xyz
Date: Wed, 4 Nov 2026 14:58:25 +0100
X-Gm-Features: AclHuK_IvwAzwzvaVvW3vcX9pBmkxBHmo3ddDOqECYjDXhAMhYt-2sOn-aUE7ys
Message-ID: <CALsH2cwoB3P5Td3SgZ7ARTcGRLhCANSDU9dXake6ty1XAf38Tw@mail.gmail.com>
Subject: Re: [PATCH net 3/3] net: stmmac: dwmac1000: stop hardware from
 dropping checksum-error packets
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, o.rempel@pengutronix.de, 
	stable@vger.kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, aaro.koskinen@nokia.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does this work on dwmac1000 cores that use normal descriptors?

No, this only works on enhanced descriptors.

> Would it make sense to set DT only when enhanced descriptors are in use,
> or to make ndesc_get_rx_status() report csum_none for checksum errors?

v2 will set DT only with enhanced descriptors.

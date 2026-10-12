Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3581478E20
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814255; cv=none; b=nAEqTa6glTuJGJPrHWuIBhoS3Amo9Ib/if7tQdY5ML9S2HaaHlTfFV6CumNQofK7ZFztAYIzyVnqRwhQmNDja/hrMOa4SfsGzQcPu1+6/HIatWWwd5fpJdSkFxzdDe5z+VJWU9tPTlV2WJYBOR3OImk31nsAxmBJRb2VRSb3qBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814255; c=relaxed/simple;
	bh=RzWtGxRI7enkyFHgOOKeEKGzebQirNlDhOqQkcVTU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E91zFrXVERuxi7mYZMtAA389FvRnHarAkWMn3cidUVqocOmUlinQiDZ53QGMxaLrSmITyKYYnplCp2BXV0PNYC9f2ks1ucH2k/BSBFEBf5+veCgbvOBf3QuJcjzcmtiWcIYm5j2d8utzcBL301K0HJKPFCTJ5+/PED4uymAOB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=KuJxVbeW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="KuJxVbeW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499dd4900dfso1591095e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1791814252; x=1792419052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BgJmGRDGYBFo9MgRXfSxesRkMyo6aaxaTRmpaShbz20=;
        b=KuJxVbeWEudzPHzLn3sgzEHZcYfgT7tRXfnjwc2C94oyi97asWZs+OGlqA6uYBS9vV
         vetWHE6CD1bKQ0Y/vhUKRdMMDmBfFBDLil/kjLwm4PkcF2IZSxBGF550rx7J3KHD8o3z
         +p6G7VkBEC0oo2NPfG2ZJ7kkSAJzpNL7v/yCipuNHtLl2VRoeqHVIrmfp/Wh1C/oY+eT
         bbzOggJas+XNok3+OOpRU0o92odpaL4N3EoSAB9yEDczV1sSyk+243lDi+ekaiEuv5Vr
         GXokRyFDVqxF8s1oPCWH7UfqllVXmrc3kjAZihegi9zVH5uJ8esy5pj1qFcE4goG4Iiw
         WemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814252; x=1792419052;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BgJmGRDGYBFo9MgRXfSxesRkMyo6aaxaTRmpaShbz20=;
        b=xccw+ogxtEEQaBPFKW62W9oKVat3CSaJE5vHW9K7MmsTCDnSceosbw4v9+MkOV1hen
         6IDCo3TC+9UgyXjmuQ9s6En+ujOBKDo2qWs6IfsZNCG03rXHyqwAbVG5lDbrodHqGhHh
         yDTvO5FhV7mIETJ2EKo1DVKF6K6S+IKLrUrn4DKL7QHuaw2lzDrJyQ1pwIJdgYRIEhHY
         vh7jKosPT35ZlkBqjEyDDlHhIXL9hDUyj2da99F7CVsUNkr4iZRYR//M9E1u7qU7WZt/
         eA0MjUNuHUiHZCr1d1U/vZRg7ySEu0IFuo+t0HSqkVmNRTGAyGnV/TmHD2eTwE91V/py
         OF7Q==
X-Forwarded-Encrypted: i=1; AKwUvByP1Vn1/o1C0d5pBSgLHkPw9hMhnqXWPLOBb6lWmm4NXxriHZCiei+AY0I/3zeWkig20ulFuFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgb4EDIe/XXTRvefhuzyH+1VL7pEQs6my8NHiU8lbTmPwwb6Pu
	mbaVHwg9DVqzdLMo0WzDFoK2elkCkz29sSYSPIqfQ531HI3uDMGT/cPntmTiplc7UyY=
X-Gm-Gg: AYBFou3KjNENluoz0db0qW5WzLLFW8ecZzahIU8grABs1NZIupxsRk+khvXfW8v2pik
	NpBJuMcb8ByeGvVeGow5BeXIX7UJlhAaaLIoKY6xNZ6CR/lrsRH84ymK60JSQIV+yCfTkDKgU49
	jjUhScpXAWHJv4WSl8afh9LrDVIwRrhbmV3P8CwfVC6PkH/SKwhVQBbDtduN1T6/5XcLThIUwgw
	5stErum1wltS/J08oAKziCr+fnszVy9H3dJWoifa0cvr1de7kBu0i/NqXySiGLZqMBhzna5bhnK
	jI3kEfElfUBuRD1ANxhLu2IHoSUrI8GRtfDeJyP9RQxBiWBtqMw5yFFt5rM99mO+jV+G90Um7KD
	hhPypSWs3743JtlbtQcoUAQf0W7e5cdOfWyvmTiL9Yvls0WwHd32zs6Ta7yZjJ5tUEw8Uw3kRAn
	iV3IyDL7+yaHNFrKuFiPzTU+FXMW5AEq71I1Oelak+DLUo76OdlVyfPpKbaAM7xeV/xhQTNEFnI
	ecKRoIp2DOyL8LN1gC546bULN9eBaghpB+jp4UgYF+gyKqHVdQ=
X-Received: by 2002:a05:600c:1912:b0:4a0:73b:a222 with SMTP id 5b1f17b1804b1-4a18e3ee97dmr155446265e9.0.1791814252026;
        Mon, 12 Oct 2026 07:10:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf1358asm295619005e9.4.2026.10.12.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 07:10:51 -0700 (PDT)
Message-ID: <893fef96-e6a2-4cad-8100-5b2865aa7605@6wind.com>
Date: Mon, 12 Oct 2026 16:10:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in
 msgsize helpers
To: Adrian Martinez Garcia <adrimg3196@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <CACO1+RRid9tJq81weX-UHj6111gGZ_H1RMnxk66dtGZfwxoXRw@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CACO1+RRid9tJq81weX-UHj6111gGZ_H1RMnxk66dtGZfwxoXRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/10/2026 à 10:06, Adrian Martinez Garcia a écrit :
> Hi,
> 
> The xfrm_acquire_msgsize(), xfrm_polexpire_msgsize() and xfrm_expire_msgsize()
> helpers do not account for the XFRMA_IF_ID (8 B) and XFRMA_OFFLOAD_DEV
> (12 B) attributes that their sibling builders emit. The deficit of up to
> 20 B can trigger BUG_ON(err < 0) in the callers -> latent kernel panic.
> 
> This is a sibling of CVE-2026-43107 (fix 7081d46d32 only corrected the
> aevent pair; these three pairs were left unfixed).
> 
> Fixes: 7e6526404ade
> Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
> 
> I used Claude Code to help with the audit.
Please, don't use attachments.

Here is the doc about the process:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n278

Regards,
Nicolas

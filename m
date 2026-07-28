Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910E34E741
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239123; cv=none; b=tNvWdnoaE/dGO+PS6osKixFEPhoD8hPFLtq8LmvxwvKjKNOcz7khYOZySfdtBerh7FZcNAcx2zlAEcKekvIvQencNNlDod2n4fYHpxpmJsSgitOCi6WD+Bb85fA4JYqcf2K+kW1f17TQtwjMKLk427GMTeGzexY0XFNeYReWFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239123; c=relaxed/simple;
	bh=Nu0LoShW3dYQ2IRjvHB5acHklRm6VRrvCUWr6Xr9X2g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SQU575BOkZbyaMN7aCz8dbmYaR/tlNbceeaTGNmEQJTcuoL68NKIwhWeY5C2CkPro6vdrPtx+S6sXL+AFtODgQZQDS4xs2hh35w5zLXO8zA3aHkAC/VEl53HOUVjTFfCVmqNPRrrryz1EqOH1JzbuuGkCZCmkfo1ssFhb24lu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYN9izSE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYN9izSE"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ed2a00f12so47119477b3.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785239121; x=1785843921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6zSDmfd6MhieMdjBpWsLSRfKTJhiPYPRUBLdJuoiLaQ=;
        b=OYN9izSE6SfV9UARxDwDSnH6IkajiPRO9IvIxq4Vv8fArQbAYsY7vRl6MfQ+/eNcWG
         XkkIZeHdxTXB5ltYwF2vhLSY7CZar6wtIQejxZC2UmM4V7N5b69wGSjffCKwr3ek9CCw
         IZ93sUij1Qp7Z4Tjx/93Y5Lub07oNOWNycACFxyfOVF5wcZsB7ElGgeUJTbbsH7zmxyz
         9K9DvHQsfZNXI2DrrXmzHYqadB0Oj3ta1Z13oOTTbrCSm94eg43mqydH6HO3kN1ZYQgu
         bBAlwfjaamtJDSaFXdGFxxyh9ayxOlPd/d6P6sOgrR6ohCm4LqVoc3QacambPABMj2Xn
         DHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785239121; x=1785843921;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zSDmfd6MhieMdjBpWsLSRfKTJhiPYPRUBLdJuoiLaQ=;
        b=cPwzQbigiC4BxsWeECAxcA9Dje/ErtOcBmxQL9wpn0d/a3ONNVadAbXPUMrsqDtKBU
         QixGnZCPTjwffBnULt8k1zbMKw9RiliHheZfyGqY9EJ61ig1DILqg3BN1i+duzX0d3x+
         5MartbRcEOO61FDs5YgI6IIwi7bCN6J9AArvqsbrAi7N3ofOhRd9V3/HoDGk7U47m9mF
         4pEncQJLYq0KnSfWgxqGIy3E6kI8EK4GNMjVe7idBvhzmk+bi+eamKJbfBt0/Qc7i3Sf
         N1SRmE6/v56Op4NCJg1WCGh3GUH1qp8ePSqrYJqeygO5uQrS3s9Xw4BcLxTrLdp/dUzx
         hZ9A==
X-Gm-Message-State: AOJu0Yw3hcMBfp623iz9LZxirzwAJ0khHLw9mZ3gKWBXVg9Pg+0+lqpx
	HbC88vB6Q/wWsJ97RcFmjf+a/Bp3V2L8z9O0Fch92hiltjadzhQDC5bF
X-Gm-Gg: AR+sD11VvckfNp3A+uSnDgcoQwA/kZgU8utheIo+0NyqlsQAar7DDKL0MmmZBwaaN2E
	Lni4uO8zj/X6aukYbIZzeOkrjrWXTbKSgwVGNIjcIYonOgukUZQMYaQgkArW4CTlem7ksSVv+/q
	NvAvfoX5BQpRl7jlwnBgDgt6E7BcZ57MxbEGIZooEmccPUTYrac5MhwJ+/7CqAFOTYtyFhsIguZ
	1cIlujRNYYWagEct68mDV5O1GjjSlmzQlOLnqWmH74XLcDG26OfqFugics/hezhh8TD2JDtnVba
	PFQbE9S2Rvx1t1nL450Ft8jhYbb4WcIcYbp36JhufRr0KPzwa/awOhunLyH9eEwwkd5khRm7Zai
	kpl2a/yrXFBNhosKpUet8yZzARdXu/HLHgCm4YdAHc6ZkqlMpSTOop+mzHHrq0BILyBt5oCzYnA
	LXA0uTN+DJslHxw8Sk80mENZZaBgPQArDKPrd0iCDtNqnKP7oOMX++lBPFrmxBjNAWOX/wd2jA7
	ZvJvk+/3hkwkRqxb9ikVY0yu74dogkhYZiV
X-Received: by 2002:a05:690c:7303:b0:81d:42e6:6a82 with SMTP id 00721157ae682-81f991ef649mr8445727b3.25.1785239120896;
        Tue, 28 Jul 2026 04:45:20 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6579f462sm45133837b3.11.2026.07.28.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 04:45:20 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:45:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 mohsin.bashr@gmail.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1fb6542e5@gmail.com>
In-Reply-To: <20260727165109.439c0f74@kernel.org>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
 <20260726202902.760552-2-willemdebruijn.kernel@gmail.com>
 <20260727165109.439c0f74@kernel.org>
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: add hardware pacing offload
 support to rings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 26 Jul 2026 16:28:45 -0400 Willem de Bruijn wrote:
> > Add two ethtool rings operations:
> > 
> > - get pacing offload horizon: active and max
> > - set pacing offload horizon: active
> 
> Could you spare a few words on the fact that we already
> have IFLA_MAX_PACING_OFFLOAD_HORIZON?
> Since it's already there and patch 3 only adds device level
> configuration (not per ring), sticking to rtnl seems tempting?

Good point. I'll convert to that.

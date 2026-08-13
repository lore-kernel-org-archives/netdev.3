Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA129BD8C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588135; cv=none; b=uhZ/cR+i+bJs2Ga6fNBeTcWg3XHijIVE+Xs/dgvR0RkjLPJyUDktQwYFtwkk/DyQLVb/D1TQTTQ+VKErecBMaenqR4l2sUfl3oafi9/tLSqPxeMrwjDBt/AxrDGG8T0znaroms7M6EKg+pLFkOLnFatqitFXhR84k/1JksWRdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588135; c=relaxed/simple;
	bh=2YHIkFSHjfogwm5MQi28k5ffHuwIyd+Q4x42ihCHNhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNLR5QBp/YbnGjb+EUdQBwRF/782f/J44FP9SJN5UQ0r/P70d9kZhhI2HfvorWgaqo67z3hsQUwt8YUXVRpGjdbkAdo9dFoBNX25xeXWtBk9DTHzmiGgzhD3JcR4DqANY9rXbHdGP0up7HXZbm08wIvFSnz4V7x0Sf1//5TYnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1dGph8Y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1dGph8Y"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d032846c95so19385335ad.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786588133; x=1787192933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFUhdg34WYBiblmC3cyUKC57CljWkVyBVLDpxu/qTdQ=;
        b=F1dGph8YOMCQ4Ty5shx4d1yTSFbXENIp/kZtyVLvIqll9KOQAmqfQTgkDHeaX4Ieck
         k2e8vQITKBiyaiZ3Z6UkGuWfHTUUR6/lLBej1OU9ePrb8bT0gyKahlFhawKOvPzf+TJG
         M0NuhAlJ/+L1SfopE2SN6T/B1t5v8wv53aPwxhkVnkSgPvX0BkrGyTSeODbxAJjtOpDl
         X7D5Hldkjh75Mcf1wisLuyDQeteq8S48w4bB09o+MTJjPY/fzkf90+hsgkqXgBpHVGq6
         rHUdf9jjkdmnn2X+UHJ1iY/aK+wQacWd78R7GDA+6SkiaaZefKOVq7PZy4FrFGXPH5E7
         MymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588133; x=1787192933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cFUhdg34WYBiblmC3cyUKC57CljWkVyBVLDpxu/qTdQ=;
        b=VBWlz6d+8Lz08qP9PZeT8r3RTcMcgEHUzdu2obkWq7oX2eF9f/Eml53WgG3XHXSmlK
         cZgvm0mJdnOHaKuytEGgVdowhKPR9vs5PDNka3kbnoBXUp4cGtE+h6zTS7Bu9CFGHAet
         0Znqlm2xqZFDAICcheCQuDUXNblMWm00UdIU5XvrwxfiT1Fa5sXIy6jxQd12Wyf/k389
         6uaTafkdgZamYyBRXYdmjmECkToCn+YMgHyOEFQDDsEiVJfFzx6gu/3waiuMeZtfsRkN
         poD3aNcx42EF1O9lZchSEjbbnGLmvDzygwWfGefRTs6jKToCXen3L5mmzEP09KyQ+e9R
         UQ2w==
X-Forwarded-Encrypted: i=1; AHgh+Rqb/9NlDplHtevLpRW+gGdkmQKUxYJoJq+RwNOlebDOODWeClpGKWUMOcPEG36q4bgnwfpT4Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdB1SKrJKgA2/pPtFpz/stEo0aaoKQxD5AFhqd6z7ZA9y0QKj
	KfY9TDhRrGh3gB28Ezsl340mNnMsKBDIaHb0dxcKJByWPgPrxD9NbXYkJKz+M2rV
X-Gm-Gg: AR+sD12BVe7Pw5MvYQHwVO6GR8n8LS8i7gOyxFobP0qb44jKasUM2IKWXR6YMl2IXHz
	b/iXletLxU7XddC3sCoQXGuQ44SsaNpN9GQoCBvgD0/hWYrzlIAsmK4tCugl2sCsvYjzxv9FfkS
	ZEUZbFUFlgy+Nwcz2AsH44yWSgvgbilQY1Zapbxs2FNYisBd6WlAR5rrNuLuwfGbcLLe5TgYjhD
	mb5YsTLE7P72Ak7/LTmmXs+Mk2YkUaDHK9fPiSXxNxwVWVV0rXn5Yg+5Uz+BpqB2ULuSrVcvv83
	oHH4wbEyDtoWbZLWULc7M3KVkNUMVk7YkecKYRHv0A3bBkND4rT0lrn7eJ+MTLroltmC7JTesY3
	5U0owRXHOiOZAw7v1I6rXDexUVyea31zHjExys3dILqLs3+OnwyYpJhId29Mepcwdb144xMonmA
	+n8H4YQhHDLGas0XFoTLwLji3vTUxCZymglYBvM5Iw8BmFV2c9k7r/eto=
X-Received: by 2002:a17:902:d551:b0:2d3:2e86:647a with SMTP id d9443c01a7336-2d37d5380ebmr30358795ad.5.1786588133158;
        Wed, 12 Aug 2026 19:28:53 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c225c38sm2920215ad.22.2026.08.12.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:28:52 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:28:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net] bonding: fix u32 overflow in compute_gap()
Message-ID: <an0r33hYV6sJlfJX@fedora>
References: <20260810-bond_overflow-v1-1-c9ff29d76770@kylinos.cn>
 <20260812180111.76d0cece@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812180111.76d0cece@kernel.org>

On Wed, Aug 12, 2026 at 06:01:11PM -0700, Jakub Kicinski wrote:
> On Mon, 10 Aug 2026 10:38:23 +0800 Hangbin Liu wrote:
> > From: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > compute_gap() computes the gap between a slave's link capacity and its
> > current TLB load. Both terms use u32 left-shifts that overflow on modern
> > hardware:
> > 
> >   - slave->speed is u32 in Mbps; speed << 20 overflows at > 4Gbps.
> >   - SLAVE_TLB_INFO(slave).load is u32; load << 3 overflows at > 512M.
> > 
> > Cast both operands to s64 before shifting so the arithmetic is performed
> > in 64 bits. Also update the comment to make it more clear.
> 
> Could you clarify the impact in the commit message a little more
> explicitly? If the links are the same speed -- does this fix still
> matter?

No, with same high speed NICs. If one save has lower load, e.g. 3Gbit/s,
Another has higher load, e.g. 5Gbit/s. The higher load will overflow and
became a smaller value.

> 
> AI over here says:
> 
>   The fix is incomplete for very high loads: each hash bucket’s u32 tx_bytes
>   already wraps above roughly 3.44 Gbit/s sustained over the 10-second interval,
>   and aggregate u32 load wraps above roughly 34.4 Gbit/s.
> 
> While these are not exactly the same lines of code - I think it'd be
> worth to address them all in one series. 

Ah, yes. The load is already overflow here. Not in the gap compute.
So the gap compute fix is mainly for different speed NICs.

> 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> Oh, you work at KylinOS now 

Right.

> -- please clearly state in the commit
> message if the issue was seen in real life or AI-detected.

OK, I will.

Thanks
Hangbin

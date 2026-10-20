Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485502;
	b=iFSDEWQ4uI/563utcMMfyAb0yYG0zMcosVFGbg4FeP5jwd0m1NqA+WRSpsl1RXMF48We
	 VnkTlZrHnz7DGq+SV0/lK7jJOTZmr64k8WNf1PGTpXcXKV+xJ3CPXvHIy1vtzTWcu6XKi
	 69afM4qJ6cgOfZlg48kBQ4VLQQFoLf2ZZTsXmo3kYgp4yj7k+6mo9UyZpnkejy2sw7Szq
	 vjLZEkgzaGKjbrS8o4wMMEsNqYMoul9RRDbJlNRnSv5vacnzIMG9EmYxpYWLkl+YmQEQ2
	 Vmm1Lzz166kVbG+ck+6iIAkPKKMW57lHh73zMcrZcDOS3o4RSsvzo/+iH5+v+Y/MK4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=3a978/iWfjMwwVZvL1+s6j16eVM0+TnP/Uzgo/nVM4c=;
	b=es5wusR/ih+bBnHcIBFobjUbBe9FTFuaQkZ7byGX5wSsVKVZ56OtfK5mvYEn8cHe/Wwc
	 5xVNDz2wsERVXQUTpIIGSo8Fc/bmmTz8AmBMMxxkG1GEoPJUrNA9xI4WA0+J0dzcr66qZ
	 QW2SD1mapCnlU63yFDzdqI4pj4zQJ3lJCQf10PRY8ZCBGfO6f0MWyAHLIE0rdsL62DCk7
	 HNxCdYKaV5Urr2AotFZikOZflnzxaQ8lZnpbjBFxjCskIA1pVRhvNPBR0Pg8twoIITaro
	 CZrK/a0ISB3NWAUQMKq4JvreIwwxtGOaCHlLLlpxbjvV074iZ7gFteiHY97Dzc0fQ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=riscstar.com;
	spf=pass smtp.mailfrom=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=xAVz2vO7;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF1606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81BF1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=xAVz2vO7
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so18626405e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792485500; x=1793090300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3a978/iWfjMwwVZvL1+s6j16eVM0+TnP/Uzgo/nVM4c=;
        b=xAVz2vO7Ltvqn9wr2sOmxRzszaervw2B63r90/KR1p5HBng3lMJO13PjroTle5N8sG
         yfj1SI0dEBp+cDVm2cI+7u7QwyfYohmqRC7otCtd4/Pl1NKxn2ONl1CmNErylD2j8sEy
         b+yQnCCBQu0XcNDqd7KeXi2oeJsbCWreqLKRS5CeZeERqWBOL1YVbRZVut4sEOi1fhOo
         +NLV+aO3bYTwW4oAuY4W1mtUG7RZ/ivkx4YsJM7GMPfTMCG35nZcbbIFlsonl06EjlOQ
         ILj6Y1AWfjcdghOzctqkG+LL2i6LfIGHJhAuxFMapFNlLEzsI0OI+edoMEn2Iqvrn+XS
         PrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792485500; x=1793090300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3a978/iWfjMwwVZvL1+s6j16eVM0+TnP/Uzgo/nVM4c=;
        b=CO/L48HIfBM5uWdDtomnvrrz3eKut6mlc/1jXpO7tBFfNAtFGFi1nLOYbpFUNH7IUS
         USkoWUS01YZuG0veChhs9dKtodRRGjQkw3RGH56tGn+56ulXi5yjTnl1m5EHy5Ppdnxr
         bKQj/2g/p2ts1l04AvDzpCFEusF7xHTXCltzkaHT3OmrYO9ZxWCoPAppVA0wZoB/ThY0
         CB/MTRWXx7k4m/f8ewC4LJuYoepZ0iZr8vbzG4qSQt7r4gvKBL1UiPEKuSvb0emiZibo
         VevnydgIxM00fD1/N3Ch1eJBbIjcw0gFFHdzRY9xkzLVMtbDnsWxOKMMvwiiNdphfeWh
         X8mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaDAOnjMbNga9WjGKttWFbK4S9FBOGm7mc++BjqWeSO0zBx+m0OD/SNRjB+kSoDQx2QTAdmWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgSbQ8vVPtHVOEb0oLWe/5VtcPYvqfmsZMHedPJFOrtzCMJiDf
	Nvmxz/AwU2ied9ndnOL0HZUaXdF5syfRS3Rwq6v/TwSqqe77jaXBorJA69DOEG37oHI=
X-Gm-Gg: AYBFou2xZHaNlwIk0Obq7nCBliaRcfI11YG4/+vrzfoJiFtq6T7dQ2aKB42OijUDKlw
	JDCJVfEEpLPI1aNd3lWwzvxqwqlW1CQl3MEzLPqXlEKMXpnl6fGXFaWYEVNZiuEN2v+iMTDwSgU
	OmvT5uEjBYF2vPJXZAHBegnBU4yPdZrknn+F3OWWFnOiAJQPEptUK0vMt6v3jJI2XiwlCN6JnLc
	0Z6VTkdKE8cLaDUcw+tRm3eAjZvbF0J+5vgVwzGxkKQd65J/Ja2mJ+ZIhplw23JWtHqpSLk3W7l
	/L9ySpqnZBuodOpALDmWkiXKBiPLm9aAIqcb5B38anXR7JP8dG/HD+njCNGOa1y7ycBmYtU7o1g
	A85GYq3pkGG4K7BJqIvQoGybVCeBC4QRrSeOs4vKkbOV4oXFL+TbdTbeVZ/XS1jSiewXNWHsXTQ
	KMFwrMkn9b1gpWtpFWdmrLrkL0FuD0S2DnnlNgyqrOqgMi7MDy58cXWlWpdYha3+XzA4BAPo5qJ
	TANlt+7RMkfCcq2hlFvgmTySle5OHYRflw+00szGJmLGQe3xsM7c4wE4zKS+bxzjDGJbKtXzQKy
	u7P1VPhENwq0yBbFRPeopNgF3VT2QWH/6ZtYywfNajV0NxZ2KNMfXITxjJM=
X-Received: by 2002:a05:600c:4e11:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-4a1d75f2396mr206375345e9.8.1792485498960;
        Tue, 20 Oct 2026 01:38:18 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc8e98sm59739325e9.9.2026.10.20.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 01:38:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:38:16 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: netdev-bot+sashiko@kernel.org
Cc: elder@riscstar.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: pcs: xpcs: re-order xpcs_pre_config()
 to update after the reset
Message-ID: <atcoeLhohLkjVz-I@aspen.lan>
References: <20261014223100.304486-2-elder@riscstar.com>
 <179232845425.3135.8614802619087243641@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179232845425.3135.8614802619087243641@kernel.org>

On Sun, Oct 18, 2026 at 01:00:54PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 3 · Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] This patch adds a generic XPCS soft reset on Wangxun TXGBE
>   parts every time SGMII is configured.
> - [Medium] The patch drops the interface-change check that gated the
>   SGMII reset, while the new comment still says the reset happens on a…

I think some of the other Medium issues are closely related to dropping
the interface-change check... and that it either a mistake in my part

Definitely needs a respin:
pw-bot: cr


> - [Medium] The commit message describes a preparatory reorder that just
>   'hoist[s] the special case logic for SGMII into the parent function',…
> - [Low] The error handling in xpcs_pre_config() now behaves differently,
>   and the commit message does not mention it.


Daniel.

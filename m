Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154346;
	b=PUwzVT4XtvSBUcdhmjKykc4JyVRcItK3+jOE+ScA/gO5hVB62hqiBbC6jYFatqRYDS2L
	 0aaXOoAzU7yeVwfQqMjnPBMaLaAdEOiSD6+brQmTIiJnGiNTMjB3+SXJmuPLTc5tDrGxm
	 xF1sMhCvEl34F1jTKUbTI6UyJLgK6ISW5wDBPYRTbK1HKciO/Qut5tzkkeI+LSTu1Xv3X
	 wsk678TiHfBvZ7wWN2+2wPnYZuknmF7whjHofqPu8LAtbuodK30zNU1wmPMJnRNfCmGjG
	 v19FO34/k+BRjAUN+PO2UZPba23ECvU79CO2Yin3+C0xr4qJDsSn0XYsVwnU35vUdwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3dQexnH2CQPCd6uomqpp+F0/o0hfCHm4JSVgBUNYqmk=;
	b=m4aP/c3qsERaTsScgJZ2MhEiKDpc42yr3IPTm9BeDWxpG4EBs5d+yEhSvg8mWENqoa1f
	 4dl9XCeTtPxa7GjTxCPLgqQsH5ty2lGpDYxLz/P8u/8BnX8C4mmxZ6k3HPl0HPX17ISBb
	 7UGnbZfmI0eJBtNSfhcftyfSnAKSg7wAiUDZClakN5BzBJFPE2lT6sktP/2gV5WtjvshX
	 TWBMs+mRAox+nACC4Q5Bzfw8gFZOGcdHyvJeZyjy83bDvryx/sd1t5QT4zn+BCqiT0v52
	 dHfHfnWYIVdZuc2THJFd8q5PpgKhV3+8mpGbwMXWNcHnGAdRuafU2e5695Li/MBDXUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TlulpGDp;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0B606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 16:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2E0B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TlulpGDp
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so1275925e9.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154344; x=1794759144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dQexnH2CQPCd6uomqpp+F0/o0hfCHm4JSVgBUNYqmk=;
        b=TlulpGDp4hUigOLh/QFhZYrRXzFS2lSMyM5SgP+im+oHkRgWC5r0lNU1as3UHkxmiU
         B+ywm5Zx/cQRppvTQSarsTGDLFmne9ZNoKByO9n3tDGtdKUCWK3LYcr4ogAU1QFoGkjT
         /TH4uFEEESj9+0aHM8pDZftc9TCutMuGyULVWYmXi3Rh9Soe3I4B2P1LW5q+hS6TyJuD
         +zpH9Drcz08Xn4pYW5Qh+3RuKkXPAmKKjPU3WRiB0tEGdcleCbT1fD2ty0nJTSdEAc/y
         u4Mh+wLzyq+SBd0zIRaanDSOxT4FaIhASnxRUqlGZWpIorHIh1+V3JMkQzb2FHbylsOt
         O3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154344; x=1794759144;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dQexnH2CQPCd6uomqpp+F0/o0hfCHm4JSVgBUNYqmk=;
        b=nTRFkBBarROwl5lVMl5Y21eBTQrv6MLimmBIFpI0DOmA4om3bF/fV+o2dlqsREXSGt
         M6WhxLKuQqC5x9RHdeFEKjdigQO8bjMxtpdqRaum2vix/ecFUI28HzRoMmJhcMr4ekjt
         9v0DVjUW/6CIKeyeJPwouvG/uIUHkIwySQ0U4rauaRMKvNzvPzFeB7JxPd3GV3ol2Phn
         BHu7ry8BMiWU8oqihqrcwam+Vv/6MIJx3ZNowlHel6ulty3cmeHJYJyWe2be3vGq9v4y
         p/CFdaZuXWwcjoKvbDQ7w5s1M801ePe1TWjpEWPBsU3y0dyu14MAVfBS2HQVi5/44NEa
         NBAA==
X-Gm-Message-State: APuU4Z++ZKrXWFOSzOb4Qg4KaR45viXrvJYWG68SdZ/NXY3/IoCxJHib
	dOY1IB5IklUrY06nAQcsBEuuV9djiRt6LbZIjXvLkJbY441JLfhXG3jsqrGpcA==
X-Gm-Gg: AYBFou3GnmxcimX6VB6VUNlHC7AeKvcvuszd8g1DuF0MG08GwRZKosEgSZ7sVjc/JKz
	+JReW0t2AJP02622oktv7AnaPXJv5eYxvxOVRySArwhF5NeWlHxHGh8jXL5szW6vNP57ZfJYM6R
	mLpUJeVDHUC/hLlzhK0E6oA0yhGZCku51QJT1yB05blXFkvv3tKrQysOUHDlrU6NcgCdp0JP2Vy
	GkCqeLmDSd6JcFxJqixmnA17tiDmg5VYikAZAU/K1Tfr2TskgbPF6UL5GuHa82icdA5AJ5tpn0V
	EG4ox/V7Hx/3YxuHdZBKwSVVEBTNVrq/x7x0K2FY6G3035GgWcGWsl/bgCc8o58wdoMvWscgSRt
	bVmOkkrn7WoliPo5+1X/QmuQAur58Y9jRobk43FaBEtpYOdCPUxTN9/9V4aU6WoM80jeBjsLe4R
	CyxgxLQFw+zGO+HxfmRmvHGBYqIYADaAMMh9sNSSVj7kWjdQh90sCcSwW2EiDRkIYgliAbamFp6
	H/A1oWxyqWFoT81jJx8EpfGJfVtEKue4t/bjUe2ASJkBIAcC9ER95lopDJiPesBE+02miWeQVEn
	mo1DLPhUI+Pi617iNSmDqofDt/ZmSzQ+mmvKzlE+NDXEhAlfxQSewl8PjjQc8l6ppJHwt5yUcyA
	DPzoaA32+4QmDrmJm9yLZdq4zHva3ESBxmx2JaDCPWGoDa1cvWjPCXzYHCPhTRfBwgmk=
X-Received: by 2002:a05:600c:1d08:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4b960d9b26amr34842195e9.7.1794154343463;
        Sun, 08 Nov 2026 08:12:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb75913sm124864075e9.0.2026.11.08.08.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 08:12:22 -0800 (PST)
Message-ID: <62fcd666-ea7d-465c-87e3-9a15afd25624@gmail.com>
Date: Sun, 8 Nov 2026 17:12:21 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] sysfs: facilitate creating an empty
 directory
From: Heiner Kallweit <hkallweit1@gmail.com>
To: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
Content-Language: en-US
In-Reply-To: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.11.2026 14:44, Heiner Kallweit wrote:
> We have use cases where an empty sysfs directory is created.
> This requires an attribute list consisting of only the sentinal entry.
> It takes only to modify one check to enable creating an empty directory
> with a NULL attribute list. Use the new feature in net sysfs.
> 
> Proposal: Apply through netdev tree, w/ ACK from sysfs core.
> 
> Heiner Kallweit (2):
>   sysfs: facilitate creating an empty directory
>   net sysfs: simplify creating empty wireless directory
> 
>  fs/sysfs/group.c     | 7 ++++---
>  net/core/net-sysfs.c | 5 -----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 

Will be replaced with patch to remove the deprecated wireless directory.
--
pw-bot: cr

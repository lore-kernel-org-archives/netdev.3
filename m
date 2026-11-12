Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478107;
	b=IUHoDzASkFk57qWITmHkRDLXqRihXAJBivKjHwN6mpxTorAyVwOHGTGlqt03kL15WkUR
	 t6+OOgGIqvylthxyHgqhSYM04iRX6TGO1Xf65go+6qFDPtusEMyX/5WYL0J7+vfv5SRjK
	 okWTFTC+joPB6aZyNA8Eo5v78r0R8Ar/izoLpofnWpDkKwAVj8LV7asjQeyvrCX9X0Nem
	 c7VgYNwmwVSjL5ho3s6WufjsXDUb01SuirTAkJBnR3azBsJx8qf6wxNxWUo26R/NVt6z1
	 7k0FFARPzATwGsXqqHjRGv+2gWxY3AU5RhhOyWssGVnC0h+q6/7zgChZhCXu33Y2tuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=stpMvXIXp9iGZb1SUS24yhnAumjBKjIpChQo6LabxKg=;
	b=EswOOZySTuQBjXOWE3JFoDqDTs0sSv09bP3DTrNADd6zczXRpAKqhSTliV6/LPc+56HL
	 vtTDJZmVSJu1sCb5U7Fd3gDxj/5huPIx9WPBtldvamCEQilQArB+fT8ZOUeJg7bAybnVS
	 SadcYO5810TmbB7gJNqMk0HidhvO1dU2eU9NCJXYt04on49D9JAsYYp4jQAlqxh2QRvfq
	 qQbehzMvaGbnYQCZNefzEgDvSQig2pP46mO64ErdS6Xs4luomtDNl+GHg9ZCPy5u7Skug
	 cf0ntenQ/ea7RPYgBO66LRCiLNH075xaLrWeI0/QezJtlfr0+YPe/UKIRH9hFsmvBgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKfympfp;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F6606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197F6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKfympfp
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso28396595e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794478105; x=1795082905; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stpMvXIXp9iGZb1SUS24yhnAumjBKjIpChQo6LabxKg=;
        b=dKfympfpfKj99jgLwxm3SlAiqNp6SvPx5zNadVqEIczyZLFAaecoCR1N0SPhQM8bBP
         OOqkxIj2Vk/CbfQKf6VWDg9wB+l50tqzDsAgcjQyv2CoNQ/FcCXmxD+d9x82S4UfN9tk
         sW6T2HwghchjcRJdA93rLETtqhtouEa79jf+AAodQ6XfcFJtXet+WsPYuSb5zv8yx3pD
         r5FcRFN09b0WifkamDp3a8zvWFgzYExbccTGiSXt5dOdg/Minza2NVKuidckMhvEQku3
         b2c7U6jQPLaQUOKCuSm+wCqzEdsQR9jQp+XKIbyz0R9WPODmJc6o6GJL+Gl5xQRZjhQQ
         z0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478105; x=1795082905;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stpMvXIXp9iGZb1SUS24yhnAumjBKjIpChQo6LabxKg=;
        b=jkopIG8UQAIdMR/buYG1NL0C8uRKOY2jAJfWLD9uG4Buz06Zb4sP+EcIREEtgj3yyI
         Oyn7zTq03WAZvpnxjxVFqvPUuGWXbW/cn1mTuBM7SaekKTvXRd9hiPUH3DHrWwKgvoCK
         COghp14OlhRqF4wiPRWp9wyPrgKqM08Kf+AsugkxwE7Fvf53hcfMXnlaDWOb79LmM/ra
         u/AiT1OLCgoRSU39C8HCzDCGiNoVh4VQJArnp/eU4bVBRUk0H7hVC1yVIsGvRZZQggrQ
         Y2D+SPDSvlpi+7ZX794H8XMuLZ8HT9futZyZSvA4w0M0bMPwd/191dVaj5bGWQHNoOY5
         AgGw==
X-Forwarded-Encrypted: i=1; AL+hErHBLxwJ2oivTcXEC/kN0Oa4OwWlkFBxWTQm9RdLFGiKSKInBwp+YHf6NJeXMEm1fsNTMuMCbIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xZZAFZFv/zViRPbiahZROCVKSkxaSQ7QIawyVQqKQPKuPbmGr
	VMvU398t5Zl18vNN2a7LrGZzspYTHYCwSycDG1RxiDcRVxbUwsZRsNB0
X-Gm-Gg: AYBFou2h6vkXl5C+1W4xlLNj8YbYQhtsUL4P3YtvCr4mvZXtiTxAjlHzi4TsT5M+hj+
	OoR9KPVlX6C6F62jZlvpOXXEdZ3qxdUQsceDvM3pj0ic07dqtUFxQhMAgSaJAX4OUoO7rhiwax8
	ldKPbIJWDmjThVwp61SShUi8M8QWAOSWnXA8D8wRFFz0we+knsXBZ4yLV3fyAx1MsOg6KtNURgH
	R5HDhk6UInPkp0IgQqOCd6aDDf7M5NP7e64iX6EfDCXH2p2sHgfEaaRHO8b56zcY5ebfD3bxvuy
	spadz3/79+C1Bu7bN15UjNt2gpYrvoyv0W3oWFy6lMR4mMmsqHZREv7SoTQm1Y46jplIuJpBJ5l
	EpTrGo9GQBgNbIAdatO5Ka3fDpPUWrdYqvnjQ7tfl5M6i0/Iw+7yGdhv+OXjdd22FI1zCxeNY9p
	4ydZoVzpcSvdG2h8fmc7/g/dxQmMe4kmD5lvQR6Bezoqb+oZ80ubk0B8P3N4Aa8o5t71JJ71ypE
	cOxBJ6vuyoA2FT5FJaMmO5Ih2d4yvfW/tjmZp7HuPLBV+FJPXGX75rOrgGLg9ZZ0aGHjhRNgCNn
	aZO03MRIpz2QCdlOVPxGk7uydkZ7CGyfkptSm5Fd1GhrDO0VxNs=
X-Received: by 2002:a05:600c:4e41:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4ba0931ed76mr91630525e9.2.1794478105252;
        Thu, 12 Nov 2026 02:08:25 -0800 (PST)
Received: from smtpclient.apple ([217.111.110.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0953d26asm70701795e9.4.2026.11.12.02.08.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 02:08:24 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH ipsec 1/7] xfrm: esp6: use the current sequence number for
 the IV
From: Usman Malik <usmalik90@gmail.com>
In-Reply-To: <20260930144523.435271-3-Jeremy.Jean@oss.cyber.gouv.fr>
Date: Thu, 12 Nov 2026 11:08:14 +0100
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>,
 netdev@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <07261E5B-923A-43BE-BD55-B2AB94D02836@gmail.com>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-3-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Wed, 30 Sep 2026 14:45:18 +0000, Jeremy Jean wrote:
> When a GSO packet is split in software for IPv6 ESP,
> validate_xmit_xfrm() calls esp6_xmit() for each segment.

Tested this patch as posted (patchwork 14858682) on v7.3, no other
patch of this series applied, in a VM with two network namespaces on
a veth, plain TCP over an IPv6 rfc4106(gcm(aes)) SA with esp6_offload
loaded and no hardware offload, TSO on, 3 MB per run, 3 runs with the
veth default noqueue and 3 with a tbf qdisc per SA mode. The sender
capture was decrypted with the SA keys.

Without this patch every run reused IVs. Over a transport-mode SA 1 to
3 IV values per run in 6 runs, over a tunnel-mode SA 1 to 4 in 6 runs.
Each reuse is a packet with sequence number N and the next packet with
N + 1, as the commit message describes. With this patch, 0 in all 12
runs.

Tested-by: Usman Malik <usmanmalik@engineer.com>


Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F52420898
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356314; cv=none; b=Fg+7nsjwwrA6BkRlpp8EDW86p92DYlusNdkhuKehxhFyewfXBIpg5zdjT0nAY1Mk5/096KvnebbMBikhhM5BaWaCozIgcxv4YU9rI47qy5+bYetlEv+p0tf3qz6KiRPWJBol8WrJNulWuMWAP+BESzqf1KI95cjT7hpuWzkvYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356314; c=relaxed/simple;
	bh=nYw7CrwIsWWZ2NPPuERLElRuvwBTOJ+y+XwzJT93iaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF0He/r2vFcCHlCAxCV50CJRa3QAMBtLM6USKe/lLJUjds6hQYJabwrhuq/9Ag1OgSX2Jiy/lTJ8JwU78TQCvaATvIyjsqSrOxM3cNI8m9EaW9r9P5EkmxfH9otILILjeu7rQUJ1mXYH88watVaW3hQP1KH/w0ECml8eQv9diyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKuux+ka; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKuux+ka"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so9453055e9.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790356306; x=1790961106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zI1uNrLXO6lrfRFZprfTQ1p/tdW6w070lpBa0j3NKS8=;
        b=SKuux+kaMroUezcTyhTj78WsTeqy0PQj+fD8CumhpehUz9T1lnbrD8mw1nXpYUMiKq
         wQmm8oNVtNLMx9IU3xyfSqQaK/wleoe3wrEn5RoD2pE/FignMBL6JEC6EBSSjPwuNSlZ
         2zdz3JudS3TcuPBpDJG5AlcftbJTrWqd6sbClBc/1Cd9NMc4DPKBFsRHYfEnDjqNE+L/
         5hmc0ftVqoMhuB+U2EMwZ1OoPdoA1M5l4bR1T/iLNY7hHxAh/xmUh9bB42TxJGwyjynF
         NIyrGgSvo11wwLdlY0OJ4skHQCymXW3XMnvY3Q+bFAOj3GBh11uoRfzO4uciIipmA4VN
         k4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790356306; x=1790961106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zI1uNrLXO6lrfRFZprfTQ1p/tdW6w070lpBa0j3NKS8=;
        b=mq4zy2sQicBnfOaxvpLa4DVen1kxr9Qbxf2LiDS8uF+juWAuoiND4uCdfg8wjYM4wt
         XD/MTvmVgCF9NIaizqTU8PG0ZKPu70LG3DhDu/CODcAD1nh34qOHkSUTZUrY2hNFF70T
         yFtDXj4Y8HWi6J7vJDKKEbHKvKF89GUbPSySPG5BOv/dKuSuMSyE9bb8Qn6l8FHOxIso
         IJsWKJiLg2viLKQNCPXsvmg4gny018hktF7tBZeY5wgMTk6U4H9w8aPgYXAa51NjZd/K
         kSHpuT8DKchz76WWdk3Noa+SNpH+C0VzSR72I4N039hYUTQie7zLAk620f8RVM1+z6az
         YUcw==
X-Forwarded-Encrypted: i=1; AKwUvBwroatvvWefXJOpMdDxFgwMgZPtaCDEAH91xmqLrML6VSXfLle5LhO4mPoO1t1eyfH+KzNspKg=@vger.kernel.org
X-Gm-Message-State: AFuF++lez2V5Co2vxOW4n4jefzZUPyRzA4ZVtOdW70KBgesNgT/tC858
	DLD8JBjHaSG3Pe0l1kZz37xVQDkPyBqPD/0niP68t27H97IM6N1PTqum4bbrZIXz
X-Gm-Gg: AYBFou2FkhWy6dNZsuQFgdoo/dQx3giPRmx3SXpH8Eb2jtuaCchEhMfpHx2v5S3yJEi
	x6+sX3boPH6sNzS0f0OZnA5Xd3pQkCNrljBlg/Ul6NmbZXFAhWasBTD6tgZIJCDfjRfWHlxLWMg
	8Y1iYd28TiKIRIRdRAdujpHgL5jZYkgs6Ztqy84jzPsJ7Nz0DZZ8nllp0+Cdn6ym00xoLhqhkBL
	i11ORd2l0S1BYuRRGvYqrAH6I9AP6EkygZuSKxjm+g7NoxGr4uRy0eiyG6r9EgBQi4yRRIaryyw
	45OGysoWVMRkTRtDLHbGKu+OOUGlGIAoiFbNxepMCXFvsPQyprT0e6nCMiqa+eg7/USCUIXUIBj
	V/V7XrfNgeS7Sr2LBGdOTWGe3CZCVTDgjmKaWpqzeymGeWX2PmuTXSF4Mz9vhqoGlHTRGWiOsHl
	E6NC6TGt1AXjS5TxlUmvLrkpdm14CncJYL0op2GMUN5WrmdEdhyTbPM4ddsfY3p8y73Xt6PvLLw
	qFGGvKeoz9LdqqpjfYVcM9yfOhGXhI+OG8QqtPqu2opgTMhC87Gza1OpunZ5JsE6SjJQCXv2ozP
	Zf8/kUmBx+R78hPzN4vBvdau35Kz7uT9+kVae8fhK6JJki3LTBl52cYHoPg8QT+6XLJulBT/X6D
	LjCOBJPnPpb4+CpFS
X-Received: by 2002:a05:600c:4e93:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49fe66d1097mr122428005e9.8.1790356305537;
        Fri, 25 Sep 2026 10:11:45 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-adc6-9c01-89ae-b145-8960-cf19.310.pool.telefonica.de. [2a02:3100:adc6:9c01:89ae:b145:8960:cf19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35fb05sm9422346f8f.20.2026.09.25.10.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:11:45 -0700 (PDT)
Date: Fri, 25 Sep 2026 19:11:40 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: allocate RX buffers as page fragments
Message-ID: <araqwSZWDYqbPZWa@gmail.com>
References: <20260924101922.2675127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924101922.2675127-1-nb@tipi-net.de>

On Thu, Sep 24, 2026 at 12:19:21PM +0100, Nicolai Buchwitz wrote:
> Fix this and allocate the buffers as page fragments, so the truesize is
> what a packet occupies. 4 KiB pages stay one buffer per page.
> 

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

I applied this unchanged to current net at 11536ee3d3e0, current net-next at
42a9fb3382fc, and after patches 129 and 130 from 6.18.54-rc1. I tested each
with a 64 KiB arm64 kernel in a custom QEMU Pi 400 model with GENET v5 DMA.

My LLM agent helped me running these tests.

Results with a 524,288-byte receive buffer (repeated over five rounds):

                             Unpatched net   Patched net/net-next
Charge per 512-byte UDP      65,792 bytes    2,624 bytes
Datagrams queued (of 1,000)  7               195
Socket drops                 993             805

Thanks,
Karl

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789484;
	b=ZgvHV9zqWxNIuUnFOoizq1fVHDLDogK06zTSql8PYwuCbpO3CXnZ8rw7rHXrMxsZ1luH
	 5yeuhKxpUfBIqyJaDiShleFviY5ut8EWSA84Ckw9nrpCzz5nbVRaj4dAGjN4sq+NUgmfG
	 cSrUTEgW0aIHKCvd+qBDLRGaiXViykIZddedx8FWIISkOAsNYOochA0xA3Qq/KnuOE2eM
	 BT5AYOAJ5h2P53/JB05oshsZSuaF5RU0uBgOU4Chv9Vz26bwy6BRUzysUS7tuUgH8c1Qu
	 qXsVWedJ7qmbxd3mVCQcV2ILTAtjLryaL8cregvMNPE0phWkLHi19ifRHMj4L25oqzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789484;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=MnFQm5QxjKVTHXXP4Vck3dh0iis4+WeM39MMUmmySsU=;
	b=zPYnco5u3x01vOcjvqIN8n0weZb7ujIbxnQyBIb3FZkzhiF0hVahGzwvgmUJ09Clxv5f
	 k1YljSJ4azU3jxR/JcgLLLb6Dbb5Mmvk3lqgLObXy/Eq+8tozNDf2yJsRJvNk4ZdVG1Lh
	 7dDi8YEf1zfhUTauJZQYrdr/ZsxoVgSqmYOtNObMeaPRhu+iVJP09epVhAia+byVXHNW/
	 uQhZBlr/PzedaAoGgttjsnTl4R27/Fo1JHEhgbXjKxCLfAkMUuZ+H7ruAohycSlE4F2Ga
	 1b2Mw3f0Or+qokGj07ygBeZBJ/OdcqR3eC/oPSO4u2csGitXtYRj3O0slMKJy5RHhlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=H2UMnPpC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=agw2raEd;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E4606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 10:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF3E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=H2UMnPpC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=agw2raEd
Date: Wed, 4 Nov 2026 11:51:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793789481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnFQm5QxjKVTHXXP4Vck3dh0iis4+WeM39MMUmmySsU=;
	b=H2UMnPpCsoRlOkeCtR+hVT1hoEhv1xg22dtOEYc6E7kTBhM/z+M9P0/9vuJumGB7YMxc1p
	b3TaewkkCc9SXqoPZhf9vWd8i+4DidAQjpII9ylSrdKi3yM1wmSxG5wgu6cFv8tkia+Zvn
	nL7OXNt+MO6+Vv6xfWlY/iSNXv3K1dNW5IcLrmyEHKs0r9UUZwURCEFN5wO+0OHO9BUH9L
	DoaLuoOiZF/NLNRF5Enx1fyPpaNR/PhcsrPtJ3BD1UQESpoV947a06DRwtbG0x0nZLIxM4
	X0a5q+gk0UWW7Wjz6h6n/6+gkwQnRVnWTsM7BJsZQMJxz8SmSEBRZoIJhIxvIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793789481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnFQm5QxjKVTHXXP4Vck3dh0iis4+WeM39MMUmmySsU=;
	b=agw2raEd24saIlT3n1JFOcQp68SHSS7TqUVk0zncPnSJTU0uqNn4cKDwyTiQE72iDjymFx
	mgofHx4BHvR0aXBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
	c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com,
	davem@davemloft.net, fmaurer@redhat.com, kuba@kernel.org,
	neelima@ti.com, pabeni@redhat.com, praneeth@ti.com,
	pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
	vigneshr@ti.com, willemdebruijn.kernel@gmail.com,
	daniel.machon@microchip.com, edumazet@kernel.org
Subject: Re: [PATCH net-next v9 3/8] hsr: Add a magic header for sending PTP
 packets
Message-ID: <20261104105120.tJIvHJL3@linutronix.de>
References: <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>
 <179233869990.3135.8968590846653304827@kernel.org>
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
In-Reply-To: <179233869990.3135.8968590846653304827@kernel.org>

On 2026-10-18 15:51:39 [+0000], netdev-bot+sashiko@kernel.org wrote:
> - [High] net/hsr: OOB read due to mac_header vs skb->data mismatch
Fixed

> - [Low] At this commit, hsr_forward_skb() (net/hsr/hsr_forward.c:774)
>   takes the new tx_port and has_hsr_header arguments but ignores them.
I prefer to do it later, the patch is already big.

> - [Low] The new UAPI struct hsr_inline_header
>   (include/uapi/linux/hsr_ptp.h) cannot be safely extended later.
Fixed.

Sebastian

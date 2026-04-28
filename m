Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11785330B0B;
	Tue, 28 Apr 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411304; cv=none; b=lwhSkdPwQPoXeCLP8RopPT8+exSk+pcy+pZG8JgSyu8jKXU05CK/OXAuU4g9T+K018wo/K0+1iQJwtz7iiWNN82FhkU7xLJQeE71uKaKLKT8vg12qzGOZ3K3s+hYQ6pdLESFze3AwAQPcZ3eBTZae1L/aUx+PAhL1Q8p9i9Rjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411304; c=relaxed/simple;
	bh=v9KAKqE4VqvqaZzIprgkyuSm8ikFxBV9FKLQ1qUH4e0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gcigretqu5kEzO/Xs7EBdojXktXxEpJNpKhx50rGIQeQV/J1UA55ThtCUiuiuDDmylx1d4gcrcrruttaZ+duzY5a34w2l7oYIKk17BKkwKYV1XuTkHyXMIHljweubbjOwA4QH1041BwwDAMKDJrhvIg241FPFcOjY5t3yP31k1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=s791euDl; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="s791euDl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D01BBA3A42;
	Tue, 28 Apr 2026 23:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777411297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wSG+8fZmpaKxIHy4Vz9hophCNyAXoRUewRurv6XUOqY=;
	b=s791euDlft8iJblvrk6nmdfZ4P0PArHK++mjybGtPW7kHMuqLK2NSBbBs31HNEr23sXq1X
	LEaHy0mLrtSZw6ntYm0ET/F3CxOs86JmrUN5/PAanrHO4v4Ao2WMSoGKdiTaiUN68JH4xs
	RVVfPAFBJbEbCjUZ8Xx7bQbYJaPst40t5+FxMs4T/f34Q5BfkhDF7Mbv9vX3etHRzWn3Mz
	Q4JTxFJ/yqIuK/bvZebw/yQ+CF1/DXRicV8IJxsK88bFsf4/xN3merS749Yw9K0yqD0CgM
	eVPYhonxh86uA2yg337CMa4SDUW9E61Btyp6AvqCfZTG2e0pmjjEvRjNjeFJNw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 23:21:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, Paolo
 Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] net: macb: give reasons for Tx SKB kfree
In-Reply-To: <20260428-macb-drop-tx-v2-1-647f5199d8df@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-1-647f5199d8df@bootlin.com>
Message-ID: <4d3d0592bd9432391f7e4267f6fc11b0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 28.4.2026 18:32, Théo Lebrun wrote:
> Using dev_consume_skb_any() marks the drop reason as SKB_CONSUMED every
> time we free a Tx SKB. Instead, replace by 
> SKB_DROP_REASON_NOT_SPECIFIED
> when packet has been dropped without sending.
> 
> It is not precise but at least differs from SKB_CONSUMED and is used by
> many drivers for their error codepaths through 
> dev_kfree_skb_{any,irq}().
> 
> Pass a reason around rather than call dev_consume_skb_any() or
> dev_kfree_skb_any() because macb_tx_unmap() is called for cleanup in
> all cases.
> 
> macb_tx_error_task() is made complex because some SKBs encountered have
> been successfully sent.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

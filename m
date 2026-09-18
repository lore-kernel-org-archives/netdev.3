Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC64718C8;
	Fri, 18 Sep 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729410; cv=none; b=b0JAr91KL1lkkD9ILDHVJ8yjiMEO3hQdV4KiGPi7peaaSTEtEMFtyONkRFKW8e6aRd348BnPFddt4wFVntJ5KHkc9AreNpYuFWm54vM8zUrXR0G9UGsubk1ugHqkTv7xDulQbR3LBGxNtggxdCTyBYUOHkcCNPLT11hW3EkA2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729410; c=relaxed/simple;
	bh=qyOPOd/o5xBiMydRvhMSeFu+XRuaOlVfnx3x0Z8RAlE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PtZtMxVcs52pj0HNrGb3I+HlX6cpl5inAbMubU0RC2C1YKSIerJVi6vMSsRu5PhIjxFFxwiiEFIze3XaclCrUg/PagLqIHM4m+FaJdNFLWa7pGZBSKCoIyL2i/LRwPXczO+XQ51QqtPto/MBmTfujIzTpDvMesw72JWptM5GppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=gkYK7+qG; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="gkYK7+qG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C755CA9005;
	Fri, 18 Sep 2026 13:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789729407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lTpEsWsb9+oKcpQwEQIYDKkpYyRVoNg1PAwiUAvnoVw=;
	b=gkYK7+qGYQ6SLSLDsCVvXLpO5bB0T+80FZ0bw3uTZu09h28rO9+hWHJGYbZ30a4dGs4HA5
	+iuDIrZWult9sYXLuxboadlKAqAwjIzXmcJWfX+ZlN92o7zigiVzzBNFfupVNwANZ0oZUO
	sjMLLe5bS8UlqQdlG7FoW+L/HQfxEe50+UIa1haMzuBbnWaS9cqWJlhINE+xCgWhcFC19/
	sV9QO+Ba+YuDcP8+9vf5GhD9fwaaeicEb6y0i7ngzsSvP2jkgnVoxRlWzLEKTDItaVHyj7
	TA+GYOZ95DkZ0/QXT3sn9yfEAWR7/McYr+smK2z0tzAxtDMPZ4Xi4SS7bV+XnQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 13:03:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 7/8] net: bcmgenet: zero-initialize Transmit Status
 Block in bcmgenet_add_tsb
In-Reply-To: <20260918000732.276506-8-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-8-florian.fainelli@broadcom.com>
Message-ID: <f8918542ababe3af39ce6f2f5ee55948@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_add_tsb() pushes 64 bytes of headroom onto the skb to form the
> Transmit Status Block (TSB) but only assigns status->tx_csum_info when
> skb->ip_summed == CHECKSUM_PARTIAL. For packets without checksum 
> offload,
> or for other fields within struct status_64, the status block contains
> uninitialized stack/heap memory from previous skb operations.

The MAC only reads tx_csum_info when the descriptor has DMA_TX_DO_CSUM,
and bcmgenet_xmit() sets that only for CHECKSUM_PARTIAL.
The stale value seems to be never used?

Did you hit an actual failure?  Otherwise this would be a 64 byte memset
on every transmitted packet.

> [...]

Thanks,
Nicolai

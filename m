Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476780;
	b=iDIY9MUNkKSYu28cU1D5gVraVNCQLlVBPBNfZGKbLAeVxaknwMu0kp93wnKM9mz14Xet
	 drJkLh6NGMcl9l4TcVb4BVLeTuZnME+FYlGINZ9lWCw4rbGlulr09eGIZ4m3d7D8a7LX0
	 8fJyHzt4cm3KUFKWlomZGJEHE2ftdchnJPvgH3/XZmPwAgSbhN4Z2L+Mrajn4hhYm/3nV
	 OE0bVCF1rg61veWCBLFI1KkVu24elrJvboLJ+wMuVwuHz+2EP6oQczfIUxE+6nPrZHYC7
	 oPGiYpCHB0zhihvidAhjkjo48NiQCG2OMbkE5e5jOXFAxrpaxoUZzVBdWA25bzjbqNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476780;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=zF4RKurSPbtIZr5y6aisxGcnIy7a/9xHHcRfZOEEHKY=;
	b=OFm0/0qj5sEWeGPUjYTJqgmsXheoOPIWUc+9M0gOVk4VBhO2fiq6heEgbZw7RE7ORuwm
	 KKdpNjlEOteGn1q3xzMl/d32NnxFp/nPT3SQjpC5CPamM+zGQFbupxTzSr7SBbKPoGJec
	 z0kqTpxLOy0aUootE/m6qlEoDJ+FlfzCaf4pISlgScEiJaRpEAgf11KcNh4cvXdgfNcL/
	 ZmBYkTsPz4ObffFHRoxZom0rV9ndTfQAEybXVnJGA8W9ROUiO9AtYVIUj25t0/bcueprM
	 HTilw5sdDkfUCLAwg0JYkESHpQV+7O/aZQ9s326+mYRcuY4Y8dBJjRcFGVfr6TsYN7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=2pXqmXMP;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B592606A323;
	Thu, 12 Nov 2026 09:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B592606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=2pXqmXMP
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85196A0064;
	Thu, 12 Nov 2026 10:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794476777; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zF4RKurSPbtIZr5y6aisxGcnIy7a/9xHHcRfZOEEHKY=;
	b=2pXqmXMP8GV7SvW37kAVDSxQn4a35G1NODITlm961BJyJKuTT4HfH7yNcaBeBN4U7Eb3SF
	oGoK1o/QgNZ93MnAS6xYwRJFTIckJQVngdNqeBszfwHk3jZwF+9MUSzkvqSL3rUdWWOmIn
	/pZph+Gzp5APYCp3MmrS3XrDTJCFBDAo3ae2EZafPKBes8q1zu2HSsGOWEeCZsq//Hfd54
	pGZ6TMzePxnA/mbDS9PvreQE1Wmuurcx6zATx0sTy2N6DxcJwEygFLY7y6YKTnpcurFyiV
	mvOoMIx7Pmbs9BvgaXK6x1zNAiFJO+3VECTyNllVrq9nQZM3UDeQXq2vkYWX/Q==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 10:46:16 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: dwmac-sun8i: Enable jumbo
 frames up to MTU 2018
In-Reply-To: <20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf17@gmail.com>
References: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
 <20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf17@gmail.com>
Message-ID: <328e66e47898b772f2956649bf4cf795@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Arun

On 12.11.2026 09:41, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>

> [...]

> Limit max_mtu so that a frame with two VLAN tags and the FCS fits in
> 2044 bytes (MTU 2018). A device tree max-frame-size can still lower it.

max-frame-size is only parsed for the snps,dwmac compatibles, not for 
sun8i.

> [...]

Thanks,
Nicolai

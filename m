Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D788256C84;
	Tue, 28 Apr 2026 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411548; cv=none; b=RKg9UqMdNlhN4dzcVltKPQkd0xXTPvVtQQMz3d5Vm5gC4ChnfVeqZTySlEsME9/qbEpuZbkBQiRNyxtRC9vuDG57Pke3Xf2eS8wpXRVyEf2eHVoU1Rf6h+YbZTkFuN/F2G/TLV2YOFL2lvYXTJ3uYNXj8lkNhwhroyqQgZx/agU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411548; c=relaxed/simple;
	bh=SyhC8Wek2MsgzVKDYuRbSyosIqzlspHBml4AgCcwRbE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PqJOl1m/RF9UPyPomJTO00QmObhRnxuc7C/u3vi+eXGLFAKp7gzyaykHUKUWmBh/3t8k+cu3r9ArzfQj5gVSVut/oqAnhImz81v3f+M7PZYp8GzQ7yl6kXfO65dgq2JVOu1l7qSpNwzvDIjrYyuC5Ici8CeknofMwVNrAk5KmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=skdkhJJa; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="skdkhJJa"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFB4BA543E;
	Tue, 28 Apr 2026 23:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777411540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=u0+xBy0MnET71D7JeCx9O602jZOfY3Q891N+fBPev8E=;
	b=skdkhJJaTXOxknsHxe5B5ahdw+cULaPAGub5qcp/aUV/LDskNrhMQ7WEseN09pSXJeQCoO
	EIx9t0VyNIhk3lW5a7UFGzJJJiJ4gciMFFwjt4Ls69md4hPKpbik1fyXI3wjx0lK9fWW8M
	3IGrwgpxqUqKtoJKzCp1a+w/Mm1EqF6TV0aDGUt4G8R/bk2Kt7zRxfZ6i81dmDynReBaD4
	N6XmrSNALgVno5UVCVLcA5tNxb6cAu8d8lc4nZ6dYLzgI31vT2PH1CyIq2FlFXR05n30m8
	NeDF5zsRSAyRHXzIQC3HUu/r77fnOCAd+91/72F9+vPqypdaLl6Ozno56zgd1g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 23:25:35 +0200
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
Subject: Re: [PATCH net v2 3/4] net: macb: increment stats.tx_dropped on tx
 error
In-Reply-To: <20260428-macb-drop-tx-v2-3-647f5199d8df@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
 <20260428-macb-drop-tx-v2-3-647f5199d8df@bootlin.com>
Message-ID: <791f3e0f49b1fdb1d4dd585fc1ddabf8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 28.4.2026 18:32, Théo Lebrun wrote:
> macb_tx_error_task() is the workqueue callback on Tx errors interrupts
> (MACB_TX_ERR_FLAGS). Count number of errored SKBs and increment the Tx
> dropped stat by that amount.
> 
> Two types of dropped (not consumed) packets:
>  - Those that have been TX_USED but with an error.
>  - Those that have not been TX_USED but that'll we drop to reset.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

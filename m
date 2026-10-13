Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911C522F1B;
	Tue, 13 Oct 2026 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918299; cv=none; b=PRKvzw+BSHjJVdT9RBGvPFbch84uvWFB+zPOWTiEssWDwIJN5MD6VTcmNoGSM8JrRsRxgYWcEeJ61MWhvhTTjv8qa8EhGx5eA0GFsT+D1pZWYve0wBWMskJ6Pmeeqq/DjsfNMUHFpdJApuQ8xF6VAieg25kUH7XhvgWaOEUc0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918299; c=relaxed/simple;
	bh=n+8rA6Pb8ILyzEhI8iY9B+JvaJnY9qKVlWFEEGNL2MM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=X8pY5QITGmqTu8kiBaHaFIGMyABEpD3zLi52q6MFqBCA8dpuK3+j0Sfoym/CIgHKOVwKNhYWtsd3CBapuvATFu+5JO21+F+nsyJ3JjxADKLWg48vEEAHPt6EB/83VF7W/7y5tfVc/KEme1WnCYgYNsxCqOOqbM8Oe6q9Ovcopi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=MzvSWfXS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="MzvSWfXS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8598FA1559;
	Tue, 13 Oct 2026 21:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791918285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=saDSlwe4mPw49S3N7DFvQPKAKv/DK7HdzCZPVNqXPAs=;
	b=MzvSWfXSXiyDpO5bt7Xz0/jTLRelKl4sQf0mQL/RKDnan4fqqMHp3C1w7Y4shL+LqvA0Wb
	3jlcN855FcGtPTmEjg/hakjaE06qTpqTgiW/cDhbcdKxvE8PQxy4VW2Fftc85aZkMHp3EO
	hrddi0EZ1RZN8kfypfQTKoqdhhzo802Qkb1PAXt6l3of+h0c9MFxxUrybSYVmOYIGf5jb2
	3zu75XCQ7FkvLSIs6lMYWLO9KhQgKTX1j2rStCgEq72xt6MMmz2Bk2wBhsBq/Zh12p10rV
	O5lyDTYaJY+jdCs2zs/ZAuT161WXLOyfETrbMMclr6u4TolpAZoKVWzZXhvsgA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 21:04:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Valerio <pvalerio@redhat.com>, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 stable+noautosel@kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v11 0/9] net: macb: implement context swapping
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
Message-ID: <27d764b0c5c72de4aff77160b9efe8ef@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 13.10.2026 15:16, Théo Lebrun wrote:
> MACB has a pretty primitive approach to buffer management. They are all
> stored in `struct macb *bp`. On operations that require buffer realloc
> (set_ringparam & change_mtu at the moment), the only option is to close
> the interface, change our global state and re-open the interface.
> 
> Two issues:
> - It doesn't fly on memory pressured systems; we free our precious
>   buffers and don't manage to reallocate fully, meaning our machine
>   just lost its network access.
> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
> 
> Instead, we shall:
>  - allocate a new context (including buffers) first
>  - if it fails, early return without any impact to the interface
>  - stop interface
>  - update global state (bp, netdev, etc)
>  - pass newly allocated buffer pointers to the hardware
>  - start interface
>  - free old context
> 
> This is what we implement here. Both .set_ringparam() and
> .ndo_change_mtu() are covered by this series. In the future,
> at least .set_channels() [0], XDP [1] and XSK [2] would benefit.

> [...]

Tested on a Raspberry Pi CM5 (RP1 GEM) with lockdep and KASAN enabled:

- ring and MTU changes under bidirectional TCP and a UDP flood
- ring and MTU changes while the interface is down
- ring and MTU changes during autoneg
- injected allocation failures in both paths
- PTP and EEE after a swap

Everything worked, and changing either no longer takes the link down.

For the series:

Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # RPi CM5 with RP1 GEM

Thanks,
Nicolai

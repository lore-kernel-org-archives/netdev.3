Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011835;
	b=vBkVo8jGjKxR/mmfCoxwNcTFd31MYi6DYBpK8k0yaUwLFTkxRalTaQ5kJCkQlvzwFW8a
	 vq0CUMJCMEKuyRJeAeXZ3fPgNo50sd5oBXmEfGIyUGn8ACVrMqpEFSW3ejx/DwVKt171r
	 hRbJ1xzLyBB5SJGC6tlXdstZdXF438rKayWg0/v0cyKK3BSqLXWzMsIu3ezGr4LQi5QvG
	 f71Gema+GxRFdLrLJj46ELhixSOvDfZ0AYc78t1t2EAaVyrLjwS+CHz/uMwYUUFj1qrnB
	 vo0tpxtZIwg3TudHt9Ft3w83QpVlYk/I41SWZHhsq98D9EANwlZCCQiIIytR4Nql99g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011835;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kZegd21eJPs0d40BjKUHqcr89Pv+qXwSyRe0ZqGvMzE=;
	b=Be7jk7CtDqkSXeoQHBNfwFjMzOe0I4DVpsmXh4Ilj47WARD3p275AtA3HVKGU3WVwC+D
	 /nZrDD53i/bcOQ8GJlF6krvIOS08F4KP3ZJEwdXwkv6WZo/vXdD+ABUpjkUXSeGRhcIPz
	 PAr2Ja656OWmRFF24VGEGV08qKw6ELUJE4omppTPKCciGRnGfkDKPK0l0BzzxQEYteNrf
	 nT5yS3U0ynTGO8LhoAv/Adam0k0qhOQzIFPCxI9bmsIwTN/Kbr76vLLYj4c//ezYdnIyB
	 Mfrg54lq21z1rJPRGlJQf4LmUX4GAQOiQMihn7fzzaiVXPHg7FcJOhCPi2wtcRpQM0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="IYlnXd/M";
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA53606A31A;
	Mon, 26 Oct 2026 10:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IYlnXd/M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793011834; x=1824547834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFcPXXCNlvoJwnjmf4sXIj7Lp3FDYBM8464Z4wq1uaw=;
  b=IYlnXd/MKe00Yfy4Ben/BdL3J/PObJm6U8aHucfFmi3oLRk6ZSojIExe
   J4iifWZYVpVtM+AxkA05wMpabQPwCmoeMMA2USwbx01NU+ptc4unq+cmZ
   +FllXI4y0dG/8w6FucfV99O/Z0oUgzNZxjmuNOTCD/nxCEhVBpBBnlQts
   BsO13pNlBwKt2zBIPoWnVdE7GW7pND9QS+v26IbEDwhp/YeHQ0qj0vs1n
   uyGpopXRWWAYfXPZAw2JEaGLjGjy6V50YswjjOD4fAluqL8/QJYxmvZk+
   FzdOqTTQbLeUTdOQqJBixxH8rt/Z44DvREY3jGMgIQfjEQFvTzOoYGnwh
   w==;
X-CSE-ConnectionGUID: BtB5I6RLRlmmxGgsFCekRg==
X-CSE-MsgGUID: wTdfZMXbRCC2GFL6SmY5vg==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="64589480"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:50:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 03:50:33 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 03:50:30 -0700
Date: Mon, 26 Oct 2026 11:50:30 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf.kernel@gmail.com>, <thomas.petazzoni@bootlin.com>, Alexis
 =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] net: Use a dedicated flag to track disabled napi
 instances
Message-ID: <20261026105030.j3a4aims7tgqm23t@DEN-DL-M70577.microsemi.net>
References: <20261022075757.1164283-1-maxime.chevallier@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022075757.1164283-1-maxime.chevallier@bootlin.com>

Hi Maxime,

> Trying to disable the napi threaded state while the napi instance is
> disabled will hang forever in napi_stop_kthread(), as it waits for
> NAPIF_STATE_SCHED_THREADED to clear.
> 
> This won't happen until the next ____napi_schedule() call, which won't
> happen as it's disabled.
> 
> This happens in 2 instances :
> 
>  - Drivers that create but don't use napi instances (stmmac's rxtx napi
>    for AF_XDP for example), here it's a driver bug
> 
>  - Drivers that create their napi instances in .probe(). Here, setting
>    threaded off while the interface is down will hang :
> 
>    ip link set eth0 down
>    echo 1 > /sys/class/net/eth0/threaded
>    echo 0 > /sys/class/net/eth0/threaded
>    -> hang
> 
> Checking on netif_running() isn't enough, as napi instances may be
> transiently disabled when changing the MTU for example, let's use a
> dedicated flag to track if the instance is disabled.
> 
> This allows immediately disabling the kthread when the instance is
> disabled.
> 
> This was tested on mvpp2 (probe-time napi_add) and stmmac.

I could reproduce the hang on lan966x by toggling /sys/class/net/<if>/threaded
while changing the MTU, which disables and re-enables the NAPI around an FDMA
reload. Without this patch it deadlocks within a few iterations. With it
applied, the same test ran clean.

> Fixes: 689883de94dd ("net: stop napi kthreads when THREADED napi is disabled")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Tested-by: Daniel Machon <daniel.machon@microchip.com>

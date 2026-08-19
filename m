Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B213CC315
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123456; cv=none; b=kqcdsDo+qNrCkuJ3RrMG74kYCJwGOxowr86UnoBO6/nEceM+K/LvikJGe+DSGZb19btuM8q3nM+JL47rfT2p0wVJ0y1mZ3Upu1lkAzlkLZC7+b3jgTDmnlkf2s4ftqr2MKTSPu+zt7CjhA5uWHoZRu+GMrQ0ugUPcr5USezLA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123456; c=relaxed/simple;
	bh=RxmIQU6g8Iu13P8fOdZWmxYGbHuU9kVWuL5SsXm0P8Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z/Oy5BH1aqvabxNIlv6MKw9tWbhwYI9mHEtfQNNKpyijBPOvqJqdOP5gmK+AjftBnD1oUV3VzK9kqngztl0BG1zw7GWIqFY8s9XqE9y1ZRH1k0LsMrbsmOgU+lxD65nDhb7rJxrjMS8+kTHTIRd7DSDzAf16nNEOO5gq+uME73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=czM8p3dS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="czM8p3dS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A376CA6A12;
	Wed, 19 Aug 2026 09:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787123443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FvlDuLp4El5NeP0h+eITHvZeljEjPUGSlpwZ/3k4/mI=;
	b=czM8p3dST6xbQdAC8bfGwsVs5Tm5RjFYOTEz+KtlQIY7PA9O/ZqAffAjdO13ccqFXbZZ99
	dqtW7wKgapFM4/82bpwE3OwELvbP6bebVQI4cyP7EdBB8f8ts59etoZWrSMn4/HxhJ7fAq
	XjJTOwv3AlrG39XQhaMu4HLgb8Umo0QkUaqOGnhXgx1e+rRD628Q9jrMWmczHkc/OJhMu8
	eC4OEK6DhXDM1bBukIHfec14LDlji8Wf4ns4mpUSalFCWire6tv/3HxSU3hTYvEyIXWGWP
	B0AkHPwDQrKy0mKfFin2qs6EtPtdFtD3IDHHzdMRpaLnClanOAL/lDXPmelHmQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 09:10:40 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Zhixing Chen <running910@gmail.com>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: fix CONFIG_OF=n build
In-Reply-To: <20260819040913.109367-1-running910@gmail.com>
References: <20260819040913.109367-1-running910@gmail.com>
Message-ID: <e84bc7b95374bbe76234bd56e819ba5b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Zhixing

On 19.8.2026 06:09, Zhixing Chen wrote:
> macb_alloc_tieoff() and macb_free_tieoff() are called from macb_probe()
> and macb_remove(), which are built regardless of CONFIG_OF.
> 
> The helpers were added inside the CONFIG_OF block, although the tieoff
> descriptor handling does not depend on OF. This breaks CONFIG_OF=n 
> builds
> with implicit function declaration errors.
> 
> Move the helpers outside the CONFIG_OF block.
> 
> Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across 
> device lifetime")
> Signed-off-by: Zhixing Chen <running910@gmail.com>
> ---
> 
> I hit this while building the latest net-next tree with my local 
> config,
> where CONFIG_MACB is enabled and CONFIG_OF is disabled.
> 
> Since CONFIG_MACB does not depend on CONFIG_OF, macb_main.c still needs
> to build in this configuration. However, macb_probe() and macb_remove()
> are built while macb_alloc_tieoff() and macb_free_tieoff() are hidden
> behind CONFIG_OF.
> 
> Build error:
> 
> drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
> drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit 
> declaration of function 'macb_alloc_tieoff' 
> [-Werror=implicit-function-declaration]
>  5951 |         err = macb_alloc_tieoff(bp);
> drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit 
> declaration of function 'macb_free_tieoff' 
> [-Werror=implicit-function-declaration]
>  5973 |         macb_free_tieoff(bp);
>   CC [M]  drivers/gpu/drm/i915/display/intel_qp_tables.o
> 
> ---

Nathan sent the same patch a few hours earlier [1]. I will follow up 
there.

> [...]

[1] 
https://lore.kernel.org/netdev/20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org/

Thanks,
Nicolai

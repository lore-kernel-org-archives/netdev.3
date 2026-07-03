Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888282D5937;
	Fri,  3 Jul 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096339; cv=none; b=Y5Zyj32ZF2xKutPSnoXx/VDHlHv9u+/6YX5CgKYFFQ4xqnOvN5U46M2MJ/mZMET0ShGmC6MnG3fnfFhH3EqLVsQF4LCSChkUKbopwIyXdnfr/m/oBojq0WW/4qHGfjP+0GVAap54ls0xrWYOkkuF+5ODCBDt8bAriQLW2STlHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096339; c=relaxed/simple;
	bh=pFq7qXlGoKSF9E+1OFt+CR/1KmxFtBay4rL6A+5TbvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EAz2rOL02UJuWIAmXbbE91Iu+8mme8b5EA9i7IvNAMdnb9CX+uHUzgSfXssQmvowkH3Q0kV3vZmEOXfvrHgA3L5TT28lEehQaOlCqxgmtWQYY2dGvZ5j/f6hj2ro72X2OknsPwdvwEMzR89670Wx+RiBsSUJjfHfk/kMOttrTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C2wkDCKY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C2wkDCKY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC1511A0E0E;
	Fri,  3 Jul 2026 16:32:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE5EB60300;
	Fri,  3 Jul 2026 16:32:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DE46102F0D61;
	Fri,  3 Jul 2026 18:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783096333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RLDscj7WzG84K9lSPYBqKCc45pcOPXuAsdlAYE6GaCE=;
	b=C2wkDCKYpR9mki7vl7MiNfHDxhacdAO8ppWqQ3C8BS4rLqa/MWXJP5Lscdkk3KMouDqEmQ
	eJUWL0c292xTl7OZ2fW05WnsqNEz5RK1HO8OGxwNFsRvc+vLBHtPRcP12nCmkyi6uLoiES
	EdN02l8R6Zy1eTI8CaITQHGjzQTE9BBQGcFskNpuop+mDzFeKAhKOd2FfGpyq7jaQrwHH5
	Q2PZFd9fF6tjvnxjQAb62VEcvtFkDGRuZPZBCEc7M+x25vK60D5AVp5B732wwzRy+QSlyJ
	5Q3jqjEy4H8cpLLSjslGGnYvwedWO0xgP8Mf9IKhRgzPRUB8NKS7Ze+yGuvlbw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 18:32:08 +0200
Message-Id: <DJP2W90JJK0G.1DBR4RMJKJO2Z@bootlin.com>
Subject: Re: [PATCH net-next v3 01/15] net: macb: drop "consistent" from
 alloc/free function names
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Conor Dooley" <conor@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
 <20260703-stucco-broadly-d9393f789868@spud>
In-Reply-To: <20260703-stucco-broadly-d9393f789868@spud>
X-Last-TLS-Session-Version: TLSv1.3

Hello Conor,

On Fri Jul 3, 2026 at 1:28 PM CEST, Conor Dooley wrote:
> On Wed, Jul 01, 2026 at 05:59:04PM +0200, Th=C3=A9o Lebrun wrote:
>> Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
>> functions have not been only allocating or freeing consistent memory
>> mappings.
>>=20
>> Rename from macb_alloc_consistent() to macb_alloc() and
>>        from macb_free_consistent()  to macb_free().
>
> What does "consistent" even mean? Is it intended to be analogous to
> coherent?

That's my guess. We used to have pci_alloc_consistent(), being an alias
to dma_alloc_coherent().

This alias has been present since forever (since Git):

   git show 1da177e4c3f4:include/asm-generic/pci-dma-compat.h

The alias got removed in commit 7968778914e5 ("PCI: Remove the
deprecated "pci-dma-compat.h" API", 2022-03-09).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


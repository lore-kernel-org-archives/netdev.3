Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A437DE9B;
	Wed, 22 Jul 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736286; cv=none; b=pCWRhG4ZgjdY5ko6qWA/Bn3rOKJoZJ8I+k9enTKpgYieWFPc61Q/aCfexOZ4xfZ6nvocahXcH0NPMWMjazJLJjjVVf0VwILWtZ1UbD/Rhy5q2byw/KlLAPotcq5wPOPPq2yQm7kqdd28LpQR+bgf5jjJexuxV1uuu3lF6+iI2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736286; c=relaxed/simple;
	bh=Kvb5/f689LP/CXCjSl2rHmj+nmCwiqnc4dCuiJ2d+B0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4QV+O0ZXnLpLdn2icfivVeUudoVNOs6Dgj76K3UBi17Ec6s3baXTrykLQogSGd1Mt/iStemoQ31vYmx5c7OU+sS0PbCJCAqQ0oUhNkeBJg+O3CNDiq4GJSvX0cb5hIsjA3MaOnzsaDAsdi9fusVxKNDDIXhQbGD8ua2J1XhfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkzphQo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkzphQo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27661F00A3A;
	Wed, 22 Jul 2026 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736285;
	bh=V3styyTrJSgjSQ3qUzOGfoN+cNHukXJiKId23arjeZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SkzphQo58kDAzKLyhhs4SgMDbLpGeGkKvV8oMJA4ZB2SjEMjBxbNG62AgYLNuuI4z
	 1wWNDhoife1i662CgnpX+2Yv58WT2iYAw2KG9Cab8JIjVVCo7L31v71vEC6bLl5wNM
	 Mo83ydoXAHKK4BFx8qqvlTnLLZwrvGXj1yYduZy1oiZ7ztnLcSrVpUGrwVU8NRDPMq
	 FNKrIfPFUW9IeAI8Cfc6YtI5smWPqQUCuizFC6pbsiS1Qu3DRYns82BAKuAwZA1tIM
	 ZhqY0NzfAZ5Dkwa6WXRW4m//mf3t/r5bNLBDOdRrIo4SDsgxyE7jPpM1rFCes3toqM
	 mz75hJ0U/niAg==
Date: Wed, 22 Jul 2026 09:04:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Satananda Burla <sburla@marvell.com>, Shinas Rasheed
 <srasheed@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, Guangshuo
 Li <lgs201920130244@gmail.com>, David Carlier <devnexen@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 0/4] octeon_ep, octeon_ep_vf: fix RX skb frags
 overflow and page leak
Message-ID: <20260722090443.0c24a5df@kernel.org>
In-Reply-To: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 23:51:27 +0800 Maoyi Xie wrote:
> The octeon_ep and octeon_ep_vf RX paths add one skb fragment per buffer
> with no bound against MAX_SKB_FRAGS. buff_info->len comes from the device
> response header. A long packet needs about 18 fragments. That is one past
> the default MAX_SKB_FRAGS of 17. skb_add_rx_frag() then writes past
> shinfo->frags[]. Patch 2 bounds octeon_ep. Patch 4 bounds octeon_ep_vf.
> 
> Both drivers also leak the pages of a dropped multi-buffer packet. The
> drop path unmaps each buffer but never frees its page. Patch 1 fixes
> octeon_ep. Patch 3 is Guangshuo Li's fix for octeon_ep_vf. The overflow
> drops in patch 2 and patch 4 reuse those helpers. They free their pages
> too.
> 
> The drop drain length derives from the device length. It had no bound
> against the ring. Patch 1 and patch 4 stop the drain after MAX_SKB_FRAGS
> fragments. A valid packet never holds more. This keeps a bad device length
> from running the drain past the ring.

I'm asking you for the second time - why are you working on this driver?
Do you have HW to test this?
This driver is orphaned, it's been nothing but bugs for years, if nobody
has this HW we should just delete this crap.

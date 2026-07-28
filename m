Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB576337688;
	Tue, 28 Jul 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257422; cv=none; b=I2p4eFT7I5VzI4r21OG+F3upJqQizZuM/5SvOgqPwNMj88/qavLOcUcsWKUxGAziRctMoeKGAjO1RWItjH36rT4MnKuOQUlvQtvW20+WrRktqxhOPqzU7SiVxu0RkeNqFWZ2jJ4rwRgNSJU7apNlPqnvdCMEgp8qMm4CBUR8GU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257422; c=relaxed/simple;
	bh=8lwqht2BJIdPgjLkgsPDgW0e64MGFMCDW74SywWutNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exoT658dkwWw0D1G0VgmFFMeOaN57w4uEobQU4Rw1XWJTzHsRVsDJZjNFoSM1ics+JTyw6QRarbQ97KTG/IcfSsL/p87ahQJ2Id0y30ASZVO8f4Q1kMIeedCiXdSEgZYLus1FGm8jkMPcOXxNbWKfJkDZtrwuyaU5ZmtiNMtCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjOFw/7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjOFw/7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D461F000E9;
	Tue, 28 Jul 2026 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257421;
	bh=eMVLXb3RT9FbDO083RgFmGa0HeZ1j8VEDktkW0c5d1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gjOFw/7/l7Hp+ilNqeaPSpN/Pahq4QGxxludz8WC/8xtj5xx4cbnYGB/5sKGL9Zte
	 52OkQIHZ9i7m1Q0TY/vpnJg9979fDAikDHyVHlBYBtOsuAKF3vts0L89stFJgr6N17
	 ax7V9kdM6DL6OiANMAtdZsntVyDHYZ4BzRf1scBqSNE5yTHk+kU9dNmKvmmOjt6e+r
	 sgtLmW1uqQIaPY5vQjExfiGSS5Sye+JNw5s92cua8oszXLzas6moBAG5PlEP0c5Qzl
	 h0axRahUUqqqipT26ey1t+zFrj6cvymkNl0x407qf7Vf03N4+abWeaOYasYcIFhzuN
	 GjBHHo6rb+xYA==
Date: Tue, 28 Jul 2026 17:50:17 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, lcherian@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com,
	tduszynski@marvell.com, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net] octeontx2-pf: Set correct sequence for carrier off
 and tx queue stop
Message-ID: <20260728165017.GU418547@horms.kernel.org>
References: <20260724072831.2415281-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724072831.2415281-1-rkannoth@marvell.com>

On Fri, Jul 24, 2026 at 12:58:31PM +0530, Ratheesh Kannoth wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> During link down event, we were doing netif_tx_stop_all_queues() first
> and then netif_carrier_off(). This can cause a potential race since
> carrier is still on during down event. This patch reverse the calling
> order to fix the issue.
> 
> Fixes: 50fe6c02e5ad ("octeontx2-pf: Register and handle link notifications")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


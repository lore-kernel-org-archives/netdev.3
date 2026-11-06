Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957992;
	b=y8LVh90YBR+k2UBThTpmjUyWZuUnTCVnZlXEGh6YPf+0cH1MnmDlh0fEStpHZClwLfCo
	 KPNxhLlYG47l0r9NCyVSaR7XpYYL+yEMtcKwiRdP13CIgv2phP0CHA9IwNqNUveCtYmU3
	 vnpp2WtnCXsdZBTre65/veFX4MdMdKk5bixFFsncSH4dvpTphLFQY21/43Dleufu/HacP
	 IkglSy7SaK9p4GH7CKKI5jqBj0/VYS+xRlDAZViU3OPdD1v09LzDs55P98uYYoqGBAJTr
	 9I6W6og2QF9VhQE7TUObtqBxZgfuKiKJLqg3x/CoLywjLmgeAflAw5ULgGLrNFHoHEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957992;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W0M+W1Y+h5TJqnxENtVRn6tD83rqY3lGCO0UuVf5Wd4=;
	b=1Of2VWGD73m/QmQpDJj1rXpBeCfh+1PFb72okUhedmqtzgWVlOQPWKq/FsIJeHaDdoX8
	 8zSA5CTYrr0/HtaehPRbRNSOPHr8BAGjoXWlyqMK2cf9FerA3d9L4Gl3mAz4sChOg5BFn
	 lkCgGIqDT05yBQxVvk5Ml6+yoAsUXy9a3YJ8d3iYKaJiXaOPejvdkl4EN2gyA/6wEwHDK
	 vKRNNLccqglWn79iCrmQ19D4Zx9RGxEzkehnzZ1wbC2Le3nf76xXrZPSdgR6TOuaCu6Vd
	 LiAA8Tng0sjVKWbTzf6JLbwkJifRVNTPTkBMdEKC/6UyByjbOp3OzxILDIVh1oKEZLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPSP9Enh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CC606A906;
	Fri,  6 Nov 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPSP9Enh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01021F008A1;
	Fri,  6 Nov 2026 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957992;
	bh=W0M+W1Y+h5TJqnxENtVRn6tD83rqY3lGCO0UuVf5Wd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gPSP9EnhmMBjsw+izdfuQkKP0nh2klj/EyKTgtwrLvvkgCwe6BORfynI/+bBhe8Zv
	 C2KOPhNQbflaIkKDL0L+aeNfXDpEOIwOUYEwv3wFY3GjCg0ze3yrpOJLOBGirUY4rE
	 iwBj4OklkwQ4gMSv88JVIZ72l0hwemOsj9RTVTxC8cLMLegyF3a516Dr18YdlIVF1U
	 04D8L9B/azY0EKPBj02B8FqpoV+P+uTMLzbgd5KlNQL4HyQsNC90/4f6SioB/lNzH6
	 H2SjEs38oQEJjrE/Y9TreVwyLzQGA0FcgzcTiZoEGzi/VOh8kFHjhEI4hTRm4g/jmW
	 5bclEZm3+Cilg==
Date: Fri, 6 Nov 2026 09:39:48 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bgmac: stop advertising TX checksum offload
Message-ID: <20261106093948.GD865646@horms.kernel.org>
References: <20261102215806.13723-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102215806.13723-1-rosenp@gmail.com>

On Mon, Nov 02, 2026 at 01:58:06PM -0800, Rosen Penev wrote:
> The driver advertises NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM, but
> bgmac_dma_tx_add() calls skb_checksum_help() on every CHECKSUM_PARTIAL
> skb, so the checksum is always computed in software anyway. The return
> value is ignored too, so if skb_checksum_help() fails the frame is sent
> with a bad checksum.
> 
> Remove the feature flags and the fallback. The stack then computes the
> checksum before handing the skb to the driver.
> 
> Tested on an ASUS RT-N16.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

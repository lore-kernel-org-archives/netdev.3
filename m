Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BD28469F;
	Tue, 17 Feb 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367636; cv=none; b=aifD01hfTaY5rxE3dhGTkSjNASshEGXY5h9JwXJU2vvmrWS3rKFvILrDuM2Sjjikzg0qL9L5h0izi/bBCHItM1i5D+TA+foxmbFpyc6m5G3TYhwEFeNmEuLNH32rFM7vGTrQsTl6GNxTgrJjbKTy9fPg0Faug7MDy1w9Uu+nTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367636; c=relaxed/simple;
	bh=LlrpJcHFap7X5mLuKnk4GuwG/MJaw1lF4+KlirxoQsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkmmVGZJNNr8o291H7Aa4iA83ItMPgAiHIONIb5VlR9LhBoDPKKBjkPQhnargweuL3XC8dxOcIq+96eLlj9R4AdJUT3F2TGsyzsh6yN7vpQCT3Br8FLyNPSx8JnJXRM3UzmudIgxVzMDWFP4MU4cLvgH+WG9qjhWQcU4Hw0YLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD2Htsze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD2Htsze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582D9C4CEF7;
	Tue, 17 Feb 2026 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367635;
	bh=LlrpJcHFap7X5mLuKnk4GuwG/MJaw1lF4+KlirxoQsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sD2Htsze+iZt25IH8dAnf2DJw4ZsoPTkKAPtN5Ye2aU0EcKrki7UIIQdIwDzkTnMg
	 +p5cFlEmi8RiSfyfqH0WFd92Q5C/QPKRcptTLFOMgCSP4HN7cfi8u2Jv6rbT0pDyI1
	 KhvLbXIqrrcIk6ROYypQTNkrrlUDM5yL4bjN1/XCquDZi8IhscHqCOq+BCfx3Mq25p
	 XMxX3bNOnJLRNnTd1KNznSlC8fPP648e3XjdRtNhI0ScEIU/EL+np1vf7WG5y6ZIFy
	 KQXxqXCc/vqriOBt15Uq65/AXFvbY7aJPzhfrvIkaQo2OHeIkXW3jwwH3WCWQz/9vC
	 0etW/OG9elpPQ==
Date: Tue, 17 Feb 2026 14:33:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fabian Druschke <fdruschke@outlook.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Fabian Druschke <fabian@druschke.network>,
 Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] r8169: avoid OOM when allocating RX buffers
Message-ID: <20260217143354.3366db18@kernel.org>
In-Reply-To: <GVZP280MB1013A39E6B154E88E8CBB87EAF6DA@GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM>
References: <20260216185245.182450-1-fabian@druschke.network>
	<64b1a578-5325-4d51-9b10-2b54fcaa0a7f@lunn.ch>
	<GVZP280MB1013A39E6B154E88E8CBB87EAF6DA@GVZP280MB1013.SWEP280.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 22:50:30 +0100 Fabian Druschke wrote:
> Ahoy! Thanks for clarification! Didn't know it was intended behaviour.
> 
> We've encountered this issue specifically with this Realtek NIC on 
> ShredOS due to lack of mlx5, mlx4 etc.
> 
> For NICs like ixgbe we didn't encounter this issue so i was thinking 
> about a bug.

Most / all "professional grade"(??) NICs support scatter, where larger 
frames are written into multiple chunks, 4kB each. order-2 allocations
on the fast path are a bad idea. One way to alleviate the performance
implications would be to use page pool, but that doesn't help with the
initial fill, just the datapath :(

reminder: please avoid top posting when replying on the mailing list

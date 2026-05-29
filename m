Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085D3A875F;
	Fri, 29 May 2026 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078052; cv=none; b=J+BsUxM6t+ERHqPK9f7oBxA0+1g1SqLFiJDEs8PA5SSVkQ9qHhCcpq4p28O6HLix3fYmKGRDTlIxjRkaAKJBr7heToNXsET7ZRNrSt24pqDRS4PfGNkjfE5usCiJAkhC9O2yN8vb1OvUZ0C+jEKWunh9vQ4qhWU25aMr/Z8jawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078052; c=relaxed/simple;
	bh=LEKI81jRUIh8bUsqzRbRzc+SBSrYwf6+bjAnYxN4cgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHH8dxCnRsxAS+FqHLMc7TgxyaS/S5CT8/w5cnABkZVwVDpwsG7vi8y6bptDvWiQS3hv9DncMmBjwbcwfyUA+UA7j9yrYWonBvlfIRZ7/GHQsQGoVvr1KGC831+YVWjIMrJ7mDeQm3IzUQTPZDR94Ouxyr2IQwYTMdP9h9JPlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URHM50TF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URHM50TF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C331F00893;
	Fri, 29 May 2026 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780078050;
	bh=EXtho9XboC78QI+YfMO3FJJLz3MkFQIZAyjanmWImWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=URHM50TFbESjNWgKg7NrAbEpJ8F08WiVi2WMXJL3xuyUoUYHxzO4pX+IYgO7Mlopa
	 rPbF4HTpY7lcPRcX9lZOoysZ4f93i0h78sKwNPYod4lKDjQ+ipgoJlKPXHxr4BMWvZ
	 8eJy6rQvbgan7VvhCSMcyl8IMjb/8BlnwIZkXO+OHqDZhpSNuh5G1Fdlk248Wkwvh8
	 YgKaOJVLt4B3hsicbPogOB15SUozvKpQdmFMl/M96fpIwoVo/w72UODCdXAYTtaxGj
	 h42mdaqw7SYb6HnDt4kTKXdaRsDoo7SIy7hs9eF4RpyzB0sTDuGd29jxHLmrzXR0DS
	 JnLzkjAckhQoA==
Date: Fri, 29 May 2026 11:07:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
 <nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v6 2/7] r8169: add support for multi rx queues
Message-ID: <20260529110729.7fb14344@kernel.org>
In-Reply-To: <fe97b63208af41fc811ad37db94bc705@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
	<20260526081117.173-3-javen_xu@realsil.com.cn>
	<20260528180432.4652dcfa@kernel.org>
	<fe97b63208af41fc811ad37db94bc705@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 06:47:00 +0000 Javen wrote:
> >> @@ -74,9 +74,13 @@
> >>  #define NUM_TX_DESC  256     /* Number of Tx descriptor registers */
> >>  #define NUM_RX_DESC  256     /* Number of Rx descriptor registers */
> >>  #define R8169_TX_RING_BYTES  (NUM_TX_DESC * sizeof(struct TxDesc))
> >> -#define R8169_RX_RING_BYTES  (NUM_RX_DESC * sizeof(struct RxDesc))
> >> +#define R8169_RX_RING_BYTES  ((NUM_RX_DESC + 1) * sizeof(struct
> >> +RxDesc))  
> >
> >AI bots are asking why the "+ 1"?  
> 
> This + 1 is a workaround for the hardware DMA prefetcher. The H/W might aggressively fetch one more descriptor even after hitting the RingEnd mark. We allocated this extra dummy space as padding to prevent out-of-bounds access and potential IOMMU faults.

Add a brief comment explaining this please

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30033955EB;
	Mon, 10 Aug 2026 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397371; cv=none; b=osRFTle3QUVSxGKbZYkpsB32lp4/f/Lo4NxG7Iq4wNb5ehIVBHu8j6JHXFyjU5KVcniU5Mpb10y6WmX7Vd8+ZxBhTK9xo70jTwZvdiDGtxdyUAdw/tpwu57fcyCGD6xwLwunN/xKV7EIEPQGRnxFDVMXEbbVw53cYXC++zSk2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397371; c=relaxed/simple;
	bh=uA9wePrIIBAHC/u3KARhb1laFiMN6j+NazzVlk8xF9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtzgmBvTSyG859XD21Ryr1jgLp3u2GxwXTCenwtZ9k8bD3gj4Ro6EaNZyIMndfSaelcCa2UDwYv2cd/krpA5LfMPu3FbA9cvbuHkeUfdlUpEkzCOxse4LgtaWiJ47L3IB2gvbODwnDMUUwpEnr9I8sNjF5wIv6Z8Xk/4MI9byOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD2oGsSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD2oGsSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4951F000E9;
	Mon, 10 Aug 2026 21:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397369;
	bh=gwm1Ou+RfGa1oAFMQHL3o3ZMRdhZs0f6XLx/rWHXY04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nD2oGsSmqPHY1NPZgD0fNneyqyttgPxZ7rgb5DM9vIc405XZkHyypPiVyWFHAdlQE
	 QONVlKAOs3cX3uFh5cAVWjPPged/fGttDSU5v1K82adyp4g8EWhEjVHagqZd7YX5Xi
	 NkJ2wnzw6kX5Y/ESYiAQDr4rLfkiVE4BOcx77HP9++gs9w79iMaySv2IkpZGmLxZUT
	 +BTZk4u7THa5a2iYuksRCobrnEVKunXJyFXoSpkXT/hOFB0YLLVKu5C7K7Pyd7ONsM
	 a4TPtfV8N+X/rlAnN4PPkt58aDZ5Zkd/Rs/rsvkFp4/tEYjhewKYWfWelobJzjLP4k
	 E1s0nej+mj5Hg==
Date: Mon, 10 Aug 2026 14:29:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v10 3/7] r8169: add support for new interrupt
 mapping
Message-ID: <20260810142928.0e53be5b@kernel.org>
In-Reply-To: <20260803021305.488-4-javen_xu@realsil.com.cn>
References: <20260803021305.488-1-javen_xu@realsil.com.cn>
	<20260803021305.488-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 10:13:01 +0800 javen wrote:
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +	int work_done = 0;
> +	int message_id;
> +
> +	tp = netdev_priv(dev);
> +	message_id = napi - tp->rtl8169_napi;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget, napi);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	rtl_tx(dev, tp, budget);

This seems not to be ring aware? Is that because we can only have 1 Tx
ring at this point? maybe add a comment to this effect, it's somewhat
unusual.

> +	if (napi_complete_done(napi, 0))
> +		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));
> +
> +	return 0;
> +}
> +
> +static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	if (napi_complete_done(napi, 0))
> +		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));

Why are we using a NAPI for "other" ? NAPI is for packet processing.
This handler only acks the IRQ and does nothing (even after all the
later patches in the series, AFAICT) so why schedule the NAPI in the
first place, and not handle all the work in the IRQ directly?

> +	return 0;
> +}

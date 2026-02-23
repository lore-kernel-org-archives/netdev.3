Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E6365A05
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848145; cv=none; b=DWgPQppCEVWPhcB5ooHi27KMBIHV7lNz2Wb5sspa5sysJc7RNt+eAG4cG8dYZ3oZ+5U3QeSIn/8bBoYzfSGx84g1MGr6tPeRLvP3ztiYg1KVOpiO/DYtE2yVeBcy4I4tE/R8BW/o/MQnaww3TNrnZsJp4taDzJqM92IU+YjaBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848145; c=relaxed/simple;
	bh=Blh1NBTkxgRNMKBaHXCO+dq7e3iDsyx+md/K/l4a6pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOgi3JMiu/+3VvoxlHPSB+0jb2mnaYhyAQQPFpwjOZoDRwryGJ7XXp8jc2xeV36Ns22/GOpDWXFB/9JgVDV5gWPmpXxrJ4IIbHFWSkdqML+QdtC8iEbs80bgC1Sy/3pf5+Cv0StJHnBZCzLeInby2T/ckQxCcqX5Em+JAtlp/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Gxs6x5Q2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gxs6x5Q2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FZeUGH/lmPkQ+aeDfJvyUvyarahPQUbQ9ViirgESqgY=; b=Gxs6x5Q2sBIHtbQll5mAdrsGBm
	J4P9x9KB/tX37XqPK4lBQryeVq6NUEhPoDX4QwdXf6U/EFspdkh16tAzSkumSHp+0Rxj1sqjixwD3
	KpukrfPP9FYZAIJx/o02MWXvn15FLyXeoi1h5oXsZI+w/ORFLDdoY7EYuuLo8lXGaWeAPDvASB7P1
	T4u505EgKjPIvR8SUF7UhwVgQIH5ixMUafdhKPaPHnO5DUm21gqRA6A/8yTBMKxq2UySOaA140mU1
	IopUAWJBYAMwHMrkkwztI87Af7gsy6mjhs6f+NVcEH44BydI8LTFPQxNGJ3SmFjMah649oL1K7R9D
	xh4B3CUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43120)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vuUdl-0000000041f-1xCY;
	Mon, 23 Feb 2026 12:02:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vuUdj-000000007LS-0fmz;
	Mon, 23 Feb 2026 12:02:15 +0000
Date: Mon, 23 Feb 2026 12:02:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: use circ_buf helpers for
 descriptors
Message-ID: <aZxBxoq8_QUzUcud@shell.armlinux.org.uk>
References: <aZw86hpjQ-3w3xqJ@shell.armlinux.org.uk>
 <E1vuUJu-0000000AfEO-2kPP@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vuUJu-0000000AfEO-2kPP@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 23, 2026 at 11:41:46AM +0000, Russell King (Oracle) wrote:
> @@ -4571,8 +4562,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* If we only have one entry used, then the first entry is the last
>  	 * segment.
>  	 */
> -	is_last_segment = ((tx_q->cur_tx - first_entry) &
> -			   (priv->dma_conf.dma_tx_size - 1)) == 1;
> +	is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry,,
> +				   priv->dma_conf.dma_tx_size) == 1;

Bah, I thought I fixed that, but it seems I merged the fix patch into
the second patch not this patch. :/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

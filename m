Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF629463;
	Fri, 14 Aug 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715798; cv=none; b=AWeJSiD5lOfaqZXX5/5Z8oqUjTD1gaUyG1GNm+Rs4re76jNJYUAHRcfiPgdC4wBXxNJsjNe8GKQfocnn7vxXHo6OtWc8vXwFoGaqSlGh+v7jOy3Jqr12Hf35MY6eZipjFl2VH5e3MnzLCcY49X1QO+vLAjViVxkb+K9daFx62go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715798; c=relaxed/simple;
	bh=EoCsd4IRg5rBanxrSCv9dZ0XRhHzFJr6rVPsVrU5GY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut2Oq9gvzgrJHAXiELKuDd4Z+wud3HnCiMFkRdcqh0ibr0jNGuWdnwowuBinXS4khYzNGsb10i0+9NJKRR5jEje9dzBG2cXPKrOQG4WCATQ1BN3n4Uouan1CZ6MrtP8sV9Clf7LXEId4qzPrLGt5EWr+wHFaQwS4XE0z0l9DM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nRfzlqLl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nRfzlqLl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f8cez0dNwC6XFSTElHJVt3452UL2y+uFiU7Rh2pSAK0=; b=nRfzlqLlTUAcsxu6852rtdj766
	kFDKRwXmUxkIymANzF/594YOMSYUJZynRuHd0hVe1IPwCjFy/8m+wLE2OdBLyoEAr+AHHx61ga81A
	YZsmWmL4GUrnyPLupofLNTb1pcU5MgALqa2cZW7eejGF40mNhhd2j3ANI42vCmKsVX4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wusOU-00Hagl-Vr; Fri, 14 Aug 2026 15:56:22 +0200
Date: Fri, 14 Aug 2026 15:56:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: fec: support RX flushing via
 fsl,rx-flush-queues
Message-ID: <d40f618a-8c04-42a2-904c-00cdb14ff988@lunn.ch>
References: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>

On Fri, Aug 14, 2026 at 11:08:59AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The FEC/ENET controller can flush frames that get stuck at the head of the
> RX FIFO because their destination ring has no empty buffer descriptor
> (RxBD[E] clear or ENET_RDARn not set). Without flushing, such a frame blocks
> the FIFO and stalls reception on all queues; with flushing enabled the
> offending frame is discarded instead. Flushing is configured per RX queue
> through the RX_FLUSHn bits of the QOS Scheme register (FEC_QOS_SCHEME).
> 
> This series adds a device tree property, fsl,rx-flush-queues, listing the RX
> queues for which flushing should be enabled, and programs the corresponding
> RX_FLUSHn bits.

DT described hardware, not policy for how hardware is configured.

Maybe use an ethtool private flags?

> Erratum ERR050395 (e.g. i.MX8QXP) can lock up the RX path when flushing is
> enabled on more than one queue at the same time; recovery requires a full
> ENET reset. Rather than encoding that hardware limitation in the binding,
> the DT property is kept generic and the single-queue restriction is enforced
> in the driver: a configuration enabling flushing on multiple queues is
> rejected unless the controller advertises FEC_QUIRK_HAS_MULTI_RX_FLUSH.
> Future parts with the erratum fixed can set that quirk to allow flushing on
> several queues.

We generally avoid adding features without users. I would suggest
leaving FEC_QUIRK_HAS_MULTI_RX_FLUSH until such hardware exists.


    Andrew

---
pw-bot: cr

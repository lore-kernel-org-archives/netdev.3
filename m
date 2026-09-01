Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9623CC7DF;
	Tue,  1 Sep 2026 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231962; cv=none; b=HdkJ3a7QxXxZ+4ewIFmNmHwDB+DwqwAjXRDm1qO4iuOG3hh1Tu0pYYYEI4GkMSpBb9xRMbCnPEQVq2Ky23jN0am3/H6okc6C3ejVtrayYt0LboBtaVldT4+7t2j7BuER4Fnq1yFCSk5Zai1lQT1xFPhkX7bQpi84IWu3VkG5F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231962; c=relaxed/simple;
	bh=ABZFUwYhFhIoHEraEjchVne7McbVBhnaI/sZtZckc70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0j7GrYUZ5nAnr3bZTfx7ulYVW/2k2sf/Qlo7W96PcHWqhs9H+l9q6JXSj3cHO8YK55763r33hwKrb8P4GxxETtULN/cuXWhXWc2qjiokapNWfkKlKaXz+ZngkFxS7DFA/2O3wuOUmfSYefCTsaULlTY/qgoecQX5njxWofQZbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jMI6fJ/S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jMI6fJ/S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k84NDGMsq/Kto9RzKtWIVCVX3P/YTWj6KJ7tWB1oRjo=; b=jMI6fJ/SkQfRbUomapZSzpP1h9
	n4ujLooQNjPdcWzpKNHt17/fz3ChFKXlHlp3w+3z6H5nIPUIOMqFot6u8fiwJBfYRVbtQeLtyONcI
	0PGbPDTRnWzdDs3ekl+VMBwsVHBv3IDHOZ56D7MXywj7z5NuVVkQpehYXqCFfBpaG1WQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Eon-002IGK-9E; Tue, 01 Sep 2026 05:05:49 +0200
Date: Tue, 1 Sep 2026 05:05:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Message-ID: <123a8343-9912-4b57-a402-08bc18748ff7@lunn.ch>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-4-wei.fang@oss.nxp.com>
 <bd07a661-857f-421a-9ff0-e807aade9543@lunn.ch>
 <GV2PR04MB117396D2988C68C961868A8F388A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB117396D2988C68C961868A8F388A82@GV2PR04MB11739.eurprd04.prod.outlook.com>

On Tue, Sep 01, 2026 at 02:31:21AM +0000, Wei Fang wrote:
> > > Add link status message support to the PF driver using three command IDs
> > > under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):
> > >
> > > 1. ENETC_MSG_GET_CURRENT_LINK_STATUS (cmd_id 0)
> > > The VF queries the current PF link status synchronously. This command is
> > > not used by the Linux VF driver but is intended for DPDK-owned VFs.
> > >
> > > 2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER (cmd_id 1)
> > > The VF registers for link change notification. Upon registration, the PF
> > > immediately notifies the VF of the current link status via a PSI-to-VSI
> > > message, and continues to do so on every subsequent link state change.
> > >
> > > 3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER (cmd_id 2)
> > > The VF unregisters from link change notification.
> > >
> > > For link status message, the PSI-to-VSI message is 16 bits wide: the
> > > upper 8 bits carry the message class ID, and the lower 8 bits carry the
> > > class code. Bit 0 of the class code indicates the link state (1 = link
> > > down, 0 = link up), and bit 1 indicates whether TX PAUSE is enabled on
> > > the PF (1 = enabled, 0 = disabled).
> > >
> > > The TX PAUSE state is included because VF RX BD rings support congestion
> > > mode, but whether the hardware can actually send PAUSE frames depends on
> > > whether TX PAUSE is enabled on the PF. By conveying the PF TX PAUSE state
> > > in the link status message, the VF can determine whether to enable
> > > congestion mode on its RX BD rings.
> > 
> > I see you have hit the 15 patch limit. Do you have a patch in the next
> > series implementing ethtool get and set pause?
> > 
> 
> No, we do not have the patch to support ethtool get and set pause for VF.
> The link is controlled by the PF, including TX PAUSE-related configurations
> (ON/OFF/refresh threshold and PAUSE Quanta). The VF can only passively
> decide whether to enable congestion mode based on the actual link status.
> Adding an ethtool set pause interface to the VF is meaningless because it
> cannot control the link or configure TX PAUSE, , or rather, it shouldn't control
> these.

Well, get will return what is actually happening. That could be
useful.

And from what you described, it sounds like the VF has the option to
not enable congestion mode, i.e. not send pause frames. So you can
implement a limited set, returning -EOPNOTSUPP under many conditions,
but still allow some control. But it might not be worth it.


      Andrew

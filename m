Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282143498D;
	Sun, 27 Sep 2026 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534325; cv=none; b=ayNFUX3EZt1bDlCzofMN0HjxBa4vyB1ndUCS0oi24pOgJI/BnXhR3Bm1XKHMYQ1W2/4/6DdZhdyAw7zb8XyShBUpbCNhRGTovbCive9kiVpi48cQp5om5OcaD7D2UUOUfdATIKGZBZ6MYh3Ww7+USIhQ2UiogYcp8511D0uNPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534325; c=relaxed/simple;
	bh=7VwCPJXIl1DZREwzaocu6/b4CQstVLqSAsqnBIXaTRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS2YmmE9X9lkSQlD1ULgfiT4pgig7MtLuRbintyy8FSPYtllUhVHi2u/e1sgaMR6G7WzE7KqoLArcHPOKWNZTZvqw3c7sIv9bHVaBaNxQn6nxSSfsmEJxMbZ0kaUqjB3gxxzRUazMAwyFWuFNrJG36F6K3IrnzIYFBSRI72Dfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0oiBAMYk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0oiBAMYk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OTg5xcZvym53tCIzrtP6CDECKJFSHZAlLWkULrpXCH8=; b=0oiBAMYkUpxDpPZiBC5aRxT1KT
	QdsVejldkNSEec1pcnbnkqlW0QhHbBGLMxjtKVvmrMCBlci/vGZXskccemr3jUa7DnQ/oMBgL7ywt
	Vs6SRsyqlujyyKUSwJ0kvI069xqlMUlLb7TSSV69XfGTkdXXI8rV+Aa4aarvRE+afAt0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAtlj-007YLY-Rt; Sun, 27 Sep 2026 20:38:35 +0200
Date: Sun, 27 Sep 2026 20:38:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v11 4/4] net: phy: restore the interrupt when the
 generic bind cycle fails
Message-ID: <b1bd8944-2a0a-4140-ace0-0bc9a771c33f@lunn.ch>
References: <20260926235024.705646-1-f@lex.la>
 <20260926235024.705646-5-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926235024.705646-5-f@lex.la>


On Sun, Sep 27, 2026 at 02:50:24AM +0300, Aleksei Sviridkin wrote:
> phy_attach_direct() binds the generic driver by hand, and the probe it
> calls is phy_probe(), which replaces phydev->irq with PHY_POLL before
> either point the hand-bind can fail at. That failure unwinds on a label
> of its own, which does not go through phy_detach(), so the substitution
> outlives a bind cycle that never completed and a later attach finds a
> PHY that can only be polled. Found on a Keenetic KN-1012 while placing
> the restore of the previous patch, as the other exit of the same bind
> cycle.
> 
> Save phydev->irq on entry and put it back on that label. The unwind runs
> inside the call that made the substitution, so the value from before it
> is known exactly. The bus table the previous patch reads from would be
> wrong here twice over: it does not hold a PHY_MAC_INTERRUPT that a MAC
> wrote into phydev->irq alone, and the label is also reached when a
> second attach of an attached PHY fails its bind, where the field is
> live.
> 
> The store is not ordered against a concurrent bind: this unwind, like
> the hand-bind it undoes, runs without the device lock that
> device_bind_driver() asks its callers to hold.
> 
> Fixes: 6d9f66ac7fec ("net: phy: Fix PHY module checks and NULL deref in phy_attach_direct()")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> 
> Notes:
>     Both points the hand-bind can fail at are reachable. phy_probe() reaches
>     genphy_read_abilities() through genphy_driver's .get_features, and that
>     returns the error from phy_read(phydev, MII_BMSR); device_bind_driver()
>     returns whatever driver_sysfs_add() got, from either of its two
>     sysfs_create_link() calls or from the coredump attribute.
>     
>     A failed genphy bind leaves the device with no driver bound at all, so the
>     next driver to arrive binds directly and never goes through phy_detach().
>     That is why patch 3 cannot cover this path, and why the Fixes: tag here is
>     6d9f66ac7fec rather than the one patch 3 carries. That commit did not
>     introduce the lost number - the substitution is far older - it created this
>     second exit from the bind cycle, splitting the failure off the label that
>     calls phy_detach(). Before it, patch 3 alone would have covered this, so
>     that is where the backport range for this one starts.
>     
>     Exercised on the board described in patch 3, with a debug-only module
>     parameter that fails the hand-bound generic probe once for one MDIO
>     address. The connect then ends in -EIO rather than the -EINVAL of the
>     validation path, so the unwind takes the label this patch touches.
>     Measured again for this version, since the value now comes from the
>     local: two images of the distribution's 6.18.52 kernel differing only
>     by this patch, injected failure at 2.0 s, real driver bound at 6.4 s.
>     phydev->irq afterwards reads -1 with patch 3 alone and 15 with this
>     one; the three switch ports read 79, 80 and 81 in both.
>     
>     One difference between the injector and a real failure, since it does not
>     affect what was measured but should not be implied away: a genuine error
>     inside phy_probe() leaves through its out: label, which re-asserts the PHY
>     reset before returning, while the injector returns earlier than that.
>     Neither path touches phydev->irq.

Again, way too much text.

	Andrew

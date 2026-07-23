Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCF47884C;
	Thu, 23 Jul 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810896; cv=none; b=jQlwE6nzrgU6jFya9UVV4euspptemS3mESZLsSalpeTwJa79iaLYCEPZp35lvFM9Je5injvyVy7ilBZRL+SIrmlHncof9xb4eYOuEv4zBzThvVrt3rzImwQp1HhTr5pycpj8ux8dbnxKkvWSnRqGvfSegEyB8CztENKGMB6xyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810896; c=relaxed/simple;
	bh=HoVPmFAr+Gdy4bSVjtdflTs+LtfUrqG7WNBH2y+0Mdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOhjbI3yYyLiUeYF3rfE2zmrZCcMBT0FMOlDmDwNoAwzSLi2UFzjknpk3fTjTEceXRG6F2sbOMyfKVMSWHj9YOmAkcQcDWqxFzFReUpvJvhDL1F738ZQq9o5iVuRO3iHgK6vES8LS/vBQzJd/ifpJAfBrhQc3Ilsk/TZPo//EzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wOtgssmz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wOtgssmz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GxWL9DkCse6W8g3cZqDt689AFIwASoWaw4D5zrXQsuY=; b=wOtgssmzQozW9mm+UPNWCkKtgj
	mgCZ12JHjrqSme2U3Y0W8wCxrgaEUSpNnHPvConch80wVeiVIADSuMI7c0jKMWyjFkK02X80qAwcw
	dYVW2Pb4q4bKEr3vs4VCv9F+iRGFPAFU8l0lQ5spEx/UkH+ObDYmSdkCKeBBzpIJsUK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmsqB-00Dob2-K0; Thu, 23 Jul 2026 14:47:55 +0200
Date: Thu, 23 Jul 2026 14:47:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: Re: [PATCH net-next v7 2/7] net: phy: phylink: add helper to modify
 pause
Message-ID: <7503ed7f-5f89-438e-b43a-5c5b466ca1ef@lunn.ch>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-3-javen_xu@realsil.com.cn>
 <8a90be50-8a45-4a27-a0a7-adfd1156c30e@lunn.ch>
 <65141a327af44b938ba2fb94e3344da3@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65141a327af44b938ba2fb94e3344da3@realsil.com.cn>

On Thu, Jul 23, 2026 at 02:50:46AM +0000, Javen wrote:
> 
> >
> >> +/**
> >> + * phylink_update_mac_pause_capabilities() - Dynamically update MAC
> >> +pause
> >> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> >> + * @mac_pause: the new MAC pause capabilities mask
> >> + *
> >> + * This function allows a MAC driver to dynamically change its pause
> >> +state,
> >> + * such as losing/gaining Pause frame support based on MTU size.
> >> + * It recalculates supported link modes and triggers renegotiation if needed.
> >> + */
> >> +void phylink_update_mac_pause_capabilities(struct phylink *pl,
> >> +unsigned long mac_pause) {
> >> +     struct phylink_link_state *config = &pl->link_config;
> >> +     unsigned long old_pause;
> >> +     int pause_state;
> >> +
> >> +     ASSERT_RTNL();
> >> +
> >> +     if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
> >> +             phylink_err(pl, "Attempted to dynamically change non-pause MAC
> >capabilities\n");
> >> +             return;
> >> +     }
> >> +
> >> +     old_pause = pl->config->mac_capabilities & (MAC_SYM_PAUSE |
> >MAC_ASYM_PAUSE);
> >> +     if (old_pause == mac_pause)
> >> +             return;
> >> +
> >> +     mutex_lock(&pl->state_mutex);
> >> +
> >> +     pl->config->mac_capabilities &= ~(MAC_SYM_PAUSE |
> >MAC_ASYM_PAUSE);
> >> +     pl->config->mac_capabilities |= mac_pause;
> >> +
> >> +     phylink_set(pl->supported, Pause);
> >> +     phylink_set(pl->supported, Asym_Pause);
> >
> >I don't know the phylink code very well. Could you explain why these are
> >unconditional? It is not obvious to me.
> 
> Thanks for review.
> The unconditional phylink_set() is required precisely because of how phylink_validate() works. It acts as a necessary "reset" to prevent the permanent loss of capabilities in pl->supported across MTU changes.
> Consider the following scenario when MTU changes:
> 1. MTU 1500 -> 9000: The MAC loses Pause support. mac_pause becomes 0. When phylink_validate() is called, it correctly clears the Pause and Asym_Pause bits in pl->supported. This happens in the function call trace phylink_validate()=>phylink_validate_mac_and_pcs()=>phylink_validate_mask_caps()=>linkmode_and(supported, supported, mask), where mask represent the capability.
> 2. MTU 9000 -> 1500: The MAC regains Pause support. We update mac_pause back to 1. But if we simply call phylink_validate() at this point without unconditionally setting the bits first, it will take the current pl->supported (where Pause is 0 from step 1) as its input. The Pause capability will be permanently masked out and never restored.
> By unconditionally setting them here, we restore the baseline to 1, allowing phylink_validate() to correctly decide whether to keep them or clear them based on the current PHY/MAC capabilities.
 
Thanks for the explanation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

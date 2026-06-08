Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157639184E;
	Mon,  8 Jun 2026 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904292; cv=none; b=oRlpSFq0ro1y1xt43Ng6sUuPhR7Y9QnBKizlrnDjYXWEa0ZewTgkjnuodXFwUMSB4CaFflyTBlTU7eif4v7zw+UcqFEg+SEzz+5FzH7Z02CRAcvU5A7rdizV7fnroj9GWhyeZr5VCVtncAeTK7RkKui1eE4Fzn/XU0r2KYd0080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904292; c=relaxed/simple;
	bh=TVkMFcWkpvN5dTT8PMKDF0D2FnQHyxW4UR3JKyAZkEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lARC7gCxG/NuMYTPRjKu7gJ+SoyCxxsGdNVyjVwe5dzFcJLldQG3hvIbJMFUukk7RF/PZy3M3elJUSG4o4FftLevFkykbSuaJ/DGKjvpqryxd0LImeXg6Sd9aKB19ppcCEGoRF7R5uLCiXKbUckDqiYFM9gtAx3cvWDeJZ0gj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xOGl3xVl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xOGl3xVl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uTEjW5smUv6BjOmVV42s9eCMcV2UCVsoxTFJQmZ5qEE=; b=xOGl3xVl77o2u+r2MjoshtVyVp
	rTHyOxL/m+Sm70FywOwwZprDCD+oIjEa+8mQdfZZdhry7XSHV4EZbJyD+/XDl7TPl2lKoVFjp8Wlh
	ud+tIEHEUed2VhnjMgrF7Jy5pZVOEjwteADzsuc3OnEqJsRTs1CEdSDVjPt/urDj/y98=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWUYW-006a1p-6R; Mon, 08 Jun 2026 09:37:56 +0200
Date: Mon, 8 Jun 2026 09:37:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Message-ID: <282e4c64-a088-4602-b053-7a8e1cd32c5a@lunn.ch>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-5-javen_xu@realsil.com.cn>
 <5005c1c3-d807-456d-a9a0-c77bde9f437e@lunn.ch>
 <b54b5f3a6703498fbc17e64548550ba0@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54b5f3a6703498fbc17e64548550ba0@realsil.com.cn>

On Mon, Jun 08, 2026 at 06:32:19AM +0000, Javen wrote:
> >> +static bool rtl_is_8116af(struct rtl8169_private *tp) {
> >> +     return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
> >> +             (r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
> >> +             (r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
> >
> >Do we know what these magic numbers mean?
> 
> 0xdc00 is a package-detect field. 0xd006 is internal HW id. RTL8116AF shares the same RTL_GIGA_MAC_VER_52 mac_version with other variants. 

Since you know what they are, please add #defines.

> >> @@ -2509,9 +2543,10 @@ void r8169_apply_firmware(struct
> >rtl8169_private *tp)
> >>               tp->ocp_base = OCP_STD_PHY_BASE;
> >>
> >>               /* PHY soft reset may still be in progress */
> >> -             phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
> >> -                                   !(val & BMCR_RESET),
> >> -                                   50000, 600000, true);
> >> +             if (tp->phydev)
> >> +                     phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
> >> +                                           !(val & BMCR_RESET),
> >> +                                           50000, 600000, true);
> >
> >Maybe this all needs to move into the PHY driver?
> 
> This is after firmware application. And PHY_MDIO_CHG opcode switches the access callbacks between PHY and MAC accessors.
> data == 0: phy_read/phy_write
> data != 0: mac_mcu_read/mac_mcu_write
> So the firmware may contain mixed PHY and MAC.

Normally, the MAC does not touch the PHY, it only calls phylib/phylink
API methods. If standard MII interfaces are used, you can connect any
MAC to any PHY.

If it is all integrated into silicon, then there is no choice, you
know the MAC/PHY relationship. However, it is still good practice to
keep MAC code in the MAC driver and PHY code in the PHY driver.

Can firmware programming be moved into the PHY driver?

> >> -     rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> >> -     if (rg_saw_cnt > 0) {
> >> -             u16 sw_cnt_1ms_ini;
> >> +     if (tp->phydev) {
> >> +             rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
> >> +             if (rg_saw_cnt > 0) {
> >> +                     u16 sw_cnt_1ms_ini;
> >>
> >> -             sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> >> -             r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> >> +                     sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
> >> +                     r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
> >> +             }
> >
> >Can this move into the PHY driver?
> 
> It reads a counter from PHY, but the calculated value is programmed into MAC OCP register via r8168_mac_ocp_modify, which accesses r8169 through tp->mmio_addr. So I think this can not be moved.

So, big picture, what is this doing? What is rg_saw_cnt?

	Andrew

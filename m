Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12AD3B38A2;
	Thu, 24 Sep 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259793; cv=none; b=ZDYs2mrhKY3kBL4PNQhMDfWgSzSVYUbgJY5aOBeUjlQo6Uod6reXb3BJpBi0hDYdM1OxmNXnthq7H8qGItqzDN5gX4/UxaVtRyd7YTNGrd5nJzLtmIUhxMeg0gqD+/ZAtaoBN7RhoYl93GS7eI+tivVho9D24bLdFekPUUd7vcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259793; c=relaxed/simple;
	bh=xah4ZcXmrsRfaouOuM6ZH2DS9ISNzEEqfSLi/nVnWgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWQ7Ws2u1QHxWy4O49hLpoCBd+H6AlIVx9R3kI8Vwc+h0Of2Kj9yRrLMA7+loODLF4jri//fbl/nKikXPK/IFCIQ/nIIDsVw4XQu/C0XqQc29kvRa9PLiAC6oUcnpu8EBm6mTdNZVpGbM2UwoOq0LfCVxXrePjZajuhKKG/eTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dhyr7+gS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dhyr7+gS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YRxCDaMEMjeNgmx5T/EVuTSh67LGdojGLOrhCwhCev0=; b=Dh
	yr7+gSHaRcEawD7cbrPt+q4UONwcYADUgJw5JgqaWvylNf7fjebTq0uJd6Xd1kOR8rR4fr5fHTz/h
	guuO87WuXQ4NjRbeV/YfXysiOAVl499MxPqbJlKGfWhJUGIxu2mFFt5LbUu3EMwTHsjckS6ETztzH
	HgxnZPvLRiN484Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9kLf-0070ej-GP; Thu, 24 Sep 2026 16:22:55 +0200
Date: Thu, 24 Sep 2026 16:22:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
	mohd.anwar@oss.qualcomm.com, maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: stmmac: support low-speed USXGMII validation
Message-ID: <66dbb6d5-5e2d-49fb-a882-acd67eb6fcea@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
 <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>
 <828e6cff-79d2-4349-805f-cca927f7b908@lunn.ch>
 <CAFkd8htx-MTOMFO1S3uZt_8wyL+qoOhb577O2MMYr6oJ9jc=vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFkd8htx-MTOMFO1S3uZt_8wyL+qoOhb577O2MMYr6oJ9jc=vg@mail.gmail.com>

On Thu, Sep 24, 2026 at 06:39:47PM +0800, Zhangfei Gao wrote:
> Hi, Andrew
> 
> On Wed, Sep 23, 2026 at 8:58 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > > index 091c9b57388fa..58ca296fc4420 100644
> > > --- a/drivers/net/pcs/pcs-xpcs.c
> > > +++ b/drivers/net/pcs/pcs-xpcs.c
> > > @@ -23,6 +23,12 @@ static const int xpcs_usxgmii_features[] = {
> > >       ETHTOOL_LINK_MODE_Pause_BIT,
> > >       ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > >       ETHTOOL_LINK_MODE_Autoneg_BIT,
> > > +     ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > > +     ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > > +     ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > > +     ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> > > +     ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> > > +     ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> >
> > What does T in 10000baseT mean?
> >
> > >       ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> > >       ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
> > >       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> >
> > Compare and contract with KX.
> 
>  T denotes twisted-pair copper media, whereas KX/KR denote backplane
>   Ethernet modes. USXGMII is the host-side interface between the MAC/PCS
>   and the external PHY; it is not itself a media type.
> 
>   The BASE-T modes are needed here because the attached PHY reports its
>   line-side capabilities as BASE-T modes, which must pass XPCS
>   validation.

Now think about why i asked. It probably means something is wrong.
But i will admit, there is a possibility i'm wrong, but you need to
first exclude all other possibilities and give a clear explanation why
i'm wrong.

The question should point you in the correct direction. You should not
do the minimum hack to make it work, you need to spend the time to
understand the architecture and find the correct way to do this.

	   Andrew

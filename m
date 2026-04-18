Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653A2D0610
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525921; cv=none; b=BIJcJRf7L+59pQvBkD/VEURxD11+pkr6K9l9O10L4RBytRoMNn7sgCP1ENMe9A2wN0c/jAhWEzc1FhKynExK4HXVUFb4nn8jlX5abnuD5yftpaFpyCVodqqckXFJaa1d8fv/fR1VLdtq6Qv0aciUey264y3bnav3Q4f9bx8Daok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525921; c=relaxed/simple;
	bh=W5nVI+jZg1YYpjL8ZRJUftTl4ocHKRAfwV5edyIa7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwsPy9JfjtGUEXoFSJl9Bm7IQx69m5yQFu618wcLPLFqalxAuTMfK3RLx7P+LJu0dDB+VhHVTURgJbIekUkl3OhLODtaMr+c+57nO2Lcdhz2b28BQtGMHJtTR3U6q4w5jBV2XFfvVsVQGxYn6IQf3Xc41V33mc/uPxOn55LH0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ODaHkYGM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ODaHkYGM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6mqB7iPguycy+udGR9zGMcDwQcuQvszIe0zBJRObhVo=; b=ODaHkYGMR+eH0dHHh+Tc9eW22a
	pIBJ/eIvh/8j0Ezasui/y5mRoBhzdEPZMfRyFoatJLWr/moRWNuFqAg5IeQdUK2WC5KPMaOyDZPKV
	JeRZmsPoXsPyW0QlF+3gVnPq5voFCKpGxr7fD8hUJ2S7Yghn5lmffr0dVfJxFX86M7GM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wE7Xg-00GZ7q-Da; Sat, 18 Apr 2026 17:25:08 +0200
Date: Sat, 18 Apr 2026 17:25:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: markus.stockhausen@gmx.de
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, netdev@vger.kernel.org,
	'Jonas Jelonek' <jelonek.jonas@gmail.com>, jan@3e8.eu
Subject: Re: pre-boot plugged SFP autoneg advertisement
Message-ID: <90958cc3-e291-44ff-8fc3-102c0f62a269@lunn.ch>
References: <007c01dccf15$9b4622c0$d1d26840$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007c01dccf15$9b4622c0$d1d26840$@gmx.de>

On Sat, Apr 18, 2026 at 11:27:40AM +0200, markus.stockhausen@gmx.de wrote:
> Hi,
> 
> I'm currently analyzing an issue where a pre-boot-plugged SFP module 
> comes up with autoneg=no advertisement during boot. After an
> unplug/replug autoneg=yes advertisement is chosen. 
> 
> The following addition in phylink_start() just before the call to
> phylink_mac_initial_config() mitigiates this.
> 
> +  /* If an SFP module was already present before phylink_start() was
> +   * called, phylink_sfp_set_config() was unable to call
> +   * phylink_mac_initial_config() as phylink was not yet started.
> +   * Ensure the SFP capabilities are reflected in advertising.
> +   */
> +  if (pl->sfp_bus && !linkmode_empty(pl->sfp_support))
> +    linkmode_copy(pl->link_config.advertising, pl->sfp_support);

Let me see if i have the call chain correct. This is net-next/main
from today.

phylink_sfp_connect_phy() ->
  phylink_sfp_config_phy

        if (changed && !test_bit(PHYLINK_DISABLE_STOPPED,
                                 &pl->phylink_disable_state))
                phylink_mac_initial_config(pl, false);

You are saying PHYLINK_DISABLE_STOPPED is set, so
phylink_mac_initial_config() is not called.

What i don't see is how phylink_mac_initial_config() does the
linkmode_copy() you are adding.

	Andrew

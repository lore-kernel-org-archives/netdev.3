Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A752363C5A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139005; cv=none; b=MrPt7y0PkXVCC96/AH3ZT2rc25prwMn7LtDr70kWbbH6Yvf54q3wCsufFw8U+QQAX+w8A8J/CyDZ8xosXF4ULKgKwOJ8NdoGPLHubfxBoD0y+pOQ1z6QpyBbGVRX0AE/rmoOgWeRCWn0+11ves2b9pcLYILwApOQoS7Ii392suQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139005; c=relaxed/simple;
	bh=QxJMvDHxq82qzxy4jnY3B8n/JyI+m2wDK8Q7aEujCIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uznIpo0AWZdRgjmxzEilXEFemCTKuHVIPXLXzY8hi2Qw7PUtPL3/CuPHVCIO6yA0W+PN78cHOCAsk4XtHDxev+03rzH8FcPIONw7skqtc84tM6bEx0MushZyzIRXp2AbgWWnhJH/7nPT2SOJeEn7WoEjwrjpJYTjwy6yxkkDy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1+3y90R4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1+3y90R4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f9OGokTb+oWF8abAe1YQnY6SQqqGbHVINcCV5udrCr8=; b=1+3y90R4dGDhrkDwermBjzPPDS
	sJNuEXVX1pQh8HO2inmI6b5Tb0ZzjqGwGG7ie1GSEWt7Qvy/e/nZGDBj+cM7XDdNu32s8YDlecEYg
	1EZz3W6UWn+RyvUDzdHgjxT5aZvC4HdZXxWKdcEdvPgxe/vmEtNdyp7wqH2Az6VYfISw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsSLZ-00Ge07-Fv; Fri, 07 Aug 2026 23:43:21 +0200
Date: Fri, 7 Aug 2026 23:43:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xander Wilmink <xwilmink@gmail.com>
Cc: netdev@vger.kernel.org, Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH net-next] net: sfp: Add quirk for Dell M14MK module
Message-ID: <5c5ba685-242f-4699-9933-87910a251ff4@lunn.ch>
References: <20260807213025.1206-1-xwilmink@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807213025.1206-1-xwilmink@gmail.com>

On Fri, Aug 07, 2026 at 09:30:25PM +0000, Xander Wilmink wrote:
> Greetings,
> 
> This adds an quirk for the Dell M14MK (S28-10G-25G-SR-85C) SFP28 module.
> These are short range fiber modules, and should advertise 10000baseSR/Full.
> Incorrectly these advertise as being a copper module: 10000baseCR/Full. 
> The link fails to come up, and the kernel logs "unsupported SFP module: 
> no common interface modes."
> With the quirk added, the 10Gbit/s link comes up.
> 
> Tested on a Linksys LGS328PC with OpenWRT SNAPSHOT version:
> OpenWrt SNAPSHOT r35298-2a73f02e56 / LuCI Master 26.190.71895~a18dc50.
> Ethtool advertises now "10000baseSR/Full" and the link works on 10Gbit/s.
> 
> Thank you for your time.
> 
> Kind regards,
> 
> Xander Wilmink

The commit message should be formal, since it becomes part of the
Linux kernel. Please remove the Greetings, Thanks, Kind regards etc.

> +static void sfp_quirk_25g_10g_dual(const struct sfp_eeprom_id *id,
> +				   struct sfp_module_caps *caps)
> +{
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
> +			 caps->link_modes);
> +	__set_bit(PHY_INTERFACE_MODE_10GBASER, caps->interfaces);

Do you need to clear 10000baseCR/Full here?

Does it get the 25G part correct? The quirk itself is only touching
10G, so the _25g_ in the name seems irrelevant.

    Andrew

---
pw-bot: cr

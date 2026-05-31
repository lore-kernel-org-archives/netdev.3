Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A018E02A;
	Sun, 31 May 2026 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240595; cv=none; b=P3rabKuQTH5O50PJpbd6sQihwDE1pFCad2sbdtAkkUq+I9w73VZJAMHK9riz4aIvA8wdZgfhg8fbjc+qKASGLBkTfz6X08425zgwZZR/EIJmHMUR7oni+PtFTbarjOyWkJMuaYYtI8Qu0j/xzOOfN+n1bYk2yGtSu+5rzQFLcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240595; c=relaxed/simple;
	bh=rtGV2fcnUyJdgafzg7UL8lmMf10ULPnr87LKx5eet5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4ogBgliYBSkLXt0VlgmqChMsiO+mJydZWBoAhXrKtq3jJNoYyb7qtKYGliH425ZUJzuO4M57N70aA/oslr1U+BhflMcABbvceWINe9A8jgm341UX7oFMWfV9MLRnfeGlUbYPbl2K0N0nIEKtQcgO48S2AzsKu2x1+B7no73sBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fzqM1V20; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fzqM1V20"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2smaPiGCWotK+PrQMbgVFk7kwk6586ncvWgPVSl4Nbg=; b=fzqM1V20W9GkiM1ae5zMHZ/bmE
	jWjTNnnTnB19DJvNfbOIHB0LaxbeXk3pqlDgFY16D4ojeape6C1atIU4139xLgq7FuflCRxwkMhKS
	lki/xfzJiOt4HT09W3p1kyO4KMMxruNGrtoF0S+IWi9BpHa8/wk4bz90UDCFwUMVb02g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wThto-005N2W-BL; Sun, 31 May 2026 17:16:24 +0200
Date: Sun, 31 May 2026 17:16:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <8331c347-4d40-43ac-aa73-a22398ac76a6@lunn.ch>
References: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>

> +config S2500_MACPHY
> +	tristate "S2500 support"
> +	depends on SPI
> +	select NCN26000_PHY
> +	select OA_TC6
> +	help
> +	  Support for the onsemi TS2500 MACPHY Ethernet chip.
> +          It works under the framework that conform to OPEN Alliance
> +          10BASE-T1x Serial Interface specification.

tab vs spaces.

> +#define DRV_VERSION			"1.0.3.1"

Not used, and probably meaningless.

> +/* Definitions for MMS defined in Table 6 Open Alliance TC6 standard
> + * that not present in oa_tc6.h
> + */
> +#define S2500_OA_TC6_MACPHY_MMS0	0
> +#define S2500_OA_TC6_MAC_MMS1		1
> +#define S2500_OA_TC6_VS1_MMS12		12

Maybe these should be added to oa_tc6.h, if they are part of the
standard.

> +#define S2500_MMS_MII			(S2500_OA_TC6_MACPHY_MMS0 << 16)
> +#define S2500_MMS_MAC			(S2500_OA_TC6_MAC_MMS1 << 16)
> +#define S2500_MMS_PCS			(OA_TC6_PHY_C45_PCS_MMS2 << 16)
> +#define S2500_MMS_PMDPMA		(OA_TC6_PHY_C45_PMA_PMD_MMS3 << 16)
> +#define S2500_MMS_VS1			(S2500_OA_TC6_VS1_MMS12 << 16)
> +#define S2500_MMS_VS2			(OA_TC6_PHY_C45_VS_PLCA_MMS4 << 16)

This kind of suggests we should rethink the API for reading/writing
registers. It should be possible to pass MMS and register as seperate
values, and let the core combine them.

> +struct s2500_info;
> +
> +struct s2500_info {

???

> +/* Initializes the net device MAC address by reading the UID stored

Should that be OUI, not UID?

> +	/* Convert the OID in host byte order */
> +	for (i = 2; i >= 0; --i) {
> +		addr[i] = 0;
> +		for (j = 0; j < 8; ++j) {
> +			addr[i] |= (val & 1) << (7 - j);
> +			val >>= 1;
> +		}
> +	}

That seems pretty complex. What exactly is it doing?

	Andrew

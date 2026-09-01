Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D537883E;
	Tue,  1 Sep 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282270; cv=none; b=CfwzssB9W91srJCoAhjTqCxOWFeVfO3WJ41Tx881RBNKnepiiLZpK1aNFcD2YQij32oxX47I1yglD03dn5FaUZYL+PN4cYfY/L1e1QFWn5x3RwBU+gNK9Lv3r1C59nsssiEEykVIuL4HXsFO/DfkIEEME8j/tvfQ/5EGMVXtC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282270; c=relaxed/simple;
	bh=lSVK6Q4/11UhZFqiVRpu2EMKyLJF8MFriSIuP85+jQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcHxlKMHQyoWG9mYmQ35kgetk9u1TROhkZU7ZVh61BSYcNHpBW5UUb/4c+RfsWa5G/UuebEnm9QpCnqyQ3p08AFt8IUWCCGkpZJA9CfHK4siDtMl/Ii7fF6zYCm33HCepZ88W30hMvi9zqaWwA5cHi/oHTIPtbNR0vDSJ3wxe1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ATX0flCy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ATX0flCy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rEabxmq/j957tmufTTvA5VAdiceGA7UDIb+ZqGI9fDI=; b=ATX0flCy0ePx4xh0Lvd51fEPaC
	xxp5sK0jyRVcwyhkC+X6ohcV76Z5r+/9SeoCCvasnQW9gCJxSKg4QcrfIi5BHAjoUcK4uw7y8yxV7
	1bDF6jIgcTYCW1PJAnUUF1trbf9eu56BW53bLPMmBvc75EDLIQBmBc36a/LnFIKJQWso=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Ru5-002OMC-6m; Tue, 01 Sep 2026 19:04:09 +0200
Date: Tue, 1 Sep 2026 19:04:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mxl-gsw1xx: deassert internal PHY
 resets before MDIO registration
Message-ID: <cccd725b-f47c-41de-a82b-60bc9c66a0cd@lunn.ch>
References: <20260901165049.672446-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901165049.672446-1-alexander.sverdlin@siemens.com>

> +static int gsw1xx_setup(struct dsa_switch *ds)
> +{
> +	struct gswip_priv *gswip_priv = ds->priv;
> +	struct gsw1xx_priv *priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
> +	struct device_node *phy_np;
> +	struct dsa_port *dp;
> +	u32 phy_reset_mask = 0;
> +	int ret;

Reverse Christmas tree.

You might want to pass ds->priv to container_of(). Or if this appears
a few times, add something similar to bcm_sf2_to_priv().

    Andrew

---
pw-bot: cr
	

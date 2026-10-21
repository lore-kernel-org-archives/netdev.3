Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544735;
	b=L2s0PTu3ZWZrtLoVJMOqMKFz6dmUql06n0wG6GKJUPZYET/TY2EnEPGbMwe3kkhuUDSZ
	 1amrdGiuS/jW6y65d+tZvtHqxFi78T+rLMoM27dSRcr5UTQXAcLWBS9DoQ100fjpCFQzI
	 EjRnrVQ4gleAg8A4aeOsfIO3H7BzUDI6y7++8Et/FIBIxRMaQe9z4zx6H6XG2zLLggyXy
	 EiBsUfWIK+EdoHrrTuXJ5Ra42crDoZc2PzXikwIzzn1bDKzQ8bVXYIRDgdsNV16/t4YW6
	 fAsH3ToItJU2hTY2euxyGZhwFB4d9jfN+V/nXXTHlp5jvhIN0wSNaVA/Rbq2lsCAYPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544735;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=yzjZW+qTIi0ilDpmbfqEu+IvND2R58m4+1/2tiefcE0=;
	b=FVh9kL8uk9daFaKpq1yL4Ic1/7ajtPgm72fuxFptRSwFWRrVYnnbMAdhojNP+iga3X4o
	 JlROXqZsQT02iPFSrgs7eZLOWWvDKDOYoErEoEbjJFALlKTD/ay7YEQ52zpJtWF4mcuEk
	 G7fmSfQQLrwFXBlyTrHLjlPz9YC5AFBDgj1QDLF9LH8ZKN6msylaOLZFN7kXwiVv8nO+Y
	 Z/69RaeQdLha/1dg3UqSpq7eN+u1tqozruPf+KRd+9bYM9IfG1Jy6tYWGwL1Crsfsv55+
	 F8SCHH+eQLlNlE3e+VvzjJXj8Zbofu6ZiZRY+zLitmUhFSYTNV/q1dN1SeBOVmu0m4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IPx3XyZn;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D7606A319;
	Wed, 21 Oct 2026 01:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IPx3XyZn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yzjZW+qTIi0ilDpmbfqEu+IvND2R58m4+1/2tiefcE0=; b=IPx3XyZncTgKcilragBIPzdckV
	dsEQcCuka/dbWro/Xth8Ygzo7JpJhxIa5YjSXQosibFqYezE5nm6j6xDUMZOsUHHlNOJR+VzI0QL/
	CzxGEMQzfC0po06/v4Sbuu3Y3AaQIohT/nmgaG5Ya265J36JULfg45on69Ot5AuTgZIY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJKli-00Bx1E-Bo; Wed, 21 Oct 2026 03:05:26 +0200
Date: Wed, 21 Oct 2026 03:05:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@googlemail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
Message-ID: <59c8f008-9ca0-4620-9a54-e73da131ab6c@lunn.ch>
References: <20261020223002.1749284-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020223002.1749284-1-rosenp@gmail.com>

On Tue, Oct 20, 2026 at 03:30:02PM -0700, Rosen Penev wrote:
> Disconnect PHYLIB PHYs and deregister fixed PHYs during both probe
> unwind and driver removal. Without this cleanup, unbinding a DT-based
> EMAC can leave its PHY attached to the freed netdev, while fixed-link
> instances retain their registered fixed PHY.

This driver is quite convoluted with its PHY handling.

Please split this into two, phy_disconnect() and
of_phy_deregister_fixed_link() and add better commit messages.

	if ((dev->phy_address == 0xffffffff && dev->phy_map == 0xffffffff) ||
	    of_phy_is_fixed_link(np)) {

		/* PHY-less configuration. */
		dev->phy.address = -1;
...
		if (of_phy_is_fixed_link(np)) {
			int res = emac_dt_mdio_probe(dev);

			if (res)
				return res;

			res = of_phy_register_fixed_link(np);

The logic here is more complex than 

> +	if (of_phy_is_fixed_link(np))
> +		of_phy_deregister_fixed_link(np);

So you need to explain in the commit message why it is correct.

> +static void emac_cleanup_phy(struct emac_instance *dev)
> +{
> +	struct device_node *np = dev->ofdev->dev.of_node;
> +
> +	if (dev->ndev->phydev && dev->phy.address >= 0)
> +		phy_disconnect(dev->ndev->phydev);

It is also not clear this is correct, since a fixed-link should be
connected to, yet a fixed link has dev->phy.address == -1?

	Andrew

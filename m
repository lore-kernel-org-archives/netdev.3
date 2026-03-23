Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631735E957;
	Mon, 23 Mar 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774257621; cv=none; b=OQxyAskDfn6NnyOLEmwHBPlgkz9O0qOB5yyL4YfJJtvP6mYtlui+VUGApCD0ZRFwT247JWSTl65OCP+7JfuH8m+EeYsWN3wnmfK99Mpd0ZxFfJEE9vHCcOJgqmtyWREB1dy9zcr7z8R7U0Ilm63cLOEmFhEbexQYj3C66qCyxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774257621; c=relaxed/simple;
	bh=PYyCptw2OM+A87u6EOfmH6Exmz6g2zs2xlASinROUh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1aedLvz+A7oBDbhOyKhA6rB3mwYkwafo2CVSwVw9H8R+pcLfTm9d/0gZo9kJuTboRCrm/msZn187P4QkocoIeXeaHB9C8Z0EJwfTVHpR7nreoqMDi5dwrP0gr7SHBs2KHzOIzVVBFvgocOyTOdlTRHL2kBSw5ZdBNwKGIYFhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eUGrZECN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eUGrZECN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ze5ETx/U/7MNxR8MXWbZ3oXcMSugHqDKn2wVuG7ra88=; b=eUGrZECNA51voE32i31QjaUAjf
	7OkBg63xFi7AlouLEgoG7RhJiyKaFD8UNYjySI3YXHajS8/lsDmdcUaiEfzWm7j+h4JrTGkNPstq0
	gaLR8j09J+NralvErg9+2AqahEiteJHprUmtvwdRKQGwvpisOaKOTCXr8i611xKiWG3QOGEr58KHR
	Rz36iy8O6wkx+5sdmC3XfHxNrsKsqC2HATT/StCU0d6fwNHx0HeU0CTYpWKQMShRe1WRqjo05fllQ
	YZuuy2ehGzP+qKTk5NjXTQIIY2p35atMT/+Laf4vhLNVycY5M8n+8k8dphiOqmJdaXNOYnIlmValW
	3pH+dkUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58016)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w4bS9-000000000Bx-0XtG;
	Mon, 23 Mar 2026 09:20:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w4bS6-000000003uf-0hU7;
	Mon, 23 Mar 2026 09:20:02 +0000
Date: Mon, 23 Mar 2026 09:20:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
	frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Message-ID: <acEFwqmAvWls_9Ef@shell.armlinux.org.uk>
References: <20260323060752.1157031-1-wei.fang@nxp.com>
 <20260323060752.1157031-14-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323060752.1157031-14-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 23, 2026 at 02:07:51PM +0800, Wei Fang wrote:
> @@ -1288,7 +1411,17 @@ static void netc_mac_link_up(struct phylink_config *config,
>  		netc_port_set_rmii_mii_mac(np, speed, duplex);
>  	}
>  
> +	if (duplex == DUPLEX_HALF) {
> +		/* As per 802.3 annex 31B, PAUSE frames are only supported
> +		 * when the link is configured for full duplex operation.
> +		 */
> +		tx_pause = false;
> +		rx_pause = false;
> +	}

I keep seeing this totally unnecessary code in reviews of mac_link_up()
methods. See phylink_resolve_an_pause().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

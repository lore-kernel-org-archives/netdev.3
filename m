Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603329;
	b=tmuPngmZIiaaLkyHOl3CrvYCMTjVD6Gc0k3qrydEZ8dngWGv6gCmWzQPWeUonWfZM1lm
	 KZv8QahmWiPEa6QsZpJiAIO1zt3bjhYLndkGGFu5fsbQ/gaNzolfaDFg7bNfoWc3LyDAr
	 iO3BT5SUmrsuG6GB/7sPgStXNzjdc8ChAzvJqXdNCcB75CxvrGeq8PNb4z0weYoogimQ9
	 Y5gZQHSC0X0vH5/oh53pM8IFwx3mw18w4NVjyBLR6ZHYN2/lk7q/nLFqSdQV5U2IIdnzJ
	 ERVjy7L/t5Jp6u5d2gUTvHRDJP0cqXLEoRm/P+lwTnhgLnJwUXSQ0a6owKlx5u57x7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603329;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=z8+Ts67/O281nCBcV7IfvsBb3ZpvM9se/ske5htY3Lw=;
	b=kO8peqzYlCbqo4o8/Kvf4AqySuAgp66BI6gHrp5RW50qkiIZQco4HFj+4DS4dXOAfRPP
	 VSz9aP6MVHpzcouwET13oW+gqpnRZ6hga+gYsSB4KiS3p9iGE8R5+SK0LxbalTcAYVdli
	 OMRWUFLAUd5pPZSMcjYnqFS9CJeSkQygF17orICVCJrla/A9q5gSUn/n6v6qLQZb1GSZd
	 w63nkPaMId2WLi5qDTuZ5oWU55zrZCihQ6rSNhJjVBNyjB5Tpi0NkO1I+lL2XNCxIhDSb
	 fjpxMfPxXVTD5Ahkk0XfSDHoUEx/L87v/dipJEtJqHBT4m3fo4o5jhgM8rcS1Hq20Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=OG7SCUsF;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1AC606A333;
	Fri, 13 Nov 2026 20:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C1AC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=OG7SCUsF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z8+Ts67/O281nCBcV7IfvsBb3ZpvM9se/ske5htY3Lw=; b=OG7SCUsFRQ9UlsA0Km34RySyFV
	5KNQqGF6UqJlEb07jcYP4+uRPRt2IJeoJeCuZk0SV3JCvnYraNdRVPDe+L/ab4AcmH+EQBWznYFLR
	gNqrSZ4+aFNZZi3XJU+XriBljy6JpeqOQEKAjPrcTuu5ohSGBC34/6PVwWoJwTOXbxTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRyIj-00GMY9-4S; Fri, 13 Nov 2026 21:55:13 +0100
Date: Fri, 13 Nov 2026 21:55:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] ethtool: add PHY receive frame and byte
 totals
Message-ID: <6dd40eca-5c17-47f5-893d-0d106f28ea06@lunn.ch>
References: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
 <20261113-submit-acx00-phy-stats-v1-v4-1-986b8a4a1871@gmail.com>
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
In-Reply-To: <20261113-submit-acx00-phy-stats-v1-v4-1-986b8a4a1871@gmail.com>

> Correct the documented group name to
> phydev, matching the existing name exported by the kernel.

> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1665,7 +1665,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currently defined values are:
>   ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3.2.1.*)
>   ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*)
>   ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
> - ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defined by IEEE
> + ETHTOOL_STATS_PHY      phydev   Additional PHY statistics, not defined by IEEE
>   ====================== ======== ===============================================
>  
>  Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in the reply.

This should be a patch of its own. That would of forced you to write a
useful commit message, and i would not of needed to ask why it
changed.

You want lots of small patches, with good commit messages, which are
obviously correct.

I suggest you spend some time reviewing other developers patches. See
it from the other side.

    Andrew

---
pw-bot: cr

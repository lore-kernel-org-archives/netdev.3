Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328966;
	b=WbyGyS8Wn4KDTv0TIMj0rsYPDdfvvN0We1E5TVaDwA41lI2lCyudA5zem/JwAnDC8MBD
	 C5rML9xr5huwNcER/NP9v8YIMyypT6MwDWGGEv7cusb++EwqyqnmNJNAEUa9aiwHazeX0
	 5mcpqF5xOfLePK8hZSnbFlo8M2D4RxULZbPjoUlYXRB3njSG4SKk0CagrPD3HfedA6tNO
	 s8QJqyIx33KFMwFBXhRhy4/k7c0NZdb9+QIg8rgt8sbKMDR1j2DlyLkH9Dp/lCCwi8EpF
	 R0ppiO+WU5OoeBLKBgSRj7Fn48URxtMDQMiBQWXXkGblnyIOovtkkU/gCXunhder7bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328966;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=bp69TPRSxmVUxIsWkPtU2k8L0z3qUF36utw3VQSvJ5E=;
	b=MzG11RzpZuR3iLszfGINCXVDXGiMgBfnJ1uxnNswuxLqge4BJlNW3+uCLDiXxzh+AMzr
	 I2zC+Jzk2ky7qSbwd2J93SLX+Q/x/bNHcmT4Kyi2zrpDidvh0cdLg1Z7argcGuDViPqEN
	 j3TVH0p/V/H8mkFALxBb+4/RTlIx1DK0lkelHjxRkcSXb2Q5ESav/yZlZJkGOjBpPSHQa
	 AKM66e22ijaLMKGOU6HLbGHIw4qEt1G00v/H+vNBL7JioKMbSsCw5HWpuNHx8+RgxFqJL
	 Ziy+ZMdtJz9/DmYiWIsiKaBaiw0yoN5BB2KOLF6/0X+icmhsEzz5051YkC85d+EV58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C8pkaIt2;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C7606A236;
	Tue, 10 Nov 2026 16:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0C7606A236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C8pkaIt2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bp69TPRSxmVUxIsWkPtU2k8L0z3qUF36utw3VQSvJ5E=; b=C8pkaIt2kjYJ8mK+4vELN482bW
	RYHAoB7wnGI1eEbq6lTaLl8z+eylhw9AYvrxOdMvHvgMDwJYr1QF0CFLtsLVf7q5qLGs94W8h8myS
	RH8Mtli9SPynf8ybpt0oa/M2yu2+oah+Iy2t5YLcR3h3Axdh+PKq5LnnERwo4DB0szVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQovZ-00FX6P-8l; Tue, 10 Nov 2026 17:42:33 +0100
Date: Tue, 10 Nov 2026 17:42:33 +0100
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
Subject: Re: [PATCH net-next v3 1/3] ethtool: add PHY receive frame and byte
 totals
Message-ID: <348f19e7-120e-4b41-adab-be016c7a6083@lunn.ch>
References: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
 <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com>
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
In-Reply-To: <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com>

On Mon, Nov 09, 2026 at 07:48:32PM -0700, James Hilliard wrote:
> The generic PHY receive packet and byte counters describe successfully
> received traffic. Some PHYs instead count all received frames and bytes,
> including frames with errors. A frame error count cannot recover the
> number of successfully received bytes because damaged frames have
> different lengths.
> 
> Add optional receive-total counters to ethtool_phy_stats and the phydev
> statistics group. Count frame bytes including the Ethernet header, padding
> and FCS, and excluding the preamble and start frame delimiter. These
> counters describe reception at the PHY, before MAC or host filtering.
> 
> Append the new attributes so existing statistic IDs and their meanings
> remain unchanged. Publish the names through the existing statistics string
> set, and retain the unset-counter convention so drivers can report either
> set of counters independently.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 16 +++++++++++++++-
>  include/linux/ethtool.h                      |  6 ++++++
>  include/uapi/linux/ethtool_netlink.h         |  2 ++
>  net/ethtool/stats.c                          |  8 +++++++-
>  4 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index eba226c79ec3..5528d0f7afdd 100644
> --- a/Documentation/networking/ethtool-netlink.rst
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
> @@ -1683,6 +1683,20 @@ by ``ETHTOOL_A_STATS_GRP_SS_ID``. Complex statistics (such as RMON histogram
>  entries) are also listed inside ``ETHTOOL_A_STATS_GRP`` and do not have
>  a string defined in the string set.
>  
> +The ``phydev`` group provides separate counters for successfully received
> +traffic and total received traffic.

You need to be careful with naming here. This is a
kAPI. phydev/phylib/phylink are implementation details, a set of
helpers which some MAC drivers use to implement PHYs. But MAC driver
can implement PHYs in different ways, and don't need to use a phydev.

``ETHTOOL_A_STATS_PHY_RX_PKTS``
> +(``RxFrames``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES`` (``RxOctets``) count
> +successfully received frames and bytes. ``ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL``
> +(``RxFramesTotal``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL`` (``RxOctetsTotal``)
> +include frames with errors. The total byte count includes the Ethernet header,
> +padding and FCS, but excludes the preamble and start frame delimiter.

And what would you call it when the counter does include the preamble
and start frame delimiter?

Take a step back. Just because this PHY has these counters, do we need
to support them? And what happens when the next PHY comes along with
slightly different counters? Do we add them as well?

It is vendor SDK syndrome. The hardware can do this, so lets expose
it.

What is your use case here which justifies these specific counters.

     Andrew

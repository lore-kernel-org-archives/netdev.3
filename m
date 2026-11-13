Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595342;
	b=lYJLlSEiMi3WnOuQeng84uT/TGj50WouYr8Z3l43AY1PGfnCg9ZKGcZQhK1dLkbQRXK+
	 2tVZVWtPcr/k3GbfqYXDqt0lQZhWJCigt+hWAjajJ0Yd0+Qeo2Zoov8fnmyX27cbgB3f7
	 QLHe4wo1k4EZ2focSURGiqWspP8eXYZ8cRsle27kHn6NGmiIYGzYLrrv/xirS0FxJ/fJ7
	 qSr3fgnZMP/id6ZWORu0Fzv7Gl8YMVAz5dN7MTza/EQfSzH3g7W5ZKh44vK5QRKzws0Ts
	 KUtalqr0XwwbHg7/Ekwo7d4+sfADTUWwopqiTjasq+Km56TRG1zRY5RUlh4n2uGbBhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595342;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nfTUaQhN0OQnkB88gXtyYSFFG+s4ApND6zHMc1XaeNU=;
	b=OpLa1F1zBoEeilHl2xf37CJ8auDSDOo7CzQtdAGBGLS6lKwFSHdbYhql1kbSx8INctk5
	 aTBSP/SVjDPT+KnfFdkL5c5QCTg0AheDLVnhvNgqkoCn9+TRebTjIYgpWclG6fDzLoM6u
	 Z2gPpQUaZjES7vEzydQDgGzm5PBeylU2XUgCaCdT+F4c0zjTuyPZ6uPWmNGBpUHZoGxDe
	 OZYuLIkTcrnIbM+q8H4L8AI4GRgbszGGtZdHiLu4OxOw592NJTpeNpiX4JlmYi/Rxz09v
	 UpNnueT75cn7WgL0vGh5vNhW2GVY8PJRcZL9O8luglUukX6BGGKRDy8jUbnHGo4kArQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MtEE2Yui;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39928606A330;
	Fri, 13 Nov 2026 18:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39928606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MtEE2Yui
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::109])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 292F1200F1E;
	Fri, 13 Nov 2026 19:42:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794595335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfTUaQhN0OQnkB88gXtyYSFFG+s4ApND6zHMc1XaeNU=;
	b=MtEE2Yuinh5cYgMSOvvYyCYGbW0wOFDU1OfY/PbFTqxJxNIJGnC+BQH4Jy3blBv8yVs7bi
	MPegf9/emFj5QUbGPyFj1SF/E/n1+Gxdr0TfOB6f9zYmt56zALDLV+MrL3BmbsAMwUC9It
	ZrdbPmCwwq5OIirSq03awncbOQFbxiear62YQPICZXylaaczrxIqE3FTb+B9HuzP5fd/Jo
	iUHTm3NUhkxSU9HIrtEkM+y86DAxwYdUUmDeCLmRWfbAzWBVhTlRaBYY8u53B+ck3hTy/M
	QNf8tEK5ByfYQ3AL2vv0wzDzrRFvbC4DrUMxrhGq4fV6XqGTVfLtSoOvMIkwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794595335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfTUaQhN0OQnkB88gXtyYSFFG+s4ApND6zHMc1XaeNU=;
	b=Z2gcNITZ1VncHGXomqg3wMioAg2tJkkWg+eGdplofGEkhUIl51X0LI3Fmdgh4V4/yQl/bQ
	NZPKUX+orlx7pFmYmXQQQvkCqacty3tcQVGck8yf5eqh9Y5ZjZLI8K9x+BJn0xlkchf8n0
	kXd/vVRC4iDFpWEJf1FhgrftB64FIfjFjG4brdtTbN6rSk+hAzqWps38wJQPeBDbfs8UYi
	+VM14YhsjvQYAb7juS+ejFcoFQXd5SRAbn6vv1KFBaPpVXFMFFlH40tQgqQiwAXA+I9FLN
	wPwf1CcqRCHNJoyobkoBkBhETzueSW0u0CU5A/xKNTEUFSWY4t19vogOX1rs9g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794595335; a=rsa-sha256;
	cv=none;
	b=Uyyf1aXa3vF2PtUxhv1KcN0Q8B27UHokOKS1gOY5qB++dFws+boNfKMhJPet/g93GyxiZo
	nao9DI1L0+dxbVbNsf0s5Sm9eON5kbV9Z0rKXXbbQt5jfzTlIqwpGPC0gR0sPQJ/9ijgUP
	pjvY9Kk0JQ0g/C/Xnnoc0zlzge8HfzKUpzhy2RLV9hBMGqCMd+mpYCeqC6MpXNTioKvRVr
	KMPb6auWYpdihRimPtNAWENGujnVtMerxzUaqZicD7i2kFrrSK+fU5TRfXakcVXvwTs9NE
	I2SlokIoAQbmQm2HCker3Mr55CtpJITAtCWZo2KLGIwy/aNOdEo+1TMDb6c/kg==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id F0A401C00E0; Fri, 13 Nov 2026 19:42:14 +0100 (CET)
Date: Fri, 13 Nov 2026 19:42:14 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] ethtool: add PHY receive frame and byte
 totals
Message-ID: <avdaBgWc5tpMhtqF@pengutronix.de>
References: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
 <20261109-submit-acx00-phy-stats-v1-v3-1-fbc6327c5be4@gmail.com>
 <348f19e7-120e-4b41-adab-be016c7a6083@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <348f19e7-120e-4b41-adab-be016c7a6083@lunn.ch>

On Tue, Nov 10, 2026 at 05:42:33PM +0100, Andrew Lunn wrote:
> On Mon, Nov 09, 2026 at 07:48:32PM -0700, James Hilliard wrote:
> > The generic PHY receive packet and byte counters describe successfully
> > received traffic. Some PHYs instead count all received frames and bytes,
> > including frames with errors. A frame error count cannot recover the
> > number of successfully received bytes because damaged frames have
> > different lengths.
> >
> > Add optional receive-total counters to ethtool_phy_stats and the phydev
> > statistics group. Count frame bytes including the Ethernet header, padding
> > and FCS, and excluding the preamble and start frame delimiter. These
> > counters describe reception at the PHY, before MAC or host filtering.
> >
> > Append the new attributes so existing statistic IDs and their meanings
> > remain unchanged. Publish the names through the existing statistics string
> > set, and retain the unset-counter convention so drivers can report either
> > set of counters independently.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  Documentation/networking/ethtool-netlink.rst | 16 +++++++++++++++-
> >  include/linux/ethtool.h                      |  6 ++++++
> >  include/uapi/linux/ethtool_netlink.h         |  2 ++
> >  net/ethtool/stats.c                          |  8 +++++++-
> >  4 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> > index eba226c79ec3..5528d0f7afdd 100644
> > --- a/Documentation/networking/ethtool-netlink.rst
> > +++ b/Documentation/networking/ethtool-netlink.rst
> > @@ -1665,7 +1665,7 @@ the ``ETHTOOL_A_STATS_GROUPS`` bitset. Currently defined values are:
> >   ETHTOOL_STATS_ETH_PHY  eth-phy  Basic IEEE 802.3 PHY statistics (30.3.2.1.*)
> >   ETHTOOL_STATS_ETH_CTRL eth-ctrl Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*)
> >   ETHTOOL_STATS_RMON     rmon     RMON (RFC 2819) statistics
> > - ETHTOOL_STATS_PHY      phy      Additional PHY statistics, not defined by IEEE
> > + ETHTOOL_STATS_PHY      phydev   Additional PHY statistics, not defined by IEEE
> >   ====================== ======== ===============================================
> >
> >  Each group should have a corresponding ``ETHTOOL_A_STATS_GRP`` in the reply.
> > @@ -1683,6 +1683,20 @@ by ``ETHTOOL_A_STATS_GRP_SS_ID``. Complex statistics (such as RMON histogram
> >  entries) are also listed inside ``ETHTOOL_A_STATS_GRP`` and do not have
> >  a string defined in the string set.
> >
> > +The ``phydev`` group provides separate counters for successfully received
> > +traffic and total received traffic.
>
> You need to be careful with naming here. This is a
> kAPI. phydev/phylib/phylink are implementation details, a set of
> helpers which some MAC drivers use to implement PHYs. But MAC driver
> can implement PHYs in different ways, and don't need to use a phydev.
>
> ``ETHTOOL_A_STATS_PHY_RX_PKTS``
> > +(``RxFrames``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES`` (``RxOctets``) count
> > +successfully received frames and bytes. ``ETHTOOL_A_STATS_PHY_RX_PKTS_TOTAL``
> > +(``RxFramesTotal``) and ``ETHTOOL_A_STATS_PHY_RX_BYTES_TOTAL`` (``RxOctetsTotal``)
> > +include frames with errors. The total byte count includes the Ethernet header,
> > +padding and FCS, but excludes the preamble and start frame delimiter.
>
> And what would you call it when the counter does include the preamble
> and start frame delimiter?
>
> Take a step back. Just because this PHY has these counters, do we need
> to support them? And what happens when the next PHY comes along with
> slightly different counters? Do we add them as well?
>
> It is vendor SDK syndrome. The hardware can do this, so lets expose
> it.
>
> What is your use case here which justifies these specific counters.

I have the same question. James, your answer mentions traffic monitoring
and error diagnosis, but not a concrete problem on AC200/AC300 that these
totals would help with. My guess is a receive problem that another driver
for this PHY already works around.

Rockchip's vendor driver for the same PHY ID (RK630 and RV1106) reads the
packet and CRC error counters from page 9, registers 0x1b/0x1c and
0x1d/0x1e:

https://github.com/rockchip-linux/kernel/blob/eeb355823a794954737fd75820dfccdab4c57af6/drivers/net/phy/rk630phy.c#L430

The vendor driver does not export them. It polls them to tune the
receiver. If there is a signal but no link, it switches to a second
analog setting and checks again. It switches settings in two more cases:
too few frames arrive, or more than 15% of the frames have a CRC error.
Its comments call this "Long network cable parameters". It also changes
the RX detect threshold depending on the temperature.

Do you see a problem like this on your AC200/AC300 boards? If so, can
you describe it? Then we can decide whether the driver should work
around that problem.

Oleksij

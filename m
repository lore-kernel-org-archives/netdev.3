Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD2283FF5;
	Fri, 17 Jul 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274495; cv=none; b=r6YgUlSuf9fjrrYEk+mV/lbOQ9KMiQzcSXgUFfkF5HtI5ZxiIy2QYEdykmUcg8YadBpxHShkE6+5srIHV2bR2Stx6ZlavJRAMo7fwXAcdwWFgRcDjx+ZkwmN+Q6UTYQxCTUyKiJxDMjgRlOn4c3Fz/QhbqvgFShyUz0kMibJb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274495; c=relaxed/simple;
	bh=kzBUjsts+r71cy1ejWQ/TLv63+isorymP7OmJkbtajQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kVY+sqORpVYgaByZjCJvCKXNSSIIhcCfJNVtLF0YcXF55n1tpAmdsMvzoE6dJSeZzinoiQRg40kgDLjv+5NufNvTnSaW/EHNV6EMl282eWOk/8GnVxgT5Rieb/qlqOH/4vTyAlFLXKek7WSvwrgntOgkR2sctlP5OCmi/J5kVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mtp8gGFQ; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="mtp8gGFQ"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1B81C6095A;
	Fri, 17 Jul 2026 03:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1784274485; bh=gzxLnljLdNASWWXI/SlJYKCpYwgng9BY1H9pLicqdHE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=mtp8gGFQnZ9nZmHB34W6BjlulTnyOBA2AYupqkCAFEpHPaZFxUUtSKqNQvg3Lx2WV
	 m+A8IghtQGDX2aPVQBeUsrWIF0h03syLYxHQl/jnYrOjnXmTq6+hUlbCZ1JUiqxrEB
	 T7pIseH6nHg7+noZAQz2kF7InXYaPTzS/F7iStUc4QNkyC77XEkozC4MK/GoPMG255
	 ThQChhQrbTbu1rpRWEY0UyJM4a2auSih5YUEhon9A/YPMOHjwTNlr5pI1ip7xbQvRj
	 yC2hKgmQj8vwSoYlVY9W1AWe85r1a5fSVRH0AEzPk82LfHqgKxpRYzTn+1yY9/njFn
	 xC1DafgEE7Tpg==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp
 fixes
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
Date: Fri, 17 Jul 2026 17:47:49 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A7B1CC8-F5F6-487E-A14C-1F0C2D5ADC84@padl.com>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)


> ---
> Luke Howard (2):
>    net: dsa: mv88e6xxx: embedded PTP timestamp support

This can be improved: there is no need to extract the embedded timestamp =
in the PTP worker as it can be done directly in =
mv88e6xxx_port_rxtstamp() (provided tstamp_{cc,tc} are protected by a =
spinlock). DSA can deliver the frame normally, similar to =
ocelot_ptp_rx_timestamp().

Deferring to the worker can reorder frames such that PTP general =
messages arrive before the timestamped event messages, which confuses =
some other PTP implementations such as gptp2d [1].

This optimisation of course only works for ArrTSMode because there is no =
MDIO read required.

Luke

[1] https://github.com/xl4-shiro/excelfore-gptp=

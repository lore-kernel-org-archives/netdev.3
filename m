Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046588;
	b=3WHvG4KKxa3E9Osy6GIcPaf8nbrNoYFKt9SlU+TQpw0qcL8/nX7KJTAAkk4xGJSq1oD+
	 ieJ6fGDHqjB3ncr73LOilT8XJYaMU6rvGGoZQdWk7Tdwa6obtAF4EUlZZYKaRVEeknV1Q
	 mvxDoqwDEDMMo5BnOWUfIM8RxNyk5+p2WAz+k3aY+foUTf1kxdnGwl38U+vyCSRVB0R0N
	 cDVw5+rOHo34vt7vnTwfGHCg24JVUxk4GtUdzBHlYLTB7M6QAcMq2GHjPYlUfWpbgyNPl
	 OildocPN7JPqdXv0gKHWbuw53SC9JQvIlW9Tlqxe2Q1dVkwxupEi1uEBeFxl/ITO0Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046588;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=SlwCDorLykD2oMbZGdGF8ssg7k93qd6ZBcdFL1kKcQY=;
	b=059yP23pc8mUCmx5GNrQYiszTrhrMR1ISytUJt00JIYl9WvYuar5Jh1vRwRbC4BqT7NQ
	 TOlW7qqjy5JmyOC4MP6oNs7QWc2ZhkmDMDCIrjkJQUwODJw7IYr3wI2swjaYu9h67l0yQ
	 NZ9wYYf1Zf5noRwNjE4l0PzI+ruMyEV3eUnSs5/UR6TxdNFftn1KvTMEkel7ELlbwIaAA
	 iCcXiR+11LxS80AK72DgaM/QfXbHf8FzotxCAy1TMIDyNAOzT1Pnq1OpZladSAQxItb/r
	 /7QHk7RsScLpy6qxSl0OYwPP3R2GnND0vN6uYH2JqpXptj3KJ63nHWisj8N938ojQAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=qYtqlQU1;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98878606A31B;
	Mon, 26 Oct 2026 20:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98878606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=qYtqlQU1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SlwCDorLykD2oMbZGdGF8ssg7k93qd6ZBcdFL1kKcQY=; b=qY
	tqlQU14AamnRAEGzw/bhK6M6BTVqn6vRFWf5bX4jZwOD3i+EBSWFBv/uWEIvN/E5pfdjRR4nwF1vE
	CF/Gy2dFHy3flxWkeonRmXFEAclkaJ8b7mLH6ZKziUe6EKTCA+Uv2muVJNRxDF2O33E26HlpxHoC+
	oadOsi4xbX9jsCk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLRK1-00CqJY-Ow; Mon, 26 Oct 2026 21:29:33 +0100
Date: Mon, 26 Oct 2026 21:29:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] net: dsa: b53: restore the NSP IMP port 2
 Gbps mode
Message-ID: <735e6453-30da-430d-9e4f-8ecd0e06f459@lunn.ch>
References: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
 <20261022211104.2091128-3-florian.fainelli@broadcom.com>
 <CAOiHx=nXKnzqB+-BvYg7rgxpLq9p2JP2xk8JchK-3+fqzpG7nw@mail.gmail.com>
 <47511aa5-3032-4bd1-bf8d-bcb1a2280367@broadcom.com>
 <bab723f0-742a-429b-a22d-bd086ef35389@lunn.ch>
 <9510382b-c726-41a9-8997-5779d991395e@broadcom.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <9510382b-c726-41a9-8997-5779d991395e@broadcom.com>

On Mon, Oct 26, 2026 at 12:34:05PM -0700, Florian Fainelli wrote:
> On 10/26/26 12:11, Andrew Lunn wrote:
> > On Mon, Oct 26, 2026 at 11:34:36AM -0700, Florian Fainelli wrote:
> > > On 10/26/26 11:31, Jonas Gorski wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Oct 22, 2026 at 11:11 PM Florian Fainelli
> > > > <florian.fainelli@broadcom.com> wrote:
> > > > > 
> > > > > The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
> > > > > its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
> > > > > so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
> > > > > ends of the internal link configured at different speeds.
> > > > 
> > > > Sounds like the devicetrees are wrong. Shouldn't that fixed-link
> > > > description be updated to be 2 Gbps then? ;p
> > > 
> > > That's a fair ask, however that would require introducing 2Gbits/sec all
> > > over the place, and it's not like we really have a good way to report that
> > > even through emulated PHY registers. This would not be a bug fix however,
> > > which this patch set is targeting.
> > 
> > Hi Florian
> > 
> > As far as i know phylink fixed-link does not care what the speed is,
> > and it does not try to emulate it in the PHY. So it probably just
> > works. Assuming the DSA driver is using phylink.
> 
> Can we agree this is outside of the scope of what is being fixed here?

Yes, it can be done sometime in the future.

     Andrew

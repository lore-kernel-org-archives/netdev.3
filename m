Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C452ED4A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871014; cv=none; b=NVavhFlS81YuwOWUVNgyNuluikkq+lPiJirf46AakCw8Bg7H5/tbaiS1LB8QebCvWD5gbO+PlAwfIlq5P5ZoyXNAJldFXtOOaFUZ2D/h7Rlqv+DKLXUG3Naxabn06BgucewSShw8T31jI0SNvEJjN0Eyys+sGA+2pjvuL/EgnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871014; c=relaxed/simple;
	bh=QRZxdxzoLo0jlgJuYiv5XaSXuLWyyys4yksB6p91GRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcZylngh42sBMQBkJ8ZlSRKJoHLFjDpDDxwUHoyjbaElnyGBYP+3f08N9DhjWgRYw4x6AjwmMpYWU3Ue92D6WbO87KdJ/6TS2C4PHCcrT7Mux33FkpU6xRkPDMx9A1USh13r/2lcepUFoeBpJJuhYDDLaPgF76RLCNTJo9GGHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pHQAM/sM; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pHQAM/sM"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QRZxdxzoLo0jlgJuYiv5XaSXuLWyyys4yksB6p91GRQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788871010; v=1; x=1789475810;
 b=pHQAM/sMYAT/bxfSiW1IsHDoL6i/1mRzlDMHUZN4GUkaK45tShjjItrgc13/ticviNTPdsmr
 3CBvEztkITc2fH6TnlPieTL4yJIzJFS1yMTd5R0sGfifpY4csAsJsWcHnq6bUrrB4AhcQFDKKiI
 RVA7+TPsIPBQQQcERuVTAWRQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2af1264f8bc09df4;
	Tue, 08 Sep 2026 12:36:39 +0000
X-Mizu-Trace-ID: 2af1264f8bc09df4
X-Migadu-Flow: FLOW_OUT
Date: Tue, 8 Sep 2026 20:36:29 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Ramses <ramses@well-founded.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] bonding: fix initial last_rx vs ARP-monitor slack
 window
Message-ID: <aqABTWhi9M5f46R9@fedora>
References: <20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev>
 <apD3VyaIOmMlv6kK@fedora>
 <P0pqA1I--F-9@well-founded.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <P0pqA1I--F-9@well-founded.dev>

On Sun, Sep 06, 2026 at 11:02:37AM +0200, Ramses wrote:
> Aug 28, 2026, 04:50 by hangbin.liu@linux.dev:
> 
> > On Thu, Aug 27, 2026 at 01:44:42PM +0200, Ramses de Norre via B4 Relay wrote:
> >
> >> From: Ramses de Norre <ramses@well-founded.dev>
> >>
> >> Commit f31c7937c254 ("bonding: start slaves with link down for ARP
> >> monitor") initialises a freshly enslaved port's last_rx to
> >> jiffies - (arp_interval + 1) so that it does not "immediately cause
> >> fake detection of 'up' state". At the time, the comparison was a plain
> >> <= arp_interval and the value was just stale enough.
> >>
> >> Commit da210f559019 ("bonding: add some slack to arp monitoring time
> >> limits"), four months later, added a +arp_interval/2 slack term to
> >> every comparison (now bond_time_in_interval()) but did not widen the
> >> init to match. Since then, bond_time_in_interval(bond, last_rx, 1) is
> >> true for the first ~arp_interval/2 after enslavement even though no
> >> packet has been received: the upper bound is last_rx + 1.5*delta and
> >> last_rx was set to jiffies - delta - 1.
> >>
> >> If the ARP monitor tick lands in that window, bond_ab_arp_inspect()
> >> proposes the slave UP. If the slave is the configured primary,
> >> bond_ab_arp_commit() sets do_failover and the still-armed
> >> force_primary in bond_choose_primary_or_current() makes it the active
> >> slave regardless of primary_reselect. ARP validation as the active
> >> slave then fails (the link has not actually received anything; on
> >> SFP+ ports the PHY is often still negotiating) and the bond falls back
> >> to the backup. With primary_reselect=failure, force_primary has now
> >> been spent and the bond stays on the backup until something else
> >> triggers a reselect.
> >>
> >
> > Can we set primary_reselect to always or better to avoid this? If you prefer
> > to using the primary slave.
> >
> That hides the symptom, but the wrong link state happens nonetheless, in bond_ab_arp_inspect(), independent of any selection policy:
> 
> if (slave->link != BOND_LINK_UP) {
>   if (bond_time_in_interval(bond, last_rx, 1)) {
>     bond_propose_link_state(slave, BOND_LINK_UP);
> 
> bond_enslave() needs to seed last_rx with a timestamp old enough that this test fails until a real ARP reply arrives. That is what the seed is for, see f31c7937c254 ("bonding: start slaves with link down for ARP monitor").
> 
> The seed is one arp_interval old, which was just old enough back when the test was "jiffies <= last_rx + delta". da210f559019 then added delta/2 of slack to every such comparison without adjusting the seed accordingly, so the seed now sits inside the window instead of outside it. So for the first half ARP interval after enslavement the test indicates "received recently" for a slave that hasn't actually received anything, and that is true for any freshly enslaved slave, primary or not, whatever primary_reselect is set to.
> 
> With the always policy the bond does recover once the port really comes up, so it is not permanent, but until then traffic goes to a port whose PHY has not finished negotiating and is dropped.
> So in my case, I use the failure policy precisely to avoid the bond flapping back to the primary while it is not actually up, which would cause dropped packets, but it would be much nicer if the link state was just detected correctly and this workaround wasn't needed.

Ah, I got what you mean. The primary slave is set "UP" but no arp reply yet,
which cause a false UP and then goes down. Your fix is similar with
f31c7937c254 ("bonding: start slaves with link down for ARP monitor"), the
difference is your version is based on the extra arp_interval/2 delta.

The code looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

But it would be good if someone else also could help review in case I missed
anything.

Thanks
Hangbin

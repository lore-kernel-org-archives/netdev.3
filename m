Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062237;
	b=DnJlFetN2PmoBMA8gw3pC7HY4QcOfJzWmOAt9MOWYsqBfZcjfDPiYwSVQ8jt48hTdSV9
	 A2sfMgz+bdKohWCkvBka/fCzrPa3XxrvCPwu/b33Sd8D1XoozF71lQnuj5BeKejWYtYuc
	 5obDeXOHCfBGJFr4MhreiScC3RJEDfyDOth2JR8Q3H87t72MGm/prZuSUTzSquuwhsPEp
	 JhtAD4lq2lfkGq8pGIUIqVdplt+spsgxTPD1Pb9hFIdepbBYgmhjgTBJ9nVUPwBT5LeKx
	 /7UiH6/jtuYS363G/w20b1BuRE1X54B1zCgB4YVjQ7j97/vmHNuOB3UdnK9hnuV/eLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062237;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0NzN51aqRpbJStcrZN13gsc+4FSKGxJBlY1ADn1Tu20=;
	b=OUQ+Eds22l3EQcGuxPfgRsynXMMauEa5UyWVZLI8nbYCWLntjtikVu5FtH8tP4zGGvZ/
	 +Y8ripq9LPX5Po+ZWuaNaF03kzQAS1UDcVcxZGJG3XBlV+3aMzYp+E8MKF7hzyJAEtirE
	 FrQUIvjnxD8S4fbUUg9z+0jD3Cb66f1CsVVcA+8S6LKxwr1wbpeuYgsmDXNw9woObLQoM
	 BUownN0FfHKNQNArrdFe6GGiAwI46ExDaheA+c/cTwAVIXBu+YQeuo7Q2AVQu+wW1NBWt
	 fvMdTm2PNWnabf/1K3VdM5qQ0vCip+5zfdDHBMCLssKPEFy6HSjKSBLjtE9wE+Hj4TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SGBTcHoY;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A06606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SGBTcHoY
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CE5ifV2bP/0mqUZJORz7tK38azXS/zuEQgIjJrDVLeQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793062233; v=1; x=1793667033;
 b=SGBTcHoYKS+rnnb4J4gkWVMp6rDz90OPf4kfS7ptTG2ad8ot7gca8AoC6cySjewI+yUfi/KM
 1e2V3nNmeC9tfZX8GUhhEWs2ef49CpEXODrZrQBpXoPxvbJ6Tn8zg9EGhaKc2isZV2LzRhsI5bO
 7mgQrxp28Tl5gtKD4R2UkvS4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ddee97269a11767f;
	Tue, 27 Oct 2026 00:50:26 +0000
X-Mizu-Trace-ID: ddee97269a11767f
X-Migadu-Flow: FLOW_OUT
Date: Tue, 27 Oct 2026 08:50:17 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Message-ID: <at_1RnSinpG5t7bZ@fedora>
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
 <atsRW-aYHeB-cEgi@fedora>
 <CAF+_u5Byu9BccKQpZ9VcXAb-fMEhpKAD9A65LktLDJ77ng+KfQ@mail.gmail.com>
 <at6lTNHwA1V9Xja9@fedora>
 <CAF+_u5Bo7_GySpNLv00omfAtKD++5DJYgriSO_=rwzNT7vrfyg@mail.gmail.com>
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
In-Reply-To: <CAF+_u5Bo7_GySpNLv00omfAtKD++5DJYgriSO_=rwzNT7vrfyg@mail.gmail.com>

On Mon, Oct 26, 2026 at 12:20:37PM +0200, Timur Stukan wrote:
> On Mon, 26 Oct 2026 at 02:56, Hangbin Liu <hangbin.liu@linux.dev> wrote:
> >
> > On Fri, Oct 23, 2026 at 03:35:57PM +0300, Timur Stukan wrote:
> > > On Fri, 23 Oct 2026 at 10:48, Hangbin Liu <hangbin.liu@linux.dev> wrote:
> > >
> > > > >  static void bond_miimon_commit(struct bonding *bond)
> > > > >  {
> > > > >       struct slave *slave, *primary, *active;
> > > > > @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
> > > > >                       err = bond_update_speed_duplex(slave);
> > > > >                       netdev_unlock_ops(slave->dev);
> > > > >                       if (err && bond_needs_speed_duplex(bond)) {
> > > > > -                             slave->link = BOND_LINK_DOWN;
> > > >
> > > > Hmm, this issue only happens when link_state is on
> > > >
> > > >         netif_running(slave->dev) && netif_carrier_ok(slave->dev);
> > > >
> > > > while !netif_device_present. Should we set the link up when device detached?
> > >
> > >
> > > Hi Hangbin,
> > >
> > > Thanks for the review and the suggestion.
> > >
> > > A detached device is one way to get there, but it does not cover all
> > > the ways to hit this bug. In particular, it does not cover the case i
> > > reproduced: during inspect both link_state and netif_device_present()
> > > are true, but the carrier is lost after inspect and before commit, so
> > > reading speed/duplex fails in commit.
> >
> > Hi Timur,
> >
> > Thanks for the explain, but the same question to this patch. How do you
> > make sure the carrier is not lost during bond_miimon_inspect() and
> > this slave->link_prev_state setting?
> >
> > Thanks
> > Hangbin
> 
> Hi Hangbin,
> 
> Thanks for the question. To answer directly: there is no way to make
> sure the carrier is not lost between bond_miimon_inspect() and setting
> link_prev_state, but the fix does not need that.
> 
> Let's split the miimon logic with this patch into 3 steps, executed in
> this order:
> - bond_miimon_inspect() - carrier is checked here and new state is proposed.
> - setting slave->link_prev_state - just a copy of slave->link, it is
> not read from the carrier.
> - bond_miimon_commit(), case UP - speed/duplex check.
> 
> And there is the case where downdelay is set and active slave flaps,
> so it is currently in FAIL. Possible scenarios:
> a) The carrier is present during inspect, so bond_miimon_inspect()
> proposes link_new_state as UP for active slave. Then the carrier is
> lost somewhere between bond_miimon_inspect() and bond_miimon_commit().
> It does not matter whether this happens before (your question) or
> after setting link_prev_state, it is set to FAIL anyway. Then in
> bond_miimon_commit() in case UP, speed/duplex check fails because
> carrier is lost and because link_prev_state is FAIL, the active slave
> goes through a regular down path with failover.
> b) The carrier is lost before bond_miimon_inspect(), so UP is not
> proposed at all, and after downdelay the slave goes DOWN through the
> same regular down path.
> c) The carrier is lost after bond_miimon_commit(), so the slave is
> already UP. On the next miimon tick bond_miimon_inspect() proposes
> FAIL and then it follows the same path as in b).
> 
> So slave->link_prev_state is not affected by carrier changes between
> inspect and commit, that is just a copy of slave->link, needed to do
> the right thing in bond_miimon_commit() if the speed/duplex check
> fails (e.g. because the carrier is lost).
> 
> The same applies to the approach without link_prev_state I proposed to
> Jay, since there slave->link itself still holds the previous state in
> bond_miimon_commit().

Ah, yes. I miss-read that. The bond_propose_link_state() only set the
link_new_state to up. The slave->link state is still BOND_LINK_FAIL.

Thanks
Hangbin

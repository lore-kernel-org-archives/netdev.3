Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294285;
	b=AXC2Q5qEYMRgGWwJDysqgFEn2lCYqR2jMLdg+PBIbBQq+eMqY277azhwDbDV1U9TSFYi
	 O2BRaqMmYZlkf0A2uV71b4vgnTSQs5BxDobHlZck89EQpdJqPUsEHk8Eg4uIqXqYFb04K
	 zez36dG4gUO/I5mkzLrXewlwf076Bjk/9AU/Ekjdm8t1rALJ0WIZ82IGQpfzU4LYulvgf
	 W+yWRh81yxuPEfr+11WKDgdh27qsxZtfotgUVqnGWwvbh4amd7REM9v3i/jmG3xN/D03T
	 FKMXTk6BW8HKoDV5kxFr2cTO/0+fb/EuDGMLl7Npc+FdcjDLlkqsPEAFYSL3ynouGtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294285;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4Co5cP3OhjENN51pkmPHHF78b8usmBedVpbFq9HkR40=;
	b=dH9Pekn7HGLA53v2RgrQjU8GhkLOG9OEwCTbGwHIxnlqx3owjkeKDDjqi0aP8BINkSas
	 Pg3kRlglGi741KsAsOWezR3w/AvW81TGnvwNSjjZraorhC7svjZYKKghqNWTsHPjG58Q1
	 gS2QFGhWBb5rJFuskEvMc7rmiy5px2i8h5aBE+sujL0ZKL92zLX/mn7OKDLd3xbtB/oYv
	 oY39uvzgddprFdxbYlmn5QUPJQbGYkuvXsfSLw6CMG+cP1+tcIiQne9ss+0rRFtOvrbEW
	 Z4R7jysGxqNxbFophKjzPWWCD8aXSzKA3T7p3il8ziAgBmndcI449QGWAoUrDfCO+1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w5XgBaD7;
	arc=none smtp.remote-ip=91.218.175.222
Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDBC606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDBC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w5XgBaD7
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Tm2syNt3GrSRviynrIU29ViJ820u9ZICYwGTQfORw8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794294278; v=1; x=1794899078;
 b=w5XgBaD7++BgTaeVYgehrgFX0Mt6ZPaWf9z9vFdudLVqDIAVP66Gzt21tmJix/bO375aCqtt
 uCR5mBnL/+652SkYxgNQgHbUG2k+dG/4HLfoKrrP4yMfc4BupioiBv8E7WI+dXWAxRoBwbCU5NS
 04XlPAqBjyXjI7I+b0dlHsIE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 098aa03fce5f2b79;
	Tue, 10 Nov 2026 07:04:37 +0000
X-Mizu-Trace-ID: 098aa03fce5f2b79
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 15:04:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: luyun <luyun_611@163.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] bonding: 3ad: update transmit arrays without
 waiting for RTNL
Message-ID: <avLB-jIgPjtwiNu6@fedora>
References: <20261105070132.385853-1-luyun_611@163.com>
 <avKIelQZ4rf0G7BN@fedora>
 <259ec87f-9c56-4bea-b2ea-6627b1913ef0@163.com>
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
In-Reply-To: <259ec87f-9c56-4bea-b2ea-6627b1913ef0@163.com>

Hi Lu Yun,
On Tue, Nov 10, 2026 at 02:13:57PM +0800, luyun wrote:
> 
> 在 2026/11/10 10:59, Hangbin Liu 写道:
> > Hi Lu Yun,
> > On Thu, Nov 05, 2026 at 03:01:32PM +0800, Yun Lu wrote:
> > > From: Yun Lu <luyun@kylinos.cn>
> > > 
> > > During 802.3ad bring-up, packets can be dropped despite carrier being up
> > > and LACP having enabled ports for distribution. This was observed on a
> > > machine in real use.
> > > 
> > > The LACP worker enables ports before queuing slave_arr_work to rebuild
> > > usable_slaves. The transmit path keeps using that array, which can
> > > remain empty while the array worker retries rtnl_trylock(). Unrelated
> > > RTNL contention can therefore prolong the packet loss.
> 
> Hi Hangbin,
> 
> Thanks for the review.
> 
> > The root issue is the usable_slaves are not available before LACP worker,
> > right?
> No, the real root issue is the delay between LACP enabling ports for
> distribution and publishing those ports in usable_slaves.

Got it, So the LACP entered distribution before the usable_slaves updated.
right?

[...]

> > I still don't understand why we use such a complex approach to fix this
> > small corner-case waiting issue. Can't we just wait for the usable slaves
> > like the following way (not tested)?
> > 
> > diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> > index d91533b80996..39ecf7f569d3 100644
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -2555,6 +2555,8 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
> >          struct port *port;
> >          bool should_notify_rtnl = BOND_SLAVE_NOTIFY_LATER;
> >          bool update_slave_arr = false;
> > +       struct bond_up_slave *usable;
> > +       unsigned int count;
> > 
> >          /* Lock to protect data accessed by all (e.g., port->sm_vars) and
> >           * against running with bond_3ad_unbind_slave. ad_rx_machine may run
> > @@ -2564,8 +2566,12 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
> >          rcu_read_lock();
> > 
> >          /* check if there are any slaves */
> > -       if (!bond_has_slaves(bond))
> > +       usable = rcu_dereference(bond->usable_slaves);
> > +       count = usable ? READ_ONCE(usable->count) : 0;
> > +       if (!bond_has_slaves(bond) || !count) {
> > +               update_slave_arr = true;
> >                  goto re_arm;
> > +       }
> > 
> >          if (bond_agg_timer_advance(bond)) {
> >                  slave = bond_first_slave_rcu(bond);
> An empty array before LACP enables any ports is normal. Waiting for it to
> become non-empty before running the state machines would introduce
> a circular dependency: those state machines must first enable the ports
> 
> before the builder can populate the array.

OK, I checked bond_update_slave_arr(), we need to wait for the active
aggregator to build usable slaves. I saw in ad_mux_machine(), it will
check if aggregator->is_active in AD_MUX_ATTACHED. Can we add a usable
slaves checking there before enter to next stage?

Thanks
Hangbin

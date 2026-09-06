Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA6156F45
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788685367; cv=none; b=XM6EkEtNvLSaO1DmlpfolSfR1TGIOIkkOayxzYCe+8GxuGjEs45s+qAK4PgKkuexsnYt+lM/JU+zQiD7Yib2eSgVZz0jPW+yR30alcJXaa+6hz/T9YDoHXkr1kVMeilinW4OQem66ttBMwV0dpb7J5EuiwNyNSEumjsLYxY4H6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788685367; c=relaxed/simple;
	bh=yZFoGE8dGWi16UZgmT16DwSXvRwvxdKjnFRWXFI+KzI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VYdP37GGLUNoUU8cevJt2OwwDk8i6vePw7F207c6rg0YQPyFAYU2gk4IvN8BOrD3qdXgzVBOsqax8dTea5XR2XCbtsE22LukWPUmQOOBhqmtCPWzN3m/XNMoLs7ymiclM1lJekS2qL3zoBxgPVaLP57pc3k9VmNzyX+PlIDymfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev; spf=pass smtp.mailfrom=well-founded.dev; dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b=S61njnW4; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="S61njnW4"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 878FB17EB3CA0
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 11:02:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788685357;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=yZFoGE8dGWi16UZgmT16DwSXvRwvxdKjnFRWXFI+KzI=;
	b=S61njnW40fbOrn0odEA5X48hWhe5d70O9pNWwpu+OR4cu2d06xOqyL3qJjvHok6V
	zf0tn8/lVYqkLpmkDk9SOWJwpNTi++2WKBohniotZHtmCB7fdbIn2jzVwbbQyCyG0Fr
	we9KjAQsZyYKadqGJSXHhDat0kRMf0jplT8RzPx7IiyGWyohZ2IK8ITENLWAjJiharh
	vJtZH8triw5MHASU2WABZOp/PPg+S22O35neNvTIsfX40Dn/LEU99Cb7HPvLirqjl5U
	7zECohPl2lJcsoEZtTg2nt5toczf5nFgN13HpvBQMzdK91eotUQJpeSnNT81JzLEUef
	B4APlL0Nwg==
Date: Sun, 6 Sep 2026 11:02:37 +0200 (CEST)
From: Ramses <ramses@well-founded.dev>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <P0pqA1I--F-9@well-founded.dev>
In-Reply-To: <apD3VyaIOmMlv6kK@fedora>
References: <20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev> <apD3VyaIOmMlv6kK@fedora>
Subject: Re: [PATCH net v2] bonding: fix initial last_rx vs ARP-monitor
 slack
 window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 0163e381fa67fa966160938ffa017803050e57578bb1735d37cd25d20463a96a9bb3a550250bbc5eaa94bfdfd8cf3defcf1aa43859ae980630826bb8230f264e7f:TurnOnPrivacy!:tutamail

Aug 28, 2026, 04:50 by hangbin.liu@linux.dev:

> On Thu, Aug 27, 2026 at 01:44:42PM +0200, Ramses de Norre via B4 Relay wr=
ote:
>
>> From: Ramses de Norre <ramses@well-founded.dev>
>>
>> Commit f31c7937c254 ("bonding: start slaves with link down for ARP
>> monitor") initialises a freshly enslaved port's last_rx to
>> jiffies - (arp_interval + 1) so that it does not "immediately cause
>> fake detection of 'up' state". At the time, the comparison was a plain
>> <=3D arp_interval and the value was just stale enough.
>>
>> Commit da210f559019 ("bonding: add some slack to arp monitoring time
>> limits"), four months later, added a +arp_interval/2 slack term to
>> every comparison (now bond_time_in_interval()) but did not widen the
>> init to match. Since then, bond_time_in_interval(bond, last_rx, 1) is
>> true for the first ~arp_interval/2 after enslavement even though no
>> packet has been received: the upper bound is last_rx + 1.5*delta and
>> last_rx was set to jiffies - delta - 1.
>>
>> If the ARP monitor tick lands in that window, bond_ab_arp_inspect()
>> proposes the slave UP. If the slave is the configured primary,
>> bond_ab_arp_commit() sets do_failover and the still-armed
>> force_primary in bond_choose_primary_or_current() makes it the active
>> slave regardless of primary_reselect. ARP validation as the active
>> slave then fails (the link has not actually received anything; on
>> SFP+ ports the PHY is often still negotiating) and the bond falls back
>> to the backup. With primary_reselect=3Dfailure, force_primary has now
>> been spent and the bond stays on the backup until something else
>> triggers a reselect.
>>
>
> Can we set primary_reselect to always or better to avoid this? If you pre=
fer
> to using the primary slave.
>
That hides the symptom, but the wrong link state happens nonetheless, in bo=
nd_ab_arp_inspect(), independent of any selection policy:

if (slave->link !=3D BOND_LINK_UP) {
=C2=A0 if (bond_time_in_interval(bond, last_rx, 1)) {
=C2=A0 =C2=A0 bond_propose_link_state(slave, BOND_LINK_UP);

bond_enslave() needs to seed last_rx with a timestamp old enough that this =
test fails until a real ARP reply arrives. That is what the seed is for, se=
e f31c7937c254 ("bonding: start slaves with link down for ARP monitor").

The seed is one arp_interval old, which was just old enough back when the t=
est was "jiffies <=3D last_rx + delta". da210f559019 then added delta/2 of =
slack to every such comparison without adjusting the seed accordingly, so t=
he seed now sits inside the window instead of outside it. So for the first =
half ARP interval after enslavement the test indicates "received recently" =
for a slave that hasn't actually received anything, and that is true for an=
y freshly enslaved slave, primary or not, whatever primary_reselect is set =
to.

With the always policy the bond does recover once the port really comes up,=
 so it is not permanent, but until then traffic goes to a port whose PHY ha=
s not finished negotiating and is dropped.
So in my case, I use the failure policy precisely to avoid the bond flappin=
g back to the primary while it is not actually up, which would cause droppe=
d packets, but it would be much nicer if the link state was just detected c=
orrectly and this workaround wasn't needed.

>>
>> Reproducer:
>>
>> ip link add bond0 type bond mode active-backup arp_interval 1000 \
>> arp_validate all arp_ip_target 192.0.2.1 \
>> primary eth0 primary_reselect failure
>> # eth0: SFP+ (slow link-up), eth1: RJ45 (fast link-up)
>> ip link set eth0 master bond0
>> ip link set eth1 master bond0
>> ip link set bond0 up
>> # bond0 lands on eth0 via force_primary, ARP-fails it before the
>> # SFP+ has carrier, falls to eth1, and stays there.
>>
>> Initialise last_rx (and the per-target array, and last_tx) to two full
>> intervals in the past so it is outside the slack window from the
>> start.
>>
>
> Is this trying to init the backup slave down by default?
>
No, the link state init is untouched, it still comes from netif_carrier_ok(=
) a few lines further down. Only the last_rx seed changes, from one interva=
l to two, so that it is outside the window bond_time_in_interval() checks.

>
> Thanks
> Hangbin
>


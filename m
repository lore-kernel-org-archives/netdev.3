Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DB3DA7E3;
	Mon, 27 Jul 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188471; cv=none; b=FRmPi5NZpuY5O91kEAxnAbWkq5fvqRjjL2m1tf44UBRj02X6jRqVE+KheYhmE0zx0zM/9f/Is4eVRntN0yOtV6jgom2pJi+RJWLyfTkXQJZq2Sk8BRaVeu1AYSrSRs8sWgDgkisU4jqzf7ME+JVdJpgC/okCqCfrTpNmfcI8ZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188471; c=relaxed/simple;
	bh=mQ4vQLAOFxbeyoyTwRA/MR/ccdNV3Kwh/GgSKubAMrY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=TZO5w0a76zd5toxv67tA9vjAbNrx75RYLuaq56cejj/mi+M5SnIuCvE1A3XvSRw/fXW8CHzwvxezz1m6r7VIBPvD3jdyVps1LVtaRoz6m5agOK8+F43vGzIxHLBAGfuifj/CzhQjOwMW/cQh7T/niz6Qbi0cItfZ8I+LwnlUfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=UUsep2aj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z/9axUSf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="UUsep2aj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/9axUSf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F15CB1400091;
	Mon, 27 Jul 2026 17:41:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jul 2026 17:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1785188467; x=1785274867; bh=gsD5bjOX4IhqWNPGOUH+t
	xLoQTndmPaH68mO358Y+TQ=; b=UUsep2ajtbeYNPbvYdP5JtIJvP+ugYIpX7VIk
	y/CgUrnWKXcYYxJ5kFWzZGgtRl+4fs+drUHAJJybQccIqFB+6C1LL94Xh1k2SxxN
	hzPHpIeSIu6/QdKNHGQn8AxSy8bJd+5jUuI9SPYj3bqK+yWsUS0ncYvBwUlVYfv7
	CWRkTxrJU8sGCmDhS4fu9zfmsZQtVb2Iu32yf4LwtNhR6gw4+pnifWZRAWuQuLK/
	DA7qujgk1dEPPXh/AH3Loe3KplrqrFLbW/pk1sR5HxZRiQmvEstRl4n4pTYHLpxW
	m2pYn0nEC7b6rveHjAVNIzWoXPaWYYSMeKxyyzJ9g9XTemCGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785188467; x=1785274867; bh=gsD5bjOX4IhqWNPGOUH+txLoQTndmPaH68m
	O358Y+TQ=; b=Z/9axUSfk4W3y2g0e9/tci6E68sE4Xf+oEnjj1nmJcsFKT7UBEm
	YbUUknPHd6/sHG6hsGCMzIKSw8XfZhhk1dvuCu21gMAZFW8+FlYzJXECqKqBb1BK
	DWOoB3ljilyz8aUztNPRonc+A8KTEZlkHQh9QIxCSXg9gF+bmJ6KNIXCWn8CLi8m
	r8UYp2Qlx+Ch0NCwDs5xY2mGBViHvLqIbWUdcdY+JngcjPdFYNvBflMYaqie4KbL
	r53uBlp9QWU1wAJfKHPfETS9D0Ve1Pqmj+757OnrRLesS6CqYV/tNW2FgluLav8g
	r1IAMOyqSMMkfkJHOWmZe39LamfQJ8XTb2Q==
X-ME-Sender: <xms:c9Bnap4Px62JjVgty0BuW8dICatLKfW2t2W7h8tjv8pw_dFb90y5GA>
    <xme:c9BnavBrcGpeigNoetFaSLJ8Lgw1J29s5h7EEa1cfD_Xn-4RuYZlXBqcgqlqWBJTB
    nFwUPIO3lQjhGdutgJkg1Syhye5W6JC7ucqeoqKEo2PBoYuzcowpyk>
X-ME-Received: <xmr:c9Bnav-isL3OUAOc9NrRIysyEserdAxa8VkXv2GDTMWk3a35Nfxr0kVFxNAxVaUOVQts_g>
X-ME-Proxy-Cause: dmFkZTEDquLLGSDwi2v3Qtx1KbQMLVWmZaZU03naY8Oyk8pI4//OxU55qeI3FJyHYt95Ku
    eQX7dsg7SJAnodcxQJ006dfKqpxAHQC9a8sqWR8fenydtnVsBYR/IAqwTMnojfhNN62Chn
    /myIRPOevQhcAFyWwRg0Oj58alNBAwJj9oMfDwnKP6wKt8iv53jZ253WBjYbVXf/ezh140
    ZpQlrnYCLf7OGmzr59na7UJJdkZ22Qjy1FLwHHshjb0M/RF0ix4ljw86snHDNdYYsxivZi
    JxuPabAe0aImd2hE/SUjJs9qGMEwZO9tx03OEePiQvPcHrVWb4d4ANNRzMPEomGcA6l0fK
    +LrPr5fTLXQVWSo4zb49lJ900dP2A6+OeA5cTn8WpPvUIWxPjk92BQSKIzijvobP26bJD8
    epJuSWsdWMmY8LFynQPQRUpHiGVNEurpLQdP/IGa1Xq1hNSVtQC3YqPgMs+mI39oS9ksF7
    nIRD9AJ13YxrH7BrptAAWs/KGEbps2lL1FdNPEPoxfUDZHX6CaqnDzoF2/cz+Uv0UL3V6w
    PD4D0o6xkAvxn75/lV0O1n5z9f4OjkezXHssLWaZ1V0r8VxBjHccT+4rfkBhtxscgubbKB
    ZzlBpOF9wsmmAyMdN09onj1EwYdX4oJ2ixTMemdelUR3+MPwWiJP3vrlte0w
X-ME-Proxy: <xmx:c9BnaiH_JC7Um_dxsQtJYaU1xcB-XUIfRrode4AdP72o9DgfRv8MGg>
    <xmx:c9BnapRoVDApc1ZByISqR_HCMRy4A8CSFuGiNwBlpTi5Mn6txUORxA>
    <xmx:c9BnapQew49Nj7rnLl3-LFTffNmcaxDPIAaLOc1yqgp-sZ291zLMzA>
    <xmx:c9Bnas0H56TSkbWWmgzw-EnLR48VkzsMuAidjw0E6INv7DuyBDqK2g>
    <xmx:c9Bnaj57kshILX5RPNGXq2rx0Cm85fk9UAPKUPWVeICnsYjtiOyfv_0o>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 17:41:07 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id F38B99FC6C; Mon, 27 Jul 2026 14:41:05 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id F25DF9FC3F;
	Mon, 27 Jul 2026 14:41:05 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
cc: razor@blackwall.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
    tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] bonding: alb: re-check primary_is_promisc under
 RTNL in bond_alb_monitor
In-reply-to: <20260725233930.2957317-1-xmei5@asu.edu>
References: <20260725233930.2957317-1-xmei5@asu.edu>
Comments: In-reply-to "Xiang Mei (Microsoft)" <xmei5@asu.edu>
   message dated "Sat, 25 Jul 2026 23:39:30 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3097459.1785188465.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:41:05 -0700
Message-ID: <3097460.1785188465@famine>

Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:

>bond_alb_monitor() reads primary_is_promisc under RCU, then drops RCU and
>takes RTNL via rtnl_trylock() before undoing the promiscuity it set on th=
e
>active slave. In that window the active slave can change under RTNL
>(RTM_DELLINK -> __bond_release_one() -> bond_alb_handle_active_change()),
>which already drops the promiscuity and clears primary_is_promisc. The
>monitor still acts on the stale decision: if the slave was removed with n=
o
>failover, curr_active_slave is now NULL and the deref faults; if it faile=
d
>over, the stale dev_set_promiscuity(-1) underflows the new slave's
>promiscuity counter and pins it in IFF_PROMISC.
>
>  Oops: general protection fault, probably for non-canonical address ...
>  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>  Workqueue: b42 bond_alb_monitor
>  RIP: 0010:bond_alb_monitor (drivers/net/bonding/bond_alb.c:1600)
>   process_one_work (kernel/workqueue.c:3322)
>   worker_thread (kernel/workqueue.c:3486)
>   kthread (kernel/kthread.c:436)
>   ret_from_fork (arch/x86/kernel/process.c:158)
>  Kernel panic - not syncing: Fatal exception
>
>Re-check primary_is_promisc (and curr_active_slave) after taking RTNL so
>the monitor only undoes an increment it still owns. The other bonding
>monitors already re-read state under RTNL in their commit phase
>(bond_miimon_commit/bond_ab_arp_commit); bond_alb_monitor() was the only
>one acting on the pre-trylock decision.
>
>Fixes: d0e81b7e2246 ("bonding: Acquire correct locks in alb for promisc c=
hange")
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
>v2: keep vars' rev-x-mas tree order
>
> drivers/net/bonding/bond_alb.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_al=
b.c
>index 2d37b07c8215..839f7482dc18 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -1534,8 +1534,8 @@ void bond_alb_monitor(struct work_struct *work)
> 	struct bonding *bond =3D container_of(work, struct bonding,
> 					    alb_work.work);
> 	struct alb_bond_info *bond_info =3D &(BOND_ALB_INFO(bond));
>+	struct slave *slave, *curr;
> 	struct list_head *iter;
>-	struct slave *slave;
> =

> 	if (!bond_has_slaves(bond)) {
> 		atomic_set(&bond_info->tx_rebalance_counter, 0);
>@@ -1597,9 +1597,11 @@ void bond_alb_monitor(struct work_struct *work)
> 			 * because a slave was disabled then
> 			 * it can now leave promiscuous mode.
> 			 */
>-			dev_set_promiscuity(rtnl_dereference(bond->curr_active_slave)->dev,
>-					    -1);
>-			bond_info->primary_is_promisc =3D 0;
>+			curr =3D rtnl_dereference(bond->curr_active_slave);
>+			if (bond_info->primary_is_promisc && curr) {
>+				dev_set_promiscuity(curr->dev, -1);
>+				bond_info->primary_is_promisc =3D 0;
>+			}
> =

> 			rtnl_unlock();
> 			rcu_read_lock();
>-- =

>2.43.0
>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761894;
	b=quNh12oK9RXYMTffIq2AFO6C7cpmoZCviK8ItxAhHBNoCo5P9PTZMgJt+JYGvT3zJIEV
	 jDAyapgIUHPcf2IkKJIikcBslrXCBlZ5W3isxeyKWVyI7hR55H8q8MP9x7ApNesueyvxp
	 1Sahy1Su4K8kDGWzXlH1YTXCZ46YnpAVEsbzm5IJB0yKXp6Z7ME3U9gbw1jV7fDaFWGnC
	 jPARkJWQ/v1JuwJ5LpbB73Jh5AwTwzBI1t9Rz4ZgnIsN41SQlpio7UFgMklplpC56vOPI
	 jDPjhfBcWWNDprWj4ZCkSlNlz+eKVbNhiX+UPeyWWcpkYBI8du307LVj7zw/CB29QMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761894;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:References:
	 Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=YQZoc8oDyvtiN6C54b6XV3T4O1nL9hPbml+fJcWO+Bs=;
	b=NzN5gygHCzBUq1O1+WgxR4az9DaQ4tYZzW1k71T1kucONf3L0ktlRja73ssPwmofIIPI
	 3f70pI52KMDC5aM+KsCaLytJ83P4JaIxsC/dXc3FnYoobdiiORFWwDQA2arE+fvSte8YZ
	 5aMBdDPoxdzAoJKLKxtiBudpa7DCUh9k+ecWnc6wCe4EM7zY+nL4lkPWATQjTWJq9oE7P
	 APOg6J4MBLcuw0A0ekhzFvq8fZW3qfXW1JLJIofN0+8Sr3Jrx7++9ekY2x//HVJvXK6aG
	 D88EdoIc059nmrnUOQgNBDM1DCgOZYlgqItU7M7sJLpFEEUcqSdq/XnUbNvMc4vj19A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvosburgh.net;
	spf=pass smtp.mailfrom=jvosburgh.net;
	dkim=pass header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm3 header.b=S9JZIFXP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MSzcgAa1;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED31606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED31606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm3 header.b=S9JZIFXP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MSzcgAa1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97CB07A01F0
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:24:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 09:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1792761891; x=1792848291; bh=YQZoc8oDyvtiN6C54b6XV
	3T4O1nL9hPbml+fJcWO+Bs=; b=S9JZIFXPVsT7xY0mgOGxtvPFAhu/+thpZe8Ni
	3jfwD6r1rnfKox59TvjvT4VtFW53ufhmJSOi4CNTgHthIex9u10YGgJyp/DZoYlR
	lW2FFvBn7hbmA/KmDUvvEht7mKHRN2mQFhhO6PYHQ/310+9JBePCWHG40mXTsE/C
	fSnT7aYAZ6QVvXnp2urrttPWWYwGMzvmH5cmORRbylfhI7k7g8m9E01nfo3K+SOv
	V/TKoL8bb83Ga9XSPHmWrGPb4QZ0HRjrDD+ImoUalDTRkQzllesYAXPSg5ILRi4y
	ZZed7/DAAVuq09xyWLfUuyGge35uxAP29VXimq5W3ROMcW6Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792761891; x=1792848291; bh=YQZoc8oDyvtiN6C54b6XV3T4O1nL9hPbml+
	fJcWO+Bs=; b=MSzcgAa1mgI05aTKWCrHYAHATE70RBcq7CYKeEdjHaoyocPx6/5
	sJh2uaYafXQEtiqmo96i0nbWV1YmTKPqK3uOUTFEs6rxyjf9QxobdF8brOcUYW7H
	y00UM5G03KLXr2Ws9hPZoK0U6FbNGfRp8C4iFeiMNQX+/pdpmNlaiqLTpFfBxURD
	GbHfJL33SA6XITnmrH2eRkiZ2USmYhMDmpZ5Q//pk9MZynNjvQGkRucl8TlLyXOy
	9o7vFPar/lej0QpN2YOP1yTCZa8mSW5DAmhwWB9Lfod7k50BmeKEhse3sxUwtukx
	ntewP6FqI1nZy85uauOvHTrr7+XGe20J9MQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvosburgh.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792761891; d=jvosburgh.net;
	mf=PGp2QGp2b3NidXJnaC5uZXQ+;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:veSY10z0hl3bKRylTA9C1oya5NaUMyrZntiZUII1SaDnWsP
	3awb2E4zjCQ98o1t0juIAvFPG7RpKWAOoSN88XXXYAYkY7uNNuoVTc2Y9bFmle+w
	1WyTS4mGLirQ9zeQ1z3V0LBT+Cta38kzW5qn2DmYNHPEjBzVngX9CUgjxs13O38z
	sg6bNDV5MedhNe5h37iu7CzBIROJ0lWmsiJOBqmJJU9s+7+nfDx4XMP0++Kg29sF
	9FGz91Jg48lO0vD5lGKAjwK7rF8WW+ki2tL2z2Bij5My2veD1VDyirzjhN6gV3F7
	h+g/m6Lu4G+1p6NqDAPsQhuQ2fZ/mdgDTvkIpxg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,comments,content-id,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tjHa6qCs1tuYLdVfuZqXrptBsLl87rIRIC4tdJB/k7I=:FfNwvr1fiBNaXLGB1xX3G9EIhU5MfvVMtS+j/fLAArY=;
X-ME-Sender: <xms:I2DbavRSSbvshMsuex95OdxxdRWF0OHpRWec8lJ8CIG82QRrEtadPQ>
    <xme:I2DbavAPKBLYNQu22zVl2vaLx5tb7akGPFvdbgxPX-KAw4S8r7t7fieXdcPULTzUv
    RtzjVMxUyfiH0f4_6IK2kDmJAmn79YMNEeTFNnKBTLlhkKA-8lWuNG8>
X-ME-Received: <xmr:I2DbauKs7oHpqHSlFCmtwAsn0chFZ0NJz3yUMhnigkIhVgD7AxwGPF3GViHwYmx1RNhKsAU>
X-ME-Proxy-Cause: dmFkZTEyVNNMufcBESKHjKCCl9qhJCQdeBMxSu8KbuasyvRpad34WaZwRSZgJzNaP1Afxt
    tIwIAn+YIef9KCbthXK78QyFuRHX787csjai5KY/8+8M7yl2lPjwncTJ5Udr0oZcchsyo5
    irKU31YLC3gAn1ZUcYOx2yNI2ROF1diclaVFt07FD8gwWEOchMZGkr8SPrw7g5xG/8rINJ
    IF4S5xHec5sNdSrxrA4gOriqv0iwLdVSjBuevYUEwBjq2su+zfRKfdIQfUNgbZZUqH+NYa
    bLutXdgHPx6zWTLQysl6LZ76noWzkjsU7Iu7QlRa6KcncRJO0fXg4k50+vlQWjwZ8Ij6IJ
    mNCr12tPwWJd5N8hFYUqdJ/ubonPP+mLwFCHY9MhwN8uVsorkCxW5Ce3inthYaUm7hhrdD
    Vq1H95KPzpVuOz6fm694h4NHfCzZNQvSKQgBZWK/XH4ESiO+3EVqMim1KgIJTEgijaHyyj
    6sUgUifAWmqrsBDvSOoJrm9B3ffI6dA27ZrRcrRrwnjNq68UhEJ2toeCQrEa292ugJLk4q
    Yr8WUCDdtMsNe2m64MoZ4kkGl+uY9DI0TNN9qx7C8gvizDUH4bAMWP5z0Hx7Sn9PdAu7Mw
    cPB92E5+kqrN55jN9/pP9vUa+CNN2MQ3RVI6tRH110wiJV5fhUstzBChY3oA
X-ME-Proxy: <xmx:I2DbaiB7LxVBFafiuL_5MvOtqkpuv8pOwhQy2lXf8ouxCP0aQgbSBg>
    <xmx:I2DbartHIb8POL4jDAd_Q-FHVg1ZOCI4C9a5CiiNg0JLWcj0RXDgpw>
    <xmx:I2DbaoT3Mk92J-NB_StHhStEKHmnHmGxqlcoOQScHOONBQXUd5UgHg>
    <xmx:I2DbaqI0FfF4aXjE6L2qv215KcnEq3mDiiL17OTxTEUQDClzBSep8Q>
    <xmx:I2DbasFLPNyGKF1ptQBObaX4pRHsBmrsjunztTbzZM4NOgC-hE4L1zKN>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 09:24:51 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 1C4961C0479; Fri, 23 Oct 2026 06:24:49 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 1A4151C044C;
	Fri, 23 Oct 2026 08:24:49 -0500 (EST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Timur Stukan <timur.stukan.linux@gmail.com>
cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
    Fernando Fernandez Mancera <fmancera@suse.de>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex failure after FAIL->UP
In-reply-to: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
Comments: In-reply-to Timur Stukan <timur.stukan.linux@gmail.com>
   message dated "Thu, 22 Oct 2026 13:38:21 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53030.1792761889.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:24:49 -0500
Message-ID: <53031.1792761889@vermin>

Timur Stukan <timur.stukan.linux@gmail.com> wrote:

>In bond_miimon_commit(), when a slave is proposed as BOND_LINK_UP but
>bond_update_speed_duplex() fails in bonding mode that needs speed/duplex
>(802.3ad, tlb, alb), the slave is set to BOND_LINK_DOWN directly. This
>bypasses bond_set_slave_link_state(), bond_miimon_link_change() and
>failover.
>
>This is fine for slave that coming from BOND_LINK_BACK, which was never
>brought up and is not in use. But since commit 1899bb325149 ("bonding:
>fix state transition issue in link monitoring") the commit phase also
>handles BOND_LINK_FAIL -> BOND_LINK_UP which means a slave that is still
>in use and may be curr_active_slave.
>
>If the link recovers within downdelay and goes down again before the
>commit phase reads speed/duplex, the slave is silently marked down while
>remaining the active slave in worst cases. In alb/tlb the bond MAC stays
>on the dead port, no failover happens and TLB/RLB state is not cleaned,
>so the bond stops passing traffic until that link comes back even though
>other slaves are up. A non-active slave is affected too, in alb, RLB
>clients assigned to it are not reassigned and become unreachable.
>
>Reproduced in tlb and alb mode with miimon=3D100 and downdelay=3D10000 by
>flapping a slave within downdelay and dropping it again before commit
>(a longer delay was added between inspect and commit to make window
>wider and easier to test):
>  bond0: (slave enp0s3): link status down for interface, disabling it in =
10000 ms
>  bond0: (slave enp0s3): link status up again after 3400 ms
>  bond0: (slave enp0s3): failed to get link speed/duplex
>
>procfs then shows the active slave with "MII Status: down" and "Link
>Failure Count: 0", and all traffic is lost.
>
>Fix this by recording the link state before the miimon commit and when
>the speed/duplex update fails for a slave coming from BOND_LINK_FAIL,
>taking it through the regular down path, including failover. The
>BOND_LINK_BACK case keeps the current behaviour. The down path is moved
>into bond_miimon_slave_down() so both callers share it.
>
>After the fix:
>  bond0: (slave enp0s3): failed to get link speed/duplex
>  bond0: (slave enp0s3): link status definitely down, disabling slave
>  bond0: (slave enp0s4): making interface the new active one
>
>Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitor=
ing")
>Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
>---

	Reading the description and patch, I'm concerned that this patch
is introducing the same sort of issue that 1899bb325149 was solving: two
state variables that end up becoming unsynchronized.

	For example, here you set link_prev_state in one place, inspect
it in another, but never clear it.  Thus, once set, it will remain set
forever, raising the possibility of false matches in the future.  Not
necessarily from this patch, which appears to always set then check in
that order, but from subsequent changes down the road that inadvertently
break this guarantee.

	Yes, that can be resolved by clearing it after use, but I'd
first ask whether there is an effective solution that does not require
keeping additional state?

	-J

>
>Notes:
>    sizeof(struct slave) grows from 608 to 616 bytes due to padding.
>    I kept link_prev_state next to link/link_new_state for readability;
>    it can be moved into the hole after 'delay' if preferred.
>
> drivers/net/bonding/bond_main.c | 53 ++++++++++++++++++++++-----------
> include/net/bonding.h           |  1 +
> 2 files changed, 36 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 09aa45d71fab..602ad697a9c2 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2779,6 +2779,27 @@ static void bond_miimon_link_change(struct bonding=
 *bond,
> 	}
> }
> =

>+static bool bond_miimon_slave_down(struct bonding *bond,
>+				   struct slave *slave)
>+{
>+	if (slave->link_failure_count < UINT_MAX)
>+		slave->link_failure_count++;
>+
>+	bond_set_slave_link_state(slave, BOND_LINK_DOWN,
>+				  BOND_SLAVE_NOTIFY_NOW);
>+
>+	if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP ||
>+	    BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
>+		bond_set_slave_inactive_flags(slave,
>+					      BOND_SLAVE_NOTIFY_NOW);
>+
>+	slave_info(bond->dev, slave->dev, "link status definitely down, disabli=
ng slave\n");
>+
>+	bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
>+
>+	return slave =3D=3D rcu_access_pointer(bond->curr_active_slave);
>+}
>+
> static void bond_miimon_commit(struct bonding *bond)
> {
> 	struct slave *slave, *primary, *active;
>@@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bo=
nd)
> 			err =3D bond_update_speed_duplex(slave);
> 			netdev_unlock_ops(slave->dev);
> 			if (err && bond_needs_speed_duplex(bond)) {
>-				slave->link =3D BOND_LINK_DOWN;
> 				if (net_ratelimit())
> 					slave_warn(bond->dev, slave->dev,
> 						   "failed to get link speed/duplex\n");
>+				/* Coming from FAIL, the slave is still in
>+				 * use and may be curr_active_slave, so take
>+				 * it through the full down path. Coming from
>+				 * DOWN/BACK, it was never brought up, so just
>+				 * revert it to DOWN.
>+				 */
>+				if (slave->link_prev_state =3D=3D BOND_LINK_FAIL) {
>+					if (bond_miimon_slave_down(bond, slave))
>+						do_failover =3D true;
>+					continue;
>+				}
>+				slave->link =3D BOND_LINK_DOWN;
> 				continue;
> 			}
> 			bond_set_slave_link_state(slave, BOND_LINK_UP,
>@@ -2839,24 +2871,8 @@ static void bond_miimon_commit(struct bonding *bon=
d)
> 			continue;
> =

> 		case BOND_LINK_DOWN:
>-			if (slave->link_failure_count < UINT_MAX)
>-				slave->link_failure_count++;
>-
>-			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
>-						  BOND_SLAVE_NOTIFY_NOW);
>-
>-			if (BOND_MODE(bond) =3D=3D BOND_MODE_ACTIVEBACKUP ||
>-			    BOND_MODE(bond) =3D=3D BOND_MODE_8023AD)
>-				bond_set_slave_inactive_flags(slave,
>-							      BOND_SLAVE_NOTIFY_NOW);
>-
>-			slave_info(bond->dev, slave->dev, "link status definitely down, disab=
ling slave\n");
>-
>-			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
>-
>-			if (slave =3D=3D rcu_access_pointer(bond->curr_active_slave))
>+			if (bond_miimon_slave_down(bond, slave))
> 				do_failover =3D true;
>-
> 			continue;
> =

> 		case BOND_LINK_FAIL:
>@@ -2919,6 +2935,7 @@ static void bond_mii_monitor(struct work_struct *wo=
rk)
> =

> 		if (commit) {
> 			bond_for_each_slave(bond, slave, iter) {
>+				slave->link_prev_state =3D slave->link;
> 				bond_commit_link_state(slave,
> 						       BOND_SLAVE_NOTIFY_LATER);
> 			}
>diff --git a/include/net/bonding.h b/include/net/bonding.h
>index 598d56b1bc97..b2b102946fe1 100644
>--- a/include/net/bonding.h
>+++ b/include/net/bonding.h
>@@ -165,6 +165,7 @@ struct slave {
> 	unsigned long target_last_arp_rx[BOND_MAX_ARP_TARGETS];
> 	s8     link;		/* one of BOND_LINK_XXXX */
> 	s8     link_new_state;	/* one of BOND_LINK_XXXX */
>+	s8     link_prev_state; /* one of BOND_LINK_XXXX */
> 	u8     backup:1,   /* indicates backup slave. Value corresponds with
> 			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
> 	       inactive:1, /* indicates inactive slave */
>-- =

>2.43.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

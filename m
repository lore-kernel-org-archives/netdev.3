Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289075;
	b=exZ/Oh4Pv/6hwYhj/pCw4eciNu4CN+/Xh1Y62C+mc9wGKAmeq1INef5D5AdgqBE7C4eO
	 wjaZ4NKc9fMmLa2YM4BnbzU0eb/w+VCSeQfHuvsp3p+O8mHAA3EQlch0EuUjnDxi3PTOE
	 BP9DgQAtmuZEp7zj/HHELQHGLIfi4/0S4iyvjz7H7//a+PK9zOz/HpK4thwwYKRPphFzJ
	 qWRjr8seOHvgMTymRpruecoB0gedd2XQp9V7KIKxvyLj1WM3Kpknuk5tw3jMZmNdDEDgO
	 ygntN+Ke3fp+G1IA2rhKm1i+tnfQnGysipXMwPPcbL6DTybqOKjb7k1bJXd1zpBas5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289075;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:References:
	 Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=G8IdhrDXDBt1/l9BcZ1dObhwhVGEgfMLpd+Ls7Sf1zk=;
	b=qMGNUFCyn7BM88qQQHb5Uvc6dvbmF448/6EIDrOzaRYplRsAoZ25h/bFtygdKfc9oVAv
	 uvvBc9HFYeIH2HMpCajKpLjrU5913XB1uztnPvKldFxCHlc6dD2yU58ngHN19XaD00E8n
	 DyCwdYuA3/oG08tq5YpsG8lXi7Li7fxg2VZGR8TiWivf0BZG3cn05Ji90gzJDO8hc/rN0
	 lKarXAP0eel+RbwIXfP7zQbGwdZOS0/NrS9NIpZlALnrg0gMK3kLVkJyxUjUXumLAR8Jl
	 FCo/Ug8hOmy85hovW6+6R7EXB8lXyj/5/YJ6q4piM1wNfo+9PaOWybl7sDDn9yXir7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvosburgh.net;
	spf=pass smtp.mailfrom=jvosburgh.net;
	dkim=pass header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm1 header.b="C/ZMR5vT";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="vDen1/UC";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7F606A31F
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D7F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm1 header.b=C/ZMR5vT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vDen1/UC
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A10D5EC0191
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:51:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 11:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1793289073; x=1793375473; bh=G8IdhrDXDBt1/l9BcZ1dO
	bhwhVGEgfMLpd+Ls7Sf1zk=; b=C/ZMR5vTYwZ/RWWpIz2WE4Z3aiPWbZTRdeOC4
	4Rw3BiQzHtkySnRS8Lmq0kbK1KtFsKCaL2go7CRgpOn9hq4AZ8GlF/EV0Jgbck/v
	vtdVq+Cn+CH6c2rYWGvupFy04viBgfzpvimTTDYzmcCk7ihDQcQvPjf3N8CMH+1G
	DQ+11g9nGersLuv/h0XLllLkjQsHB5Ur/aOshJ1eUYuRcUbpiL4n3ySfUTJoObyg
	0Aw1RLbaUHaAMgSiElqlQGogNebDo4tjK5mZHzeFucko0UJ2q4Gk0Ge2ucVWxgoL
	OuRWSFEYp4freV7cY1fLtiuBZXG8/yv3xckyZglqQ93gEIQyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793289073; x=1793375473; bh=G8IdhrDXDBt1/l9BcZ1dObhwhVGEgfMLpd+
	Ls7Sf1zk=; b=vDen1/UCG7TL96KKy3PkpyCYmTeR17m6/s9plPLnkPbr5M4j/3J
	CayrjJXtfz/gUPSk2y33nLAugrjvtCItHudgF5TuKse4WGYFPECR0HDIg6WZIeCl
	Pwr9d0H8ZA5Arg40DQgE1ALxSbwDIjFJCLQPxds1GFKIKbD4fxMPJQyXtKYt/skd
	BWJ2xDzFFhvD9csudXAGNkA2tTI9gLVBYf0bJbmCU8UkMiWHmuKWBl5gyZdokMZX
	RvTR4AuqSdov8RKjcAsSEuVKIJ7YBbR/rpamV3vSO0cHvb7Y/w+MUokznKsIy9I5
	2NiZcn8HH2U6ynns7/ssnMVAA2CZoWAmdSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvosburgh.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793289073; d=jvosburgh.net;
	mf=PGp2QGp2b3NidXJnaC5uZXQ+;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Uh2XPfNtg1zJY+CapbctcXF0SzL/3ldWO8u9V+mItZnlxbL
	fiHIud5F6rSgrnHScGbr9uv6nJqggwT0ItNxqrWg/hKN3vvDYTV0tDEsceu9sBD3
	szrmvWj8nRNVq4BLfy2Qeul4RqqIhlXNttTx5obve/exDz49JXacZGH8U01+45qq
	zMSi2VODq0KWq+cpQefYkVfZtuK66+urEKfwsH9VTEWW7muCq3sWTIPHc8pIzgL5
	8ExoCzRx+qORTmk1cPMdL5VJK0Y7uYW/zCARpfYsFqXMnDHSzSYVf5iDOWvzCf/r
	+kUt5VFz38h973GZsW5MWbstGjMsumkJRyPgd9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,comments,content-id,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:v9WhcfxqeDwZLr4c6RdbsvzcqfHxZ1K8ASUYr7miv0w=:o6TDCgmdPCK+NUxESaCIEHCfqT9yIUqdNOWASZitE+E=;
X-ME-Sender: <xms:cWvjage6rubdF5JMIX9lOpKXzglO3Z7b89BfHP5FrQiKizZg07yCVA>
    <xme:cWvjagcFdCa6zDKQBGlegjyAB_zXASaBrFkuZrvRfONQiFCO1NlWq_1oXdoGD7ymr
    l4GbPpYEI4Pw--qs8nINvWWDv_nNgg-NUu7y82jKfBQTsejyJP8hCTD>
X-ME-Received: <xmr:cWvjaq2xrEeye0Z467-PP1XcYaQRpPNomHcKOdlhyWnpZyeKCGXCHB3eyjTTBkHpBdY1d2g>
X-ME-Proxy-Cause: dmFkZTGA0WzT4LB5V2stVAUOkFYZRPVj48xzIzu37ou0BKOlCiDVSYJdNRDlAEpJxXGIEP
    px6Wp4SzUFld0UYozeDZNV+jOpRxIodr5v3oWp6FIXrrSDgr32bljPPMmZ5BJEmKJFcw7T
    NnAonehRAip8gusxVF2HDZEOtuhyIo7gjtiYjbKi+C9zJRWdsxEHFagTFzpgH7e4/LeFVl
    j6nAwRJBmpN/ivEV+k8IoWCUaBlTyHF/qOxJ8p1zoq1Oiwxpw/8TtDKKWxWO+WscP/Bn62
    nkoJreG7KRtEunOGCgCulikJm2vs8WpHfekSE9xqzjRPpgHmXVshMyB6M+nmKL1j5KRLiN
    wTBeH1HbDy+UfJq/oQ6TapGmrVzlR3ksnOBBUjTApOiMUsEP2uLTP/pE91BvfoturyYfo5
    DMT9/woq61mYyZhxMt4mHtoYI6A48kQKXEubNLXoMIz5lVIoTuQyyY9RLG9fDIIxouWj9V
    E1klpIOYIy3GOWeeI/W+wBS0YbrjOt4dwDtEm29KIeN/dUs+kx34gskqXyWMgh1W6X4vbw
    hNK3FXSaLTsjvGFOXRRm4VKh58JI7A/jwypt0a+SjJV6vkiVCY3jAIvDmh3LlRDTV5MTZ6
    vivG5SLUU50jHEN7esoNSV8g6ThqFCnwMc0AAUGQ9dC1M6s6IgHTD8Vd/q6w
X-ME-Proxy: <xmx:cWvjao_niXTzrWzBEVVTExHm8C0VN0caqheHnmjcaZkrbbqXUA-ZkA>
    <xmx:cWvjav4sYc44IzxlCUe-YvJLWBQr6jmsG4DQ8O1TjXR6Gomdaq0zeA>
    <xmx:cWvjagvHJand-nghIxME5yNYixBYwkE1-B0GNKYAS52bPFOYG9ACRQ>
    <xmx:cWvjah3bXsYyRW2ldbkQezQ_xKDs18XAamsGhSxzZZpPD8_I09td8Q>
    <xmx:cWvjaomPxLGnQMdZdczDLxBMIvN7qec1EdNvrGJUct0WP2OS69RtRP_W>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:51:12 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 92D0C1C03CC; Thu, 29 Oct 2026 08:51:11 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 920901C0364;
	Thu, 29 Oct 2026 10:51:11 -0500 (EST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Timur Stukan <timur.stukan.linux@gmail.com>
cc: netdev@vger.kernel.org, Hangbin Liu <hangbin.liu@linux.dev>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Fernando Fernandez Mancera <fmancera@suse.de>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: fix missing down path on speed/duplex failure after FAIL->UP
In-reply-to: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
References: <20261028104758.299129-1-timur.stukan.linux@gmail.com>
Comments: In-reply-to Timur Stukan <timur.stukan.linux@gmail.com>
   message dated "Wed, 28 Oct 2026 12:47:57 +0200."
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
Content-ID: <91954.1793289071.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:51:11 -0500
Message-ID: <91955.1793289071@vermin>

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
>Fix this by not committing UP proposals in bond_mii_monitor(): UP is
>already committed by bond_miimon_commit() once speed/duplex are valid, so
>leaving it there means slave->link still holds the previous state at
>that point. When speed/duplex update fails for a slave coming from
>BOND_LINK_FAIL, take it through the regular down path, including
>failover. Slaves coming from BACK/DOWN keep the current behaviour.
>The down path is moved into bond_miimon_slave_down() so both callers shar=
e it.
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
>
>Notes:
>    Changes in v2:
>    - Drop link_prev_state. Instead, don't commit UP proposals in
>      bond_mii_monitor() and let bond_miimon_commit() commit them after t=
he
>      speed/duplex check, so no extra state is needed (Jay)
>    - v1: https://lore.kernel.org/netdev/20261022103821.89552-1-timur.stu=
kan.linux@gmail.com/
>    =

>    Sashiko pointed out on v1 that the 802.3ad netdev notifier can set
>    BOND_LINK_FAIL on a slave that is already down, which then goes throu=
gh
>    the full down path again. That is pre-existing and reproducible on an
>    unpatched net tree:
>    =

>      ip link add bond0 type bond mode 802.3ad miimon 100 lacp_rate 1
>      ip link set enp0s3 down
>      ip link set enp0s4 down
>      ip link set enp0s3 master bond0
>      ip link set enp0s4 master bond0
>      ip link set enp0s3 up
>      ip link set enp0s4 up
>      ip link set bond0 up
>      (wait for LACP to settle)
>      ip link set enp0s3 down
>      ip link set enp0s3 up
>    =

>    "link status definitely down" is logged twice and enp0s3 ends up with
>    "Link Failure Count: 2" instead of 1. I will send a separate fix for =
it.
>
> drivers/net/bonding/bond_main.c | 58 +++++++++++++++++++++++----------
> 1 file changed, 40 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 7019e5d8fdc8..9bafcddbb453 100644
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
>+				if (slave->link =3D=3D BOND_LINK_FAIL) {
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
>@@ -2919,6 +2935,12 @@ static void bond_mii_monitor(struct work_struct *w=
ork)
> =

> 		if (commit) {
> 			bond_for_each_slave(bond, slave, iter) {
>+				/* UP state is committed by bond_miimon_commit()
>+				 * after the speed and duplex check, so that it
>+				 * can still see the previous link state.
>+				 */
>+				if (slave->link_new_state =3D=3D BOND_LINK_UP)
>+					continue;
> 				bond_commit_link_state(slave,
> 						       BOND_SLAVE_NOTIFY_LATER);

	Reading bond_commit_link_state(), for this call site, all it
really does is slave->link =3D slave->link_new_state, when link_new_state
!=3D BOND_LINK_NOCHAGE.  The changes to ->should_notify_link only matter
for the ARP monitor, so that part is effectively a no-op here.

	Therefore, I wonder if it would be cleaner overall to not do the
bond_commit_link_state here at all, but instead keep what you've added
in the BOND_LINK_UP part of bond_miimon_commit, and then add calls to
bond_set_slave_link_state(slave, ..., BOND_SLAVE_NOTIFY_LATER) to the
BOND_LINK_FAIL/BOND_LINK_BACK case to make the change stick.

	A quick hack patch that I have not tested to hopefully
illustrate what I mean:

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
index 756d79281ffc..5fb215fa85f6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2877,6 +2877,8 @@ static void bond_miimon_commit(struct bonding *bond)
 =

 		case BOND_LINK_FAIL:
 		case BOND_LINK_BACK:
+			bond_set_slave_link_state(slave, slave->link_new_state,
+						  BOND_SLAVE_NOTIFY_LATER);
 			slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
 				  slave->link_new_state);
 			continue;
@@ -2933,19 +2935,8 @@ static void bond_mii_monitor(struct work_struct *wo=
rk)
 			goto re_arm;
 		}
 =

-		if (commit) {
-			bond_for_each_slave(bond, slave, iter) {
-				/* UP state is committed by bond_miimon_commit()
-				 * after the speed and duplex check, so that it
-				 * can still see the previous link state.
-				 */
-				if (slave->link_new_state =3D=3D BOND_LINK_UP)
-					continue;
-				bond_commit_link_state(slave,
-						       BOND_SLAVE_NOTIFY_LATER);
-			}
+		if (commit)
 			bond_miimon_commit(bond);
-		}
 =

 		if (bond->send_peer_notif)
 			bond_peer_notify_may_events(bond, true);


	Thoughts?

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

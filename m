Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111618;
	b=Uh0vj/ajp6e+z4+CphgqsT4YJRafOtfav77KZvDVWujpQmEkPWrDLy9NSOwBVbvkZDJy
	 8PHGv4afWdrWcpYEYv/VbjdG8/qfgD9muv/wH5Qire4JqBnHf5/T96HyyXjAU89NirgDK
	 OpeMjTdJYkzI7Zsl/LivSBocnDODRO4TrVdcR3i2S2PeXzCenqpvd6fK0O+NJhLaaJLCX
	 QrtDe+/hx058itNZNCJhBL4Pamgk+hvq8XLkQ4M86ItA0JA9/+/7z6mAZxdLowe44iNjt
	 aSL48em9Mo9J0jXOuBkjLGxFdGX33CtSCQqG6AzfNFOEV9fCbO9ec75hstKyf5mKCtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:References:
	 Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=jdM4qcBkP3IM/VUJ/lLqwtGE0kuScpYqXF0GCIsfZJ8=;
	b=ovBKfZVaEVRqdp8dBZvWGwUykbADMd83hA31XeCj7jvIeYKaEi+jNpe1sSd4e/hAfqiy
	 +gf94X9/db8bZZklqAIiTyDB5y+nqFZe4gx+jYXa4ObPw3IA4eMA/3o8i47AaLvTs9lxL
	 5Kmy71aFKdfjv0kJoIX0uuR9Eqlv+Vi+yYT5k0FFhx+/Rw5dBfMBMYGZf/6Hw+dEwh81d
	 rAKyM6a+eB0Hn0wQ2efIK5qTJIuGYnCqT2sJhI8TEy1aoe+OQFeML0h3PluHZnqjJPOKg
	 G2OhdZjHx5TUfCGt8VicoQ4Ll/L5BuEFSkJsC5Xw9IiIcp5ykDb9Aq9pyyskDyQr1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvosburgh.net;
	spf=pass smtp.mailfrom=jvosburgh.net;
	dkim=pass header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm1 header.b=HQkMeeud;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pO0MwPvO;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EE606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 294EE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvosburgh.net header.i=@jvosburgh.net header.a=rsa-sha256 header.s=fm1 header.b=HQkMeeud;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pO0MwPvO
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A20171D00156
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:33:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 10:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1793111616; x=1793198016; bh=jdM4qcBkP3IM/VUJ/lLqw
	tGE0kuScpYqXF0GCIsfZJ8=; b=HQkMeeuds0blzhA+A/qnDXULpHFQa6Om1dqqA
	PNb72f63zZVb6nT9oP3o5OWAeE7xvl1XtRDemzw6eJHNou1K5tdTI5oCwBCwd/LN
	9YaSHtLh3w1mq8BrolJ3Nckd4mxFE//F0DFwloru1Mofjfs/y10NWsCl/w5JlpU0
	Kv1dma805Y2e7g60woB29jNdVxnIQ+ti6aAloozQCzsKoNYVo5tQJgPWfNjPscVG
	ldFSBlNA3GUI0Ke4ntL7WPWLjkYvPHu/b98NgPUWG62Nb0CblKti1YFqYpempkY6
	a02AL1HSU/SZV9T8BtsXTFEKTZowf7MM/OCpaO1bd2+NRNOWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793111616; x=1793198016; bh=jdM4qcBkP3IM/VUJ/lLqwtGE0kuScpYqXF0
	GCIsfZJ8=; b=pO0MwPvOsUI3LVkdnziLGI6syc6WGNwLpxBCyAcOyezpCaaxUez
	R2WffuE3lRp9Mz0qqXDHqTlKz5fnnRWXk6+2ibXRSiLrOrfHynJrpvZUO902UiOK
	DzrLkm0Q4+3jVJrsx2NEYIlonCOk2K2+P3AnBGyVtgohRioMVcthn3c6l4laNFIX
	6hOnBiHnDQTpHu9mlnLQ6GXpcw6vfWVJu9fYwQMbtPFYLOpX+KI3Y5ZwzAJSABgW
	Vhe1a9BC/gaXYXNY3hgM5qAG9O7J1pPU/b551PymVAuoSqx7U7D5B7oGnCCtE0Mc
	6YcUjDboBZFgapJeYXHkZNnEyugeKoFihfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvosburgh.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793111616; d=jvosburgh.net;
	mf=PGp2QGp2b3NidXJnaC5uZXQ+;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FtPbJqQcxtuHxLSo70fvTub8XSLOuAX7GcPBe7swq+NiBbJ
	fXpUUBEotk8gsNFRUzR7Xn5nCFteDI2tmV4Utk4Mkhi+DJPjWce6sfN43ymkkoWy
	ZO1/YN8OwxEYZk015Gax6ORRLsi14pYbbPgBIr8rFr8U5jlk2GTaEXJmrCLjOBBy
	rCCcEEbZVBoS71DBJVl4+xLO5a5Mt/kSCqGqU7VLZ/ec0URqsrH0qeobVmmYysht
	uO30hk3jRYswCmncOO7jpXde9obkHzqMa7qu66tuRSoj7SelFi4MtwCn9gv+Ecfe
	S4YZndIopsSxlgNIbvJgebPAF5b9a8xM8Z90nyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,comments,content-id,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zdK+Mf8diUOjj8SMr4Shh3pnY0Rw7TAJlTMN6WzwWh8=:yeVHK8VMzd6RNxvLvncI2QW2CGJv8E7TgGv6nRb+Etg=;
X-ME-Sender: <xms:P7bgah47vVh_vtLckqsvYB7ug621i24WR0H-g3nYkrasoe9RN3HL2w>
    <xme:P7bgatKlz7FjCs61FwttQX8b_nqLh33gno1AI8bLbJRZp2Z_R0nnc38sTvLOgx0jZ
    PUPT5EJkts-5sdxvI8cbKuKoGWbA2aj_4oDaaRnqA3WWQZ94ZaSTvUW>
X-ME-Received: <xmr:P7bgahyKSjXSfN-g3klZw1N3e7gB2e36bYOMSMg2rSXqJy_-4ijPRYNOlzr4PfQjMbWYLGI>
X-ME-Proxy-Cause: dmFkZTEo3giUd1iRoB5M8ubjAJnUph9QOqszYRsamVpVSMDt4/tIH/8DTzCOvv+4rxCWSo
    s4IM/o9fDJbPv6umbK8ZYC4TpT1mCIN81NaOw2WlJlzkgR5fg6DETUCmhbSagmOy3rfVE7
    fhYHBwTt45jHucSM/1+UC/FMyi6hEbTQq8ELQzZtJNN2F5QyfsgkIHyEBcERAFlBSQTtI/
    DoZ9tXn5vrtTyp/heYgny+Vnj9oog2WbMDWR5mKyhil9EhXIH9PRz5cXC0MlaFLa112QbK
    CPkimVTeMsPoV8VB2iBDM5JCNIliA4Rxryug8NdPTp19zve4mQhnvLGJ0xMlYrviIsihhx
    BlCiT8WnT82vJ9QbsiHOa2U/TpVnPXThmnP4mdn4bhM58FUoErbu2aIP6nHx7ce/UoLrPK
    U/ncJpuu0s1w9oKIl6M2XOF3ycyIutX7uMX9XDq7dVtXt/hTOeLqVxy4D+gdm7RabBJ6/L
    a/LYzN951+/msKvngPEwWh4euT2mtaVhtLUSjP24b+m2g5VpJkf+JtTu0JBoqUxeEa3saX
    IZoBasPVfOTx0lTbD5L2t5R9oS/RVuATmkwmOmRdwX3hF8xFzwRUGc4Qz+I1sNh84VT+xX
    3wGWhS+qskggoB1a4Hw07a+vvEbhGNuVlXi13s4iEtHlpWfau2n/rCMmvHcg
X-ME-Proxy: <xmx:P7bgatLIhjka4EIvrvQSz6sNg0E-JrJHkKiUSsLD-ZnrdAF59ybb2g>
    <xmx:P7bgaoVIM6QabC0JTJ8rFbQTZ-7GDDk_vHUjkBLvUUWefS2mudDAoA>
    <xmx:P7bgaobJyuqR7Oi8foOrZpjvLnQc4EeBMuXBnTQXc14QFq95hCQIHA>
    <xmx:P7bganxrP-32bq-Rzu4nyxOo9r6dz3T2EVUqN0p0pXApXM9jAbYUHw>
    <xmx:QLbgarYK1P-ovsO6HCo0ahcR2pEkFw0Kk87VMw-UdM2ZH4sQ3BQ6WPmh>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:33:35 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 66DE71C0432; Tue, 27 Oct 2026 07:33:33 -0700 (PDT)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 662131C024E;
	Tue, 27 Oct 2026 09:33:33 -0500 (EST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: ramses@well-founded.dev
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Jiri Bohac <jbohac@suse.cz>, Eric Dumazet <edumazet@kernel.org>,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v3] bonding: fix initial last_rx vs ARP-monitor slack window
In-reply-to: <20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev>
References: <20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev>
Comments: In-reply-to Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
   message dated "Tue, 27 Oct 2026 13:23:29 +0100."
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
Content-ID: <74902.1793111613.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 09:33:33 -0500
Message-ID: <74903.1793111613@vermin>

Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org> =
wrote:

>From: Ramses de Norre <ramses@well-founded.dev>
>
>bond_enslave() seeds a new slave's last_rx with a timestamp old enough
>that the ARP monitor does not consider the slave up until a real ARP
>reply arrives. That is the purpose of the seed, see commit f31c7937c254
>("bonding: start slaves with link down for ARP monitor").
>
>The seed is one arp_interval (plus a tick) in the past, which was just
>old enough when the test was "jiffies <=3D last_rx + arp_interval".
>Commit da210f559019 ("bonding: add some slack to arp monitoring time
>limits") added arp_interval/2 of slack to every such comparison without
>adjusting the seed, so the seed now sits inside the window instead of
>outside it. For the first half ARP interval after enslavement,
>bond_ab_arp_inspect() therefore sees "received recently" for a slave
>that has not received anything and proposes it UP. This happens for any
>freshly enslaved slave, independent of primary_reselect.
>
>When the slave is the configured primary, the still-armed force_primary
>then makes it the active slave. ARP validation fails it shortly after,
>since the link has not received anything (on SFP+ ports the PHY is
>often still negotiating), and the bond falls back to the backup. With
>primary_reselect=3Dalways the bond recovers once the port really comes
>up, but drops traffic until then. With primary_reselect=3Dfailure,
>force_primary has been spent and the bond stays on the backup.
>
>Reproducer:
>
>  ip link add bond0 type bond mode active-backup arp_interval 1000 \
>      arp_validate all arp_ip_target 192.0.2.1 \
>      primary eth0 primary_reselect failure
>  # eth0: SFP+ (slow link-up), eth1: RJ45 (fast link-up)
>  ip link set eth0 master bond0
>  ip link set eth1 master bond0
>  ip link set bond0 up
>  # bond0 lands on eth0 via force_primary, ARP-fails it before the
>  # SFP+ has carrier, falls to eth1, and stays there.
>
>Seed last_rx (and with it the per-target array and last_tx) two
>intervals in the past, so it is outside the slack window from the
>start. The initial link state is unchanged, it still comes from
>netif_carrier_ok().

	If the missed_max bonding parameter is set larger or smaller
than the default of 2, is your seed of two intervals still sufficient to
resolve the problem?

	-J

>Fixes: da210f559019 ("bonding: add some slack to arp monitoring time limi=
ts")
>Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
>Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
>---
>Changes in v3:
>- No code changes. Rebase on current net.
>- Reword the commit message along the lines of the v2 discussion: lead
>  with what the last_rx seed is for, state that the false UP happens
>  independent of primary_reselect, and that the initial link state is
>  unchanged.
>- Pick up Reviewed-by from Hangbin.
>- Cc Nikolay. Hangbin asked for a second review, Jay or Nikolay, would
>  you have a look?
>- Link to v2: https://patch.msgid.link/20260827-bonding-last-rx-v2-1-7c38=
33822c23@well-founded.dev
>
>Changes in v2:
>- No code changes. Resend with my personal name in the From and
>  Signed-off-by lines instead of my handle, as requested for the DCO.
>- Link to v1: https://patch.msgid.link/20260817-bonding-last-rx-v1-1-9da6=
f7fdf812@well-founded.dev
>---
> drivers/net/bonding/bond_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 7019e5d8fdc8e..269384fadfa6f 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2123,7 +2123,7 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 		new_slave->link =3D BOND_LINK_DOWN;
> =

> 	new_slave->last_rx =3D jiffies -
>-		(msecs_to_jiffies(bond->params.arp_interval) + 1);
>+		(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
> 	for (i =3D 0; i < BOND_MAX_ARP_TARGETS; i++)
> 		new_slave->target_last_arp_rx[i] =3D new_slave->last_rx;
> =

>
>---
>base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
>change-id: 20260817-bonding-last-rx-0303fa048f9d
>
>Best regards,
>--  =

>Ramses de Norre <ramses@well-founded.dev>
>
>

---
	-Jay Vosburgh, jv@jvosburgh.net

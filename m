Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793103813;
	b=D+RPtFR3xmrNjbcpct8SoIvtenkgaMvOE0NBaDOP369VI1lhjDWnpULjsVz7fWJeoAJ8
	 Rhqix3uxu8PgwBmkUbq5sWVccjeqJa4S/CafeLdeYuCJ1WMJprF9eF1CaMI6ZWv98QxWO
	 bU5XYhQzPy+CnXS6ZteGs67LLnY2a9fNeGqPXCQ1KuHr2XonXmK3VsK+ebu/z47yJWdi+
	 uxDoyPXc8mgL+SQRLtFsVR+0bIzCLyEWYH4sQWXbGgdUm6Rftnr1JfdxTahelswG4CSXi
	 +KFFFjBOIqYqWwxU0riN3eEYubqoBxdi46FxWjqSIjouajrG6t6XuUCEca7XdkCHZ0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103813;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fpfsmU+OZOP/dnJV2FFDnyzaNyuyVQpqhZJOIXOEgto=;
	b=ALD/kOfI0Xxa9AdjQs+9NoZb6s6oadZeeVo/ha/dU6xc5XlMiYb/Sy+UZjbaHcDetj9C
	 obRWDvwKsLzcu7ViLXsG9c6AannnZq+CjlmqWLJTb8DSqYny13RtYy58Qs5VE396M5bwx
	 q9necv4WbFn/9HzY4+1BfZ9VHgRBsto3D3a/BmW/bKmtgy82C5Bbx/tbNvwq3JvVc/4sx
	 RwVv2wI7GPfX8CwdPBASofXjbJA2FvABEwjSopI5DDwqFgdcb/xY2jHviDfRe/XeWMPoG
	 ifWmcA0vQR8I6flhgQKseMT9kQJ9uz04J0YWFAnkFxcOQCYCU3op+/ZRO3K+t2u0RXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceKt1GWr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036B606A31B;
	Tue, 27 Oct 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceKt1GWr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793103812;
	b=mApP1oDtXXpJYnSQkPq8dywRMWr4VjGoNBk0eAgG4MI9234EVYTy0ClmKZ4744z24zRf
	 sZ1r9fyzrSqk6jRIaVu/gDuLhWRYMiFusW0a6Lp3bu9o8q2aPE/c9xWLJT7i6z2iBmChD
	 tMxP8Y6tusHo6cbBW3bdoIv1wwSWsO1Vf/ANPabfKPfPHiGDcOiOu8Glsn/jwAfSd3ZS2
	 BQ00zgsdFM9APCJ7hjc6xIABhv6JVR2/4uvGW6Q6a3ySx5YygLPLoDXSEt6f639q4AvJl
	 2zVSPHpuz6Ap0E/zyAuvIJp2r6ro9rO354FoEMK2x2wg71dTch8XXrRWKzHmtFEeuJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103812;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fpfsmU+OZOP/dnJV2FFDnyzaNyuyVQpqhZJOIXOEgto=;
	b=tTiKjryWpI7sCPVhXnh1IuaE+dvRtdD49lMMpeBP4X5HGhOHb970vyLRrFNn7HNT+5JC
	 nYy+vHb2qxJD+nmsOX6LLxLKn3Oe1+ncYLtc24HjrjeFtQNEmAthxZc6PuwWxO/UXXLrS
	 0clXejoRXJ1I/qVjGF4rVTlyDoNRm/vxg49ePNY5Wf/XSK8qaY/Jo7Ja5b6VaZDbFuJel
	 aPPYYj/cNJQMsabpHAfiH1YyO3lnTHc4QHI58YeOEFcJgkYXXBveu4u5VK1uRr1Vgw5VD
	 VkgF+cr8KwIjY7Adzvto1fZKBOt7Y5sZJQypcRfZdsaSuJVU2UcvRjO7u0xDbdFtGGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 102561F01825;
	Tue, 27 Oct 2026 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103812;
	bh=fpfsmU+OZOP/dnJV2FFDnyzaNyuyVQpqhZJOIXOEgto=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ceKt1GWrVji2BS5PBXOOpPeCS5OIj8k6aAYvRxKFByT3BvU2mVxc9pp3r3jYBCHIJ
	 wCzKm5LONpHit+PHLz50oRlApTkrgecvhjQQ+xLbz/MfxQfLSImnxE2F7dJgVCmAlF
	 29nQy6gStAjQOh4V/25MsiMp4R9RXlm6GEhE6i/EWO0nbvxSl4o2jKqGjffFrbYxxh
	 mRYZnq/B+LM2VcP7PA0axLBaQH95w11kF1YSM2ObmXOJZa6a87xPDmbeYaTKXS4BPN
	 GtcDv7vT+8coJK+pH4xMxQ2x/rwQoODNvPrrjhq5O9dwLawe8nAJKDxlVzndnCEmPt
	 7UgZ9/O+EsX+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 96FA1450B8;
	Tue, 27 Oct 2026 12:23:31 +0000 (UTC)
From: Ramses de Norre via B4 Relay <devnull+ramses.well-founded.dev@kernel.org>
Date: Tue, 27 Oct 2026 13:23:29 +0100
Subject: [PATCH net v3] bonding: fix initial last_rx vs ARP-monitor slack
 window
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-bonding-last-rx-v3-1-54907f1fb042@well-founded.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBAF0KsY1mJgMC115T2MixaGFtNQAxRrm
 t7dFjcu6vJP/rw/k4DeYiCXw0w8Jhvs4NYgjgeiutq1SK1eMwEGBZO8pM3gtHUt7esQqZ8oE0y
 Ymp2lqTRZv54ejZ2yeCMOI7l/j2FsHqjiZm21zoY4+HfeTTyX/04kTjmtdF2Y0mgjOVxf2PfUD
 KPTqE8aUx5J8MPADgMrUyohhZAACsQOsyzLB7lsV8cTAQAA
X-Change-ID: 20260817-bonding-last-rx-0303fa048f9d
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, 
 Ramses de Norre <ramses@well-founded.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793103811; l=3887;
 i=ramses@well-founded.dev; s=20260817; h=from:subject:message-id;
 bh=iLuXMQJ1SxlaYAgJ6k8T6L5P5ZUpQnl669RJjA7KhuI=;
 b=egGJkC94lXuW0zEaKLESCsSkMiu5EmZPrr3lE2In3Bof0dnjmZZWq9wH8A97RhZNl12/YvHI0
 NRTktxnngChCKVB2BJwwHAhhrD+AuF5ntrFDgOzcSTamrda8Z8QoGu1
X-Developer-Key: i=ramses@well-founded.dev; a=ed25519;
 pk=1vBXHBVeJBMaC+2Zuonl0QQhEgGIQHERyF5RZNnrCmw=
X-Endpoint-Received: by B4 Relay for ramses@well-founded.dev/20260817 with
 auth_id=957
X-Original-From: Ramses de Norre <ramses@well-founded.dev>
Reply-To: ramses@well-founded.dev
Content-Transfer-Encoding: 7bit

From: Ramses de Norre <ramses@well-founded.dev>

bond_enslave() seeds a new slave's last_rx with a timestamp old enough
that the ARP monitor does not consider the slave up until a real ARP
reply arrives. That is the purpose of the seed, see commit f31c7937c254
("bonding: start slaves with link down for ARP monitor").

The seed is one arp_interval (plus a tick) in the past, which was just
old enough when the test was "jiffies <= last_rx + arp_interval".
Commit da210f559019 ("bonding: add some slack to arp monitoring time
limits") added arp_interval/2 of slack to every such comparison without
adjusting the seed, so the seed now sits inside the window instead of
outside it. For the first half ARP interval after enslavement,
bond_ab_arp_inspect() therefore sees "received recently" for a slave
that has not received anything and proposes it UP. This happens for any
freshly enslaved slave, independent of primary_reselect.

When the slave is the configured primary, the still-armed force_primary
then makes it the active slave. ARP validation fails it shortly after,
since the link has not received anything (on SFP+ ports the PHY is
often still negotiating), and the bond falls back to the backup. With
primary_reselect=always the bond recovers once the port really comes
up, but drops traffic until then. With primary_reselect=failure,
force_primary has been spent and the bond stays on the backup.

Reproducer:

  ip link add bond0 type bond mode active-backup arp_interval 1000 \
      arp_validate all arp_ip_target 192.0.2.1 \
      primary eth0 primary_reselect failure
  # eth0: SFP+ (slow link-up), eth1: RJ45 (fast link-up)
  ip link set eth0 master bond0
  ip link set eth1 master bond0
  ip link set bond0 up
  # bond0 lands on eth0 via force_primary, ARP-fails it before the
  # SFP+ has carrier, falls to eth1, and stays there.

Seed last_rx (and with it the per-target array and last_tx) two
intervals in the past, so it is outside the slack window from the
start. The initial link state is unchanged, it still comes from
netif_carrier_ok().

Fixes: da210f559019 ("bonding: add some slack to arp monitoring time limits")
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
---
Changes in v3:
- No code changes. Rebase on current net.
- Reword the commit message along the lines of the v2 discussion: lead
  with what the last_rx seed is for, state that the false UP happens
  independent of primary_reselect, and that the initial link state is
  unchanged.
- Pick up Reviewed-by from Hangbin.
- Cc Nikolay. Hangbin asked for a second review, Jay or Nikolay, would
  you have a look?
- Link to v2: https://patch.msgid.link/20260827-bonding-last-rx-v2-1-7c3833822c23@well-founded.dev

Changes in v2:
- No code changes. Resend with my personal name in the From and
  Signed-off-by lines instead of my handle, as requested for the DCO.
- Link to v1: https://patch.msgid.link/20260817-bonding-last-rx-v1-1-9da6f7fdf812@well-founded.dev
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc8e..269384fadfa6f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2123,7 +2123,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		new_slave->link = BOND_LINK_DOWN;
 
 	new_slave->last_rx = jiffies -
-		(msecs_to_jiffies(bond->params.arp_interval) + 1);
+		(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
 	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
 		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
 

---
base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
change-id: 20260817-bonding-last-rx-0303fa048f9d

Best regards,
--  
Ramses de Norre <ramses@well-founded.dev>



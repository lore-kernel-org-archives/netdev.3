Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757160;
	b=z4SVqqSquR+eEm1iHPxsH8ofFEOFVBSgB1c1kzfhPUapJRUYl3dWYer2EYzlqrJDJYCx
	 LbQoVwB6iM4J9FOdbEqI1H0asIJ76q8VCRIlHKa2cWoNggTUlWZ7IaqEc/FAt2zoHOqh9
	 sqrR67Gx1PtOsJ9qeebH7frKpouKMvQMWf+tX1cCGBPhinHGFIbijYFkvE8UwTdr1LG0W
	 Yiw2r7przNBjTWsWFkICh6hzICdtoQ+BG2xmBRSP5+LTcnWpAirHx076luAcH6m3atJbG
	 LgciW+wkPgx1hWiGGMCazMhfE+Aku7Vua9S8E8TQXujjMXrYuZmzsozieQVbhHamsaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757160;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=CHvv0Ghh9PRrTAtIAXczD8TlBySiVNCv/5eTBqpNKPQ=;
	b=X5OblVrZfktnCwkXw4j9ADxbi+EDtnzP1P2qK4SqAiK5wePAlyTrEktudd2n+YBWbz2g
	 DijxFONmwe6EWr3hAgyuuYYX08r1IJGAN6clyHeunFm5giDvfFaBdtOeTB+3PqQy2NT9G
	 X8qDUjPFiGtBtKqpyToB+XOYE9oipdlVpDmQP4mFLRnEoRO1xbOPRuhmnNdxSlTfpeBML
	 KS0Tnjz5M+hjgJyKq8GUIAYipiDB6GNDlh+eJ2t4rt1jq/eFxCnspBKDHC5r/aFMiG+68
	 y26fsj0n1nAZRbhvEBzVUHFwVeX6+tD9vEXbmkGLdLpCDi2rYdxin6qi4Z9IyODKe0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=ZE4rUETF;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9D727606A31B;
	Wed,  4 Nov 2026 01:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D727606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=ZE4rUETF
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nikola Z .
 Ivanov" <zlatistiv@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Hangbin Liu <hangbin.liu@linux.dev>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2] team: fix promisc/allmulti leak in team_port_add error path
Date: Wed, 4 Nov 2026 09:52:17 +0800
Message-ID: <20261104015217.2222-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793757148;
	bh=CHvv0Ghh9PRrTAtIAXczD8TlBySiVNCv/5eTBqpNKPQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ZE4rUETFbIf/H/J2O/TDLhj0ByTjgRnjkE9IRsTz9/OzKb38YJI18ZApeLLrmbjO0
	 1uob5z7vOI49N+dUyQhnNPYTuNSwnvAHKfOY7F/WJd7DB+sXhDUUisbJ5VHvU5myO6
	 XA4iFLkvK/hN2xXBuMt+aIVBb18SAZGN4V5ntCAxyAZKCGl+aQ4i4mRKRS+7yfWFod
	 RruiZJjPSYuLO7Vxnjq7ytoBGSXGsKDlFzB1fkiWCeFzKPardgPeT5Av6WdM9q0AuS
	 313Nkgd+QZsl+yCSk4VF++N+B8XRO9RSqfFF67Pj6bJwQQXU53TLPwaCtAI6uzLgwt
	 J2ZEcvlhy0kng==

From: Li RongQing <lirongqing@baidu.com>

team_port_add() increments the port's promiscuity and allmulti
counts before calling team_dev_type_check_change(). If the latter
fails, the error path does not undo these increments, leaving the
port in promiscuous and allmulti mode even though it was not
successfully added to the team.

Undo the promiscuity increment under err_set_slave_allmulti and the
allmulti increment under err_set_dev_type, so each error label only
reverts what was successfully applied, matching the cleanup performed
by team_port_del().

With the promiscuity rollback now living under err_set_slave_allmulti,
the inline dev_set_promiscuity(port_dev, -1) in the dev_set_allmulti()
failure branch becomes redundant: that branch already jumps to
err_set_slave_allmulti, which undoes the promiscuity increment. Drop
the inline call to avoid doing it twice.

Found by source code audit.

Fixes: 0ae9cfc454ea ("team: Move team device type change at the end of team_port_add")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1:
1. Remove the dev_set_promiscuity(port_dev, -1); in if (dev->flags & IFF_ALLMULTI) and move it under here.
2. change Fixes tag

 drivers/net/team/team_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 957cc78..cfb833c 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1365,11 +1365,8 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	/* set allmulti level to new slave */
 	if (dev->flags & IFF_ALLMULTI) {
 		err = dev_set_allmulti(port_dev, 1);
-		if (err) {
-			if (dev->flags & IFF_PROMISC)
-				dev_set_promiscuity(port_dev, -1);
+		if (err)
 			goto err_set_slave_allmulti;
-		}
 	}
 
 	err = team_dev_type_check_change(dev, port_dev);
@@ -1397,7 +1394,11 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	return 0;
 
 err_set_dev_type:
+	if (dev->flags & IFF_ALLMULTI)
+		dev_set_allmulti(port_dev, -1);
 err_set_slave_allmulti:
+	if (dev->flags & IFF_PROMISC)
+		dev_set_promiscuity(port_dev, -1);
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
-- 
2.9.4


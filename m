Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 55A86490BF6;
	Mon, 19 Oct 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398709; cv=none; b=dPDjNb6rrguMAKcFhBoHhQlY1W0mI1+8GGsdysrKRXl0tDm4+5I4ojYVoy5KkhIPXF1UEPOGUmSpuq5nBod9OUngtrADGMr8l56GiO+fOlxM8RJE0Co3z2GmMrxiuU0Md1Y6e6KovG65XDqRYIbCWBaYVeHpc1V4+LJ5HyLszK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398709; c=relaxed/simple;
	bh=lcCdM9nY36pUot4cJnMNpDMUQBx/EKey6joCBlAhsos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyP/rNHLAsgV/AWczBEdHYqZHKwA65v/Ez7/ap4wf/sfx5cdFzVjp6XMNZWMyuK72UH4YXmE/pqh/wisvX9t+i+oZJKgDejwoCr6Jp+ADQxXKgEBsV6pfvvlV/rxpfVZANTR5zpQ8o6tRL6ka/xNAn3R5g9t8QlBhivu5kVnzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=FgL4WYaU; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="FgL4WYaU"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] team: fix promisc/allmulti leak in team_port_add error path
Date: Mon, 19 Oct 2026 16:31:22 +0800
Message-ID: <20261019083122.1841-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1792398697;
	bh=fM6nVphT01KKCr1ragQzNAOlPmkKz0tWFbqA9g+400U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=FgL4WYaUIaiTdmnJacBDX80iMh12paPAuLyPFaN7tki8jbJBozq6dwqBJyArSF8HP
	 X5tpQCz3gig5wBX4ocYhADPGF/I/DfjeJ3+a9JtL8/Sc8vtj3WzXkZRarNY11z0jBW
	 jj/5VezeKdAFGqD37bScJesLkGfbPTdvoOtUBDP1/17hptoHePYB5oexQAvOmeV9/+
	 gb9yVPOMzAbPM5lK9E+2sOZyDeAltbc8Vz7aZMZTHgzitLpA9JWc9967wlyuheoi58
	 56hH7ztRWV4FmktxAd8QtJdEm3RUFibmrkwqXNR+F/otKNlS4DTgwBL1fT+Qz4tbrV
	 gREM14YqYRBbQ==

From: Li RongQing <lirongqing@baidu.com>

team_port_add() increments the port's promiscuity and allmulti
counts before calling team_dev_type_check_change(). If the latter
fails, the error path does not undo these increments, leaving the
port in promiscuous and allmulti mode even though it was not
successfully added to the team.

Undo both increments in err_set_dev_type, matching the cleanup
performed by team_port_del().

Fixes: 43c2adb9df7d ("team: set slave to promisc if team is already in promisc mode")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/team/team_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ca75f08..3b30063 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1386,6 +1386,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	return 0;
 
 err_set_dev_type:
+	if (dev->flags & IFF_PROMISC)
+		dev_set_promiscuity(port_dev, -1);
+	if (dev->flags & IFF_ALLMULTI)
+		dev_set_allmulti(port_dev, -1);
 err_set_slave_allmulti:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
-- 
2.9.4


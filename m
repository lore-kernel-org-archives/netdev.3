Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379645;
	b=nrtbZ0W5m3jXxzmrQ+6y7bVDuAXch+zfJRNRpRO0kyl78qZscqgeSP+OPuNDpo5ivC5V
	 xfMkRESbrfzmu88vbZHYoGAYZzFBmXYgHs/BpccCMlLNwoUTdlCTXlyvEzI/7q9rqlvgU
	 YGzhw5zh44LqG9N1Kv1Eb31Tx/VJ9UhPpNyWOO6seBSe7NupDX/o7KLWbFHyrrmlDIK12
	 fMucvlPXWzHWypxgfWisiXV9OeghJyg5Gaa6Bjyr5iJ/QDVOzYuDFeF9QkbJttKTIsplu
	 y1l8Qtzx3GMdhGQ1KH6ltbnWX5nUw7EXZhkwzysHVZABau4GDBU8AXDfLKf3/whZCgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379645;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FhfwlU4Cu7/dKeluYJ5+3JUKxIlFopvSssPKy+noPwE=;
	b=b0Luzbm6otx+gGoi8Vr1irxfDgoMwmgS32ocm+cyjUt4rqC+bZKOzbK4y5zCVfuimHTa
	 c3aXRVLJ5hrD0F3v3y6W9qfd7wOyY6Hd5jIiN7g8E/Dk1bUNhwg8c6rkr+sXlGq3zPgfg
	 F0b1ewXIHcCjxjJ+jfeI7iEraj7NfNcM21cfB6cj1X9vM+4CTkpd7OPcFiVPfGqfy9imb
	 hbA7i+Fv1zGyhnzjl265LkXFyn0QHBzAeQkfphINuL3ZLmG8iENjIbn3hDZZWb0/jrfaa
	 AidrGAisFoXukoixWi7HrIhhdlXNwN38Z12XmnkPYCtd92ExP2nfwQ2SzMy+ditl6+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=yj3v71IP;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9E0606A33B;
	Wed, 11 Nov 2026 06:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9E0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=yj3v71IP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=yj3v71IPAG7S/R7e7wSHYDSjpZYxoDv6iU4cSSiZS1z+PWQ2psdaYlwQWcO0zXQB6TxS3njrGaCBx
	 Ds5KaTOyhR4nL0LDwACnWYXPKtKWXle/WiMctc/ojkh9cwSg/a9BXpJLG01b9fkz5cI8nzdt5+LT08
	 0lBUb9alb7DvAw3M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af40f795cf-d2bc0;
	Wed, 11 Nov 2026 14:47:21 +0800 (CST)
X-RM-TRANSID:2ee56af40f795cf-d2bc0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af40f78f42-d10dc;
	Wed, 11 Nov 2026 14:47:21 +0800 (CST)
X-RM-TRANSID:2ee36af40f78f42-d10dc
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Mahesh Bandewar <maheshb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] ipvlan: update port flags only after ipvlan_set_port_mode() succeeds
Date: Wed, 11 Nov 2026 14:46:55 +0800
Message-Id: <20261111064655.233265-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ipvlan_link_new(), the shared port->flags is updated before
calling ipvlan_set_port_mode(). If ipvlan_set_port_mode() fails (e.g.
switching to L3S mode without CONFIG_IPVLAN_L3S), the error unwinds via
unlink_netdev, but the shared port->flags has already been modified and
is never restored.

As a result, subsequent operations on existing ipvlan interfaces on the
same lower device operate with corrupted port flags (e.g., VEPA or
PRIVATE flags inadvertently set or cleared).

Fix this by deferring the update of port->flags until after
ipvlan_set_port_mode() returns successfully, matching the behaviour of
ipvlan_nl_changelink().

This issue was identified with the assistance of an LLM-based code
review tool, confirmed by reproducing the state corruption in a
User-Mode Linux (UML) environment when ipvlan_set_port_mode() fails,
and verified in UML that the shared port flags remain unchanged upon
failure.

Fixes: a190d04db937 ("ipvlan: introduce 'private' attribute for all existing modes.")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index f29864db662a..5732b167c5b3 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -678,12 +678,6 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (err)
 		goto remove_ida;
 
-	/* Flags are per port and latest update overrides. User has
-	 * to be consistent in setting it just like the mode attribute.
-	 */
-	if (data && data[IFLA_IPVLAN_FLAGS])
-		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
-
 	if (data && data[IFLA_IPVLAN_MODE])
 		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
 
@@ -691,6 +685,12 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	if (err)
 		goto unlink_netdev;
 
+	/* Flags are per port and latest update overrides. User has
+	 * to be consistent in setting it just like the mode attribute.
+	 */
+	if (data && data[IFLA_IPVLAN_FLAGS])
+		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
+
 	mutex_lock(&port->pnodes_lock);
 	list_add_tail_rcu(&ipvlan->pnode, &port->ipvlans);
 	mutex_unlock(&port->pnodes_lock);
-- 
2.33.0




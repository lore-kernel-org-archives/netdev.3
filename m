Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466120;
	b=lP9+ZVQYHTmkgGwG8phVrZYMe0zwx+lK5yQHEzQdNvLFuG6axXgpZGqfZAk0FaHzPkhZ
	 NdS4VxAn+UXrmeIRLrSMi9h2phToRAZMOE8CJuv3wR2Cqe2rlYrIUqHpoyiyXykZrVyX+
	 XMnzM7porbnjq3hJ9HZw2XFQxKrlEL1wIemJCrsxj8oGEObU/5XYKRMoypmtEKcwxgyHK
	 MSmBHE6GjOhdeUTYjcEmXiFRnfgmUjWaXAKeNfYNFSSZ/oggACk+xAsZVhjeStzm6oUFN
	 JHQqz5Vu4S1k4jajFKJJU8nkhgrUwgXsPa0J/XK22FPrNNnhfCMfXKKz5YYRuOuDMIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466120;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wTWBtNCAGodQDgAKD3Exz5ymS4Zkos+iD05/S8F8FRo=;
	b=ZtPgra3tziiTjFRscmQD0mk2afuJWyMP8noP1TgbyXo/vnWdEpgSQ+in0+x8v+Uworak
	 f7OPKQ/2s5rtTArfzr/BB4WsgILjyRhcO53KGLZ4hA+dDsGbQxztWzPLACZy3CEMQxXYF
	 n5I00jRXn60bvuHYmzagzamghQFOc9DUwsiCLLhg0MX82zUT/GFqC91vxwiTmskkvPaMN
	 6eh0KOcc9WAKr1LNRuzAUY0QD9uKpENFryLH33sSr/jgUMA1AtcqqDXZiK9+QnqBW3QuE
	 R1IPFuI1Lr5LePsookgrb8Q5vH3l/oBNnr61bJIezMqZkn0jD6MoRW10CRuwrGDiD2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=go+4XAhb;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA222606A31C;
	Thu, 12 Nov 2026 06:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA222606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=go+4XAhb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=go+4XAhbQSlP+ATyT0OTeLGBSWaKbhXbl3lfp6NuaTIlYHFGPFwg5Qz6is5YJTOCpYjIOEZW9W69X
	 pfDfIhTzLX7U6tlenn6eG64PhoLDZZZ52DKbdG1mRPyDwokg7V/UigNypRLQZyzRkkDNwfY4dQEEzY
	 /Ky0l3Sbu1Aq8ggk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af56144d6f-1ace7;
	Thu, 12 Nov 2026 14:48:37 +0800 (CST)
X-RM-TRANSID:2ee26af56144d6f-1ace7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[112.23.105.204])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af56144729-f5b20;
	Thu, 12 Nov 2026 14:48:37 +0800 (CST)
X-RM-TRANSID:2ee86af56144729-f5b20
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Mahesh Bandewar <maheshb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net v2] ipvlan: update port flags only after ipvlan_set_port_mode() succeeds
Date: Thu, 12 Nov 2026 14:48:21 +0800
Message-Id: <20261112064821.85624-1-sunwenbo@cmss.chinamobile.com>
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

In ipvlan_link_new(), port->flags is updated before calling
ipvlan_set_port_mode(). If ipvlan_set_port_mode() fails (for example,
when switching to L3S mode without CONFIG_IPVLAN_L3S), error unwinding
calls unregister_netdevice(dev) via unlink_netdev.

While unregister_netdevice(dev) destroys the port when creating the first
ipvlan device on a lower interface, struct ipvl_port is shared across all
ipvlan interfaces on the same lower device (tracked via port->count). If
another ipvlan interface already exists, unregister_netdevice(dev) only
drops the extra reference and leaves the shared port alive with the
updated port->flags, unintentionally altering the flags of existing
ipvlan interfaces.

Defer updating port->flags until after ipvlan_set_port_mode() succeeds,
after which ipvlan_link_new() has no remaining failure paths. This avoids
modifying port->flags on failure without needing to save and restore it,
matching ipvlan_nl_changelink().

This issue was identified with the assistance of an LLM-based code
review tool, confirmed in a User-Mode Linux (UML) environment by creating
a second ipvlan interface that fails in ipvlan_set_port_mode(), and
verified in UML that the existing interface's port flags remain
unchanged upon failure.

Fixes: a190d04db937 ("ipvlan: introduce 'private' attribute for all existing modes.")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
v2:
  - Clarify in the commit message that when creating a second or
    subsequent ipvlan interface on an already-active port,
    unregister_netdevice() only drops the extra reference rather than
    destroying the shared port, and explain why deferring the update
    avoids needing to save and restore port->flags (Hangbin Liu).
  - Soften and clarify the wording in the commit message.
v1: https://lore.kernel.org/netdev/20261111064655.233265-1-sunwenbo@cmss.chinamobile.com/

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




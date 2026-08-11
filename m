Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577C211A09;
	Tue, 11 Aug 2026 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414866; cv=none; b=Op/vo/UvaimycnKT+LCndBveHVivB5esRaNJoE4nfp6G2LLcKBy2ZjQ3nigtPNJx17Jqpb4B8NF8XmsD8sx0Wii15Wjw+VeIEOjhFWSoTzq0eP8Yqfon3soEBh9LW5eA4GQuirs6AJzULQ7lvUlt+HcIk9+ZEdzMOfz+y61o7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414866; c=relaxed/simple;
	bh=FWotcI3BD4aK/UxVqGL25bEr4XkZpyVmrvHf4aLWvIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtmcd4fgXFCbO1wuyiqB+5JDeybIN7IzqH40JIStOrg8uRD3hh7axJ6vZzKD/PsZPfb+WDEJYNyS2eJVZqjHb7N0EW1TUlPbh80CdUijx0wCYi9Ae9zSG3lYxbYcGM+vHT/sJ3cO0Yn+4dEnhp7yqqcYvIPrZNcYw/jRO1WX5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=amNigSm8; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CBKkIIgf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="amNigSm8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CBKkIIgf"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hJwMr1gn5zKnPZ;
	Tue, 11 Aug 2026 04:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786414856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G9u6v+nOsbAGHUCFUdGgy8VZOBzISPEw7P+pjiss7iA=;
	b=amNigSm84qz82IOUJpzAK+Kx+IdGB7F714ndQx3jdf2dtwoKNNVdJo5caQpPxJj5t2K/37
	mAGtVovyOYpgSiQlb4Ck3vjZ6aCYQR3aI1E5se7fyA+HVL8MP/unwiIVgBokmq5psI2m9A
	31VAw9keFP9LAB92XdjqIliTFCIsGJbab0ngRquzGkZFQ2iiRdwWN4qXDf3Vo1gVOrsGJ+
	sHtsn1+PICX3OhBP/ihIiajLPeaX395kOvk+Vrw5SI1T6rbZjy8DNimzhvLrH3euwm3uz7
	55hc2KXHP1SnpyiasxTLLvqX7LC4OisyoJy/o+xTzhmyTG9Ij4sT4DPpNPhOhw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CBKkIIgf;
	spf=pass (outgoing_mbo_mout: domain of a0yami@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a0yami@mailbox.org
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786414854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G9u6v+nOsbAGHUCFUdGgy8VZOBzISPEw7P+pjiss7iA=;
	b=CBKkIIgfaDox9GLkjQgvlT1EurHnfIor6pgeaLzAQkoQ8xxfd1DqdlsghwOzZQTi0FF+vX
	g3puJ3ra5+Qtzz7N6Lir0Il9NgwZmn341UtBc1IGfp8wnK2JIptIEX96MTqWHQ9mNJfVsL
	uXSdNLUDL1Qd4/2T7yUaLUHWd6sWPBxmRGIegUdYI8HxKDl/jwq+f2bG+GKjLndc0GaFr9
	oUmuMW+gn/1uOOHtu05j6XhYtsvGdobhZ41r1jIHBxamMcyeXvVxs+T8QZxPMDA/adIypq
	Xi34kvsw6oIBDo3FSF95o5+O3VHpIq97f8DJiGpM+tfF2YsztZLlAWcsCqXdMA==
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH net v3] gtp: serialize PDP context updates
Date: Tue, 11 Aug 2026 10:20:12 +0800
Message-ID: <20260811022012.5416-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xfogs5wozktekcz3fkzxhm7w85rc6a8b
X-MBO-RS-ID: b1cc5d49342306793b9
X-Rspamd-Queue-Id: 4hJwMr1gn5zKnPZ

PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
network device is being unregistered. The latter is serialized by RTNL,
but the generic-netlink delete path only holds RCU.

Running both paths concurrently can therefore make both paths delete the
same PDP context. The issue was found through static analysis and
reproduced on a KASAN-enabled kernel by a two-thread program
racing GTP_CMD_DELPDP against RTM_DELLINK:

  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range
         [0xdead000000000120-0xdead000000000127]
  RIP: gtp_genl_del_pdp+0x1c1/0x420 [gtp]
  RBP: dead000000000122

The second deletion dereferenced the poisoned hlist pprev pointer.

Serialize PDP context updates with a mutex shared by gtp_pdp_add(),
gtp_genl_del_pdp(), and gtp_dellink().

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Assisted-by: Codex:gpt-5
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
v3:
- Rebase onto net/main.

v2: https://lore.kernel.org/netdev/20260808124322.5800-1-a0yami@mailbox.org/
- Use a dedicated mutex instead of RTNL.
- Protect PDP add, delete, and link teardown with the same mutex.

 drivers/net/gtp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..8ee516debeed 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -108,6 +109,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static struct genl_family gtp_genl_family;
 
@@ -1555,9 +1557,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -1833,6 +1837,8 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 	__be32 ms_addr;
 	int family;
 
+	guard(mutex)(&gtp_pdp_lock);
+
 	version = nla_get_u32(info->attrs[GTPA_VERSION]);
 
 	family = nla_get_u8_default(info->attrs[GTPA_FAMILY], AF_INET);
@@ -2134,6 +2140,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -2154,6 +2162,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 
-- 
2.53.0


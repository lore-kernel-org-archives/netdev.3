Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CA4137AE;
	Sat,  8 Aug 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193053; cv=none; b=JqxzvjBQVtkaBpgZvmfDF1pIfAar2v1sx8bqAAUpNXBf+8SHqljlR9Y/gVi+4fF4FIU0eUPM5S28TTWCWQBPocckhqnSIRtlREQ3y7fLCKK+yDZSZQ7xFJgpW8p/AVv5fPXw1bVeeS021r4EofOYVPH+TWhiq2U9XSRbf2quufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193053; c=relaxed/simple;
	bh=AyCwAk+ln85kFu6hhMaIl+YSNXLS2PZpC30KEfRSxwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfyiTkjTiFYjG/JEoumPEIUMIAbXenEfj4eCbI6kg6GOaOBjIuIsfbUrmnN+apxlBJwJPrGtojfEyIWdxoSo7D8IGISULcI3BRE/XPt4lXAMTA3PfIjPQLAG1+wVHWflMU3kIh4XCVgfH+zfgzYxI0884snETtxo5Tyx1+GjBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z06oxv30; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TfQvs5+h; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z06oxv30";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TfQvs5+h"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hHLL15tFDzKn8v;
	Sat, 08 Aug 2026 14:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786193033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KByHrrfP3MVUrI3GEmWsPaUCesxG0W7CgKlZBX3IEE=;
	b=Z06oxv30M8j+PWXWoW1FwPbVdImOgfN6jlqY6cPfpKjBLbstZm+HZqUVhsjKmkMuhCV69X
	qT0da8o37l41trBpfh8HsIUeP1pq/s+TR+ZV8nmZ4lMlv/GwIQ7AMbn2mv/IrEsDR/qt/Q
	rPb1shK4y3WHd6MYRbHW6Yf/GM+iAxlbqPhoxbx9cta/G+PKLUPRIkH6zr4GmW6oSolp9z
	MX6tb5+vV+l4IzJenznHpp1CwW5FvGfTrPTq37AqAEPzoeZYAE4uNIRWfL+sbS1Azc4gvJ
	NIDzBvk722v6pjumO+tAgtD7YdqG5e3ir5KfD6+aqx8hnWExETXZvdlWMsKRvw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TfQvs5+h;
	spf=pass (outgoing_mbo_mout: domain of a0yami@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a0yami@mailbox.org
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786193032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KByHrrfP3MVUrI3GEmWsPaUCesxG0W7CgKlZBX3IEE=;
	b=TfQvs5+hPZtVqkQCX9T8zhDzDX+qDNfcxHUFJ0EBirnK2+e8ta/jQbvPXU96/NcakSIOe0
	nKk7nhXRl2LCJCYu677CnCBuN17V+szOgRgUNn9i+bCXATh15WSRPLn7IGGrfoiiBjtXqE
	AfOg+4Cxm+kykAXuMw0wKHyjBUiP5NqJ15aDIYsLlkvdoz2Mslpg9N4E5WzKiFiaIX0uzY
	XN686QLtrsLZQP5XFEe+WUYJ70OEgRoHRVRVIcj/brLIYBd57Eoj9sENjthPmNnnlkypFj
	Vj34jQ1iGf03DsUbbVJLthSXKUETeFzpTdRkZcLMPcmKDDLtLQXrvq5KMHRvGQ==
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH net v2] gtp: serialize PDP context updates
Date: Sat,  8 Aug 2026 20:43:22 +0800
Message-ID: <20260808124322.5800-1-a0yami@mailbox.org>
In-Reply-To: <20260806023226.5537-1-a0yami@mailbox.org>
References: <20260806023226.5537-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 70714821da2be9dd93d
X-MBO-RS-META: xebd89fci4ggjya4sxsrgy6kbtip88sj
X-Rspamd-Queue-Id: 4hHLL15tFDzKn8v

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
v2:
- Use a dedicated mutex instead of RTNL.
- Protect PDP add, delete, and link teardown with the same mutex.
 drivers/net/gtp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 427b91aca50d..161d004e34b6 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -105,6 +106,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static struct genl_family gtp_genl_family;
 
@@ -1546,9 +1548,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del_rcu(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -1820,6 +1824,8 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 	__be32 ms_addr;
 	int family;
 
+	guard(mutex)(&gtp_pdp_lock);
+
 	version = nla_get_u32(info->attrs[GTPA_VERSION]);
 
 	if (info->attrs[GTPA_FAMILY])
@@ -2127,6 +2133,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -2147,6 +2155,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 
-- 
2.53.0


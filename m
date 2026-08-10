Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14E3EDAA2
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371094; cv=none; b=JTlNMUFepqRUzxxnXWGQAh4iQCndM5ZWh1dl5t9XX9MnfRquaqMrTy95dqaB0+jtj2N31JRoVWm8j8fwpVDDGZaVgiVcr1QsqfAlXHNyLOsdEjgPKtOcSej2mZ9s9Id9+8pBc7Cx2jz+6tqE3uUxzcoFvjexCyJm0hmZzrVKtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371094; c=relaxed/simple;
	bh=MLI2dy+CITZJUfRn+r4FhLKr2mO4v8ccuzCmNCGIA2Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=naI5TNFiq/ybPSHMTdwvyBxhbGRPfO853ECXubGKw2X/8xBbIshhkDY1+TLESfxnxnugOMcaRwBwZiOkHeEuJqiroVP9Bto7eJNCVo4eFF9ylJVt+7hj1E18J32kXoknrFsPtVSQ9PeQ4XcjK37CRJ3uwdEXUCSUZl9F4l/UbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoY8nSp+; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoY8nSp+"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-526da7e3c9dso16742401cf.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786371089; x=1786975889; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcHS/nuwmsgjwiAf8ICCrjjP61LEdpQ/ArmgBJs6ppI=;
        b=PoY8nSp+bQdXg5qQhmXft5bVhgTgCKKc4hl/kyKLknh/laxpMC73uuK+/e9g4madVz
         19OdMUkvlN/hFizZH+RqAXvbiIYBqOWR1UpIDb8ft62qChWCG99m3+WJyqoZR6XeFIVU
         454E4aKKDu1QPdXH9Mgm/Rfv70ATzkfpkhaUVeEFY4PJr1XanbM6ooLWr4O9+BzfZvPG
         t9Yn2drujLr+QFj+1Hk12K/xd8MS8k8KrLAp+kqP02WUhNE7SPI5xOrZU5o8As1pDqhQ
         VWPHqCfSCBh6MyYIkvMSddfv2u6ZcIeKYESisY/4BsH8X73+anruPSx7n2ZrYEO29N7e
         718w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371089; x=1786975889;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcHS/nuwmsgjwiAf8ICCrjjP61LEdpQ/ArmgBJs6ppI=;
        b=Zmp4b+cebALpQpEa7AQgTUTHrUOY2aXcPg9c8Pyes0vfUaGyvprW+xrqPCwmzJodxG
         g8C6KifwoEk+QNW9VUjnG7vxOIc8LwltJlTObMpdtRzXoSsmSiycxa0d8o2hO4piQvro
         0DRbRbvX9gewWR2QkhJKw8pFBOKK8Nh1RhlzdJht8nSX06PL8B+dIVSlkmv9/FnKpo1s
         ZsZmNZFilt9cq/8+AnSYKpHhs3GAsF+LZ02iaOQ64ZwgDzLas0wHdorAtnkXWAYd0OGN
         WEahd4JbdVluYUbMn1RoLw36tyO4HjZW79bcBK4+WgI65Td5VntMfwiUyTeqrho/XIgx
         jzCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIvPyAcgNKEaWvV3xJdvMBU18UEd2+eFMVowiMocQSGYxNApu0g1mDnuv+09w45F3SxupYC9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytnHTOehQ80h632xgKGm4RswYUoWXSJbgLHAZ2KexSvIJQI9z6
	H+agQPpvdOe1RPJP9iGmMWuhOoUkMBG07bFLnlkmjcbVOTpl7Xnev1iI3INSNImocO37aUruSNd
	ZwB2Iiy4NESGf7Q==
X-Received: from qtam7-n1.prod.google.com ([2002:a05:622a:e107:10b0:51c:9f19:4c92])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6205:b0:51c:b900:5136 with SMTP id d75a77b69052e-52d4bb87e3cmr23454641cf.0.1786371087258;
 Mon, 10 Aug 2026 07:11:27 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:11:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810141125.1176545-1-edumazet@google.com>
Subject: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on seq_file release
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com, 
	James Chapman <jchapman@katalix.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In pppol2tp_proc_open() and l2tp_dfs_seq_open(), iteration state
(pd->tunnel and pd->session) is kept in seq_file private data to allow
iteration across multiple read() system calls.

However, if userspace closes /proc/net/pppol2tp or /sys/kernel/debug/l2tp/tunnels
before reading to end-of-file (EOF), any tunnel or session reference stored in
pd->tunnel / pd->session is left un-dropped when seq_file private data is freed.

Fix this by dropping any remaining pd->tunnel and pd->session references in
pppol2tp_proc_release() and l2tp_dfs_seq_release() when closing the file.

Fixes: 0e0c3fee3a59 ("l2tp: hold reference on tunnels printed in pppol2tp proc file")
Fixes: f726214d9b23 ("l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file")
Reported-by: syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a760f32.01d0871a.3a0d52.004f.GAE@google.com/T/#u
Assisted-by: Jetski:Gemini-3.1-Pro
Cc: James Chapman <jchapman@katalix.com>
Cc: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/l2tp/l2tp_debugfs.c |  4 ++++
 net/l2tp/l2tp_ppp.c     | 51 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index b26986fda9d6cf096519d56032fe3deb5034c7c8..c12d5e1ee550ccc2608b6128cb653ca373280373 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -306,6 +306,10 @@ static int l2tp_dfs_seq_release(struct inode *inode, struct file *file)
 
 	seq = file->private_data;
 	pd = seq->private;
+	if (pd->session)
+		l2tp_session_put(pd->session);
+	if (pd->tunnel)
+		l2tp_tunnel_put(pd->tunnel);
 	if (pd->net)
 		put_net_track(pd->net, &pd->ns_tracker);
 	kfree(pd);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f8881699e1cad88e6f312e6ca47ae0af94c6137c..1bcf447f2f8b08235fdec747d33fd188e869a382 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1597,6 +1597,53 @@ static const struct seq_operations pppol2tp_seq_ops = {
 	.stop		= pppol2tp_seq_stop,
 	.show		= pppol2tp_seq_show,
 };
+
+static int pppol2tp_proc_open(struct inode *inode, struct file *file)
+{
+	struct net *net = pde_data(inode);
+	struct pppol2tp_seq_data *pd;
+
+	net = maybe_get_net(net);
+	if (!net)
+		return -ENXIO;
+
+	pd = __seq_open_private(file, &pppol2tp_seq_ops, sizeof(*pd));
+	if (!pd) {
+		put_net(net);
+		return -ENOMEM;
+	}
+
+#ifdef CONFIG_NET_NS
+	pd->p.net = net;
+	netns_tracker_alloc(net, &pd->p.ns_tracker, GFP_KERNEL);
+#endif
+	return 0;
+}
+
+static int pppol2tp_proc_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct pppol2tp_seq_data *pd = seq->private;
+
+	if (pd->session)
+		l2tp_session_put(pd->session);
+	if (pd->tunnel)
+		l2tp_tunnel_put(pd->tunnel);
+
+#ifdef CONFIG_NET_NS
+	put_net_track(pd->p.net, &pd->p.ns_tracker);
+#else
+	put_net(&init_net);
+#endif
+	return seq_release_private(inode, file);
+}
+
+static const struct proc_ops pppol2tp_proc_ops = {
+	.proc_open	= pppol2tp_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= pppol2tp_proc_release,
+};
 #endif /* CONFIG_PROC_FS */
 
 /*****************************************************************************
@@ -1608,8 +1655,8 @@ static __net_init int pppol2tp_init_net(struct net *net)
 	struct proc_dir_entry *pde;
 	int err = 0;
 
-	pde = proc_create_net("pppol2tp", 0444, net->proc_net,
-			      &pppol2tp_seq_ops, sizeof(struct pppol2tp_seq_data));
+	pde = proc_create_data("pppol2tp", 0444, net->proc_net,
+			       &pppol2tp_proc_ops, net);
 	if (!pde) {
 		err = -ENOMEM;
 		goto out;
-- 
2.55.0.654.g21b8a5bc05-goog


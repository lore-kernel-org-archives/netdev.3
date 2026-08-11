Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956C43C05F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459618; cv=none; b=KOQvs64i8k/FWGX2clizAb16oQEvEUBq4Wci3yrdfFWq7JPumQvC7Z0F/coaETCjZH8UNgStJTYJtFw5WmSNYKzljgYSWU82wvaYA7Dh9h0IBD3pwJPRnC2wbHNm3yp7hy1jFXK3TDvQChqZW+rwyMh02FkRxBwpq0l4BD2lrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459618; c=relaxed/simple;
	bh=ZyYVCsTx0DYcD8s0NCcYFq/lxYTZxXhmolqRHg0AO8U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=neKKzlN2BKNkk7n/QsZr5IC24vLR3UP03WCxRJhzArEsM4mU3h3eVe2TrqUXeo44iw+R3ts9X5lh0KeH6XzjjQN13Ep59Kwg0RonlVr1OhuggwFuYPY0Vsk7DdQ5J7K0wvqFJ5k07uaZWvbD5JVvLszxwDZ5bc/4D6i84iN6RXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNTG3h6j; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNTG3h6j"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e820609d9so302974085a.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786459615; x=1787064415; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xXgGTHWtn0Us9yQ9pyaNr0IxhkN70QWQjDXeZ56LgHk=;
        b=cNTG3h6jt8oLPF4kclXGKEKDpE5jR+75tJQ0jRlhKaKEM+mb+MWGxuCEQaXgVmRXGu
         9NkZOJiJmckimaqlLCbY9TO03yL2bj0QQipK23GFM0GqKdkQPhriIHzVMRe2Z+/atW1F
         t63KY7WEcNPLMBeGbg4f+H0bCNsrbCgly/b+qkY2aJVo/iybfIYVkZJKUl88hDcHoKos
         Yo3L3yTFdfTPPp11ru4r3L0/wz8pkXQJFTmWCBP6T7Bgsb6quPkOQtN2czuzQkItqURc
         GVMXUNHUnHKKYrAroiy+SIgzmkJctwtsLdbeCrCPg6EJSj0L7Z+aOwMDAmcao/6SvsxF
         c2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459615; x=1787064415;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXgGTHWtn0Us9yQ9pyaNr0IxhkN70QWQjDXeZ56LgHk=;
        b=IQPmWiHX4NBrwAyt8NuOe+yNGk0l7issrLdAglQZYH8HGITgqsFhzTk7DdHqFcNt2x
         n9U2NLFg/eRQ+KISfiUqqELy5bIXK9XKJCFzESTVrXeL2IUh/viATWKUC0SEQk/IOcIm
         fK+Q0+bztccif7o5+7pzn0KXyWMJTdYFlig6At2UNml80FhgK8rpRxUUjwuCPercThQ/
         ge+Ylxcaz0dK/hl1PXY2BkvYH/X9rD8lUJ2Kker4YsBGHSu7kZTHqRyABIJCXvvWvnyE
         GCR8hk2jTrqVyn5BS84GVM7Vv62aJniWHLKR6onrG7ZWcx3+QK7VfSe041GVcPLzq6pt
         tDJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfJD4q3wlPG8E3BsxkAsfKgEr95iz04Gt4UZaVflZWahEA1qiPnNyaNr68XZmGkzKO63Nv2qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73hadxnl21ao9RWJN8O5UrtZ5cguxMFhrDhP1bUG/jwRYUwHV
	Zz+TuASkEzBwd0MvZx2oKRR5YoAoXrCvdXhVA9PLrG3H/tniqSKwrKzCBJXZyQeG8O47qEbmaVD
	Rj9EfKHk45HwFpw==
X-Received: from qknqf4.prod.google.com ([2002:a05:620a:6604:b0:92e:dac8:d6ac])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6406:b0:933:aa0:bb83 with SMTP id af79cd13be357-936ad5135d8mr118238885a.34.1786459615149;
 Tue, 11 Aug 2026 07:46:55 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:46:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811144651.2733424-1-edumazet@google.com>
Subject: [PATCH v3 net] l2tp: fix tunnel and session refcount leak on seq_file release
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com, 
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
v3: fix CONFIG_PROC_FS=n case (Paolo)
v2: https://lore.kernel.org/netdev/20260810141125.1176545-1-edumazet@google.com/

 net/l2tp/l2tp_debugfs.c |  4 +++
 net/l2tp/l2tp_ppp.c     | 56 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

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
index f8881699e1cad88e6f312e6ca47ae0af94c6137c..ef8fdfaf051d4602691fbd82e164e3b1eb31a86b 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1597,7 +1597,53 @@ static const struct seq_operations pppol2tp_seq_ops = {
 	.stop		= pppol2tp_seq_stop,
 	.show		= pppol2tp_seq_show,
 };
-#endif /* CONFIG_PROC_FS */
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
 
 /*****************************************************************************
  * Network namespace
@@ -1608,8 +1654,8 @@ static __net_init int pppol2tp_init_net(struct net *net)
 	struct proc_dir_entry *pde;
 	int err = 0;
 
-	pde = proc_create_net("pppol2tp", 0444, net->proc_net,
-			      &pppol2tp_seq_ops, sizeof(struct pppol2tp_seq_data));
+	pde = proc_create_data("pppol2tp", 0444, net->proc_net,
+			       &pppol2tp_proc_ops, net);
 	if (!pde) {
 		err = -ENOMEM;
 		goto out;
@@ -1624,9 +1670,13 @@ static __net_exit void pppol2tp_exit_net(struct net *net)
 	remove_proc_entry("pppol2tp", net->proc_net);
 }
 
+#endif /* CONFIG_PROC_FS */
+
 static struct pernet_operations pppol2tp_net_ops = {
+#ifdef CONFIG_PROC_FS
 	.init = pppol2tp_init_net,
 	.exit = pppol2tp_exit_net,
+#endif
 };
 
 /*****************************************************************************
-- 
2.55.0.679.g6767b8d81c-goog


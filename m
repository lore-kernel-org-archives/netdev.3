Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EF38D3ED
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122627; cv=none; b=oSrNT4tiEGR1g2MUJcSvHLL/Bpod79zy/aSEUCye5Rj5mwrAgM1w6qEfWQ/S31WQzPsBAbQ+Jm6/jepGTeFhWyF/yuGW++651HZPS4vuDYthyhWwOyvikd6repHB+Q7zAOaaqAEW+uztEZraIMjaPuxHMRtxmR5Le1IvhRvG4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122627; c=relaxed/simple;
	bh=I4CABGXjTJheJN90a8dJaU5pacRQj/oNKRMh16rmia4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nF+kny7awqEKPgqmi4q5egtGqqYW8opAoc11sDYeRqZgU8KyUCJQ2Ib52zIghKQoCcj4OFWmTpLWAiD1DvhyRafd3hzuIb1ZjQ9bTObbKUBANjIuLiIfzCb2PuoRfYfmHD34qyNS+eULlaRVJHPELfI3HtDYn78yUHQ6FJZ8omY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJMFDTkI; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJMFDTkI"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0f0a0760so61108011cf.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786122625; x=1786727425; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=clSEJ3UwtXKJIIWAprg7HGhkfYg/BjPf3JtVxf9+fI8=;
        b=qJMFDTkIscjIsX1N3KYk32kF/dpo2GgM/SALfbjEyLqrej8LgdUnrQ51xCuoyUnQsO
         0mi6UInPoeS2yGXRX8Os7Wblk8Fr3HdC82vuCaJVO3lgYs4MRSiTaFjilOd6LFbW3U0r
         jFP8082hY1LzvyhVruIA7uc3KRIjU4J0w+QUrwIAK5EmeIXKTxdUGGdEuzRQ1GwHFbtT
         MvHK0MjwRi74h/vZnSO+NLnClxusgz4IyulYuM/2GbRYVJJlsbhzui1KzccWyt2/NBem
         jyn30Pe4gHLP2a68kuWqix1cqku096yFovsEqgZtEIWGL6lEjIs2aZHruZbGVKKVeW3f
         cfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122625; x=1786727425;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clSEJ3UwtXKJIIWAprg7HGhkfYg/BjPf3JtVxf9+fI8=;
        b=gmtefwIBBSLHgRTZtvrbwfnZRrEU8krISk/D4V4tX1rNWLwCYp6kupE1k0AQ3GzGld
         hOkVqHcQPhlu6rG+CsXzjCgnWSZ803GsEmtLCF+6aHauWTXZuBJxXonUDdWU+SFDLPxS
         RF9ITaioR8S7yhre+HwSpaM1qaHxmiPy89dSumsfphBLW3OJ/sEYX06kNSWHS0yrzmGu
         yZggxTBTjevCvv8tuw8TqDwNOrmLcPyNvzGSmb5LNWKYHOkdvPcK8SvaSb6SJ319vtAG
         FosK+K5H+wT0zkQb9Q/nhmX/c+DdU3qaFXtv/X0DWd23p7nCdsUAQi27aXsyPdxyA37h
         z1Jg==
X-Forwarded-Encrypted: i=1; AHgh+RqUjpGhoJTSdsJb5ha2RBXnhmE9yXh8I1Oj+P4a0ilW+VtUAHv8+0FPoLnZM/FZPIRg5ue92EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdq+eGkJ0n3AiNYciUwGDoxepMReL67SdG4fFkun1gEOHEzkd
	9AIkekfG+dv/Pfik1noDut7uznEZgaR3QGYjFldhC4Glbs6ThDMHYizln8OMykzsQhpW/fMPpe5
	EWe2noTEB9tgkZw==
X-Received: from qtam18-n2.prod.google.com ([2002:a05:622a:e112:20b0:51c:b62:17d9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:134b:b0:51c:88b:d7e3 with SMTP id d75a77b69052e-52d2090cc27mr28212811cf.3.1786122624628;
 Fri, 07 Aug 2026 10:10:24 -0700 (PDT)
Date: Fri,  7 Aug 2026 17:10:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807171024.1897860-1-edumazet@google.com>
Subject: [PATCH net] l2tp: fix tunnel and session refcount leak on seq_file release
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
 net/l2tp/l2tp_ppp.c     | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

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
index f8881699e1cad88e6f312e6ca47ae0af94c6137c..24e5bc06f65c6134974612294e36dd13c1608607 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1597,6 +1597,40 @@ static const struct seq_operations pppol2tp_seq_ops = {
 	.stop		= pppol2tp_seq_stop,
 	.show		= pppol2tp_seq_show,
 };
+
+static int pppol2tp_proc_open(struct inode *inode, struct file *file)
+{
+	struct net *net = pde_data(inode);
+	struct pppol2tp_seq_data *pd;
+
+	pd = __seq_open_private(file, &pppol2tp_seq_ops, sizeof(*pd));
+	if (!pd)
+		return -ENOMEM;
+
+	pd->p.net = get_net_track(net, &pd->p.ns_tracker, GFP_KERNEL);
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
+	put_net_track(pd->p.net, &pd->p.ns_tracker);
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
@@ -1608,8 +1642,8 @@ static __net_init int pppol2tp_init_net(struct net *net)
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


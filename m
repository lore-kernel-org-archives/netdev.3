Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596326;
	b=Ub7w7qwebA6oeN4Zb6E/lwt9XDhlzIMW6juvVJpK/vcbDlQ3vIrmvDwsqJ/AtfBHsLIM
	 0IakZFwkRACcjvUrqkFe65fhtil5YLWUOf38POy61Mw5trlUV4IRCX6eLe/g+jTkX3Pvd
	 JvJnL7xZYeyfvRouz9J/9fuaJ0xHSVA/X68ucIezkuK2HtUOr9+AdxC+0d8EUP0YYOCiG
	 mrcRzr5FiRzUeZTOI0RwcgYTQNPCu5JWPX5mA7PPhq5hUnvfyEVQtaw3JnwR5WZjI6y/f
	 UHDRs2xMwGflQC4DI1JzfqTXzcQa21BiHcktWTjf6fI9c8xwmeegjvZrNOhPZ/L/aig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596326;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=knvARjvm/b7EPks61dPTHzn4nKrfkJtbvOaJXgAGa6w=;
	b=XpWgmg1GZgWcxByMtKGQ+UVvxmot48qsj1Pus1AnbuSa2tZP5z/4f0vVx9c4ZDdpe4K/
	 uo79Z3KbvaVQCPWBlUUtjfEeHUgw1BiOY2UCIlHI1Smu2fzos7vY9kPW3k71kvRLYp+v+
	 7nxbWCw8yiZqeng93q9UriZNWwmpjZHMe+iMnUdwOzDf7brIFTzHqeiBhZUHhgEC4Pc5o
	 PFHmg7jwk6PHtieALnXsqvhSj/EqGNYMUEYb/hx0E9iyiGY2iEuE6s75+3aS6HvV8OVWf
	 kYn6MEDzitcirn2z2Vi6jzT3P2VnYjE9GUvrfWE/qaE3ku/C9cj+GohmY/4+01fHnfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ta+J1CRy;
	arc=none smtp.remote-ip=91.218.175.176
Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798F606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D798F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ta+J1CRy
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2NUhMoKkUJ6bepZ4RgyA85/mYzDtnL9WbvXKX2SoqhA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792596323; v=1; x=1793201123;
 b=Ta+J1CRyGV9OmxnXjk3QROzoKrk1/Eke2jvUuto6loQLqIV/iW96VrFICUMDl1YrtN8LV0Ls
 nbyywT/KJBYco76vnyrBugQXNPGdV03n/exdwV0FDd7pqmxlDrF6XHT04KUMCYHZAbYuvbIiS2j
 x+Nhb+zEZbMWIlfdKcgU5ofQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 328008eecc345c54;
	Wed, 21 Oct 2026 15:25:10 +0000
X-Mizu-Trace-ID: 328008eecc345c54
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next] bpf: Pass extack to bpf_xdp_link_attach
Date: Wed, 21 Oct 2026 23:24:55 +0800
Message-ID: <20261021152455.71524-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
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

In order to drop the dependency of bpf_verifier.h in net/core/dev.c, pass
extack to bpf_xdp_link_attach() in link_create(). Afterwards, transfer
the error message from extack to log buffer in link_create().

Drop the stub bpf_log(), because it is not used in net/core/dev.c
anymore when CONFIG_BPF_SYSCALL is not set.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
Address Jakub's review in the series
"bpf: Add syscall common attrs support for xdp link_create" [1].

Links:
[1] https://lore.kernel.org/bpf/20261020152804.39863-1-leon.hwang@linux.dev/
---
 include/linux/bpf_verifier.h |  5 -----
 include/linux/netdevice.h    |  2 +-
 kernel/bpf/syscall.c         |  8 +++++++-
 net/core/dev.c               | 10 +++-------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1d34ece19bcc..5926f13ff43c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1269,13 +1269,8 @@ __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
-#ifdef CONFIG_BPF_SYSCALL
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
-#else
-__printf(2, 3) static inline void bpf_log(struct bpf_verifier_log *log,
-					  const char *fmt, ...) {}
-#endif
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
 		  char __user *log_buf, u32 log_size);
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4548b0fd824d..f5d6438c4b8f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4418,7 +4418,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);

 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
-			struct bpf_verifier_log *log);
+			struct netlink_ext_ack *extack);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 87cd122d1024..26917a1ecbb2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5944,8 +5944,14 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog, log);
+{
+		struct netlink_ext_ack extack = {};
+
+		ret = bpf_xdp_link_attach(attr, prog, &extack);
+		if (extack._msg)
+			bpf_log(log, "%s\n", extack._msg);
 		break;
+}
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
 		    attr->link_create.attach_type == BPF_TCX_EGRESS)
diff --git a/net/core/dev.c b/net/core/dev.c
index a142613536b0..d79a589206e1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -97,7 +97,6 @@
 #include <linux/kthread.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
-#include <linux/bpf_verifier.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/busy_poll.h>
@@ -10773,11 +10772,10 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 };

 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
-			struct bpf_verifier_log *log)
+			struct netlink_ext_ack *extack)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
-	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
 	int err, fd;
@@ -10786,7 +10784,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
 	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
 		rtnl_unlock();
-		bpf_log(log, "Invalid target_ifindex.\n");
+		NL_SET_ERR_MSG(extack, "Invalid target_ifindex.");
 		return -EINVAL;
 	}

@@ -10808,15 +10806,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
 	}

 	netdev_lock_ops(dev);
-	err = dev_xdp_attach_link(dev, &extack, link);
+	err = dev_xdp_attach_link(dev, extack, link);
 	netdev_unlock_ops(dev);
 	rtnl_unlock();

 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
-		if (extack._msg)
-			bpf_log(log, "%s\n", extack._msg);
 		goto out_put_dev;
 	}

--
2.55.0

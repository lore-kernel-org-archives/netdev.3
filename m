Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2140DB34
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923980; cv=none; b=FsDRNt5h4BDb5ed31GRurbBj0SgiIZqZKvF3EH+1qF5xsRA2psETxPWenpsea0WjwVIpVFfc2FgDh5f/mJQoV1SONKmh4+nTWLQNDK+npNXK/z4PXI3kZ9NcinQjZYN+fw43YsFQPbSOxco+qlYCk3rnv0S8Vj9CjAneV+tTP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923980; c=relaxed/simple;
	bh=U0P6MNmnhiR29aCTI603qoZc2/QBg2U55GuxveIGVUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4rg5YWzXTlTVAnoQAlBwxY3oF9Mq3WfOxfFzy6FptlAezCvLw4WVwvBKMswLa7KlaJTt27dAaxJzgIY84Lg/Zblx9U8ZX1zotlNEk8LbKrNUd1amtJWdIFLx5uZRHg6ibDvwVXP8Tsb7qBbgR+tYl16CoAaCr33uRF2xjyv9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okLkZxCI; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okLkZxCI"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso3288292eec.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 23:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790923977; x=1791528777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adi8qFiLqEh1nUAugSDylELoH/XxWZrE37VsReOSdbY=;
        b=okLkZxCIWlksanRcSYruTorQbSEb/6ZqysHYpo2ZZq9hPAxoiJam+as8HSD5B2/86y
         E8crOpFg61sBebM84Vo9Z3mGu1klv2CPewgKcSDLPvf2InfwCykSQeUaBf+EdaRu8ndl
         oxNHEGtIo0y9CDVJ1IACLiVU7jGZpgHfLvA8+SekBXOO2iED4xT2YMt3tjzZPiAKX60g
         W45nrKKkpzBkn7loe1FRkiTb4jzuOZo+/FibKPtsG6soRTGgLFZgIx8gkvwFeU/x10xx
         /sBR/o6HgrMYB7Xkq3VQ+GUi0BJO153hoZGAuQ9xFv5FUcfcyyL2fQ6mf3h3pfYYutkT
         IGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790923977; x=1791528777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=adi8qFiLqEh1nUAugSDylELoH/XxWZrE37VsReOSdbY=;
        b=fEE1NtyOG4voPE7Nc9SOwtUAbcTQ17FsC/7tOVX0/bT3G+7KRkZ29EydSMEwMzUjWF
         Oi2cKDr0Wn3FMu66XrZgZ6Wo8OQfEKt2sxzkN9oB8HNF0lh9nP6bRxFOfhmCf3zHOJ4v
         OdkK5XUN1S9CRE/anvsEJyKrs7r2abno+E1dgMxW9dz8BA7ItRvk5xrW/G2UXs8DQMol
         33VxUNNeSxGoSpJoh7JwNXy/Mao6FwGainBxSm5yk0Dc33osqnCg+n28sfJZPu3mK5PE
         v/bNiYv9kmcvt/6pTj+RjJZ8WFXC+gxemEqxKR/dgbMUl7GIiEd8NtA17CGbqNYOHnVK
         ZNOg==
X-Forwarded-Encrypted: i=1; AKwUvBwweRCC9pbwoEcE/QGB/lODClZ5nti4ZKfeI3/9CQ6oxDQhHwk4HMDa1AudT9bK/7bfctkUXvE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbHCG1agC9lRHcj2L5x6Yu2FeaCKrpOAxEiPw9y7YS8+2+/rZk
	1unOh8bBBO2nK8rp35MVUlRImG3GaXDrjuzTYv9eOpVQw3mLX0q4EVCx
X-Gm-Gg: AYBFou1+YeAtl3J2rpiXEnnwHBIYOK886k/zhRyC6JiEYdE54JUlbauB00qvu5BP6Qq
	1FiMUt0o8MSZwrxL5Rf+ffHrObm5BkVZjj/LRDdL7LRCWsdgV5ltuzLHEv8IiEfA+NCZaYDIMcI
	VHvUBXCmNMijhH9KuL0+NFpY+c8XmoVlh2FwkWqeBiom9iRLrQP7DuFCWa/jDeCijOZ8au7K0fD
	RHpTFTChVRSCEnACvHYsELv4fjWQ0w+twsf6aZGHK+Mn8v4SMRn65eYvZ2bs2mrEZfoVdBvu0KE
	17nuZ3+EAezj79hOvGwS4eEnoVUHVy/6YLYtUZN8oCwqaDHw8A8k3f37oJJtfx6AnwZuQEn1Uhp
	RktGjlgghXgKZzvwpl7+0Y2w6zSUTMv4ZYnE9rNlGMU4FS8PiU48hAHLUvBM/pWM5KLWhD3ebYi
	crznZnXgTfW5xfs2k4cdcQlswwlXvl3riPkDZXwNHtS89+2wJiW9gEPIFSZo8N/GyevPgo+w8X+
	rKWbmTX
X-Received: by 2002:a05:7300:d518:b0:34b:dbbc:a72 with SMTP id 5a478bee46e88-34f2185446fmr2605436eec.24.1790923977085;
        Thu, 01 Oct 2026 23:52:57 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c739sm4349453eec.3.2026.10.01.23.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:52:56 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH net 1/1] net: use random salt for netdev name hash to prevent text base leak
Date: Thu,  1 Oct 2026 23:52:46 -0700
Message-Id: <62774f8c6cbad549d1a95f88df99ab7745d7f6b8.1790917676.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1790917676.git.zcliangcn@gmail.com>
References: <cover.1790917676.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_name_hash() uses the network namespace pointer as the salt for the
network device name hash table. Unprivileged users can use SIOCGIFINDEX
to look up attacker-chosen nonexistent names. Timing these lookups
reveals which names share a bucket with an existing name, allowing the
salt to be recovered. For init_net, recovering the salt reveals the
kernel text base and defeats KASLR.

Use the per-network namespace random value from net_hash_mix() as the
salt instead. The value remains stable for the lifetime of the namespace.
Since all name insertions and lookups use dev_name_hash(), this only
changes bucket placement.

Fixes: 8387ff2577eb ("vfs: make the string hashes salt the hash")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
---
 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 18dc88990510..f3eca7fa2481 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -98,6 +98,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <net/net_namespace.h>
+#include <net/netns/hash.h>
 #include <net/sock.h>
 #include <net/busy_poll.h>
 #include <linux/rtnetlink.h>
@@ -193,7 +194,10 @@ static inline void dev_base_seq_inc(struct net *net)
 
 static inline struct hlist_head *dev_name_hash(struct net *net, const char *name)
 {
-	unsigned int hash = full_name_hash(net, name, strnlen(name, IFNAMSIZ));
+	unsigned long salt = net_hash_mix(net);
+	unsigned int hash;
+
+	hash = full_name_hash((void *)salt, name, strnlen(name, IFNAMSIZ));
 
 	return &net->dev_name_head[hash_32(hash, NETDEV_HASHBITS)];
 }
-- 
2.25.1

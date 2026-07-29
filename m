Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5337C11B
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346315; cv=none; b=V+3iKlGUAKM4ZtnDljngNH6XplHNfWxlvCPvnniHfK9JP6To+IxAkF/VgXB4ErPcSNOm/qNTAG79w+CPeH08kuAuZ5tOXnmqHggXhaL7deUVy0LNMbm6CPr8Kl6+ed9NO0dzNvNGEGHZxREisug3GHpWNC7WDM4J38vxdqv2nkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346315; c=relaxed/simple;
	bh=Jc7G6StL/c7Ytj+6YqLr8/+Jzh8vDBmz4m0lxtPGPWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWAG11h+LIUre+CVe9QGeijhf/cgsAy4Du5gvjTW3qi+1uDErq1F6z43kGVlw9oQ6FxAhbd1obO+Rlmdh6UU7xO9ptnoNRJ3SZIOHKF5ztHfzJhZnEprBB5VBwbCMYjKrmKrQeC4H4iULy+sr5HulpYxtbDAUEs9P+YMwPqa0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeHq1R5O; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeHq1R5O"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so105910a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785346312; x=1785951112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=38ZcQuiK7/9UCGF364MaZa4PYPgvUUkg1FUph1SOAX0=;
        b=YeHq1R5OqrLek+DRCgOjL0Z6dNhKL+Uzu7y3u/KAZrlL9XJhPFQetMY+JrZ7pxSWFl
         tG3NChC11B9yXq9ys6CXnqxwYZd8zjXh4QIJUXNIRSZ8JBtAlVV+bHqL50NX044WUxlr
         9Vmg0T2VUTplLl96doEZ29mFo0MsZOlIL1sGdOjGIqnFp+fNJ0KCuwfvPrat29sK/T5P
         Zc2Xx/Tk4zYXXVUlhEeXLeWw7AC/hpiyaQLvH9uTsE9OVFCK9ZMzjq/yr7Xr8hvmc+jh
         IIAy9rTZNNhZdvSxTGNhg9xA7gGF+MUMsXftG3GbLu5rNWTuveFj2gCHBzJBHOsIM9Fv
         B31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346312; x=1785951112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=38ZcQuiK7/9UCGF364MaZa4PYPgvUUkg1FUph1SOAX0=;
        b=QCtCuGfgcgNL4O6WYHs9+ylCRLUUGj+WybA/79GcCuXGLr1w1vkV+DMMMtXEfr+MdD
         iE5ppeOirCBE5x1AgsYZJFoZ5ysWXP1siug8P1bXY7Vo3etCF5DY05P6CQI13tKj+n0C
         SROP+ACp+kmuA0oFXcHmyE15P8KqmsKBqawA5hVLIfa9lEA81E3Wh272jawDk4F7dlMJ
         T3CuOhkdU+N50xYRgfr7WYaWYnNAsfc4BTgDJ9W9hLt70MP52vJjPXoXW0Kv35HYihb5
         mifa2g2Q9W0KSGaGHAFo1uRe1YZ+uQyDR/XfASQt4LwyZfokUCL8xqpk/KFeiaNVtJsu
         ICtw==
X-Forwarded-Encrypted: i=1; AHgh+RpAnArwYljsfEnYlPUnMMkL9+1JVpZHmT0PTA2IP+d9I8VX51tC9dbKmOdneHM7v3UMDfv8YEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhrmLpwUfGJAkug1NDrTVcgUYkro2YbOg4BOncWfdENxQihV2g
	vQRkz2bu+5PiSdXRZ65RoKgOq3hEnpT9kE17Sxyhtx+ezALH+ilQKcvC
X-Gm-Gg: AR+sD13epNj8EJbiOp+xYZ3rDdLxqYsMbiEJCyuPCpCQj0EIafr4F/6fQ++r5C8AgiL
	lCHmrlwWdklFoh4AUG4697rkDDjUFP0vjW8rATC26S4VPV+mRzXNhE8r/n/1epE8sio0KV7QDEc
	1Pyc+6nruC2tU/JrW1ugRdpeSFe+avTDETSIsUaQlIp+1U+eBCqE8jiAWsxkySC50WP4kCAwdYM
	9JyDiFLeDrBeayHF+9NhY4FCpdGxWBRSOU6E8C1kjNxVqL6uO2ItW3v8mvcVFdWih+1enudpafp
	qCfXisx1xsFReSIS0uPsHr4fO6CLwSpTBhm00hUdtIXghhrz7SzdPJpEAP58SUSD2IQ9UCA9lPM
	oFDYtjdR0xSfsBTL8o5ph+eTvi55ZPdqaJoJGWrpbsM4OkexCFIAMCKPbvCP6MSTTK0MayZ8dFk
	yFxqFQ2U12dio3r7UZT7tUG85/f/yN/qZjxCS55qWbTyjQp+SYNIcTsKObqyIAK/LwWAQ+Yxs+P
	QOTbCJj0z1zYpUr/g3amqZ33fqBWML3dyexg9HVpwA6u/8Nz6A/8fE=
X-Received: by 2002:a17:90b:3e44:b0:37f:eda5:516f with SMTP id 98e67ed59e1d1-38f6a1b8dc3mr7154386a91.0.1785346312247;
        Wed, 29 Jul 2026 10:31:52 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d480c5sm19583850eec.25.2026.07.29.10.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:31:51 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: ebt_nflog: pin the NFLOG backend
Date: Thu, 30 Jul 2026 01:31:00 +0800
Message-ID: <20260729173100.216916-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_log_unregister() runs after the per-net teardown so its final RCU
grace period also drains readers that obtained the logger from a per-net
binding.  However, ebt_nflog passes an explicit ULOG log type to
nf_log_packet() without holding a reference on the selected logger module,
unlike the xt_NFLOG and nft_log frontends.

An ebtables nflog rule can therefore remain callable while nfnetlink_log
is unloaded.  The resulting interleaving is:

  CPU 0                               CPU 1
  nfnetlink_log_fini()
    unregister_pernet_subsys()
      kfree(nfnl_log_pernet(net))
                                      ebt_nflog_tg()
                                        nf_log_packet()
                                          nfulnl_log_packet()
                                            instance_lookup_get_rcu()

The global ULOG logger is still registered at this point, so CPU 1
dereferences the per-net state after CPU 0 has freed it.  KASAN reported:

  BUG: KASAN: slab-use-after-free in instance_lookup_get_rcu
  Read of size 8 at addr ff110001052e6210 by task poc/92
  Call Trace:
   instance_lookup_get_rcu+0x1ce/0x1f0 [nfnetlink_log]
   nfulnl_log_packet+0x248/0x2fb0 [nfnetlink_log]
   nf_log_packet+0x204/0x300
   ebt_nflog_tg+0x351/0x550
   ebt_do_table+0xedf/0x22b0
  Allocated by task 90:
   __kmalloc_noprof+0x186/0x470
   ops_init+0x6d/0x420
   register_pernet_operations+0x2f6/0x670
   register_pernet_subsys+0x23/0x40
  Freed by task 93:
   kfree+0x131/0x3c0
   ops_undo_list+0x3e3/0x700
   unregister_pernet_operations+0x232/0x490
   unregister_pernet_subsys+0x1c/0x30
   nfnetlink_log_fini+0x34/0x450 [nfnetlink_log]

Acquire the ULOG logger module reference when an ebt_nflog rule is
validated and release it when the rule is destroyed.  Request the NFLOG
backend for legacy callers when needed, matching xt_NFLOG.  This prevents
module teardown until all ebt_nflog rules have stopped using the logger.

Fixes: c83fa19603bd ("netfilter: nf_log: don't call synchronize_rcu in nf_log_unset")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bridge/netfilter/ebt_nflog.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebt_nflog.c b/net/bridge/netfilter/ebt_nflog.c
index 61bf8f4465ab..426f8adc912c 100644
--- a/net/bridge/netfilter/ebt_nflog.c
+++ b/net/bridge/netfilter/ebt_nflog.c
@@ -41,11 +41,25 @@ ebt_nflog_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int ebt_nflog_tg_check(const struct xt_tgchk_param *par)
 {
 	struct ebt_nflog_info *info = par->targinfo;
+	int ret;
 
 	if (info->flags & ~EBT_NFLOG_MASK)
 		return -EINVAL;
 	info->prefix[EBT_NFLOG_PREFIX_SIZE - 1] = '\0';
-	return 0;
+
+	ret = nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	if (ret != 0 && !par->nft_compat) {
+		request_module("%s", "nfnetlink_log");
+
+		ret = nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	}
+
+	return ret;
+}
+
+static void ebt_nflog_tg_destroy(const struct xt_tgdtor_param *par)
+{
+	nf_logger_put(par->family, NF_LOG_TYPE_ULOG);
 }
 
 static struct xt_target ebt_nflog_tg_reg __read_mostly = {
@@ -54,6 +68,7 @@ static struct xt_target ebt_nflog_tg_reg __read_mostly = {
 	.family     = NFPROTO_BRIDGE,
 	.target     = ebt_nflog_tg,
 	.checkentry = ebt_nflog_tg_check,
+	.destroy    = ebt_nflog_tg_destroy,
 	.targetsize = sizeof(struct ebt_nflog_info),
 	.me         = THIS_MODULE,
 };
-- 
2.43.0


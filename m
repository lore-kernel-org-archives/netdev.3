Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F2381EBC
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445147; cv=none; b=qBIGMohWSXz1AQ2o4AIw+9Df4HOBSjXHLA5OjRJ4yOMOEinQqnWVWRnXZHDq9YrXyJawomecKYMZQQyPF1ljwIDKcsM1xQfIbib4NtB5FTVi9lbuNxx8Jg2mseCqjdYEyDb19FeB1ng2xO4X/MpIACBu07eTO9p9EcChNgYvBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445147; c=relaxed/simple;
	bh=J+AhSgGwt6r0gJXNT77YyglaJAxP3u30DbwIyT1MBgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbmkcary6Otk0VtP+pbrEop6gvw1cXqX+n+DEEx9iSPkJQVZE1KXYTkVZqAatDxFptbf8BWdw00Ka2tcN+ajCuHrKnCYx9VdNIeB2/HIp+o9NmV/b30HizM4nJkvGTcHjCtv2VBwFM6nj5pGZcODHFMHNvPHMrrwPvQ0bfc7bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHAr7+C6; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHAr7+C6"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344213c95bdso3102eec.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790445142; x=1791049942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwvxlwyQkpsMgM6uNMmOr1LUHz18HQva7SpWQBiJmMA=;
        b=RHAr7+C6j2hxZQNac9iNTMedEzf+XAqZiz8UBrbw1VVKP/DO583IaUZAu0NjfdDZji
         w6sm8LFaSIURUgniznrLanYijIBDonAE/woTLtpQW7vMIqGD+hJTgxZXl0tFyyEZcqN6
         AG6S/rL6QkvsvCgMfQ8I3YRezczag7P1YvOmI91Q6ST6DmtXmZiHFmsBQlOf7/yZYqoR
         +OXXzYOpKMPFaDdZUwABNCYvWfnu8gd29QAqmjwUYtrOOcpE5+ClaBdCwdNrocAviuvH
         btnn9JhBVncu4IMfniVx4rJa8cgFOi2sJp97At8kgLoG9vIt0ad0d4PlaNhwdLkPzBga
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445142; x=1791049942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwvxlwyQkpsMgM6uNMmOr1LUHz18HQva7SpWQBiJmMA=;
        b=oH35rhqXX1Y/Xh64RtM/tTTn76QC4Sg/PyMUGPD8JwtzmDRKzDFGV4UjfKWA0DBu3H
         rA6e3HrX68PA9pbOjEdCsMjmkgYuE7YTsosmIxtDs7cxVv5qE6aNnSeWSm1s2TL16Gt3
         059W9/OQD9QILn+Xx0OnPeF5RFyLjEu5vtuyp/+PcPNTLfTztuHvVsUW9sYzbpguKip2
         E9KGGrp0loEreNLJ8CJkGuBdkeMcuxr/PvP/5TPaaWDxQ013Fxc+BnjwRPF4++wQe2jQ
         5c06dJfK2EMHB1lbtunNUWP914R97W9JQVfefAehXuypNs/YYynvL40x5S9oIzAB6XOm
         hoGg==
X-Forwarded-Encrypted: i=1; AKwUvByUoNnvJauLeF0NComiVejG2gmiLxLsgjIEhgENmz7ZwEuyfSraF90UX9wOxPgp9YmKxRSZBPM=@vger.kernel.org
X-Gm-Message-State: AFuF++ldX1oENFxoXg9fs3osbKAJzFNSlouDjklLnhwNB3W0FE9MA80W
	8os+7r2X2FTfbWmfUk5gimNSDkZcxDVgYxNtuixE76wAbr0Jzp8rgtrj
X-Gm-Gg: AYBFou2NmVIwZzjoPay8M1sS2RJi1flCvfs5SnauWQnnthuDMvnm2b9POjnnHWh+9ho
	Z2Nf8OZ9K+nTkmBzgQnLQrpJVboi1HIl/ig6CmUo8vECCW2B3lTvv1u5ksqOJJkkdrx+f02ApTS
	wzU8Bv09FW9/2MMY8Aa6hkylgW1Bgyz25/+LwZDmxja/DxgTYsMvWklSgATmiV8n7nfNMRNV++J
	xChOutTYRuVw73K3gJObaxrTUYP1/iXchyBFrJoyN2Tf48PztEb05RQmLBUGOBT6RcTm03xKNSR
	Rkmv4YXGKgg1q2lv54y8Ip/08996cIE3b9xN/W9Hu5RADSXNmBjf7nh6A3rdmUuFdlzp1uDxLLA
	D9RlIAZGZjbq/E1iICKeOujq0imGTwPvWzKBARIcInIfM/s5y5HLsXpi3ahJq7HVuhFfxFPCMM1
	ZiBrNlDIbwvOWs1rYXxdyD5Fky92Ip2BPGFvoGexDPGE+LWz/5Eiw+POZ3+t1nW7//mlzEecSbg
	7fKDghhIciVZR5pwnsexlQpJf0oiXjO4UuLWeAKagegtTQgC0Zz2xRsuHZ/5aKabjaoZY8=
X-Received: by 2002:a05:7301:dd97:b0:33e:6a79:5a81 with SMTP id 5a478bee46e88-3427179721dmr5365610eec.1.1790445142180;
        Sat, 26 Sep 2026 10:52:22 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341463ec3ecsm16482252eec.31.2026.09.26.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:52:21 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: conntrack: wait for RCU readers before freeing the hash
Date: Sun, 27 Sep 2026 01:52:09 +0800
Message-ID: <20260926175209.2618167-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_ct_get_tuple_skb() calls into conntrack under rcu_read_lock() without
holding a module reference. CAKE can use this hook to look up a packet
without an attached conntrack, even during nf_conntrack module teardown.

nf_conntrack_cleanup_end() clears nf_ct_hook but frees nf_conntrack_hash
without waiting for existing readers. The grace period in per-net cleanup
runs while the hook is still published, so a later reader can race as
follows:

  CPU 0 (packet path)                 CPU 1 (module teardown)
  rcu_read_lock()
  ct_hook = rcu_dereference(nf_ct_hook)
                                     RCU_INIT_POINTER(nf_ct_hook, NULL)
                                     kvfree(nf_conntrack_hash)
  ct_hook->get_tuple_skb()
    nf_conntrack_find_get()
      access freed hash bucket
  rcu_read_unlock()

The same missing grace period affects initialization failure after
nf_conntrack_init_end() publishes the hook. During module teardown,
KASAN reported:

  BUG: KASAN: vmalloc-out-of-bounds in __nf_conntrack_find_get.isra.0
  Read of size 8 at addr ffffc900012e2ae0 by task poc/90
  Call Trace:
   __nf_conntrack_find_get.isra.0+0xf87/0x10c0 [nf_conntrack]
   nf_conntrack_get_tuple_skb+0x255/0x400 [nf_conntrack]
   nf_ct_get_tuple_skb+0x75/0xb0
   cake_hash+0xfdb/0x1e10
   cake_enqueue+0x5cd/0x36e0
   dev_qdisc_enqueue+0x40/0x170
   __dev_queue_xmit+0x1e90/0x3110

Wait for an RCU grace period after clearing nf_ct_hook, before releasing
the hash table and the remaining conntrack resources.

Fixes: b60a60405fb9 ("netfilter: Add nf_ct_get_tuple_skb global lookup function")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/netfilter/nf_conntrack_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d0d9e5ea84a0..b07e94e75d4d 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2455,6 +2455,7 @@ void nf_conntrack_cleanup_start(void)
 void nf_conntrack_cleanup_end(void)
 {
 	RCU_INIT_POINTER(nf_ct_hook, NULL);
+	synchronize_rcu();
 	cancel_delayed_work_sync(&conntrack_gc_work.dwork);
 	kvfree(nf_conntrack_hash);
 
-- 
2.43.0


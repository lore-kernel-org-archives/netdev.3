Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087816;
	b=N/9v0rASUHKwoZTEOc9+LFnr//ot7P4zp/YDed9LOAjkQdIiwUMtn2rQ6DF8M05P5I2N
	 LezHRVsr3MlT9E0AyIvOsce5DRM2y4ytcapB7azeo0sATEzGzouZcJ0Sd5Fk70zYqq67o
	 V0TeceGLyMi/5eSqbae0tuRK7UFAzqf9+CQZ9HdgCyyUcW4t3cndX2Vtu/C34ndv6eZVz
	 B/+uATn8bwGRRs7oIHEHHypm0HzYrmirr4GEC5kxPt+cWUk67iPF9vSubanL+UvdBSKN2
	 s2oAtmFv7W6Npd5pa88gW2o7tBJpthkPRaYXLY2WyB93O+TsUn3tgk8DgoPcKulKnPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZS2Hout5cP37ERNwsU2rRcOCH5vWR2whSc9eaYvYi90=;
	b=bKu1IyW8VV49IfUByC5ZuasEwfiaoOQEmRWorXdZxX4uNb/Ig9jUuUSH/RluELVxMt58
	 wELyN5g+9iWOQB6ZQcUxk3OoBKnxBUp90gjSc2XRy9gP3fB7M+Z1TRAJsQVhTZwotHNV0
	 Wt+/uBQI1i+BfLLIbZnCv67UF4EEo6VB1ThEsNlC9AKkV+vU5qemMU+W1IakPzl5D7nXH
	 c/F0qU9uJ1VoT5tA+hxnQ1blPllNCZLLLOkskaSmTe+b44YTyhq9VKpTEDnU8vfhJwGKD
	 lNv7dvjqmk0NPSIgwYpMSxjXIYLNUA0JYQnNXyOK42ZNc8J0VG6S4sTO6B+rMbUofJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R14r4DTk;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87001606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87001606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=R14r4DTk
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f2493c28bso313967485a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793087815; x=1793692615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZS2Hout5cP37ERNwsU2rRcOCH5vWR2whSc9eaYvYi90=;
        b=R14r4DTkHR5zQFvQmfzoA3DVtcSTydqWCIujZ7/6DxEZK/JM+Hve/Jho7+z2wEUW9N
         S69VK4FBKrdCklDS1QHH1dDKvO5AQXjlOZ4YpXRuTbm6JqrPzfRtFiThMEZvI1BPmZLa
         Am+ivBP9EAEYZAq2GXU8rGdIwRg6XZP4kYdNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793087815; x=1793692615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZS2Hout5cP37ERNwsU2rRcOCH5vWR2whSc9eaYvYi90=;
        b=DdCaX1AtlpDxwWjB7I6o+OTn+D/jZBUAn2Wvg+7vECBX9d2dXTvnirtMsFqIGBwiz5
         AOgW5b6ldmusvSHd1YZuInrqxjpPkjyN2ukMwEPx0NZ16UeSxrkw/+NiqHa6dy4MRxZa
         LWaTev5HuG2T5lWngwBjfoY3YjMwV/LKdJT6b5jEIp0TKhOOhP2CfmCPiQBSktBPijLF
         O/K84a3W5o+Q7viJM9Tnyt7i/AoYbPpUJmcjqoSrLdIxOXym5g19BBW+/AADn7p3Atcq
         GD5Q+Dlv0dqvNOUL4e6dl1DthjazupqS0uOvNQLGu6rkmkS+tsgQFctpJ17PatFubRR6
         MQiw==
X-Gm-Message-State: AFq9FYI+QAg9qoddH+DFaYh0AUgcJ3f5fA2JiiDyp95rsJlNzf5wY9qC
	ogMLqe5XlcpdbluSFM7Hrbj75JR8CFKiinG9zJ3CF8HeyHVA02RHLtdzxM2Wopp2aCV2f0ThdCo
	MDIY=
X-Gm-Gg: AYBFou1dPJDF8e9jocJ71u/BqGvLVNMY9WSPhSZcsbxLug2IjQU2IeJKBQwbV10ino9
	11gqfAMxuQO1H8z6CPPkgzihljknWvuwgOjHei6CE5H0x7m6Y7v2Lh6gqGfhWJNvNshe7LpIp/3
	PyxqrflGQxUaeBs8PT9iGp3G75vybK+ZWefXlslPkdPW5RAkn1zQZ2UI67Ct1dVYMXT15hsIpkm
	XlL05QHaboltsg79LEwNhbKWA040r8x3rtfrrNo1bqFzGbYBSTRvaDC8wwB0+SJ2isCCRMqocMo
	t84VrPuMI3pDqgYLvvQ8UWX1t9NLaPljshyiyBljE9IpzxkuPaOqhgagcxGUbmRSovB4fuxtFdo
	+GKUloprNgLwL3pwTxceVWgf6xsERNdwMsS08JLM3OEj9bZKO6TcJjOW1tFozDUGIRxnAtSK/Z+
	koMAx8QXws4gXeYBrWOW8bfm/J2VZdPT/YBJsuuOwP2Q7HwhRph0uJVqK4S6v9ojDzJ9k6eWocc
	h/G1NaYiNPbz0nfMHA30CXept5/xCEPJD+9sDbEj33gVOWWcKFhbB1OzBjlhYdsOQ3ZheICTZ5f
	oeKxQc4mRJuKBgCT2Mdd5YVBYWj+z51jGBPl8wATsXA=
X-Received: by 2002:a05:620a:448a:b0:93a:3d67:391f with SMTP id af79cd13be357-940ef7d5658mr1344922185a.7.1793087815549;
        Tue, 27 Oct 2026 00:56:55 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066629dsm906675585a.7.2026.10.27.00.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:56:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2 repost3] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue, 27 Oct 2026 03:56:43 -0400
Message-Id: <QDISC-6HS9.v1.r3.20261027034729-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com>
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com> <QDISC-6HS9.v1.r3.20261027034729-1@mojatatu.com>
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

teql_master_xmit() sets skb->dev = slave only right before the slave's
ndo_start_xmit(). If the slave's neighbour is unresolved, teql_resolve()
parks the skb on the slave's arp_queue with skb->dev still naming the
teql master. The master can be freed while the slave lives, so the
queued skb can dereference freed memory.

Set skb->dev = slave before teql_resolve() so the parked skb names the
device whose neighbour owns it, and restore skb->dev = n1->dev at the
neigh_update_process_arp_queue() reinjection point so the skb goes back
through teql_master_xmit() instead of leaving headerless.

The reinjection restore is not an identity for other parkers:
bpf_redirect_neigh() with explicit nexthop parameters and nft
fwd ... neigh can park with dst->dev != skb->dev. For those paths it
moves skb->dev to the dst device and the packet can re-enter that
device's egress path. This is a behaviour change for those paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/neighbour.c | 1 +
 net/sched/sch_teql.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7448320f7ad5..5823f5007812 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index acd03f9afc6b..3fbd5af10028 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -348,12 +348,12 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		skb->dev = slave;
 		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 
-				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
-- 
2.43.0


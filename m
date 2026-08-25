Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F23381EA7
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645890; cv=none; b=USBGLNh0amVBxWlyFmqebb9+cGl0AFATIKRF252X37a7jtu4fdq4CO+IW/CsPUdLuUL3QzIp5BlxhUj2FYLuJQ7Pv2BIyb01CNlVD0gd98r8naBe7ZhuqQ2TC8JU9uo7mTCoIZwhO4E/4RljtMsN07j51gRdpWXkxlg2GZSanBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645890; c=relaxed/simple;
	bh=2wca9jiUZpoFjMcimeII6bdLA+Yz8eGkHT39Out8KPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sO7mh2u1W6MTfj2Rtc0yG2PnUfsddiOjr6sULAu0uvMQ6DsecPnNn7alcgRXYNqwyK/nYQXskFFB1t9GEO//ym+xODlD3Z+58INAPNxGbviu+akqRDWoHM3cym5fQLgl8DtVcPkzqvoq59tYitVMPVRF5tu+h3/yoSjir11JPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Miket/0A; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Miket/0A"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a76536bso48284661cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787645887; x=1788250687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MGsld5jCXIuE1ZQHccQwWJT/ZObyzhHpKhPa7xQCWQ=;
        b=Miket/0APIFZdfNFWHsh0rNXUo8BCoY0H6mkS1BmUMOrL6Ong77iziG4Cm6ZBd2IpL
         7ZMU6Pm4T5WeD6+EENp7+0QD8awVY7szIEejlwX7UgtHaZcpYZ8J6kzUaGwHpr9Ra/N8
         Tu0fEcj01vV8HrE/n6y0T1qRHPKdvwa20+2SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645887; x=1788250687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MGsld5jCXIuE1ZQHccQwWJT/ZObyzhHpKhPa7xQCWQ=;
        b=D56HNt1LK4E1E/qq6xOoJP1jB2tY7qDCPzop7/q1T+GSXFDC/J9mhHP6ZcN3dWQbMY
         rbgInNl98aY5R0chWhT3dq14R2BtaHyC4lyWpjqqb3dN1kL1MVQORfJEqSh3VfDWtJyL
         hBeKcfuVsS2q9NYi7qS35Ubk1j+EEsTFVBjGwajW18zZIHTmqKktOC+wqIfv9DJxGfuP
         vY8gJzR5IWviosOzPXD2yXFGPeVq9QDT2v/fnqAM3qwzSXvjjndokTn1izuzRIJkM+r4
         wcPzlBPrY/T6ffOuO9OijgNst/WK/8twuC7sEMqt//ndveMsjC10eWWNhqulCXI6XVaD
         Rv3w==
X-Gm-Message-State: AFuF++nhHNwokIZLJsVWQOqyXiIzdqf+/xrAvhY4sqKjxXKpvuYeS9C/
	tAVmCsAOoVf7+qTTChyH1PTmsxxD5o1BoTGiZFg+2jUV1K+q5xJr33SNHq2PcKVkEn1R/moKD4m
	ibyOMNA==
X-Gm-Gg: AR+sD11sFl2fIqZ3nQlbpL9QSM8fYyvilJGOiAULrZYOGP1cIgtV8zw45k3qiEikmFx
	VeMK+sQRfQSWsQe6THP+HGtXTmsJ6QDsC3pLWPHKim0gXfHm7oAWLWNyue6AxqLKcLOzzMjhitf
	AUgiN8Og5fLDHxYcNyQQLbz/sjaXfh7PWoez/G1xARycm9dam9bnhpEjSZfDroTQr+wgZtsDUvU
	4JG8Ccj1yb5rbLzpvLzcUGiHwWzb7HYMCN0w4DMSXuVuHzbvsQDpjkKdbMSY032oeWI4GiwBoW6
	AzAVInuFb1mpzPAlBUnLI488+MGxvaSGVTlX0fSi+6kNk9wepgqOIYG8W3Y3x/5lr6shzEUWS2v
	T5OD1fkJZGPaErtCi1nyECFlsSKuZyTv7NIbPFZlFulbZ1iU4/2RfWpNlniIbFO0cNhMN/28Lez
	H1K+RF4zeQZqAkZwv1CiU9j1Nyc1mUHvoQ+Wzx3wTiZ4Lc8ZFD0mfa
X-Received: by 2002:ac8:5f52:0:b0:517:875a:d634 with SMTP id d75a77b69052e-52e09bad973mr258346751cf.2.1787645887168;
        Tue, 25 Aug 2026 01:18:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09975f5asm65387341cf.2.2026.08.25.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:18:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring and account to memcg
Date: Tue, 25 Aug 2026 04:17:50 -0400
Message-Id: <20260825081751.134086-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
bound. An unprivileged user (via unshare -Urn) can set a huge
tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
memory, causing a system-wide OOM.

Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
via extack whereas for the resize path, the error propagates to
netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
are charged to the allocating process's memory cgroup.

S16_MAX is the virtio virtqueue size limit: the virtio specification
stores the queue size as a u16 with a maximum of 32768, so 32767 is
the largest tx_queue_len any in-tree driver can meaningfully use.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
  while the devices are down.
- Attach mq at root, then replace each child queue with pfifo_fast:
    tc qdisc replace dev veth0 root handle 1: mq
    tc qdisc replace dev veth0 parent 1:1 pfifo_fast
    tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
- Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
  rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
- On the unfixed kernel this exhausts global memory in ~28 iterations
  on a 2GB guest -> OOM panic. On the fixed kernel the oversized
  tx_queue_len is rejected with -ERANGE.

Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Jakub)
- Changed cap from 65535 to S16_MAX (32767), matching virtio's
  virtio16 ring size limit.
- Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
  already prepends KBUILD_MODNAME).
- Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
- Fixed tdc teardown to use JSON list form for acceptable exit codes.
---
 net/sched/sch_generic.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..eb5c0d3f67c2 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
 	if (!qlen)
 		return -EINVAL;
 
+	if (qlen > S16_MAX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "ring size %u too large (max %d)",
+				       qlen, S16_MAX);
+		return -ERANGE;
+	}
+
 	for (prio = 0; prio < PFIFO_FAST_BANDS; prio++) {
 		struct skb_array *q = band2list(priv, prio);
 		int err;
 
-		err = skb_array_init(q, qlen, GFP_KERNEL);
+		err = skb_array_init(q, qlen, GFP_KERNEL_ACCOUNT);
 		if (err)
 			return -ENOMEM;
 	}
@@ -957,8 +964,11 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
+	if (new_len > S16_MAX)
+		return -ERANGE;
+
 	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
-					    GFP_KERNEL);
+					    GFP_KERNEL_ACCOUNT);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
-- 
2.43.0


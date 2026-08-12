Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C4357D18
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512138; cv=none; b=S9VxQ55LUoVtqTq4Wc6V+sO6i8pzGLh2DLBBQKC271oGEY0XUe1VCHF8uIwC63kQl5ifKc2K+8oQFc3PKvEWAHJMlP1WgePI6tw0mrqYezEC7jf+ywDFz3t024i2uLTcL+h1tAzVahQzdlNY2qe0qgDLH+9JJjcLl8xfbFH1Umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512138; c=relaxed/simple;
	bh=ibwpRO9tdzRnB9hwRdiCbyvha37TSoCPH2xljG79eqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvPz4h3Q7owRrUGMQ46JC49ZY7qnyNSBIDNEWFR9RSQWUW0fzF92LRnrRogbhYcKU51K7hFk+1vE0gOUszPc37DludvPnRKbqtByC/VdBDdcpQRJ6mg21AJiByLmfTl78ZSew6qsXNSGDqnADryCWjxLp65fOv9QIvu0qqm8mNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6yiS7e4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6yiS7e4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso408659a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 22:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786512136; x=1787116936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=diIcC2mYMoxigl9uIM8y5rRAYyfw1dzo8pm6pfntNRk=;
        b=C6yiS7e4PB8oRktQoMCAxAAJabO2rmAayk6dsKGP62eRfqZYQqqKplfM3kRVHHXf+m
         GYkN8pCMwWYBaqt5q5O5xOWa5pEpfD5CE9IMSMxfhGUjqXzVrqEbOZA8mUghJcML9SoH
         HZO2oDmPdavfvqg2u1fLenRlFoYpASYx90Ue4lDe35Q6gsim2j3NXxk+f3aohlrz1eGd
         TBqClMezJOgNJ2SSqOxnY7FYTon1t3n6/VJp/cO7ExNuVKWgxVBCKRcxNNf3H41bxDJz
         uuWpEa0QxQFb34qQ44AmqZM+Ann2IwNxJvEdoeZHxDf5tUkTGsxWqKpEjreSOGiIeJ/d
         67sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786512136; x=1787116936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diIcC2mYMoxigl9uIM8y5rRAYyfw1dzo8pm6pfntNRk=;
        b=qN24lhm5k0AemCA1/0g4tyApFWjuUSnAsCfmEF9iM4o2ScK+fMhf4bQyVRI/4oAVQm
         1x6zftjypntqAQTOnpnWI4T3fgj9RXsb6ls13fLxG16/tyhalInxl8/4iJCWQnhUH0Ld
         w29ydixHqQgaa+7GGptu3nieXXnfVOFEvGO2N7yTePpHp7zaIOtxABbrLUJP+v4mUwpo
         qdxdVz/NF7GMXN+apBxlWx15gCkSmNH77QAhQojr/AA2/6usLrJ/h+nWy7pMtNCGXx4n
         Vw0sKH4s8J4HFH4HwhCI3BCoaI2swNmOXoo4Z/AvyxBYLfcIQ8+aeas+RolQ1xpzwP3i
         f1VQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7VvnvDIt3HMYq2UKujJbf8ZXi7Jvr5BA+07bKuFJF76LV9y0Q0nogVh4EwBYf1FrBD9V1dyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywP0XqFy3Fg5l0yRZv1hOIRP2wLW9vcZPjD5tebLpMb8TG8Zq6
	FCBvn8StD4g5ECE+SM3FFunIGdEM4quFaRsLMpndPrgNQbp9Ps9Maiw4
X-Gm-Gg: AR+sD11QJ+EqijETePpMlIDJIueCCWRNQcvvM5v2Bd1fKrB5rjFMldcQz53MnB8rFq7
	oppA0uRHIY+9HI+vaMHbVRuOnwW4N/JAnNNyrvr387voHnMK655/eux/veoWaALDAKSGv3nJ383
	+FhWN76EDUlaRXiBEjC59RpEUnf53xGQdww8ScRDNV0FB+YehlsbxqNXKQnPK9hXOvWNg8SzKAb
	TbmscXkH8/kiv7dEZnzwP2XB+vRIxtVVsY17uxLTL6WYLrnemIH2S5r3Cps6g+tPCR3MG6ln+Rg
	DDdmbPH5muzWn8XRfe8JzqOreBiQV8TgRV6OQqvyB8e4N5MLJW+50bIpvou63Qsc/MhUw1TW4lo
	OaaeawpAg0g8QirUqWXoftt6wu0LOG2kuPWmH31VgekMuiAh+rgfloE5CbFe3WpSv+tTz7rxCXN
	ylLqkq1A3sxlHVCiZSVMY6/HmFGF8IFZ59hl0aALuetWcxyZafdoxOuCtEToLBJzS+AkBHe6+rq
	2s4dOhZP67c
X-Received: by 2002:a05:6a21:1509:b0:3c3:7cfe:b32a with SMTP id adf61e73a8af0-3cc3f735f3fmr2725770637.27.1786512135917;
        Tue, 11 Aug 2026 22:22:15 -0700 (PDT)
Received: from Vinkys-MacBook-Air-39.local ([45.135.228.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141244511afsm6026783c88.3.2026.08.11.22.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:22:15 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nicoyip.dev@gmail.com,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH net v2] net: pktgen: use a consistent flow count
Date: Wed, 12 Aug 2026 13:21:30 +0800
Message-ID: <20260812052130.32823-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pktgen_if_write() can update cflows while the packet generator thread is
inside mod_cur_headers(). The latter first tests cflows, but f_pick() then
reloads it when selecting a random flow.

This allows the following interleaving:

  CPU 0 (kpktgend)                 CPU 1 (proc write)
  if (pkt_dev->cflows) // 10
                                   pkt_dev->cflows = 0
  get_random_u32_below(pkt_dev->cflows)

get_random_u32_below(0) returns a full-width random value. Using that
value as an index into the fixed-size flows array causes an out-of-bounds
access. The kernel reported:

  BUG: unable to handle page fault for address: ffffc8fe2d2674bc
  #PF: supervisor read access in kernel mode
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 0 PID: 65 Comm: kpktgend_0
  RIP: 0010:mod_cur_headers+0x16f8/0x2840
  Call Trace:
   <TASK>
   pktgen_thread_worker+0x305a/0x6bc0
   kthread+0x2c6/0x3b0
   ret_from_fork+0x36e/0x5a0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Read cflows once at the start of mod_cur_headers(), pass the snapshot to
f_pick(), and use it for later flow-state decisions in the same packet.
Publish proc updates with WRITE_ONCE(). Flow selection then always uses a
nonzero count bounded by MAX_CFLOWS, while a concurrent update takes
effect on a later packet.

Fixes: 007a531b0a0c ("[PKTGEN]: Introduce sequential flows")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
---
v2:
  - Use the written value when reporting the new flow count.
  - Add READ_ONCE() to the remaining lockless cflows reads, including
    pktgen_if_show(), as suggested by Paolo Abeni.
v1: https://lore.kernel.org/r/20260802152309.821584-1-marsy12010123@gmail.com

 net/core/pktgen.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ee64f3012..e14bb9a48 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -566,6 +566,7 @@ static const struct proc_ops pktgen_proc_ops = {
 static int pktgen_if_show(struct seq_file *seq, void *v)
 {
 	const struct pktgen_dev *pkt_dev = seq->private;
+	unsigned int cflows = READ_ONCE(pkt_dev->cflows);
 	ktime_t stopped;
 	unsigned int i;
 	u64 idle;
@@ -590,7 +591,7 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 		   pkt_dev->nfrags, (unsigned long long) pkt_dev->delay,
 		   pkt_dev->clone_skb, pkt_dev->odevname);
 
-	seq_printf(seq, "     flows: %u flowlen: %u\n", pkt_dev->cflows,
+	seq_printf(seq, "     flows: %u flowlen: %u\n", cflows,
 		   pkt_dev->lflow);
 
 	seq_printf(seq,
@@ -675,7 +676,7 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 
 	for (i = 0; i < NR_PKT_FLAGS; i++) {
 		if (i == FLOW_SEQ_SHIFT)
-			if (!pkt_dev->cflows)
+			if (!cflows)
 				continue;
 
 		if (pkt_dev->flags & (1 << i)) {
@@ -1632,8 +1633,8 @@ static ssize_t pktgen_if_write(struct file *file,
 		if (value > MAX_CFLOWS)
 			value = MAX_CFLOWS;
 
-		pkt_dev->cflows = value;
-		sprintf(pg_result, "OK: flows=%u", pkt_dev->cflows);
+		WRITE_ONCE(pkt_dev->cflows, value);
+		sprintf(pg_result, "OK: flows=%u", (unsigned int)value);
 		return count;
 	}
 #ifdef CONFIG_XFRM
@@ -2373,7 +2374,7 @@ static inline int f_seen(const struct pktgen_dev *pkt_dev, int flow)
 	return !!(pkt_dev->flows[flow].flags & F_INIT);
 }
 
-static inline int f_pick(struct pktgen_dev *pkt_dev)
+static inline int f_pick(struct pktgen_dev *pkt_dev, unsigned int cflows)
 {
 	int flow = pkt_dev->curfl;
 
@@ -2383,11 +2384,11 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 			pkt_dev->flows[flow].count = 0;
 			pkt_dev->flows[flow].flags = 0;
 			pkt_dev->curfl += 1;
-			if (pkt_dev->curfl >= pkt_dev->cflows)
+			if (pkt_dev->curfl >= cflows)
 				pkt_dev->curfl = 0; /*reset */
 		}
 	} else {
-		flow = get_random_u32_below(pkt_dev->cflows);
+		flow = get_random_u32_below(cflows);
 		pkt_dev->curfl = flow;
 
 		if (pkt_dev->flows[flow].count > pkt_dev->lflow) {
@@ -2461,12 +2462,14 @@ static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
  */
 static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 {
+	unsigned int cflows;
 	__u32 imn;
 	__u32 imx;
 	int flow = 0;
 
-	if (pkt_dev->cflows)
-		flow = f_pick(pkt_dev);
+	cflows = READ_ONCE(pkt_dev->cflows);
+	if (cflows)
+		flow = f_pick(pkt_dev, cflows);
 
 	/*  Deal with source MAC */
 	if (pkt_dev->src_mac_count > 1) {
@@ -2582,7 +2585,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 			pkt_dev->cur_saddr = htonl(t);
 		}
 
-		if (pkt_dev->cflows && f_seen(pkt_dev, flow)) {
+		if (cflows && f_seen(pkt_dev, flow)) {
 			pkt_dev->cur_daddr = pkt_dev->flows[flow].cur_daddr;
 		} else {
 			imn = ntohl(pkt_dev->daddr_min);
@@ -2611,7 +2614,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 					pkt_dev->cur_daddr = htonl(t);
 				}
 			}
-			if (pkt_dev->cflows) {
+			if (cflows) {
 				pkt_dev->flows[flow].flags |= F_INIT;
 				pkt_dev->flows[flow].cur_daddr =
 				    pkt_dev->cur_daddr;
-- 
2.25.1


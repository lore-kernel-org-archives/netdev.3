Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735F1C861D
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684229; cv=none; b=rIuJDjrEfZNZyrhjSrsFya3JlVcWkPZLqAUZlx35QVmUDb8LD2F2T5hmQodUHP70uVRkb/rjn31yFiZItT/XbtYdjpH8GDZqRm8bopuButZ9vOZiPhmJ4/gSReXjk0dq4MJDSAj5dD8MUiS3NieC+fC/gqMecAMFuUNJxNeI/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684229; c=relaxed/simple;
	bh=ToY9uHYPwnCExAaylf1jjhCH7i6dkAib+8j00Q4rQnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bfj5KCbX0u1Q4NL0Vuy05rI3AU+M9oST5nWbQngJWYCh3nWik8fuK4Pj0hoih7MiKhkktysmKbxBrqKMTj3cPSZpnJz7bNPPAOQITDIwZ1a/D+COxtkVB0EIMy2qLS4YLfXGvmfKWHCl8GzsoWn7dhcFpGbU8nZuV7gdpa79mHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgyc5fp4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgyc5fp4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc73e322dbso23330425ad.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785684227; x=1786289027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rUwniuzrkpCFpQcic8q1OxrQ7B0joRHxWX+7MTlOezo=;
        b=Hgyc5fp4+hebouc5ZSKkMT3ROXpEvcLGV6j+K+eFS0hIZILgqzeFNGoHlBo3Ik8XI4
         L7rkcwDIvRHfV1Ckib7nLUEv7FTD7ozQFn35YAPucW5RrsoE5w40QjgzVpJLpKeERNb1
         3AY0kolXuOP1rcW8Fwb08hF2AtxgeQRT3kkpcSNql/t92UUwVCbacNzh+AJykRdcVl62
         YyDjASjIwtRS2HcLfZ8UBKzqtSHJBdG0nXtQhGGUJXYvGlavUJhB23d+9+AfihBxwFGG
         qpBFHyG/K0BmzvvCeoX0TaVRnD0gmLaC3DYDt+PFXxXHmLC6Ofqpr5F0byhpSz3aDbQI
         sQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684227; x=1786289027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUwniuzrkpCFpQcic8q1OxrQ7B0joRHxWX+7MTlOezo=;
        b=ID0Mrktqg37IsZiAsRtyFEmVO0AkrqpxvdAAbxp/zReZEQ6T8KJFwG0TCXaBM/GToU
         xRqsouJt804AW8Jc/QNIXsXtctEtxxvF4cQffRZe1jIqdX6oirSveLX+89BwQA2/xLe9
         OJeJofgIwAq19k82z0MnCn4iPN3UTbHQnD4tL1i15ev6vnnWF6z+GvVspm6FrQfvsWPr
         /lRL9UQC03hs1Sn9yUxUJynpfnfwEtibkiaV2pSiIr4t017NLfRXKy9PheDzGyM2DHL8
         M6Kd49JDDY6qXbiletAIHpD+6ZES448JbajdxrQbJsxj3E1tZnXkR9gqNEFYQ/0kNm/D
         FZ2w==
X-Gm-Message-State: AOJu0YykbJjlZurh+RI/IJewLB2on++P1AaRYd4XFbMsJ4mMRaYyM5AM
	XpD2TgoBXrWJ916ueW1aTGlNjJ7cYjsYFdBwlFfAZ0szZ9s7oT/1Huu5
X-Gm-Gg: AR+sD11GSvxa0nx146+KEK5EvkD6a3debD39SGWbmMQSHYtRLofptFCuTfFIHu0+MMz
	MxdaMKpfaXlZbAYUrataVWTKkdBCUWIUGgmbzyTur12/2Vi4iAR9RnBGafrTVh5ygJGcE2wMcYd
	F1aeymatlw+ewMg/2r2X//SoKshFpKZ+896hMz5kw6DYGt1StC6E1TWrh0N/RfbdFsjioogrfMl
	A+OvxYz7M7wNcu6YjfVXFMErK33MsXGgF2rjWtvyFO7ClgaxMzLEcgr/XYW+QnZyf/51HIzkyGd
	IlFmGbWYH8uJTtNzSpL/rzEM50NnqS5jBGtOMDVvGMvobehtQUcUazigMJmHkFBT9t7QLbOre3z
	Hj5S6YVuJBPYiQf/chyYe768d9pUeigiXhe5OGzD7A/6LCD1Aff4+ZTujWIsu5ttqVOIlnWv+Gk
	Y7/F80dimcsScZQQGFHrUSL2/oFkaJQ/KNXSVKSHHwbZKG93Y5rE6GHJpn/xm4kNB3Z1biXvMsh
	q9dlSTHraWg04Adm9Zzu2ldm/hkgYtmFv3u3Rr7xI7+LQ==
X-Received: by 2002:a17:903:38c4:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d0521bc1a6mr71406475ad.1.1785684227415;
        Sun, 02 Aug 2026 08:23:47 -0700 (PDT)
Received: from chcpu15.cse.ust.hk (191host116.mobilenet.cse.ust.hk. [143.89.191.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ecfsm26640495ad.10.2026.08.02.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:23:46 -0700 (PDT)
From: Qi Zhang <marsy12010123@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robert Olsson <robert.olsson@its.uu.se>,
	Jamal Hadi Salim <hadi@cyberus.ca>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Zhang <marsy12010123@gmail.com>
Subject: [PATCH net] net: pktgen: use a consistent flow count
Date: Sun,  2 Aug 2026 23:23:09 +0800
Message-Id: <20260802152309.821584-1-marsy12010123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

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
 net/core/pktgen.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ee64f3012321..631cb1f55f6d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1632,7 +1632,7 @@ static ssize_t pktgen_if_write(struct file *file,
 		if (value > MAX_CFLOWS)
 			value = MAX_CFLOWS;
 
-		pkt_dev->cflows = value;
+		WRITE_ONCE(pkt_dev->cflows, value);
 		sprintf(pg_result, "OK: flows=%u", pkt_dev->cflows);
 		return count;
 	}
@@ -2373,7 +2373,7 @@ static inline int f_seen(const struct pktgen_dev *pkt_dev, int flow)
 	return !!(pkt_dev->flows[flow].flags & F_INIT);
 }
 
-static inline int f_pick(struct pktgen_dev *pkt_dev)
+static inline int f_pick(struct pktgen_dev *pkt_dev, unsigned int cflows)
 {
 	int flow = pkt_dev->curfl;
 
@@ -2383,11 +2383,11 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
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
@@ -2461,12 +2461,14 @@ static void set_cur_queue_map(struct pktgen_dev *pkt_dev)
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
@@ -2582,7 +2584,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 			pkt_dev->cur_saddr = htonl(t);
 		}
 
-		if (pkt_dev->cflows && f_seen(pkt_dev, flow)) {
+		if (cflows && f_seen(pkt_dev, flow)) {
 			pkt_dev->cur_daddr = pkt_dev->flows[flow].cur_daddr;
 		} else {
 			imn = ntohl(pkt_dev->daddr_min);
@@ -2611,7 +2613,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 					pkt_dev->cur_daddr = htonl(t);
 				}
 			}
-			if (pkt_dev->cflows) {
+			if (cflows) {
 				pkt_dev->flows[flow].flags |= F_INIT;
 				pkt_dev->flows[flow].cur_daddr =
 				    pkt_dev->cur_daddr;
-- 
2.43.0


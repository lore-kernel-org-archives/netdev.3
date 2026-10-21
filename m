Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598235;
	b=ZKe2WpY0rM+VIUuE2yGg4A+Z2B4Q980WWIsW/9b/1Xzuoc9n2YxLIi3T3IR3sJv8MEDY
	 qR3lSKKlInPltcfyiMH9hKrh5TnvRPGiLY3csWXs4soCKfmlgSIYWH4YQO8ucsIOzGtAq
	 uxPJXW5P6+ZRKsgS8j0TJgS4TItexlHYwC7KVwyxtVAHyQTEJzbNQDdUGAnPBuzu675Jy
	 MqnCcXg2bvDg2/H5kBdwViPDic79AJeKH75eHiEEIa8N1Q6dIwsEh6WvwDXlRESLHWvzK
	 LNgN99GJGXnEOeJqsyUW3oCr87EPYgdrYVNzofiYwQZH3xLwGPWVQcollySiVtNtBnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=knoq/Hz8VdzqraNUncDEQRWa4sgvuhUQyEtj317XXVo=;
	b=isC6pALvnY8aw5deQMp9QhObphJbB5OLH2tWYxrKvIfuBfQZ3qwRe5NXv5U0VAhxCtLO
	 g5Yif4oWdWsQ+vp39Fot2fQqjTMK/eR8S51q//dcEJMMNhE6+kn+xb30a1dcj8FMGPWE/
	 CObI8LPcJG/beTGFixN3pj2tNn0Z6mX7w5iWFV1CIS+wTB8bGAZaEqZMhV6YHi+H/wGTc
	 HxyEVagr/NSZxHa26CMcAph1P35tnkuC0foL5TgUjYMZbgoN4TP+IkgI1OCXjprY3Q4se
	 aTMP+8U7L2ITI5qATByVIEXWZKyRfMA6hbhcgbmqVOZI1pSr5wHA0XHthrH6Hs0fZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MzADfsxS;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C66606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C66606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MzADfsxS
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so320160a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598234; x=1793203034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knoq/Hz8VdzqraNUncDEQRWa4sgvuhUQyEtj317XXVo=;
        b=MzADfsxSAT7dj9/h9ouk8Y3QFSNGoRckfrw2ZO5PSpzYAPOMWpJmAsaFoS99WgZoYQ
         5vlguOZoYvJRTIFp25fte4xGBWMzuPCmI7JA+/MrIObsnc3tFN0eQtqygm+ztBU3jWPU
         EmEENBKYwVzDOGI1IWHGVc5T7XXUzzTQ7CcolIU5KCL+9nozcKpKhh16bHV8xloTtlqn
         QXehSeLNeQ13RfPq/2U3mczLt90XKtiVUB7noTgNzgxbdgpgbZ8Q4UblbkmSCXp9JlhL
         PSwDszEsQsUeqR5zKAuShncXnPf8aD3LTCRsUEAjrnG06ltEMuPOKoIF97gynM1lkqwP
         ESNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598234; x=1793203034;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=knoq/Hz8VdzqraNUncDEQRWa4sgvuhUQyEtj317XXVo=;
        b=QZpitnJfBz4kt/mrJeQvw0EoMFuFW9NecSotPM9mopPVrgLSw1CLC2SmYe0hgj/eQ5
         clWh414bz3f92fTqCvleEbVdZ2J0gZa8d+nvtaboCrfBk4JBLqvRvCu4zfSxS1NR7FaV
         YLCRBhmHfADCbPbIs/FYBQ196LbjoQ/11QMJs7okOCX5/G7nGWHgCylmnjZC2o0i6+t7
         e3WKUAfqdMKkdYXRcxaHGBEIqkiwdzOM4LNDOZRWKWn1hlvMslC+VDz2+XKGuaD9sNNA
         BibFPFnVQbj0jkQFha61lMFbVJIrmt/VnDqa2gpDue+2B7354ZK+RVu8Bb7wbnrNeyN2
         geBg==
X-Gm-Message-State: AFq9FYLSYmTvTZsy9o0P6YdXkGABG5aqn2yLwY3e+pHrUR8cILrWw77V
	sgNjL4fxxY2ZzFCzy/wkqL9TpazKy4E4rPiCU3RD6RkK3NTAgzozcvlU
X-Gm-Gg: AYBFou1OXD8wnVPFwTXODRozQOK+20ZzIgih5FqJ1iQmzCM+pAPrDWsqutyNcG+ra5r
	JsrEz7C/WMfe5u60WW7A15FbAMhy5+epMISuMQziv+845cb8SzG6heM+wRKVgu2cReMpFl+0wBk
	ErcHRG7AlAgmBO3f3sJHpD6BGthmw7CFYfS5LLPCRBEow/CpnH+Udg17nKkrBhp0bA38mOrjOJ9
	rhM/afBEbdbVaxwxCFMKglKpvo47xeehGKGEBOslcX+IEdn3rbXYNGbvDr0SnuN2z71y7ZG6jQu
	YFxecxiknzONUmXslBMWELmT/5JLP1zSjEI+7zR1X3v0oaLHmrPphhvD1xu6CbVnWl54d03uZRG
	41Y3DOA9e+Um/LP9mnE/aFw2OQxIJkn05KiB1B3/RWy6XKqIjiU8Cg2659EwO5gKTmqAbT8cYOT
	l1OWe63JIu8V4UqOT9yYq4TT2ozUg8nqqnwSQxDA/9CGa28rOvibniEyD1iqMe/A7urzX5p03PG
	mN5MM9Pa+0SlRowhyE3Uf6iP4PFEjPXU1tRME61u/pCipQ4YN1/lpvtANFwMtvYD+9HJR1inUzm
	kLChhLOHJcYLS2ZTkJfo7UWqAxW5BA==
X-Received: by 2002:a17:90b:164c:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3ad86cc64d2mr2256809a91.60.1792598234013;
        Wed, 21 Oct 2026 08:57:14 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48ed70dsm85357a91.4.2026.10.21.08.57.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:57:13 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net/sched: fq_codel: read flowchain under the qdisc lock in fq_codel_walk
Date: Wed, 21 Oct 2026 23:57:05 +0800
Message-Id: <20261021155705.69457-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fq_codel_walk() tests list_empty(&q->flows[i].flowchain) to decide whether a
flow is on the new/old flow lists.  It runs from the RTM_GETTCLASS dump
(tc_dump_tclass -> __tc_dump_tclass -> tc_dump_tclass_root ->
tc_dump_tclass_qdisc -> cl_ops->walk).  RTM_GETTCLASS is registered without
RTNL_FLAG_DUMP_UNLOCKED (net/sched/sch_api.c:2533-2534), so rtnl_dumpit()
runs the walker under rtnl_lock.

The egress datapath splices the same flowchain under the qdisc root lock
instead, not rtnl:

  [w] list_add_tail(&flow->flowchain, &q->new_flows)   fq_codel_enqueue :211
  [w] list_move_tail(&flow->flowchain, &q->old_flows)  fq_codel_dequeue :302/:313
  [w] list_del_init(&flow->flowchain)                  fq_codel_dequeue :315
  [r] list_empty(&q->flows[i].flowchain)               fq_codel_walk    :742

list_empty() reads one word (head->next, via READ_ONCE); __list_add() writes
it with a plain store.  The two locks are disjoint, so the walker's read is
not excluded from the datapath writers.  The walker and the enqueue path can
run concurrently (enqueue is on the xmit path and does not take rtnl), so this
is a genuine unsynchronised read of a list_head that the datapath mutates.

Impact is limited: a stale "empty" answer only makes the dump skip a class
(the per-class stats path re-takes the lock in fq_codel_dump_class_stats), so
this is a data-race / cosmetic-dump-accuracy issue rather than memory
corruption.

Take the qdisc root lock around the membership read, the same lock the
datapath holds when it mutates the list.  The lock is released before
tc_qdisc_stats_dump() (which takes it again in fq_codel_dump_class_stats), so
there is no recursion.

Observed:

  (observed on the same path; the sampled race was in __alloc_skb, not the walker)
  BUG: KCSAN: data-race in __alloc_skb+0x17c/0x314
   __alloc_skb+0x17c/0x314
   netlink_dump+0x30c/0x74c
   __netlink_dump_start+0x304/0x450
   rtnetlink_rcv_msg+0x5f0/0x830

Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KCSAN); it
opens both gates (the dumpit arm reaches fq_codel_walk), though the sampled
KCSAN report landed on a different symbol on the same netlink-dump path, not on
fq_codel_walk itself.  The defect below is argued from the code (disjoint locks
on the same list_head).  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
Unprivileged: RTM_GETTCLASS is an RTNL_KIND_GET, so no CAP_NET_ADMIN is
required for the dump that reaches the walker.  Impact is limited (a stale
"empty" answer makes the dump skip a class).

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/sched/sch_fq_codel.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index e6c87a32950f..789fdc6551a6 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -739,7 +739,18 @@ static void fq_codel_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 		return;
 
 	for (i = 0; i < q->flows_cnt; i++) {
-		if (list_empty(&q->flows[i].flowchain)) {
+		bool empty;
+
+		/* flowchain is spliced by the datapath (fq_codel_enqueue/
+		 * fq_codel_dequeue) under the qdisc root lock.  This walker
+		 * runs under rtnl_lock, which does not exclude those writers,
+		 * so read the membership under the same lock they use.
+		 */
+		sch_tree_lock(sch);
+		empty = list_empty(&q->flows[i].flowchain);
+		sch_tree_unlock(sch);
+
+		if (empty) {
 			arg->count++;
 			continue;
 		}

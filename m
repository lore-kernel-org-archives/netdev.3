Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A73D9DBD
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645475; cv=none; b=f4qSB/wAXPWTcClx8v6TVSVeED5Fhd5NgXtjcPEXe9+pULhr5XcmxvZzORQx+XCJWiLeLkP1eWPaGYFjuZ20VnxEg+Ep9STCTAf4EVhNygJHmfsvA1r29blUhGWTLEpxO0Lelt4Gwwg57I4bmXGlpXOb8SORrhltn4VsDelHlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645475; c=relaxed/simple;
	bh=y36Ax4YF4yLRhFQxcrDxiQuFHif7Q8seDuq+RBUpD64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nfaBGvdwCFqhoSFkwaPQ2y+vTW1QIQbA09S+5aiet3rjOnXe0Yl2c0Za6sSs2Q+aR7+k34JpXvbnGBtUpDpcD/Ra88sajDrOF9/7ntLCaD7Mlvzh1Sxb0w/zb9D6WvvlWIFISe0lvgBVMdT3iEshdPhL6gkJ9aLHl6taWP850ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Xr1KNS+v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Xr1KNS+v"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0cea8883so3702161cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787645472; x=1788250272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+8bCsdXT6TwceZuqICOBhZfZqT0QVpIoiBUtUgZYLk=;
        b=Xr1KNS+veY9k3VC6pc3N+QZIvc51vhjR8eGAxIhzcO4LyqyvlqIGiQyJ21hTM/Pqkw
         2ZWmSvGgmmkdMnKsWOMQ2K5xOSDD/wYTXo1z21gMhOhn/jBnn87uU2JQiMazygHXo2BD
         v14wGyiJcoJc5cq+x1AK28SNnA1v6C0lG01QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645472; x=1788250272;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d+8bCsdXT6TwceZuqICOBhZfZqT0QVpIoiBUtUgZYLk=;
        b=SiwapbVXJBOUL1bv3OaG78HOonvBu8Sk6muH3mR+J0NvQC4bp2O0ZGWv+QenZzsVNl
         h7rYnEmRKx+xtwIc2POxfQFZ4b7xI2ZR5yeNb8++F3KKf45JYJTNEJRMBuYHRFjdcxh7
         ruhNYwdHR8FRfs6AZejYzvsUXCtOdpDUKYygezNbpR/yVj+BvF94h7r5fYlA73eBJMPL
         OW/dNmP6rnJg5Lba7dt3rX9yYS6KoDL4SMZjzpZGndUvCxoaLyEwaYwbncV15o5F85ut
         9aGM6GADRDXnwZibwVux7quFdvI2++VtUfjXavWN4BrS63OfzcMHwiUP4TBNMzQTerBa
         s5LA==
X-Gm-Message-State: AFuF++nxjSFn1odDK9JND8eYqXhFRlNs6ihBtkIMzLjAw9og5F24Ul03
	8DOGz0Coye0ciZ2+/x9Ir73fZitmTDT5JDR7jHWvHertXPD7slxwGfcMxBU98mncKnKKTSQ4Rnf
	L0oAC8g==
X-Gm-Gg: AR+sD113Dy0l4N+PTe54UifkxmkrAtzIjSkcEOkl01VP03sSEQZPJcRxsn7os+bvkjc
	s/OFbueUXFDnpoNdbPQf7FIwHfozL9QXa/G8nZP4LBA/gi3BTqYehXha3XYl0IxojB45vEgJBK7
	BDj+gr8f1JSrlCVW9TCPX53y1bKWffeXwxz4HuxAA4vCKjq3w627KbgL330V+Ksk+fz039f6FOM
	PUXM5myvGPcLP5icfHBzyWAxBWFRVx91oRPJTXLeRH73TWjwuLUzIF5MnAJid0W3WdXcprGBstO
	u2JwTLA7hseAE6YjcDYmEkBZe6UbKhmVry/GcpRYE1ahCNex1El2MEwl28rSnxakIOhlzoNJ9gZ
	TZsRi8AGmUKZWURcsG6Ws/VyRgLlzGXwwWjen+YkE/rck7Sr+flfTgWX1sAbQY0te/27htx0kM6
	e3wxIF9ssXfr5Fp14Q/5d/HJ8n5j26lfzllevh9KyTd8sM6rd37B35
X-Received: by 2002:ac8:5c82:0:b0:52e:1364:debf with SMTP id d75a77b69052e-52e2ec67f64mr57421811cf.1.1787645471757;
        Tue, 25 Aug 2026 01:11:11 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09aae6f4sm64715251cf.16.2026.08.25.01.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:11:10 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 1/2] net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
Date: Tue, 25 Aug 2026 04:10:51 -0400
Message-Id: <20260825081052.133898-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gen_new_kid() falls back to returning max (htid | 0xFFF) when both
idr_alloc_u32() ranges are full, instead of reporting an error.
u32_change() trusts that value and inserts a new knode with a handle
that is already live in the hash table, breaking handle uniqueness
within the table's node ID space.

The handle was never reserved in ht->handle_idr, so every later error
path that does idr_remove(&ht->handle_idr, handle) removes the
reservation of a different, live knode, which is then reused — one
failed add compounds into further duplicates.

The 4095 limit is per (table, bucket) — ht->handle_idr is per hash
table and the range is derived from htid (bucketid), so a table with
divisor 256 can legitimately hold 256*4095 knodes.

The sibling helper gen_new_htid() has the same silent in-band failure:
it returns 0 when the tp_c handle pool (1..0x7FF) is full, and
u32_init() publishes the root hash table with handle 0 without
checking.  Two root tables with handle 0 alias in u32_lookup_ht(),
allowing cross-tcf_proto knode add/lookup/delete.  Add the same
exhaustion check that the divisor path already has.

Return an error so u32_change() fails with ENOSPC/ENOMEM when the
node ID space is exhausted, and so u32_init() fails with -ENOMEM
when the hash table ID space is exhausted.  The extack message
distinguishes pool exhaustion (-ENOSPC) from a transient allocation
failure (-ENOMEM).

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_CLS_U32=y (or =m with module loaded)
- Create a clsact qdisc on a device, then add 4095 u32 filters with
  auto-generated handles to fill the node ID space for the root hash
  table (single bucket). The 4096th auto-handle filter add triggers
  the duplicate handle (fh 800::fff reused). Reachable at Level 2
  (unshare -Urn, namespace-local CAP_NET_ADMIN).
- For gen_new_htid: create 2047 u32 proto entries on the same block
  to fill the tp_c handle pool, then create one more. The root table
  gets handle 0 and aliases with other handle-0 root tables.

Fixes: 7801db8aec95 ("net_sched: avoid generating same handle for u32 filters")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3:
- Fixed tdc test that sashiko (correctly) pointed potential security
  issue on.
- extack: condition the "Hash table node ID pool exhausted" message on
  -ENOSPC; emit a neutral "Failed to allocate node ID" for -ENOMEM
  Introduce small extack helper. The v2 message was misleading for
  -ENOMEM (Sashiko nipa gpt-5-6-sol-1-2).

Sashiko links (v2 RESEND reviews that prompted v3):
- gemini: https://sashiko.dev/#/patchset/20260822222049.114526-1-jhs@mojatatu.com
- nipa: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260822222049.114526-1-jhs@mojatatu.com

v1 -> v2:
- Commit message: removed misleading "4095-knode cap" claim (knodes is a
  liveness counter, not a limit; 4095 is per (table, bucket) via
  ht->handle_idr/htid); reworded to "handle uniqueness within node ID
  space"(sashiko).
- Commit message: added IDR-desync paragraph (max handle never reserved
  -> erridr removes other live knode's reservation -> reuse compounds).
- Commit message: noted ENOSPC/ENOMEM both reachable (idr_get_free/
  radix_tree_extend).
- Fixes: e7614370d6f04 -> 7801db8aec95 (duplicate-handle bug predates
  the IDR conversion; e761 only added the IDR-desync consequence).
- Added NL_SET_ERR_MSG_MOD(extack, "Hash table node ID pool exhausted")
  at both gen_new_kid() call sites; bare -ENOSPC -> "No space left on
  device" was confusing.
- Folded gen_new_htid() exhaustion check in u32_init() (Sashiko nipa
  main-1-0): same silent in-band failure pattern — gen_new_htid()
  returns 0 when tp_c handle pool full, u32_init() published root table
  with handle 0 without checking, causing cross-tcf_proto aliasing.
- Renewed tdc test (v1 tdc failed in long-running sweep, prompting v2).

Sashiko links (v1 reviews that prompted v2):
- gemini: https://sashiko.dev/#/patchset/20260820095236.68390-1-jhs@mojatatu.com
- nipa: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260820095236.68390-1-jhs@mojatatu.com
---
 net/sched/cls_u32.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index ac6d0fa5a40e..a3e65c8cf29e 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -370,6 +370,10 @@ static int u32_init(struct tcf_proto *tp)
 
 	refcount_set(&root_ht->refcnt, 1);
 	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : id2handle(0);
+	if (root_ht->handle == 0) {
+		kfree(root_ht);
+		return -ENOMEM;
+	}
 	root_ht->prio = tp->prio;
 	root_ht->is_root = true;
 	idr_init(&root_ht->handle_idr);
@@ -695,21 +699,33 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 	return ret;
 }
 
-static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid)
+static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid, int *err)
 {
 	u32 index = htid | 0x800;
 	u32 max = htid | 0xFFF;
 
+	*err = 0;
+
 	if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max, GFP_KERNEL)) {
 		index = htid + 1;
-		if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
-				 GFP_KERNEL))
-			index = max;
+		*err = idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
+				     GFP_KERNEL);
+		if (*err)
+			return 0;
 	}
 
 	return index;
 }
 
+static int u32_kid_extack(int err, struct netlink_ext_ack *extack)
+{
+	if (err == -ENOSPC)
+		NL_SET_ERR_MSG_MOD(extack, "Hash table node ID pool exhausted");
+	else
+		NL_SET_ERR_MSG_MOD(extack, "Failed to allocate node ID");
+	return err;
+}
+
 static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_CLASSID]	= { .type = NLA_U32 },
 	[TCA_U32_HASH]		= { .type = NLA_U32 },
@@ -1079,7 +1095,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		 * handle which is used to uniquely identify the match entry.
 		 */
 		if (!TC_U32_NODE(handle)) {
-			handle = gen_new_kid(ht, htid);
+			handle = gen_new_kid(ht, htid, &err);
+			if (err)
+				return u32_kid_extack(err, extack);
 		} else {
 			handle = htid | TC_U32_NODE(handle);
 			err = idr_alloc_u32(&ht->handle_idr, NULL, &handle,
@@ -1091,7 +1109,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		/* The user did not give us a handle; lets just generate one
 		 * from the table's pool of nodeids.
 		 */
-		handle = gen_new_kid(ht, htid);
+		handle = gen_new_kid(ht, htid, &err);
+		if (err)
+			return u32_kid_extack(err, extack);
 	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
-- 
2.43.0


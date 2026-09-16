Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C24BF924
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587476; cv=none; b=TPRAQxcgNY0RujiOSAdFV9VANYizVD4gGr+hmYV7nQ+MiujacfAiheiM9xG5HL6cntOT29zepKT0eHIioh39rGjhxZ+v/55DzcBwo4HzfBj4zps0zVrKduqfZVsINp4i80+wHmyplInhsBOcGgdjm9oTohP12EFOfcqi8M1ZORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587476; c=relaxed/simple;
	bh=yplVFRAFa94y/k5PPMn8uE7M5AkSzATAdqIoyN/qNAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLGPTlGJIU+iR5g8Sc587qEM0g7kK95Q9C/lV3Lt2ypt1jlkrwbUqpjMpOIMzj1nOjnxpRsjBEJ+N54BDcXS81cTY5nfkir/oPe84bVPbPFpYk865Sc1BeEjyA8GnCasnFpJSz3mUTrqjcIQEaV/o9FuzeIT1WJjqCTyirUNZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq9ffwJJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq9ffwJJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so766115e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789587460; x=1790192260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqBEDTU8nPSvf5UYETgqnWhTRAs3DpHURSqSqutOD2E=;
        b=gq9ffwJJl6pEQ8M+WG6WhaRBoYUyDWrVhP5pCnqASFXSqoGAXtw8uBYJ5hBj/ouHzP
         /hpiHIok08F7S12ru01kmthT0r1UvIJMqITYRQyO/enKll2V0PoTex+m9vll/gShZ0P3
         fm756zp7Khk7INV/v8gZ9dMHKSnHASZrRYv2fy4I8ofPb4BHi1TntM6SOI5ypfiHh/pE
         9BXvz+VKmxePazRyha1+tykXFz23CwIDPUjCNqUWKVowO/NVF4kE97tM5oE36Utxh910
         kiOev7wG8L1AX1nX3p+FSDAn0fNuNm5tamjuO+66ZQD+mtO42dohOMZlKXh7rFkVPOW1
         2D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789587460; x=1790192260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hqBEDTU8nPSvf5UYETgqnWhTRAs3DpHURSqSqutOD2E=;
        b=IrPi/7c94x9e1idw5m5noouggXexlOMGN1mM7CzoH14Obh9pCRvbkvvuqDr49BPVAe
         Z7H3te58LD/4rJMi6shnA9Uo45Q2jVLJUYwkmWQazkKmzJYtjjsmAbjU/Y170l1XGnhL
         InzjjHqM1prIKKQWr6Dam1e/UF3Rrlr5xyvjBPqp9kUjmkXZTzUI861p5pBrOr0+N/2f
         OKGnDOtOT/ssbgyplvyqIXOjYbh6o57y7D8yEzf79C8nVZ+jFVYreYVbQSWrA6REwfGw
         0FMcdLOYdY5bVmlYlw57bmw5nGv8qhPLVJL4IgNKU9/wd8iyCaQHLK8o6qkiUZsm3oOJ
         e2VQ==
X-Gm-Message-State: AFuF++nBnwVdgHAfgkPvletdK0ErQX/6aM28H6looy0ug1w6S+98a4nv
	WjTvPqbgLINzJ9QxcykxW9/0y2NhZFgM5jqAJ1zXUvmu6DFv3VlHcQgPGoGD+AZWwWk=
X-Gm-Gg: AYBFou2jgkyK+X3vHJQ86TPo7M5E76Kf1pTv/Z4Qiy9s5EN59mfKOCYXBcn3mNx/dRP
	qXm5yqqs5pBpg/LNXM3qs/3yLN6GprlzEEMebntsJu11npdS/XRxardvsQ1C43v9F6wvP1vg221
	JI1yUxz1FYoIPfcGsJMyEPgW9KZ0U1AfaUWwmz68sEl5GeW8K8VPoaeuSRO1dYcMymABIghfNI2
	9C6yVo1WWpOOhK62xTcuBij9K9v/aPD+kfstPsZuhInQFr+gp/ocW+UdVSPuXU7PT7zZqTUETph
	Z7PvHzT6aHF5gj+J27qyWkuIP1H6Z9PwuuJEL5HKP4e/NetTemC1do0/prNCL9/wuWnxE7rWvih
	MSppNNhxu2EkbkYZc1GwfrEuTgs14+j2EmjtZ04w7UggBMrXtYkxIslY03u3BSlujPlHfvzCgEm
	b/sZgO1dRTSfZWisF4Mzzlc3IP9gwAw9fiXRsaHnH59KwWxQulKZdbwc7Z7/lQu1s=
X-Received: by 2002:a05:600c:4505:b0:49c:fc6e:8cae with SMTP id 5b1f17b1804b1-49eb73475efmr47512675e9.18.1789587460386;
        Wed, 16 Sep 2026 12:37:40 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23ac75sm12936105e9.13.2026.09.16.12.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:37:39 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v2 2/5] vxlan: vnifilter: bound the number of VNIs one request may touch
Date: Wed, 16 Sep 2026 22:34:46 +0300
Message-ID: <20260916193449.2552039-3-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916193449.2552039-1-alishmery18@gmail.com>
References: <20260916193449.2552039-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With both endpoints bounded to the 24-bit space, a single RTM_NEWTUNNEL
or RTM_DELTUNNEL message can still ask for all of it.
vxlan_vni_add_del() loops over the span creating one VNI node and one
per-CPU stats block per iteration, all under rtnl_lock.

The span of one VXLAN_VNIFILTER_ENTRY is not the quantity to bound.
vxlan_vnifilter_process() calls vxlan_process_vni_filter() once per
entry, vni_filter_policy places no limit on how many entries the nest
may carry, and an entry carrying just START and END is 20 bytes on the
wire, so bounding each entry on its own would still let one message ask
for thousands of times the bound. Sum the spans of every entry and
reject the message as a whole in vxlan_vnifilter_check_msg(), before the
dispatch loop rather than inside it: entries are applied and notified
one at a time, so a limit enforced during dispatch would return -EINVAL
only after every preceding entry had already created its VNIs and sent
its notifications.

The limit is 4096, which follows from how the interface is used on
bridged VXLAN devices where the VNI is derived from the VLAN and so
cannot exceed the usable VLAN ID space. It bounds one message, not how
many VNIs a device may hold: a device can still be populated with the
whole space, it just takes more than one message. It is a driver-local
constant rather than VLAN_N_VID because a bound on a VXLAN netlink
request is not a count of VLAN IDs. One asymmetry is deliberate:
vxlan_vnifilter_dump_dev() merges a contiguous run sharing a remote into
a single entry with no clamp, so a device populated by several accepted
requests can dump as one entry this check refuses on replay. Chunking
the dump would not remove that, since the same run split into capped
entries still exceeds the limit when they arrive in one message.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/
 drivers/net/vxlan/vxlan_vnifilter.c | 88 ++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 5aaaaeee8110..9a1baca39d8b 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -17,6 +17,15 @@
 
 #include "vxlan_private.h"
 
+/* Maximum number of VNIs one RTM_NEWTUNNEL or RTM_DELTUNNEL message may add or
+ * delete, summed over all of its VXLAN_VNIFILTER_ENTRY attributes. VNI
+ * filtering is mainly used on bridged VXLAN devices where the VNI is derived
+ * from the VLAN, so a message touching more VNIs than the VLAN ID space has no
+ * practical use, while an unbounded message can walk the whole 24-bit space
+ * under rtnl_lock.
+ */
+#define VXLAN_VNI_FILTER_MSG_MAX	4096
+
 static inline int vxlan_vni_cmp(struct rhashtable_compare_arg *arg,
 				const void *ptr)
 {
@@ -846,12 +855,77 @@ static int vxlan_vni_add_del(struct vxlan_dev *vxlan, __u32 start_vni,
 	return err;
 }
 
+/* Derive the VNI range one VXLAN_VNIFILTER_ENTRY selects. Shared so that the
+ * count taken by vxlan_vnifilter_check_msg() cannot drift from the range
+ * vxlan_process_vni_filter() then acts on.
+ */
+static void vxlan_vni_filter_entry_range(struct nlattr **vattrs, u32 *vni_start,
+					 u32 *vni_end)
+{
+	*vni_start = 0;
+	*vni_end = 0;
+
+	if (vattrs[VXLAN_VNIFILTER_ENTRY_START]) {
+		*vni_start = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_START]);
+		*vni_end = *vni_start;
+	}
+
+	if (vattrs[VXLAN_VNIFILTER_ENTRY_END])
+		*vni_end = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_END]);
+}
+
+/* Reject a message asking for more than VXLAN_VNI_FILTER_MSG_MAX VNIs before
+ * any of its entries is acted on. Entries are applied one at a time and each
+ * one notifies as it goes, so a limit checked inside the dispatch loop would
+ * leave the entries ahead of the offending one already applied.
+ */
+static int vxlan_vnifilter_check_msg(const struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack)
+{
+	struct nlattr *vattrs[VXLAN_VNIFILTER_ENTRY_MAX + 1];
+	struct nlattr *attr;
+	u32 vnis = 0;
+	int err, rem;
+
+	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
+				 sizeof(struct tunnel_msg), rem) {
+		u32 vni_start, vni_end;
+
+		err = nla_parse_nested(vattrs, VXLAN_VNIFILTER_ENTRY_MAX, attr,
+				       vni_filter_entry_policy, extack);
+		if (err)
+			return err;
+
+		vxlan_vni_filter_entry_range(vattrs, &vni_start, &vni_end);
+
+		/* A start above the end selects no VNI at all and costs
+		 * nothing; leave it behaving as it does today.
+		 */
+		if (vni_end < vni_start)
+			continue;
+
+		/* vni_filter_entry_policy has already bounded both endpoints
+		 * to below VXLAN_N_VID, so one entry adds at most VXLAN_N_VID
+		 * and vnis cannot wrap before the test below rejects it.
+		 */
+		vnis += vni_end - vni_start + 1;
+		if (vnis > VXLAN_VNI_FILTER_MSG_MAX) {
+			NL_SET_ERR_MSG_ATTR_FMT(extack, attr,
+						"Request asks for more than %u VNIs",
+						VXLAN_VNI_FILTER_MSG_MAX);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
 				    struct nlattr *nlvnifilter,
 				    int cmd, struct netlink_ext_ack *extack)
 {
 	struct nlattr *vattrs[VXLAN_VNIFILTER_ENTRY_MAX + 1];
-	u32 vni_start = 0, vni_end = 0;
+	u32 vni_start, vni_end;
 	union vxlan_addr group;
 	int err;
 
@@ -862,13 +936,7 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
 	if (err)
 		return err;
 
-	if (vattrs[VXLAN_VNIFILTER_ENTRY_START]) {
-		vni_start = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_START]);
-		vni_end = vni_start;
-	}
-
-	if (vattrs[VXLAN_VNIFILTER_ENTRY_END])
-		vni_end = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_END]);
+	vxlan_vni_filter_entry_range(vattrs, &vni_start, &vni_end);
 
 	if (!vni_start && !vni_end) {
 		NL_SET_ERR_MSG_ATTR(extack, nlvnifilter,
@@ -975,6 +1043,10 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
+	err = vxlan_vnifilter_check_msg(nlh, extack);
+	if (err)
+		return err;
+
 	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
 				 sizeof(*tmsg), rem) {
 		err = vxlan_process_vni_filter(vxlan, attr, nlh->nlmsg_type,
-- 
2.53.0


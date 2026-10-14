Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE84E8E19
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981617; cv=none; b=QdMHuxhICEWPNOK2dZ9T0KrBmFL2INr1AvT2p4wleIowii7wZ0yyCU+KMdebcZVe2GMYke0htuaQuCBD3N+ILUr+ESxg83usxJKl7g3LHTNTgJf8vCSqOFHL20PbSQsZDsYRsK7Lb36P+daJrkiQtzoCc7IJHxSmcbrWFSBWYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981617; c=relaxed/simple;
	bh=xBZsWg657O0Kzvpg78Nn4idAJHQmNUGX/Dguk5wqE5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaSV/P3P2qswc08AXNH5ScBiqVeb5bGYFxRcRPnaS/l8zMjXJsvLw+xNrzUUMdYVwHHyqYlVq+2BOFsSzmRz055t7V9XalD0KNJf5IlUHv+F5wwCYOjKmSqXUbxggiv6TU1ynfn4u7f8UZDUC2rahVsdbyiTyk+9Zz6F2LvMDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTWTwB/P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTWTwB/P"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so34719815e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791981607; x=1792586407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j8lPCn9h1uuA3yPP/goaFyMU1vXNQ0kqv5qfig57c8=;
        b=oTWTwB/PphcFSQeYz+4CjijfFO7mTevKds5hwY9pTUDls4MIk87n2a4mlOfvwnmfQ1
         sHbqjFnPptVawAXk72tUJBxucGi7IMOO5VRdHR/ufnDbdp5Nm+5sZwXxLi/x68Tecj5s
         2F/yGvPIxStwasiwwrHSngiqIU/DRr+jCeQPEtv03hS9FjPIQ5eqJtfem6W7fiaOi6L9
         jmuLlxSHYWUzQ24gBMUtc/tUyqPOEDOHEee3XMouFys2xPAyQezbX8muTxK+agijp+71
         hZEUag6ofcFuXkwOwBXf49BcnRpz//p/cfmz/YOyxcijTKF7PAl5bZtGhsRFnUXTY2gc
         WRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981607; x=1792586407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7j8lPCn9h1uuA3yPP/goaFyMU1vXNQ0kqv5qfig57c8=;
        b=A9SO4EidfSjglccigeemuLbZWXI1KihaNnX2NZz51lV8LcbE6bzoeF63lUN7M7FmSz
         IG1hxLxuPJGDE4WIbdDRhkMetuOJwdh4TZFNere51gmd0ZMflyOSvE652JylR8l1mLpd
         +cVtqD/JWLd07/5K9PO40UVGEvd+vsewWVgsQ+NENkL7QHDQyp4ZS8KWMhhpxdJTksZ2
         CdocodD90fj4FtWU5H+ZfmR9hCw8OdzJotC3QlFU88IETqA2FuCIkCGy5tDKCv8riKek
         d+VKNcpi8X7dwujcdkArgvDIv26/I7BaP7T1y/cDMFqr6iEzVcNlMdxEjJA+RZrJl9F/
         rCfw==
X-Gm-Message-State: AFq9FYJJ/ZfiImU8Rh2cKqVgmEUhYOVqzI00iXn7lGpWEXjKHjBf+DCT
	Styikm0fEcXzVMbqRVHQjRAMSSIfSowqvm0Ku0aiTLqmLYJDpwfQq+bKkpd/V5SI3dk=
X-Gm-Gg: AYBFou2/KG6lw9AA0lkPELX51BgfRRI7nKvxiOKc5d4Ymtgp5JfYmEsjDFtuH4pJTBn
	VTnxcxEoYYIPHuj28h16a7NebFXwP2y/TTnDvZWE4ZHP9aBnLJtrmoiIcn1Ow/sBsGza0e5I5cw
	JZK9CDR7PCIpz9qw1TGHA9Ef3mgEJuwyxHUbVLriyDXqMlfnIMKkMfbw+LRECOS57AxLBSh7PhE
	imk9vZdMtFuv+akY2bjX5jaBrzVNcjGRhj6qH4cBBN1gJNQxTmB8U4eFF32mAl9wyC0iTZhYmGr
	1n3Y7TpkHez+h2GETSX38umc4pjOLTTtlO0McDHzlG4Do3c6Ed2CK9p8YAEldjJlhO3n0C+gSMA
	QiaWWtPQELoJMblPOVShhKDfE9nDMqdFOZ5/SLFGb18644zvwb1CHvb//z0DWJtlv3p7bPsdUYD
	t1IZvTdY3F9capsvkuxGJ27/QFZrDy44v+P+HjrDj9wtrTP49Bv6QsI5MdmgfO8u6NrYzl17aPD
	g==
X-Received: by 2002:a05:600c:5493:b0:4a1:78da:d271 with SMTP id 5b1f17b1804b1-4a18e4ee976mr343394145e9.30.1791981607167;
        Wed, 14 Oct 2026 05:40:07 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2ec47fcsm54163165e9.1.2026.10.14.05.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:40:06 -0700 (PDT)
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
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v4 4/7] vxlan: vnifilter: bound the number of VNIs one request may touch
Date: Wed, 14 Oct 2026 15:38:11 +0300
Message-ID: <20261014123814.388557-5-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014123814.388557-1-alishmery18@gmail.com>
References: <20261014123814.388557-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single RTM_NEWTUNNEL or RTM_DELTUNNEL message can ask for the whole
24-bit space in one range. vxlan_vni_add_del() then walks it one VNI at
a time under rtnl_lock, holding the lock for the length of the walk.
That walk is the cost being bounded, not the memory: an add allocates a
VNI node and a per-CPU stats block per VNI, a delete creates neither,
but both walk the same span and hold rtnl the same way, so both are
bounded.

The span of one VXLAN_VNIFILTER_ENTRY is not the quantity to bound. An
entry carrying just START and END is 20 bytes on the wire and a message
may carry many of them, vxlan_process_vni_filter() being called once per
entry, so bounding each entry alone would still let one message ask for
thousands of times the limit. Sum the spans of every entry and reject
the message as a whole in vxlan_vnifilter_check_msg(), before the
dispatch loop: entries are applied and notified one at a time, so a
limit enforced during dispatch would return an error only after every
preceding entry had been acted on. The range extraction is factored
into vxlan_vni_filter_entry_range() so the count and the range later
acted on cannot drift.

The limit, VXLAN_VNI_FILTER_MSG_MAX (4096), is the one the preceding
patch introduced for the dump; it follows the usable VLAN ID space,
since vnifilter is mainly used on bridged devices where the VNI is
derived from the VLAN. It bounds one request, not how many VNIs a
device may hold: the whole space can still be installed in more than
one request, and a
device holding it is still torn down in one step by
vxlan_vnigroup_uninit(), which is device teardown, not a netlink
message, and is not subject to this cap.

This is a policy narrowing of what a single message may ask for, not a
fix for a crash or corruption, and is not a backport candidate.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v4: use the constant the dump patch introduces; rebased.

 drivers/net/vxlan/vxlan_vnifilter.c | 80 ++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 5beec29eb84a..2999dd536625 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -971,13 +971,79 @@ static int vxlan_vni_add_del(struct vxlan_dev *vxlan, __u32 start_vni,
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
+/* Reject a request touching more than VXLAN_VNI_FILTER_MSG_MAX VNIs before any
+ * of its entries is acted on. Both add and delete walk the span one VNI at a
+ * time under rtnl_lock, so both are bounded. Entries are applied one at a time
+ * and each one notifies as it goes, so a limit checked inside the dispatch loop
+ * would leave the entries ahead of the offending one already applied.
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
+		/* A start above the end selects no VNI and costs nothing;
+		 * leave it behaving as it does today.
+		 */
+		if (vni_end < vni_start)
+			continue;
+
+		/* vni_filter_entry_policy has already bounded both endpoints
+		 * below VXLAN_N_VID, so one entry adds at most VXLAN_N_VID and
+		 * vnis cannot wrap before the test below rejects it.
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
 	const struct vxlan_config *cfg;
-	u32 vni_start = 0, vni_end = 0;
+	u32 vni_start, vni_end;
 	union vxlan_addr group;
 	int err;
 
@@ -988,13 +1054,7 @@ static int vxlan_process_vni_filter(struct vxlan_dev *vxlan,
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
@@ -1104,6 +1164,10 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!(cfg->flags & VXLAN_F_VNIFILTER))
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


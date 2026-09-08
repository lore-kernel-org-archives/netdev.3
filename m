Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B03D9DB3
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911707; cv=none; b=tU3bSeOs+WvR8q+Jfqf5zwp8I9AbLmVpWuG9MF1PlV32LzLhyWKPuon6n8ZVI4dwp3pkdn525uP40O2bmjSwT5lQWCJGNV/tYjE8s4kQKg+evTORXlu5prrCIrFOEeRDOwhHbmMAqcMsDYkNMMvdfb8kJsFebfCM30/we4d8MIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911707; c=relaxed/simple;
	bh=34maEfXL9tMu+NshyrBIaYVFQSwlFoJtqhIlZ/iNbjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLpseTjgQRLWshH4iSzJDWHzTKheZM8ZBBDPeN945YNCfqXBWsIWBGhNXz9eXHh1WM9/nUiEWSm3TyOUOx5dcplkR6r4WTMDWPtHN8nuWIKR6OVq0Ra3eFBgSuZdfP38wxS/AIxEOWs3ggk3hcNbbYSa8xsA0Nj2apfswQdUp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6ODhMeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6ODhMeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCF41F00A3A;
	Tue,  8 Sep 2026 23:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911705;
	bh=K2r2nTbNvPjKP3aVAttt5apv/VDhqpzVd7z9nIjasus=;
	h=From:To:Cc:Subject:Date;
	b=n6ODhMeTnwmPsX8zCsXWVH2lsXmonkHSLbQN2Cysfm8bvMPo6W0qcIOvaGXu5nl6U
	 HN1Rzyqn3c2NiM1GvTSGVo5mVfwLSaHqObgL1z4lsNgmASKoS6vqngPvSKZQIHPjbW
	 xxd9nymfvQwJ0luYvMuI6NL6pxSPHXVtXfFvdWb2wEoa/qxMnj/BzL0AziConyjNpl
	 Oyxb2vTMv1LUDB8lHEthPre4RnRWt46YwItiy/BkmW7u6A3VtlVpydHFMg5l97ePBY
	 y9y5sI7IU46l6xfiI/aqtzYbxGkQ4tY49JCYV8TRgcjW5g1LjcKA7xcnv6T7adDTOe
	 eFj9vEKPw17pQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	johannes@sipsolutions.net,
	fw@strlen.de,
	pablo@netfilter.org
Subject: [PATCH net-next] netlink: policy: report the big endian attributes
Date: Tue,  8 Sep 2026 16:55:00 -0700
Message-ID: <20260908235500.1642031-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paolo pointed out an issue flagged at low priority by Sashiko -
we're currently not handling BE{16,32} attributes in policy dumps.

Commit 3f4285d741b4 ("netlink: specs: fou: local-v4 and peer-v4 are big
endian") flipped two fou attributes from NLA_U32 to NLA_BE32.
This made them vanish from the policy dump.

Follow the YAML spec format and treat byte order as a property of
a u16 / u32 rather than a type of its own. I don't have a strong
preference either way. The YNL format "feels cleaner" but the
kernel's separate type is easier when handling decoding.
I don't think that the policy type is actually usable for decoding
(since it only contains input types) so I went with YNL and added
the separate attr.

A missing byte order means host order, again like in the YAML specs.

Link: https://lore.kernel.org/ab90f970-0ebb-4c07-b7b1-db3f91395116@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: johannes@sipsolutions.net
CC: fw@strlen.de
CC: pablo@netfilter.org
---
 Documentation/netlink/specs/nlctrl.yaml | 15 +++++++++++++++
 include/uapi/linux/netlink.h            | 14 ++++++++++++++
 net/netlink/policy.c                    | 16 ++++++++++++++--
 tools/net/ynl/pyynl/lib/ynl.py          |  8 +++++++-
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index 8b4472a6aa36..7e7c158e3e73 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -42,6 +42,16 @@ doc: |
       - bitfield32
       - sint
       - uint
+  -
+    name: policy-byte-order
+    doc: |
+      Byte order of an integer attribute. Zero is left unused so that it
+      can be taken to mean host byte order.
+    enum-name: netlink-policy-byte-order
+    type: enum
+    value-start: 1
+    entries:
+      - big-endian
 
 attribute-sets:
   -
@@ -152,6 +162,11 @@ doc: |
       -
         name: pad
         type: pad
+      -
+        name: byte-order
+        doc: Byte order of the attribute, absent means host byte order.
+        type: u32
+        enum: policy-byte-order
   -
     name: op-policy-attrs
     name-prefix: ctrl-attr-policy-
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index f87aaf28a649..82c41aeb4357 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -329,6 +329,17 @@ enum netlink_attribute_type {
 	NL_ATTR_TYPE_UINT,
 };
 
+/**
+ * enum netlink_policy_byte_order - byte order of an integer attribute
+ * @NL_POLICY_BYTE_ORDER_BIG_ENDIAN: big endian (network byte order)
+ *
+ * Zero is left unassigned so that it keeps meaning host byte order,
+ * which is also what a missing byte order means.
+ */
+enum netlink_policy_byte_order {
+	NL_POLICY_BYTE_ORDER_BIG_ENDIAN = 1,
+};
+
 /**
  * enum netlink_policy_type_attr - policy type attributes
  * @NL_POLICY_TYPE_ATTR_UNSPEC: unused
@@ -356,6 +367,8 @@ enum netlink_attribute_type {
  *	bitfield32 type (U32)
  * @NL_POLICY_TYPE_ATTR_MASK: mask of valid bits for unsigned integers (U64)
  * @NL_POLICY_TYPE_ATTR_PAD: pad attribute for 64-bit alignment
+ * @NL_POLICY_TYPE_ATTR_BYTE_ORDER: byte order of an integer attribute,
+ *	&enum netlink_policy_byte_order, absent if host byte order (U32)
  *
  * @__NL_POLICY_TYPE_ATTR_MAX: number of attributes
  * @NL_POLICY_TYPE_ATTR_MAX: highest attribute number
@@ -374,6 +387,7 @@ enum netlink_policy_type_attr {
 	NL_POLICY_TYPE_ATTR_BITFIELD32_MASK,
 	NL_POLICY_TYPE_ATTR_PAD,
 	NL_POLICY_TYPE_ATTR_MASK,
+	NL_POLICY_TYPE_ATTR_BYTE_ORDER,
 
 	/* keep last */
 	__NL_POLICY_TYPE_ATTR_MAX,
diff --git a/net/netlink/policy.c b/net/netlink/policy.c
index 08b006c48f06..574d44b7d518 100644
--- a/net/netlink/policy.c
+++ b/net/netlink/policy.c
@@ -234,6 +234,11 @@ int netlink_policy_dump_attr_size_estimate(const struct nla_policy *pt)
 		/* maximum is common, u64 min/max with padding */
 		return common +
 		       2 * (nla_attr_size(0) + nla_attr_size(sizeof(u64)));
+	case NLA_BE16:
+	case NLA_BE32:
+		/* same as the unsigned types, plus the byte order */
+		return common + nla_attr_size(sizeof(u32)) +
+		       2 * (nla_attr_size(0) + nla_attr_size(sizeof(u64)));
 	case NLA_BITFIELD32:
 		return common + nla_attr_size(sizeof(u32));
 	case NLA_STRING:
@@ -289,21 +294,28 @@ __netlink_policy_dump_write_attr(struct netlink_policy_dump_state *state,
 	case NLA_U16:
 	case NLA_U32:
 	case NLA_U64:
+	case NLA_BE16:
+	case NLA_BE32:
 	case NLA_UINT:
 	case NLA_MSECS: {
 		struct netlink_range_validation range;
 
 		if (pt->type == NLA_U8)
 			type = NL_ATTR_TYPE_U8;
-		else if (pt->type == NLA_U16)
+		else if (pt->type == NLA_U16 || pt->type == NLA_BE16)
 			type = NL_ATTR_TYPE_U16;
-		else if (pt->type == NLA_U32)
+		else if (pt->type == NLA_U32 || pt->type == NLA_BE32)
 			type = NL_ATTR_TYPE_U32;
 		else if (pt->type == NLA_U64)
 			type = NL_ATTR_TYPE_U64;
 		else
 			type = NL_ATTR_TYPE_UINT;
 
+		if ((pt->type == NLA_BE16 || pt->type == NLA_BE32) &&
+		    nla_put_u32(skb, NL_POLICY_TYPE_ATTR_BYTE_ORDER,
+				NL_POLICY_BYTE_ORDER_BIG_ENDIAN))
+			goto nla_put_failure;
+
 		if (pt->validation_type == NLA_VALIDATE_MASK) {
 			if (nla_put_u64_64bit(skb, NL_POLICY_TYPE_ATTR_MASK,
 					      pt->mask,
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 8682bf588e1f..fb5acb8acded 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -115,6 +115,7 @@ from .nlspec import SpecFamily
     NL_POLICY_TYPE_ATTR_BITFIELD32_MASK = 10
     NL_POLICY_TYPE_ATTR_PAD = 11
     NL_POLICY_TYPE_ATTR_MASK = 12
+    NL_POLICY_TYPE_ATTR_BYTE_ORDER = 13
 
     AttrType = Enum('AttrType', ['flag', 'u8', 'u16', 'u32', 'u64',
                                   's8', 's16', 's32', 's64',
@@ -122,6 +123,8 @@ from .nlspec import SpecFamily
                                   'nested', 'nested-array',
                                   'bitfield32', 'sint', 'uint'])
 
+    ByteOrder = Enum('ByteOrder', ['big-endian'], start=1)
+
 class NlError(Exception):
     def __init__(self, nl_msg):
         self.nl_msg = nl_msg
@@ -158,7 +161,7 @@ from .nlspec import SpecFamily
 
     Each policy entry always has a 'type' attribute (e.g. u32, string,
     nested). Optional attributes depending on the 'type': min-value,
-    max-value, min-length, max-length, mask.
+    max-value, min-length, max-length, mask, byte-order.
 
     Policies can form infinite nesting loops. These loops are trimmed
     when policy is converted to a dict with pol.to_dict().
@@ -454,6 +457,9 @@ from .nlspec import SpecFamily
             policy['bitfield32-mask'] = attr.as_scalar('u32')
         elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MASK:
             policy['mask'] = attr.as_scalar('u64')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_BYTE_ORDER:
+            byte_order = attr.as_scalar('u32')
+            policy['byte-order'] = Netlink.ByteOrder(byte_order).name
     return policy
 
 
-- 
2.55.0


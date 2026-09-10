Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F458F076
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070604; cv=none; b=OV3yk63wEQ8Z/eQJbYCxKVAETFHken6nnqwu5xcwesROm8taTL/DuaSiI453lxbhybTRhoRgjOs0GHZvJ9YP3YzNAjqtXf6+4Ojf1VbvD/n+LjMP8cbBz/nQy2xzEMjK/7dyCAzIVD/t4VOhWDcQySIpk0CZsu8+g5n7njolVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070604; c=relaxed/simple;
	bh=C7W806hlclB5V9N6j0kMaVdsjWCj4o2CabTp4qB8otw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy8OuALbzH5TChr5pJ/vNa3L4aWZCEaQ1GKjPhl4sSFnAuCnr6w+OX4XPRYS5DDtCwm4/dImQfHRJ9crf4wjuZ2AXoZK/9+jmF4FPaP/8hXip4izCagKmD+9FNlgrqrIxYTR1dKKGoSLx651huI9y1TIcgycpGaywnbfqY9vWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pih8pDal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pih8pDal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E451D1F0089B;
	Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070603;
	bh=6TFfYy6dDUig9jpx61Gh6k1VQO3no2QsKqyR68rJFFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pih8pDalj3UAbq/AVFDf+9+BkQeewFlBmtcP756L664wpd2gewzEu4l/J3qJ2XVRj
	 SkenXzsUZz2AhCOZN2xre3BaCIl04AIk1Wq8rdCzIfIrv23lKAm5f1Dd1IpxFzVpAP
	 wawJB2mxqUUdH0GnauQHXl67EKzOHEPrvN5xYQHCjDkzxCXToFf/K6RTuXrsZdEjZw
	 8C99xegugOu+Ayk6Mo5i6Gs0HBorqZXge00c0j1ufk+ZVQbyaTkTUPsejz9cwNtYaV
	 8D8evhRussjaMe6bwoBeGyCbavwLrmY4aMkdNFxFMn84mOrL8t4MQznNGJcyzD967V
	 1y4Vuq42av1DQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiri@resnulli.us,
	tariqt@nvidia.com,
	moshe@nvidia.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/8] devlink: generate the port function policy from the spec
Date: Thu, 10 Sep 2026 13:03:09 -0700
Message-ID: <20260910200312.2665792-6-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910200312.2665792-1-kuba@kernel.org>
References: <20260910200312.2665792-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devlink has a one huge root attribute set for the whole family,
we haven't taken the time to properly define the sub-sets for
each command. Do it for port-set so that we can drop the hand
written policy used by devlink_port_function_set().

We need this subsetting because within the DEVLINK_ATTR_PORT_FUNCTION
nest DEVLINK_PORT_FN_ATTR_OPSTATE and DEVLINK_PORT_FN_ATTR_DEVLINK
are output-only so we have to filter them out of the input set.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 37 +++++++++++++++++++++++-
 net/devlink/netlink_gen.h                |  3 +-
 net/devlink/netlink_gen.c                | 13 ++-------
 net/devlink/port.c                       | 19 ++----------
 4 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 962789dfbfac..f23466fb27f9 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1001,6 +1001,41 @@ doc: Partial family for Devlink.
         name: max-io-eqs
         type: u32
 
+  -
+    name: dl-port-function-set
+    subset-of: dl-port-function
+    doc: |
+      Port function attributes that can be configured; opstate and the
+      devlink handle are read-only.
+    attributes:
+      -
+        name: hw-addr
+      -
+        name: state
+      -
+        name: caps
+      -
+        name: max-io-eqs
+
+  -
+    name: dl-port-set
+    subset-of: devlink
+    doc: Attributes accepted by the port-set request.
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
+      -
+        name: index
+      -
+        name: port-index
+      -
+        name: port-type
+      -
+        name: port-function
+        nested-attributes: dl-port-function-set
+
   -
     name: dl-dpipe-tables
     subset-of: devlink
@@ -1429,7 +1464,7 @@ doc: Partial family for Devlink.
     -
       name: port-set
       doc: Set devlink port instances.
-      attribute-set: devlink
+      attribute-set: dl-port-set
       dont-validate: [strict]
       flags: [admin-perm]
       do:
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 75572a9a23f6..99ccacc693b7 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,9 +13,8 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
-extern const struct nla_policy devlink_dl_nested_devlink_nl_policy[DEVLINK_ATTR_INDEX + 1];
 extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1];
-extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS + 1];
+extern const struct nla_policy devlink_dl_port_function_set_nl_policy[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 17d1edcdb935..43ef6864d462 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -46,25 +46,16 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 }
 
 /* Common nested types */
-const struct nla_policy devlink_dl_nested_devlink_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
-	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
-	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
-	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
-	[DEVLINK_ATTR_NETNS_ID] = { .type = NLA_U32, },
-};
-
 const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
-const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS + 1] = {
+const struct nla_policy devlink_dl_port_function_set_nl_policy[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
-	[DEVLINK_PORT_FN_ATTR_OPSTATE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
-	[DEVLINK_PORT_FN_ATTR_DEVLINK] = NLA_POLICY_NESTED(devlink_dl_nested_devlink_nl_policy),
 	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = { .type = NLA_U32, },
 };
 
@@ -106,7 +97,7 @@ static const struct nla_policy devlink_port_set_nl_policy[DEVLINK_ATTR_INDEX + 1
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_TYPE] = NLA_POLICY_MAX(NLA_U16, 3),
-	[DEVLINK_ATTR_PORT_FUNCTION] = NLA_POLICY_NESTED(devlink_dl_port_function_nl_policy),
+	[DEVLINK_ATTR_PORT_FUNCTION] = NLA_POLICY_NESTED(devlink_dl_port_function_set_nl_policy),
 };
 
 /* DEVLINK_CMD_PORT_NEW - do */
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1528f2d148df..803429d9a008 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -6,19 +6,6 @@
 
 #include "devl_internal.h"
 
-#define DEVLINK_PORT_FN_CAPS_VALID_MASK \
-	(_BITUL(__DEVLINK_PORT_FN_ATTR_CAPS_MAX) - 1)
-
-static const struct nla_policy devlink_function_nl_policy[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1] = {
-	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY },
-	[DEVLINK_PORT_FN_ATTR_STATE] =
-		NLA_POLICY_RANGE(NLA_U8, DEVLINK_PORT_FN_STATE_INACTIVE,
-				 DEVLINK_PORT_FN_STATE_ACTIVE),
-	[DEVLINK_PORT_FN_ATTR_CAPS] =
-		NLA_POLICY_BITFIELD32(DEVLINK_PORT_FN_CAPS_VALID_MASK),
-	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = { .type = NLA_U32 },
-};
-
 #define ASSERT_DEVLINK_PORT_REGISTERED(devlink_port)				\
 	WARN_ON_ONCE(!(devlink_port)->registered)
 #define ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port)			\
@@ -782,11 +769,11 @@ static int devlink_port_function_set(struct devlink_port *port,
 				     const struct nlattr *attr,
 				     struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[DEVLINK_PORT_FUNCTION_ATTR_MAX + 1];
+	struct nlattr *tb[ARRAY_SIZE(devlink_dl_port_function_set_nl_policy)];
 	int err;
 
-	err = nla_parse_nested(tb, DEVLINK_PORT_FUNCTION_ATTR_MAX, attr,
-			       devlink_function_nl_policy, extack);
+	err = nla_parse_nested(tb, ARRAY_SIZE(tb) - 1, attr,
+			       devlink_dl_port_function_set_nl_policy, extack);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Fail to parse port function attributes");
 		return err;
-- 
2.55.0


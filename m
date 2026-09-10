Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA357D22F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070604; cv=none; b=UGXS0F+7qddg4sQfkM3jRxOl8u7wdEYospn3HvdWgsZXCNmdC2I1cnOABllOa1FYsNLtD/PtKQoYQ36BggEbZCkqZnYxCaYiT+FYweypkKfWsZX+ZsF0Img9pir4lpQGnKLnTshWAFX8nfzA7WCD2TsCRK8LQLIVDgA3sJ0ejj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070604; c=relaxed/simple;
	bh=Cxl04WvO+nVrAEjru5lQG1bwdm7V4ZJnuJYZE5Uz320=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kj+BOuhYfwVv76mc3snkecY/8VX53uJmkjPyJCcBVfVu8cctssAc+Z4gRPHfZdL2YYo3GxHbkeNE1ngzev0DUgTNoHmpZEv+/JdsOR2cWkVM82E0xOazujdOEJr7kbqO6zeVdCC2UkARoEqT8cSDS3Vms10hc/EUmqTYWUHJqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4mG2L2C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4mG2L2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B2F1F000FF;
	Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070602;
	bh=1L0SD5tsj/rMqHbCYn27/ZUjHexXZNGzbZuG2dIyMII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4mG2L2CPLv4ouyDCNceN3Vr17tSj+VxEeJU36zswTUn2Ol0ra18C7zd0lQfVjoIc
	 y0D5HIYRU0lUoDNoLrxtr4RpEEiZqL08kLHbkLOehFm91KYf5YWUbjlRoKMy4o5UNm
	 F/7f2Fnpxv0gIIY+Tjcn0xEisFvwb/JkDNlVrhth3OMZy4SKfI8nTBSbpi8KeAxHuq
	 Yolf4qBcSnkNyoCS3ckvbhiU5GVNzPXGgFY+6TeyOijk6etiR6iS7VizsObKa/IV0F
	 kJMWcTRTKZJfNTFF8G2G2U16QGLVod1fOWd9ugrszRDHh2y/zGAlArG48eK4dwsUmq
	 v9d0VacpYbukg==
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
Subject: [PATCH net-next 4/8] netlink: specs: devlink: complete the port function nest
Date: Thu, 10 Sep 2026 13:03:08 -0700
Message-ID: <20260910200312.2665792-5-kuba@kernel.org>
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

dl-port-function stops at caps, but the nest also carries
DEVLINK_PORT_FN_ATTR_DEVLINK (5) and DEVLINK_PORT_FN_ATTR_MAX_IO_EQS (6)
both put by devlink_nl_port_function_attrs_put() on every port-get
do and dump. YNL raises

  Space 'dl-port-function' has no attribute with value '6'

for any port reporting max_io_eqs or a nested devlink handle,
i.e. for mlx5 SFs and VFs.

Commit 5af3e3876d56 ("devlink: Support setting max_io_eqs") added the
uAPI value and the hand written policy but never touched the spec.

Add the missing attributes, subsequent commit reworks the code
to use the YNL-generated policy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml |  8 ++++++++
 net/devlink/netlink_gen.h                |  3 ++-
 net/devlink/netlink_gen.c                | 11 ++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 7ec52f81c323..962789dfbfac 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -992,6 +992,14 @@ doc: Partial family for Devlink.
         type: bitfield32
         enum: port-fn-attr-cap
         enum-as-flags: true
+      -
+        name: devlink
+        type: nest
+        nested-attributes: dl-nested-devlink
+        doc: Handle of the peer devlink instance instantiated for this function.
+      -
+        name: max-io-eqs
+        type: u32
 
   -
     name: dl-dpipe-tables
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index a70e0e4769aa..75572a9a23f6 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,8 +13,9 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
+extern const struct nla_policy devlink_dl_nested_devlink_nl_policy[DEVLINK_ATTR_INDEX + 1];
 extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1];
-extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 30f01901b587..17d1edcdb935 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -46,17 +46,26 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 }
 
 /* Common nested types */
+const struct nla_policy devlink_dl_nested_devlink_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
+	[DEVLINK_ATTR_NETNS_ID] = { .type = NLA_U32, },
+};
+
 const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
-const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
+const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[DEVLINK_PORT_FN_ATTR_OPSTATE] = NLA_POLICY_MAX(NLA_U8, 1),
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
+	[DEVLINK_PORT_FN_ATTR_DEVLINK] = NLA_POLICY_NESTED(devlink_dl_nested_devlink_nl_policy),
+	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = { .type = NLA_U32, },
 };
 
 const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1] = {
-- 
2.55.0


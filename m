Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248B46EC6C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070602; cv=none; b=pswklvec8C5zJdw4KPrnwEcS0zDu7cFNQ60I3wnXv+kiamCbqivhNjZIsfFDenrHhv9FX503JymaACbcYSiycXABtHWHHsA4oyPQaH5RaX0bfIX1kK25aGhU/28/JLOYakslWhfJcx8cRgrU/COuaW6yhpzk2Lq6l1hXZt7w7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070602; c=relaxed/simple;
	bh=H4VOyWKpXIsw0GxfF+3M38eVV2GG01HyDOHIaM3ABpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1N8Df1CyhBGd5ULvEQaYqQkqBJTrYoUo34nq43L8WTuTL8AISsOOjGqoL1E36VUvlclSMx1qL53Q9PBt1IoeVoGsVYppUHvoSL8dxToAcl/z4kYIX5ef3JuPyccxAmWM/5r++XeFYe0+3hret5qe5n0ZVeoZNkF/9W68+jjpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1T7LUcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1T7LUcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0956E1F00893;
	Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070601;
	bh=4jda5XqgAAozfz2Oh7ET3X7j4CpQtRxco6p6RqQgPjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1T7LUcEQBinTBcoG0Bn+rgLUoVoozUalNZORWmVHjyLKFnVIiOBQ/buoDg4BqJv2
	 y+zSUtTtHB1bWNB1b8AjtMLTVgARUu/4bMCKXOUA8n5ONRF7FDdGLZtWRptIcDpe3h
	 t3YrteGal5rECM0kV/Q+qjTyViwzWR9e6tC+hzenwFXdYmw46XrzsVc9cfeH71CIQh
	 RKjEkTxG/3SrA8EG566gKWBXkAj9t/0sZf5ABaCasCRHPeOr1UbFZ19ZKjCgTZSDsi
	 VVBCmCkXco2RTyqtqGdKhPbMb3cGhxrD+e+ZfZQW6pP+RJxeeFJN195un1v+sdD+Gg
	 r7+hLWytVnjjg==
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
Subject: [PATCH net-next 1/8] devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS
Date: Thu, 10 Sep 2026 13:03:05 -0700
Message-ID: <20260910200312.2665792-2-kuba@kernel.org>
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

DEVLINK_ATTR_RELOAD_LIMITS carries enum devlink_reload_limit, the spec
says enum devlink_reload_action. The two are unrelated, and have
a different set of values (bits 1, 2 vs bits 0, 1).

AFAICT this is a cosmetic change - both DEVLINK_RELOAD_LIMIT_UNSPEC
and the out of bounds bit 2 will be rejected either way because drivers
don't declare them as supported. User will see either a policy
validation failure or "Requested limit is not supported by the driver".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 15 ++++++++++++++-
 net/devlink/netlink_gen.c                |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 38b1190f3d26..d933b205ee86 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -174,6 +174,18 @@ doc: Partial family for Devlink.
         value: 1
       -
         name: fw-activate
+  -
+    type: enum
+    name: reload-limit
+    entries:
+      -
+        name: unspec
+        doc: no constraints
+      -
+        name: no-reset
+        doc: >-
+          No reset allowed, no down time allowed, no link flap and no
+          configuration is lost.
   -
     type: enum
     name: param-cmode
@@ -775,7 +787,7 @@ doc: Partial family for Devlink.
       -
         name: reload-limits
         type: bitfield32
-        enum: reload-action
+        enum: reload-limit
         enum-as-flags: true
       -
         name: dev-stats
@@ -793,6 +805,7 @@ doc: Partial family for Devlink.
       -
         name: reload-stats-limit
         type: u8
+        enum: reload-limit
       -
         name: reload-stats-value
         type: u32
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index dec00133178d..30f01901b587 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -334,7 +334,7 @@ static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_INDEX + 1]
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_RELOAD_ACTION] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
-	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(6),
+	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(3),
 	[DEVLINK_ATTR_NETNS_PID] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_NETNS_FD] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_NETNS_ID] = { .type = NLA_U32, },
-- 
2.55.0


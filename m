Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909540B106
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488832; cv=none; b=fDAXmUBX3p8A7zH5M8re80kbEU3WxpeYn/qkCvieYV33Y44NRQmSqAy83MDUzegLjD/5KVfS+1r3YR5t4JHl+zOY/ZmLNQos2K61zKW1ZHh/bpqXxO5/+Q8piKR6bRhNvPRbSahOqkFV6CfPb/Fvu98PeBnSv2Fhysv1u3mxB5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488832; c=relaxed/simple;
	bh=O4tzRXYPkOKe13DIWy+rV1pLcz1urPlGU0z3hv1vPV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYfyeSYDNLhQocO9G8OYlNUzhTBR62G2LyaAGLwfPK2iAL+2TcSnE/5ml5PnuOfUNk9SPsd8AwO5/tLGJR1X7MAZroj9VXzn3/gtT/m6S3erStBZrSZERR3pqxvloEw9lxdNdCxJISliDjNqgp2oFRprcZkxQpxk+6rgHJl6hHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeEIIdeu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeEIIdeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AB51F0089E;
	Tue, 15 Sep 2026 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488831;
	bh=D02B+VXDexb3KSoZ4pfRR1fzHShVZcaAWIJG7ciAt6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeEIIdeunqEGolCui+yMkby0hbVlPnaKnlWKVHm/+b3QwceNDYSAGd25s8Wx6nA1N
	 mx/Uk3frMKe8DE8pLo86e3ru4X6baZmbgtlqSru0ZvOKCPe0nF3NE/flNa8qAdV/dV
	 mDfi7CZPutOx7zx0Lorh9jP3cUPMbdgLm57y2umN1ym00uiypOqj+gAtvsJFKgM4Tw
	 utlpnFjjxwjCUkkNPheUdLWLaEzNSUBJBcZZVJeZepQfNT5vNS/WkIMQAw0UotYgbL
	 7lMNeilc/c9w29+Ff7YzV0Jg8NPRCm+DMG7E33TC2heuUvTsyVTcfRMEpehU8YRueS
	 DDvwIEOKd0piQ==
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
Subject: [PATCH net-next v2 1/9] devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS
Date: Tue, 15 Sep 2026 09:13:33 -0700
Message-ID: <20260915161341.1053476-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915161341.1053476-1-kuba@kernel.org>
References: <20260915161341.1053476-1-kuba@kernel.org>
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

While at it annotate the right enum for reload-stats-limit

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: add the last sentence to the commit msg
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


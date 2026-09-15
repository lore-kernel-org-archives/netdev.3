Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57341378D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488833; cv=none; b=R32mVX7Ub0I5U5i68/XdT/NCTOgh3x1w4jf4t5lMfPRONNIACcmnA5DGR6BP2cSWtmEof6Jybs+TBt7UYJ/6t0AquJqBZ4vrzrEUKCKnSXn8LiglgHoIYLS5dgXBPERSjX/UVJuaEUG5EIPfhqKZBgDuzrDkeHlsuJgy/sAszXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488833; c=relaxed/simple;
	bh=2BRBk/8PXfnl6bp4WdEiSGvutAo2nFmJSI1Od5BZmPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lB9Lp+lxbMeQICh3KENvhiR57Ar2Lx0ioRkCJ4cJt4SjkngCqgq4rngul6QLdqbfJgJ+DVUcMuGCB6T5mkJQrPTQuIuIpgClxPOlBQjScnDPEOYy2tiz7jL1fJws515bdCwyRvZP9B12yKIgLv4/DHXJHRMsnUP23ePYwEVeThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfQ3eKmP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfQ3eKmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAAF1F0089B;
	Tue, 15 Sep 2026 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488832;
	bh=vYbRG/nKJuxr6JCNPdO1jfcIe760UBxD5TWKQfPc2LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfQ3eKmPFVrtoiZXs7BauoAQIARyVuYHO1OR1cnl9j0qW7qC6QPLv01/A8WIT3U61
	 vwa1PWrDCtoAoCfvOV6pve4JcM+hFPkXHj2lQOKRXaFh9aC3NPIvIzphVnKhoms2t8
	 91ToI0R2/MarGy4JvCSgPwFw5kH7W6kgvU+156LFxZ3p+MfZiOkoHCcnQRDqKCHg6m
	 9tqqVuWsbqIImLgu/xck2r6/nlPHXK62cUxYvckyf4Nk5tHyAAKmMq3OQk6exHvhmJ
	 ASMxgzfJmbQaDJvVEDS56ml1xVKWJHzpqzRAuamFhdfTuw7mGHU9BQVcXWPS6DdvfH
	 GTKzR2ntOWuIg==
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
Subject: [PATCH net-next v2 3/9] netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
Date: Tue, 15 Sep 2026 09:13:35 -0700
Message-ID: <20260915161341.1053476-4-kuba@kernel.org>
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

The "# TODO: fill in the attributes in between" gap before selftests
(176) hides exactly one attribute, DEVLINK_ATTR_NESTED_DEVLINK (175).
devlink_nl_fill() calls devlink_nl_nested_fill() unconditionally, which
emits one of these per entry in devlink->nested_rels (mlx5, ice).

Unlike the other TODO gaps this is a single attribute of an already
modelled type, so just fill it in.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
---
 Documentation/netlink/specs/devlink.yaml | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 0e0791d4e2c7..7ec52f81c323 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -858,13 +858,14 @@ doc: Partial family for Devlink.
         name: linecard-supported-types
         type: nest
         nested-attributes: dl-linecard-supported-types
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: nested-devlink
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-nested-devlink
       -
         name: selftests
         type: nest
-        value: 176
         nested-attributes: dl-selftest-id
       -
         name: rate-tx-priority
@@ -1351,6 +1352,19 @@ doc: Partial family for Devlink.
       -
         name: index
 
+  -
+    name: dl-nested-devlink
+    subset-of: devlink
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
+      -
+        name: index
+      -
+        name: netns-id
+
 operations:
   enum-model: directional
   list:
@@ -1376,6 +1390,7 @@ doc: Partial family for Devlink.
             - index
             - reload-failed
             - dev-stats
+            - nested-devlink
       dump:
         reply: *get-reply
 
-- 
2.55.0


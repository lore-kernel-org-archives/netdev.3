Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594C599A39
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070605; cv=none; b=m14IOQg4HcQekefXkidQ8xip37KEnGaWdqV3mD63Hyl+8xCZiiK8z925HdCsFAONMfX4piJovwsfxRHyuwGIhef61L5XSfWIAS8gaam7I++tnwR4BgxDx7Ndn7haO8fOrC2gRYAtsqp2Fi8R0NU9yeOmNCinY+GgwwPo6fowfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070605; c=relaxed/simple;
	bh=FrwR64hfOtZ8LRmynpak3XiTDysVtvkkqWr7MW8wls8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGDQMCBsrAYhzSWiTiqkP2hRn8yOm/gYr1D2qRCWI6/rSFS5adjCYTMpmjwBXsQe5aF4KyeaXRYqFlHEnLDES7NqZ3yN4lvlCTb7OGESZ28atHVdEXfAhmKP1FflxaYxPZAXp8dRSzYmSNKz9fSSVs9JnIlwh7vta3O1DzAUBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRJnt+fp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRJnt+fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74ED1F0089A;
	Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070604;
	bh=/sGnEaI0YHN7ilUvcEfM6C0C7oOJ4/OHpm+2jY5+Wx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRJnt+fpW3QkAhwL3tp4XochSBfCtS6OVkrz3tx8bWJLpl2SNLriZ0UtxfUuv1fBj
	 S74T6tNjy/vyG5FGsXAKielIDSFY19YLCvTIP72h/UBL/9RZf+XGk3jmnKPrMF5DFI
	 FYhV41Yw28HG2LO763r7zyvRVsk708H95c02ptWtM8ab/EK2ZYMJ9Ua8yrb7y97Gpm
	 ZenLZgyGaXZL7P1WrQddz5pBd/iVSIaoYOLcRGNWHZoFrxJOGwcYM2/c0hO/4WCsig
	 q9M2SVR7b7rRd/fwC4yijU0eJ6OGjrirJPqgp8oI7JkNXz59b+HAx/nxzUOc7UQFSC
	 TpQG07mS/2Eug==
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
Subject: [PATCH net-next 7/8] netlink: specs: devlink: describe the netns id in the parent-dev nest
Date: Thu, 10 Sep 2026 13:03:11 -0700
Message-ID: <20260910200312.2665792-8-kuba@kernel.org>
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

devlink_nl_rate_parent_fill() emits DEVLINK_ATTR_PARENT_DEV via
devlink_nl_put_nested_handle(), which adds DEVLINK_ATTR_NETNS_ID
whenever the parent rate node lives on a devlink instance in another
netns. Now that we defined dl-nested-devlink subset, which unlike
dl-parent-dev includes netns-id, let's switch to it. The rate APIs
input genuinely does not accept the netns-id, so we need to subset
them to stick with dl-parent-dev.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 39 ++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 9d816a0b7da4..54de1eeb2234 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -912,7 +912,7 @@ doc: Partial family for Devlink.
       -
         name: parent-dev
         type: nest
-        nested-attributes: dl-parent-dev
+        nested-attributes: dl-nested-devlink
         doc: |
           Identifies the devlink instance which owns the parent rate node.
           Used with rate-set and rate-new to parent a rate object to a node on
@@ -1390,6 +1390,10 @@ doc: Partial family for Devlink.
   -
     name: dl-parent-dev
     subset-of: devlink
+    doc: |
+      Devlink handle accepted as the parent-dev input; the netns id the
+      kernel reports back is not accepted, the parent is always resolved
+      in the caller's netns.
     attributes:
       -
         name: bus-name
@@ -1398,6 +1402,35 @@ doc: Partial family for Devlink.
       -
         name: index
 
+  -
+    name: dl-rate-set
+    subset-of: devlink
+    doc: Attributes accepted by the rate-set and rate-new requests.
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
+      -
+        name: index
+      -
+        name: rate-node-name
+      -
+        name: rate-tx-share
+      -
+        name: rate-tx-max
+      -
+        name: rate-tx-priority
+      -
+        name: rate-tx-weight
+      -
+        name: rate-parent-node-name
+      -
+        name: rate-tc-bws
+      -
+        name: parent-dev
+        nested-attributes: dl-parent-dev
+
   -
     name: dl-nested-devlink
     subset-of: devlink
@@ -2379,7 +2412,7 @@ doc: Partial family for Devlink.
     -
       name: rate-set
       doc: Set rate instances.
-      attribute-set: devlink
+      attribute-set: dl-rate-set
       dont-validate: [strict]
       flags: [admin-perm]
       do:
@@ -2402,7 +2435,7 @@ doc: Partial family for Devlink.
     -
       name: rate-new
       doc: Create rate instances.
-      attribute-set: devlink
+      attribute-set: dl-rate-set
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54828420898
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488836; cv=none; b=hX0Pkf39IgsxxFLYEQwfQtEndHFh7c8rAmZ/SUOSPj1nwhmVpN48+ZC1jljhmx7XxqQqfAg0k1ip66gUfyYxPYENQrZdjQ3vKFB3x22ZKuGVONPft/zcRXjmONHXcwi5axRZ+AGdK4LNh3wkwDr2A+YR25dUyEVoWMgHdgGxLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488836; c=relaxed/simple;
	bh=PXoPUWuNlQLeDqLvFH+yHHDsXFxTPs8G9bPTceX+FL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFr8p9oP1Ty4IeB405DU9hVRfhVkDLUe95RwLr9pR6iDv/TtNkOMbuLZ0Nqofr3RHWOn8FWZFRJx337PCb0bRQiCJhWI+kjdYxXt+EDMwskcTTQDlDDXprBfhUgYFYs4RU6yyJC2pO/ZQbQUEY1pV0cpy6q1nMc6QQ/Es49O1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQjA0M7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQjA0M7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C21F0089D;
	Tue, 15 Sep 2026 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488833;
	bh=jBYf0bJzKqB2OLaqb6OTeWVSnJZdl7g8iQM3e46ZsGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQjA0M7q6XimbBJICJbpzusGwIkqVg1Gls/h4CTsHLY0QWubxsuYc9EEU5BP6JTte
	 ZS9R5dNjdCpS3pIMOBsI4lkJKhjGlCCXRch05zA956dhxfwqwpjdzKnvVIO7+J+4Zj
	 Frqbi+nuPSGZCIULK7cqu+103whRhd2c+FwSSvl69HQ3muu5CQsNX4dSld3dRiqLnn
	 8Bm14vRb/Dgyp4rv84gyDC9Rvt6AFRrjz35oDminkkfeMjjqGM8eVlX0FJszyYwQUM
	 4MifPOlrXh64kzyYgjISsI7FjE4tXkkeDw1HAiQv5B3gTOHQUe5Nxkoj+kRQPAkV4P
	 vev2mnXoM2nhg==
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
Subject: [PATCH net-next v2 7/9] netlink: specs: devlink: describe the netns id in the parent-dev nest
Date: Tue, 15 Sep 2026 09:13:39 -0700
Message-ID: <20260915161341.1053476-8-kuba@kernel.org>
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

devlink_nl_rate_parent_fill() emits DEVLINK_ATTR_PARENT_DEV via
devlink_nl_put_nested_handle(), which adds DEVLINK_ATTR_NETNS_ID
whenever the parent rate node lives on a devlink instance in another
netns. Now that we defined dl-nested-devlink subset, which unlike
dl-parent-dev includes netns-id, let's switch to it. The rate APIs
input genuinely does not accept the netns-id, so we need to subset
them to stick with dl-parent-dev.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: include port-index in the subset attr list
---
 Documentation/netlink/specs/devlink.yaml | 41 ++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 5c9c672497d4..5535247faf14 100644
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
@@ -1398,6 +1402,37 @@ doc: Partial family for Devlink.
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
+        name: port-index
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
@@ -2387,7 +2422,7 @@ doc: Partial family for Devlink.
     -
       name: rate-set
       doc: Set rate instances.
-      attribute-set: devlink
+      attribute-set: dl-rate-set
       dont-validate: [strict]
       flags: [admin-perm]
       do:
@@ -2410,7 +2445,7 @@ doc: Partial family for Devlink.
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


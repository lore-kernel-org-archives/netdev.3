Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB7545DAC
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070603; cv=none; b=CtkxwwWMHd6n2z6pjDNqPNHVBTddWF30m4bTvHIPkAY7SUwst0xHKnqG1fDEyujhVf0CHsXLNicM9FcwvuTZXmf4VBYiTlrjb9Ovm0qp7iXQKfvxOOtfU5JiCHcxvcr7bMR6hwN+Y3FxJhTK8qchs3Ux71XCU9uq6vHQJagdYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070603; c=relaxed/simple;
	bh=nSM4JEtwMy0XlSCwN5nbQSmNShmWwaAGsqEyPFZnno8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kShePjt2irAsfjTxdaBp5RLH9SlYJT5ber4kOJkSO8HfRhf/iRe0dCRgTVv0JGqN4S/q/l5tDr/66vyOAP0n8bbYywSME9PvDDpQHHrh2f6DxnDTPtHJaOnyOiT8AxHAHkUe2trUBq7jOhcn7NoxIDc565TSn/snDSmM+MGch8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWsdMzrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWsdMzrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15441F00899;
	Thu, 10 Sep 2026 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070602;
	bh=4SRc/BcUYhKtTStd+FJEAvnJx0WdtWJ2s7wdEZSM4Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NWsdMzrSubO/RiZtJwa9g+OjXIEFy+ogDQPtxgzicR6PJpDU0+G6+MEdE77BK8OPO
	 ZTnMXTiwMU90iYCbgAVgY4/idnBTsRv0zVFeUzRr8KidruA+7QgT6KZZ80GwTMx9L1
	 tIeXIE6FcwHkHEeiL7dUaO/RiSUJ7TOZO5GFjyumNAfJmaGZBZoV1xb6gq/msQA+e0
	 Qm1+EvIrdgX1vbJWs4AdPnlyxufwuxf7lILUWHyTlowknGXIUni6BSgGGq/FhTPR9A
	 +4BP51sHdf1pQisvVKf5cbeK4D3ho3o8gPeOzgr49sagoxDf06xLGx4gOufotFuSb3
	 Z/Y8P5AlNa0JQ==
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
Subject: [PATCH net-next 3/8] netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
Date: Thu, 10 Sep 2026 13:03:07 -0700
Message-ID: <20260910200312.2665792-4-kuba@kernel.org>
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

The "# TODO: fill in the attributes in between" gap before selftests
(176) hides exactly one attribute, DEVLINK_ATTR_NESTED_DEVLINK (175).
devlink_nl_fill() calls devlink_nl_nested_fill() unconditionally, which
emits one of these per entry in devlink->nested_rels (mlx5, ice).

Unlike the other TODO gaps this is a single attribute of an already
modelled type, so just fill it in.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015259E33F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070606; cv=none; b=UIh7guA1v8j2c385ivzCQ++31LFeVld+EpVUgO5hpHX6MU1iHejpO4w3AuLRV9A3eO5BNwz7Xp2mO28VClbJrj3BnJWesmBOccdIyxuAaG6tpFcRrLHlW2pETmGMqPUsh78el2tfUxxi1ozCJeCvxggsBWsec09H7d21CQzTqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070606; c=relaxed/simple;
	bh=ChUoPAwVOe9GpYAv2RXB4FEw+78JfqkCYZxsxo30rXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J52wHGL4SWoQp9oIlueoDtumr3HK/CiRu2KMAryNrx/4GaAAYBn1S42CFlxWzl4DkRrk4tefJRLCoRfIh1cBgttPnB9ozjzuIQ7B1JRBJ9kOt6WipJjqo188nz5838gFx7K057Ivf/paVc0UKYuuyuciOM0tbntJYX/63H2Y8V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6pHVjSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6pHVjSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B4D1F000FF;
	Thu, 10 Sep 2026 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070604;
	bh=34aCThUdcI0Xgr9g3nNlhLlfdyIAOyY1i4SuV4nGgbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6pHVjSMHeQQGYerK9sh/vNwzoIi3cncIPeeuGsPFxZ8xGg4ZyG96TcUnk9cylB/W
	 b05aW++HRhJnJGwxTV6Z4ZgkkA/BaCZjiYppVTV5vydLCMgD7dmfY0cxxtseu62oUY
	 HBXY0JC6UkUdPmVHBWcrgQHPBmBH6b11MR9VQxqylt6nGp1AwCs6dar16PcCS3olji
	 wxb3WbMK/++8sgm2d93ZC2tbS+VfxXoxDha2oAaQrRk1YSVWkhBRpN2xdxmhpB5yop
	 OKKNadpNB+PWYestpXfylq0n4TGytxBhp9nuaLKXlWZ3Tsu+PGEugfi2k3m3CfeUS5
	 YXuBhaSG/ATLg==
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
Subject: [PATCH net-next 8/8] netlink: specs: devlink: add pad to the subsets carrying padded u64s
Date: Thu, 10 Sep 2026 13:03:12 -0700
Message-ID: <20260910200312.2665792-9-kuba@kernel.org>
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

We are missing the pad attribute in a number of subsets.
Worse, dl-attr-stats which is a separate attr space doesn't
define pad, but reuses the value from the root attr set
(DEVLINK_ATTR_PAD). This would break parsing stats on
an arch without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/devlink.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 54de1eeb2234..acb22856a6a8 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1065,6 +1065,8 @@ doc: Partial family for Devlink.
         name: dpipe-table-resource-id
       -
         name: dpipe-table-resource-units
+      -
+        name: pad
 
   -
     name: dl-dpipe-table-matches
@@ -1099,6 +1101,8 @@ doc: Partial family for Devlink.
         name: dpipe-entry-action-values
       -
         name: dpipe-entry-counter
+      -
+        name: pad
 
   -
     name: dl-dpipe-entry-match-values
@@ -1237,6 +1241,8 @@ doc: Partial family for Devlink.
         name: resource-unit
       -
         name: resource-occ
+      -
+        name: pad
 
   -
     name: dl-resource-list
@@ -1289,6 +1295,8 @@ doc: Partial family for Devlink.
         name: region-chunk-data
       -
         name: region-chunk-addr
+      -
+        name: pad
 
   -
     name: dl-fmsg
@@ -1329,6 +1337,8 @@ doc: Partial family for Devlink.
         name: health-reporter-auto-dump
       -
         name: health-reporter-burst-period
+      -
+        name: pad
 
   -
     name: dl-attr-stats
@@ -1343,6 +1353,10 @@ doc: Partial family for Devlink.
       -
         name: stats-rx-dropped
         type: u64
+      -
+        name: pad
+        type: pad
+        value: 61
 
   -
     name: dl-trap-metadata
-- 
2.55.0


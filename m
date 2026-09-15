Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC514252BC
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488836; cv=none; b=KdlKlvLXgkZeYf9T//t2Qfe3e+THRJEQmXCvrdGFf5QrwJ6clFCxH/mcj0I9jlHkqRPFyFJN4bcTbi364spqIXr0naXsdKm7UTrBGnVsG1q1Sm5EKxH2YbahYhTPU7Z+GTR7+H+PUBAoC3iOswIrhMUP9FItcx0skwrGsi35Ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488836; c=relaxed/simple;
	bh=lezp946AQjhem9x0n4hzd8kIAl9BwMLnH7qrqWcoItI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRqdIxycJrgKJ4vgn3zEpVOfyVtJGPfVnrM7dACQOQmQr1xhU7nxi52P8+3iJ+ejVEcng6tjuragh4t5UYdGhJxN8ogO5YCNGuyK/VsNrYxVuPHqjWgVXd5LoUi2Wlt5reCHQn46qAgG2GPNTQ/yY6ZA7YQ9hvHBhl0ikCStj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC3UF0hL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC3UF0hL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E990C1F0089E;
	Tue, 15 Sep 2026 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488834;
	bh=mrHgsU5Hge76HT99B4mqf/7+QlgpBVfUYfRPDAZ2DQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kC3UF0hLBUqYIluYegrg4+YzEXM3vbcmb5xytDJWs6/a8GTL1/yU2q0wdS9UStNpf
	 h1Sn91wFovM8xlI+KPsvEYwaWB+Mod53YB5Ukol3ZZ+4LceRWpgFvxGSCZBipjThVs
	 WscNZ+1l9xYvMJ8LDDuBm3Q2b9RsoORM0YjqZ6YGK084ezJVn9cywCrh/4WXAjapyl
	 EwEX8lOYVSjnn0LbXvwf2LOKFVgx7MCd7L73/gmuFPfd5T6lbiXBaNHwaxeAj9rSlC
	 RqM8yGRUzVpHwgB1bV71EKUPJLOl3n9HBbYLWcNxE845rpjzpR67J0OKlTxxnZeHpF
	 balTZjUHAvOwg==
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
Subject: [PATCH net-next v2 8/9] netlink: specs: devlink: add pad to the subsets carrying padded u64s
Date: Tue, 15 Sep 2026 09:13:40 -0700
Message-ID: <20260915161341.1053476-9-kuba@kernel.org>
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

We are missing the pad attribute in a number of subsets.
Worse, dl-attr-stats which is a separate attr space doesn't
define pad, but reuses the value from the root attr set
(DEVLINK_ATTR_PAD). This would break parsing stats on
an arch without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
---
 Documentation/netlink/specs/devlink.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 5535247faf14..4fb64e71063d 100644
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


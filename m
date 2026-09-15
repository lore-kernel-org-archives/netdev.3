Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E440F756
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488835; cv=none; b=LM/ZWmYGkvPh/LpJd4nCOIQrxcTFTQ7TJQPDn7QGRx9HKGrbf3MFtaIFoirOsp0CW+kbfLWGWlY07cxrCdB02FCctw8Gb/630nv1r/LsUYu9g7f5AF+1bbJw+ULjDEpeoWVDIjCWgomZKpVC+lPjTgCq64EYI3U/QlYXJkSNdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488835; c=relaxed/simple;
	bh=tYobmxG1wdOIkukFwyKh1Q3Ztc8pRbhdhPPn6V6s50Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQMbXndxDBCqGe/Mohs0fe/pV8wn+taa4lNhdssjbQHmPJS84EB5Iy/ozYj8gB7VJbIXSqm0v7mcnAk38uovgKob8yfNQtFdYibSBqETKkOn2rVECK4eCpFF3rfkfPGv20RfVkIRy/szyfMpiMLYs5hQM/FD5aR4Etijz3gT9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWgBr61O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWgBr61O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A191F00893;
	Tue, 15 Sep 2026 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488833;
	bh=bakFrkzRaeIwunTJCCD8QkkkqQ6mmXffECo62dNNyVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWgBr61O3oZBH3qalWIUryDEcZVsYHKdU5L2Wx8qnlO6uTIBNkw/mrUblZ0Il5yBX
	 rPm3lvPCE9kWw/43zaXCrrsPemqhhhU3nlLQDFraS7Z3JJxRvjeSDLzAD/YhFmt20T
	 EpCDplu3YdXF5F2/UpgBx0bKMb6rwCTClneDKSb/bp2LN/2QOOaBP4shI09+5vnrm+
	 H4Udv+EnSzfOT3nitvTjo5lnfJXRWqPyKL4QjP/2VhcQSWMVASzwOtkCnAvTAnKDql
	 knU8QnDBQKjDURR8rfQqaAP3cAK67a2G7xNuy6W9vnVCMXJioO4HbeDCaCOlARpbxR
	 t1DFYqGGtQrGQ==
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
Subject: [PATCH net-next v2 6/9] netlink: specs: devlink: populate multi-attr attrs for region read and line card
Date: Tue, 15 Sep 2026 09:13:38 -0700
Message-ID: <20260915161341.1053476-7-kuba@kernel.org>
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

Three attributes are emitted repeatedly inside their nest:

 - devlink_nl_region_read_fill() calls
   devlink_nl_cmd_region_read_chunk_fill() once per 256 byte unit
 - devlink_nl_region_snapshots_id_put() emits one
   DEVLINK_ATTR_REGION_SNAPSHOT sub-nest per entry on the region's
   snapshot list
 - devlink_nl_linecard_fill() emits one DEVLINK_ATTR_LINECARD_TYPE per
   linecard->types_count entry

In all three cases we're missing the multi-attr properties, and the
attributes themselves are missing from the attr list used by C code gen.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: also update the attr list in the spec for region get
---
 Documentation/netlink/specs/devlink.yaml | 28 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index f23466fb27f9..5c9c672497d4 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1264,6 +1264,7 @@ doc: Partial family for Devlink.
     attributes:
       -
         name: region-snapshot
+        multi-attr: true
 
   -
     name: dl-region-snapshot
@@ -1278,6 +1279,7 @@ doc: Partial family for Devlink.
     attributes:
       -
         name: region-chunk
+        multi-attr: true
 
   -
     name: dl-region-chunk
@@ -1360,6 +1362,7 @@ doc: Partial family for Devlink.
     attributes:
       -
         name: linecard-type
+        multi-attr: true
 
   -
     name: dl-selftest-id
@@ -1971,7 +1974,7 @@ doc: Partial family for Devlink.
         post: devlink-nl-post-doit
         request:
           value: 42
-          attributes: &region-id-attrs
+          attributes:
             - bus-name
             - dev-name
             - index
@@ -1979,7 +1982,15 @@ doc: Partial family for Devlink.
             - region-name
         reply: &region-get-reply
           value: 42
-          attributes: *region-id-attrs
+          attributes:
+            - bus-name
+            - dev-name
+            - index
+            - port-index
+            - region-name
+            - region-size
+            - region-max-snapshots
+            - region-snapshots
       dump:
         request:
           attributes: *dev-id-attrs
@@ -2045,6 +2056,7 @@ doc: Partial family for Devlink.
             - index
             - port-index
             - region-name
+            - region-chunks
 
     -
       name: port-param-get
@@ -2444,14 +2456,22 @@ doc: Partial family for Devlink.
         post: devlink-nl-post-doit
         request:
           value: 78
-          attributes: &linecard-id-attrs
+          attributes:
             - bus-name
             - dev-name
             - index
             - linecard-index
         reply: &linecard-get-reply
           value: 80
-          attributes: *linecard-id-attrs
+          attributes:
+            - bus-name
+            - dev-name
+            - index
+            - linecard-index
+            - linecard-state
+            - linecard-type
+            - linecard-supported-types
+            - nested-devlink
       dump:
         request:
           attributes: *dev-id-attrs
-- 
2.55.0


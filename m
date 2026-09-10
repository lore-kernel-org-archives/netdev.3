Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17C5964FC
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070605; cv=none; b=axgPh/hREvKoe76J7CL1uKs709FtS46z+Yc0F9SVSzVyFvV5l0zzlOMgNWf9d6V42Sf16/9tIqejcvAbiPOZNbHZqM0RJDFmJvZxchG8YDc1RWCo6eznhmJ1CRoAagoZrfwolpVPmwFjslReeOP2NGS/BUdySfIigqPrNF1JjmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070605; c=relaxed/simple;
	bh=C3usgVlI2jNU17s8p1gFGIs/Z/sOawNbHTzpUbeK7+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2QqojXFILksj9IvV812EQq9KWNegORL94Vo+tzoDYdmcNFZ5hcul8DlcByZFxTA3tZbi/J8o8RWwAXOFxFarBfhWPBhf13+cNnuvHJ/aAZ6vPvYOA9XIBl3bBIxeb6hsd8NDEQ5uUQhe5FOhZ83SjgPuEV7sW0m1rfzWj/ryS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWbMxqTH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWbMxqTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C091F00893;
	Thu, 10 Sep 2026 20:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070603;
	bh=BsHd++9RMpjVDCRQ8d9822EnZKoTTqkxG9ArsyfrC0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HWbMxqTHzOCsHg/YvKp6NV78wyBuB0VUJ4M1YFnYSkJXQ/VMkOQ/QiL0oS5N2+FpX
	 PpHfTPJADoreoZZXEe3Pe8B5ljg2ohP+7QxoaY6PtBRi+sgOr1n0X1QYv5U4lCb4mA
	 MwxKpHXLr8a+3cLQQHjp9cjcPgdMUW0DOV0BYzQ8F8ShCpP1II2TXad5EC1iEsRcUc
	 KsjQUUNdXfH4+DEcuoCtuqa/QM1Z5AR5mWozlnnahBM1Rs9iRj/yFCNWn2tOJ8FtA5
	 4C48dSw7B34ISEd4IQfjgRKwnWPHtgC/m786QjepCiAjBFeu6NTfAf865pOkPWrhv9
	 hATq8jPexbEMw==
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
Subject: [PATCH net-next 6/8] netlink: specs: devlink: populate multi-attr attrs for region read and line card
Date: Thu, 10 Sep 2026 13:03:10 -0700
Message-ID: <20260910200312.2665792-7-kuba@kernel.org>
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
 Documentation/netlink/specs/devlink.yaml | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index f23466fb27f9..9d816a0b7da4 100644
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
@@ -2045,6 +2048,7 @@ doc: Partial family for Devlink.
             - index
             - port-index
             - region-name
+            - region-chunks
 
     -
       name: port-param-get
@@ -2444,14 +2448,22 @@ doc: Partial family for Devlink.
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


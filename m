Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5D3AE6E9;
	Tue, 26 May 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811333; cv=none; b=lggwRjxVA83aAJ714bZow9F153Xsso7HHBJnyec/ppgs8CjRHNVyAclhj+n+nLKaKocuL6L3IpaleuCiZnnThyODKbOPk6KZ1c1IrpCoHm+rrtLbZYlNl3jqXnzcGoTtwxw3P97O+5eHFNJ0vRYrELG8Ax22MMaER5R4cHjWIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811333; c=relaxed/simple;
	bh=YQPSNgU+71Te1YxKqrqlXJjJT4/0JscaUKGNsvsT6eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYIAKC7opscJWCnaIKUx8qUAULQ+g+FRe7Ydel2L8bPcu3hFGIsKjHpEO83HDKvuRhGXKZ+caZ3FZmbQUq84nOerquYqhujXSowxaUruUj9DUvJ/9ELjP9tHhZmZT55/0ftofq/tSDkNE1k6MHuc8hO55ATIV/rVfi6OMKLRNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d64m0iwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d64m0iwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD00F1F00A3E;
	Tue, 26 May 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811332;
	bh=+ciTda9JPKyJSdZUoLUl6m4Ql8P2BNxw9mPnBa35ydI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d64m0iwxfsNScDASIvZukmROUhrgSzY9WEyHmk8F5fH6D96TmCI+zi4/xtP9gTg55
	 tf1FKJi0ofIbiNqlMcC49yP9ew9d7ekGh6L+QvVBG5txgKKyBy3U5J0NzXc3dKNGz8
	 jdd3GXuysEFDuOkbl2YV13YaoG4i0LPVmRJnS5vvkIMrDVagYg82VON6iNq7KuMxId
	 5RIgiFtQdhq7dRd7Lc2om8oWZ6nHZglbWu6kKgiX+h0iJTDwUnwCBdJmquj9DpJpIK
	 4Bm+ZRmVxVpJ5j789VfJoUicmFpaZUaspD1dYA3pwbGdnEF4x+Me6tF1prZZD0ZHbH
	 rRbjnO8GlTxZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/10] docs: net: render the checksum comment in checksum-offloads.rst
Date: Tue, 26 May 2026 09:01:50 -0700
Message-ID: <20260526160151.2793354-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checksum-offloads.rst seems like a better place to render
the checksum comment than skbuff.rst.

Remove the stale references to sections in that comment
(it no longer has A, B, C, D, E sections).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/checksum-offloads.rst | 18 ++++++++++--------
 Documentation/networking/skbuff.rst            |  6 ------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/checksum-offloads.rst b/Documentation/networking/checksum-offloads.rst
index d838fe5c1606..d4ded890011b 100644
--- a/Documentation/networking/checksum-offloads.rst
+++ b/Documentation/networking/checksum-offloads.rst
@@ -25,10 +25,8 @@ take advantage of checksum offload capabilities of various NICs.
 TX Checksum Offload
 ===================
 
-The interface for offloading a transmit checksum to a device is explained in
-detail in comments near the top of include/linux/skbuff.h.
-
-In brief, it allows to request the device fill in a single ones-complement
+In brief, Tx checksum offload allows to request the device fill in a single
+ones-complement
 checksum defined by the sk_buff fields skb->csum_start and skb->csum_offset.
 The device should compute the 16-bit ones-complement checksum (i.e. the
 'IP-style' checksum) from csum_start to the end of the packet, and fill in the
@@ -47,8 +45,7 @@ mechanism such as LCO or RCO.
 SCTP CRC32c can also be offloaded using this interface, by means of filling
 skb->csum_start and skb->csum_offset as described above, setting
 skb->csum_not_inet, and advertising NETIF_F_SCTP_CRC. Drivers must not treat
-ordinary IP checksum offload as SCTP CRC32c support. See the skbuff.h comment
-(section 'D') for more details.
+ordinary IP checksum offload as SCTP CRC32c support.
 
 No offloading of the IP header checksum is performed; it is always done in
 software.  This is OK because when we build the IP header, we obviously have it
@@ -56,8 +53,7 @@ in cache, so summing it isn't expensive.  It's also rather short.
 
 The requirements for GSO are more complicated, because when segmenting an
 encapsulated packet both the inner and outer checksums may need to be edited or
-recomputed for each resulting segment.  See the skbuff.h comment (section 'E')
-for more details.
+recomputed for each resulting segment.
 
 A driver declares its offload capabilities in netdev->hw_features; see
 Documentation/networking/netdev-features.rst for more. NETIF_F_IP_CSUM and
@@ -154,3 +150,9 @@ or left at ``CHECKSUM_NONE``. Drivers **must not discard** packets with
 bad TCP/UDP checksum and must not configure the device to drop them.
 Checksum validation is relatively inexpensive and having bad packets reflected
 in SNMP counters is crucial for network monitoring.
+
+skb checksum documentation
+==========================
+
+.. kernel-doc:: include/linux/skbuff.h
+   :doc: skb checksums
diff --git a/Documentation/networking/skbuff.rst b/Documentation/networking/skbuff.rst
index 5b74275a73a3..94681523e345 100644
--- a/Documentation/networking/skbuff.rst
+++ b/Documentation/networking/skbuff.rst
@@ -29,9 +29,3 @@ dataref and headerless skbs
 
 .. kernel-doc:: include/linux/skbuff.h
    :doc: dataref and headerless skbs
-
-Checksum information
---------------------
-
-.. kernel-doc:: include/linux/skbuff.h
-   :doc: skb checksums
-- 
2.54.0


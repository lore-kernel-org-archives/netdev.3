Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C133C8705
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653946; cv=none; b=J530CgtnUXvgCHHfVvdETZ9KID3c2027LVH7k+iJX6AEzELH7cUgEoXtQabv454B4Rhor3AJqI3V+bRk7HEo8IVdap3CGS9vCKLLjl4MJsucVSxr2bnF5N0ZfAli0D9/mWKd1bgViy1i2Sbyithhh3J39KXYwU4k6+mzhLxBW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653946; c=relaxed/simple;
	bh=BWYev73HaJSnzrEAnlgrwJYbkkFT02+lBiRDnD08l2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx1kS/KiETfkGLaNHb0NgI6GUegYC5XYTytYbuBa2c/UsrucAAzLUlHMfe2WrM6oyLQS4pRiX7unjwNGFV2uJHJxGkf5jHT0yOCzTvfK057P8MthGuMtP22OaQk2YvxPwT3+ByJCmRelDcPdmFmS7LpETRkQogj/Avf1uvVZK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzrdjmEx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzrdjmEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653945; x=1807189945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWYev73HaJSnzrEAnlgrwJYbkkFT02+lBiRDnD08l2M=;
  b=YzrdjmExP+7QwpMcjQRUyzJ3u9mHQzobrCIGAcHUoYzbAU+45mN3JZs3
   XCKyIx/GdkDOkf78I80vbyCMkgPeJ+2VJWWl7bMmgzsReltQEfa5kkMhS
   IXMcjs2YD5sXRsQokvJOyBElFCwm35GoyP5aLeqL2p4ECsmlRrepw4sum
   pdQDJ0hwkpbPcqyGe3qIkHZCxCqnDy7y3fba5Dfba4GZOhIkmFeN5UvSr
   riZlYYCAEbYO2z0TfwcHm+0U6ZA+yPyqn1B/ImTR5kTw4n0XcCYlDktHr
   YofOMCnV3exBn3+G6QKOnlcp9SHnE4uAfDCHOlF4TifkIfOkgdzUY1voN
   A==;
X-CSE-ConnectionGUID: ZteQ7qN5S2a7ZzzKnZ4flg==
X-CSE-MsgGUID: N+xBCv/mT7yh/N/WllSujA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087270"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087270"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:24 -0700
X-CSE-ConnectionGUID: NJ9yPvteQTKjL6xVMcgY+A==
X-CSE-MsgGUID: 5POLM2duRceF21fFxT21nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228715090"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:24 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 4/8] ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant
Date: Wed,  8 Apr 2026 15:12:12 +0200
Message-ID: <20260408131216.2662245-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexander.h.duyck@intel.com>

ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.

Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
0x7F to name this mask explicitly and replace the open-coded AND-NOT
operation with the cleaner AND form.  The two expressions are
arithmetically identical; the change improves readability.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Split from monolithic ITR cleanup; this patch only adds the
   IXGBE_ITR_ADAPTIVE_MASK_USECS constant and updates ixgbe_set_itr().

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index b3f4d21..c704cc6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -475,6 +475,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 #define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d7c5e83..1885fe8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2960,7 +2960,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0

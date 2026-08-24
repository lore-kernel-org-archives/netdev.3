Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54241D620
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577773; cv=none; b=SjLSMe3d6ivhR2eGSuHnDJ/WT3L2AFcXV9bPA71nCT9SOt4YXXjU2hbWM/3fFqRUjceyG2SY6I6LL8IU7D5aYOBNiSHqTFjxkcj6dd6q76auP/ohUDpT/RtZckbkExv9T7atVV125RtnRigJNZYurQcO5NmIydgw3nr78NfL8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577773; c=relaxed/simple;
	bh=4iwRKxSimrc6YusEY2wkNKpRDAOO+LqtPIbldkpRD9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYCXHuMz3Z0caXaZz7tpU0saL5nH78Wd42O4+xx5pl4dHUUxvEaIH0gWL+onLA4tndALqVVnhHicI9JsmM7//7PWquh5rSuELCMsbK4iWQi585OIWLK/3hFmSHz7+0HKapwVBjw9h/+YOUMeRtt3846R9XWMyVkAd1JEusMQIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i77ViLRv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i77ViLRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787577771; x=1819113771;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4iwRKxSimrc6YusEY2wkNKpRDAOO+LqtPIbldkpRD9Y=;
  b=i77ViLRva15uSM5SYPKuYjTieZGJGW4rFh1gHePWP0+q8Qe80yRc95Vi
   R1DoqTCuGl+IAiU4sD/N3lyKDRhzJjU00MXw94Ex0IMzN5ovPxyL2KFqS
   C1buOHyUIqPQO27syW36Kik+MmlPXOHSrta98JNYZl3AZMdMDoGRrfG1p
   haowVeUnusuZXuhTKfjWZN3lwd3cCN7AlqOy8Sushe6v2M5PfsljCxAMW
   Pp3zTvZeqPoqBrPzY7sSj+YhFxJ2kPOaobz/DarArW4UMeg3eHPekZMjg
   0zjg4lLYzJiZkW2fRednN0e9eR1i7adIcqdMFGKHpOOpUE5+pxJPfhbyA
   Q==;
X-CSE-ConnectionGUID: qHfVLJDLRHWvxPkWIj7oSw==
X-CSE-MsgGUID: IStRp1KaSe6RrNYToIT1hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91898135"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91898135"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 06:22:50 -0700
X-CSE-ConnectionGUID: X2TNBJc/Q4iKOZ8Nnsjp1A==
X-CSE-MsgGUID: rb4Vfjr1S1WVsplx+l9oGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="305213235"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 24 Aug 2026 06:22:50 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: fix bound parser hash offset before reading packet data
Date: Mon, 24 Aug 2026 15:22:48 +0200
Message-ID: <20260824132248.3396788-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_rt_ho_set() uses the HO register as the starting offset of an
ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
be advanced by user-controlled data reachable through
ice_parse_raw_rss_pattern() -> ice_parser_run() ->
ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
size of pkt_buf.

Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
so it stays correct if the packet buffer layout changes.

ice_parser_rt_pktbuf_set() stores the caller's raw pkt_len in
rt->pkt_len, even though it only ever copies min(ICE_PARSER_MAX_PKT_LEN,
pkt_len) bytes into rt->pkt_buf. Both ice_parse_raw_rss_pattern() and
ice_vc_fdir_parse_raw() pass a VF-supplied pkt_len of up to
VIRTCHNL_MAX_SIZE_RAW_PACKET (1024), i.e. larger than
ICE_PARSER_MAX_PKT_LEN (504). With HO now capped at 504, the
"HO >= pkt_len" loop exit in ice_parser_rt_execute() would never be
reached for such an oversized pkt_len. Store the already-clamped
length instead, so rt->pkt_len always matches what was actually copied
into rt->pkt_buf and the loop-exit check remains a valid bound
regardless of the caller-supplied pkt_len.

Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
Cc: stable@vger.kernel.org
Cc: horms@kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
- also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
  ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
  so the "HO >= pkt_len" loop-exit in ice_parser_rt_execute() can't be
  bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
  (reported in review)
- dropped Przemek's Reviewed-by since the patch changed
---
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index 3995d66..b330005 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
 
 static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
 {
+	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
+	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
 	rt->gpr[ICE_GPR_HO_IDX] = ho;
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
@@ -106,7 +108,7 @@ void ice_parser_rt_pktbuf_set(struct ice_parser_rt *rt, const u8 *pkt_buf,
 	u16 ho = rt->gpr[ICE_GPR_HO_IDX];
 
 	memcpy(rt->pkt_buf, pkt_buf, len);
-	rt->pkt_len = pkt_len;
+	rt->pkt_len = len;
 
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
-- 
2.52.0


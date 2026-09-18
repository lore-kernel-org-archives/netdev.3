Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42A4F7CC1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738396; cv=none; b=RTw53wnsjbEk23kTzCmUlorSRsOf02ZinvflsXjhTsDAe7iuPgDkcow5sYDlAKTXK/YpyzaCAj6AD/hB/9aCfSvpnqznR8nKr34jpeKSzAtIo84RGXjS5NYs2A8xvIlZCb7pG4cDzbgg5G2ySrMjnzNIkij+Ek1LWoA3w0TMx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738396; c=relaxed/simple;
	bh=2E9Pez/JNLraDd7GK5S27b+3RfEH+WKJa5e0tkfg4gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VsbNg1lxXDHPBo0PuWW92bDPfxn5RgcHL/pyDZRR5tffuM9uc7C1dxGZ51LmfcAWTv3+jOjyr+e/JDzXbcC5CSu5GFIhGQ3Gegov6/drkIdt9hah2OoHqrcEeHwWbw01xK+hmhZrWI1XXfH+ITdWQlrhbcuZ+qgWg9xVepy/zE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuDoj2IJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuDoj2IJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738394; x=1821274394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2E9Pez/JNLraDd7GK5S27b+3RfEH+WKJa5e0tkfg4gc=;
  b=FuDoj2IJekcEc0glOfmcpw2sjoPT2w7ahFD6uzQURE/sq/0NhUUek4iz
   VSXAVuqO//Z0ssEUy4Yp1VPkyh+v1vh55HK873iJ13bJBKBANY03q9qA0
   240Z+aDTtht71cszqWEDoLKtL9sMShQwFpYHJwQLRiUcyB7Qs7G/cI2wS
   +pI85AOfPOxQun+bd41OuGZy8wAERIPtL3oSNWhq1jQftFnWjwmpdBlG+
   kn5SElBuU0CZTWpHfWzem3ur5k580J/k79CXw1UFMPB8KGQ2hAR/UC2k8
   4xW2PzrZ9bzpOVINfseJOBzIIRkjGrUo7HTyOUHNVZR34+AMhqvNx58Ip
   A==;
X-CSE-ConnectionGUID: 8xxtJ3ZhTCKzjwOo0R7chA==
X-CSE-MsgGUID: kLE8hdw3S0ODGu7XEswfDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101592479"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101592479"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:33:14 -0700
X-CSE-ConnectionGUID: RNK8oiaHTQSLgF5z+UutGg==
X-CSE-MsgGUID: ic1ULgAIT4iZ45/TNly+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270717889"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:12 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3] ice: fix bound parser hash offset before reading packet data
Date: Fri, 18 Sep 2026 15:33:11 +0200
Message-ID: <20260918133311.4169756-1-aleksandr.loktionov@intel.com>
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
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2:
- also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
  ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
  so the "HO >= pkt_len" loop-exit in ice_parser_rt_execute() can't be
  bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
  (reported in review)
- dropped Przemek's Reviewed-by since the patch changed
v2 -> v3: no code changes, resending to pick up Reviewed-by.
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


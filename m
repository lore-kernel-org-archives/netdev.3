Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55B3D9DA8
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789888894; cv=none; b=fLKJA6f3DtBy/Xv9GnlmLR/zUBte1Onpvs0cYEqQAk13moPGilhUhELBpFape8K742xu6qiX+T1/PfwAJJX6ezN+vUtQ8rAo7TGV7CoLYcsFMTcit7N/CXwcvhcjEM2f9yHJc3cAgYxJZa5dlCQ/CwoEoBPIbACdiAKsEmcaKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789888894; c=relaxed/simple;
	bh=RjrKH9cGLPoTmBjFTwTydWRSrGDoAmKKPR/JLk2ORh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hyva6nAtNl+G4m5pagBExNyR9/pNTaxtFd5EDaKmuuSNipkxkIXikSHtQDUizlEvtJQZGD78sa/SApd6ihIswAZtocULQBGNGFrfmDK1ggLJQBVRSStWpnKu0YHZSyJ9aEvc73VqRe4cNSPYFDq01tMPjK7DblcjW+/VKkMXEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg+0Nb33; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg+0Nb33"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso17613155ad.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789888893; x=1790493693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
        b=Hg+0Nb33Uvusr4Zgb7vNq6UBzZE+c688453PIm3XY7r+qNSEQ0A45DpbTMoOGeI8zL
         RscAr+Bea1MZyVjU8DVI48y3Irn2vxZtLlmgnwkmBegtAsbT0vr/FtnikyGwsXcWGQXj
         2aMhU7ZhgHD0heguWdGzVdbsZOVZVqpVpogQUwy8Jl91NTqqriz4mHNnNrRZTxdC9MeL
         bVjwKWubliPgdThcOs9fdQTUovCLPK2CTNgVkkgF5+VJKQCj83oS0F8dyRpcFhlYO4Yt
         adwDVmC7Rkn/wVcZ8JcLvQcyNwOGZXxom1Ngv2MPoEo/s0wvjE2tLAchbq6arfojBS79
         RLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789888893; x=1790493693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
        b=1ZAhgt08Lbm0/6dB6hNU/d4M1tGXZNJdn22Vaz+z92EgRRwTbO86Pp+d17ZDrZEqsu
         PEiQOSYPZh+iOA4Z1xLS94APFKJev8+S2RKC/efv8DSenSmzcFu6TE3rC+Ulz2YInHcl
         d/XzJfwWwezA8OhiyPcHJB+dnr+nCcSXwNcJSz9nqvMb/OIJiX+gCJVp5GuCxZISKEoa
         gl8wdG6mJ2LgN3K+Eyeqj4v9+E5UrM0Tyz9V98Ku/v8HzrK55W2yHIhvzaL91RDcpxRZ
         0cvdahE7684OtICkKdJN7lYQ9H4LVm7m5OLv4/zkRAimq8Wo8UVX2W0j5lC58+42fLjO
         XzxA==
X-Forwarded-Encrypted: i=1; AKwUvBwdr1LDiisaa8urZqS0Le/3MParClXVDGnYxnbhZX5hHYpu8dNiqoz4+85y73Rd5b+nls2woAs=@vger.kernel.org
X-Gm-Message-State: AFuF++l5AXLcPkIVTTAC2KmobeV4CnTufbZaVZpqjV6GEifHWARkUMoE
	7sT6pLSdhWlJ8osT1M3Ut95qHNFVn0Zi6Z5ZgN9uiHB84bBxf4eJnSGh
X-Gm-Gg: AYBFou2byzS1GoH7L2Gkhrn4dCtiBQ2Ozqysmuewq8g4RA3UFkKKpSLSLYbMgRe1g+Z
	yDW+ydewLkU/fS+9J3MtRfOUREruHZolUytUsWOxoTgv2HhVBYuh2iQaRZKo7rTFU/xgVq50un2
	szlaOnf8yHE97a2u0/fp8yLyWp/6bWvyhVvbSNeo5vybZuQ2XR+1ju24LWYR+giIAbAO8rpsp3b
	bMpy8mzwNRHGJBLDaCzxzR8dq8fTcryHXHV6PREWlBUNcYJVp3K1f8DoYczNfr4XvUdI15LfA/+
	Tp+P+spLtwnFR6BCKRd3MlmzM87b28U1S4OQ2FgVgp90u04t0xyV7bXeEXBcXd83WmnYDCNfO8c
	KlXnwIcMX+9Azwu1nUaAc0QJxm0sMgN8p9B5/vGTaNFqY/600i3L6ZR9Oehan5V9jWeI37msMn+
	mS0iIUpud4tM1amlhw7vxSazrVDxH+dGOyusyxN2FB3v3vlDKEQNID0HqATBdYzoAvavB3wa4p7
	EdKmnJZZF6fQ6eGYVC/sGZ/VqX6w9rYVHP9nqbFOpeAID4B9q4mergHyRC1lQ+lYMCtkVc/iPyl
	HSwOxQ==
X-Received: by 2002:a17:902:db0f:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2dd9c5e9b98mr143166245ad.0.1789888892689;
        Sun, 20 Sep 2026 00:21:32 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2de217b3a97sm16542345ad.31.2026.09.20.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:21:32 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	alexander.nowlin@intel.com,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH iwl-net v2] ice: fix empty PTYPE set for GTP RSS profiles
Date: Sun, 20 Sep 2026 07:21:14 +0000
Message-ID: <20260920072127.1278984-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Configuring RSS for GTP flows via ethtool, e.g.

  ethtool -N <if> rx-flow-hash gtpu4 sde

is accepted but has no effect: the hash of GTP-U packets does not
include the TEID, so all traffic between a given SGW/PGW pair lands on
a single Rx queue. The GTP RSS configurations the driver installs by
default at VSI init are affected the same way.

ice_flow_set_rss_seg_info() does not set IPV_OTHER on GTP segments, and
such a segment carries no L4 header bit either. ice_flow_proc_seg_hdrs()
therefore takes the "no L4" branch and ANDs the PTYPE set with
ice_ptypes_ipv4_ofos_no_l4, or ice_ptypes_ipv4_il_no_l4 for the inner
segment. Neither holds a GTP PTYPE, so ANDing with ice_ptypes_gtpu
leaves the set empty: the profile matches no packet at all and the
configured TEID field never enters the hash.

Set IPV_OTHER on GTP segments so that the tunnel-inclusive PTYPE sets
are selected instead, which do contain the GTP PTYPEs. Skip segments
that carry an L4 header bit, because the VF path strips IPV_OTHER from
those on purpose.

Verified on E810 (kernel 7.2-rc2, COMMS DDP 1.3.63.0) by reading the RSS
hash from the Rx descriptor: GTP-U traffic varying only the TEID goes
from one constant hash on a single Rx queue to 4096 distinct hashes
across all Rx queues. The same holds for inner IPv6 (gtpu6) and for a
PDU session container extension header (gtpu4e); plain UDP flows are
unaffected.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
v2:
 - Ignore IPV_OTHER in ice_get_rss_cfg() so "ethtool -n" reports the
   GTP fields again (reported by Intel validation)
 - Do not set IPV_OTHER on GTP segments that carry an L4 header bit
v1: https://lore.kernel.org/intel-wired-lan/20260714192302.631428-1-hayatake396@gmail.com/

 drivers/net/ethernet/intel/ice/ice_flow.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 121552c644cd..27de6048ebcc 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -2088,6 +2088,15 @@ ice_flow_set_rss_seg_info(struct ice_flow_seg_info *segs, u8 seg_cnt,
 
 	ICE_FLOW_SET_HDRS(seg, cfg->addl_hdrs);
 
+	/* A GTP segment without an L4 header bit would select the "no L4"
+	 * PTYPE sets, which hold no GTP PTYPE at all. VF requests that do
+	 * carry an L4 bit drop IPV_OTHER on purpose, so leave those alone.
+	 */
+	if ((seg->hdrs & (ICE_FLOW_SEG_HDR_GTPU | ICE_FLOW_SEG_HDR_GTPC |
+			  ICE_FLOW_SEG_HDR_GTPC_TEID)) &&
+	    !(seg->hdrs & ICE_FLOW_SEG_HDRS_L4_MASK_NO_OTHER))
+		seg->hdrs |= ICE_FLOW_SEG_HDR_IPV_OTHER;
+
 	/* set outer most header */
 	if (cfg->hdr_type == ICE_RSS_INNER_HEADERS_W_OUTER_IPV4)
 		segs[ICE_RSS_OUTER_HEADERS].hdrs |= ICE_FLOW_SEG_HDR_IPV4 |
@@ -3002,9 +3011,10 @@ u64 ice_get_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u32 hdrs, bool *symm)
 		return ICE_HASH_INVALID;
 
 	mutex_lock(&hw->rss_locks);
+	/* IPV_OTHER is set on GTP segments internally, ethtool never asks for it */
 	list_for_each_entry(r, &hw->rss_list_head, l_entry)
 		if (test_bit(vsi_handle, r->vsis) &&
-		    r->hash.addl_hdrs == hdrs) {
+		    (r->hash.addl_hdrs & ~ICE_FLOW_SEG_HDR_IPV_OTHER) == hdrs) {
 			rss_hash = r->hash.hash_flds;
 			*symm = r->hash.symm;
 			break;

base-commit: 1cd23ca80784223fa2204e16203f754da4e821f8
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266635;
	b=bg+ZFlJd0w0GI+ltcAQRXxVQQO0bBveCQrlOWTq3r0KWkukXp3gbEsZo0NexA8ffhCZJ
	 OKDgEMFtx3YEIiDZwuxeYxdzNFZx8m374RXWhf29/CP1xzUDNcThS3Y7bMl1wrryYG4vR
	 WEUS5ErzXk3AvVH8HDL1+9HKFuXIRFc3Av1bwUlpL1V49g/IQ3je8uJaNI9Mbsfy7Tc4G
	 eCHTU0befcZA2m550XIe4MrfBxT8iClsSDOB/H03ASO7VFfHJswEfofNH6lE71IlWw93W
	 IU5pS7xIbluoqfkIG4ESli7DdqrqYDFOUkowwuZH17AhKjEATLRBmzWuWlJaR+wosPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266635;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=M+/MPQG9slfrEp9ZM9gxqbHorKdOMhPMBQvDJPIlvQM=;
	b=EXeIXqePw4yWhHyiYzSXsGOTVWGf/+k7lcwp85kFSKxLEnBW6UurEnKef35hEPBHU7Ka
	 p8A73rXuqn6CgDKKFIMkYyB18cBIfMlie1knL6/1sjcP0loPcHVWxpVuHHwBdMBWuT50k
	 5xXZP+e7gNd/WKMsSoX/ZHipvkH+pfWeQPnK2pnd+jNGEA6zdxD7T9GhvbVhou73FjUTy
	 RlbvUp/VuZdpsA/Q+/OzPyeX7TpMcehNyXg11bl01UklgdV/xyYAMqtNIRe1ZoP6rwBDS
	 OLNCdkT7CTOrPGy2RVA9sYyn6plhbFDwrnJ7Ta9EWixJs4Zu0kTK11gl04gJjMRf3zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=a30XKua6;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B4606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 045B4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=a30XKua6
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9MNxkh2431764;
	Mon, 9 Nov 2026 15:23:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=M+/MPQG9s
	lfrEp9ZM9gxqbHorKdOMhPMBQvDJPIlvQM=; b=a30XKua6UBAVVfFmuU8ym1SPF
	qyXiIRgeMg5lYQLD7mLHCk1QgFpEh89973vARSAJXQnJH4y7bteAXPjg8RLM0fJZ
	za2ajH5u3QgVav0GwvAE6J4tEUa0sBl2Nc9mh7R5GwVp0X3A6R88Tw51gF4OD4NL
	Z0lN2E3a5MsXDPh/ZG1gQktht+KhACxZ3KSN0X3d12FixLxpFeriDklLjdhYskNV
	CedOJf3fdc0op1ba2Mq7GhYlOzo1AMHTlPbP0iZIglw2QTahPEkMypsJp9MW3yKN
	BQ9zG0Nl1QfEFx2VkXYeNfZrKGK2dR0KRrglg+8xUgctg0uFTNDx/d5SfI1qQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ht066pw9s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 09 Nov 2026 15:23:48 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Mon, 9 Nov
 2026 23:23:35 +0000
From: Riten Gupta <ritengupta@meta.com>
To: Michal Kubecek <mkubecek@suse.cz>
CC: <netdev@vger.kernel.org>, Joseph Beshay <jbeshay@meta.com>,
        "Jesse
 Brandeburg" <jbrandeb@kernel.org>
Subject: [PATCH ethtool] ethtool: Avoid undefined shifts in bitmap helpers
Date: Mon, 9 Nov 2026 15:21:44 -0800
Message-ID: <20261109232251.1105094-1-ritengupta@meta.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfXyyJvo3MKC6sg
 NRgnBMNm20OXruEiCzVPMeATkwLOecdpa3+ZeQpmF/Al3mUjo6ehQqFrJZkto7YKTgrfCKG3bz0
 QdQYrmyiFy5d9HqEM+LIRJPFH1VAaLE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX4OtQ21hR2u73
 as+yiQGwPMo+15r7q7ABic/PABxJAPykHe9d+yQ0G63O/rIo8mDvNjTBc60Mz2Q1pl526E7hhLs
 Whu3ZdPp9Os8FFPNaNkX1yrsBzN5Ggx6LfJ7CfxNPzyfJdfGRTc+wBEvYrM/0sNFSGULg5u2ATM
 Bp9KkghBBz/F6LdYHjEAkiD4gZQ6U3U/rfFRbXcAvFF0tLQTv1dDLkQyFTaIjqKuFNKwwaPZGQ4
 8lXCv8tQHxDhL7ZkQbXIe89TnLKA6KD6bQxTfObc6QY7zmG3DR+iGLX6nNg6Cmiqg6zgM+71t4A
 6KOJ4KeWdl2MfplV8bZ2U7wKaulueFmNWN0tht1x/RI5c2fIZANz1KJpn06Fw0gnFwiDCHCq4TJ
 /v36Tp7jY2HpoBt8zEn8Pi5ARoML8oV9OIDOkpdgWvMxaf5m2Sei5erb2xqgBnhp2AtJi9Zeq7m
 toZ7EjyDDMhEVktpElQ==
X-Proofpoint-GUID: UNaa5TmTlcWPJAcT8lLdRqyPjRVmX4WP
X-Authority-Analysis: v=2.4 cv=BZZNQbt2 c=1 sm=1 tr=0 ts=6af25605 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VabnemYjAAAA:8
 a=PpYU2pQG3nxUwL0tp_EA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: UNaa5TmTlcWPJAcT8lLdRqyPjRVmX4WP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01

Several helpers that test or set a bit in an array of 32-bit words build
the mask as (1 << (n % 32)). The literal 1 is a signed int, so for every
bit position congruent to 31 modulo 32 the shift is undefined behavior:
2^31 is not representable in a 32-bit int. The unsigned type of the
bitmap word does not change the type of the shift expression.

All of these are reached in normal use:

 - ethtool_link_mode_set_bit() is called by init_global_link_mode_masks()
   on startup, so with -fsanitize=undefined -fno-sanitize-recover=undefined
   every command, including "ethtool --version", aborts with

     internal.h:202:22: runtime error: left shift of 1 by 31 places
     cannot be represented in type 'int'

 - feature_on() and set_sf_req_mask() handle the netdev feature bitmaps
   for "ethtool -k" and "ethtool -K"
 - walk_bitset() handles compact bitsets, e.g. the link mode bitsets
   requested by "ethtool -a"

Use 1U, as bitset_get_bit() and the netlink/monitor.c filter helpers
already do.

Fixes: 33133abf3b77 ("ethtool.c: add support for ETHTOOL_xLINKSETTINGS ioctls")
Fixes: 490503bdbd67 ("netlink: add bitset helpers")
Fixes: f2c17e107900 ("netlink: add netlink handler for gfeatures (-k)")
Fixes: a7a05af4a1ea ("netlink: add netlink handler for sfeatures (-K)")
Suggested-by: Joseph Beshay <jbeshay@meta.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Riten Gupta <ritengupta@meta.com>
---

Notes:
    Tested on top of bae2dbd with gcc 11.5, -fsanitize=undefined
    -fno-sanitize-recover=undefined:
    
     - before: every command aborts in ethtool_link_mode_set_bit() on startup
     - after: --version, -k lo, --json -k lo, and -K/-k round trips on a veth
       pair complete without UBSan reports, including -K tx-esp-segmentation
       and -K hsr-dup-offload (feature bits 31 and 63 here), which go through
       set_sf_req_mask(); walk_bitset() was tested with a synthetic 64-bit
       compact bitset with bits 31 and 63 set
     - all test-cmdline cases pass before and after
    
    test-cmdline reports one more instance of this, RXH_DISCARD (1 << 31) in
    uapi/linux/ethtool.h, used by "-N ... rx-flow-hash ... r". As that header
    is imported from the kernel, I have not touched it here.
    
    The internal.h and features.c changes were previously posted by Jesse
    Brandeburg as 08/13 of a larger cleanup series [1], which stalled on the
    UAPI changes needed for BIT(). This patch is only the minimal fix,
    extended to the same pattern in walk_bitset().
    
    [1] https://lore.kernel.org/netdev/20221208011122.2343363-9-jesse.brandeburg@intel.com/

 internal.h         | 4 ++--
 netlink/bitset.c   | 4 ++--
 netlink/features.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/internal.h b/internal.h
index 50d43cc..406776a 100644
--- a/internal.h
+++ b/internal.h
@@ -192,14 +192,14 @@ static inline int ethtool_link_mode_test_bit(unsigned int nr, const u32 *mask)
 {
 	if (nr >= ETHTOOL_LINK_MODE_MASK_MAX_KERNEL_NBITS)
 		return !!0;
-	return !!(mask[nr / 32] & (1 << (nr % 32)));
+	return !!(mask[nr / 32] & (1U << (nr % 32)));
 }
 
 static inline int ethtool_link_mode_set_bit(unsigned int nr, u32 *mask)
 {
 	if (nr >= ETHTOOL_LINK_MODE_MASK_MAX_KERNEL_NBITS)
 		return -1;
-	mask[nr / 32] |= (1 << (nr % 32));
+	mask[nr / 32] |= (1U << (nr % 32));
 	return 0;
 }
 
diff --git a/netlink/bitset.c b/netlink/bitset.c
index 10ce8e9..0c58431 100644
--- a/netlink/bitset.c
+++ b/netlink/bitset.c
@@ -227,9 +227,9 @@ int walk_bitset(const struct nlattr *bitset, const struct stringset *labels,
 		val_bm = mnl_attr_get_payload(bits);
 		mask_bm = mask ? mnl_attr_get_payload(mask) : NULL;
 		for (idx = 0; idx < count; idx++)
-			if (!mask_bm || (mask_bm[idx / 32] & (1 << (idx % 32))))
+			if (!mask_bm || (mask_bm[idx / 32] & (1U << (idx % 32))))
 				cb(idx, get_string(labels, idx),
-				   val_bm[idx / 32] & (1 << (idx % 32)), data);
+				   val_bm[idx / 32] & (1U << (idx % 32)), data);
 		return 0;
 	}
 
diff --git a/netlink/features.c b/netlink/features.c
index 1a8c2f5..2973b44 100644
--- a/netlink/features.c
+++ b/netlink/features.c
@@ -57,7 +57,7 @@ static int prepare_feature_results(const struct nlattr *const *tb,
 
 static bool feature_on(const uint32_t *bitmap, unsigned int idx)
 {
-	return bitmap[idx / 32] & (1 << (idx % 32));
+	return bitmap[idx / 32] & (1U << (idx % 32));
 }
 
 static void dump_feature(const struct feature_results *results,
@@ -304,7 +304,7 @@ static void set_sf_req_mask(struct nl_context *nlctx, unsigned int idx)
 {
 	struct sfeatures_context *sfctx = nlctx->cmd_private;
 
-	sfctx->req_mask[idx / 32] |= (1 << (idx % 32));
+	sfctx->req_mask[idx / 32] |= (1U << (idx % 32));
 }
 
 static int fill_legacy_flag(struct nl_context *nlctx, const char *flag_name,

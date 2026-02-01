Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC233CEB9
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769955283; cv=none; b=S7cOzu5SgTc5u0OMDkb8tcJfek7UA7GiNTP2kZJwYNvuJXt0CjHzhbngESTujrRZZ9YCu/Ll7IJTOtkRVok7hIIMBSBkBTJeuzwVaxldHijZbQ6ZGRZy+Je154B+9I4rCviaQSPGVEuO1ELC8kZ6s3oH/ARIPxJJX2T/K8BlY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769955283; c=relaxed/simple;
	bh=MgOywgjpVbTVfAhVRGWjklJ4VfDwc9t3bcDSNF8jTEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGQdOGC6vUZk7baydj1Fc5Jz2Mf/aTq1UACg58KP/o/oXRdxZBN223zQT/UgHIqXG6Wl6+RxizOQCNSNh4HPpvIkWvPUcoNKie3AKkqmFI49OcHLUsAoo+VENOoOpVGHhXl2zP7Z4HE+B8quPBiYLV7NAWhqsEuBOiHpROJ/688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=jHULLAp6; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="jHULLAp6"
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 611EEWh2001191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 1 Feb 2026 23:14:33 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=NsDbxjjmDR7CvHkvxGhq8nSyf2oqDfr3q8OmR6MlyCQ=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769955273; v=1;
        b=jHULLAp6oKbuXYDcbKLPKiG/1tfUlOI1mcpKIrrSPQpjY2q5LtCJZ/w3N5Os+4tN
         ADBk2kK5J758uT3e1l7mvCxnillFqYnySDCBgxBlfoYehf4IfmpAjH/BFVLAtWcl
         gyuHhTIwDiBBFVKJdat4FoK2uXg/JUhgjV++xeSdFgmJS0VtjD0Drf2Cir05EZB0
         tsh6jw2G5q2fltSqltwI10XcpjfsqiNOtjSK6FqS2xXVNtP5wt4cdgFdvGaHHQXz
         la8EU5nKsAl6WRH16a7nBgAZxSQbdTLNbBoqubI1e8clbHSr+TP5hsF2yrSQeo/v
         xZJxF2fBGQiaJVCtN4j2PQ==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
        Simon Horman <horms@kernel.org>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] ice: ptp: don't WARN when controlling PF is unavailable
Date: Sun,  1 Feb 2026 14:14:00 +0000
Message-ID: <20260201141430.131063-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In VFIO passthrough setups, it is possible to pass through only a PF
which doesn't own the source timer. In that case the PTP controlling PF
(adapter->ctrl_pf) is never initialized in the VM, so ice_get_ctrl_ptp()
returns NULL and triggers WARN_ON() in ice_ptp_setup_pf().

Since this is an expected behavior in that configuration, replace
WARN_ON() with an informational message and return -EOPNOTSUPP.

Fixes: e800654e85b5 ("ice: Use ice_adapter for PTP shared data instead of auxdev")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 272683001476..082313023024 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3048,7 +3048,13 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
 
-	if (WARN_ON(!ctrl_ptp) || pf->hw.mac_type == ICE_MAC_UNKNOWN)
+	if (!ctrl_ptp) {
+		dev_info(ice_pf_to_dev(pf),
+			 "PTP unavailable: no controlling PF\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
-- 
2.51.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616410;
	b=oaqy6WerERIxCj2BAp5ZNlWvwD3D10sZtY50ASXvOKhiMjWWN2pibzr0BwdhOqT/0+L2
	 3URDt7ksy/Nq4nkgjy+FDnPxx3ViWVaUV+nv+uTfLXPaIC4//FAg11Lq7yC57MwNfrxAu
	 ATZj44FMmuVJfrXkjqcUQ1YN6H6PumMOUztRaIGCTGLGjiOHEqksvu1p9R7D17zAYI5qe
	 +2rPRdJCJPSCnjiqPpixpezHCL9VDGSdrNy1VdbKpQ/v/o5uifP7HzySkYoILAcZPTrxe
	 az0frHPTcO8Cq04res4Nbk5PptUHirP2/LRaVs0gjdpDLyYvz0Lfv4sPEMu3IH7KQMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616410;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/7xDlceIeNbo7lDGt7hMq0QjN6wX8+OHWkN6IukYVwI=;
	b=fjS6wi05vE8JzTUt+KI54A8J0NGyfb+dmpmQP3qUnnqfa+Yzeg2Wp6uPS6QyKmvs1VG1
	 LT7EyvBWVwpmpwMpXpfgXDG8jYMR/iiCpSDaTQlO0zfQJa3qmG90qegu97ILu63vu8bJP
	 1680CZPYnthguKqLfZnqvXG3gFCiDLqLPqsxEs66pX3PGedtebcU4r2LNZ2rlsV/tlpmD
	 3klf/Fj5Wwd4/yKj2jlHvaC1BvdAxOPQvZMa2zcHtyBZWnDkL2j0pg/pzwrW2IsyJhFLI
	 cZWWgyT/GsX+EIUPX2s6mOSfWz2ex3Xdg7ZXNdyP3KxgOHRPknCc+1BQP9JdK2KaONg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m+ioguzH;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CA606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m+ioguzH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616409; x=1825152409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EfBBOEZZ/St3wrXFXXFhlsLqHhhbxpnuAZwH6hLbGGE=;
  b=m+ioguzHdYdWlq6qxRyrFXbMbTPEOZrF24xCWv29AxGk0Dqj0mGrIsOv
   jqaAZ9nlcQ+KprlGrfLDRQANLbrh2lBvL9j9xMzOBWqy/ojlNowRB1rHw
   raYwXuNXMptrI9YArTnLlwaFd4LRieGwjYjqq9kN+6RqvB5awzs6kiDQ5
   NRc7bL+aO6D5LFQ7vUj9QzZtOmsr1UU3Z7dKx31Q0+qBouEK+WWQH53od
   +c0rRFyjWZb8osU9DMZIQyfU0Iv9h/DVWPOYrraKZjnisexfUwBhGk8lc
   tfVi4uNrT8vXvbmT3i4fyAsIgpWdZP8MZP6pXP4Y+7TdGCOSGLuap6yz2
   w==;
X-CSE-ConnectionGUID: p4WKM17xRVK9+F/+I93n9g==
X-CSE-MsgGUID: HkiYj//1SZq6vCDLXSq25g==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2305034"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2305034"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:46:32 -0800
X-CSE-ConnectionGUID: RA9T3jxwTuOrUyFkHdqI4A==
X-CSE-MsgGUID: BS1LAls0QCWwsc4+M7uwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6012008"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 02 Nov 2026 02:46:30 -0800
Received: from pkitszel-desk1.igk.intel.com (pkitszel-desk1.igk.intel.com [10.217.184.18])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D0CE52876B;
	Mon,  2 Nov 2026 10:46:28 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 2/6] ice: take rtnl before tc_mutex in DCB MIB change and rebuild
Date: Mon,  2 Nov 2026 11:50:17 +0100
Message-ID: <20261102105346.30739-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
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

ice_setup_tc() and dcbnl ops are called with rtnl held and then take
pf->tc_mutex. LLDP MIB change handler and ice_dcb_rebuild() (the latter
only on its error path, via ice_pf_dcb_cfg(..., false)) do the opposite:
take pf->tc_mutex and then rtnl. The MIB change handler runs from the
service task. ice_dcb_rebuild() runs from ice_rebuild() (reset, also PCI
AER resume), and from ice_link_event() in the service task, on a link
change while DCB is enabled. So a MIB change from the link partner, a reset
or a link change, concurrent with "tc qdisc add ... mqprio" or "dcb ets
set" may deadlock.

Take rtnl first in both functions. ice_dcb_rebuild() now holds rtnl also
on its success path, which only sends a few AQ commands. None of its
callers hold rtnl.

Lockdep splat, on the first MIB change that needs a DCB reconfiguration
after "dcb ets set" was used:

        CPU0                    CPU1
        ----                    ----
   lock(&pf->tc_mutex);
                                lock(rtnl_mutex);
                                lock(&pf->tc_mutex);
   lock(rtnl_mutex);

Reproducer, with the FW LLDP agent in its default (willing) mode:
  PF=eth2
  ethtool --set-priv-flags $PF fw-lldp-agent off
  dcb ets set dev $PF tc-tsa all:ets tc-bw all:0 0:100 prio-tc all:0
  ethtool --set-priv-flags $PF fw-lldp-agent on
and then, on the link partner, send an ETS recommendation with a different
UP2TC mapping (python3 lldp-ets.py <partner-ifname>):
  import socket, struct, sys
  ifc = sys.argv[1]
  mac = open(f"/sys/class/net/{ifc}/address").read().strip()
  mac = bytes.fromhex(mac.replace(":", ""))
  tlv = lambda t, v: struct.pack("!H", t << 9 | len(v)) + v
  # not willing, prio 4 -> TC1, TC0/TC1 ETS 50/50
  ets = bytes([0, 0, 0, 0x10, 0, 50, 50] + [0] * 6 + [2, 2] + [0] * 6)
  lldp = (tlv(1, b"\x04" + mac) + tlv(2, b"\x03" + mac) +
          tlv(3, b"\x00\x78") +
          tlv(127, b"\x00\x80\xc2\x09" + ets) +  # ETS Configuration
          tlv(127, b"\x00\x80\xc2\x0a" + ets) +  # ETS Recommendation
          tlv(0, b""))
  s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
  s.bind((ifc, 0))
  s.send(bytes.fromhex("0180c200000e") + mac + b"\x88\xcc" + lldp)

Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 0bc6dd375687..3034f461f513 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,6 +537,7 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
 
+	rtnl_lock();
 	mutex_lock(&pf->tc_mutex);
 
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
@@ -570,14 +571,16 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	}
 
 	mutex_unlock(&pf->tc_mutex);
+	rtnl_unlock();
 
 	return;
 
 dcb_error:
 	dev_err(dev, "Disabling DCB until new settings occur\n");
 	err_cfg = kzalloc_obj(*err_cfg);
 	if (!err_cfg) {
 		mutex_unlock(&pf->tc_mutex);
+		rtnl_unlock();
 		return;
 	}
 
@@ -591,10 +594,11 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	 * Suppress the Coverity warning with the following comment...
 	 */
 	/* coverity[check_return] */
-	ice_pf_dcb_cfg(pf, err_cfg, false);
+	ice_pf_dcb_cfg(pf, err_cfg, true);
 	kfree(err_cfg);
 
 	mutex_unlock(&pf->tc_mutex);
+	rtnl_unlock();
 }
 
 /**
@@ -1055,6 +1059,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 	}
 
 	/* That a DCB change has happened is now determined */
+	rtnl_lock();
 	mutex_lock(&pf->tc_mutex);
 
 	/* store the old configuration */
@@ -1105,25 +1110,23 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 		pending_handled = true;
 	}
 
-	rtnl_lock();
 	/* disable VSIs affected by DCB changes */
 	ice_dcb_ena_dis_vsi(pf, false, true);
 
 	ret = ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
-		goto unlock_rtnl;
+		goto out;
 	}
 
 	/* changes in configuration update VSI */
 	ice_pf_dcb_recfg(pf, false);
 
 	/* enable previously downed VSIs */
 	ice_dcb_ena_dis_vsi(pf, true, true);
-unlock_rtnl:
-	rtnl_unlock();
 out:
 	mutex_unlock(&pf->tc_mutex);
+	rtnl_unlock();
 
 	/* Send Execute Pending MIB Change event if it is a Pending event */
 	if (!pending_handled)
-- 
2.54.0


Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191538CFE1
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642972; cv=none; b=GBmvxMiVv5POUkLY03jYnpiohVBBlIAAfVR3T+tZDpBsVl0GXggviu7f6GygVk+IQPObyY/nyEjDhLXift+RVuGqkuAaTebAF7m35MMdGeyZ8Mo1DL3d3UPm+lJCq8S2GjObpBDIygXLCVrgi+cwO+LPTGmVfCLO7O9SUu6GbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642972; c=relaxed/simple;
	bh=Sy2dQIDfTn0vvrCxCW0E3gAUSF0oXL12B/CyzEPp41Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtpU6zRwrDUsMXM79yTPM2e/GzIYiCzJGEwVQATtSmbK2W3WoRmpJINMHyAuMahhoiHNDA2/eSer40DTtYFEvwUe8ykl8yV8ak0c/+hPd5xzwassVWM53QAUYDzFksq/V+Odc+zVTJKPJgwUXZcLM8lV+N4zH7OgL82jRvMQYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VSFIf0uG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VSFIf0uG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so27005305e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784642969; x=1785247769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfL6iUrlxMqA1SULmpcqd51oivcgiX3MCBlh/k4Gk/k=;
        b=VSFIf0uGwNeuRUCPnPQqgtgZ/nzigUGU+1iw1WT8PpehCbv66g5igOfKacQRFnvPdk
         156KHKz2m1KEJ2nTnGNQVGtWItG0qVxLubthiq/bI0ijTy0kESWPPPe860IH4+oRvJlz
         /9HZEtDmKc2+oE6eOmmG/q9NWzS/WC7nH3S42KwQIf03qCSiXlrURJtFswlmTWYLLA3h
         Hc9yYUS5OFVlSAJHIVpOe+VC3FmxnREcbSzGtCPMNweb+qWRolIfZl498NTWxxy9RN6A
         yxSH5u9X05YLlHnTaMQLxrt6Z4H2nlgs3GLcLozOdcWnUnqRGeI/WqH7Av1b1bthC1Tw
         oihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642969; x=1785247769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfL6iUrlxMqA1SULmpcqd51oivcgiX3MCBlh/k4Gk/k=;
        b=cc7/5eQODJMXithouLq5LcUPcoyriIozE9T7caPXw45hdBCEUPirpWO2DYoRFoLgXM
         r7PO1I9X+rQ4gFauplLsfETxfCiHjoVmgStTX9FyU84SCGCE2OPI8JSBRzUrVesY4a7m
         3FtCGN45+3RLbtDwCksExjMl2EgzvIY4XUx1/ZYJE3O3t5S8/Ab3hF4MyGiAyku0Qdel
         IcUuve9yvrA2Et65RoZaAmqPTbolGa/lV7Z5NUdQj2AXydgP1yaex+xhvxbIFQW0eOPo
         nT9383VOuRLVgUk0RRTIKwQlyV0YpOFr1TVGKGiOFKksDgiGBbuOqAmNyteIOLdJ2bxl
         jNxA==
X-Gm-Message-State: AOJu0Yw78NtnSI4VfPG964jT9fPeaHdXpoabsxw7Jb2Ebm98hqvneSVa
	tZZbqJyQuin+LvtprYEbW+SWvltaGK7hDZ373p+LyhzXEPjUX3D27JQDUVO0UKc8zIEAd5yV+Jm
	IOfTCb7g=
X-Gm-Gg: AfdE7cmhGyZP19666KIU5Frgh3MPE8vOHJcWz+PsW/8uV3q/2WDwwkhImVCdWkodLjX
	tQ35rzMI1iU9bcVP+ZAJVfSROfLOOTRn7j8L2XS7NjAlpVMHVs3SCkCdzzAP7linprKPTJgwita
	YmLRpf6QC/rAUdav0TL3x1mTbXIPmYDXAycGBekfeZ42D8C7Is4Vtb1iueDvjKjN+9LABjFvcWv
	JnhDUF0Fa+RE8Wgjfoinl024H56zg04jKZqKuUzwqQjjZn8NVVdMl8JkFLhlPi9gF7PDFgVufsd
	XKDZd3wSfTyiIwPnCN5JmdTMOOyAXZ91OukCSAc3/EDR2+opvRD9Sr5C12T9AKTgHfeB5JyRche
	xVgaC0rtmGgdvNdxLKdMsJ6XgJsLtspFJPIBUy2rqEyCZ+FSR3cPWQXmZOe2X5PMQcnxA3TH9Ip
	RdXVSPB7uGd6MBX9ya+hYy9Gww
X-Received: by 2002:a05:600c:4ecb:b0:495:4c73:3d59 with SMTP id 5b1f17b1804b1-4954c733e07mr193457475e9.23.1784642968727;
        Tue, 21 Jul 2026 07:09:28 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-495653698bcsm65138255e9.2.2026.07.21.07.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:09:28 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/2] selftests: net: bridge: test ranges with PVID VLAN
Date: Tue, 21 Jul 2026 17:09:22 +0300
Message-ID: <20260721140922.682265-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721140922.682265-1-razor@blackwall.org>
References: <20260721140922.682265-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test with PVID VLAN that matches the flags of the VLAN following it
and check if the range is properly dumped. PVID VLAN should be on its own
and all VLANs should be present in the dump.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../testing/selftests/net/bridge_vlan_dump.sh | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/bridge_vlan_dump.sh b/tools/testing/selftests/net/bridge_vlan_dump.sh
index ad66731d2a6f..90e18e2104e3 100755
--- a/tools/testing/selftests/net/bridge_vlan_dump.sh
+++ b/tools/testing/selftests/net/bridge_vlan_dump.sh
@@ -13,6 +13,7 @@ ALL_TESTS="
 	vlan_range_mcast_max_groups
 	vlan_range_mcast_n_groups
 	vlan_range_mcast_enabled
+	vlan_range_pvid
 "
 
 setup_prepare()
@@ -191,6 +192,28 @@ vlan_range_mcast_enabled()
 	log_test "VLAN range grouping with mcast_enabled"
 }
 
+vlan_range_pvid()
+{
+	RET=0
+
+	ip -n "$NS" link set dev br0 type bridge vlan_default_pvid 1
+	check_err $? "Failed to configure default PVID"
+	defer ip -n "$NS" link set dev br0 type bridge vlan_default_pvid 0
+
+	bridge -n "$NS" vlan add vid 2 dev dummy0 untagged
+	check_err $? "Failed to add VLAN 2"
+	defer bridge -n "$NS" vlan del vid 2 dev dummy0
+
+	bridge -n "$NS" -d vlan show dev dummy0 |
+		grep -Eq '(^|[[:space:]])2([[:space:]]|$)'
+	check_err $? "VLAN following PVID is missing from detailed dump"
+
+	bridge -n "$NS" -d vlan show dev dummy0 | grep -q "1-2"
+	check_fail $? "PVID was incorrectly included in a VLAN range"
+
+	log_test "PVID is isolated from VLAN dump ranges"
+}
+
 # Verify the newest tested option is supported
 if ! bridge vlan help 2>&1 | grep -q "neigh_suppress"; then
 	echo "SKIP: iproute2 too old, missing per-VLAN neighbor suppression support"
-- 
2.47.3


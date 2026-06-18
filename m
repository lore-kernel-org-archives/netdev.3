Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507013CFF4F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768026; cv=none; b=O1eRNjn3XoBDdnwPwgv25hr7OmWimGbZH9EE/ZImnkmvnP8Z35+lnrslGsU8x6oOejT7CX1VxVJUTeGYOcV3j2P7ajlv/R6EEI2xFC7csN1fO9QKE1pzWi5c8kuWUw9102a/uTNiRxOwbnmZTlVPPHRjYAgn4XNKFbJ0YJjuWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768026; c=relaxed/simple;
	bh=Jj87B0nR8At2bZKgk9HSptVq6BQS48KuPJJ+5Wkoo7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqiSDgbrs9sfVGJklkCzXPx3QWexZ4iYRZI35143zmf7498KIlYpzVZBPovsa5l0RC0xUzb1W4BJZPQ2Bg6aXOwy8tmeBqHj/Qihmnbm6U16xhyBcGgHA+RT5oTUs4dW27afwByt8CVMdviUWvFUa8bYS2rkbd6mBElerEfiYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmteuzMf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmteuzMf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845397d1221so350242b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781768023; x=1782372823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC8m00hNT/zsxkHYFRFPGw4zukh8ZUZXCbr2Z4/rGi8=;
        b=SmteuzMfYktvrfKadzVdHTg3Y1UAkSZ+r7PUijR0nqOQ29i+1xFBiQte+42ZRnn/Xr
         PvwEujrNEV/VBIq/C1it6rFxco2n3pkebM/Pb6hvbwgA7xfPVN8D+8Gx281Q+wUaJfie
         pBan4Jl/JOmyKgqRFAFdGbXTl2pGbGsN688VYuHKYTKeZqmW8yCIviF9rhF55lsFIx21
         tRXdcIV2EUwc/juk+8oCFN+WnfQqNc151In5FhWYLuumyN1wpbkBPKnxe1Du2YtkWniW
         fCDKRYFtx9+WHYkq3wLDGKEZ6Shq+91bPd9GpJrToEerT/Fe3MMeY6Q+/QVvspL/064P
         pJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768023; x=1782372823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HC8m00hNT/zsxkHYFRFPGw4zukh8ZUZXCbr2Z4/rGi8=;
        b=kej4Xggmm9lUyxotPGgygaHy+buXUXSRKKPCO1WvLVpxBKXAnuzhyebLZdkrveaiCA
         bnsaX8P4z1Oehm1mgJnxjEDmNLH0jmOgrh4CJIJIf8huSDPkh9QnCxTPa53Lbtup3WRh
         AcUpe9P/uZuWxSK9QHOfq28M8rafERQBc5b89w03f+tSadP6Mh2ZfFMChpVAM/xZDEh6
         MPl5NWWIS1eBNPy/ifdKPcTH9hNUjPznLYOL8Aab00wZcGbQ+uqxKZGRg9Lhos6aXGni
         3Udvavd7j2JyirEH28YitqPXjxplJe4c2CAYCNAjyewSwte+PwSNwNOIWzaJzcp9L7u1
         y0AA==
X-Forwarded-Encrypted: i=1; AFNElJ/LE/zSCej6nDRaJWZriDtoZFElknZT2c8QMNEdug2dQdKVguvp62jnbvAcYG5M0pzVmJvcj8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlU5C2UPkgsLNDWBet7TRDBLEK7nkjQlEPQRUPR03tFhddOUv
	/E8PbQwQkUMCVswOFruZvpaUFJkBAh6bn9toym+fN7BJZugHxE3h2px5
X-Gm-Gg: AfdE7cmhp8jj8XQNsUYbJINIqzpM57+RcDD8z3CuKsCgE0ehqtSGi7lawdOxpSx9q+2
	pDJRrlPceslBU4eyFR2CVKnfa8hTA3UhTjQLVtzPqyFMS29GE6zPLM1OzuOiizaagVZgcCKIFKZ
	Dmr/zFEbxOga1byfl68lY/L8c7gcFNVzuJItGPbvl5V8IP8m6HlPFiyK9ODQiTFaOB9d2H80vvb
	mqdXb5gbdi9vMAkmqKde8PFtTmHcyRprEFrKwtgRvzoHn0pEyE2e4LYzIf92VZVpW+F+abPPAEZ
	sHJVziCpGkzGY3uJB/5HMm9N0kV/qzLB4YJ0QxJFJP809uK+YcrHS/LMg1Hsdm4iy0yyjQl6T/y
	xD+uPNv8RmDuPHol5n/8qLJxKmGcY4htzwpGKmnG97d70WrXJbK4MLIZ7i10XU93/dNIy1lqWKN
	LBfSm3Y2drg7icBqEASq0oXYNwcEXYMD/HL9yP7u9pak/653OdSlM0Aq/5u3kTQRYZFFQ7
X-Received: by 2002:a05:6a00:124d:b0:842:5b63:6114 with SMTP id d2e1a72fcca58-8452447e116mr7603109b3a.13.1781768023376;
        Thu, 18 Jun 2026 00:33:43 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm18630390b3a.0.2026.06.18.00.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:33:42 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] igc: Cache MAC passthrough address
Date: Thu, 18 Jun 2026 15:33:23 +0800
Message-ID: <20260618073324.1843310-2-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618073324.1843310-1-acelan.kao@canonical.com>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remember the MAC address that firmware writes into RAL0/RAH0 after reset.
On later probes, wait for that cached passthrough address instead of using
any valid register change as the completion condition.

This keeps the first probe conservative and lets later dock replug cycles
use the known passthrough address once the platform has already shown that
firmware can rewrite the address registers.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 41 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fa9752ed8bc5..cf87a82f1bf8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -12,6 +12,7 @@
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
 #include <linux/etherdevice.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/mdio.h>
 
@@ -70,6 +71,32 @@ static const struct pci_device_id igc_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
 
+static bool igc_mac_passthrough_cached;
+static u8 igc_mac_passthrough_addr[ETH_ALEN] __aligned(2);
+static DEFINE_MUTEX(igc_mac_passthrough_lock);
+
+static bool igc_get_mac_passthrough_addr(u8 *addr)
+{
+	mutex_lock(&igc_mac_passthrough_lock);
+	if (!igc_mac_passthrough_cached) {
+		mutex_unlock(&igc_mac_passthrough_lock);
+		return false;
+	}
+
+	ether_addr_copy(addr, igc_mac_passthrough_addr);
+	mutex_unlock(&igc_mac_passthrough_lock);
+
+	return true;
+}
+
+static void igc_cache_mac_passthrough_addr(u8 *addr)
+{
+	mutex_lock(&igc_mac_passthrough_lock);
+	ether_addr_copy(igc_mac_passthrough_addr, addr);
+	igc_mac_passthrough_cached = true;
+	mutex_unlock(&igc_mac_passthrough_lock);
+}
+
 static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32 *rah)
 {
 	*ral = rd32(IGC_RAL(0));
@@ -97,22 +124,32 @@ static bool igc_is_lmvp_device(struct pci_dev *pdev)
 static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
 					      struct igc_hw *hw)
 {
+	u8 cached_addr[ETH_ALEN] __aligned(2);
 	u8 addr[ETH_ALEN] __aligned(2);
 	u32 orig_ral, orig_rah;
 	u32 ral, rah;
+	bool cached;
 	int i;
 
 	if (!igc_is_lmvp_device(pdev))
 		return;
 
+	cached = igc_get_mac_passthrough_addr(cached_addr);
 	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
+	if (cached && ether_addr_equal(addr, cached_addr))
+		return;
 
 	for (i = 0; i < 100; i++) {
 		msleep(100);
 		igc_read_rar0(hw, addr, &ral, &rah);
-		if ((ral != orig_ral || rah != orig_rah) &&
-		    is_valid_ether_addr(addr))
+		if (cached) {
+			if (ether_addr_equal(addr, cached_addr))
+				return;
+		} else if ((ral != orig_ral || rah != orig_rah) &&
+			   is_valid_ether_addr(addr)) {
+			igc_cache_mac_passthrough_addr(addr);
 			return;
+		}
 	}
 }
 
-- 
2.53.0


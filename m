Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98B342532
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405544; cv=none; b=ePeECQjmBXM361u1pJY5fxha6XgDW891BY/0Cv1Lk1b+f+a/UWtX+BuwFhNjO+t+z5AWE7jqwG/lekkhDIOzRpTJpizhXYzzC42M4W558rX3OQFiLCE2sYmlPAB4uGqbCZOThCQVrO45Vxs1GzEsrgt597/eXPHnE0izkA3iWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405544; c=relaxed/simple;
	bh=kg08YrKIRvZJ4Umaa9T0oc9c5TJ0cVuh5vuc+gdbkGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMlI21z4t1X0KYJLs0dlvvZ4nMo/PFaHe0+hW4cDNaJu2vKFM0IiCy+pO9lD4dA2SZEeSf8jMaGZIGpbqQU62/1pFVfX6k3+FhQ+YwE/GEa0NS67o3d5VaY0Ka56skEYyEVs/hLx25ewIj7zig1xb4qksOAwCIqbyaaNLNFV6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QGyvHxj+; arc=none smtp.client-ip=91.218.175.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QGyvHxj+"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kg08YrKIRvZJ4Umaa9T0oc9c5TJ0cVuh5vuc+gdbkGY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791405539; v=1; x=1792010339;
 b=QGyvHxj+MHT0iRKi85+/tKsz3aQlsOaOXrDjUfJYo5VQ7I7G0PcIHFrE+JHRSMCwZyYrvkPG
 719vKH0DkxlSk97NzxCwEaiyv0wkofenJysxc+ZQg7UMZtF+u8o8YNkVRilqa7Q745qiVzvK3Tb
 F4cKuKVW4goTHbNecv4pqaqI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d5a943d16b077be6;
	Wed, 07 Oct 2026 20:38:59 +0000
X-Mizu-Trace-ID: d5a943d16b077be6
X-Migadu-Flow: FLOW_OUT
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net] ptp: ocp: fix PCIe delay estimation calculation
Date: Wed,  7 Oct 2026 20:33:59 +0000
Message-ID: <20261007203359.417270-1-vadim.fedorenko@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in fixes introduced a high cap for delayas U64_MAX value
while ktime_t is actually s64. This is wrong cap as it becomes negative
value and any comparison to a real delay will fail to update delay
value. Use KTIME_MAX constant as correct max cap for PCIe delay.

Fixes: aa05fe67bcd64 ("ptp: ocp: Improve PCIe delay estimation")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 3d26ec1f7b9e..a8cba2f64b98 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1825,7 +1825,7 @@ ptp_ocp_watchdog(struct timer_list *t)
 static void
 ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 {
-	ktime_t start, end, delay = U64_MAX;
+	ktime_t start, end, delay = KTIME_MAX;
 	u32 ctrl;
 	int i;
 
-- 
2.47.3


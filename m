Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05723939A4;
	Mon, 10 Aug 2026 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345098; cv=none; b=JnWIuzXqBTrwzCeRC55ivps0X1lHUexkaemAaUGZcB/Ph8phFXZ+YMRxyifXA7gKNuZodv29yi4B5JMWfkIrnMw1fq3FmWMbZJU4e+FGn+Mxv3TFirrFvdq9QEMNX9BV0vBtxfVGI822lasqrbKoImMK0MjUYBuwXqPzeCGq+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345098; c=relaxed/simple;
	bh=7WlPeWCWTJ+S0FMnLOLkCGqMPWXTgxckC0ljdW2sEGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CcTBz2IoyGzJ2cRA/aU/SGL99LUqGII05qg9i0QQZm0t5DRhXU3ZszPyz7COBALUVYJxkAAWpabax6RLy3g9odPkLa8YF1N8o9FNg2os7MWfUhI/+5VOQq1/6XX9fdNhtbLXjW37LXj3uTrM7ytDNV4991RjO2+liVfuAUubd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bMi4LUef; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bMi4LUef"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67A6viQN31514129, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1786345065; bh=oAJl7fPPZqm2YPpWeuSwRmWowSoWPb5vYe00HxOiy9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=bMi4LUefoGWIa3H5nV86hOf8YPw38c6TyseJSQFr1UUKBwzBtKnU6OuHXy0xaL67S
	 i0TsBypZnEunCJsXmYqBpAwM8b0dQhnZqtE++bjSLBZ26ChtqRSyrf6MeF7qA0x+dq
	 pTG5bxH5P9ZpNnGMl32oQSZdu/U1eE4mb+vkpZsyFo/xW7b6vWj9oJD2bihNRKRlYD
	 3gMfqzDu5WCFvxGO2aLEbJXiVm8ax95StK0eGxkJNXkPpWc5oXVZFLJZZcu9UDP/pJ
	 IzrjRWlvtfQadb8Y9NxNRcR5JVzMeil9svSIJ5kReyj3dE1oRLhSL4JNJKQfoAeuF4
	 8q5Pv7ohdpE4Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67A6viQN31514129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 14:57:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 10 Aug 2026 14:57:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 10 Aug 2026 14:57:44 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Mon, 10 Aug 2026 14:57:44 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next] r8152: use GFP_NOIO during system suspend
Date: Mon, 10 Aug 2026 14:57:41 +0800
Message-ID: <20260810065741.4019-1-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

During system suspend, memory allocation with GFP_KERNEL can block
waiting for I/O to complete. If that I/O depends on a device that is
itself suspended, a deadlock results.

Introduce RTL8152_SYSTEM_SUSPEND flag to track when the driver is
operating in the system suspend/resume context. Set the flag at the
start of rtl8152_system_suspend() and clear it at the end of
rtl8152_system_resume(), following the same pattern used by
SELECTIVE_SUSPEND for runtime suspend.

In get_registers() and set_registers(), select GFP_NOIO when the flag
is set so that the kmalloc and kmemdup calls in those paths do not
trigger I/O reclaim.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..57d04af6368c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -792,6 +792,7 @@ enum rtl8152_flags {
 	IN_PRE_RESET,
 	PROBED_WITH_NO_ERRORS,
 	PROBE_SHOULD_RETRY,
+	RTL8152_SYSTEM_SUSPEND,
 };
 
 #define DEVICE_ID_LENOVO_USB_C_TRAVEL_HUB		0x721e
@@ -1370,9 +1371,12 @@ static
 int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 {
 	int ret;
+	gfp_t gfp;
 	void *tmp;
 
-	tmp = kmalloc(size, GFP_KERNEL);
+	gfp = test_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags) ? GFP_NOIO :
+							     GFP_KERNEL;
+	tmp = kmalloc(size, gfp);
 	if (!tmp)
 		return -ENOMEM;
 
@@ -1394,9 +1398,12 @@ static
 int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 {
 	int ret;
+	gfp_t gfp;
 	void *tmp;
 
-	tmp = kmemdup(data, size, GFP_KERNEL);
+	gfp = test_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags) ? GFP_NOIO :
+							     GFP_KERNEL;
+	tmp = kmemdup(data, size, gfp);
 	if (!tmp)
 		return -ENOMEM;
 
@@ -8693,6 +8700,9 @@ static int rtl8152_system_resume(struct r8152 *tp)
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	}
 
+	clear_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
+	smp_mb__after_atomic();
+
 	return 0;
 }
 
@@ -8758,6 +8768,9 @@ static int rtl8152_system_suspend(struct r8152 *tp)
 {
 	struct net_device *netdev = tp->netdev;
 
+	set_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
+	smp_mb__after_atomic();
+
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev) && test_bit(WORK_ENABLE, &tp->flags)) {
-- 
2.34.1


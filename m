Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEC34B662;
	Sun, 20 Sep 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889375; cv=none; b=J6QuUZgvBc8MCR7fhzSHGfEf+wwtqxZur3NNw+iqdcx2w3gHi1W9Xe5nWE73BrzkGRiCTTTuow6Cla+AX4i4KmZhy1y8E6rKymj1FAbHTdIgmwK73q99tzE7s/9sXGkONhT4fQBfrpcPgldhDNVuTaBCL354707nKbYkmBM5Whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889375; c=relaxed/simple;
	bh=pBgQ849jDAg8Q305lUVoSgp3uVqS6DnG20M+a5PjCEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLmnWgeMItHjITooVwvmPp4nvtvXVr6Ztzc1UrUazPTwSRcLAA/CjkGTgMttIRJsLyAR5IGnAgoJub4zvP2HhPEn+oTF9k1pZxxJBFMMVnNnBZDuWqQUA4H65QNUi4FBtw3PNJ113x3qAIwCBziBB1sf54hjeEysBTgD1Fk57sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.180.135.190])
	by gateway (Coremail) with SMTP id _____8Bx79JZi69qW94NAA--.40882S3;
	Sun, 20 Sep 2026 15:29:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.135.190])
	by front1 (Coremail) with SMTP id qMiowJAxmM1Xi69qJOsiAA--.7935S2;
	Sun, 20 Sep 2026 15:29:28 +0800 (CST)
From: Ming Wang <wangming01@loongson.cn>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	Ming Wang <wangming01@loongson.cn>,
	Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist
Date: Sun, 20 Sep 2026 15:29:26 +0800
Message-ID: <20260920072927.825279-1-wangming01@loongson.cn>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM1Xi69qJOsiAA--.7935S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEQEmqvPvQFMAAAs4
X-Coremail-Antispam: 1Uk129KBj93XoW7WF17ZFyrtw1kKw45XF17XFc_yoW8WrWxpF
	4rCFyay39xJry5Gw1rA3WfWFy5Zwn3Cay5KFWI93W5Z3Z0ya4aqFyxJFyUKrykAF45AFnF
	yasxJ3y7Wa1DGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07
	x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jY0PfUUU
	UU=

The MeiG Smart SRM821 5G module (0x2dee:0x4d53) crashes and drops off
the USB bus when it receives a Zero Length Packet (ZLP) after sending
or receiving an NTB of exactly 16384 bytes (tx_max).

According to the MBIM specification, devices do not require a ZLP
if the NTB size is exactly dwNtbOutMaxSize. However, the cdc_mbim
driver defaults to sending ZLPs for devices not explicitly whitelisted
to accommodate non-conformant hardware. This default behavior breaks
the strictly conformant MeiG SRM821 module.

Add this device to the ZLP conformance whitelist (cdc_mbim_info) so
the driver will pad the NTB to avoid sending ZLPs, preventing the
device firmware from crashing.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
---
 drivers/net/usb/cdc_mbim.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 877fb0ed7d3d..bf3e6af7d7c9 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -631,6 +631,10 @@ static const struct usb_device_id mbim_devs[] = {
 	  .driver_info = (unsigned long)&cdc_mbim_info,
 	},
 	/* ZLP conformance whitelist: All Ericsson MBIM devices */
+	/* MeiG Smart SRM821 ZLP conformance */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d53, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
+	  .driver_info = (unsigned long)&cdc_mbim_info,
+	},
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bdb, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
 	  .driver_info = (unsigned long)&cdc_mbim_info,
 	},
-- 
2.43.7


Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E003BE646
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275643; cv=none; b=Z3CQBLTuJxlUXCDcthV/xdXkoH2W0pheDM/Id2fL2zM0LTw8+gczrNEucef7DfdHJGMdV0BwYuAO81kodpxnyOyDuaVkOIV8DCxX7JnZISKnMu6hbFxyhi1yYLmnHFAH1oMJ6TJieMIgNzH0HKZNbRr8RNGzIDDpv2ArG0fnGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275643; c=relaxed/simple;
	bh=L+2PIl9c91cGPKqFh5rawFvpSlD16Mcp4ipH690q0yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMeHxiet6WEl1umC+JEk22JS3n02GWQ6kycmqUD23PQFmrfQy8k/ro0iEeVd/rUJXv0ShRInZBmm22k0UArDvkCMxa5EaQd87uMGY8Os+NMMCbwSANLMoDYRetijbjKfqs3C2xpPp2RxSxQ5JKuzufRmdA5gm7VvNtZNbDr7Ocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVq0Iacr; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVq0Iacr"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb64371a2aso2556828a34.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784275641; x=1784880441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUD8b/O4I8LwhV5Q1VRQ5q+jG0xHp0fGcr6yD3Cz0hU=;
        b=cVq0IacrErL/Zb/LfUZklGwsbXFjfjXseBYZkhQJ4m5/Xe5NpHOQg8o9Y3QG6tCvju
         y3AD6G2lIEIFutgEbWFlitiL9MdeKo9yvslvPpIbCLS5fROPD4ogYYF3YarxE648aKTR
         SW7p0FFvzN8Ua1udnJ3f6tEsZzQtomGgB0pSqpEssfTkI6gPfzCbM55gUoSTWP4WKKm4
         QccO2h08jRuxXfEpjrnQqygIucaqk4hFzlw4FALuT/torxoN6lu/ZtUVNxoONzCl1gX4
         u+9RIWppcUa+pUOJvqwPLff/4np+mLAAdVJTZNk6XnXcB4r/OgwAGw3Vfrmg0xNIzOCX
         f+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784275641; x=1784880441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUD8b/O4I8LwhV5Q1VRQ5q+jG0xHp0fGcr6yD3Cz0hU=;
        b=A918ZROQZcNMDGolqolHVyk6pM6Z//CL0vR713+5S7rnzavsV2jCO2kOQM27wKtqXt
         qfAPSX6xOPKsE7bMzl6uDI0n97XMiDG3swPt4lzqFUDBUvxG9Xju1YQP3gy8PrsXUH5b
         0EsQ8MqDNlylKJ89kmcRxU4cM1Q88lIsKy7TGWU3Ax4FbieM21FT2G3e2JSv1qXqySR1
         R1hgLkHxqWL+YR3LT7U4sHg7Woncos6eMWH8muorxShEkO2op6Vf8SAa+Gtm4hMgTlqW
         vQ9yiBqlATCNW0nuD40cSLmbPysPiQ0RfIEelxbQfrVEhiDwCp/spw6PbBcyoEXhMsuu
         aRVg==
X-Forwarded-Encrypted: i=1; AHgh+RptOYQRN/ehsDaAve2fd8WD/AORTqM8dIZk+MoBXZNmt9oqGRrlRUd84qoyBAgOSJplZ5JQcUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jSyRGC147TXHKG2W9h7XK2aewlDcM0TzDVMX3hQa1GxNA8tD
	JA7oJtUuBODsM5s4nJ/0u2cw1oSohpa8L3QihCPZXTJ8257ScBLjsSOH
X-Gm-Gg: AfdE7cns0J5vYH1QrLD1JD9UemkY4kOqGLbyGK8G9RmwhE356n8m8h37jQ7kOCCY8k8
	KbQfOhtKliT/LdK9yf05uW3G+8gTvxHx3+qc4veaqthftQ2LoPDChIU51/w39PD8VoGipnFlRP4
	C+g7HH1XUxPNqySRYruNZROXsAZBQw9fPsJxG/SGucXr6NZ2RYHgdXUCL6m6VNitmoZFvFDnMgq
	dzgc+i1za7rWNK2/P2MTLx9umix4HQjR4lH8fAEKeRi223AZHmpEXvz3Y1j/hVenAol1sdpcK/o
	J979S0bzlASY3Jz7qPPVedj/WbBSPs/yM/EI5fVJer2Sy52ef4Sy7KBmXt8qM2u8IUS+ISDMUny
	Jsow1nvpeRrSSoYiZkTVdn9NTyX3mr2m9k3FfdeEOwxojeByJfMMGRVvaWZW+NnjOUzsy6hEYzk
	sTH3BW3ephuG0Y
X-Received: by 2002:a05:6820:1523:b0:6a3:f5e9:8e45 with SMTP id 006d021491bc7-6a53669164emr611027eaf.1.1784275640951;
        Fri, 17 Jul 2026 01:07:20 -0700 (PDT)
Received: from capidev ([2806:264:548c:900d:4433:c2f3:888d:435c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568da4ab47sm923890fac.0.2026.07.17.01.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:07:20 -0700 (PDT)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: Matthieu CASTET <castet.matthieu@free.fr>,
	Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Chas Williams <3chas3@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>,
	syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com
Subject: [PATCH] usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect
Date: Fri, 17 Jul 2026 02:07:04 -0600
Message-ID: <20260717080704.1264-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus: Norton (VPS 260717-0, 16/7/2026), Outbound message
X-Antivirus-Status: Clean

uea_probe() distinguishes a pre-firmware device from a post-firmware one
using the USB id (UEA_IS_PREFIRM()), and stores a different object as the
interface data in each case: a 'struct completion' for a pre-firmware
device (to be waited on in .disconnect()), or a 'struct usbatm_data' for a
post-firmware one.

uea_disconnect() instead tells the two apart by the number of interfaces
of the active configuration (a pre-firmware device exposes a single
interface, ADI930 has 2 and eagle has 3), and casts the interface data
accordingly.

Because the two handlers use different criteria, a crafted device that
advertises a pre-firmware id together with a multi-interface descriptor
(or a post-firmware id with a single interface) makes them disagree: the
small 'struct completion' stored by uea_probe() is then passed to
usbatm_usb_disconnect(), which casts it to 'struct usbatm_data' and takes
instance->serialize, reading past the end of the allocation:

  BUG: KASAN: slab-out-of-bounds in __mutex_lock+0x152a/0x1b80
  Read of size 8 at addr ffff8880470e2c60 by task kworker/1:2/982
  ...
   __mutex_lock+0x152a/0x1b80
   usbatm_usb_disconnect+0x70/0x820
   uea_disconnect+0x133/0x2c0
   usb_unbind_interface+0x1dd/0x9e0
  ...
  which belongs to the cache kmalloc-96 of size 96
  The buggy address is located 0 bytes to the right of
   allocated 96-byte region [ffff8880470e2c00, ffff8880470e2c60)

Reject such inconsistent descriptors in uea_probe() so that both handlers
always make the same pre/post-firmware decision.

Reported-by: syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e62a973f8322b3bbe3ac
Fixes: e2674dfbed8a ("usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
 drivers/usb/atm/ueagle-atm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 4e71ed679a76..4266a0cb7e3b 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -2549,6 +2549,7 @@ static struct usbatm_driver uea_usbatm_driver = {
 static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *usb = interface_to_usbdev(intf);
+	bool single_iface = usb->config->desc.bNumInterfaces == 1;
 	int ret;
 
 	uea_dbg(usb, "ADSL device found with vid (%#X) pid (%#X) Rev (%#X): %s\n",
@@ -2557,6 +2558,22 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		le16_to_cpu(usb->descriptor.bcdDevice),
 		chip_name[UEA_CHIP_VERSION(id)]);
 
+	/*
+	 * uea_probe() decides between the pre-firmware and post-firmware case
+	 * from the USB id and stores a different object as interface data in
+	 * each case: a struct completion for a pre-firmware device, a struct
+	 * usbatm_data for a post-firmware one. uea_disconnect() instead tells
+	 * the two apart by the number of interfaces (a pre-firmware device
+	 * exposes a single interface, ADI930 has 2 and eagle has 3). A crafted
+	 * device advertising a pre-firmware id together with a multi-interface
+	 * descriptor (or the other way around) makes the two disagree, so that
+	 * usbatm_usb_disconnect() treats the small completion object as a
+	 * struct usbatm_data and reads out of bounds. Reject such inconsistent
+	 * descriptors so both paths make the same decision.
+	 */
+	if (UEA_IS_PREFIRM(id) != single_iface)
+		return -ENODEV;
+
 	usb_reset_device(usb);
 
 	if (UEA_IS_PREFIRM(id)) {
-- 
2.43.0


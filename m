Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844498;
	b=PC2YUmBEcMxrkvg5UbjwhM3IklG++CTTQ6Q6+DXgR0mMXyMkpz20cMutM3dfTybVyqj6
	 V7OexqevCUHAcuXlrg6EAh5BXjVuhoP+X3Sopq0Fk+rXmOM09XfHsA8/4JXYM6+H1PPVW
	 3zOMpGxl8W4an4hLh/ec+YAigJ81AmV8JMZBAry+OXnw2GGdIUzevy+NokwumdTF8X3Kj
	 wik96JNlLdudBhxvUB0ruF9FOYZd2M2Rb+8dDlq8pQtB8xsZTXtCEkeJaY94XHASUSJ3+
	 diLqDYglRlF7hNyuR9gWdbaa2qmY1a5n9oLIyUpl1qfNXCeEhJqVkg+juX+qR+D/Zhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jqt0c/lDmpmJvJHzNqMywlimWKbXZGChu8Ayeo3lkSc=;
	b=M1t1apEQopx1Pz7LWZNQBd9Sta60iK3ea5lGtvyMlYuGkbLiyjABSaELQJB7OtP0aMP+
	 uc1+453B4p9BFWk6xbyE3uyqVR4ALVfc6yzF0HNwM6gw6Ig+PW5GnkAwIsgWa8RygHjPH
	 1fZMLbkkPkxJlaFR9yoj74ub8saK+GttmcesPUsTt1Eqr9zuSwg0NQ7CgyCXQhsiqsRkb
	 tkRZWJ1lktnIlIrrEEyVxwHS53TwCy3FaelK2FqkzkT7zJ+qVngFEfUGF/x2BTo7EXH9V
	 NxC2gY6fkcPXxdEIHvenEW1BVdnRyZEccWUMM0rRxoWmHtgJNY4S1UNy5q61wGufZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="o6ca/lm6";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E223606A31B
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 12:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E223606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o6ca/lm6
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-170135e43c7so1824863c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844497; x=1793449297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jqt0c/lDmpmJvJHzNqMywlimWKbXZGChu8Ayeo3lkSc=;
        b=o6ca/lm6V4UU6dl/RTS33waZdfKti64hPX9pDpIVPS9Ntr95n85UNLonAKVQ48RuVA
         lo43EdWq2izqtWowWq7T5w03Nhwj6NsN/QTMybG1ZQ9JhGl7dTPBX4CGhgcA7BHYGE82
         qGjz15hZUutPNjYyidHcV7lGHOotCXy6ZZT6b8QDiwFaLiLSWSclcPopx6luMSuVdEmF
         SIxhZjD87d85IbLFcaTt+TAc0yzeC9YovYGRu9CUm1XhU5eVL1k5J0Iq8FppMVzVDAs+
         4mulrH9CJ9o+xbkJ2BnJshn65Tdn8gL3jhlmScebyZ/Eo2cCXMqwWLe3rsWjygZGuZzj
         VeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844497; x=1793449297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jqt0c/lDmpmJvJHzNqMywlimWKbXZGChu8Ayeo3lkSc=;
        b=djnT/NzYtqC/8edmdAbgOtr4zYRYCmQx6eR8Gj+UeDaXZCwKwn+zZQbuGPGC0z6ayV
         QTSTZmAohv+PHEBR4MB5aGnkA7Z5vEbZHc8RNRHpjz8725gBgir3xiv5u9xmE6tSWvTY
         XLdpm+AuvPTBHhhaQeisQ7S+yiBKPr4R70LY9ptf7KMnQDzE6aJKCaSe2jg0odq02cSA
         QmSzQRUVwlGJfu2h/Z7M10u1MZM94RcsxDec8Z2RtgMxcDoDK0AyDdPbITzBiitW3tme
         Jrqf8rXVunGSMJryyh1cbYyvxkKxCrNYmA7gXJq9MzVw1fADolu1GSQtHTqdj6u6ljat
         ojqg==
X-Forwarded-Encrypted: i=1; AKwUvByHYQOMoOBpda4dL/Jl2nH8qkgLgaO7aJL3UnYElZh0t3YdT9bkEKAOzYO6jVBZXcE6OtD0Tc0=@vger.kernel.org
X-Gm-Message-State: AFq9FYID7h7zXCkfLFnBcz6JkhMc4eq4IQeZ2EZDPVrUZzjTOIs9niU7
	GlGr8rW5faH4YkF+4BeeS4GBQxTdkRDa5PI+U6Zi7rJWjoKyvs90aoGr
X-Gm-Gg: AYBFou2bpdpIuCCEPqZqOcbrXkcTjxMpI+pkS+dhcrAuW004ShI+lieNVLUZ3s+/ggR
	UsUjeP1T9xTLjVo9dgPJcthvN6BtRsRpP6xWZ6pmJByKgpvnmKTodkvJwl+6T7o92kt52r7Gdzo
	VmUUf7z55Ckn387UI+tfOsUpeFy0JXLHUgb22Gp6mCYL8bA9kG2Tslgqt1HLgKylhZVLNrdrsuY
	UdF0BeUUGSsAXQ3ywjhQx3xFSU0/IQKsgc55w1YDxMU9F2PvnjncvaHw5bSOvP3gw3vip9RpLqx
	fiJENZfpD7JyT9dSiQzYvM4deoAQ7XS2XRMMGqOnXJy4bygV6TCRLTWlnST6UvQFpslrm07RQov
	Q3HoSGQs3ikoTFOKJp1VYI/Or44HrGw8FXRAi6mOGNbVJTKvUk9N81iKBbFOYU88h+Q6ShFqmVA
	yxOke1FAMQ+cyRZHCKFkF8FPTU8GQvNpzmtCqqmC3IpUkIUcEC8bXe5WaWolclGaKQ1fvppE9eF
	oNMEcq8Nf0ATxGFdgsTJaI51HDO6pvBDzudP9rTYByYvyKrZgMXrWHGQtsA2YuhgBxiXLqPptmR
	sQGsLG/y/25NI6OIg5M=
X-Received: by 2002:a05:701b:2501:b0:163:8b44:902c with SMTP id a92af1059eb24-199374f457cmr2427790c88.17.1792844496879;
        Sat, 24 Oct 2026 05:21:36 -0700 (PDT)
Received: from SAJV1N5.lan ([2401:4900:b9a5:d1e4:f9f6:478:606d:146c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm8559529c88.6.2026.10.24.05.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:21:36 -0700 (PDT)
From: Divyanshu Jha <divyanshuj2006@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	netdev@vger.kernel.org
Cc: Divyanshu Jha <divyanshuj2006@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org (open list:USB CDC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: usb: cdc_ncm: add Apple Silicon MacBook Air (05ac:1903) device ID
Date: Sat, 24 Oct 2026 17:50:51 +0530
Message-ID: <20261024122051.14427-1-divyanshuj2006@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The Apple Silicon MacBook Air exposes a CDC-NCM interface (05ac:1903)
when connected host-to-host over USB-C.

The device tested is an Apple MacBook Air (13-inch, M1, 2020), Model A2337
(MacBookAir10,1) with an Apple M1 chip. Unlike
commit a5148bc2fa27 ("net: usb: cdc_ncm: add Apple Mac USB-C direct networking quirk")
which hypothesized all Apple Silicon Macs share PID 0x1905 ("Mac"), this
M1 MacBook Air exposes PID 0x1903 with iProduct string "MacBook Air".

Like other Apple CDC-NCM peripherals (0x1902 and 0x1905), Apple's
firmware omits the CDC status interrupt endpoint. This causes the
standard cdc_ncm probe to fail with a missing endpoint error:

  cdc_ncm 1-7:1.0: bind() failure
  cdc_ncm: probe of 1-7:1.0 failed with error -22

Add device ID 05ac:1903 to cdc_devs binding to
apple_private_interface_info so the driver bypasses the interrupt
check and initializes host-to-host networking successfully:

  cdc_ncm 1-7:1.0 usb0: register 'cdc_ncm' at usb-...,
  CDC NCM (Apple Private), ...

Relevant 'lsusb -v' descriptor output:

  Device Descriptor:
    bcdUSB               2.10
    idVendor           0x05ac Apple, Inc.
    idProduct          0x1903 MacBook Air
    bcdDevice           10.01
    iManufacturer           1 Apple Inc.
    iProduct                2 MacBook Air
    Configuration Descriptor:
      Interface Descriptor:
        bInterfaceNumber        0
        bInterfaceClass         2 Communications
        bInterfaceSubClass     13 CDC NCM
        bNumEndpoints           0
      Interface Descriptor:
        bInterfaceNumber        1
        bInterfaceClass        10 CDC Data
        bNumEndpoints           2
      Interface Descriptor:
        bInterfaceNumber        2
        bInterfaceClass         2 Communications
        bInterfaceSubClass     13 CDC NCM
        bNumEndpoints           0
      Interface Descriptor:
        bInterfaceNumber        3
        bInterfaceClass        10 CDC Data
        bNumEndpoints           2

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Divyanshu Jha <divyanshuj2006@gmail.com>
---
v1 -> v2:
- Retarget from net-next to net.
- Clarify hardware model (MacBook Air M1 2020, A2337) and contrast with
  commit a5148bc2fa27.
- Add 'lsusb -v' descriptor output and dmesg failure/success logs.
- Fix typo in commit message: cdc_ncm_devs -> cdc_devs.
- Add Reviewed-by tag from Nicolai Buchwitz.
- Link to v1: https://lore.kernel.org/netdev/20261023070419.235361-1-divyanshuj2006@gmail.com/

 drivers/net/usb/cdc_ncm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3e4a..6848b9421137 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2019,6 +2019,12 @@ static const struct usb_device_id cdc_devs[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1902, 2),
 		.driver_info = (unsigned long)&apple_private_interface_info,
 	},
+	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1903, 0),
+		.driver_info = (unsigned long)&apple_private_interface_info,
+	},
+	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1903, 2),
+		.driver_info = (unsigned long)&apple_private_interface_info,
+	},
 	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1905, 0),
 		.driver_info = (unsigned long)&apple_private_interface_info,
 	},
-- 
2.47.3


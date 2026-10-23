Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739070;
	b=EpIW09Q4LhK7ht6G1a2A6mLbELdyVnWkjEgjfjaeGW7X7S2kV/As/z7N1DmCuOOKiICp
	 RZb2jH265CgFM0KcVMbrr0PWTb9wSAYhOpyfSf/fqkDWGhV8GCE/wHcbnPHDhSxcBuZuI
	 hPPDK+FmwHqZdIKQ3b3JFzQiyvZqLP5WhKbGp8bgl2f4eo+SAbb10i/wGlymed38VBGGM
	 sbnNgfKAnxZv2wHjdReokvN1GFpHG6TjJimjvMPvyH6OBJpsCVSUG6VmvV3c3mcs1Kmdv
	 PgTlPsHznwPdeRQir4GCk+mELSFt9yR5MgpuFHwCR+M1b5XvRqd6NhKfsF5oFUzbS7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qG5b3GBAm10vBf9IK+PFH6C3j46v3ALudwzqDcSeLhk=;
	b=5aPeIzYccmYYxRTtQj+brPG2tjYXqEIWaMSCrNy70jmNB6O+daywUlMCccheYG+mD5xc
	 Ge79wpkSe04v1WASn+MSdKnTrJS7FgGf6AVEPy5yXicEtfMLxydekdjNct+lB/EZLk1v1
	 1rY5QexriGXsJEQu+kgkXO2yIN37ZimC3TigP284jTHmF5rOnnAwmUYYmj6Z84HzVRJUa
	 uH8re8ql2k3GauJxplMksom+SPioUEmCg7owckG8G7Yst9Nf9TYjwqe5tbnTo14K3umUj
	 2P2aeTVFcwJriIowhyveMIWXe1jGS80DGFgOdF8WUHMRd76xdgg45jmau5NLmHcxnVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgiCm4CB;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1D606A31E
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED1D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgiCm4CB
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so1375889eec.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739068; x=1793343868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qG5b3GBAm10vBf9IK+PFH6C3j46v3ALudwzqDcSeLhk=;
        b=HgiCm4CB/WS6pRw2SWQIvkZ1zLtaW1GUKFazHOhdwUgfMlbe/K+ehi8yZssfpEPqaa
         7aqJUyj1cDGLrh5U9k4dkSALQFRC7I5q42ZpvyIz4f69htYbNxp04eKUKtamPx1DBj+v
         M+l2WR4CdWV2bv2AR85rgzE8nG7XWJKlgTuJRvXZQh7HqW+IJs4nsYC2AwHzrfp3qUH/
         qIQw3eNXPkBVV/IEpTErqIqt+nEHeE9VoO/dLaCps+nlgU3yQICyx6HDL6T/LHXxmbt8
         c5VOIveoku6z6YZCoD1Kxkh2q/xMXmgRxNqJ6MzPGLecUHiYLJX52h1hZ7Wv7Kf/kQve
         gsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739068; x=1793343868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qG5b3GBAm10vBf9IK+PFH6C3j46v3ALudwzqDcSeLhk=;
        b=IIJQWFTHUA5DECYOUGAUEW165Lvq6GJcSWuow+TbPUdQuEeZXevcqexEatldqx5cBN
         uPZcGFPspPs4qigmcroiNP8GIaZV8rkuicj5rZQ+hTJrw0ysXEvsYLDC4jbsIYg+IvG8
         0uOix587bh9HrIP78rDgpQFja+XPpSt5XXAFE4ntkqC1/HU14dFIqTTRErsKEi8ePTjO
         NDfiwD7H7Yt23a9V1wlf1aVvffI+6sXN0As2Z+2YFs1IGMebAKgscM438rhn5n+eZhb7
         2VcqAjeOirSS9UoTaOvL3Lw6u/B9XP+d4NrKT0OucwFirLxbbi95Lh45U644pbhacqCu
         8AWw==
X-Forwarded-Encrypted: i=1; AKwUvBz2YN+wbR42kv9KQIsKRm0ShUpPBioM+1KmSNKoXPL3acwlTOWE6Gbeo7P4wrOsqyB6wrdIvFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR/tXaVNLPt0AgVpcBTIGAEl36h02Bi0ekNroUO3RAIaQPMjX+
	+8U1R5oEfBF2pOn8OPVnc+GxA5WXBkXYweeqDtI8ZFrM/saeI9kUSZqV
X-Gm-Gg: AYBFou3BVhzPIETYdAw/SMCgD0bcVV0Ctk/K+uPkRIhzFbU8b8k5I2FPhrVfXjMLANH
	OP/R+YGHUukhvznZeMlrvdzpplaFdltO6t42G3henpgTJ06/erCNhrdyAquEmSmX6DYaH4oTn56
	zJ78MOgL882SuQsMLwPrgsrNB7jmvjV1DRWlhEIGYX/Mm3J0HMTPyYgDPOH1pDz5/crOLbZT4Ml
	S2F4gxPPRD/iemLtOwisFuyHAIS6kJZ54nS5ld/TR0n45UkeFXIpN0Fomi/DmjKgmGXRXtOrdsN
	5Mv9gCGjMsnnqJ/JfR7E2DFFW+CI4YkkCSlFaEsKEN0WM5xejaJ+yySJxaiAeib2aifq8dbm3Jx
	iuXV5ursMw9aA6OrWV6SZjrMfBEFFjqwKvJo9n6fWR8Uhgt3kG5LEeicDRiY/QHXWKOnzsnIzML
	cOl0EidTLZmmfeMmThYmepV537GIqjMxF8w30ZAOkXzcNLrt1Dn9jmGpMZ7t1ukSTQflK/331Rx
	iJK97jjOM1dfT+TJqtU0sP7lxiaNB4R5N3OUsnsHetrEQtLqht/bSeiRToUZLDe9r8JS200QdSX
	FnwiCpbRtrVHvdjL9TKE69ctenZXyg/Hwc8m2Q==
X-Received: by 2002:a05:7301:f8d:b0:35a:7020:c08a with SMTP id 5a478bee46e88-369d976cd6amr2105063eec.19.1792739068048;
        Fri, 23 Oct 2026 00:04:28 -0700 (PDT)
Received: from SAJV1N5.lan ([14.139.240.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9de33acsm4764472eec.20.2026.10.23.00.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:04:27 -0700 (PDT)
From: Divyanshu Jha <divyanshuj2006@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Divyanshu Jha <divyanshuj2006@gmail.com>
Subject: [PATCH net-next] net: usb: cdc_ncm: add Apple Silicon MacBook Air (05ac:1903) device ID
Date: Fri, 23 Oct 2026 12:34:19 +0530
Message-ID: <20261023070419.235361-1-divyanshuj2006@gmail.com>
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

Like other Apple CDC-NCM peripherals (0x1902 and 0x1905), Apple's
firmware omits the CDC status interrupt endpoint. This causes the
standard cdc_ncm probe to fail with a missing endpoint error.

Add device ID 05ac:1903 to cdc_ncm_devs binding to
apple_private_interface_info so the driver bypasses the interrupt
check and initializes host-to-host networking successfully.

Signed-off-by: Divyanshu Jha <divyanshuj2006@gmail.com>
---
 drivers/net/usb/cdc_ncm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3..6848b9421 100644
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


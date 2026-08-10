Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEB39BFEC
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357747; cv=none; b=UfdG6yLYR+ltZgKSQ1+20O/27Girc7ka98T0oSab7vg7Ed1PmE+UX3JDS0SohJN6V2uyR3w+0NEfA6y177jc1tphuDvVpN1AWbl7rDHF3IbJp0LX15MrUqEK55CmfEGi3/kNGrp4wJs3r9bzpNcIx3Bus704cegwoitagMWCFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357747; c=relaxed/simple;
	bh=lABGybqrOfA/5F7rLlcKuLSPW3KayZdePUYNTXr1NxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXiadCs+9o5jTLLXjOW9Dk9j5D3I0xabOoUiIyGbqu047LADRWo3aUXf2y6tn5VmDm6aeuuziYyM+zHUIreP/fhR/7Gy9cx2+1sSTBKoRAHvfBJoeKOGMwtZYboT9tb+nQ2cr8oD5MOgYHL5oFkN74X6vTZD/8UX9jLBu/289Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF2s0QrM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF2s0QrM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so15285725e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 03:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786357744; x=1786962544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=boYBSecBRl5T+XjjQzpMdytsU7Qux9bXP/GDQdqKxko=;
        b=EF2s0QrMvqJp+DGhV7+6GXGOqn+fgRztAa5UaKpx4plfuEa4uoP7bK9/Whuvl1PNSu
         fexBfiw3JAbGdKxNVFDnGteW6ImhIK6hnLWhUEcV4c/8v0+h4CAD8dK+uPHtd3ZQKUAI
         1NJ9xjdXt3FVyVKedVwsrxQoTZ2HNY3TvmSEqBzhbHCp0SlE6V11GiOcCMi2iRQAtmsz
         huauI67W0qJVsFcDt16JJoXqeHJ6HSlVzkjGVYoB7wIKkaPTYUhxArz6DOaX7p+4hcfW
         Im+wTAH8JHSPu9fcDJvo3lPRdSn0OmLqrN+La2J/ZpaDWZLajIJHVF/dymQHjelafq7G
         k67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357744; x=1786962544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boYBSecBRl5T+XjjQzpMdytsU7Qux9bXP/GDQdqKxko=;
        b=NYt9vkFVExTjEwBQcTmD+4na9+fyit3MvK6wrarxWF6WZ7juVC1onScYSrTBEUurw3
         I4WM7tieDkBXpkHDLUqDEXA2Z/Q+dHzKRaeiQ5/D1wByhM/0SK7c+J9Hmz+B/oFj4FQF
         sOJkUfFOmLTS5M8JPGANLNSncgEwo1nC6GxjfM8a3RjA7Y5TCabJtk/68iw51rbiWZz4
         wUoNjkLKMLdwOaJD3Q9h3iafcXgxvtZV4TAEWRUEMwEDZlT1H3WugO2GXt2mRNJskeLE
         nMlbPpDfXWICXk7vEAA1SXwAzok69ZAPVQPbbarIMY5JLEmR9mxMsSj4Vc03HKI0HrEX
         csqg==
X-Forwarded-Encrypted: i=1; AHgh+RqifhLnWFJEemmWni9YobV0QdV3GkmrK5dwXbBSBJHFf2/eTzCJF7cNLAY0Y/4ZoB90Y6euJxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN78/dcp/fz2UtLnu3OFBFiM4iM6ZIRjFhMIfeDIw2mvj2zdxr
	z/zX7okPjWsIybNZchpjGA4HY2Kwzr5dU50r/G/AX0ctRYGydPTr0YSy
X-Gm-Gg: AR+sD12N6V4QjT/R3z/oHu7s3YjXNgsXDlRsbhhNIKqklYj0Cj9tHLdGAXAootZvwfp
	M41m/kujSUvE9pO9nvFYOHuyNImxvqT/8uS9mHf/hYjKR9q9FxNFJ6PyKjv11zG9OiZVYgMo7oa
	pV4A9mjZY2nkjfZG/TrWaRF8r9BeVsbKntkc8wyK6Gq9emEglPocro3YIQ+zUSMVcEyI/GkBTEo
	MygXw7FDo53tsYteVw8h4z4uRdXzcvU/KHCoZIlYnQiVGuZOa8CkDtYCgmBz0Es449FsK5oy6yr
	wBv09NSULk4EpQrDifzz830vTIMhF1DuWSM0Al7UhHSKTER5ld5YB9cI6uzts9IyMAKc5anuazS
	/x4Cq72BkgD5h6gaD8rh4QheAxB9MAR48G6AjCrTSbeUjKcNPIEDsRyUa2ynt5dCTr1iSn/SzwH
	SHBly4MeZtX39g+ARKOMOl1STI2178ZQDhnoLtn5dZ5X4vmCygcnHAJV7wFs0arvMIiXQzeK1QH
	4cTZogXIsCj2hInYMYALUe6O+xQrowodAeZRI3JbvtqNRWesn6JquQFdywTKivw4WvUDLu5LC56
	cAvS
X-Received: by 2002:a05:600c:4f45:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49972764ed2mr11353955e9.5.1786357743613;
        Mon, 10 Aug 2026 03:29:03 -0700 (PDT)
Received: from labdl-itc-sw01.tmt.telital.com ([2a01:7d0:4800:7:a04:488a:882a:de93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27ec7sm297309075e9.10.2026.08.10.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:29:02 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
Date: Mon, 10 Aug 2026 12:28:40 +0200
Message-ID: <20260810102840.125473-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the followin Telit Cinterion FE990D50 composition:

0x0991: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
        tty (diag) + ADPL + adb
T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#= 10 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=0991 Rev=06.06
S:  Manufacturer=Telit Cinterion
S:  Product=FE990
S:  SerialNumber=2aa802d2
C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 94cdb61dca83..147beaa61340 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1360,6 +1360,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x0991, 0)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
-- 
2.55.0


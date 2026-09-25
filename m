Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84149CF21
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.253.228.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342111; cv=none; b=B9D8n+MO2QCk3vqoHl9Zkh6aD2G4pQFCezpP3D5lBKKGDvQPWYiBaS0kz4mV3e+eDJWNx2AeNRpO0taS/TdLGOd9oAB92eNVXpY5NoubdkAXm8Te4/c0sd+do9UTJoV5oxiXF0euwUjjN/NvgB+YdICALIz+ye1aXOCP9JcOj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342111; c=relaxed/simple;
	bh=ynu9tlkmX6+koFl+QN1myO6jZFCV4lPFmhslwQkneqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oWYkkGv/DAhY6N41ksMWjUh5fAIBg9tN9As9TvygFnABqnYT+hcDmWnUXCW/ag5znl5vfpr85pb2s3YNC3l3RcEcgWvkE+IOC1su+1IQbDjOI/MaLS1ovXH2KTSwJGkjzeUAjoxTSjeCHImbr9nrnl5ZM5HuP02Td0ywaDRO7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arcor.de; spf=pass smtp.mailfrom=arcor.de; dkim=pass (1024-bit key) header.d=arcor.de header.i=@arcor.de header.b=LBIwXvOR; arc=none smtp.client-ip=145.253.228.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arcor.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arcor.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arcor.de header.i=@arcor.de header.b="LBIwXvOR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
	s=vfde-mb-mr2-23sep; t=1790342096;
	bh=XXk8BUKGmmAYZCiVAGhKqgFCbzl5t8bvdzpz2UrzU/s=;
	h=Date:From:To:Subject:Message-ID:Content-Type:From;
	b=LBIwXvORkwSP3gAD3vmQSY5fvBxxOJAsakHj8rqU6o3eirmvcfAqhcWV01xp4NJaM
	 RmXklfJRd50VEKVDPo9Evok/Sw5ui3pOmCWTnBS+vl0qVckvrtivAv3R/wHt5WHFDr
	 YH92HJVG75pPwE+M2q+JBTId1XDw7kZTqNK0ykZg=
Received: from smtp.vodafone.de (unknown [10.5.0.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4hrrlh2b6Dz3sHpx;
	Fri, 25 Sep 2026 13:14:56 +0000 (UTC)
Received: from arcor.de (p5b281a72.dip0.t-ipconnect.de [91.40.26.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4hrrlX6BtnzB2sP;
	Fri, 25 Sep 2026 13:14:45 +0000 (UTC)
Date: Fri, 25 Sep 2026 15:14:32 +0200
From: Reinhard Speyerer <rspmn@arcor.de>
To: bjorn@mork.no
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net: usb: qmi_wwan: add Rolling Wireless RN947R
Message-ID: <arZzuOOvLUZtdOlv@arcor.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-purgate-server: smtpa01
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2359
X-purgate-ID: 155817::1790342092-4E857030-30A84AB8/0/0

Add Rolling Wireless RN947R 0x9300 composition:

DIAG + ADB + NMEA + MODEM + RMNET + QDSS + ADPL

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=33f8 ProdID=9300 Rev= 0.00
S:  Manufacturer=Rolling Wireless
S:  Product=RN947R
S:  SerialNumber=xxxxxxxxxxx
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#=21 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#=22 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Reinhard Speyerer <rspmn@arcor.de>
---
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index f51cf9cb9421..b36a2258d8ac 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1454,6 +1454,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1312, 4)},	/* u-blox LARA-R6 01B */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
+	{QMI_QUIRK_SET_DTR(0x33f8, 0x9300, 8)}, /* Rolling RN947R RMNET */
 	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
 	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d63, 0)}, /* MeiG SRM813Q w/ Modem(PPP) */
 	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d64, 0)}, /* MeiG SRM813Q w/ NMEA */

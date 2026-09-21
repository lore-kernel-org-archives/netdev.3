Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05E49553A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983272; cv=none; b=IdGPPwhnaaQQ7epaJgeWFz9XyCtryCuZQ8Dl6cVS1K1Lww1OUzqKLiDQHNTV2nbbgWD4orZGSF+ESPm8fAndpUp7IUoRmfvOO4mi6TcSGpt1w/6mr9qmDujzUITrGddc+Uz926Fda1nzmci5gKg8xlCJx8MNALAXoJeXWUCubpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983272; c=relaxed/simple;
	bh=VDiVxS02UvU/DeJ8GhMZFJd8KjufYlSoVNBbS5euGuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/l6DUrvCz1pYSPWhY6+CIIB21a0iUi2kv5NXyHfPR0Uf6xAFiqrfswYVM7qviUnrhR+AgnOYT2PNF68Z3oyrgNjcpAsfF9tv8bdWScz30sAgSWghz3z+d9S5uBo8d/BGcCX9Ql4ijKU6/dh1t1U/cj4M9lmKY9RB4e7wPcm+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cErvDhFi; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cErvDhFi"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so14085975e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983268; x=1790588068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KHp+jegDUOX55mRyFE6554e6Msr1rJ/McOVQlrwyHvk=;
        b=cErvDhFigGfdKbiuM902L2yLXhtvophUV6V86cIt370TA85fqwObN4OtTMphrvkkF2
         i2yTyY75Rra4AEggTDKDi28tB56S73ymEY/wb508Bqmff1a8l+Ygjo+HMgCXifnUA1FD
         Gt/Nl+4X3e2BZClF8ruWEPQHL/egOFssbKfJtfP4t+treMaSGSL96IuTQiHSeF+350zU
         YNvB+Vf8juSd3W3mJdg9NDgJ8WHIzqnNbJZ4+jvVv45V93RsaSeVs4JjMuwBtyicRAi0
         gOl7SwJjlWVLGtLRZTVWC6IXGogbpWs1IfGLub/RtdY1PalnivH3JYZ2NTEZbg2HDWaS
         X+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983268; x=1790588068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KHp+jegDUOX55mRyFE6554e6Msr1rJ/McOVQlrwyHvk=;
        b=Md+UQ48FT9PksiT+aO9EZH1EPreIVeLevY5g7nPN5CjgDabYmDBb9Yze1tDKqXaSop
         K/TFHU5ZfQTXhQhEqkrNXptfxon5JSxYlft0qbvE0k34kyQxHwk8+uKk5qwWQBz9SPKo
         jZivZS9mqqVJu7ba/8KGyHCMC+5X16Pe7HaNgTGsfwzi17Nvkm1pADhnIttrFbVV85fv
         4UVZLXkS2YjtvfBuFv+KonIuvP3oZbkt8Qc8lA+Zt8Z1hEy7UKtxZyRKE8KBXyBg6JLO
         HXL7lYR9/exYlgvbRJNQH452WyPHMnhP82uvkQ1an95lt9MxV1VrVbwaT5DVR3Ng22ag
         Wv0Q==
X-Gm-Message-State: AFuF++k30qbp0R3qMSbeE40+pBhrmbLlaY+aQFzfgtJNlGYZLAj5Bh7F
	LUs/U5fl2MWqQ7L5t1V9tXtf2BVVwjNIUg3VY3vU/mksyzR5qIh49YT2
X-Gm-Gg: AYBFou0vzf6DLmOWU72d73nWW3fQRxtLdQJVzR8YFvDxqNoa9T7KkJGZsvVZLGK8U6t
	rdUgHzkMSDsi6VqzviPrWYLa3P49wjDAdRikhsBcfPkIDzV5kvQE5gAAamurAL7BWEuBFEgQBQa
	JyUyE3SOQzf6BPJ5pKBHZmK49y/KbQQmlj7F88TfyVnE7gU+15rxKyBe4xBC5O9BdS1/NHZHWSY
	X0kBIgB0v4vn1gEP+e89u9uKsZkAhJkw87liPuzt2Svas+56QcJHZ/9qm5t8xgRCxxUrPksNPqS
	4XYbeXgj7J+Fo4Fc2naJAPUZcBUAw8r3NTFJTjKfzby/ZQGB1UgdInVNmeoNcJsff1uxp+1269u
	hN19eRQVQZz9VYyBHJOuvJpIc83fd4avjAnrj+siDYVH5s/HnwBi6w5nt7caqbFgtIn11QLRimq
	2WG3OT60I5djg9LBqH4OdQhgJo9wlF6jihIIQuuzV/5JlPbjrp55sxemd+Zh5s9r+L9CY7K96y1
	F3sPv/vJazPZNO3rFZ3aE6vwd1NKc4Dk1U8D+Gdxjafje4=
X-Received: by 2002:a05:600c:c16a:b0:49f:ce78:356e with SMTP id 5b1f17b1804b1-49fce7836b0mr85310405e9.31.1789983267863;
        Mon, 21 Sep 2026 02:34:27 -0700 (PDT)
Received: from gil-endeavour.hs.rfd0.com (bl10-2-111.dsl.telepac.pt. [85.243.2.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcce144b1sm351916195e9.0.2026.09.21.02.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:34:27 -0700 (PDT)
From: Gilberto Conde <gilbertorconde@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next] net: usb: qmi_wwan: add Quectel EG120K-EA
Date: Mon, 21 Sep 2026 10:34:26 +0100
Message-ID: <20260921093426.2870266-1-gilbertorconde@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Quectel EG120K-EA LTE Cat.12 module (USB ID
2c7c:030b). Its QMI interface (interface 4) uses class/subclass/protocol
ff/ff/ff like the other recent Quectel modules, so match it the same way.

The product ID is shared with the EM060K, which the option driver
already knows and uses to claim the serial interfaces. Without a
qmi_wwan entry the data interface is left unbound.

Tested on a GL.iNet GL-X2000, where the module is soldered down and
enumerates at SuperSpeed: cdc-wdm0 and wwan0 appear and ModemManager
brings up a data session.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2c7c ProdID=030b Rev= 5.04
S:  Manufacturer=Quectel
S:  Product=EG120K-EA
S:  SerialNumber=45546267
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#=12 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
E:  Ad=89(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Gilberto Conde <gilbertorconde@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 13a5e72059..f8b771dcc9 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1086,6 +1086,7 @@ static const struct usb_device_id products[] = {
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x013d)},	/* Quectel RG660QB */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0306)},	/* Quectel EP06/EG06/EM06 */
+	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x030b)},	/* Quectel EM060K/EG120K-EA */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0512)},	/* Quectel EG12/EM12 */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0620)},	/* Quectel EM160R-GL */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0800)},	/* Quectel RM500Q-GL */
-- 
2.55.0


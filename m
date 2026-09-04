Received: from mail.jetone.com.tw (mail.arestech.com.tw [210.61.96.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2925B091;
	Fri,  4 Sep 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.96.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509014; cv=none; b=Ww2VtMLcOa5bbDB0eY/cmBfYze6sTKw5jFGQDZtoniKCGhpvGkG2M3WYgJ4hHktxL8Hy4sxk+H+L6EFgR7zIAC/d7DtQo9O5SLCUFZWOtpQcMEHHmxlMIz3cegV8ihPy8LDOTlQG4uVPQqbEbYbLzQRwLP4HpQDvnJD2ljgA+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509014; c=relaxed/simple;
	bh=Fx74hJ8BwQx9E4bzaJqfH8OvmWl5PYxwnYjwP45bS9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPfrq435ySFJxmF9ie3nMdK+Iihtv8aO7wuDDlgdIS/1q9/6QCCIW/+r60WjY5AocGKWAaxfLmS///lWcEoDOQrx4rgIYzffUrKbpjD2PJ/eFC3D/pZjGRpjXQ6zn4kwkpW5g7Slelk/qlvoeANfJnYOd9xQ0EOZz9xNgYIQdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jetone.com.tw; spf=pass smtp.mailfrom=jetone.com.tw; arc=none smtp.client-ip=210.61.96.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jetone.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetone.com.tw
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6847vtTpB3290923, This message is accepted by code: ctloc85258
Received: from mail.jetone.local ([192.168.0.53])
	by mail.jetone.com.tw (8.15.2/3.29/5.94) with ESMTP id 6847vtTpB3290923;
	Fri, 4 Sep 2026 15:57:55 +0800
Received: from ian-lin-DREAMBOOK-PRO-14V.jetone.local (192.168.0.137) by
 VM-EX2019.JETONE.LOCAL (192.168.0.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 4 Sep 2026 15:57:54 +0800
From: Ian Lin <ian.lin@jetone.com.tw>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: usb: qmi_wwan: add Compal EXC-T1 support
Date: Fri, 4 Sep 2026 15:57:41 +0800
Message-ID: <20260904075741.55778-1-ian.lin@jetone.com.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VM-EX2019.JETONE.LOCAL (192.168.0.53) To
 VM-EX2019.JETONE.LOCAL (192.168.0.53)

The Compal EXC-T1 is a Qualcomm MDM9207-based LTE modem which reports
"EXC-x1" as its USB product string. It exposes its QMI function on
interface 5.

Add a fixed-interface match for the QMI function.

Tested on a Compal EXC-T1 modem using an Ubuntu kernel build. Interface
5 bound to qmi_wwan and exposed cdc-wdm2 and wwan1.

Assisted-by: Codex:GPT-5
Signed-off-by: Ian Lin <ian.lin@jetone.com.tw>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index fdfdcf24d..bb9493006 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1446,6 +1446,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0316, 3)},	/* Quectel RG255C */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0112, 0)},	/* Fibocom FG132 */
+	{QMI_FIXED_INTF(0x04b7, 0x4d22, 5)},	/* Compal EXC-T1 */
 	{QMI_QUIRK_SET_DTR(0x04b7, 0x8217, 8)},	/* Compal EXM-G1x */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/

base-commit: 6ebcf5074cff0402730c6981d2397139fee6322d
-- 
2.43.0


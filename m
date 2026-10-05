Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A793876D5
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233533; cv=none; b=QjzGxvy/fB+x33HZ9YIO14k4rRp/bCw9CCxFwSUQrm0bh5XVfj9auBb0WcuRvMDn0wsdw5M3umnyoF6a3+yBQYfeMKrinpQmepIJvLj+nf1JevQj0980CoaORJs9PD5PgBuXI/IAeQH73OIPlCdVjK6FwRA6RA0no2TiPexBglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233533; c=relaxed/simple;
	bh=giNYsJQLixxH/tn3pTRwaEN7a4MZGpONgq1VDU5ZWDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCC2WDVWuh1djAlrux3OfUtXQW+2Yt5m2a5Vhan3GuxeMMz0DWcgn4Ujl2DizcN7ARCXkUVHy+m1VFv59EbkjaltVOoge9udf3h0Cka1Xpzf/BNy/yIJD1ZhVCx0/L5Br1V6rcCMnetS/DValHhNk1YkRq4BS9yA6M8LqLAUV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZIrve9Cp; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZIrve9Cp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791233522; x=1791492722;
	bh=giNYsJQLixxH/tn3pTRwaEN7a4MZGpONgq1VDU5ZWDo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZIrve9Cpum9TvdO3zwWi/zIKbFZESM1CIWRg+EIsiIu2WUtBwOL0XrdIMrVUwFTsw
	 4brbtmoTPF/MD5oCvTRaYDKhRAb2jAim0SoLyMKFNu75Gz4Y6/XWIfllEOnm8ipYlp
	 /Di5osgyh8FCgM14A7OVrtBpoIzb9HKTC/uvKShwqj3vTvUY9QRpoEO+cRklYS+jWz
	 +Wia9VGqJKpduTxQToBbCfQyHLY0EwMgAmSUe4mciN8tgh5Qr2YUIuDiqqn1CQSEId
	 dhQ4aW50Ig/cDq22CYgKETsdd+SHApC5qo5hgI3dweH3FJJBrDhS+0KEyHbwcxQrAg
	 YSQkWJvWTqAsQ==
Date: Mon, 05 Oct 2026 20:51:56 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>, Tim auf der Landwehr <tadl-git@taufderl.de>
Subject: [PATCH v5 3/4] nfc: st-nci: map proprietary RF protocol 0x90 to MIFARE
Message-ID: <20261005-fp5-st21nfcd-v5-v5-3-7be15a86c61c@proton.me>
In-Reply-To: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
References: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: b8f02c33da1be7e1224d50c41ddd260cf240caf6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Tim auf der Landwehr <tadl-git@taufderl.de>

ST21NFCD reports MIFARE Classic with proprietary RF protocol 0x90
(a Classic 4K, and a Classic 1K on the Fairphone 5). That value is
not an NFC Forum protocol. st_nci_get_rfprotocol() returned 0 for it,
and nci_add_new_protocol() then drops the tag.

Map 0x90 to NFC_PROTO_MIFARE_MASK. ISO15693 (0x83) is unchanged.

Signed-off-by: Tim auf der Landwehr <tadl-git@taufderl.de>
Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
 drivers/nfc/st-nci/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index d7802434a..d83221566 100644
--- a/drivers/nfc/st-nci/core.c
+++ b/drivers/nfc/st-nci/core.c
@@ -15,6 +15,12 @@
 #define DRIVER_DESC "NCI NFC driver for ST_NCI"
=20
 #define ST_NCI1_X_PROPRIETARY_ISO15693 0x83
+/*
+ * Proprietary RF protocol the controller reports for MIFARE Classic.
+ * Not an NFC Forum protocol, so it must be mapped here or
+ * nci_add_new_protocol drops the tag.
+ */
+#define ST_NCI1_X_PROPRIETARY_MIFARE 0x90
=20
 static int st_nci_init(struct nci_dev *ndev)
 {
@@ -76,8 +82,14 @@ static int st_nci_send(struct nci_dev *ndev, struct sk_b=
uff *skb)
 static __u32 st_nci_get_rfprotocol(struct nci_dev *ndev,
 =09=09=09=09=09 __u8 rf_protocol)
 {
-=09return rf_protocol =3D=3D ST_NCI1_X_PROPRIETARY_ISO15693 ?
-=09=09NFC_PROTO_ISO15693_MASK : 0;
+=09switch (rf_protocol) {
+=09case ST_NCI1_X_PROPRIETARY_ISO15693:
+=09=09return NFC_PROTO_ISO15693_MASK;
+=09case ST_NCI1_X_PROPRIETARY_MIFARE:
+=09=09return NFC_PROTO_MIFARE_MASK;
+=09default:
+=09=09return 0;
+=09}
 }
=20
 static int st_nci_prop_rsp_packet(struct nci_dev *ndev,

--=20
2.55.0



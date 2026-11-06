Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.32.148.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003539;
	b=y/Rv9GlaaU2oP/MGTxsN9EtVtPwVJtEh5YV47oCPcNwm8wg22HzFBZedtDSQY0IXTJ0k
	 tIAVb/kM9tu3bGegIHhE6FJNMEn6mqSkg1up8Q+xQnZHsMPaSsTBjKzfQo/7WJGq9nCTJ
	 Fe0WrPg3jRsSNzPTbc1/1/1QEEZR2CAJgN2DcZUUvmWLmNDyCFUFSwrrYoidNLqLgxuIr
	 cwOm9C3FhaSsAFKNnwzmG49zGiOhdL2ayOxi6a4vjZShfP6Mx28lIPyrq4z5hJ0gybHr3
	 mCu/tiC0vuuN6mDjqjHBcNZ/NcVwjnK2/H0YrCT517urn5KuuWAsc2L8h6GRq/OIDog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003539;
	h=DMARC-Filter:DKIM-Signature:Message-Id:Feedback-ID:To:Cc:
	 Origin-messageId:List-Unsubscribe-Post:From:List-Unsubscribe:
	 X-CSA-Complaints:X-Mailin-EID:Date:Subject:X-sib-id:Mime-Version:
	 Content-Transfer-Encoding:X-Mailer:X-Last-Tls-Session-Version:
	 Received:Dkim-Signature;
	bh=R6n0aYpkmHjIgahCRbhjVhsZJsulzyuC2Atz+IY4FEI=;
	b=bYz6KH8DVro7Cs5/a6wFdSP6LWTC4EozCb+GKo0TJXfGGjr1t4YzpzDzuiHo6Rm6Wsh9
	 qSVyvtkTAvmqn+wPa9BeihadI53unidGA1yKOPr6ktvWyP7+kdMMPGqf6hQ1T5M5d81cX
	 zc4GQ7WnDey1S5sBIx6RBsG1+Xykcxx3sqccEkBeYEPdiJKxRE/gArOEGe9E6dipctHd4
	 KLEjaXmNVMKToqg8Q+lSQt+v9KVnBhd1y3HT83yOM1aeP4mcrOBYx6r1IgNSJ5GMdK1za
	 bhKvWGLKo9OMsyMFsZLyZRnEmwLXUAyw4sAdAlLE7ZuZjAwDEp5Iz3B5SKSu9fVXr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=romitsagu.com;
	spf=pass smtp.mailfrom=hp.d.sender-sib.com;
	dkim=pass header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=brevo1 header.b=mQo11e2q;
	dkim=fail reason="signature verification failed" header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=dkim header.b=LeBoK3iV;
	arc=none smtp.remote-ip=77.32.148.42
Received: from hp.d.sender-sib.com (hp.d.sender-sib.com [77.32.148.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17E606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 22:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D17E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=romitsagu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=brevo1 header.b=mQo11e2q;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=dkim header.b=LeBoK3iV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romitsagu.com;
 q=dns/txt; s=brevo1; bh=R6n0aYpkmHjIgahCRbhjVhsZJsulzyuC2Atz+IY4FEI=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=mQo11e2qI6dsASFKO7LVZXtlXGU4rAluxJvr/dzkGLG5C4/fIw403K8GHPV8s4OjMTCmvfkoUB/x
        5rHb3Y2nYCBK8wmQvoa/qGUdsvWMHUrwNl5fR9K9A+dyFdf58CknhiVCCooL9t3Drwi4F0NK99RG
        kfl81/fy7dEVksres1040f5tWFeg/Sq/uI2k57f+nwwwfguR3wUqPqFW0CIQ8MWGCO3dxrhcf90O
        fcpYd84p1QXKOuKuqv3EXkbEzYUPSh93F/3AxxysN+/y6tcQuKG7bdh/bOeX75p8GTTskOF9vH43
        T8BZHnsliIIRU/CANv7/0pRzPqyiIXs8QFtYUA==
Message-Id: <20261106221836.3445-1-romit@romitsagu.com>
Feedback-ID: 77.32.148.42:7631162_-1:7631162:Sendinblue
To: <netdev@vger.kernel.org>
Cc: <linux@armlinux.org.uk>,  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,  <davem@davemloft.net>,  <edumazet@kernel.org>,  <kuba@kernel.org>,  <pabeni@redhat.com>,  <linux-kernel@vger.kernel.org>,  "Romit Sagu" <romit@romitsagu.com>
Origin-messageId: <20261106221836.3445-1-romit@romitsagu.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: "Romit Sagu" <romit@romitsagu.com>
X-CSA-Complaints: csa-complaints@eco.de
X-Mailin-EID: MjY5NTA4NDE4fm5ldGRldkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYxMTA2MjIxODM2LjM0NDUtMS1yb21pdEByb21pdHNhZ3UuY29tPn5ocC5kLnNlbmRlci1zaWIuY29t
Date: Fri,  6 Nov 2026 22:18:29 +0000
Subject: [PATCH net-next v2] net: sfp: add quirk for OEM SFP+ONU-XGSPON
X-sib-id: Eiscf88Pb9CjizbiPhS8kk5dXggeWRSOgvo-cRvynN-nP8yOyNDWmJmPT1V54kbyQV_G4ZHw-skX2jheBTGLM6Jx8ogDE2a4xFJoNxg7sVHJqEDT7P4u239WzQyGxiGNunOlogPkF6kbn_WhlvOQTKI2u3mn53UKYNh5pdE_e2b07pyu
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.43.0
X-Last-Tls-Session-Version: TLSv1.3
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DE4F4063A; Fri,  6 Nov 2026 17:18:41 -0500 (EST)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romitsagu.com; s=dkim; t=1794003529; h=from:subject:date:message-id:to:cc:mime-version: content-transfer-encoding; bh=Xlywh/A5GtLCtifpFseekBFA0sryMULQdDy/KRtRFDA=; b=LeBoK3iV5UQvZCnPfFKbKBR8QkqZDoLVXUbJ/vCydngFGoSxzUu0oT1eICvM0OlR1Pa45Q PAIFTCIVMNK5MTAdzHNNipnwERs7ZlwXJxrk2zVS2Xyb0MVs2ZG6Ujau2Y+PyHumkZdp90 FU0DrCWZVa129R5pGgei4sBjAua31JQZzFFs0DH5VCuKMU6+xwvw40R7NI2ZGB/mpyQvy2 dlE4jaGpRQrNdnJE2iToMpdyPFz5bQN/awKvmVoWRt7P1SKTQdWIgabK60ErIts4c+cvdw q8/GZTX/KQn8ldMou4I7WspT9oJD5sY41jzkTFxAnNN8y8NAKVpTZYasEB5ZmA==


This XGS-PON ONU stick (vendor OEM, part SFP+ONU-XGSPON)
needs the same handling as other Potron-based modules. Without it,
the module fails to connect and the kernal shows these errors:
sfp sfp1: module transmit fault indicated
sfp sfp1: module persistently indicates fault, disabling

This module requires TX_FAULT/LOS behaviour and boot delay tuning.
Add a quirk using the existing sfp_fixup_potron.

Signed-off-by: Romit Sagu <romit@romitsagu.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2:
- Move the new quirk to be better sorted alphabetically within the
  OEM section and next to another XGS-PON ONT (requested by Jakub Kicinski)
- Added LOS in the quirk comment (recommended by Sashiko)

v1: https://lore.kernel.org/all/20261103011849.181392-1-romit@romitsagu.com=
/

---
 drivers/net/phy/sfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 85e57a16bb52..915156743701 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -638,6 +638,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
=20
+	// OEM SFP+ONU-XGSPON is a XGS-PON ONT stick with broken TX_FAULT and
+	// LOS indicators and slow startup, just like potron.
+	SFP_QUIRK_F("OEM", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM XGSPONST2001 is an XGS-PON ONT stick with broken TX_FAULT and
 	// LOS indicators and slow startup, just like potron. On cold
 	// power-up the EEPROM vendor PN field reads back with non-printable
--=20
2.43.0



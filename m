Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.32.148.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668755;
	b=x0iAdEHsjcDQU7tpBHrCjOPH5LWqv9VmQNF7FABffsiwGu9rin7MYaK9YHcB42s4J3Nj
	 0u2dO9ay0m0fMxDGxujv2U6Kjv5WTlhjg0iAU6BdfYm0YowEWQB39MVzFG4qBICJNT69V
	 /sZ15MgQDTL9kCuCnS7MNsxtMY+ah55k0wIVBAfh6x7XtLjg8NhQyKqqneMvggtZvgNGI
	 mD4cZ2ExyAYcuGcV6lIlylpu7b3Hzzy8jevecrYTDM3DofH2XzgoNoxZ+PaXDzRz75ZSe
	 3snbi/CQJg4k9kCWNTFwvNJ65JK35E3vaZCKNz//4/i+CUOV0qYUbSEYjcU36CAmf3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668755;
	h=DMARC-Filter:DKIM-Signature:X-Mailin-EID:Date:Subject:X-sib-id:Cc:
	 Message-Id:Origin-messageId:List-Unsubscribe:X-CSA-Complaints:To:
	 List-Unsubscribe-Post:Feedback-ID:From:X-Mailer:
	 Content-Transfer-Encoding:Received:Dkim-Signature:Mime-Version:
	 X-Last-Tls-Session-Version;
	bh=Gn4weV70A0Qeh7+Puy6JMegQUP+4k09ZOvQ35EPxVyk=;
	b=fFH2blp+nU5DF9KPsUK4iJSOoPzQQC7jK9ZLtehygcC+xItKZFbNbxD5F8hpT/AKpCKf
	 +ka1XBxYoqWgMobUODtyOq1+L4s77Xs1Lyn2jH9AGFwuQJsNEaiekU+GXvvf7rcu5Ghdx
	 niLqV1GFjA8cPD8lbBJnV6hDKG1cXzSDAs01at/c7zJlWkG12ivgnTxjdatDQfhEm0Rnl
	 o2FmXx2W/6fXNok6hlX5KDKV61egRajVQwgijpUaXESs7ndybdqt01CXFva7zHuVcONsO
	 meiPXtn9evb6DFKnuHZr3Ti4yHx5RYj3SsuXCyg+s0z0XWpvpxJQ3JefbZrdDEl8hjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=romitsagu.com;
	spf=pass smtp.mailfrom=hp.d.sender-sib.com;
	dkim=pass header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=brevo1 header.b=pryEUBuR;
	dkim=fail reason="signature verification failed" header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=dkim header.b=sHem1Tjr;
	arc=none smtp.remote-ip=77.32.148.42
Received: from hp.d.sender-sib.com (hp.d.sender-sib.com [77.32.148.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13B606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A13B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=romitsagu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=brevo1 header.b=pryEUBuR;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=romitsagu.com header.i=@romitsagu.com header.a=rsa-sha256 header.s=dkim header.b=sHem1Tjr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romitsagu.com;
 q=dns/txt; s=brevo1; bh=Gn4weV70A0Qeh7+Puy6JMegQUP+4k09ZOvQ35EPxVyk=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=pryEUBuR5+mY9+aTsV52gnfeDPhkfUTOZ+3GKYJlXIj7aQ3rgPPLZptLaubpgaxznI4rj+KnI3/m
        x0nJeo5928vwJqQYnVQrQNjX99DtWDp14FGtWNVmeYcDXu9Igq0ybdLLJsYsvvHTiCvAeL52BSaQ
        4TDzG2qLzGu9/X51za4V0e4O97Hqu7I2u0J6WEjl2PIIgLOMJSLnoyJmQgxq39U5TRUM97kLT4wK
        d8jRzRNqk4oz3RLgqENpuk9XmYBihb1bD1hDE0jZQHIxcGGfO4Qr4KrT2BYVHnIIpup9z/4zXjaq
        AD1zKOYwGi/UNswwxNp5LMXcUJ48TJe1iYagXg==
X-Mailin-EID: MjY5NTA4NDE4fm5ldGRldkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYxMTAzMDExODQ5LjE4MTM5Mi0xLXJvbWl0QHJvbWl0c2FndS5jb20%2BfmhwLmQuc2VuZGVyLXNpYi5jb20%3D
Date: Tue,  3 Nov 2026 01:18:42 +0000
Subject: [PATCH] [PATCH net-next] net: sfp: add quirk for OEM SFP+ONU-XGSPON
X-sib-id: eaatN49NkHJFtIG1QN0dpL0-v8G-hyJe9YggpXjIN1awLp6pmvGHpcQS62JyoVA0yJksQACjMDXwxMuytmAVZDI_9zD1yQFYNlvqr9Hu8RsU58ejChiNE0eJ3TRNDhlCE9IepykGEbKaudEbisprPJTz_KpqgHgHyxZ50l0yW3YZUWLN
Cc: <linux@armlinux.org.uk>,  <andrew@lunn.ch>,  <hkallweit1@gmail.com>,  <davem@davemloft.net>,  <edumazet@kernel.org>,  <kuba@kernel.org>,  <pabeni@redhat.com>,  <linux-kernel@vger.kernel.org>,  "Romit Sagu" <romit@romitsagu.com>
Message-Id: <20261103011849.181392-1-romit@romitsagu.com>
Origin-messageId: <20261103011849.181392-1-romit@romitsagu.com>
X-CSA-Complaints: csa-complaints@eco.de
To: <netdev@vger.kernel.org>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.42:7631162_-1:7631162:Sendinblue
From: "Romit Sagu" <romit@romitsagu.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7305040ED3; Mon,  2 Nov 2026 20:18:55 -0500 (EST)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romitsagu.com; s=dkim; t=1793668743; h=from:subject:date:message-id:to:cc:mime-version: content-transfer-encoding; bh=XahXTocY6unirklQewQrX7+/b8GZtqO6bUbLqyn7YOs=; b=sHem1Tjr9k31yBK0gtCGToTV4RpiVHksnmD3b1CB84pK8w6aDmDkiQk/0aDyEZTogvPg40 fn/XnVvTcX5gU8PLHFowa+hTaCXnITfjtpr7x2WtfxyIVMYEtuASLun5jn+DAX1RqtFWXE 3N4j2EHY2KSg9NRpZYKq+MdR5UI06LIXuqGgOQ4qgwQkdg2mzx2UpKDgKqCBQzPeyGBgtA gO7+w+4Rh1/CJ525wT3IzTRrvdCKSshVAUk/xey/eCnoupLh8A7Oxtl4TlR2eBG/W6m7OQ iFrlhV7GdM3bqv8NrbNt1yEWzncH/32IGXReJygeQAbb1giDi+oA1BooKvmb2w==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Last-Tls-Session-Version: TLSv1.3


This XGS-PON ONU stick (vendor OEM, part SFP+ONU-XGSPON)
needs the same handling as other Potron-based modules. Without it,
the module fails to connect and the kernal shows these errors:
sfp sfp1: module transmit fault indicated
sfp sfp1: module persistently indicates fault, disabling

This module requires TX_FAULT/LOS behaviour and boot delay tuning.
Add a quirk using the existing sfp_fixup_potron.

Signed-off-by: Romit Sagu <romit@romitsagu.com>
---
 drivers/net/phy/sfp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 85e57a16bb52..9435b25b54c9 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -623,6 +623,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
=20
 	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
=20
+	// OEM SFP+ONU-XGSPON is a XGS-PON ONT stick with broken TX_FAULT
+	// and slow startup, just like potron.
+	SFP_QUIRK_F("OEM", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// HORACO HC-10GE-113C uses Rollball protocol to talk to the PHY.
 	SFP_QUIRK_F("OEM", "HC-10GE-113C", sfp_fixup_rollball),
=20
--=20
2.43.0



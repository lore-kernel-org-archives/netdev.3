Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023140;
	b=caPnII5SgIVB/flxoein1WVoBhW9NRMRUF74Mud2MowNiHGTufFW6v2/cNpNRpKPvqQB
	 FG55GyHHQhlpRdQq8xw4aNJRMHbqfQngb9OBYTqu5r5QJLyjhZye+Vuzyt3P/43eVwtiK
	 3YtWL0OSnLRGbcISSRECflpU7MP3ZVI/ReEFjuxChMVzasabeSmQECiwpf40SkqHmohHh
	 JAQJYV95+NAM47sga4S4mShA4FZ4TTyJCnzYDnj1TzV27GlxqDwDONno+RXG3dSq++JqD
	 lj/Qp+IN7XxRlbEUZVvv6YdSKcszdgby1w794zVf4k7HrxrBKmPJoFFWaSpufQKI0BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023140;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=vTDWR4Av6DYB2fTr3K9DQEAWzrajqn487d3krJjj0o8=;
	b=h5mF/vZhHUIYrCqTgqCEy1ZaMBmP68rae3O9m38YkL9ylKxhMbUep5CsK7fDLFapLjIq
	 KCXgKt+/1WYfuiNNU8D//pPwuavHX59v22kWDe75e/E+a5CcDR8MdhStgaJxUSbDN6mQh
	 aJuvRSQzjO93fM+XwAoDJSbyJSboqxC4Y0YoNOIRotXMUXpQ/oSpcxZ1G7T3O9ZhsifZ4
	 R/i5xQ16ZXw8TFXZFk4Yl5sg3nCo95yxPLFpyOyQjF8SZiRg2h9unZC22XZ3eUPCWaVyT
	 GoG31rGm+4BaPjuK0mmFdDwP6Q8oH6LGtkR6yKcjRE2CwPaA1/9wZ8imv7prypy+S+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=martin.ostertag@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YrE0L1V3;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5422606A31D;
	Mon, 26 Oct 2026 13:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5422606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=martin.ostertag@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YrE0L1V3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1793023128; x=1793627928; i=martin.ostertag@gmx.de;
	bh=vTDWR4Av6DYB2fTr3K9DQEAWzrajqn487d3krJjj0o8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YrE0L1V3viLF1HR/KjVM1F57sDDGe1DOZQkem4fg0eFJvonCYsuAsU92hzl+gMO2
	 6OV7GpdzTf9Ky/A+jpKQz+JH4Io/4uKtKwdzTBg6iskFyTsJeR3VrgUHxkC3qPwmO
	 91B9LvjQUf45+HP0Tje6OnJ18M/3QelSRG7//7fbYF22b6VErZ6Vdz6WfJMr3c7zx
	 Prz3nD/QMnNYIxbmh05/nI8hLXS8iTrV35Aff4ijRbHXWLrfbQdmqA+sjWh3YB1qM
	 h0OUnVSbkkfxISMaaT675uhp5wEHk/0ZREnz80z4q+y4exjfLIN0h3SCMK3Vqs+cz
	 GHsrUIeQH2mxNNwTzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1xGNPG0ZMo-007UOu; Mon, 26
 Oct 2026 14:58:48 +0100
Received: from perseus.lan (perseus.lan [192.168.2.182])
	by blackhole.local (Postfix) with ESMTP id E7F26122;
	Mon, 26 Oct 2026 14:58:45 +0100 (CET)
From: Martin Ostertag <martin.ostertag@gmx.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Ostertag <martin.ostertag@gmx.de>
Subject: [PATCH net-next] net: sfp: add quirk for ZYXEL PMG3000-D20B
Date: Mon, 26 Oct 2026 14:57:57 +0100
Message-ID: <20261026135757.100139-1-martin.ostertag@gmx.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TyQMohkcJlD5zDeCq3PDYXRSdUwsNQFRlM65IvnaWd/UqHKdXNl
 utlb06EkDFOYzcEr4ARKOXLscuHyqMjj3ZXlgUGraLEX6vHdkJkOBOEv5Cd/8flMZHLujp4
 mdM7TGfvBpv817YO4uYaeIJ9Z3uuLZJEvee6SSjh9tEyYNsn04C0xtYtkdF5xjwNkNZ3Nmt
 w3hxksEe6XDowYvYKzB3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DXWbX+l0tFc=;My8x0xTEQj78RX3CngBhqRmhX/O
 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
 p0JOmiWrDhefAMt1DS0XacLVxGwfG1SK

The ZYXEL PMG3000-D20B GPON SFP module reports LOS and TX_FAULT in a
way that prevents the SFP state machine from initialising it. Its
EEPROM also advertises autonegotiation support although the module does
not implement it, and the module needs about 60 seconds before it is
ready.

Ignore LOS and TX_FAULT, disable the advertised autonegotiation and use
T_START_UP_BAD_GPON as the wait time before the module is assumed to be
initialised.

Tested with a ZYXEL PMG3000-D20B in an SFP cage.

Signed-off-by: Martin Ostertag <martin.ostertag@gmx.de>
=2D--
 drivers/net/phy/sfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 85e57a1..578d4d8 100644
=2D-- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -472,6 +472,18 @@ static void sfp_fixup_potron(struct sfp *sfp)
 	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
=20
+static void sfp_fixup_zyxel(struct sfp *sfp)
+{
+	/*
+	 * The LOS and TX_FAULT signals are not usable on this module, so
+	 * ignore them. It also needs about 60s to become ready. Use
+	 * module_t_wait, as module_t_start_up is not evaluated when
+	 * TX_FAULT is ignored.
+	 */
+	sfp_fixup_ignore_tx_fault_and_los(sfp);
+	sfp->module_t_wait =3D T_START_UP_BAD_GPON;
+}
+
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
@@ -654,6 +666,10 @@ static const struct sfp_quirk sfp_quirks[] =3D {
 	SFP_QUIRK_F("XikeStor", "SKT-2.5G-100M", sfp_fixup_xikestor_2_5g),
=20
 	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+
+	/* The module advertises autonegotiation it does not support. */
+	SFP_QUIRK("ZYXEL", "PMG3000-D20B", sfp_quirk_disable_autoneg,
+		  sfp_fixup_zyxel),
 };
=20
 static size_t sfp_strlen(const char *str, size_t maxlen)
=2D-=20
2.56.0


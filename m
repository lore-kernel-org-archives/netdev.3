Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65C363C74;
	Fri, 31 Jul 2026 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478485; cv=none; b=AfRR8Z+tIW1lBDnRvnZoDBqG1yshemfQvZM+osHBdFTGqJ8geQXzSYxklM+tGdk7Ne0Ydk5vomSJD0w/8j87vDm6zV4hCPC1nqk4mpib7UcE6wgQLoGBy/nTu5TwF7rZsfsxMIKdo2gjEzxCjdKPm5XEdvbK4puPoocU6RaimsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478485; c=relaxed/simple;
	bh=atvf+AsuBnzffDwfwJ29qn2L06KJZTBxknpsPAQdTbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk08V5xi1fJQZ3nUv2462iUeTx7myb5cxQIg9niQCxvnZDVW622Ct0reJnVkm5EXMBmUAsNgfmsqH2VbvVTFND3DdjUR9RVwTG5s64S58539AxFG2eBdT87sXKPyYLE/frPZBbrRwlJoVRpsowC0bCZhaSnqRz7gvcYAhpbEthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=J+Dzq2oh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="J+Dzq2oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785478457; x=1786083257;
	i=markus.stockhausen@gmx.de;
	bh=C0FthCe6pfn/9WIbcCv7S7vlwPyKw8h3KbE2dpZz/IY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J+Dzq2ohJUN/EXVPVxBk8DsKaqrFEWRFYbb6bQZNfR8ivHkgPyiiyaRRyt8Mjlj1
	 gpvlUFeuDcinGLjjGk7sCXQjZ6F3V4+tJsenD38lPgvY0muRdo6tLGsfMf/TvGYGb
	 1X+cr2ryVpmLq0qGtVe6loVLn+rXWwqJwT9GNx+woKrRK9cnPi6k11SV4y9BNUNs+
	 Cu7NI+ZlCwNO4e28a64aGd0MA+MkE6Tq5wRBwiEqmAkcvAYcgR+uDzxv3eKCQD4oi
	 odpb54N5lo/M+PPuOvB/KG8icIiXaaCxrmTTY2QDBSH6XJpYDDfVwDuIwWxxnfSrL
	 8BmkWVzv6JqjuM67mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1wzD0F1xKc-0120nP; Fri, 31
 Jul 2026 08:14:17 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v10 10/10] net: mdio: reword MDIO_REALTEK_RTL9300 Kconfig
Date: Fri, 31 Jul 2026 08:14:00 +0200
Message-ID: <20260731061400.78301-11-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731061400.78301-1-markus.stockhausen@gmx.de>
References: <20260731061400.78301-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YUC5lRcg8db71q6SCrwc06aGyYeOl1AwEiZkkhCv9F6xiUoXlIK
 j+wULPYhSTPxAa8P7u8gA62AAJEBitx45i/TcCiZJLN/J3aSar006v2XPFzpBze95rqdlKb
 Ufr0J5XGc0D1Tl0jDMqw3hHuLNLbFdTj8sLYBAB5biQeOe5uFJhPqaMCdH1sWdy8GJdZ/mE
 cTjOssEu1laVH4AZdl8Ig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SVFYfzY0Nzc=;qRwgXh4+UvtrSs6WBpYQnDPMGz4
 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
 nYNan9cwmCBt7/7rsshBkLgG3qvUuGLGwkX1ct4kSpfzQolbAJeHnZXPxwvII0WD7m581BKKk
 OF8ToeQX/88NQXfWqeB0FRtYnP5qeU/+oM36GAu9uVhs+L3SF7ufS0J6Zj6VBun/XzZbh3JKJ
 yBgCK/lAPgYKkGRvPpe482C/8PGJ4lAib6jJcb2N/KYRJKOsTq9dypZU2Bbcob8bZc2O+HPTy
 lBJz31oN/NIrMsOTqhCj2kNFY/zpoVPbdZcX62BHUdauuwb7rfwgucAU71uqFV+seBhhOaNbw
 jX8fYevSWWwXMzbELeC4MsgRg6YLDlnZvBugM/iDiNe+gZm13Rc2XWZHovkdiAlQn8oBW7ld0
 1IgzjLbXV6rS2jhs//N9ZPz8qEXNWX08N7j1RJS3ZZ/UggRKcFKoPQRNDXTY1ZpYd7sLkwOvm
 AnsPexUvrI4DFy8hE7rcX1Xk66qJEcKG3o7aGSLS92r8T+Gm7hn/60+c/jWGBAQFYRw0DrAwV
 NzyKlMfC/7NXvJ9uyE2yJqMpv9+YSY4e1bkT/w9blOfPqTxH6LU1qgkj/eVyjo3OMy1Irrggs
 sDf+w4h0MsVfcw5ao8x8b6vxLe03NhXiHmVe2ELUfLJhiv+lkkUfhPKwrrYtRR04394GmHmPG
 Qnh0cJ96t4Qdj6zu1hbtTVD2uJvZk45XD9OihbLFa1M8V3WYwAlyTheoCAoucx56lF0joyq4L
 StTAsIUD0ptliFqT1FwQqdQAjt5tZgg2ZmiBBngocFb5E3PjrUwf4dF52c63MCydpyhdBgofi
 OWYN76kxC9iqnbDquvVGSY8wzdaS2KgdrlSvbmBivWriGB/vBwK1u09QHg4Gufw/1qaGpjLV5
 mm8a7XpHDXKm5PwCO0v9NMWoCt/0/tcPs6vkcN33ksjP80nPk4/vG8JaOsZL7Jo4NKybSCny7
 kyxPwET5nNKU

The Realtek MDIO driver has been enhanced to support multiple devices
from the RTL83xx/RTL93xx series. Reword Kconfig accordingly.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index a05229838cb4..d44278f26fab 100644
=2D-- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -172,11 +172,11 @@ config MDIO_IPQ8064
 	  interface units of the IPQ8064 SoC
=20
 config MDIO_REALTEK_RTL9300
-	tristate "Realtek RTL9300 MDIO interface support"
+	tristate "Realtek RTL83xx/RTL93xx MDIO interface support"
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
 	help
 	  This driver supports the MDIO interface found in the Realtek
-	  RTL9300 family of Ethernet switches with integrated SoC.
+	  RTL83xx/RTL93xx family of Ethernet switches with integrated SoC.
=20
 config MDIO_REGMAP
 	tristate
=2D-=20
2.55.0


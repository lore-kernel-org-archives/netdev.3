Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5C31B833;
	Thu, 10 Sep 2026 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008675; cv=none; b=n26dPbJt4t6DVOhRzvln6LQ+kdiNV1wNOTyoR8KgwbYKFaMrtOj/kgfcXWlMAl1jlzMDRaAZ9644k4VqXlN4ROzrCsKJT4KrHhuOZKDKTSdFRHqp+mD+shRD35LZUJuV4Jp3ihlS1tc6iVcsLeshn3bLiXwPSe79um6/wWZz9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008675; c=relaxed/simple;
	bh=cVcxK1aiMRaKU8cfLvr37sclf8jE31MtyL0jNm9Hjhc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=caxGn5ainX5ro73my4ngWhD531LSHySkhpt6J3C3c6ONFYXI6954rsUBXkHrX/lI9bE72YCZRYysiFHq0bWyv9mFHsuUZ/KmaapohEi9wpiQ0rNuf+QwcFP35aSknWzR0hlnP9+QH/ID/8uPUUMMI1nOopfb7DZhCN7vsEmSNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=G3SfQfxY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="G3SfQfxY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68A2nTEM11125917, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789008570;
	bh=vgRBQ/Koq9Io+v0ItDmXAEyDc80pI5Y2hiMEKw4BWvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=G3SfQfxYo9N1TpH61o0zvEbBuZK3XQLSHUlK7BaLJGAEqSpyeh9gIArN3Ig2Le3rV
	 QwQttZ1cnyoVki8Y4z0WXdT5CV8MX+FPVig5VG2O9zk44C5VxpAJJJgoQ6Q7pd1WrH
	 3raW1ULOIKWQT64KPIS8B3UEbahN7W/92qYsBn92Ys2npdAnfGE3ID71BElO4JgG9z
	 opnSqHu5OHB5OZYnrSneaWpOqIWy+7Bpa+uW86IHAsddyZDLuq+S2N5knlmMwaSJh7
	 nhLyEGqcju0NglUIj1nBR9q/S+B8n07Ec+Gt8n3OiB21D26gkglE7OGUg1ZUHWstmy
	 f6lVln9YIvrsw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68A2nTEM11125917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 10:49:30 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 10 Sep 2026 10:49:29 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 10 Sep 2026 10:49:29 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1] net: phy: realtek: improve firmware write speed
Date: Thu, 10 Sep 2026 10:49:26 +0800
Message-ID: <20260910024927.1644-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Firmware execution routine unconditionally uses phy_modify_mmd() for=0D
all OP_WRITE entries which introduces an unnecessary read transaction=0D
when updating an entire 16-bit register. So we optimize this by=0D
checking bitmask boundaries. Use phy_write_mmd() directly to speed up=0D
firmware loading process.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realt=
ek/realtek_main.c
index 27e31a799e2c..97b0b67b9900 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -548,8 +548,12 @@ static int rtl8261x_fw_execute_entry(struct phy_device=
 *phydev,
=20
 	switch (entry->type) {
 	case OP_WRITE:
-		ret =3D phy_modify_mmd(phydev, dev, addr,
-				     GENMASK(msb, lsb), (value << lsb) & GENMASK(msb, lsb));
+		if (msb !=3D 15 || lsb !=3D 0)
+			ret =3D phy_modify_mmd(phydev, dev, addr, GENMASK(msb, lsb),
+					     (value << lsb) & GENMASK(msb, lsb));
+		else
+			ret =3D phy_write_mmd(phydev, dev, addr, value);
+
 		if (ret)
 			return ret;
 		break;
--=20
2.43.0


Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C868422E25;
	Mon,  3 Aug 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777585; cv=none; b=KW5hxjclZqCuW3Yy1Zu/Rrmyb8HWDhiptFgIgbEKwGnpwbmqf4kCiVfkF42ly1f/B/9t6nA+GQFOMGWdIp4D2ij1uINSaLlD2bnCX4PGwBD+JpGVnExS6jDv8v6mPID3EX1QftmpNgLtyHcSOjUsp+F8yh+IBwxFatsqUj9MLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777585; c=relaxed/simple;
	bh=dKwaG5VNDNI9501qg+6P2LLSj26d/WNX12kGIcx/d+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rohe0CVno6bwoW1psB/2Yx820C8x3RrjQKsp3BIX3F14wUIMjPyy+mlTB63zxFHYmxJnUSl/2R3IS3UbTy/sYcpaA+ao2Iv8PnTQ9XwACjvR/o17yKBYGM/K19o8RHmaelzxOA9C8WT45Ww/eH688zNuWvRM6VOjV1CN4c7F9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=N1wtkFVn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="N1wtkFVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785777554; x=1786382354;
	i=markus.stockhausen@gmx.de;
	bh=8/yaa9k9SxuVI6bWKM3zmgJC6vuOk4m/X83VFkiBS8Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N1wtkFVnb7CPscUxO9lcFamcjRp13zP3nxLEQkSpHl3/NtFvrYzhHOWgV2rMBVhm
	 JbcI0ObZubTDPduG1BXag6pkQvt9cKPLvwdgbBfSseivqVipQ1jM1dMBzLRxTGvJD
	 /dofWUNKIxJOszaZ76M1xEVyl9wd61pSqwwCVnvtKEgB8H6gZutdTxePVb3nh2XXQ
	 F4H6wyb0n60y+t4DR1bJZDe1fO27o8AGP+Ob8iSGeB0gnInRfmiSGXynufGZcpOH/
	 K6g+3xOZndhgBJZAevaLcxMM/1Qq0MACP4mkBeLlbNDpRUecphtr5uMhCsf7uxHAG
	 6la9jrY/P9TaC/Y5Dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1wmHte41x1-00AAzz; Mon, 03
 Aug 2026 19:19:14 +0200
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
Subject: [PATCH net-next v12 08/11] net: mdio: realtek-rtl9300: Check for C45 support during setup
Date: Mon,  3 Aug 2026 19:18:50 +0200
Message-ID: <20260803171853.507506-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803171853.507506-1-markus.stockhausen@gmx.de>
References: <20260803171853.507506-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sjDHmQnTNs901VRFzBBoEqxc8Koh+rR0Uit+oR6U4eh4tD3MnXt
 ZB/mSqDOBcfuuStcluGZJU8ndjwj8bVKoZsx4cYv87RLFaJDdZoZZAXHBvC4iKxsEoDsBMI
 7x5W1cwz/ld+E4Zho7V4IyvEddAQhKPs0U6S9p4yJVEVQM63OtBYdZf2hhXVG/indEEcCxX
 riPjWmfYBqhPCiqxDIn+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DpWjx70gMxA=;5j4VH9pMIRncDyoAEjn2bBPxF1S
 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
 nLTYgzB4SGybn9WY23BLsP/u+4Oo9cOu000t4=

The to-be-merged RTL83xx devices have only 1G ports. Thus the MDIO
bus always runs with C22 mode. For now it makes no sense to add
those devices with C45 helpers that are not used at all. Add a
consistency check in the mapping helper so that it aborts setup
if devicetree defines a C45 PHY for a device that has no such
read/write functions.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index f8577aedf08d..368166061aef 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -779,8 +779,13 @@ static int otto_emdio_map_ports(struct device *dev)
 		 * (i.e. clause 45). Select 10GPHY mode if there is at least one PHY th=
at
 		 * declares compatible =3D "ethernet-phy-ieee802.3-c45".
 		 */
-		if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45"))
+		if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45")) {
+			if (!priv->info->read_c45 || !priv->info->write_c45) {
+				err =3D -EOPNOTSUPP;
+				goto put_nodes;
+			}
 			priv->smi_bus_is_c45[bus] =3D true;
+		}
=20
 		__set_bit(pn, priv->valid_ports);
 		priv->smi_bus[pn] =3D bus;
=2D-=20
2.55.0


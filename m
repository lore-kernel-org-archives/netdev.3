Received: from send278.i.mail.ru (send278.i.mail.ru [95.163.59.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4F22A7F6;
	Sat, 10 Oct 2026 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657346; cv=none; b=bmQP3Lg6WDSEuyB0jIK40iLNnZkpm0rsSl8bVlyQ3bJMpQAst2VSaQ+monfDKoccrn4bE9yn+cVrM5d9fovpY1uZgN8WpDIgzS1aMldOUvVX/kB77CVyYQauou9sQofDXUWtkC+iog2DamxImOJYAFaaEq6U5pwfF7wZWWnTD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657346; c=relaxed/simple;
	bh=sGPEGV6UnbEN8GtLw8+nT6t/WMTk6ziDHF1RQx1++Us=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rKdNCwV6QdRTZ0F4AEXp7L77TzBH/P09XudZXmm+ArtDqZbTO7aGzqORhH/iezbPJqk3UHehB4hF6Pysxr//ZkGWvE6IBeOujDVnaQ5RxhUHpDv8huZkS5jI3IHHO9120W5jNr4UE/gcAzsujrJWZZRr58PWVbBmXevADS6p9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=ivy5jxEt; arc=none smtp.client-ip=95.163.59.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="ivy5jxEt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:
	Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=xICysHOq30s2z8HPfLn0xzBZMAjvQx+FmOCSGQxk61c=; t=1791657342; x=1791747342; 
	b=ivy5jxEthxEluKZWpS0zWRQAD1XEvl9U4x5RAueRRvWgDI9/nPq0uL3Onv7dG3OyhZY3bwJ8aVH
	Tl8wSOPSSJHp9UxbcPun37036J397kv1cDOaWq4vHIJaox7jeqBmY5aRTguMwQpq1ZGLLYq5Nyas7
	+vCsKBkVZanyC6DJ0u5BShS42yEuTaLvFlSU9cizkn6M++VwAQ3DGm86J3bHgLZb7JwVBdUb5Zr1D
	w5CE8obrPN6x/4S5/AreZONrwamNQhewuG3mTcGgLd+8v2bY5xze7B0kSkfqKn5Nj31FNTFfQq88L
	l8IL0t81wPUi+7CWorpfmpgDcu/HWylxrhmQ==;
Received: by exim-smtp-84d6fb566c-fxzzf with esmtpa (envelope-from <skyline@mail.ru>)
	id 1xFbv0-00000000DX1-0LBG; Sat, 10 Oct 2026 21:35:38 +0300
From: Konstantin Meshkov <skyline@mail.ru>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, linux-kernel@vger.kernel.org
Subject:
 [PATCH net-next v2] net: phy: marvell: add LED support for 88E1116R PHY
Date: Sat, 10 Oct 2026 21:35:37 +0300
Message-ID: <179165733751.2921261.13784246298385245617@mail.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Authentication-Results: exim-smtp-84d6fb566c-fxzzf; auth=pass smtp.auth=skyline@mail.ru smtp.mailfrom=skyline@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9A0706A514393B94563A9958F92DA4B87945D44F36EE26CCF182A05F5380850404C228DA9ACA6FE27B1F2774061418FF33DE06ABAFEAF6705C23E808EE97839959ED81C7A8F2ED338EB7B4B1AEBBE2F88
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F16C4DE526EFCC04EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2E937F277D5340A7B2E070BE324C7D3C4F8B4638458B2AAE7BB0A4F435E46E6718B35066C979671628AA50765F7900637F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0F75B7380DB97F9D88941B15DA834481F9449624AB7ADAF37BA3038C0950A5D36D5E8D9A59859A8B6CA2F541AE18FDFD076E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C289736CE4F78F08343847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A54B028A349C7F175E5002B1117B3ED696A6FA35D2CA3EC49F219207EC0A953D2C3610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB39D827CA74CCEABFF3F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6592ECDB8FFF47098128C3B6D224CCF70CFA75E93DD3B0A087BB063218099947FF75461DCF7D9FE422AB8341EE9D5BE9A0A0DB30ACB12B63A097611A78B5E053CB33A199308AC54CD64546A885F7A58241B4C41F94D744909CEF050418E73B5114343AC56E63459EDF0964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWDp51C9Ija0YAP+qXqN/L60=
X-Mailru-Sender: 7F28D27DF3217653F22F657F8252CA8709A4B80F3DF710CDB951B70A5BD4BD8EF0BDD5AB424365298D2F0B78A5E2C0F9E2E7FBE4C8C559FA08335C02508E532CFD0FAA000577B61F3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok

The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
through the same page 3 register 0x10 LED control layout as the 88E1318S.
Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
so the PHY LEDs can be described in the device tree and driven through
the LED trigger API with hardware offload.

Tested on a D-Link DNS-325 (88E1116R): both PHY LEDs are registered and
hardware-offloaded.

Signed-off-by: Konstantin Meshkov <skyline@mail.ru>
---
Changes in v2:
- Only wire up the LED trigger handlers; drop the led_polarity_set
  assignment and the dependency on the pending PHY LED polarity
  series, as suggested by Aleksander Jan Bajkowski. LED polarity
  for the 88E1116R will be handled there.
- Rebased on current net-next.
- Cc the netdev maintainers.
v1: https://lore.kernel.org/netdev/179152610952.2918676.6625057760354797023@m=
ail.ru/

 drivers/net/phy/marvell.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa..244454f 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3913,6 +3913,11 @@ static struct phy_driver marvell_drivers[] =3D {
 		.get_stats =3D marvell_get_stats,
 		.get_tunable =3D m88e1011_get_tunable,
 		.set_tunable =3D m88e1011_set_tunable,
+		.led_brightness_set =3D m88e1318_led_brightness_set,
+		.led_blink_set =3D m88e1318_led_blink_set,
+		.led_hw_is_supported =3D m88e1318_led_hw_is_supported,
+		.led_hw_control_set =3D m88e1318_led_hw_control_set,
+		.led_hw_control_get =3D m88e1318_led_hw_control_get,
 	},
 	{
 		.phy_id =3D MARVELL_PHY_ID_88E1510,
--=20
2.39.5


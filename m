Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC135201B;
	Fri, 18 Sep 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767993; cv=none; b=Fu1BBznx+D4s6gzaontxNzEpN5GTHTDBbryEsXkqyQAaxXlwvm+wXM4HsMSPcolpgBZcQ5rgrmdetUj1+vUyWPEITd1PSFF7ovG9ACnoSY0Ka9z1vJnqDb9tCFXjHoZhFNLJUvHk/yWK/N4A2/FZ5VZbJNa1Xj889WL4rfRM8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767993; c=relaxed/simple;
	bh=n2nWGp/DtkyQvp3yejQb6P6ED3ksQYxrnI7Dx8zIsT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pw4EbviDdK89DX75HjAP11DaZUeypSjFRUgWtQVIFjr1BSpB3v4rCIjYHKBciUisjifBSDf4bcJKJYwUXnstszXhRK4xqPRnjru+yuwk0u4zZc6DRjWza7N+enLbDC5AFC8UNvQZEqiyXWItX1QaRwoFT0q15HgTeMzvm6DiwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de; spf=pass smtp.mailfrom=jonasjelonek.de; dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b=atNMC9h8; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b="atNMC9h8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1789767989; x=1790372789; i=jonas@jonasjelonek.de;
	bh=T7VjXcGLNEp/PsjeylEWb75dAKLZ6LRRe6ugNMaNiXc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=atNMC9h8Xt6gHPSEDj9lp27CXVEHRxZ8M0GM88jLXzAaeJjRjFy5rdcrpW1F3vZl
	 fEMtSoLQHD9U3+gumvo8FsBog+AR+kI64vccMkXGczzj/kg2J+m2pm0ZfxLxwBtlX
	 VBDuJFoLOGxu9SqeiZVNC6x7btnEqO4l86QI2qGwRm+ngJvPIztaDJ9zfUGqKVxjk
	 H8ulEYawObSITHVqpuAAE0AU8AHkRlAg8Y4t+5r7wYg2NDQRyM2ub9Nhjm34kqjEA
	 Rae7/bsNJOWPY6va11+Rxpf75sYePr0Fn1vkB8XtU5hphMV42R3XrObUk2wq0STnS
	 GNoIgR6MDz5N4mjNaQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M6DnM-1x9svl2Wm8-00FJ5z; Fri, 18
 Sep 2026 23:20:05 +0200
From: Jonas Jelonek <jonas@jonasjelonek.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jonas@jonasjelonek.de>
Subject: [PATCH net] net: mdio: realtek-rtl9300: fix RTL931x C22 extended page selection
Date: Fri, 18 Sep 2026 21:19:55 +0000
Message-ID: <20260918211955.3955777-1-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6s+eZMirCmmbXGVkcVKDj9D5cbWlJQExptG3AHo5Ge9Gm5RpiDj
 k9dF0MpZU2BAkBEdjoSkwhDsnuT9/Z/IFtubXtaGubGDP/qyvAgNftNORof5/kSc6AeSjz5
 o8O0WPyEvJ0Nwnw+OjK1z3DDQ7fykvDrDIzvKUHa95dQpEHmXOPVOun4/QFXYeaPFi1hGRR
 BbXZ/SDC62Haib+Z5irhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4hiqyQPUj4o=;fJcYdgt82Vsr7AcCxRibT05Bzip
 rLy1YRL30nLU2ZUulJGHRhsrevlBbgnkLpudny4ourjPGRR+dRaRHHuhaUAFe3nfYlUbofefX
 mXpg5QXTNnKkGOv1gfRJCkfGqxUv9JAjklCJ8bWAlOpDRBNQRgOjAnoLVlm7rqMm9+3DcZ+d2
 9QPQ+ZniiFBBM3u1wgHQ6qY3/QBBv3eJWqBixgc0YF5uuemckrrYYHA49hE/xaZKJWKTg4ptj
 2T8mNfctOdWsTTEYWrl9JYXK7Dvm9fB1L3ewuDckqPZuZdhs1wCmQ0rN8ce9p6dZFAuATjFYN
 EHJQ6I3XMHJuTh/dllP2Pk6L2amVTICQeXjqgapaM+Z2xiQx87B7YqQbRjESXtOAE8peoaxli
 h73D/jHV2YkKBv43PN+nsg7ikhz4d4HjKn9+9H20v2jESor1uP/tG/b9/Wi/t6abAGxEPwD82
 qCSh/U5fjCpyENAx2oSFxHMq0L1ZFtlkuVBpJFmJQMTFOVD53/E8BA2oGFLMJVBm/dmxgOZG2
 /lsc5hxc64Uy2T9F8PDB8gfLDK6eM42U3Z0ZQbDKtzPx8939W9exe/bhtSsG+GxOjekcGBUOT
 emmusEV5glx/bWTaqVrcnfjYtJMcmF5KP3jRP8lQ9zhn20IXnTFdoUK10TO/DyC4RvTMThdKT
 8Om2M2D3PP7Xo0lH6egRW1NmwHuASEtz3AEFIhEfyp1oJzHi2asp95PDMX3kjUlDR9Ks3/kfQ
 SRDqx1fUPlf1WCwBmFWlpQJfjTYpKCF8/z8CZh3ltj8RG0DWkIqY+BWjoN+YZw7N7FxIDZsNV
 Tl5iZTZEqXDlSdWkwv7Emsw399aIfp1YjDPKV0xBDu65drIxKhx10QZnsBFpqEI5nvqVtRRRd
 NryUNvPyhhRqvuhBRsYeQHINdmDfhsyY1fL6xcnwWC84YTsO1+REsxP4Y6dWVO9xjHtLEDq7G
 0wNW8LWKD7BkH47vTTpcVKiT4SpN9dfGur7MWUtB87Mi1g6m3GtBBVHlgSMN2KN53xYMzgwg/
 eMmElg7eQdPyqIatMxHLTNw1KNE5IOi5UZKh1sYNs8RBrnTPaHKWpAIhsQl7523HhhHNpo2H4
 Wc2JFuzLxR8XFVLT9a7ojeanmwGb5HjfD8jn0JEereHvXSXXjf010Ha+vx8yl31XPa+0MiEbu
 pXb7zmOeEQnTPpVrbpx2qapvqzDyRpLALtKdCEc+TPjrpXN+K9Kx/T/PoXnLxIqA2+imxL42M
 e/9U1GyDJ681eNJbMvWr1xcsOfjx60juE9+yyjXToeJlMZ2c6mxpSUv8c37etp5o+FT4T15aA
 6lP99ujVcMMpEDjg1ru9peBUSNtj8oD0liGedqSEl0uwkIeo6c/pM3oTUqm2iygy+zOUT7Swj
 JdcdEXCBQvDeB3rE0AUUWse7P2wsdKwXgn4aN4T9BKhDsAjMqIqnfDNLnSEUHKbpHwD92S2SA
 oOeLpegIw7Q0u9N1auW+qe3gAQBQk71tS6WcTeWZk1FEzGl2yU69+ukIERuzgaR5dZdjKGgAE
 ustQs3p0blR8qjTnHq4a3VpGhprxUudqmgT3eaNHge9njlrIYXzgf9rZxvpBoDDo/hSPrOcKV
 zZHgVrBjFz/xaKXU2SZ7CBuCSwLv2piQvJGCLczpWoH7fJd9bWYisfS/wveM5E+Jib/KGF9pL
 4YvWMO2pS21C0bH0qqk2xAUr02OdAq7ZQ576BFsnq5SckfY4kKmhKr66Herq2D7FAwjkvYGe0
 UNR5jb8ajo8QbAoQlkPH2WX59/VJZ/v7aMD242bjbBhUAdlddt9gSric86c9gn4GDBsn+AGSU
 Et8Lg/z6YjD0dVbDVfdbHl+aNJRKTcE/Oj8MvPi/dci9WOmMQyH+i3jMt6cLwugcqg0GUfmyd
 FfDScAth10bHbcX2YYc2LSjRym+U1dYi0ad+8y/3fX9SwlrtkhOViAUkFhzjqHX4FtN0UULAO
 FJFvXi3SQ3JfEy3etl0dp9cQJ/hJzd7sKhyagVi+DpG3hn5gf6rdZhc0DrI6EbgQ3ENqjMopc
 i9mDEMhrWMq5rj+gPLFR9oJESm817cKeoN00IIQk4xa7bLZNFVPdL2acIofklu7rY1sg4blmH
 mCqzdECdm+wHKXCPS4fjWWUFSXrvXmFLs78eFc84jeaOrVu9haWeF/mwSZMEWZb5rLq2/HKic
 SlMFGtgefR+5cBhonxqusO4ryTbUBcY485213jDNBnf/S1vNfG80L5ESTNjj9XTtuCERPvaNp
 miiZKq/c6H703XzLdHtQAub1KummDnRWm2Yl6tUl7FuaAMsFjLCafE+Xot3qXjW59958NLm/F
 ZiNuBhfHxvY6oZxg3/bSQ9qlBEJD2WgrYbQlcQecN7fgOPiE=

The RTL931x indirect access engine has a separate nine-bit extended page
field. The driver leaves it at zero, and otto_emdio_run_cmd() therefore
programs extended page zero for every Clause 22 transaction. This
overrides page selection made through PHY register 30, causing accesses
to private PHY pages to hit extended page zero instead.

Set the field to its 0x1ff "do not change" value for RTL931x Clause 22
reads and writes. This preserves extended page selection made through
PHY register 30 and restores access to its private register pages.

Fixes: 5ebdcac59aff ("net: mdio: realtek-rtl9300: Add support for RTL931x"=
)
Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index afd52a1cd7f8..9ce2b7807532 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -88,6 +88,8 @@
 #define RTL9310_SMI_INDRT_ACCESS_BC_PHYID_CTRL	0x0c14
 #define   RTL9310_BC_PORT_ID			GENMASK(10, 5)
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_1		0x0c04
+#define   RTL9310_SMI_INDRT_EXT_PAGE		GENMASK(8, 0)
+#define   RTL9310_SMI_INDRT_EXT_PAGE_NO_CHANGE	0x1ff
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_2_LOW	0x0c08
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_2_HIGH	0x0c0c
 #define RTL9310_SMI_INDRT_ACCESS_CTRL_3		0x0c10 /* I/O fields flipped */
@@ -325,6 +327,8 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.ext_page	=3D FIELD_PREP(RTL9310_SMI_INDRT_EXT_PAGE,
+					     RTL9310_SMI_INDRT_EXT_PAGE_NO_CHANGE),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -337,6 +341,8 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.ext_page	=3D FIELD_PREP(RTL9310_SMI_INDRT_EXT_PAGE,
+					     RTL9310_SMI_INDRT_EXT_PAGE_NO_CHANGE),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),

base-commit: 46bc52d13594848023e681860df8700c8db14354
=2D-=20
2.53.0


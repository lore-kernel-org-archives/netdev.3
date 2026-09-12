Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37447F3A5;
	Sat, 12 Sep 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218324; cv=none; b=NvGKsamqG2jSRuNEjSRwKbEc9D/R4Lnlz8cVEtXMnLzdtpHf3kFZ1rBO41KGadg2yaAmm8qSirf6/jy70fG+mjxtg2XBTMElmF7hz+Js9vzYAJ7H8xb0KTpLEUuZHyDd2YGCURQXZj1IWlhTEjjKW8BII/QzlxGoGGR475yYrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218324; c=relaxed/simple;
	bh=ydfsz5XITR2oR79GBGeJ+uDZ6er15w01gKWkZ+URzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atNEubpLfwk/TSg5ZhquDB4pUQySx4IgI3JzEarC/IhFJ4kHNAGLrwrQI600yOmBMp6+kjgTbUJ/1fyozdBspIDIXoy05vUUbNhp1lRwd0MkiqJlmIccR5tvmy4IgxEd4hLCvCJbmeZ5s+nGfeQsbQnwCFFHAOATVNcgFbwAa1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=f8b7tt5P; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="f8b7tt5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789218308; x=1789823108;
	i=markus.stockhausen@gmx.de;
	bh=ztjCG3dNSmWGtxIYj5ce9+ZRGbkVDtjMZbi161TLc7Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f8b7tt5PpYeRzNI3OW50WX+Fh21c84c61nXRPRLUnGGyp8dAzIbAy3zvurWmQFCz
	 3FCuceRoXHRSO7slmsN9B3iXtY7LD1K9o0mgZapqnX1jwNPThn2FJ20B1YlDndT3n
	 A9hfPtBZapW9ANwxFKQ7O8Fhk6ip2kl0k+RzUfAIYgVyKE/TtiifK06t2rzHCwFVj
	 0DxQV0GWKYy/KuxmCOU9/dHIjh02hExX33+Yixv48L5hu/kcFDl5wRn/E7XaGL9Tl
	 8ftgnfIMBrfaKxMyztMIqZVOwMAPLh+uwpDge+N6co7GY6abfs0yq7ynTUwuF4P49
	 1Q/iMGRSzHvlAOwG+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1wcMva1FtO-00gmin; Sat, 12
 Sep 2026 15:05:08 +0200
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
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v4 0/5] net: mdio: realtek-rtl9300: add bus frequency handling
Date: Sat, 12 Sep 2026 15:04:46 +0200
Message-ID: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NUe45+4+5PSMjlsxZU1qJT2QfRSsCRiZnf/2KlHJExdB1SBTF0O
 tqW5LcKKtSvUTu9easabxrwq16iCyqFZXL9pKgBblVZkqYaIl9lXlI09MhEJtcoBAPO01uy
 yyFSlCed/JWavhuT0bfHMX7CIGepHGitL4yFXHcTB8qhSja6rp0sqj5LqHC/7KUArifmcOI
 pNJT+6ET+hb0ya4IXVO0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nz8uDw/a4xs=;YO5Y2CD3gjLsCimnbvupngidrFG
 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
 2IR0

The Realtek Otto switch platform consists of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

All of them support changing the bus frequency of their one to four
Ethernet MDIO buses, although the available settings differ between
the series. Extend the driver to support this feature.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
v3 -> v4:
  - Add new devicetree patch to clearly describe the number of
    MDIO buses. (Sashiko)
  - Harden devicetree clock-frequency properties to match the
    driver. (Sashiko)
  - Therefore drop Acked-by for devicetree patch. (Markus)
  - Improve fwnode to of conversion. E.g. drop dev_fwnode or usage
    of unneeded includes. (Sashiko)
  - Reword commit message of frequency commit to better reflect how
    the setup logic works. (Sashiko)
  - Refactor RTL839x frequency setup and comment to be consistent
    with the commit message. (Sashiko)
v3: https://lore.kernel.org/netdev/20260909150107.3602067-1-markus.stockha=
usen@gmx.de/
v3 Sashiko 1: https://sashiko.dev/#/patchset/20260909150107.3602067-1-mark=
us.stockhausen%40gmx.de
v3 Sashiko 2: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909=
150107.3602067-1-markus.stockhausen%40gmx.de

v2 -> v3:
  - Add Acked-by for devicetree patch. (Conor)
  - Andrews Reviewed-by not added because of Sashiko findings. (Markus)
  - Add patch "Reject duplicate MDIO bus" to harden the bus detection
    and as preparation for the RTL839x frequency setup. (Markus)
  - Rework RTL839x frequency setup to better handle missing/default
    frequencies. (Sashiko)
  - Use for_each_available_child_of_node_scoped(). (Sashiko)
v2: https://lore.kernel.org/netdev/20260906081946.3499898-1-markus.stockha=
usen@gmx.de/
v2 Sashiko 1: https://sashiko.dev/#/patchset/20260906081946.3499898-1-mark=
us.stockhausen%40gmx.de
v2 Sashiko 2: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906=
081946.3499898-1-markus.stockhausen%40gmx.de

v1 -> v2:
  - Describe per-device frequencies in devicetree. (Andrew)
  - Add proper per-device frequency checks. (Andrew)
  - Use the initialized parent device for dev_warn(). (Sashiko)
  - Make clear that otto_emdio_probe_one() currently has an
    indentation issue that will be fixed by this series. (Andrew)
  - Throw error if RTL839x devicetree has different speeds set
    for first and second bus.

v1: https://lore.kernel.org/netdev/20260903122119.2638354-1-markus.stockha=
usen@gmx.de/
v1 Sashiko: https://sashiko.dev/#/patchset/20260903122119.2638354-1-markus=
.stockhausen%40gmx.de



Markus Stockhausen (5):
  dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
  dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
  net: mdio: realtek-rtl9300: convert "fwnode" left-overs to "of"
  net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs
  net: mdio: realtek-rtl9300: support non-default clock frequencies

 .../bindings/net/realtek,rtl9301-mdio.yaml    |  65 ++++++++++
 drivers/net/mdio/mdio-realtek-rtl9300.c       | 120 ++++++++++++++++--
 2 files changed, 176 insertions(+), 9 deletions(-)

=2D-=20
2.55.0


Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4B446852;
	Thu, 30 Jul 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427406; cv=none; b=bB8nqFArd1Hfv/JLbjCnd+P3pn3DJITuu0V19Ffkyzg7Vjqm9rTm+HD10XusUiEdpMrkl+Jg2U8cNbbxKU99+hC/FFBmd69AxXtcjJFba+2srsEcmCUXwCvBGma/o6a5n0HWfZHQv0rlxvSHeENTOl12bmrgHE+djvm8rd9H1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427406; c=relaxed/simple;
	bh=Kts6fOV7abFITfpoA3cVBvBpbyx8Mzr9G8ROuDSkpgk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fWg36vvbdkd9U/dGN10XZfArs0kZ4rzzLhuCLSH8Ty4twWz/uPhu4mifqlIPxpIW4HOntleTPW8qtk4Ntwy493+D0eLC+5aI4HIAElbbCbqF45H3Ky3yXBRV/3GJSJVWH3JW6AFa2FqTygNlJp1qj1GyEPE8TptZdFXCtWMETFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpTDv-000000007W1-0nVU;
	Thu, 30 Jul 2026 16:03:07 +0000
Date: Thu, 30 Jul 2026 17:03:00 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 0/4] net: dsa: mt7530: fix remaining swallowed MDIO
 access errors
Message-ID: <cover.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v1 of "net: dsa: mt7530: fix swallowed MDIO read errors" [1] was
applied to net just before v2 [2] went out. This series carries
everything from v2 which was not already applied with v1 and still
qualifies as a fix: the two standalone patches v2 had grown following
the Sashiko AI reviewers' findings on v1, and, as patches of their
own, the companion fixes v2 added inside the already applied patches:
the unchecked bus->read() in core_rmw() and the unchecked PHY_IAC
command writes in the MT7531 indirect PHY access functions.

The remaining non-fix changes from v2, dropping a redundant read-back
and improving the poll failure messages, will follow via net-next.

[1] https://lore.kernel.org/netdev/cover.1785213071.git.daniel@makrotopia.org/
[2] https://lore.kernel.org/netdev/cover.1785368701.git.daniel@makrotopia.org/

Daniel Golle (4):
  net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()
  net: dsa: mt7530: check bus->read() error in core_rmw()
  net: dsa: mt7530: error out on failed PHY_IAC command writes
  net: dsa: mt7530: serialize the regmap IRQ chip like every other user

 drivers/net/dsa/mt7530.c        | 56 ++++++++++++++++++++++++++++-----
 drivers/net/pcs/pcs-mtk-lynxi.c |  5 +--
 2 files changed, 51 insertions(+), 10 deletions(-)


base-commit: dd16f1b5720f5dae33a79b5305e188e8290a3973
-- 
2.55.0

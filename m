Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39235C6AB;
	Tue, 28 Jul 2026 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214351; cv=none; b=MKk3hKWE4zYSQ0/dGOJIM32PnCpwicGRnBkpNHnr/ooTxZO3I5u8S5HJLAlN+fvDptQRixkSZsr1x5tyIMIF4scHI9PRP1j4p4fRjzotqXQmOm2CibzNR4cUXEYAU9wJLis+AxGlpZjwAfsQZBxfxyHylYW7ZVUOLHvMgD7GFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214351; c=relaxed/simple;
	bh=fsbNP2+037tWd/glurw/HerLiKcQlEgfsaiaJ9aipLk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j7nIDETgi7A8hdrETAfqX6wQOCcQ6r0MxioqTUVIA0N+obZZFyoSEJLIHaTJGJHSaCSh295dok0MbzBiQIyO5/jTYD+LHY8iNjJ4FrZ4nItBLli6TtGcBNK56zSRiyBhLszKho5woSabqpD6R10GzFKVHQiJcZoBSzAy/O2DM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1woZnU-000000004wL-1Kv5;
	Tue, 28 Jul 2026 04:52:08 +0000
Date: Tue, 28 Jul 2026 05:52:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 0/3] net: dsa: mt7530: fix swallowed MDIO read errors
Message-ID: <cover.1785213071.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While working on a register access cleanup for the mt7530 driver, the
Sashiko AI reviewers flagged long-standing error handling gaps in the
driver's read paths [1].

The MDIO regmap backend truncates negative bus->read() errnos into u16
register halves and returns success, handing garbage data to callers
and to read-modify-write cycles which then write it back to the switch.

The ATC/VTCR command polls and the MT7531 indirect PHY polls consume
reads through a helper which returns 0 when the underlying read fails.
A failed bus transaction thus clears the polled busy bit and is
mistaken for command completion, defeats the subsequent
ATC_INVALID/VTCR_INVALID checks the same way, and lets the indirect
PHY access functions return garbage PHY register data.

Fix the backend to propagate bus->read() errors, and convert the
command and PHY access polls to regmap_read_poll_timeout(), which
terminates polling on read errors and propagates them.

The cleanup series depending on these fixes will be submitted to
net-next separately after the next net/net-next merger.

[1] https://lore.kernel.org/netdev/cover.1784481922.git.daniel@makrotopia.org/

Daniel Golle (3):
  net: dsa: mt7530: check bus->read() errors in the MDIO regmap backend
  net: dsa: mt7530: error out on failed reads in ATC/VTCR command
    polling
  net: dsa: mt7530: error out on failed reads in MT7531 PHY polling

 drivers/net/dsa/mt7530-mdio.c | 11 ++++-
 drivers/net/dsa/mt7530.c      | 86 ++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 50 deletions(-)


base-commit: a50eba1e778ad4da5b6f9ddbbf57dabbea59bc05
-- 
2.55.0

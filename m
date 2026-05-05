Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED091C3BF7;
	Tue,  5 May 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990569; cv=none; b=M8AaanhtjxPX3RygLaNAHcB9mUVZhXO9xmFrrewIpVgIrN8Zh8/M3byB8S5tXQbNYZGHvnJan6DZ0FVQCm3cWg+W0B9VG0kL2X/Z0CE3hKmro/7gyOLvAnpkSapX3gMtWPhHN/42ECsQs2JwhaLPiF2osrvtEX37MHqFl3nWF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990569; c=relaxed/simple;
	bh=wtsdKmJsrRfGLb9YjWPJ0wg4Vgbjr4kdanJ4F2dLXWI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ej3aT5KoIRr+gW7/Vd4FZD/yTSY2hllbKQw+wOr+MdNBMJR49wr6j0HC5Ju/oMi2l4dzruD+/WYh6IkrNOp8oD/4OlejpbHnlHs2p3KlvgpT5qsRKAHDQNKS8d9JezhJ8ICgJpsclMgLnakaRBQfqYlpsTaZd2i+m9wpMhoLxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wKGYt-000000008Q8-0upW;
	Tue, 05 May 2026 14:15:47 +0000
Date: Tue, 5 May 2026 15:15:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Edward Parker <edward@topnotchit.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 0/5] net: dsa: mt7530: assorted fixes
Message-ID: <cover.1777986341.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A batch of small, independent fixes for the MediaTek MT7530 family DSA
driver, addressing long-standing correctness issues that surface on
hardware with bridge VLAN filtering enabled, on link-local frame
reception, and during bridge join/leave transitions.

Daniel Golle (4):
  net: dsa: mt7530: fix FDB entries not aging out with short timeout
  net: dsa: mt7530: preserve VLAN tags on trapped link-local frames
  net: dsa: mt7530: fix CPU port VLAN not being reset to unaware
  net: dsa: mt7530: clear flood flags on bridge leave

Edward Parker (1):
  net: dsa: mt7530: untag VLAN-aware bridge PVID

 drivers/net/dsa/mt7530.c | 153 +++++++++++++++++++++++----------------
 1 file changed, 90 insertions(+), 63 deletions(-)

-- 
2.54.0

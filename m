Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A324E016;
	Thu, 10 Sep 2026 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.228.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040401; cv=none; b=rXrZ4+KBTN8NnHRBzZuC30LyWAsL2XoGneGM1m57abP9vVtVd99HhWZx0VksGbRyLxLcxHoI8q6s9QS5dus6ExWR/WGFVg0nKzl7KUgXquLJACPc+NlPygJJgBk8qstC91pOuOgHJQqPxerQXVjgqbA0B2dupfOOgLfo5mnapnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040401; c=relaxed/simple;
	bh=MuI5ZoR2KmXDo0xgTJySRZJ9mUPPeEsyxMoAaattzLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnXOTDiDD06wOnGzJt/G5/XtVnFBOdbboQqbUONjuMi1DNQ9c8jYMf5BGkXtiT9DiFdllIjWnIgEbG3YWSM1NR+2yERzLrIOY5OasiTpwBuMpr1IG8KkCN5FTfwLgqwARiT+hy2PJIhmEvTTQ71sY9pbV2rqQZrRVIsW+slcbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de; spf=pass smtp.mailfrom=dspace.de; dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b=EbH9j6uX; arc=none smtp.client-ip=80.228.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b="EbH9j6uX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1;
  t=1789040398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCdgCovM884FfdUWP8JorqJdxM/aXjJe2TbERbkQhls=;
  b=EbH9j6uXWd9L0jhjI1h9vaq+85KC6h/LX1RGPHDggZAtk+0HGOMQn4BJ
   pFfy7TacE54CdY2xAs+m/gsBmBjY1zGvwj7nG/+qQH0V/4r3C+xHrrDf4
   VdfKkk8oDNVdUqQeUaUZrLln8bfnvfIZ8qqewe09HwtAFHMxS+Owo9paM
   s=;
X-CSE-ConnectionGUID: RGGjoQFnRrSdIgTK5XABdQ==
X-CSE-MsgGUID: WQgWWFUlTiSxiE+/M71TNA==
X-IronPort-AV: E=Sophos;i="6.27,95,1787004000"; 
   d="scan'208";a="5467928"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
  by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2026 13:39:55 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
	by Z1-1000 (Postfix) with ESMTP id 7578960037;
	Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Z1-1000 (Postfix) with ESMTPS id 6895260036;
	Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.5.241) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 10 Sep
 2026 13:39:55 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
CC: Daniel Baldin <dbaldin@dspace.de>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pascal Kneuper <PKneuper@dspace.de>
Subject: [PATCH net 1/2] igb: Preserve RXPBS.CFG_TS_EN in igb_setup_tx_mode
Date: Thu, 10 Sep 2026 13:38:53 +0200 (CEST)
Message-ID: <20260910113854.13279-2-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910113854.13279-1-PKneuper@dspace.de>
References: <20260910113854.13279-1-PKneuper@dspace.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
Content-Transfer-Encoding: quoted-printable
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
X-TBoneOriginalCC: Daniel Baldin <dbaldin@dspace.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pascal Kneuper <PKneuper@dspace.de>
X-TBoneDomainSigned: false

Commit 05f9d3e1ae6e ("igb: Add support for CBS offload") restores the i21=
0
Rx packet buffer size with an unmasked write to RXPBS. Bit 31 of RXPBS is
CFG_TS_EN, which enables per-packet Rx timestamping. Writing the register
unconditionally clears this bit on every igb_up() (link down/up, MTU
change, or driver reset).

Like other drivers (igc, i40e, ice), igb intends timestamping settings to
persist across link changes: igb_reset() calls igb_ptp_reset() to re-appl=
y
tstamp_config and set CFG_TS_EN with queues stopped. igb_up() then clears
it immediately afterwards, undoing its own restore.

igb_ptp_hwtstamp_get() returns cached settings and never reads the
register, masking the fallback to software timestamps. On an i210, a link
flap increases PTP path delay from <1us to tens of microseconds.

Fix by masking the buffer size field, as the FQTSS branch already does.

Fixes: 05f9d3e1ae6e ("igb: Add support for CBS offload")
Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
index d4a897a8c82c6..0f3c728a07fb1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1947,7 +1947,12 @@ static void igb_setup_tx_mode(struct igb_adapter *=
adapter)
 			igb_config_tx_modes(adapter, i);
 		}
 	} else {
-		wr32(E1000_RXPBS, I210_RXPBSIZE_DEFAULT);
+		/* Preserve RXPBS.CFG_TS_EN so Rx timestamping settings
+		 * persist across link changes.
+		 */
+		val =3D rd32(E1000_RXPBS) & E1000_RXPBS_CFG_TS_EN;
+		wr32(E1000_RXPBS, val | I210_RXPBSIZE_DEFAULT);
+
 		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
 		wr32(E1000_I210_DTXMXPKTSZ, I210_DTXMXPKTSZ_DEFAULT);
=20
--=20
2.47.3


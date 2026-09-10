Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D437BE7A;
	Thu, 10 Sep 2026 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.228.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040397; cv=none; b=Tsas7Y5jDuY/LuulFenBr4zCqnj+9z+yMzPBcGb2n2CDNL1tA81ess/dQRR+FtObTIkwJJPHyNjM98bbebYkY163BmjPlnqxsCoaKrGeUGOv9eR8hdChrmpm+jP4HCeiUm1YGD6RvRNUjaKZuIZ8uy2vioY30iiWLe2XoYYqZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040397; c=relaxed/simple;
	bh=nx9/G3l9BsoVhRjXLmQOubf7D78TGoPNdVhz8sER2YM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgTUY6tNk5j9PjTMgURIZafOP387YgNgTWhcGJd5CXJnPJuX7EBB/+pV2kVGlk2QgEtXh5CFuuXhuBZRJxwOlDP6NNar2R+a90KO2uC10SCL7Cd1FyMfEPkzCgwun4OxCrgaPyLLVaAkHs9PJki3iK90SipbwOOx0yluVNsiSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de; spf=pass smtp.mailfrom=dspace.de; dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b=Yug6TOFu; arc=none smtp.client-ip=80.228.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b="Yug6TOFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1;
  t=1789040394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yshyf3Fv0vvyf7p7UbWV0SuvDTq/4gC9jwwz1xnCFUI=;
  b=Yug6TOFu5rBaex7bGSvfdVUzVF4DTYdp/ddDKTacRJ57eUn7K6I/qbPX
   nejpsYJnPDwne7fYDvvbVuRxclU9muM7OdZYo0lwxTeVe6pQrVujwD0NC
   xqUF10v2TL4InlZJ5/OdHVK4Qhf7dYtnx0xbopA3Ol4i6d590f5ckK6XQ
   8=;
X-CSE-ConnectionGUID: j6+iw3OxSpqZQup+gmUsiw==
X-CSE-MsgGUID: x1cxu3oQSsi+B6UccK1KkA==
X-IronPort-AV: E=Sophos;i="6.27,95,1787004000"; 
   d="scan'208";a="5467919"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
  by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2026 13:39:44 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
	by Z1-1000 (Postfix) with ESMTP id B55C160037;
	Thu, 10 Sep 2026 13:39:44 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Z1-1000 (Postfix) with ESMTPS id A834A60036;
	Thu, 10 Sep 2026 13:39:44 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.5.241) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 10 Sep
 2026 13:39:44 +0200
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
Subject: [PATCH net 0/2] igb: Fix i210/i211 Rx timestamping loss and packet
 corruption
Date: Thu, 10 Sep 2026 13:38:52 +0200 (CEST)
Message-ID: <20260910113854.13279-1-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
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

Hi!

This series fixes two issues with i210/i211 hardware Rx timestamping:

Patch 1 fixes a silent fallback to software timestamps. igb_setup_tx_mode=
()
unconditionally writes RXPBS, clearing CFG_TS_EN on every igb_up() (link
down/up, MTU change, or reset). Unlike other drivers (igc, i40e, ice),
hardware Rx timestamping fails to persist across link changes.

Patch 2 fixes frame corruption when enabling Rx timestamping at runtime.
RXPBS.CFG_TS_EN changes the packet buffer layout. Toggling it while Rx
queues are active creates a race where descriptor status and buffer layou=
t
disagree for in-flight packets, corrupting Ethernet headers and dropping
frames silently. Fix by quiescing the Rx path around the change.

Patch 1 must precede patch 2, as the quiesce cycle in patch 2 invokes
igb_up() and would otherwise trigger the register clobber.

Best,
Pascal

Pascal Kneuper (2):
  igb: Preserve RXPBS.CFG_TS_EN in igb_setup_tx_mode
  igb: Quiesce the receive path before enabling i210 Rx timestamping

 drivers/net/ethernet/intel/igb/igb_main.c |  7 ++++++-
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

--=20
2.47.3


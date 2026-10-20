Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516318;
	b=MsC6db7MbDxP8s0AL23N/2AXmPYTplSNLiI1J4kVgvVxHEXig4Gu4wGOPdmF9cfxCx3/
	 ofnHhvk8F25L0I5pdNBPGCj3Xn051AL80fo7ovURLwLrOMvmKSsi0wP96AI1leH3vrfAR
	 oEe7mwaGthFy6lqTxDANZAW9/Y6LzJ2EeUBO7G7fhjuQTd4QulH50BQ9PBcXeBk1cpkx9
	 4SUpAtydRZ2ehkcZTCVi9INCjC04+wuU/D6rK6xmEMiy58ulus+ImunBMDU0DIGY156hY
	 khg/vwRaLF70bJPuPtDGSR96H6X7rprv8lANrAHAYs128C8mZ+iQoiCbmF1pDXR0Zog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4aCqGxErTzl3incPuuNNF4wVfmPt6xcsFheAMAI1pug=;
	b=tqeUy3VpEMQmtZDfQ+D2ZvLMq9bvTuZgcQatViXGJ637SKLbQh8jYD8e6LM35HaDOV55
	 NFKZf+AjzXCnzLDyNRNNfbsDACno+7U36QHSDE55VS6/9ZK95jUfZLezC1xhCQY7SBg9G
	 Rnk7wEioXDkTg4thao+b9z+7FFIdmpFz8WZnv0pmcxy8yo7sWZcaAfDBqZKO5Tt5CoobT
	 VvPiEvtc7z+5hD0HxmYRbteztNQb80ZSGjI2IhlppdTOOjeiL73uWQH5Be4yV1YwBvTCU
	 FHAnsKpAL74nHQuDJloGDQFH/iPKC14XlHYlx89FgVqTGqDsgHW3Brt84wCH7GeYlfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006260A2612;
	Tue, 20 Oct 2026 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A006260A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 814B9E8315F;
	Tue, 20 Oct 2026 19:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4aCqGxErTzl3incPuuNNF4wVfmPt6xcsFheAMAI1pug=;
	b=Qd3smCCdIBkVzU4VF6wp5sjKphfZz5AuJyEFkWuNRvMpvK5oGaLoTlJbkwF2O1tjHIpe8s
	WiPDqxr6g+mb+OAVs9T/ozqCqSm9vj+bBeToFwdkCnTNm2kQq0Ca7Enq+cSHfHgNpFHG6B
	MNXtyD3FHhTQe+oe1am8XVrpxv53eSwr0Lf4ycAaEtQh7dad/Uwoex/E1NlrGxoprD23YN
	BhueIXZwx1U0ynuNe8tDklh9ttA40UzJP3d+YrP94PgNKA2S2liKHhqgpqUgOgyJuDh7j5
	pwSOTcWdXeUa3VUg0fIUfJO+kRe+ZChP4F958p97emxPD8FUMkL75/EFUebnFQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id fmbDPnxeQ5CY; Tue, 20 Oct 2026 19:11:49 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:11:48 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v2 0/2] net: pse-pd: si3474: probe error path cleanups
Date: Tue, 20 Oct 2026 19:11:31 +0200
Message-ID: <20261020171134.852878-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small changes to the error paths in si3474 probe. They do not
depend on the PSE fixes for net ("net: pse-pd: assorted lifetime and
error-path fixes" v2) and apply to net-next as they are.

 1  The error message after a failed devm_add_action_or_reset() reads
    the ancillary I2C client, which was just unregistered.
 2  Use dev_err_probe() for a failed controller registration, as
    pd692x0 and tps23881 do.

1 was found by code inspection and not reproduced. Both are
build-tested only, with W=1.

Changes in v2:
 - 1 was patch 9 of the net series v1 [1]. Kory asked to send it to
   net-next, as it is not an urgent fix. Collected his Reviewed-by.
 - 2 was patch 3 of the net-next series v1 [2]. Its message no longer
   mentions the vpwr supply check from that series, which is not part
   of this version.

[1] https://lore.kernel.org/netdev/20261018082314.48950-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20261018081853.47484-1-github@szelinsky.de/

Carlo Szelinsky (2):
  net: pse-pd: si3474: fix use-after-free in ancillary client error path
  net: pse-pd: si3474: use dev_err_probe() for controller registration

 drivers/net/pse-pd/si3474.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)


base-commit: 8cc24527d54d3ecaa09eec5a91bd107bb8b3d7d3
-- 
2.43.0


Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2437754B;
	Fri, 12 Jun 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781298008; cv=none; b=jYg46Yo+t7C0murBATPIlHu7YS8XuYyCwBdfqXl3UE+U7/lmXo3uG8onjRahmxXC8O8hKR9rPN3Uu3o9yeOh+gFuAJ5PsMIKucKTrR4ATSv4ytvaBsC1zgB+Vq3ySm+Riq+UUAm62C9zlb0E0NkmIa8xtFRpdm/fFoS0CWwkQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781298008; c=relaxed/simple;
	bh=MnTlWXnA9OYO+S+1hQYbFnesde3b0uOWEzzavhIGK9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRiDGTFtfL44bJSflq3rAqOM+Lxy7E7rKgRnPkUxpXHWRHcbGAo2hWWLcU/S38G4xzz823O4sppA2ShiAFjelDTuEQDr8AS03525R8ZfEMBBNGlBT9IDQ75zyYlpf5/dLQIdWLr161/h/9mBUZ9xcclNltDt+WzC3qaQVQnHui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=labxXYwW; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="labxXYwW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75287A4F82;
	Fri, 12 Jun 2026 23:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781298003; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8rgv1C1KYhvNmP9EhM2vaA6On3DtJ3+S9NABs+9QcAw=;
	b=labxXYwWpClV0ZsjpfV2pZGB2j9GrgyemghJq3wU+aR/sgOY9kprwb1VUrWX3X6vwVSgGm
	BQsHlW4U7m6waP1gbHgDMhVVHjmSCrpk0VBNsKI4H9+9Jb+g4Iu5W8nb4S2glmM76Q3vG8
	eKs+Og1RZrWU8OTMuUp0Yvi7UrfFBaqE0dWsMy6btPD/qOpK/J24TQXuuzsCpR2/r4tSoV
	Kfna4dvxWudcZGvI7mnojDgacl8yZZN781IQt8w+6/gwE5DCf5/ZYGEdMV7LZJDTIZ7v+P
	6ZSX3g4J0Dr07/WdXfarIKKIN0niwktEU0KqaWVxmiYTvaWCCy7Vn9KpL+2yeA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 3/3] net: bcmgenet: allocate a single-queue netdev
Date: Fri, 12 Jun 2026 22:59:15 +0200
Message-ID: <20260612205915.3156127-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612205915.3156127-1-nb@tipi-net.de>
References: <20260612205915.3156127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The driver only uses TX ring 0 and RX ring 0, so allocating a netdev
with GENET_MAX_MQ_CNT + 1 = 5 TX and 5 RX slots leaves four of each
unused. Switch to alloc_etherdev() which allocates exactly one queue
of each kind.

No functional change: netif_set_real_num_{tx,rx}_queues() already
clamps the visible queue count to 1.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 25f339eb304f..001bd445b110 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3915,9 +3915,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	unsigned int i;
 	int err = -EIO;
 
-	/* Up to GENET_MAX_MQ_CNT + 1 TX queues and RX queues */
-	dev = alloc_etherdev_mqs(sizeof(*priv), GENET_MAX_MQ_CNT + 1,
-				 GENET_MAX_MQ_CNT + 1);
+	dev = alloc_etherdev(sizeof(*priv));
 	if (!dev) {
 		dev_err(&pdev->dev, "can't allocate net device\n");
 		return -ENOMEM;
-- 
2.53.0


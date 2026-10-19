Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427212;
	b=KdEotCuBSkIxw3+bMB3+FWaEN0bZ7arvughlmFFBIbyOxH340o5iX233aMTPuYxVxCfE
	 noYWlFChxxR3KDcMCOx69cg6+tS6OKojwX6cNXvOx7icX4JG+9qfqD06GG7f85OykP2+a
	 TEeXjSTa4Hn6qCxeHaawxtAeRMzXzydCGA+FSimkeFv8QflvxU5m0jgOVx+YKMisfkIZ/
	 8AACRWHY2SnmWun/qjrkSytytCxqhNrriA42R+7Fex+gS5oCbv3v095TJdbbS5xNEvARO
	 Ajg6lcf7ePZQ+1up3ZfBooCqVI4YWfOZ6xUC7tlzE0lLkNJH+iajojYk3TkBGbUAtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427212;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Id;
	bh=2Vryb/bgdWGX8AXBGKZLikDJ2wM1HUfIJw74M1UjXEg=;
	b=nOU5pvOcinWn3tSDqoMj8fkfo061WLIoi/pKBxToPYxXVfF6Cd4TBOP7oYMArUZSZBtz
	 47re9Ve44tWoflThA9Fvr5yajsJrQ3TaEj2r+R9qj2Y6qhois5sHhCZn4Wfno2G+qsH8z
	 YgnqI+RemYtnwsIoOMEjm4dnHsDW2lGG+qBijHUNxrFXvbjZMDud2hK1O7G1hVzFTmnj1
	 aVvZ7KExFo0wbJ3ABDGZ/ATiSVMOhe9/yA0pUd/u+pxEKexXr1M0GjH9lby3E+dwU3E+0
	 b/tU93m4cO2mvEwOfXTkb89eNz+59Qu7c0p8NtCZQ9tkEW+g/7qrM+bV4gbJO8/opPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.38
Received: from mail-e677.seohost-mail.eu (mail-e677.seohost-mail.eu [213.239.133.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE360A2614;
	Mon, 19 Oct 2026 16:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEE360A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xIqCH-000000037oW-1UEh;
	Mon, 19 Oct 2026 18:26:49 +0200
From: Piotr Kubik <piotr@kubik.pl>
To: netdev@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>,
	Piotr Kubik <piotr@kubik.pl>
Subject: [PATCH net 2/2] net: pse-pd: si3474: validate the channels of a PI
Date: Mon, 19 Oct 2026 18:24:53 +0200
Message-ID: <20261019162453.1244120-3-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162453.1244120-1-piotr@kubik.pl>
References: <20261019162453.1244120-1-piotr@kubik.pl>
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
X-Authenticated-Id: piotr@kubik.pl

si3474_get_of_channels() accepted channel 8, one past the last channel.
The driver then accessed channel 4 instead: quad 1, channel index 0.

It also accepted a 4-pair PI whose two channels are not a channel pair
of one quad. The chip forms a 4-pair port only from channels 0+1 or 2+3
of a quad (2P/4P mode bit in POWER_ALLOCATION, PORT_REMAP default), and
the driver sends every register access of a PI to the quad of its first
channel, so such a PI enabled and measured the wrong channels.

Reject both at probe.

Discovered by an AI code review agent; no shipped device tree triggers
it. Validated and tested on an SDG-9000 board (MediaTek MT7988A, two
Si3474) with Linux 6.18 and a modified device tree: one chip with a
channel at reg 8, the other with a 4-pair PI on channels 1 and 2. The
driver now rejects both at probe, and the unmodified device tree still
probes all eight PIs. No kernel selftest covers PSE hardware.

Fixes: a2317231df4b ("net: pse-pd: Add Si3474 PSE controller driver")
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---
 drivers/net/pse-pd/si3474.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
index 99e96f6bdefc..2f18714c95f1 100644
--- a/drivers/net/pse-pd/si3474.c
+++ b/drivers/net/pse-pd/si3474.c
@@ -250,9 +250,9 @@ static int si3474_get_of_channels(struct si3474_priv *priv)
 					"Failed to read channel reg property\n");
 				return ret;
 			}
-			if (chan_id > SI3474_MAX_CHANS) {
+			if (chan_id >= SI3474_MAX_CHANS) {
 				dev_err(&priv->client[0]->dev,
-					"Incorrect channel number: %d\n", chan_id);
+					"Incorrect channel number: %u\n", chan_id);
 				return -EINVAL;
 			}
 
@@ -267,6 +267,16 @@ static int si3474_get_of_channels(struct si3474_priv *priv)
 				pi->np);
 			return -EINVAL;
 		}
+
+		/* The 2P/4P mode bit pairs channels 0+1 and 2+3 of a quad */
+		if (pairset_found &&
+		    (priv->pi[pi_no].chan[0] ^ 1) != priv->pi[pi_no].chan[1]) {
+			dev_err(&priv->client[0]->dev,
+				"PI %pOF: channels %u and %u are not a channel pair\n",
+				pi->np, priv->pi[pi_no].chan[0],
+				priv->pi[pi_no].chan[1]);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427201;
	b=amTKbkhE3x0L55h6UmTJaexQ8ks3zrqcEJjz4rGc3TA6KCzWjYoGoKk0SwcMGAQ4ePcR
	 sXNW2mxzzZEg1cJYcgtA35B5M9MtWKk9V+qBmOr95rbGPMjNgBXLWKjaMrBWRb9OJ7I22
	 iLe3lgj9elTR7eVINbmir8QTrCuj+3Zy8Vh+grJodJ4MvsAcqA7suegNCaHbfN50lsTP7
	 XH9vbt7RtD7QrG8wCPKYZgB3VmnM6WzxwL2GUwH9fuLq64sAmxTOST14aejcGsTg/Kwak
	 JDHSa9kBrTiQof73rTT29n9ucKu+lSyyqk3xSmjiWJniXO9hSjyUSqJl/Xzyco5SxDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427201;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Id;
	bh=qoRXbK04cNKi6SEza1JnC/GwWIFm6k81kwXvhP8i5e4=;
	b=ym541d6LNqgEwma51iawLtmf94KUXd3QpAoydO6rVIJuwsmyVFcUk6ORWbnDy53Un5e0
	 khwgN/yJHZjEc1uv55xtd0dOb4/RiUL2ndsN1PPk6fMa0w5aoGZd9LHm0G8ydRheHX0Nb
	 zuURln0sPnEacN/yxWRBStgXAA07ZDYPNxCeOQ0FZdzpXWTAQFz3ilkNWeldjtnQc8oIP
	 p0irl0qiqf/wKAZWcUC/7BncAV9wl5XhJYGXeJzg4QkjPVPKyyadKMqwpM+Vx10IR111m
	 Pfo/gCAQPMeH0a5+o8iGvlMsrrTEFVZN7geMhQk9BDswUZ4u1E2kYd1eoB3t+dIQCAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.38
Received: from mail-e677.seohost-mail.eu (mail-e677.seohost-mail.eu [213.239.133.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6F606A339;
	Mon, 19 Oct 2026 16:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA6F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xIqC5-000000036tN-3UMR;
	Mon, 19 Oct 2026 18:26:37 +0200
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
Subject: [PATCH net 1/2] net: pse-pd: si3474: keep detection enabled on the other PIs
Date: Mon, 19 Oct 2026 18:24:52 +0200
Message-ID: <20261019162453.1244120-2-piotr@kubik.pl>
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

DETECT_CLASS_ENABLE holds the detection and classification bits of
all four channels of a quad. si3474_pi_enable() wrote the register
with the bits of its own PI only, so it cleared them for the other PI
of the quad. In AUTO mode that PI keeps its admin state and a PD that
already has power keeps it, but the port runs no new detection: a PD
plugged in later, or one waiting for detection when the other PI is
enabled, gets no power.

Read the register and set the PI bits, as the PORT_MODE update above
already does.

Discovered by an AI code review agent. Confirmed on an SDG-9000 board
(MediaTek MT7988A, two Si3474 in AUTO pin mode) with Linux 6.18:
with both PIs of one quad disabled, enabling PI A and then PI B left
DETECT_CLASS_ENABLE with the bits of PI B only, and a PD on PI A never
got power. No kernel change was needed to reproduce it.

Tested on the same board with the same sequence in both orders:
DETECT_CLASS_ENABLE keeps the bits of both PIs, and the PD gets power.
No kernel selftest covers PSE hardware.

Fixes: a2317231df4b ("net: pse-pd: Add Si3474 PSE controller driver")
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---
 drivers/net/pse-pd/si3474.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
index 1845b9c51cf7..99e96f6bdefc 100644
--- a/drivers/net/pse-pd/si3474.c
+++ b/drivers/net/pse-pd/si3474.c
@@ -312,8 +312,13 @@ static int si3474_pi_enable(struct pse_controller_dev *pcdev, int id)
 	/* DETECT_CLASS_ENABLE must be set when using AUTO mode,
 	 * otherwise PI does not power up - datasheet section 2.10.2
 	 */
-	val = CHAN_BIT(chan0) | CHAN_UPPER_BIT(chan0) |
-	      CHAN_BIT(chan1) | CHAN_UPPER_BIT(chan1);
+	ret = i2c_smbus_read_byte_data(client, DETECT_CLASS_ENABLE_REG);
+	if (ret < 0)
+		return ret;
+
+	val = (u8)ret;
+	val |= CHAN_BIT(chan0) | CHAN_UPPER_BIT(chan0) |
+	       CHAN_BIT(chan1) | CHAN_UPPER_BIT(chan1);
 
 	ret = i2c_smbus_write_byte_data(client, DETECT_CLASS_ENABLE_REG, val);
 	if (ret)
-- 
2.55.0


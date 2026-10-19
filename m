Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427177;
	b=sK92xvUK5oyCbRhkDZ203W4yhSUKds2jpIcSBEn/oX5wrXfnzBL251j8oLvbqWKAW5mZ
	 +j621poIHo/hDpqfzBknnaPAWi/0wFHwOHluXrcDUqMdJibCDFi0k+enYZvZvb2wEfTvJ
	 Z5P6s83F7c5Ev/A6JK7PM5ZYsHghM+FoPYD/7iyqR2UJQpeO1eCBcovdBjKdB056toY95
	 0PWglw46X610jbZKSdFdTuU0GV8RbZaICmbW2RJCoQR7atjGCYzvQHhKhLxbhoYpKcaE0
	 C30VdUrPrVQOUh4/8O8ZF8hX6EjDv5QXZ9CTEPMSmsY6IyvF2qgwjXgSn8kbwA52iFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427177;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Authenticated-Id;
	bh=1kdG8GQ5F1yW/RvBshLO/ATOMmsru7igsd0wbeattQg=;
	b=H/vvjs7xvALS3VWWxY1AZuSHuVs4I5Px8VVS5hz/i2ZjmnETjM9dk9uRj7tOm4Dvenl0
	 s/+b1Eeh42DYQStHLR8MlUodgzzgDHPXZcKQYjNLx8oAJ0OyVLc1wdejiPVeizHkmVJrT
	 0HvjBnNRSELxozhrqYEAPfEM8QQjQrdUUbs9Egza1z4NKrQ7iBxw6aWRucw0D4HnoD6Y1
	 pm2tcuK9ofdm3InSNOayOogEuBWuPa+Qn9lfuCrtjOmf/j8nVaCpVPZDdKJ2o4k3uYncx
	 wc4zd2ZAPzQ2y4EX6s2hyhYJTPfzbVHl8ilZZ7RFCMsKRRU5TAc34dULW7aIU97qEAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.38
Received: from mail-e677.seohost-mail.eu (mail-e677.seohost-mail.eu [213.239.133.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D860A4ADA;
	Mon, 19 Oct 2026 16:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169D860A4ADA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xIqBg-0000000346r-26XC;
	Mon, 19 Oct 2026 18:26:12 +0200
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
Subject: [PATCH net 0/2] net: pse-pd: si3474: two driver fixes
Date: Mon, 19 Oct 2026 18:24:51 +0200
Message-ID: <20261019162453.1244120-1-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
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

Two fixes for the Si3474 PSE driver, found while preparing 2-pair and
semi-auto support for it.

Patch 1 stops si3474_pi_enable() from clearing detection and
classification of the other PI in the same quad. Without it, a PD on
that PI gets no power after a later plug-in.

Patch 2 rejects a channel number of 8 and a 4-pair PI whose channels
are not one channel pair of a quad.

Both were tested on an SDG-9000 board (MediaTek MT7988A, two Si3474)
with a Linux 6.18 kernel that carries the same patches, and build-tested
on the net tree.

Carlo Szelinsky's "net: pse-pd" series [1] also touches si3474.c, in
si3474_i2c_probe(). The two series change different hunks, and his
patch 9 applies on top of this series.

[1] https://lore.kernel.org/all/20261018082314.48950-1-github@szelinsky.de/

Piotr Kubik (2):
  net: pse-pd: si3474: keep detection enabled on the other PIs
  net: pse-pd: si3474: validate the channels of a PI

 drivers/net/pse-pd/si3474.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.55.0


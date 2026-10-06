Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADC22425B;
	Tue,  6 Oct 2026 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265319; cv=none; b=ikkfzRC3e9WsikOGrKHNE4HV/3XjxoAttfQ58hkV8dehAFPbvCIgp2+DMBHAXtQivdvEXpl8sIwoVX7+khDqTehKpzjgU5qqWr45hkBQjFZXdszPtR+rlyeNFXGkQ0Jt8lIiJh+3OSYIFGxINAhf0I0XU7xek1NrY69QEhPyM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265319; c=relaxed/simple;
	bh=PWHaIG+hpIuWhukDfcDeVqxPTpgjqMFqZCrFjrbSDP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dA7WRrGxEtqWrcXNFS09VZsGS9aR7MqInD24fRxPAqxru8dHl/1mmVTG7YtBjJA3VF5AbKuXtMhlPXtq1qvQ4xiSolMODA7BEeB1+iw324zQGGBgQ3JZIDAVduS6FD/b6JZIeQl+rgFVZ0rbdkRiI+rY6pW14Xxq7MFZKOWlNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AuV0kEBg; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AuV0kEBg"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B327A012B;
	Tue,  6 Oct 2026 07:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791265312; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=O7KRJAu4AekxCDbbfQHLexeWodWBOMLMHcaqzIyiIDg=;
	b=AuV0kEBgvRyRq6PIKlIIdlGoen15xSN9lw6/NKQnozvzTdVDbPqDW7dlLhOUBnSbuIzaBa
	q/WufE238zElcX2h2DmcP51kXc0++89RtHpF4QmqhvfBabWbfjrpGhUKl0+Vd1IXoLsH2H
	6/KSCmGW33w8rUwsIv/UbLV7Ss+uBmt5cw9Yehy85dXOdWhDfbWSnBl2DHWku7Ygii2Vig
	9ygIj5UlhhWY7mNkXovqwpKdeXPioc8kiCOpuWVXVvQVFXGtQKO0xKuQSSc5V6q2y52HtA
	xu2whDCWHyLkE0/1sSU3+1HgUU6G78PbAvKoe2MLBpoNvBezmjZK/Ql5MINW3Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/2] net: macb: fix software FCS handling of shared and
 requeued skbs
Date: Tue, 06 Oct 2026 07:41:31 +0200
Message-Id: <20261006-nb-macb-shared-skb-net-v1-0-a80641479041@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G+jign5FPLQaNYhVGhFB/LvF4
 8DMPCAUmQTa7IFIFwvvIYHOMxgWF2ZCHhODUabSShUYPG5u8CiLizSirB4DnaitroumKa01HlJ
 8RJr4/scdJAH69/0AAK+WKm0AAAA=
X-Change-ID: 20261004-nb-macb-shared-skb-net-13174995332b
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

While testing the genet MTU series I used a Raspberry Pi CM5 (RP1 GEM)
as pktgen source for the CM4. With clone_skb the CM5 rebooted after a
few seconds. Further investigation showed that macb_pad_and_fcs()
appends the FCS in place, so the shared skb grows with every transmit
until BQL completes more than was queued and dql_completed() hits its
BUG_ON.

The same code also modifies the skb before the TX ring check, so a
NETDEV_TX_BUSY retry gets an skb that was already replaced or grown.

Patch 1 checks the ring first, patch 2 copies shared skbs.

Tested on Raspberry CM5 with pktgen at 60/20000 bytes, clone_skb 0/
1000, burst 1/32.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (2):
      net: macb: check TX ring before modifying skb
      net: macb: copy shared skbs before appending the FCS

 drivers/net/ethernet/cadence/macb_main.c | 80 +++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 31 deletions(-)
---
base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
change-id: 20261004-nb-macb-shared-skb-net-13174995332b

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>


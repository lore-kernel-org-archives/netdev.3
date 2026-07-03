Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19B36A36A;
	Fri,  3 Jul 2026 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063876; cv=none; b=WBQiTI9ii5zIkOIe4rmddUVhUcLZrJxssBCrfNNMxpvktadzxXnowLbwTEs5P0w7No41TTIcoGNNeJ6yKs3keuoJUnpvlUo5JDWPn0/aTXQor7tBVJhEuGrpLnB9xqo2ckHLlspagbBpzIrxaR1Qr9EqVUhrnAQxMYNDS39vIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063876; c=relaxed/simple;
	bh=CxzlnR1f/DDQDS8RilC/FzpK0ckPfxvTo8UksGTUFLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xv5qZpFdiVh/N48HBYHivQPZC7geAQe42gUsgIbYrI3p7sCL6VAAgxCh8bLSRR3RMiUGv6tP4ZgFgToqtEwfn9T5Yk79clpi7DuY3pAMU/NInrjoIfV5Ztg+5SiebP5koybXMTnBbIasHbIzhs/2w0ieZ8kRkwtS7j9wNEnqHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=rcSHhCq/; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="rcSHhCq/"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1307D60C04;
	Fri,  3 Jul 2026 03:31:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063874; bh=BhVyJk5bz8mYY+Md/25oDatUkQdqF6OKx9DwNdQJu44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rcSHhCq/sH8+UlquNnVjx47fo23f3u48VqJYQ0NfNT90s7VEZ8IKzw+0Nu+zn9qZe
	 vT/hYg55TYbMxHCDEyFQnLXEiq8JIxQ6BO/nabfYU3380geaVZDxFjmEHzTTbs4n0Y
	 d9eDSyrz6g7ZpY9zXmhvB8vVb9oxBWQbUA8Jm934KvgCxX4wEBHa5VnPYDVI8qA4+f
	 oeJ7+ceN3wi5U7Or0ksel376NI7CKI4FyDtrgdODrVYnc8ytZUGyFtVJONMAeFEOpo
	 8peguWRce4MJPELwxr3lIzG5DQfUCYUVX/QUEm/pGLDk9XbcuKhdHYcir2w8BboRfp
	 xSO8aMd4d3tXg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:27 +1000
Subject: [PATCH net-next 08/12] net: dsa: qca8k: Update error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-8-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
In-Reply-To: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=1797;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=r9aa5ujg4q3o81ZX5B2iE5V6bY3r4vvx2W68uZvw+TI=;
 b=gjV1Xc2MBvim/RkqPlxpWZnOgDn8zevIcTNXnxTqoPKrvXYqJfYm3A/G1PLgaM/QJIcC4KadO
 hj31cY1Ob7TC5Hk6UsUBBZtysv/iU63jKsqWOaLHycdkqR8N2d+SbTW
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

From: Andrew Lunn <andrew@lunn.ch>

Now that dsa_inband_request() can return positive values for the
length of the received reply, the return value checking needs to
change. This driver only uses short messages, and it is unlikely the
hardware will actually receive messages of less then 64 bytes. So
don't check the message length. However, ensure the return value is
either a negative error code, or 0. Ensure all users of
dsa_inband_request() return either a negative error, or 0 on success,
so as not to change the API.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ffa3b1ba23bed..94332497902c2 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -341,6 +341,7 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 				 QCA8K_ETHERNET_TIMEOUT);
 	if (ret < 0)
 		goto out;
+	ret = 0;
 
 	*val = data[0];
 	if (len > QCA_HDR_MGMT_DATA1_LEN)
@@ -574,7 +575,7 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 				 data, sizeof(data),
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	*val = data[0];
@@ -664,7 +665,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 				 NULL, 0,
 				 QCA8K_ETHERNET_TIMEOUT);
 
-	if (ret) {
+	if (ret < 0) {
 		kfree_skb(read_skb);
 		goto exit;
 	}
@@ -685,7 +686,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 					 resp_data, sizeof(resp_data),
 					 QCA8K_ETHERNET_TIMEOUT);
 
-		if (ret)
+		if (ret < 0)
 			goto exit;
 
 		ret = resp_data[0] & QCA8K_MDIO_MASTER_DATA_MASK;

-- 
2.43.0


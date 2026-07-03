Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC90370ACD;
	Fri,  3 Jul 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064877; cv=none; b=Wz4tcS5Qt/Kd30hcoKjjZ23L36QEkoUKPLwNX9fy7aF6yy9QzBIpohQEhjqGpUSU0nGAeBluoJzOEcOK4jmGebXW3HVNP+ZhXoXTy6c+M67lsYD8IU6uWSmwoAY2ueP5T0pvFbmxEiLLxSyQQdZusrtugesOS0kLed1kcfstn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064877; c=relaxed/simple;
	bh=GmijxIf1JZsLeDnYRvQ3vzJbiSe6WsGGDf2U0VCNQ+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5K7tmDRJnfgxO8zKZFrVxrp5hZTlReOp+L3QJ6Ol8gIHl7bj8pxDxDc1oLWpUO+p4FwRQ3PbmBHaKJt40eH8+0Fn7Qr8ofy3JJtkeqRr2I0z9cSpi1wDCIZl35S9tTCd2Oq2Pk+wXOjB1fEtOcET5soum7WdqtR73bupHikAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=OAvAw9Jk; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="OAvAw9Jk"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id BF50160C0B;
	Fri,  3 Jul 2026 03:47:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064875; bh=2R42+sSKqQiPgnGVDasAndv1FXCuG7A99qjgPXJOtV0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OAvAw9Jkx16wlx6gd2YRP5rB79fHYaLUMfMgrE166DCSRpoTHOlVRgQUyPbNuARYZ
	 pLAJTnTq9KLTug66bCAQ2kbiM6TIsehl1FpM6Yx5fnAlRXb9LTtutudn7qcOBFLMS9
	 YDhuaPmD9b+KUj9yd94d5CHwS6alEn+swPRGeqp8UKpQRebnFJlkCujwMhVuQXiftI
	 bkG4L7v5tENMGc2DCCI0FttaRxbeEmGxjhP7jiz3p2amPzia0tP4KKUjNS5LF3VBly
	 Doy5vGMa9Td/d7r7JWKdrZ5fRbgrJ7QCHtU66UZ92zS75DCy8CM414BThbbca1x6LC
	 YN5Xbfb//WMag==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:50 +1000
Subject: [PATCH net-next 16/17] net: dsa: mv88e6xxx: size ATU snapshot
 buffer and region by num_macs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-16-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=1295;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=GmijxIf1JZsLeDnYRvQ3vzJbiSe6WsGGDf2U0VCNQ+I=;
 b=0WmFw5kjBUFkrHjOvnt2odgquLtpvic0t1HkkdFwsdpei/I4k6742DJoTGGLDTk1OtAHT5Qzt
 I2/7Quf3ZrLAAFTAKjiVEVu2qrRB7lBwW7Fd5PNAMAE7dLnspA1z+He
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

The ATU devlink region and its snapshot buffer are both sized by the
number of forwarding databases, but the ATU can hold up to
mv88e6xxx_num_macs() entries (which is 8192 on the 6352 series).

Fixes: bfb255428966 ("net: dsa: mv88e6xxx: Add devlink regions")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index 6f034841883c6..6d7da381f9f38 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -380,7 +380,7 @@ static int mv88e6xxx_region_atu_snapshot(struct devlink *dl,
 	int fid = -1, err = 0, count = 0;
 
 	table = kzalloc_objs(struct mv88e6xxx_devlink_atu_entry,
-			     mv88e6xxx_num_databases(chip));
+			     mv88e6xxx_num_macs(chip));
 	if (!table)
 		return -ENOMEM;
 
@@ -776,7 +776,7 @@ int mv88e6xxx_setup_devlink_regions_global(struct dsa_switch *ds)
 
 		switch (i) {
 		case MV88E6XXX_REGION_ATU:
-			size = mv88e6xxx_num_databases(chip) *
+			size = mv88e6xxx_num_macs(chip) *
 				sizeof(struct mv88e6xxx_devlink_atu_entry);
 			break;
 		case MV88E6XXX_REGION_VTU:

-- 
2.43.0


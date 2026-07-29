Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5E1EE7C6
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785367832; cv=pass; b=k957gSK0Sy+F9NQ8077WUktowis1ach9svnY9M4MkKIjAv32scMFExrWQOpGyhLhMZAyHiuuMMHsJs5mcLWp5qBgy0IkBgu4NW1fIbBsi2v+ZfzYO+4C7h2gcf5S2GaP5TYyWQewIDzVmWreg7pgpLytYd7xHNdr/Ih2CM1//vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785367832; c=relaxed/simple;
	bh=hG/QRem0sX6Qo/jmoUIpUfL1fjbaSOt8VqmuEuYnE6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME6UT/RkEsHI4XM2AB5B5YotWifbcUqwPCZWgdI8SBItGyw/hIbIFMjnjH4/Y5rc9GG686s0srCYdrZoBzgUm/fTlhG7P4Hxa8u83iAfOt1s2gBcXW1pchCFoMMDfT7GHcHU+Ui9FJeJifr9NR2+VdLnzZGU4Erdt6x7dL4Ft1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ft0WpsJ1; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ft0WpsJ1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf41bab353so26225445ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785367830; cv=none;
        d=google.com; s=arc-20260327;
        b=b4u0jEQvMntxn5X3v3N/4hjr/gjVghplvJMKoU1bkmQcoUe76DSuEfSzR2+O2yjgX+
         ATU23poAhQel2KPEaQ5PyFEdU8WZn1IAQ8C72/dd2vxEcu+ajVCmIwD3WRUx+/n5k0+W
         +Dwvk1awoYvEBylIXBi4xseWKWdBcrLr9S6uDrjWJaFc+/xOAITs89sezkVrZ/+oTTLF
         H0VnbCXSk6pfJGaoUPZukwuxtU0XIC+UccrWPGWJVTJ7LF0IceoQq+l8s8qniZqSWkNM
         YH6NuBUI6JMEBwEIGXthOO9hfVCJI3OyBXpnUFflT4YGenxYoGwa9HRNW2EkNNvV+KSN
         Srbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wxxf2QhWWZ+fp4BhL82ATMjU1Qp6blyuGYMZO2K0Wy8=;
        fh=+9SB16GGv1zbFfk5k2eLJnZhHboGWF2Fqr4YW7ZJ80c=;
        b=HbAG+GqZ5X/QYa+GglSpVQ5cZYEdaus26FCl00k+DTDaU+Stkapkcn1oIkwBysYusI
         PtpYlGXi9Kr+92FkqqnPRdEOw/jJMI7QQmDD7wHM6j6Zi6HM3j6YWsDvcMLkHT95lPcX
         ZZ/TdrEUOJhSuqPci2s05CE9UzdS1zExSIzuV+V51Vi/pbCssIWswy8Xq9/Ip2Exb53Q
         yheN9UAQJF2frVmkM9KVnNMgRJJ01/Twsr3FhS0z9MwJx/vIqu9cUegaEOCtfsFB8+7/
         dZ4uy1tQrXIigWDVjKe9PEACgLrPtev1NnqD0/BpahCisoQirHaMzmX6Sb28gyCXWK9g
         sOmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785367830; x=1785972630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wxxf2QhWWZ+fp4BhL82ATMjU1Qp6blyuGYMZO2K0Wy8=;
        b=ft0WpsJ1ZcVdae4hF9s6tgeBZ0S95CCkKmxWlkybeJ8UfOwBlHN6KShutb8Db6MwB1
         /UxUk69h7eyOtHhs1uYwiU1WF1j1rZ2XCt4kZTlUZuwH8NVe89jPt1ORL5gIcmRRVIhS
         KnmHzB5DLASTn8iRsFsLs0ukw3LQSIngRJbfk5TZwdn910uuLPqFky6b9KhURzpXiZQv
         64wJlyeanJ9hwhcQAVUvZRv9H0NxiEPQbQ0BQu6pY+uNjbE/trbfl7/eheAQH6zPXL/4
         PX6zl2exeRXmsiEEYoMhKZTXksKmGQv7VjnnHmw0xN46xj3GhnFjKWv/NcL1PGQWJ25c
         atfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785367830; x=1785972630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wxxf2QhWWZ+fp4BhL82ATMjU1Qp6blyuGYMZO2K0Wy8=;
        b=hMrgip2dM49nAj4d3iLP7Tk8H3e+X06o9EHrHLP1cW43Ph4d95uTRJES1o1fQiOvRo
         CfsiFF8QQMoLbQRi2kiozoLsG2U9APUILD6KpRUlgvBxt45eBJUzCMl0jy7XmUnCj0ki
         10VSN9FtopJUf3M1kNJTpYxfp8bW/gNkO/JHzZmGUYqovRnbkEzn3qM868EUC2TnceN1
         FxziLFLvfjseRIS8o8G5Z6gyRIwRFtGgec5TASdN4P+XpoQTpbB15cQRuubyJne2ykCe
         jo40nDUjPDfZQ1CsNwnsk7A+4Pwq10sJ71BrX33/RIU4qm5XBHWpl0N0hOFV0w3iQvWb
         +z7A==
X-Forwarded-Encrypted: i=1; AHgh+RrfZAAgYAdYR3mMqBljRn2M97Cjd64DmNSXSZtbFpJfaz48/QepDmRQe4eI5mvYUWJAXiaG6H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6bKcUB90go/pnF81OPK57wbFvWM1mWJob6V4QQWjLNTga4NC
	Bw4pnOAcmVTnMhZ7DY3EnaepK/aSJNcPNYmopeWD5mCgkU+1cU32jtpvxtjz/ebL3nY9RfET2N0
	rJr2BdFndbiufSHH/5bZh7j/bbfgocANu3LG1JPA0
X-Gm-Gg: AR+sD11ztXb0eSEVmL4TvPlHVDOoCo6KZdenrYNxaK1Pr4+DzEVQzs/Oiu5NFILykN5
	Mg/QZGQuYZaBN1g9Gq545E/1P7NzDpWDHV/5iZQSLJOdm5EZieQdJrH1QFMkB4awa+IliBurPWp
	5ke6YIyB2Jjjy6tKMdanfz8WbD5qOYzDTG5U/FnzsyN5N28GEKp4G7YyFlXUDzUktTdeYpJhWf6
	zpAOR6CdZwaLChHchzKFJBFUAxRTrEqyfAOc3eML+yn750td1Q1s7xOeS4RLm8v5dTHxotp4iQu
	INk9bOTwMagpBKJKoWqlCi2R57HyHLawI/ZWTbFlXu0Yuv+/9cBaY9uMCfZdjBNnY7HjKQf1D81
	+
X-Received: by 2002:a17:902:e949:b0:2cc:84e7:73bc with SMTP id
 d9443c01a7336-2d035cef4d3mr3233925ad.32.1785367828768; Wed, 29 Jul 2026
 16:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719232153.1405569-1-xmei5@asu.edu> <2820549.1784570299@famine>
In-Reply-To: <2820549.1784570299@famine>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 29 Jul 2026 16:30:17 -0700
X-Gm-Features: AUfX_mx6C_wJ3lx8I9w3Demh4eLyF5-z6HPyf7zn9EDcdVPxG7aPsSCcI4gSWz4
Message-ID: <CAPpSM+RkHO7uEVrEbqgfundSbiLU67enaSXhtk6mL8bXzC17xQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix skb_under_panic in bond_ns_send() over
 stacked VLANs
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, and sorry for the slow reply.

On Mon, Jul 20, 2026 at 10:58=E2=80=AFAM Jay Vosburgh <jv@jvosburgh.net> wr=
ote:
>
> Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:
>
> >bond_ns_send() builds an IPv6 Neighbor Solicitation with
> >ndisc_ns_create(), which reserves exactly LL_RESERVED_SPACE(dev) +
> >sizeof(struct ipv6hdr) of headroom for the later ip6_nd_hdr() push.
> >bond_handle_vlan() then inserts the collected VLAN tags into the skb;
> >each inner tag consumes VLAN_HLEN of that headroom via skb_push(). With
> >enough stacked VLAN devices between the bond and the ns_ip6_target, the
> >reserved IPv6 headroom is exhausted, so the subsequent
> >ndisc_send_skb() -> ip6_nd_hdr() -> skb_push(sizeof(struct ipv6hdr))
> >underflows past skb->head and hits skb_under_panic().
>
>         How many stacked VLANs is "enough"?  I'm guessing that it's
> somewhat device dependent, as LL_RESERVED_SPACE includes
> dev->needed_headroom, but as a ballpark here, was it more in the realm
> of 3, or 30?

Exactly 6, and it can only ever be 6, because that is also the deepest
stack the netdev nesting limit allows.

For the veth slave in my reproducer LL_RESERVED_SPACE(veth0) =3D 16, so
ndisc_alloc_skb() reserves 16 + sizeof(struct ipv6hdr) =3D 56 bytes.  With
N VLAN devices above bond0, bond_handle_vlan() puts tags[0] in
skb->vlan_tci (costs no headroom) and pushes the other N-1 inline at
VLAN_HLEN each:

  headroom before ip6_nd_hdr() =3D 56 - 4 * (N - 1)      (it needs 40)

    N =3D 5:  40  ->  skb->data lands exactly on skb->head, passes by 0
    N =3D 6:  36  ->  4 bytes short -> skb_under_panic()

N >=3D 7 is unreachable: veth0 -> bond0 -> v0..v5 already exhausts
MAX_NEST_DEV (8), so creating v6 fails with -EMLINK in
__netdev_upper_dev_link().  Sweeping N =3D 1..7 on the unpatched kernel
panics only at N =3D 6, and it panics on every boot; with the patch
applied the same sweep is clean throughout.

You are right that it is device dependent, but only in that first term.
The panic needs hlen < 20, i.e. hlen =3D=3D 16, i.e. hard_header_len +
needed_headroom <=3D 15.  For an Ethernet slave that means
needed_headroom <=3D 1, which covers veth and plenty of plain NICs.  A
slave with needed_headroom >=3D 2 gets hlen =3D=3D 32 and cannot hit this a=
t
any legal stacking depth.

>
>         Also, why doesn't the skb_push called via bond_handle_vlan ->
> vlan_insert_tag_set_proto -> vlan_insert_tag -> vlan_insert_inner_tag ->
> __vlan_inser_inner_tag trigger the skb_under_panic?
>

Because __vlan_insert_inner_tag() grows the head before it pushes:

        if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
                return -ENOMEM;

        skb_push(skb, VLAN_HLEN);

so short headroom means a pskb_expand_head() realloc, not an underflow.
ip6_nd_hdr()'s skb_push(sizeof(struct ipv6hdr)) is the only unguarded
push in the chain, which is why the fault always lands there.


>         Does adding one or two more nested VLANs move the panic into the
> above call path?
>

No, for both of the reasons above: there is no room to add more
(-EMLINK at N =3D 7), and skb_cow_head() would absorb it if there were.

> >Restore the required headroom with skb_cow_head() after VLAN insertion
> >and before handing the skb to ndisc_send_skb(); drop the probe on
> >allocation failure. For paths that did not exhaust the headroom this is
> >a no-op, so previously working configurations are unaffected.
> >
> >  skbuff: skb_under_panic: len:84 put:40 head:... data:... tail:0x50 end=
:0x180 dev:veth0
> >  kernel BUG at net/core/skbuff.c:214!
>
>         The above text doesn't seem to match with current net-next:
>
>         pr_emerg("%s: text:%px len:%d put:%d head:%px data:%px tail:%#lx =
end:%#l
> x dev:%s\n",
>
>         I presume you replaced the "head:" and "data:" values with
> "..."; did you also edit out the "text:" that should precede "len:"?
>

Yes, sorry, I over-trimmed it.  Orignal:

  skbuff: skb_under_panic: text:ffffffff85eef44b len:84 put:40
  head:ffff88801400b740 data:ffff88801400b73c tail:0x50 end:0x180
  dev:veth0

data is 4 bytes below head, i.e. the N =3D 6 case above.

Now the part that matters more than the panic, and that changes what the
right fix is.

Following your VLAN-insertion question, I noticed vlan_insert_tag() passes
mac_len =3D ETH_HLEN, i.e. it assumes skb->data is at an Ethernet header.
That holds for bond_arp_send(), because arp_create() calls
dev_hard_header() first.  It does not hold for bond_ns_send():
ndisc_ns_create() leaves both the IPv6 header and L2 to
ndisc_send_skb(), so at bond_handle_vlan() time skb->data points at the
nd_msg.  __vlan_insert_inner_tag() then memmoves the first 12 bytes of
the ICMPv6 message down by 4 and writes the tag at payload offset 12,
and transport_header is left stale, so the checksum is stored 4 bytes
per tag too late.

Sniffing the slave's peer confirms it.  With two VLANs (one inline tag,
VID 11):

  60 00 00 00 00 1c 3a ff          payload_len 28 (+4)
  87 00 00 00 00 00 52 db        cksum 0, 0x52db written 4 bytes late
  20 01 0d b8 81 00 00 0b        the 8100/000b tag sits in the target
  00 01 00 00 00 00 00 00 00 00 00 02

So bond NS monitoring over more than one level of VLAN has never worked:
no peer can answer these probes.  The panic at N =3D 6 is just where the
same bogus insertion also consumes the last of the ipv6hdr reservation.

That makes the headroom-only patch the wrong fix: it stops the crash,
but bond_handle_vlan() has already mis-tagged the packet by then, so
every 2+ VLAN probe stays corrupt.

Both symptoms have the same cause, tags inserted before any header
exists, so the fix is to build the probe in the order the stack uses:

  - push the IPv6 header first, so the reservation is consumed up front
    and the later tag inserts grow the head via skb_vlan_push() instead
    of eating it;

  - run the probe through NF_INET_LOCAL_OUT as a bare IPv6 packet,
    exactly what ndisc_send_skb() feeds the hooks today.  This needs a
    small export (ndisc_attach_dst()) because ip6_route_me_harder()
    dereferences skb_dst() unconditionally;

  - only then push the link-layer header and add the VLAN tags, so they
    land at a real Ethernet header and the target address is untouched.

With that applied the N =3D 1..6 wire capture is clean throughout.  I kept
LOCAL_OUT deliberately so NS monitoring keeps traversing netfilter the
way it does today; dropping it would be simpler, but a silent behaviour
change.

I am not familiar with the bonding and ndisc internals, so I posted it as
an RFC rather than presenting it as settled:

  https://lore.kernel.org/netdev/20260729230119.2717507-1-xmei5@asu.edu/T/#=
t

Thanks,
Xiang


>         I'm wondering because without the actual values, it's not clear
> how far beyond head the data pointer went, and thus whether adding more
> VLANs would move the failure into the VLAN tag code.
>
>         -J
>
> >  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >  Workqueue: bond0 bond_arp_monitor
> >  RIP: 0010:skb_panic+0x142/0x230
> >  Call Trace:
> >   skb_push (net/core/skbuff.c:224)
> >   ndisc_send_skb (net/ipv6/ndisc.c:454 net/ipv6/ndisc.c:506)
> >   bond_ns_send (drivers/net/bonding/bond_main.c:3255)
> >   bond_ns_send_all (drivers/net/bonding/bond_main.c:3313)
> >   bond_arp_monitor (drivers/net/bonding/bond_main.c:3458)
> >   process_one_work (kernel/workqueue.c:3322)
> >   worker_thread (kernel/workqueue.c:3405)
> >   kthread (kernel/kthread.c:436)
> >  Kernel panic - not syncing: Fatal exception
> >
> >Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> >Reported-by: AutonomousCodeSecurity@microsoft.com
> >Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> >---
> > drivers/net/bonding/bond_main.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_=
main.c
> >index e044fc733b8c..3ac3418c9498 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -3251,6 +3251,10 @@ static void bond_ns_send(struct slave *slave, con=
st struct in6_addr *daddr,
> >
> >       addrconf_addr_solict_mult(daddr, &mcaddr);
> >       if (bond_handle_vlan(slave, tags, skb)) {
> >+              if (skb_cow_head(skb, sizeof(struct ipv6hdr))) {
> >+                      kfree_skb(skb);
> >+                      return;
> >+              }
> >               slave_update_last_tx(slave);
> >               ndisc_send_skb(skb, &mcaddr, saddr);
> >       }
> >--
> >2.43.0
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5C5348C70
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321559; cv=none; b=n2kKooDXAK5EVr3B3/MhxDpR8W+YNAiz51V34vMZ3g7IznFtIHdyV3h7aZUc3eGS0N3WZiVBfkePhHcmM7hkQdnoy4pXoBGpkpW646MAt+U3m6wG1yhijhy51UxLBrxFgO71nR6GXXZKyGHSSfzcpZraOeICWxKSp1J+aJMD6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321559; c=relaxed/simple;
	bh=KqMCsFrbIX6z9wBotO+910SMeXxGA7Y5TmURpJPdz1Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GohspqJpXdNlRYMAU0ioyNX/4FyfvkX7DQomwrovmMZZjDbpIic9HdhT5kdEPCDABR2a5YOJCJpWpIPLx2orn3Ehbt/3jM03oWFk3d6BRqhVwQQBQ6TrIwJP+LcczgMnzp9mfbUsJZEjeKeef3tdASfA5c8q21Ej7x7E0h6mEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=gdrs4FL6; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=fukqaDe1; arc=none smtp.client-ip=160.80.4.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="gdrs4FL6";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="fukqaDe1"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 65OHItvm010517;
	Wed, 24 Jun 2026 19:19:00 +0200
Received: from lubuntu-18.04 (unknown [10.172.30.234])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id B41EE1228D4;
	Wed, 24 Jun 2026 19:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1782321530; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cZ3TDFu2xRlVMi4gjjFeX9epN7KpgU+YS8fpU9SnlM=;
	b=gdrs4FL6xystr7jfsI8eQt+AliK1SmYqu/mMF0dfXGgQkLTP2WlK/o33ZIMmqSpFfkQwry
	MQoh6Fu8FoWAVqBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1782321530; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cZ3TDFu2xRlVMi4gjjFeX9epN7KpgU+YS8fpU9SnlM=;
	b=fukqaDe1TIHibIacF/xlFFOVRWxeXI6Be9X1gtieB9gRFl39FQ1Jn68pcOEXktFpDO5END
	Ex1dcP3DWnNQzrUmnotXdaMYQDWws/uUuIXu7yqXmTgMMECiM/vNoNWz6Sp5euzEUl8Ufa
	sqcOyQG1/cFvoKarfD47F1I8FkuDGrSWwDlqBUOFtSBOO27UtzBX0zvVLaQ6AHkTWH6OmA
	W/yBlV2p7gEhyZYy5RU44pTUxnMGara9mfoe4L7HvzHegvSOsWzetfiVVFV746qqJN+Kgk
	Ou4kYKutiYSOft1PEk6LYHgSK/AzF0gYpnUNB5QjNHOGv7Bzh7PmgYQ82GJFEg==
Date: Wed, 24 Jun 2026 19:18:50 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Anthony Doeraene <anthony.doeraene@uclouvain.be>
Cc: netdev@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        stefano.salsano@uniroma2.it,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [Bug ?] Packet with End.X segment not correctly forwarded to
 nexthop
Message-Id: <20260624191850.55dd7be54ccc935743f5bc8a@uniroma2.it>
In-Reply-To: <3fe17ca9-25fa-4fb1-ba06-4463e0409a8b@uclouvain.be>
References: <3fe17ca9-25fa-4fb1-ba06-4463e0409a8b@uclouvain.be>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Fri, 19 Jun 2026 15:25:09 +0200
Anthony Doeraene <anthony.doeraene@uclouvain.be> wrote:

> Hello,

Hi Anthony,
thanks for the description and the reproducer.

>
> I am currently experimenting with SRv6 and VRFs, and I found some weird
> interactions between the two.
>
> For the context, I need routers to have multiple VRFs, with each VRF
> having different routes to reach destinations.
> Our routers not only send packets to a specific nexthop, but also
> specify the VRF that the nexthop
> should use to forward these packets.
> To achieve this goal, routes in these VRFs push two segments: a local
> End.X segment, and a End.DT46 segment.
> Due to some implementation constraints, I want to have a single End.DT46
> segment shared by
> all routers in the network.
>
> Once packets are encapsulated by the VRF, the packet is sent in the main
> table to do a lookup for the nexthop.
> As the End.DT46 segment is shared between routers and can not be used to
> learn the nexthop, I decided to
> use an End.X segment to specify it.
>
> However, what I observe in this scenario is that End.X segment
> processing function is never called, resulting
> in the packet not being sent to the correct nexthop.

As I understand it, you are encapsulating a packet on r1 and you want to
decapsulate it on r2.

The first segment you want to apply on r1 is a local adjacency SID, bound to
the End.X behavior. When applied, it would force the encapsulated packet
onto the r1-r2 link toward your neighbour r2, and advance the segment list =
to
your next segment, the shared SID bound to End.DT46.

Anyway, as you have noticed, this is not what happens. The reason is that
the packet is generated locally on r1, so it is on the transmit path. An
SRv6 endpoint behavior is triggered by a SID in a packet the node receives,
not in one it originates and transmits. So the End.X behavior is never
triggered: the packet is just encapsulated and routed using the first
segment as its destination address, and not steered.

To steer the packet, you need to control the table in which the post-encap
lookup resolves the first segment. This need already came up for another
use case, originally introduced by Nicolas Dichtel. We referred to it as
'route leaking': the lookup must be done in the underlay table, so the
encapsulated traffic 'leaks' from the VRF to the underlay.

We worked on a patch for the seg6 encap that lets you choose the FIB table
for the post-encap lookup. I will post it when net-next reopens. You then
push only the shared SID and, in a table of your choice, add a route for it
via your next hop. The post-encap lookup resolves it there, and your next
hop receives that SID as the active SID and handles it:

  # next hop for the shared decap SID, in the table you pick
  ip -6 route add fc00:ffff:: via fc00::1:2 dev r1-r2 table 100

  # encap route: segment list is only the shared SID, resolved in table 100
  ip -6 route add fc00::2 encap seg6 mode encap segs fc00:ffff:: \
      lookup 100 table 10 dev X

- X is used just to determine the IPv6 SA of the encapsulated packet;
- table 10 is the encap route's table; if a VRF is bound to it, you can pass
  vrf <name> instead.

The lookup table can also be your VRF table, so the next-hop route sits next
to the encap route.

>
> I am wondering if this is an expected behavior (i.e. a node should never
> push a local segment), or if it is a real bug ?

It is expected, not a bug. A node may push a local segment. The point is
that an SRv6 endpoint behavior is not triggered on traffic the node
originates, as these behaviors run on the receive path.

>
> I am not well versed into the implementation details of SRv6 in the
> kernel, but I'm suspecting that this "bug" comes
> from the fact that seg6_output_core calls dst_output, which does not
> allow an SRv6 segment function to be called.

You understood the mechanism correctly. As explained above, seg6_output_core
ends with dst_output on the output path, so the seg6_local endpoint function
is not called there and this is by design.

>
> A minimal example is given below, which creates two namespaces (r1, r2)=A0
> and allows to reproduce this behavior.
> (tested on a kernel compiled on virtme-ng from commit
> e771677c937da5808f7b6c1f0e4a97ec1a84f8a8)
>
> Thank you in advance for the help and thanks for the SRv6 support on Linu=
x,
> Doeraene Anthony
>
> File setup.sh
> ```
> # Topology under test:
> #
> #=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fc00::1:1=A0 =A0 =A0 =A0fc00::1:2
> # fc00::1 [ r1 ] ------------------------- [ r2 ] fc00::2
> #
> # Description:
> # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #
> # Each node has an additional VRF, which it can use to provide different
> # routing decisions based on arbitrary rules (e.g. QoS aware forwarding)
> # Routes in this VRF will encapsulate the packets and push segments to
> # specify the nexthop (End.X) and the VRF the nexthop should use
> # (End.DT46). The same End.DT46 segment is shared by all nodes
> #
> # Problem:
> # =3D=3D=3D=3D=3D=3D=3D=3D
> #
> # Once segments are pushed, the End.X segment is never applied. As a
> # result, the segment is not popped from the SL, and the packet is sent
> # on an incorrect interface.
> #
> # Forwarding steps:
> # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #
> # - R1 sends the packet to fc00::2 in its VRF `myvrf`
> # - This VRF encapsulates the packet and add two segments:
> #=A0 =A01) End.X segment to force the transmission of the packet on r1-r2
> #=A0 =A02) End.DT46 segment allowing r2 to know which VRF it should use
> #=A0 =A0 =A0 to forward the packet.
> # - After encapsulation, r1 does a lookup in its main table for the
> #=A0 =A0End.X segment, but does not pop the segment. The packet is thus
> #=A0 =A0sent incorrectly on the dummy interface
> #
> [snip]
>
> ```
>

Ciao,
Andrea

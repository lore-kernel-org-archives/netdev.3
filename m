Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FD307AE3;
	Sun,  9 Aug 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307119; cv=none; b=irZ5GsBPcoHGpF/Ton6kognjhsHSceCXZGM6bM2McT67IoLzUgBqKlwGERS2I5z1ny4aZxFVoERBvdyKGS1BaR9HAs8Lfs+o22yvPvwPm594zfcAlCtl+9HrKfBOWjVpFM/a6UsZNTDxt8e3kJfV1J1EMPpDYeSvUIp+ZOb0ZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307119; c=relaxed/simple;
	bh=WOx3rPBwhOWApl3rt8xnempq0RpfxHsbspYlhVkA4G4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OUH7IcADX4s3MRVRIshbpE1heaFlnJWRMBw/nQ4VB8t9hJDUKv9A6ZkhXSs0Fk4l4165WjtpgaVeJSvQ2POICaXgcgA/Sl3Sc35rB0u6pVE12ih/uYmTpHZ6bNHbewkzeHrVHe9oiBgaC/oczHIO1VXPjFuBwgSjrfFc3JGs+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=+613fvR1; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=wkOh0/OL; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="+613fvR1";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="wkOh0/OL"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 679KJKnQ005541;
	Sun, 9 Aug 2026 22:19:25 +0200
Received: from lubuntu-18.04 (host-80-183-189-234.pool80183.interbusiness.it [80.183.189.234])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 5793F120F34;
	Sun,  9 Aug 2026 22:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1786306756; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tv1pB0Ks27bmZ9A6awRSAb4aB9qKOCPNIKkn8lc+6A4=;
	b=+613fvR1alA1RTLefWD/JbHOoL2E1P2Xp0Ks8+0CGwk1aF4RFdDuPs1rXKVePviI4e1kCz
	13wTqFP0/YEBQYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1786306756; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tv1pB0Ks27bmZ9A6awRSAb4aB9qKOCPNIKkn8lc+6A4=;
	b=wkOh0/OLEIE6huC6L6JDqcOGaOp2ikV71c97YuRP35LsFJt9nqqySTrsmESZzbK2mzI49V
	yZPg+H8m6aQlyiOOVGfwH1YOaUCnaq/sGENTy8+ijGskzP3ivKglVedM8CWK1lbQJx6e4g
	hE/FTnXutXwI85/WJFRaiIfiFMWVVulwaXqXMuNtwqEYkFLpwxjkLVO41RLiywR0GJLqHo
	cxOIJw3K6G1G+eVsO8/9mWViJ/oR1b0+81bwItCbRj/jotZobdojUad+MGZRoeK6iDdBgd
	d4XKochWEiRoCERFP6L0hCFxi4a4295FDR29u1GRJKyn7wrECtdZra8WwI8CVw==
Date: Sun, 9 Aug 2026 22:19:15 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Lee <david.lee@trailofbits.com>,
        Nicolas Dichtel
 <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, David Ahern <dsahern@kernel.org>,
        Kyle Zeng
 <kylebot@openai.com>,
        "Dominik 'Disconnect3d' Czarnota"
 <dominik.czarnota@trailofbits.com>,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2] ipv6: seg6: clear IPv4 control block in End.DT4
Message-Id: <20260809221915.2ffc1ecd0f445fcb70270e31@uniroma2.it>
In-Reply-To: <e7eb5ac7-7b5d-4484-aa66-4c92bb20c538@6wind.com>
References: <20260804094625.715305-1-david.lee@trailofbits.com>
	<519a06fd-c9aa-425b-a374-607aff0a9140@6wind.com>
	<CAC_etQFJTsCN5zr_gxO_SEDjbJU4-yph0ezbvQ6zZ9ZVaLie0w@mail.gmail.com>
	<e7eb5ac7-7b5d-4484-aa66-4c92bb20c538@6wind.com>
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

On Wed, 5 Aug 2026 13:58:21 +0200
Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

Thanks Kyle and David for the patch, and Nicolas for catching the End.DX4
gap. Before v3, a few comments on the commit message and on the code.

> Le 05/08/2026 =E0 12:17, David Lee a =E9crit :
> > BUG: KASAN: slab-out-of-bounds in __ip_options_echo()
> > Write of size 255

Putting the KASAN trace in the commit message would show the impact
concretely and tell a reviewer how the problem is reached.
Is the reproducer available somewhere? I'm wondering if it could easily be
turned into a test, both to check that the fix works as expected and to
help discover other related issues.

> >  Therefore, End.DX4 has the same stale IP6CB-to-IPCB issue. The current
> >  patch only clears IPCB in End.DT4 and is incomplete.
> >
> > Do you prefer v3 to be sent out to cover this case too?
> Yes, it would be nice to fix both in the same time.

End.DX4 and End.DT4 both reach the inner IPv4 packet through
decap_and_validate(skb, IPPROTO_IPIP). End.DT46 dispatches to End.DT4, so
it is covered either way. Handling IPPROTO_IPIP inside decap_and_validate()
covers End.DX4 too, so v3 would need a single memset there instead of one
in input_action_end_dt4() and another in input_action_end_dx4(). Something
like:

  if (proto =3D=3D IPPROTO_IPIP) {
      int iif =3D IP6CB(skb)->iif;

      memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
      IPCB(skb)->iif =3D iif;
  }

On the interface index: I would take it from IP6CB->iif before the memset,
rather than from skb->skb_iif. IP6CB->iif is what ip6_rcv_core() recorded
for the outer packet: the interface that packet is considered to have
arrived on. That value does not come from the headers that have just been
removed, so removing them does not make it stale. skb->skb_iif is the
right source in ip_rcv_core(), which runs before l3mdev, but End.DX4 and
End.DT4 run after l3mdev.

When the packet is received on an interface enslaved to a VRF,
ip6_rcv_core() puts that interface in IP6CB->iif and l3mdev then replaces
skb->skb_iif with the L3 master. In decap_and_validate() IP6CB->iif still
holds the receiving interface and skb->skb_iif holds the VRF.

I ran some tests on net/main and on two variants of the fix that differ
only in what they write into IPCB->iif. The packet arrives on ifindex 8,
enslaved to the VRF with ifindex 9, and the receiver is a UDP socket bound
to the VRF reading IP_PKTINFO:

                  no fix   iif from skb->skb_iif   iif saved
    End.DX4            8                       9           8
    End.DT4            8                       9           8

The no fix column is net/main unchanged: seg6_local.c does not write
IPCB->iif at all, so IP_PKTINFO reports what ip6_rcv_core() wrote in
IP6CB->iif, read through IPCB because iif is at the same offset in
inet_skb_parm and inet6_skb_parm.

So the two are not interchangeable: taking the index from skb->skb_iif
makes IP_PKTINFO report the VRF instead of the receiving interface, taking
it from IP6CB->iif before the memset does not.
IP_PKTINFO is not the only reader of IPCB->iif. With skb->skb_iif that
field holds the VRF (ifindex 9), and after End.DT4 a socket listening on
the receiving interface (ifindex 8) does not see the traffic.

It is also worth reconsidering the Fixes tag: decap_and_validate() has
never cleared the control block, and its first IPPROTO_IPIP caller is
End.DX4 in 891ef8dd2a8d ("ipv6: sr: implement additional seg6local
actions"), which predates 664d6f86868b ("seg6: add support for the SRv6
End.DT4 behavior").


Two side notes, both of which the Sashiko automated review also raises. The
same stale control block is left on the IPv6 side: with an outer Hop-by-Hop
header IP6CB->nhoff points into the inner payload and I see those packets
dropped as an unknown protocol. And input_action_end_dx4() and
end_dt_vrf_core() set the transport header at sizeof(struct iphdr), so it
points inside the options when the inner IPv4 packet carries them. I have a
reproducer for each and will send the two patches separately.

Thanks,

Ciao,
Andrea

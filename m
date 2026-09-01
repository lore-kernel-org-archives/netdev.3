Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B363D567F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306274; cv=none; b=qxA/X4TSvIKxz/V/WgiE2pSvKq+le/YunHqi6/V+GqnjxJf+HCYZ8rKpHKergC/fccZ3+GxD2r+TCFUT3ConbM5EfGiZqtharfJ2N25Xzqi16GT5ExjywOrMRgj3ZWumXUH2RDNfZgsQh8NpqGlYHYqjrt7XpfowrvdubSTo7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306274; c=relaxed/simple;
	bh=y7qk0AWs2JFfWcuUaGMjAK9qkDELwTJN8hjHOher5/s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=tHBws8F3Tjetqz6rhtYW1uR61ojE7QLvVqY7ZUrXF3W7UgyOSWFUtAUPYtRnYsIsRwCKeTh/Y2TUT3D0wfdcvPcSP0ppxxkszTVURtJEJ8jKJMbS7spH4rmLr4bjSpOrSYTwzveyMCD2xKLnx1X3biFCQbqzGyVGnVyPwXPjzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=oFbmWPT7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzR3Y6TI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="oFbmWPT7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzR3Y6TI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B6C1E1D00022;
	Tue,  1 Sep 2026 19:44:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 19:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1788306271; x=1788392671; bh=O1VfaFd4iK5TR4LrRGS4F
	+6nXLI/tsvBjysEXW8X1Ms=; b=oFbmWPT7kGJu0BmPs4eyeEC7ew86rEjdT2VCV
	HdHi+gaPHrX6QW42A8veAVu1jExbYfbLMjIO1NoKbX2BGFuJBWh/zejlDIFr/6uL
	vC4U682lErwaKV1lhGCI9AFEdGtzrVcu4/+5BUM9duT4bH6C7VpX5fJ7G5UGtUmI
	5PgOozzAMV8zkrJLWE4H7h/5bRBJ/WOdte2hXYo5nXC2XUczOAGabW4tr1ohKMpB
	Ehjy9FpJsXkHIBZfDKaQOMwFuidzBAda7caNPFzgeMb76RRogGeKoplydE/dR5KH
	jQy9quvr44zIGbHX2MHsXTPk0S9A2t95iCvjfwJTfZFa/r3ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788306271; x=1788392671; bh=O1VfaFd4iK5TR4LrRGS4F+6nXLI/tsvBjys
	EXW8X1Ms=; b=LzR3Y6TIem//Oa9LnHPqrW3rtktZmpPzDcOSeeBvvtw8ogEtd/V
	e8I8VabduPdoQohg0HwpQs/3gpkubsJGDXJB6XR/eXnWRjk6QPJsxunJzFcU3YVb
	XFWtPBovKd0+VjDVVGnLpiO8G08OOAMLjWQrHyJg3yNN1auLutihWB14cO6F8Evg
	nGBqEm7LQBf12g/4yp5B3VHEWX2pyLsbLd+3lTN6rM5Raw3z3hDvNkendgVs8Hs5
	tyJJbqdVGCdDliKsL5XBx7uGDkEpk8EhUYPEs5BJmOmvpT7YlxAdWWR0CFKqnETp
	X2z4QoGk/X80AMasFSF2W7iPB5ekbyqGO9g==
X-ME-Sender: <xms:XmOXasbVR7oCrpjJECrZT61appgrSg7xHgoQGnPiJzQ4Bj2kDTNwoA>
    <xme:XmOXaj_Q-Rjdc5QQkPCse_9N5Sp36BbSFhVW4HqS-1BYIIDqBRogvGdUkhAle65Da
    LvCodkgFbtBZCpbubwOnVc_IEimgaYOQ45hPjiUwBWFWb-aYdpw9yUK>
X-ME-Received: <xmr:XmOXarZ9MCM5N2pCZQoSdeqGFmLyUx75AvfnEKIYb4OpInp_GVLfjphbl2lqttkd2R6qhQ>
X-ME-Proxy-Cause: dmFkZTGd1Bpp2KvHBU/T1xINcOmSWjSM0VOHtTjv02ECs8M4FgQnPHadDcmoLqq+Bq+m2w
    KXDyRi0dZT8SGdQLc14a8O+sUgEgF1SUIfOPi3EmjMCqlTqe2/NnvbbjW01E4CY5+lxuoN
    hG7nCmzFXAPzyickWxs9RZD3Q1pYOr0Z9WG35d83XmAvE3IdT6ED+NoDH/7Rzat9uY+jHG
    14Ho+AB4b3np92XrNBpF2YrVx+d13zaGMdYCGaiMNNPpYMyZNs68IG6nLyoUnhewH/SvM/
    uWTA5NXxXWLBJTsYpGgoMUuJqD3J/pJYnxWHrnGjWur+5iSVW4ArNju/SCK+siBSxo+jWV
    i9jqDyMEu8RbxVkOamATYdXFuWXxWiqdtktqt3DfhhnPGKhXIoGe9jvigShHOOgcjWoMgi
    K9wgcd5J2Q75LS+KTO1vPoy+WYBKff/aYZ2v/3An/VpG6aN591DhWXTTvwiw33t4cDT9YU
    X4ehE/2XZlp2qH76nM0KEGd/2F4rkuNYWoZ5F2OnK4W9SU5XZHWBnm5mEZbqyPUsM2PTE8
    GcKP5RG8lYlFRzPModwHIO+c/ZkLTT71MiHo2wjtnuXq+Dn0uv/2o5JxgT2GkAzitjJJea
    i8pHx445/JFPryG20zc4rQtAtBiHyWMEBqaceQxTdUN+cbatPIFPUjtIQMhQ
X-ME-Proxy: <xmx:XmOXatcL1HSrbFog4gkRr7l0UJcAybPV6TiRDxUKqvZ-ug7BtGhSRQ>
    <xmx:XmOXaokMPvmraXOJ2PaaZIXy9DVKjqQz-o2NcdDA8w9qZt1R5IM7tw>
    <xmx:XmOXat3j_BPCEplOKvPDqvxNk335Lh22vfP1wR_SokC95PjBazsJzw>
    <xmx:XmOXahf84QBwPT6zyrJlC7fSCkYQbfd0p7nLJVEjAQhI8soJ3aZ03w>
    <xmx:X2OXajNKQVkGE-_I3qZr5gt7VT2V_sswJ67GiKAe4VfI2doeP6lriMrR>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 19:44:30 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 53FF59FC75; Tue,  1 Sep 2026 16:44:29 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 50D7E9FC41;
	Tue,  1 Sep 2026 16:44:29 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Paolo Abeni <pabeni@redhat.com>
cc: Eric Dumazet <edumazet@google.com>,
    "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
    Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com, Tonghao Zhang <tonghao@bamaicloud.com>,
    Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net] bonding: avoid ARP flood on RTNL contention in
 active-backup mode
In-reply-to: <06d2e605-6d3d-40f0-b247-031756c0d752@redhat.com>
References: <20260831090937.3342052-1-edumazet@google.com>
 <06d2e605-6d3d-40f0-b247-031756c0d752@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Tue, 01 Sep 2026 13:32:54 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <587590.1788306269.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:44:29 -0700
Message-ID: <587591.1788306269@famine>

Paolo Abeni <pabeni@redhat.com> wrote:

>On 8/31/26 11:09 AM, Eric Dumazet wrote:
>> Commit f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one
>> fail") changed bond_activebackup_arp_mon() to reschedule arp_work in
>> 1 tick if the second rtnl_trylock() fails (for sending peer/slave
>> notifications).
>> =

>> However, by the time bond_activebackup_arp_mon() reaches this second lo=
ck
>> check, bond_ab_arp_probe() has already been executed and sent an ARP pr=
obe.
>> If RTNL remains contended, rescheduling every 1 tick causes
>> bond_activebackup_arp_mon() to re-execute bond_ab_arp_probe() every jif=
fy,
>> flooding the network with ARP probes at HZ frequency (e.g. 1000 pkts/se=
c)
>> instead of respecting the configured arp_interval.
>> =

>> If rtnl_trylock() fails at the second check, do not change delta_in_tic=
ks
>> to 1 so that the next ARP monitor execution is scheduled according to t=
he
>> configured arp_interval, matching the behavior in
>> bond_loadbalance_arp_mon().
>> =

>> Fixes: f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one=
 fail")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> ---
>> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
>> Cc: Hangbin Liu <liuhangbin@gmail.com>
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> ---
>>  drivers/net/bonding/bond_main.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> =

>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> index ef9eb0c53c66..c23cf18a996a 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -3871,10 +3871,8 @@ static void bond_activebackup_arp_mon(struct bon=
ding *bond)
>>  	rcu_read_unlock();
>>  =

>>  	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
>> -		if (!rtnl_trylock()) {
>> -			delta_in_ticks =3D 1;
>> +		if (!rtnl_trylock())
>>  			goto re_arm;
>
>Sashiko noted this should cause a regression, with notifications
>potentially delayed for an unbounded time:
>
>https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831090937.334205=
2-1-edumazet%40google.com
>
>That was also the behavior prior to f1986b3a9f2e, so I guess is =

>a reasonable trade-off, but a 2nd opinion would help :)

	Yeah, without reworking all of this so it's just one round trip
on RTNL, it's a choice between possible ARP spam or an unlikely
possibility of egregiously delayed probes.  At the default missed_max of
2, with the rearm interval set to delta_in_ticks (i.e., this patch
applied), the ARP mon will fail over if it misses RTNL twice, with
caveat that the first miss needs to be the second RTNL acquisition in
bond_activebackup_arp_mon.

	I suppose another possibility would be to set delta_in_ticks to
something larger than 1, on the theory that RTNL shouldn't generally be
held for very long, so a sufficiently large value would be likely to
miss the contention but not wait too long.  Choosing a value is going to
have voodoo in there, and would likely have to be some fraction of
delta_in_ticks.

	Regardless of the rearm interval (1, delta_in_ticks, or
somewhere in between), the notification can be delayed for unbounded
time if we are sufficiently unlucky, although it's more likely with the
larger value from delta_in_ticks.

	That said, I don't have a major objection to changing this back.

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net


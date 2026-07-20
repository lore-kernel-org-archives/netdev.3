Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3F3AF666;
	Mon, 20 Jul 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570306; cv=none; b=tOIDMC4m5gQ6ITJj0IR3cQKumyZ0rXqAoux/5Nf51tQFDB9ReUCwiWngDAMktHK5fRKYmLX51+nfIBKAEPbka5LLZEP9acsxYsKv/0TocwU4XC17FLxKvpXJFaCXbhzuQkBaL2OSbhsnCyF6wEXf8ZBPFijq9NkLD1Dr+YNVdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570306; c=relaxed/simple;
	bh=SZC5oqjIgw4bSfI4XJKIGyF+nGaz0r08BIpmhf/8u20=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=DzW+rzwU8laVy+0hay8EQDo5xGlDDYVypRnCillG8F2ggR+uje/QaosfCxqSfT71LwwhmJQdq3NIq7wdM0H6dRWrxXn+h+mFQRMj+V1lvI26d9taSA0uXq30YnRP/VnfLgoipX1brcqzg6fOvHxGm1BQWHLcVedlxJi+1Pntyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=zzR/caXj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=diKz0sEa; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="zzR/caXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="diKz0sEa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D3401D000A7;
	Mon, 20 Jul 2026 13:58:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Jul 2026 13:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1784570301; x=1784656701; bh=/+Ggis0DocspAMfsWjAJi
	2a9R0IBN/cBwrZuXl9/GSU=; b=zzR/caXjF7JmVBFtc0jkSx+tmGfx+AFvvY+jx
	LY1kvR0gMi+dntWwotGexB2YiOR0F3UQQzbmFjW6HE04vwAlwykp6ttkakAsTqBT
	tWKBai5B0klOYP8TzPmRlNsS2nVkSR8cemO97AAwz2jSdJwSfkUAsCjp8nSHovX3
	8vCcGC8VXEC6BQSghCgTwsDKXwm2JPmgpO0ceIPg6zXI2l0ZqVZeEIgZfrdVSkK6
	ta5NXB6cFiuf+oU0WSx2zkopUVsWCprt+/F2pGdh8Quy2pz+buKzfl8MNyWkO6DX
	y3gi0ivMb0VXWmrL/rJFY6TTZruP1HQjICuTK3RaOTBhDsTew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784570301; x=1784656701; bh=/+Ggis0DocspAMfsWjAJi2a9R0IBN/cBwrZ
	uXl9/GSU=; b=diKz0sEaGT41P23/hnhOySFuwj/Bl7sGDqAArYgGslkKVtAxyvK
	VbcDou7uNAuFXiE86adsVUzkEpOzeXz0+48d1rffzhCWgdtLUqbGK4aoOT0SXyAC
	wHkSJz03Fo+GsGk0UsvztVAF+I2dewlccQOUl5xKDI8pbCmikQ+HWvmO0QIm5C/j
	5ppKkdrejsH6y6UW5N+4NFyw+Td8UJ/PzHJAo4xg6m8l8FuCm/2JeKHez6hA/lRs
	fImnzii9fhNz0uz0ypM524/dUCBXuLA/ZbI5T2ZpsGqcTtswSzcsSqkgYOsxz59S
	0cp4jHH41HLzFx8ULQKvA7k8PBeRt2SNzbw==
X-ME-Sender: <xms:vGFeahmqaEJ7T34Lcrzm-GwPlt5HVYpb_NSBxr1RkGfM-SNsJARybw>
    <xme:vGFeak-0bfegLZ1HUQbmLR1YMMYqu2jAjZ5H4KHfBNDWgUPbgJd92bR4lCJgYoj36
    xOQtKQnOxilXFMEEqISbStCCYYcFxu-EO4R-ORqn-UXm9rartZ45RE>
X-ME-Received: <xmr:vGFeanLNIW68Hrx5kSUGYREmbM_5uHtbH1mwCEo5-mBSrasB8zqEiy3gCdzPrIh4BKF0Vw>
X-ME-Proxy-Cause: dmFkZTFjZWSsrWEajz4r/fgwf13EyBO3Z+vm4GyW0dVzQNpa2GFNxMiaMcRMh/5JbDbyAB
    ++j2+jRxFWfJjZCOLLZIjWOw2dG+e/oDQcLwNXbLBwVBaSNZf8SvDlfE1l8cZV7X5uL7SL
    bKbcuiLF03R0Ji+jKtGbPWxAhks+QAJWngsPuIGxCGY/yJH671cKwwH5P1vlh+Sf9SnLtv
    kEG2HyKiuFIXmurxYtbZY0Ycu69lhViqixQUz6b7e/4KY8jDhq4Lw39zNa+8hAd6Arm6gB
    TMi4+xk6XnI716eVTa+9/LODSBpul8PNh00INSUknQ3EBbqrbboAaUovjEmJoqolh8sqAB
    ERVWWtf+gCOnEUjj+ftCHv1KnQlaADvRmKsUDkKXG+9ExuvJrIKuc0lQBWANsdiHIPo5VY
    DyZnLbjR8gGNTEgGrDQEKhvgC+eNTe7pzhxGzKUB09ubYis68yrfYOpgkcDXHnD3sRCIu7
    4XSGLPuQrGpXmIOlXeqMcbqPnwsFIUC6GG/xJUdOHrxcqo3wzSatC91B57aXqnm1InK8ig
    VHoCKuN/i3v7LVNYmfQPSrjskbSZPt0j6lKZfW+BZ74KlHAoRHeOhUo2d/SBnLos5V6QJa
    BXCv6gIG95J+0IGOUsT/dQlUOxYZ0zIX96bvej27rX38zd3ESpdt21k2HKzA
X-ME-Proxy: <xmx:vGFeahhke9blQ5rL2EOAlBFyJHkEQFalnDL9xFd9fOiMtEZh4kzvTg>
    <xmx:vGFear9Ph8HA8Q8C6T1AWVrTGh2mAtCEDrYA5myKyIKZO_VyWjlyNA>
    <xmx:vGFeauMtxIPYaRXgj0mwcxRSTomoaqbUrkg9XGpgzsNZ8lAFO4qZpg>
    <xmx:vGFeanCG7xtU3XZzMJLae4ZYtFp9oWDn59YrsyfSP2STtit2ADqN1Q>
    <xmx:vWFeagl5LO6eNtxVKclulKyelq7kdl-JTMTqPVz7h1jSoewI5V8TQdCH>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 13:58:20 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 322199FC6B; Mon, 20 Jul 2026 10:58:19 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 30E6F9FC65;
	Mon, 20 Jul 2026 10:58:19 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
    kys@microsoft.com
Subject: Re: [PATCH net] bonding: fix skb_under_panic in bond_ns_send() over
 stacked VLANs
In-reply-to: <20260719232153.1405569-1-xmei5@asu.edu>
References: <20260719232153.1405569-1-xmei5@asu.edu>
Comments: In-reply-to "Xiang Mei (Microsoft)" <xmei5@asu.edu>
   message dated "Sun, 19 Jul 2026 23:21:53 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2820548.1784570299.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:58:19 -0700
Message-ID: <2820549.1784570299@famine>

Xiang Mei (Microsoft) <xmei5@asu.edu> wrote:

>bond_ns_send() builds an IPv6 Neighbor Solicitation with
>ndisc_ns_create(), which reserves exactly LL_RESERVED_SPACE(dev) +
>sizeof(struct ipv6hdr) of headroom for the later ip6_nd_hdr() push.
>bond_handle_vlan() then inserts the collected VLAN tags into the skb;
>each inner tag consumes VLAN_HLEN of that headroom via skb_push(). With
>enough stacked VLAN devices between the bond and the ns_ip6_target, the
>reserved IPv6 headroom is exhausted, so the subsequent
>ndisc_send_skb() -> ip6_nd_hdr() -> skb_push(sizeof(struct ipv6hdr))
>underflows past skb->head and hits skb_under_panic().

	How many stacked VLANs is "enough"?  I'm guessing that it's
somewhat device dependent, as LL_RESERVED_SPACE includes
dev->needed_headroom, but as a ballpark here, was it more in the realm
of 3, or 30?

	Also, why doesn't the skb_push called via bond_handle_vlan ->
vlan_insert_tag_set_proto -> vlan_insert_tag -> vlan_insert_inner_tag ->
__vlan_inser_inner_tag trigger the skb_under_panic?

	Does adding one or two more nested VLANs move the panic into the
above call path?

>Restore the required headroom with skb_cow_head() after VLAN insertion
>and before handing the skb to ndisc_send_skb(); drop the probe on
>allocation failure. For paths that did not exhaust the headroom this is
>a no-op, so previously working configurations are unaffected.
>
>  skbuff: skb_under_panic: len:84 put:40 head:... data:... tail:0x50 end:=
0x180 dev:veth0
>  kernel BUG at net/core/skbuff.c:214!

	The above text doesn't seem to match with current net-next:

        pr_emerg("%s: text:%px len:%d put:%d head:%px data:%px tail:%#lx e=
nd:%#l
x dev:%s\n",

	I presume you replaced the "head:" and "data:" values with
"..."; did you also edit out the "text:" that should precede "len:"?

	I'm wondering because without the actual values, it's not clear
how far beyond head the data pointer went, and thus whether adding more
VLANs would move the failure into the VLAN tag code.

	-J

>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  Workqueue: bond0 bond_arp_monitor
>  RIP: 0010:skb_panic+0x142/0x230
>  Call Trace:
>   skb_push (net/core/skbuff.c:224)
>   ndisc_send_skb (net/ipv6/ndisc.c:454 net/ipv6/ndisc.c:506)
>   bond_ns_send (drivers/net/bonding/bond_main.c:3255)
>   bond_ns_send_all (drivers/net/bonding/bond_main.c:3313)
>   bond_arp_monitor (drivers/net/bonding/bond_main.c:3458)
>   process_one_work (kernel/workqueue.c:3322)
>   worker_thread (kernel/workqueue.c:3405)
>   kthread (kernel/kthread.c:436)
>  Kernel panic - not syncing: Fatal exception
>
>Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
>---
> drivers/net/bonding/bond_main.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index e044fc733b8c..3ac3418c9498 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -3251,6 +3251,10 @@ static void bond_ns_send(struct slave *slave, cons=
t struct in6_addr *daddr,
> =

> 	addrconf_addr_solict_mult(daddr, &mcaddr);
> 	if (bond_handle_vlan(slave, tags, skb)) {
>+		if (skb_cow_head(skb, sizeof(struct ipv6hdr))) {
>+			kfree_skb(skb);
>+			return;
>+		}
> 		slave_update_last_tx(slave);
> 		ndisc_send_skb(skb, &mcaddr, saddr);
> 	}
>-- =

>2.43.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

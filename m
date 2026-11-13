Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552746;
	b=J7BUnQvtsWM4PWfxyb2deyLjfqS7rbvaXWJVJpJ33OkOxZzeTQhzx6iV7AP6tG+ehJ7U
	 WQy6RgXGpuN4XrKBXPdo/cC3HNjzKHfwnoJgOlceQsaH7+GeDlP+A9PKCos2IvqZesNNt
	 AdxaKHFtp/0L9TByT3z4RhDblyRasz8a8wvn49o8pEreZ4jrbEztCqSGkifLh5qeUyxnM
	 lgrFxe8t9eJ//Xo5rEMzEqkB0T6PiHw6MY+RtLOB/RapUc1UwYn4FggVPeyvEFu5Z8KHH
	 fge2Y/88QJXksPbUdeuvpH3ybI/r0lv2x5s4b2eykQ+ZXgNR9zezGrvxAg/NFaQMdNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552746;
	h=DMARC-Filter:Received:Received:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=2XQrnwAhwtkRALyvygGxCMh98jqLHcFie2WnTlzzUsQ=;
	b=F5m2bgI4xU8xDn4tj5dIMPpAXQ3XbP8DQKqMJLhXTjkdyc1Z+n9kq08822PmbjUMavCs
	 QQ+97e5eXd9SYLhVLYH0j5n/CmE4FkU9VtQmpS8e+uFBw6e7ehcHSfEy/49jAHAUgS1Ch
	 cT7PbrHq/WF2g1/RRg37eiFQObfN4t284ldFG+lSC6cawbTQFqCIQ8f1Th8F3hMwgiCg0
	 Ma/D7lPvR90VqzAuevkatRHqOMvjwBRib9h/K8PuBQPGAHbF/I9+4c8jKrBMQ4KRIOx0w
	 KcdI/bU8wE4VOiS8wUURvQ9IIeQO19uxU6OaCKBEv99XayV3hw9GEpOw+VcGK0WrlYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=idosch.org;
	spf=none smtp.mailfrom=idosch.org;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1FL19jss;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAC606A321
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 06:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBAC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1FL19jss
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B4117A026B;
	Fri, 13 Nov 2026 01:52:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 13 Nov 2026 01:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794552744; x=
	1794639144; bh=2XQrnwAhwtkRALyvygGxCMh98jqLHcFie2WnTlzzUsQ=; b=1
	FL19jssRHZNAizhNfCcNi8okBbmWImVYi2Byx/6fNLT1QfG6cQr+6bZD7Rw10oce
	sCujH/9ysbRh4rogYnQprKhfIn8GYj/ffyZW8aEYhosmZX00SzSljw/xgLzQr90u
	SkCstsw5ViQoLA+K76C2tyis5waCGTEAotGWzkTLxwiTcZwu8byeAQyBmP9LYQqk
	k4otG45Sr7P8PgmIseafnvZCr0NxkkkghWWo+HjO1ixRWHpvSxhewEIwBzLHP8mm
	jChPQxnRfkMYccYHySd759Ba/Qh22p0sUPIwh1i1PRPgumyMF2pxwHRteI8PjRJp
	HNhpEthGHrLnYVKkEW30w==
X-ME-Sender: <xms:p7P2aug-kjLMVNP5REdRVYI94v9g6-vGf6n4JCOL7lKXcu5MragttQ>
    <xme:p7P2anNJG92oLB_128YMO14J7jFwWIyq9nkSJDTPOppBkLR6CRW8fxNA5EDyGlrFt
    6dGDrBFjkKHjdjAR0ZYGWiJu33ZAip-f2d-xULMZTZ7bn1v1J39>
X-ME-Received: <xmr:p7P2ahpaGqID-9d4_SQvNCwWvg_Rr2eo7qfUbP4UFh8jmpeNz_S-70yI_Y5lkCqzjJEqYUT7WxsJLoaNLL4LS9grGpf8JQ>
X-ME-Proxy-Cause: dmFkZTGGvy8QNFMUGu3RsKrwE62F6NxJtw/CRFFD1tNzzHGhFoQ6CO5d25P1makStN1j4x
    wzVzSUdKALwWF4X//CTxL94qTAmtojJpIEhvJ91RzCSgOq42GYuZVEmBFA+XzHRJwjWkIQ
    8Wkt2CmCYwuCyYbOkuCOoSeNRUR8/s9ZkOzDkeN/cF6QGg2Q3J3vQQB1Q/BN/ZHJSKLXur
    vrLBkyA/yt8ZdtkAYZhIFqEYPjbgROlTq1uMNyIVyogItoF1q0bR6KEL4p3XRA7HCRausD
    3R8QGWLkOiW4F+bR3hOKLDunlboXKsTOuxop+lAEETbIslfiPM5tQzbFrANDAxYvYvNjfe
    vD2fBqPFoNh38lu09iSaQHnsxfuEZ0kTdBG/h8+100eJu2599nNPO3xZWd3qj+SSIUg+cC
    /s7HxObdiQ54V6H2mzY14n0jNHutxhNMfavufI67+dykxHlwtqhA1P6QGraKFqkRPeJyxZ
    5dZnwwwXyNcDeyr3kviMtVoB535AZWyaihk8YxaYqBmBE0rkjBKH/dBTaDQ+Aj001H4Zeo
    vEB8XGtXt3g2qVvGfoAfOqwOrDK+nZVGrN5pK/Y8PnY8Q9BnaMHiXz0H/Xt0wkVXN2h5e7
    +1Ar/LQMBcJY2BEtvf5ulrJznuW5/eatKlp3myzy6pfSgPRoHVlTCghBLMaA
X-ME-Proxy: <xmx:p7P2ah4_nLDXI-Q5D6TFLzEnP87WRj1intKnGdH_0cYyI11_iytN0A>
    <xmx:p7P2angXMr4Rrg1zsR1yqKpSLKHgMLrlD-agF4sCYlBqPfAb70SMdA>
    <xmx:p7P2av6g7qU6qPP2w-mfO-7DoDmjBM0-ckSDMfAtTbXPITojuF9B8Q>
    <xmx:p7P2akHbMYl7iRCi0vYYuZ1mnAovDJjP7juwXyCFql4VN8LoRQkZYw>
    <xmx:qLP2ajJuhTeivhrjuWisOrIDZRf189PaQYE_nq8IW4TGaYYoUX6Kh5aS>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 01:52:22 -0500 (EST)
Date: Fri, 13 Nov 2026 08:52:20 +0200
From: Ido Schimmel <idosch@idosch.org>
To: netdev-bot+sashiko@kernel.org
Cc: idosch@nvidia.com, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
	jv@jvosburgh.net, andrew+netdev@lunn.ch, razor@blackwall.org,
	aahila@google.com
Subject: Re: [PATCH net-next 1/2] bonding: 3ad: Receive packets in COLLECTING
 state
Message-ID: <20261113065220.GA3517282@shredder>
References: <20261111171947.2816258-1-idosch@nvidia.com>
 <179451491706.2199510.1058504888559496420@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179451491706.2199510.1058504888559496420@kernel.org>

tl;dr - I believe the patch is fine as-is.

On Thu, Nov 12, 2026 at 08:21:57PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The fix clears 'inactive' only when ad_enable_collecting()
>   runs.
> - [Low] The patch fixes a real, user-visible bug but has no Fixes: tag.
> 
> --
> 
> bonding: 3ad: Receive packets in COLLECTING state
> 
> With coupled control disabled, an 802.3ad port in COLLECTING state should
> receive packets, but the RX path only delivers from slaves whose inactive
> flag is cleared. This patch makes bond_set_slave_rx_enabled_flags() clear
> slave->inactive in addition to slave->rx_disabled.
> 
> > When coupled control is disabled, a port in COLLECTING state is supposed
> > to receive packets, but it does not. The bond only delivers packets from
> > slaves whose 'inactive' flag is cleared, whereas
> > bond_set_slave_rx_enabled_flags() only clears 'rx_disabled'.
> >
> > Fix by clearing 'inactive' as well.
> 
> [Severity: Low]
> Should this carry a Fixes: tag?
> 
> bond_set_slave_rx_enabled_flags() was added by commit 240fd405528b
> ("bonding: Add independent control state machine"), and that commit only
> cleared rx_disabled. The RX gate in bond_should_deliver_exact_match()
> checks only bond_is_slave_inactive(), so the bug goes back to that commit.
> 
> The notes say this targets net-next because it never worked, and that
> makes sense. A tag would still let stable and distro maintainers link the
> fix to the original commit:
> 
> Fixes: 240fd405528b ("bonding: Add independent control state machine")

Addressed in the notes. Not a regression and therefore should go via
net-next and shouldn't be picked up for stable.

> 
> > diff --git a/include/net/bonding.h b/include/net/bonding.h
> > index 598d56b1bc970..cb89aff437f44 100644
> > --- a/include/net/bonding.h
> > +++ b/include/net/bonding.h
> > @@ -594,6 +594,7 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
> >  static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
> >  					       bool notify)
> >  {
> > +	slave->inactive = 0;
> >  	slave->rx_disabled = 0;
> >  }
> 
> [Severity: Medium]
> With this change, inactive is only cleared when ad_enable_collecting()
> runs. Can a COLLECTING port still be left with inactive=1 and
> rx_disabled=0?
> 
> bond_option_all_slaves_active_set() can still set inactive without
> touching rx_disabled when all_slaves_active goes from 1 to 0:
> 
> drivers/net/bonding/bond_options.c:bond_option_all_slaves_active_set() {
>     ...
> 	bond_for_each_slave(bond, slave, iter) {
> 		if (!bond_is_active_slave(slave)) {
> 			if (newval->value)
> 				slave->inactive = 0;
> 			else
> 				slave->inactive = 1;
> 		}
> 	}
>     ...
> }
> 
> A COLLECTING port matches !bond_is_active_slave(). This is because
> ad_disable_distributing()->__disable_distributing_port()->
> bond_set_slave_tx_disabled_flags() left it in BOND_STATE_BACKUP.
> 
> The steady-state COLLECTING recheck in ad_mux_machine() only looks at
> rx_disabled:
> 
> drivers/net/bonding/bond_3ad.c:ad_mux_machine() {
>     ...
> 					if (aggregator->is_active &&
> 					    bond_is_slave_rx_disabled(slave)) {
> 						ad_enable_collecting(port);
> 						*update_slave_arr = true;
> 					}
>     ...
> }
> 
> Since rx_disabled stays 0, the recheck never fires. Until the next mux
> transition, bond_should_deliver_exact_match() keeps returning true, and
> every non-LACPDU frame on that port gets RX_HANDLER_EXACT.
> 
> The notes list this as known issue 1 and describe COLLECTING as
> transient. However, the companion selftest ("selftests: bonding: Add a
> test for 802.3ad with coupled control disabled") keeps a port in
> COLLECTING indefinitely by clearing the partner's Collecting bit. So a
> partner that never sets LACP_STATE_COLLECTING would keep the port
> dropping traffic.
> 
> Would it work to also check bond_is_slave_inactive(slave) in the recheck,
> for example:
> 
>     bond_is_slave_rx_disabled(slave) || bond_is_slave_inactive(slave)
> 
> That would let the port recover on the next state machine tick.

Again, addressed in the notes. COLLECTING is not a steady state. A
partner that never sets the Collecting bit is not distributing either,
so there is no traffic to drop. Once it sets the bit, the port moves to
DISTRIBUTING and 'inactive' is cleared. The selftest is only able to
send traffic to a port in COLLECTING state because it is clearing the
Collecting bit in received LACPDUs using tc-pedit.

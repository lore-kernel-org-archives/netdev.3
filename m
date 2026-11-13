Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533565;
	b=ipUZEf/Nvaf1v+krpWe5TDa36PrVNeGY/lXJf5HkOaBOV7Wpxpjk9LcPHU67PSU233re
	 rWWEpOIwpMhjEQ6OG1o8+kLFAzZNC+xypieK6431pJ34xvyUEMCXEwKNojW817HyCvPQw
	 BYx0WaB3CMVhvXdtF9c1usFieM2B9RpAWmEPFDgFmuBiuaMG478XFTkDFy1QqWBSTnTry
	 3a+S/1HYq/lfvE3q1Wu9s4QyqZKO1DPTH8PD9ZWFKFBmJviJFIaQq6M1Q4p39IcVnf4sF
	 MM7C+G+8pZDhffJ8ysRVyqO14C2/g44ugmeHJWxdpBadFQTDrrAEAIcc3CcHe3Vx6lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533565;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=/AIb3So9MCT2SbD2Scd+/HlVguvx2ln4M2C5vvxMyjs=;
	b=npZGgguUoQzNwtzBfN7jDv9KG7mWFmH5HKr9YzcTJ77dEgTAR6HcEC8dso03OHyZDtUi
	 Zju+AqTAL2zem3vzoIbWiCVQ5GRwzHxhVlETULs9HG8G7jY8jNDMi9NTnEn7esW6Ki1dj
	 8oE3LSMvLe+04iOVmd3K4QTzT8RZ7pW9paPCX+6RbWcVGYoxpFuiGFVLHTJETcS4lZBT9
	 aDu/weZ3oIJPYLk7pjE6Bu9jQdKku9+VoBJQW6JbCXTW5GzxCgbp4MVxjNR/qTH1zMqBx
	 0/l5auzm/cZvSzWW86yofTIYMPG1VQGmN+qoTms1HpMTEha4DD7aRhiZh13iMiwQunw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pbu9Pnn9;
	arc=none smtp.remote-ip=95.215.58.74
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9470606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9470606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pbu9Pnn9
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XBRHkQX7a1dXHxnR1u1SHo8udwsy2HxO8jafhHb8B3A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794533562; v=1; x=1795138362;
 b=Pbu9Pnn9Q3hPVIZKH7d+wEAFxQomQqe4/SQEZtECuWupCXdnE8D+6zFBKRAqcicVWBx0iXVD
 JKxPusirVbpYVsJh5VZkosxwvWIOa4HBIC3JtcPgBCdsvvTRuqW78u90PK6f49NUcT8fCJChURB
 Aswh1ef8jgoDAnjbXv5sd5x4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 79730afe89d0038b;
	Fri, 13 Nov 2026 01:32:42 +0000
X-Mizu-Trace-ID: 79730afe89d0038b
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 09:32:25 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org, idosch@nvidia.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, jv@jvosburgh.net,
	andrew+netdev@lunn.ch, razor@blackwall.org, aahila@google.com
Subject: Re: [PATCH net-next 1/2] bonding: 3ad: Receive packets in COLLECTING
 state
Message-ID: <avZoqePFtrM6kEIV@fedora>
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

Hi Ido,
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

Makes sense to me.

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

If the partner does not set LACP_STATE_COLLECTING, it is not supposed to
send any packets.

> Would it work to also check bond_is_slave_inactive(slave) in the recheck,
> for example:
> 
>     bond_is_slave_rx_disabled(slave) || bond_is_slave_inactive(slave)
> 
> That would let the port recover on the next state machine tick.

I'm fine with or without this checking. But having this check looks better.
Up to you.

Thanks
Hangbin

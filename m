Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949700;
	b=s8HCiJCdG9cSbcEuijZhG3ZPswfgMX5qtJNmrpW35x9biM2y4vcIsBgoBO2+lA++g3j+
	 cjO10OcSbFCFvCGeIhtfqXDz1M48mZ6Wgt1B/CIp4TWpIUISXPWIwMhWtWnWPBzeivK/X
	 PNM7JXwXHVU1F4g7HYUHQMZiGJL4YXmwAI9VyQ2P8JvPp0M4Tn3Zr/HBBU0qa57CCN/nK
	 9a5rcmzHBVi5gc7rh5aBnAFNBMXaUhgiR8t9MpJcJNc8pzvwEGkU9MPJjxTRDp7K1KfSA
	 5lN7oJ5c76dOZS+2+7rGOE9kOAqZIZ31FdH5gNZPh5sgfNrZv2GCoP3BlGYgZvbYoKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949700;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q9YYTe4i+4Chs5+YJWhPl441drO/ZQz1qRAsGWnT09I=;
	b=aA1EtIve30YD5FpxbK2ytI+F34y6U/0q7lr4wPnqTExBBGMK7bEAU0uktcN7WV5oK3n/
	 w6K+iElXHiefhMXwHisATe8zORPntfCKTQSoG1LgduiC+cuKXCc6dAhGOKjKF0FRSdn88
	 EXnuJ56d7z6gO/u18VHodljyVRo/VXh9oyVqDoWjTrj/vtTez1GG2BXp5bgFmdkZl5nyG
	 lb+oQ1H9wYXO/tDbPicneuzF8A2J5x2EKORFFcpICU9tkj2BXq+mrzS5g1nCHwikOxhNb
	 Sc1FZEITMq4TPF3wsUBmfchrVFSiniyjVqZFBoblRv3OVy/iIk5QltHXzLeTrwXZFfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CLjn+X7o;
	arc=none smtp.remote-ip=95.215.58.233
Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B975606D812
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B975606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CLjn+X7o
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RqSggLrOpNcBQyi3pO63AlsgM6jzSKYB2+97JEfd7P8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793949697; v=1; x=1794554497;
 b=CLjn+X7oZ1Li6Tw+7+7sk9d54FQu32SslMOusYl8ds8/SJYrAf6MYeMu6y0FSSfv7viPmM8Z
 awmqNbBtDH6+2/OUuHC19G1gpjGGWudQituxfP6kD/msJPT3YxO2o6m8Ca98VaHTBGj39jl7yZT
 SyEWav4fM8I7rDVsIg7A7Xp8=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 984ea10fba56dac9;
	Fri, 06 Nov 2026 07:21:37 +0000
X-Mizu-Trace-ID: 984ea10fba56dac9
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 15:21:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: ramses@well-founded.dev
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Eric Dumazet <edumazet@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net v5 2/2] bonding: give a slave that starts UP a full
 arp_missed_max window
Message-ID: <au1_9r8R3PkVqRkN@fedora>
References: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
 <20261030-bonding-last-rx-v5-2-0b9b653f2f94@well-founded.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-bonding-last-rx-v5-2-0b9b653f2f94@well-founded.dev>

On Fri, Oct 30, 2026 at 03:51:16PM +0100, Ramses de Norre via B4 Relay wrote:
> From: Ramses de Norre <ramses@well-founded.dev>
> 
> The ARP monitor marks an UP slave DOWN once jiffies passes
> last_rx + arp_missed_max * arp_interval + arp_interval/2. bond_enslave()
> seeds last_rx one arp_interval (plus a tick) in the past, which brings
> the down deadline of a slave that starts UP forward by one interval
> compared to what arp_missed_max promises.
> 
> Active-backup mode hides this with a grace period after enslavement in
> bond_ab_arp_inspect(). Load-balance mode has no grace period after
> enslavement. With arp_missed_max=1 the deadline is half an interval
> after enslavement, and the first monitor run checks the slave before it
> sends the first probe. If that run lands in the second half of the
> interval, a healthy slave is reported "interface is now down" and comes
> back UP on the next run.
> 
> Seed a slave that starts UP with last_link_up instead, so it gets a full
> arp_missed_max window for its first reply. bond_arp_rcv() and
> bond_na_rcv() only trust ARPs seen on backup slaves once the active
> slave's last_rx is after its last_link_up. A seed equal to last_link_up
> keeps that check false until a real reply arrives, as it is today.
> 
> This only covers a slave enslaved while the ARP monitor is running.
> When the monitor starts later, from bond_open() or when arp_interval is
> set at runtime, the seed is still as old as the time since enslavement,
> as it was before this patch.
> 
> Fixes: 5944b5abd864 ("Bonding: add arp_missed_max option")
> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
> ---
>  drivers/net/bonding/bond_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 2f5638f4d3a78..84eafb607c370 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2158,9 +2158,13 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		new_slave->last_rx = jiffies -
>  			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
>  	} else {
> +		/* Give a slave that starts UP a full arp_missed_max window.
> +		 * Not seeding it later than last_link_up keeps bond_arp_rcv()
> +		 * from trusting ARPs on backup slaves before the active one
> +		 * got a reply.
> +		 */
>  		new_slave->last_link_up = jiffies;
> -		new_slave->last_rx = jiffies -
> -			(msecs_to_jiffies(bond->params.arp_interval) + 1);
> +		new_slave->last_rx = new_slave->last_link_up;
>  	}
>  	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
>  		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
> 
> -- 
> 2.56.0
> 
> 

Sashiko reported some other issues during arp_target/arp_interval set. But
none of these introduced by this patch. And we haven't received real user
report about these issues.

So for this patch

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

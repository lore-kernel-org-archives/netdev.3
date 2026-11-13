Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537863;
	b=kSaSAN0LBUVR1MZqB+fSAqZs09kldlsNOIHB3bp7OdGQqFazJ3fcuhONDnXuIv+jSVlu
	 8RHJtsWN/I5lPZMvA8f0tMASaPaU3PgIUhYgTFB+qsEttRPvq4HnYnY0hr9P7o31Wvt9R
	 U2WMYK6i/vEM/IFmJzPnJ5eiUWYTmuemYCLzvMN3c6dutrE57so0yU3KmEbzltS5P9uy/
	 UdnW+TOAe189Kf74PUGbOWLW1xs3OH+9+Zm1eamW0vdo0mzwtX8MvxTA1m8IHoyIvEXbr
	 ZJwk5Tyyv+p4ZuiRf/7V0XpFZhMPQi5s04z9lyGQFyLbAgmoqvIDrtCw0DZTUSOlOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537863;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4TRHs1DfBlKdmDJbWxzloimLXw9ZeFotvX38yZ1XhRg=;
	b=DsFQ6QC2cU27lv+KGHGsxBtgRfdXQFFHHODokjRyp6SjhUokWIN4Jp5JUoohbfQiVuIq
	 mlk9i0k1x4gy4sa3p2wJ44PurZMaAKi68oAa40NQ8An49wCX75eHoAt7QTgPJ+c1H8/55
	 zO8l/6bIuFfunvp+lQzTP0S6QqsDAKyoIXhNCL88MA9I3i7/kkHtvq9yzNaDaeQWWmtxl
	 1g/H+krG/p5c7o+Hzf45HEgYJwPseZL3pNRSje1nkazJvItMchd8LrG8+PN7G7LLGEsLx
	 41XhORSFoXU3H6r0Jx1PXdW8iZ2bSADeHNKuOnFyZNcl6lB+RaxytOQ12UceGQAk/Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NUA+44mg;
	arc=none smtp.remote-ip=95.215.58.1
Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84187606A334
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84187606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NUA+44mg
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uM/mtAX4nI/KfIYibTQw8PdMaeavSpiAqFsZsivtIZI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794537860; v=1; x=1795142660;
 b=NUA+44mg64uewSieqnzAL2rKJ+0elhQ10PV6OrkLhHAC+F2SNGJhQL0HSNtQGSzMOuBLoV/G
 Jb5Pm0GhIMyA7fQz5j/+cSxIip+TfDjaJS1YIvhg2SOA6vOEgX35T2t4ISpLjs71Ssu4f2XgyV5
 ArgOKOqhTl8HRYGEmboS0dak=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7cb7555790e61df8;
	Fri, 13 Nov 2026 02:44:20 +0000
X-Mizu-Trace-ID: 7cb7555790e61df8
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 10:44:09 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH] bonding: reject IEEE 802.15.4 and 6LoWPAN devices in
 bond_enslave
Message-ID: <avZ5eZLRKVgdc_7D@fedora>
References: <20261112130833.233208-1-skalpesh942@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112130833.233208-1-skalpesh942@gmail.com>

On Thu, Nov 12, 2026 at 06:38:33PM +0530, Kalpesh Solanki wrote:
> When the first non-Ethernet slave is enslaved to a bond,
> bond_setup_by_slave() copies slave_dev->type to the bond device.
> However, the bonding driver does not set up subsystem-specific
> mid-layer contexts or private structures:
> 
> 1. IEEE 802.15.4 routines (such as ieee802154_llsec_dump_table(),
>    nl-phy.c, and socket callbacks) identify WPAN devices by dev->type
>    alone and unconditionally dereference dev->ieee802154_ptr and
>    dev->ml_priv (ieee802154_mlme_ops). Because bonding never allocates
>    these, this results in a NULL pointer dereference.
> 
> 2. The 6LoWPAN netdevice notifier (lowpan_event()) identifies devices
>    by dev->type == ARPHRD_6LOWPAN and treats netdev_priv(dev) as
>    struct lowpan_dev. On a bond master, netdev_priv() is struct bonding,
>    so writes to lowpan_dev(dev)->ctx.table flags on events like
>    NETDEV_DOWN corrupt the bonding driver's private state.
> 
> The team driver closed an identical gap in commit 9043be310c6a ("team:
> reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add"). Bonding
> previously only blocked CAN devices in commit 8ba68464e478 ("bonding:
> refuse to enslave CAN devices").
> 
> Reject ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and ARPHRD_6LOWPAN
> devices in bond_enslave().
> 
> Fixes: 8ba68464e478 ("bonding: refuse to enslave CAN devices")

Nit: I’m a bit wondering whether we should use this fix tag.
The issue exists both before and after this commit.

On the positive side, the tag can notify users to backport this
patch if they also carry 8ba68464e478.

Since this is not a regression, it should probably target net-next.

> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc..b3b003e39b2 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1894,9 +1894,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	struct sockaddr_storage ss;
>  	int res = 0, i;
>  
> -	if (slave_dev->type == ARPHRD_CAN) {
> +	if (slave_dev->type == ARPHRD_CAN ||
> +	    slave_dev->type == ARPHRD_IEEE802154 ||
> +	    slave_dev->type == ARPHRD_IEEE802154_MONITOR ||
> +	    slave_dev->type == ARPHRD_6LOWPAN) {
>  		BOND_NL_ERR(bond_dev, extack,
> -			    "CAN devices cannot be enslaved");
> +			    "CAN, IEEE 802.15.4 and 6LoWPAN devices cannot be enslaved");
>  		return -EPERM;
>  	}
>  
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460305;
	b=vwvfaRc7QgtvTiUcc4tuHnC9GOGc3LsCTOPIHbrD9xaMl/vRS+Wkx/0tpXMHPFyShoar
	 58u+FxkFuZk5Cy2u4czJE4xUxgF6QAmD40R+HAE6LHSp97yDtXfUJ/yilPzHfTelEU6If
	 D2W1DodNBkR04GoU8sGw0OYjYTP0OFherJvQ6mdbmOZAadrqyzUAOM+zq2CBZ/IgvYpbT
	 ooylElVwP5/O2ZfnALqJZV55wUr2vugxcG0mi+ogj63svP3oCTBBbFciiu7gEtht9IVC6
	 lpUZBSfjRTgaRtTvw++uDEhSq/d0DXOyCZpYATArBwdYB/YPU90pFJY0c8ydO0phUgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460305;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=usNYCTGOXfbAT1C1//piOShSVVfXVlsx9LA+HpO8xUI=;
	b=FCHTjiB3xixHuB0boChenY4ERhN16wMshMLzvoAjDVYpMS/xBGdAktc5FVBAm9q8o+gn
	 V5DEFVy/Kte7KTzRM6m6Et7wSd7IRjWfr+FZFYlx2QqJp25p4+j2qZnOGPmcSpuXyWrNA
	 cfHSkN4IfFxF17rfBvi8fuGCcj6nruiNxHICaAFF7oSDwgSrxOo0IUany2j653b+T4Wuo
	 vTDUcUZp78iz2nXmU4InKC2pRQDwbOVHTy+CLgqPoVQAwOq6xirhq9/x0zgf6SzQlJHsl
	 7moR7ZFwMhcG9fvTpTgL8LidASpaRHyBOJyjxzLFTQt89PEVKST+ERZg0OFOY0L9zzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.110
Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD3606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 01:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65AD3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SvymMiE1h9eGO72NOBmTXmWopdT7YaAz+Ajx0/HkoVg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792460301; v=1; x=1793065101;
 b=NxtzGOTyu5QdhuKmNmyEE9601ys6bN9dXLPKY4KYOvQvcA+hay9qrc5F1kdSo1ukQAdytcH3
 I8fHnc+Oq0T3n9QSd500rOe1CVqaXTXnCmi9v1tHha206lhUnHymEHdvpvrvPolOwHatlc9ut+0
 Ix6FgAd8K6OqBqGvXX8GdBfE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 41f018b724df8ac4;
	Tue, 20 Oct 2026 01:38:21 +0000
X-Mizu-Trace-ID: 41f018b724df8ac4
X-Migadu-Flow: FLOW_OUT
Date: Tue, 20 Oct 2026 09:38:04 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH net v5] team: reject CAN, IEEE 802.15.4 and 6LoWPAN
 devices in team_port_add
Message-ID: <atbF_LBIJYIynlq3@fedora>
References: <20261019155407.61487-1-socketcan@hartkopp.net>
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
In-Reply-To: <20261019155407.61487-1-socketcan@hartkopp.net>

On Mon, Oct 19, 2026 at 05:54:07PM +0200, Oliver Hartkopp wrote:
> From: Jiale Yao <yaojiale02@163.com>
> 
> When the first port has a non-Ethernet type, team_setup_by_port()
> copies port_dev->type to the team device while netdev_priv() of the
> team device still holds a struct team. Several L2 stacks identify their
> devices by dev->type alone and then access type specific data that the
> team driver never sets up:
> 
> - CAN protocols rely on the CAN mid-layer private data (ml_priv)
> - IEEE 802.15.4 code dereferences ieee802154_ptr and the mlme ops in
>   ml_priv
> - the 6LoWPAN netdev notifier writes through lowpan_dev(dev) on
>   NETDEV_DOWN and reads it on NETDEV_UP/NETDEV_CHANGE
> 
> Enslaving such a device (e.g. vxcan, wpan0, lowpan0) therefore leads to
> NULL pointer dereferences or to writes into struct team.
> 
> This is the same problem that syzbot reported for the bonding driver
> with a vxcan device enslaved to a bond master, which crashed in
> can_rx_unregister() and was fixed by commit 8ba68464e478 ("bonding:
> refuse to enslave CAN devices"). The team driver has the same gap.
> 
> Reject ARPHRD_CAN, ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR and
> ARPHRD_6LOWPAN devices in team_port_add().
> 
> Link: https://lore.kernel.org/all/b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net/
> Link: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95 # bonding splat
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Assisted-by: Claude:deepseek-v4-pro
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> v5: [Hartkopp] reference the syzbot report of the identical bonding problem
> v4: [Hartkopp] also reject ARPHRD_6LOWPAN as reported by Sashiko AI
>     review, reworded commit message (bonding only rejects CAN)
> v3: [Hartkopp] fixed indention and compilation as reported by kernel test robot
> ---
>  drivers/net/team/team_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1223,10 +1223,21 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  		netdev_err(dev, "Device %s is loopback device. Loopback devices can't be added as a team port\n",
>  			   portname);
>  		return -EINVAL;
>  	}
> 
> +	if (port_dev->type == ARPHRD_CAN ||
> +	    port_dev->type == ARPHRD_IEEE802154 ||
> +	    port_dev->type == ARPHRD_IEEE802154_MONITOR ||
> +	    port_dev->type == ARPHRD_6LOWPAN) {
> +		NL_SET_ERR_MSG(extack,
> +			       "CAN, IEEE 802.15.4 and 6LoWPAN devices can't be added as a team port");
> +		netdev_err(dev, "Device %s is CAN, IEEE 802.15.4 or 6LoWPAN. These device types can't be added as a team port\n",
> +			   portname);
> +		return -EINVAL;
> +	}
> +
>  	if (netif_is_team_port(port_dev)) {
>  		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
>  		netdev_err(dev, "Device %s is already a port "
>  				"of a team device\n", portname);
>  		return -EBUSY;
> --
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

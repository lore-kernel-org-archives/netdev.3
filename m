Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794490385;
	b=nKyX1ESZ9hn5LqZN9t9pXLZifUsSeLGu9lJcnidyPb7I53dwvIuT4P4/YuHbRkl43UV/
	 BoJ++c2XoeEU9vohVR9HlEHwnM8YxJxxkYWeXgnqdUiYAcrqG3NzlzmIYJTlPUGOq4VqT
	 Ywrsos+w6YxY4qpxILi2uwHxclZd/NxKAnMiHZaXYl1vX1qhBU2dc92vIe6Od8ewdVYW4
	 Po4GXzTmn8Ygi+sVZA75seXipuUw+/9w6ek2porxJD4JfF2SqCB5JXaJPz4oD+Uqsxn6C
	 q8ZxFrYdwM9DgPmIP5YRNE4at8+MhKEE6OIXuIh0OW1u+CAx6eNwZRZUNDY1PaR+sTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490385;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XEpG/m7IN5D5yxsecINq+awxii2iq6OXFLjGmU4ka2c=;
	b=2iU9GJe/n6rNt0/d892CzRB2df8dYe+PS+GjVSfb3Vtq61j7jGEnQt0g8OFrgg8Y7YA0
	 gCWkpjkNnnVRVL/HrqOlzUVl4LB0bTMJvfBq6SgT8f398YTtOwgOUjcYvXPvGK0xfk7HE
	 0zmbaiURmQPDuX3YuZim0YgT/SbftrcH4wjGW7Mr7PeO4ocaPtoQFVzrH10UTuZojY/Es
	 3l0kY/DdLa8yAYPDcC4vz6S0ay1enfR0El/kHzUmcC+aSpaMz4SzY8ZJR9ux70R/S+xef
	 EkadX67Regnf5ScJ1//7Z3Cmjg/m8mJuZ0Cw/icgVJQUYntm+ysXV4rbs07pxn5Gy5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Wx9Q9+s8;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eFzU6gPy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6A606A32A;
	Thu, 12 Nov 2026 13:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C6A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Wx9Q9+s8;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eFzU6gPy
ARC-Seal: i=1; a=rsa-sha256; t=1794490366; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZOtKtgOf/WJ4Xw1AzwVwZ4nOOj92XwZBAZDJeNUlVU4kUZuHY4uTGGQfcexrxH8I2A
    BcLX2Zayy1xeMzUE6oGkcWvBYHxaW7G89yXr/6Ll584q7o6b46aZ0NP4+W9HJdJfY3lh
    h8/aSXpw5vbadMmcbL7zHf7K1knzm0M8rRsyihmhQnQH/H+huYWCzynAjfxfNP+GF/p2
    CYLLmPEnGfEBJLq1ZCYJicNfvyz2sBWxyKcDG28pUjtixUgBSbwDMUd+SNkHZzQJy/yU
    e/PdEgf4EI8XEeusS3Ld/f/QNgesXWrayklOTN8mNxU2Jf9yA2+qPThwbrMKKbeLH3j1
    ZA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794490366;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XEpG/m7IN5D5yxsecINq+awxii2iq6OXFLjGmU4ka2c=;
    b=Q6imTTss+THwP7hbTA4LWrO4kI6BRaSeGk9IzysB715dINQBVW+8jn6q496NUvUG8l
    qz453CI9OraW2KNdQLayry+CIHmjAUPBXRhJfz7kSQMoEeShHJdnKyWJjrkeHlt8iZ8X
    0PcPldItQe9mjO8tF2GyecmFTbqCo9FgNnf7x2ebgxAE0ZvGZMlJsdcbEcyT1dtqSI+o
    iIqe6EFIZraDfFtnZ68xRxszXeCFhcnmJ3nKC9WPA0DamPH4BtfyRiiYqKaixKyegiJf
    +NkKtMj8sQcYr9hAs/T4cZxzHfnus3dMKv04YImXTl3aywuOPCJSR6IVIQe2cZvfxdnN
    uOvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794490366;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XEpG/m7IN5D5yxsecINq+awxii2iq6OXFLjGmU4ka2c=;
    b=Wx9Q9+s8hfiUHhqRzxoTjiFDIfU23RbQ+udZ9OhM2Mt4AQSFvJcbfAnwxxtLuaVVYg
    mAOab/eUXekJH+8f4gRZAS6hHriPn/+Wi42zX6n/PLvrjLtJhBzecwFAPQOQThW6klTW
    /bPMmMyLU2STqfJyAuJ0ylcKRfYq7vGWVNWNaK58vervbIgsAks0NNoNB+7pjsziTrs4
    AbA/QHUvc+vN/C02QXlp3ogjVaXEkCs5AFwdrr5ycQiPnoWNnRdEPI9jfFpEOn/098NZ
    bQt2D8eBYaPFA9aBkt8lSkMuDWCNwlM8A2N3Twy68K2FaT2uxTjTP2VUHHVEGsTk60dC
    irzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794490366;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XEpG/m7IN5D5yxsecINq+awxii2iq6OXFLjGmU4ka2c=;
    b=eFzU6gPyszN+hvHSemQ7FP6gLgT9RhB5CFF5j57dGesQdsf5TmyBdTC2gVSmAz4bY4
    S9llDqKqOgirYis1mNDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.3 SBL|AUTH)
    with ESMTPSA id Kfdf2a2ACDWkFI7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 12 Nov 2026 14:32:46 +0100 (CET)
Message-ID: <9e202895-ff3a-41ab-9bd9-96568561ebc6@hartkopp.net>
Date: Thu, 12 Nov 2026 14:32:41 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: reject IEEE 802.15.4 and 6LoWPAN devices in
 bond_enslave
To: Kalpesh Solanki <skalpesh942@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiale Yao <yaojiale02@163.com>
References: <20261112130833.233208-1-skalpesh942@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261112130833.233208-1-skalpesh942@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalpesh,

many thanks for picking this up!

On 12.11.26 14:08, Kalpesh Solanki wrote:
> When the first non-Ethernet slave is enslaved to a bond,
> bond_setup_by_slave() copies slave_dev->type to the bond device.
> However, the bonding driver does not set up subsystem-specific
> mid-layer contexts or private structures:
> 
> 1. IEEE 802.15.4 routines (such as ieee802154_llsec_dump_table(),
>     nl-phy.c, and socket callbacks) identify WPAN devices by dev->type
>     alone and unconditionally dereference dev->ieee802154_ptr and
>     dev->ml_priv (ieee802154_mlme_ops). Because bonding never allocates
>     these, this results in a NULL pointer dereference.
> 
> 2. The 6LoWPAN netdevice notifier (lowpan_event()) identifies devices
>     by dev->type == ARPHRD_6LOWPAN and treats netdev_priv(dev) as
>     struct lowpan_dev. On a bond master, netdev_priv() is struct bonding,
>     so writes to lowpan_dev(dev)->ctx.table flags on events like
>     NETDEV_DOWN corrupt the bonding driver's private state.
> 
> The team driver closed an identical gap in commit 9043be310c6a ("team:
> reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add"). Bonding
> previously only blocked CAN devices in commit 8ba68464e478 ("bonding:
> refuse to enslave CAN devices").

You could have referenced the bonding-splats from my patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9043be310c6a4c5e57f7bba4b9870554eac7aa96

So it is not only that this problem has been found by manual code 
inspection.

> Reject ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and ARPHRD_6LOWPAN
> devices in bond_enslave().
> 
> Fixes: 8ba68464e478 ("bonding: refuse to enslave CAN devices")
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

Best regards,
Oliver

> ---
>   drivers/net/bonding/bond_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc..b3b003e39b2 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1894,9 +1894,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   	struct sockaddr_storage ss;
>   	int res = 0, i;
>   
> -	if (slave_dev->type == ARPHRD_CAN) {
> +	if (slave_dev->type == ARPHRD_CAN ||
> +	    slave_dev->type == ARPHRD_IEEE802154 ||
> +	    slave_dev->type == ARPHRD_IEEE802154_MONITOR ||
> +	    slave_dev->type == ARPHRD_6LOWPAN) {
>   		BOND_NL_ERR(bond_dev, extack,
> -			    "CAN devices cannot be enslaved");
> +			    "CAN, IEEE 802.15.4 and 6LoWPAN devices cannot be enslaved");
>   		return -EPERM;
>   	}
>   


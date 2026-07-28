Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB23C6A5C;
	Tue, 28 Jul 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222712; cv=pass; b=HtNKrpmUE+U02cPvlUABm90aphT+OUCQ55DP4k0NOSxxA52Q5ywksHP3tr/Zq74anq4vx6ylQi4L0Vgsf2KklwG+PQZXqqMKRa2VJgi8nG/ZsQfn9Ii9SPyWK9kF3k2ghDE3ykPijYnSSeQsUkkpdRrdktGveZDUuH9V5oFE6gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222712; c=relaxed/simple;
	bh=wIm+qrYyJ9bO697UKL56Tbh4mLaPlA2eLGXp0I2aB5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tYYJZWZ2YqsGMaaYJgukPf5LUwX3wV+Xa4UhyvJrjqEsHA3fOim/NgBsanInNokFM4jYr8GJrfbwQFUXUWEZD7v9AOwd4Z1IExxPyY395yjxfW85ekt7h5DhrBtN1jOkiJwfsneobJNoA1zAYoTEe6RQxzYU74jD/OtVQ7LPVjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Cl27F1cS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=htvDeNb/; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Cl27F1cS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="htvDeNb/"
ARC-Seal: i=1; a=rsa-sha256; t=1785222706; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OBiKUN0SdgC4jxy2/0ovWLrPS+phNwh4fNitLHykOGJG4s9iwGwGvYRocyomcMZipS
    orOIQ5MLQsfW7jb6+V8l+Hv+pTPJporWE1YauqmxK/a6g/G3L3ZhB0wWO1FX94sQycNN
    xAM8P2nDnsctV0rhnzd2XjQgC+tuKMiZnixfCwSN6Hjrkfp7usvUmjxgOO+SADGBg0Fi
    0MsLNux0k3NO/pHzWE7qvL2vtIB7IRHidRW+derlWx0QEOMFQb5BYMMhXQ+shptj2MSZ
    afWsNmrOY+Xnsvhvx/V6liPkcuBnn7iK3MO5If4v7vz+7tIYE+LCdSO4YyW9bgX1THYc
    YrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785222706;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sKN51Z73r0ArWTjaniw2XLiKIB97yBpfa09IpCTJVZ4=;
    b=ULiX2gtsZn1TfyVQBbxWjJbzuUJkYyqVvBkaOvsM5eyWCGIO+xoBAiZJu3CxLfGoO9
    2OS1hANm66wxtYRzIMFGXufhhFOO+tLpRpKo/hflShtO9MtOArqwN3C04xSF8uuiijhj
    LdRGPhS8nyUxPejGZfafm2QjGx6GrxVR+NTq+TVYEeytrurtCSSzfGuTLh+0mwdjf+di
    fo/+MOQkEPNIYs3ePNH4cVvInENLS0WXuIFsiA7eItZEJqNLxuVVznEXHuYUPsCUw5rN
    qqDNvrPW7NxFXKV+gkNZWU8KKarp6RlXCJh298jWpPWvCR6j/jMOWuFRhlflWfHiHGQH
    WOhQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785222706;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sKN51Z73r0ArWTjaniw2XLiKIB97yBpfa09IpCTJVZ4=;
    b=Cl27F1cShh6qF3i6/uTDhtlKVpuBrZb4Fc0zWJCuo4RFypWwQKKisAR739clPAs+fA
    msROolNg1ePf07opN2Ii/zPmY1w6b5C6H5DKmW8ajnbpeR0/vZQg0AdMIXpvB2D+Eny1
    VXCsj0oqkOEm3Je1XHW9E3rQEsUJZpL9rH7BjtzGTXxHJaoJGP3HYsZx0aeJfOaD4aLM
    FRyN1p9ZzwSjRZbt1/gwX+VcS8Vt2OEnvT+nUEjVx1T7WHoANgkU4PNpIkmtI/JpMkT8
    FRhwh/8bRVAyVm8LJpLKVRjlKr+pIBPi/dx5skwSJJKSWAz6hGH/pdMgdy+fPwQZg27F
    Nz4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785222706;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sKN51Z73r0ArWTjaniw2XLiKIB97yBpfa09IpCTJVZ4=;
    b=htvDeNb/Tx2RWAYCWLHVVnXGpQF4y5fJ3fZH6eWhBczu8p0o2uqmJrD73D8HjIAzHr
    0vC9FFRfJOLytM0nR5Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926S7BjHLU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jul 2026 09:11:45 +0200 (CEST)
Message-ID: <b58d98e0-8fe3-4e4e-b8a5-c1c7e647ccca@hartkopp.net>
Date: Tue, 28 Jul 2026 09:11:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] team: reject ARPHRD_CAN devices in team_port_add
To: Jiale Yao <yaojiale02@163.com>, Jiri Pirko <jiri@resnulli.us>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723040032.2094322-1-yaojiale02@163.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260723040032.2094322-1-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23.07.26 06:00, Jiale Yao wrote:
> Enslaving a CAN device (e.g. vxcan) to a team master triggers a
> NULL pointer dereference in can_rx_unregister() inside
> net/can/af_can.c.
> 
> During team_port_add(), the code only checks IFF_LOOPBACK but
> does not reject ARPHRD_CAN devices.  After passing this gate,
> team_dev_type_check_change() calls team_setup_by_port() which
> sets dev->type = port_dev->type, adopting the CAN type for the
> team device.  However, CAN devices operate on a fundamentally
> different Layer 2 architecture, relying on the CAN mid-layer
> private data structure (can_ml_priv) instead of standard
> Ethernet structures.  Since the team driver never initializes
> can_ml_priv, subsequent CAN subsystem operations -- such as
> closing an ISOTP socket bound to the team interface via
> isotp_release() -- reach can_rx_unregister() which dereferences
> the NULL can_ml_priv, causing a kernel crash.
> 
> The bonding driver already rejects CAN devices since commit
> 8ba68464e478 ("bonding: refuse to enslave CAN devices").
> Team, as a sibling aggregation path, needs the same protection.
> 
> Fix this by adding an explicit ARPHRD_CAN check in
> team_port_add(), directly after the IFF_LOOPBACK guard,
> consistent with the approach taken in bond_enslave().
> 
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Assisted-by: Claude:deepseek-v4-pro
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

I did not know that the team driver had the same approach.
Thanks for catching this!

Best regards,
Oliver

> ---
>   drivers/net/team/team_core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index feaa75fbf8fc..38f88a836010 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1224,6 +1224,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>   		return -EINVAL;
>   	}
>   
> +	if (port_dev->type == ARPHRD_CAN) {
> +		NL_SET_ERR_MSG(extack, "CAN device can't be added as a team port");
> +		netdev_err(dev, "Device %s is CAN device. CAN devices can't be added as a team port\n",
> +			   portname);
> +		return -EINVAL;
> +	}
> +
>   	if (netif_is_team_port(port_dev)) {
>   		NL_SET_ERR_MSG(extack, "Device is already a port of a team device");
>   		netdev_err(dev, "Device %s is already a port "


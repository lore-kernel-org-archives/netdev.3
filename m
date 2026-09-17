Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E694A8A13
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636946; cv=none; b=u6Ds/R7kqUVAmXrVPFOVd9iMxM2fEPR3FwVGMPLYCE9RNYKLG8ILham+CIA5nOn8Nxm5BMcFMC3yVn19C+XdXbHmSPEz+i0kntMHKHZDNW1LlSU2oCEIWAdc1REvQa1KK9s4zJwgPbwA2k0fnbE5NsCsu5XcpYFMBdSx/WodonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636946; c=relaxed/simple;
	bh=+Stjrj+vGNOF5NuNWJl/btEftxR8T7A4aY+OgvE3Ijs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uotHEfkZam3t8fsVcnzttr0yJ6eNp+JyLEVzm3LsVJL5leb+QVbvl0r69hFgLJ6/K380b3QXSTb1gxZcZSjHFTGnVnwJtxu5qLrAepe7IMmmWDawRjaUsByarmDtrolzDkJIWYahvuCutVPnXSDqaqD3CWTWZrNhriJf+Ws+zsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BJamNHrP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BJamNHrP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC8DEC5CD6F;
	Thu, 17 Sep 2026 09:23:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 528DA5FAA3;
	Thu, 17 Sep 2026 09:22:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F91211C7B073;
	Thu, 17 Sep 2026 11:22:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789636941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0qQ2paoHG8bvZyAwZpWekURyukr1Gkc/RRDyLmU4R3M=;
	b=BJamNHrP3uwXYpFlqZjl8VGvUvakoOwSjwk1ZAFDleEoH0EMTGzQGqNsBdw2Z138b0CrRz
	UvCcl5MTcFwNQDjp0uwPMNCH/D5f2jyMy/pzhCCbHBjUYJvUqjoQw6OydEYhdl6mMAyGJE
	b6s76JD5ojJs/tQBGKsGVRaMTX9qlp8AL8sjI6LECbAgkgrTbJQ2Gz+WsAcQpMW/P6Yamp
	e+Lhg4v/qbDrhIDAHMOLYBYMYgJAJ1wt3kXC1uflaMA4FAXZ5N+NN+P+Lape/acWWXE9EF
	rBovCVkTeyJJ7JR24dZeDT6yuV42GXFomz4nvKvJfIyvAAvf/ZpPZnatK4zbCg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 11:22:17 +0200
Message-Id: <DLHHCJ7NP756.3S1PWCQHV5Q3V@bootlin.com>
Subject: Re: [PATCH net-next v2 3/4] net: macb: Add MQPRIO qdisc hardware
 offload support
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-4-vineeth.karumanchi@amd.com>
In-Reply-To: <20260909142056.1433875-4-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Wed Sep 9, 2026 at 4:20 PM CEST, Vineeth Karumanchi wrote:
> Add support for TC_SETUP_QDISC_MQPRIO hardware offload, allowing
> traffic class to queue mapping via the mqprio qdisc.
>
> Implement macb_setup_mqprio() which configures TC-to-queue mappings
> through netdev_set_num_tc() and netdev_set_tc_queue(), and resets
> them when num_tc is zero. The driver advertises TC_MQPRIO_HW_OFFLOAD_TCS
> offload level.
>
> Add macb_tc_query_caps() to report mqprio capabilities. Setting
> validate_queue_counts to true delegates queue count and overlap
> validation to the mqprio core via mqprio_validate_queue_counts(),
> avoiding redundant checks in the driver.
>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
> Changes in v2:
> - No functional change; rebased on net-next, which renamed the
>   struct net_device pointer to "netdev" (was "dev"/"ndev").
>
>  drivers/net/ethernet/cadence/macb_main.c | 59 ++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index ff7e02d3fab8..67150ff03066 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4492,6 +4492,60 @@ static int macb_setup_taprio(struct net_device *ne=
tdev,
>  	return err;
>  }
> =20
> +static int macb_setup_mqprio(struct net_device *netdev,
> +			     struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct tc_mqprio_qopt *qopt =3D &mqprio->qopt;
> +	u8 num_tc =3D qopt->num_tc;
> +	int err;
> +	u8 i;
> +
> +	/* Handle reset case early */
> +	if (!num_tc) {
> +		netdev_reset_tc(netdev);
> +		return 0;
> +	}
> +
> +	/* Configure traffic classes */
> +	qopt->hw =3D TC_MQPRIO_HW_OFFLOAD_TCS;
> +
> +	err =3D netdev_set_num_tc(netdev, num_tc);
> +	if (err)
> +		return err;
> +
> +	for (i =3D 0; i < num_tc; i++) {
> +		err =3D netdev_set_tc_queue(netdev, i, qopt->count[i],
> +					  qopt->offset[i]);
> +		if (err)
> +			goto err_reset_tc;
> +
> +		netdev_dbg(netdev, "MQPRIO: TC%d -> queue %u (count=3D%u)\n",
> +			   i, qopt->offset[i], qopt->count[i]);
> +	}

MACB queue N is always higher priority than queue M if N > M. Here we
should refuse the setup if mqprio->qopt->offset[i] isn't sorted no?

I asked an LLM and it found a precedent in igc:
igc_tsn_is_tc_to_queue_priority_ordered()
https://elixir.bootlin.com/linux/v7.2.5/source/drivers/net/ethernet/intel/i=
gc/igc_main.c#L6797-L6801

> +
> +	return 0;
> +
> +err_reset_tc:
> +	netdev_reset_tc(netdev);
> +	return err;
> +}

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


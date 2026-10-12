Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5547492E55;
	Mon, 12 Oct 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810222; cv=none; b=OntBhNpLN0eK0nnj8DSOY92kkqA1NPIodNWemwaNDshCB2ZWvyXxMlzoz0itOIUXLaRefEYmKQZSrAkMAoJaTTLkmKNKoXERJaevc5+lur3yJ3VfhNy1/HXFRrc67DHJfkeZocIEj34k1/+TUbWmV6t6VI7Za0ftpgTXeXp2560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810222; c=relaxed/simple;
	bh=cvbfgS5g+7JPRPJCscUOGp885XiFHsQ+KJlNe9yeZmU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UDpLa2cSxXzj2m3KtlJ9hJvS/gRnbNfy5oQfFQLvzDMOp1860Fa8wXZoAop9SXFAekBvF6s/aE8mgSXBmAEYUJiVHlc42v8zlCsuJry26QU56M6BDz6yAdmJujWu7UGpjyMCITaZq3XeoKymOurjMPLwxq/roFm0NuBm8sc8A70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxDo/WJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxDo/WJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F21F0089B;
	Mon, 12 Oct 2026 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810220;
	bh=3XqSrKCa84e+HqE5gbWTI47m1f8S2aJtTZICNp1fLtM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MxDo/WJVaR18b7UeYusUJyFBi0tkEDHSETEpw45jChK6GziwcjjhWjkqmr15dDzDp
	 5MenHo/eqihjaUgRbRNr8ZBfvo5nKZdXGiWPUj8NFnQ/bfYPE1ssOynr0P45qjMJ0q
	 4WfPa3yVH+m2zq53utlvrvaSYa+f+6xMRJWNQZWwW9DcGr3+1WR0bRlXTKyHdsLhmr
	 hyUGfvduv+89HVNsFO9uiWJjEUWaEzFZTULqYyzgRpCUJmWvAx3oEMRG0hFBhthP57
	 nGBnK1IBWiMQJSV71tdWPsO6slmartlKL1uCKX+MMhHc0S7QsUbK7cHl+e9MDh5K2S
	 WKY4/PIMYLgRw==
Subject: Re: [PATCH net-next v2 07/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 QM configuration
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 13:03:39 +0000
Message-ID: <179181021906.434549.13205983754847009473@kernel.org>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-7-8c7b057e2c43@oss.qualcomm.com>
References: <20261011-qcom_ipq5424_ppe-v2-7-8c7b057e2c43@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message and the new code comment above
  ipq5424_ppe_qm_group_config in…

Pre-existing issues:
- [Low] At this commit, ppe_port_resource_get() checks `port >
  ppe_dev->num_ports` and then indexes the single IPQ9574-shaped…

--

net: ethernet: qualcomm: ppe: Add IPQ5424 QM configuration

This commit adds IPQ5424-specific QM settings, which ppe_config_qm() selects
based on ppe_dev->type. On IPQ5424 the multicast queue range ends at 283
instead of 299. The group0 shared buffer pool is set to 2010 buffers
instead of 2000.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index ef46e9b133fe..d2bd78853b98 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> @@ -314,6 +314,37 @@ static const struct ppe_qm_queue_config ipq9574_ppe_qm_queue_config[] = {
>  	},
>  };
>  
> +/* Multicast queues are dedicated per PPE port. IPQ5424 has only 3 physical
> + * PPE ports, versus IPQ9574's 6 PPE ports, so multicast queues 284 to 299
> + * are not available on IPQ5424, and the buffer pool assigned to the general
> + * 'group0' is larger here, 2010 versus IPQ9574's 2000.
> + */

[Severity: Low]
Is this explanation complete? The commit message uses the same wording.

In ppe_scheduler_res[], ports 4 to 7 each get four multicast queues:

    port 4: mcastq 284-287
    port 5: mcastq 288-291
    port 6: mcastq 292-295
    port 7: mcastq 296-299

The three missing physical ports only cover queues 284-295. Queues 296-299
belong to port 7, the EIP FIFO port, which IPQ5424 also does not have.

The queue range in ipq5424_ppe_qm_queue_config[] looks correct. Could the
comment and the commit message also mention the missing EIP port?

> +static const int ipq5424_ppe_qm_group_config = 2010;
> +
> +/* Default QM settings for unicast and multicast queues for IPQ5424. */
> +static const struct ppe_qm_queue_config ipq5424_ppe_qm_queue_config[] = {

[ ... ]

> +	{
> +		/* QM settings for multicast queues 256 to 283. */
> +		.queue_start	= 256,
> +		.queue_end	= 283,
> +		.prealloc_buf	= 0,
> +		.ceil		= 250,
> +		.weight		= 0,
> +		.resume_offset	= 36,
> +		.dynamic	= false,
> +	},
> +};

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch, but it
interacts with the multicast range set here. ppe_port_resource_get() still
indexes the single IPQ9574-shaped ppe_scheduler_res[] table:

drivers/net/ethernet/qualcomm/ppe/ppe_config.c:ppe_port_resource_get() {
    ...
	/* The reserved resource with the maximum port ID of PPE is
	 * also allowed to be acquired.
	 */
	if (port > ppe_dev->num_ports)
		return -EINVAL;

	res = ppe_scheduler_res[port];
    ...
}

On IPQ5424, num_ports is 4. A request for the reserved resource
(port == 4) would return the IPQ9574 port 4 entry, which has unicast
queues 192-207 and multicast queues 284-287.

This patch leaves multicast queues 284-287 unconfigured in QM, so
enqueue and dequeue stay disabled for them. The correct reserved entry for
IPQ5424 would be unicast queues 64-143 with no multicast queues.

Can ppe_port_resource_get() hand out multicast queue IDs that are disabled
in QM on IPQ5424?

No in-tree caller passes port == num_ports at this commit, so the problem
is latent. ppe_queue_dest_init() loops while port_id < num_ports, and the
other caller passes port 0.

A later patch in this series, "net: ethernet: qualcomm: ppe: Add IPQ5424
scheduler resource configuration", fixes this. It adds
ipq5424_ppe_scheduler_res[], where index 4 is the reserved entry. It also
changes ppe_port_resource_get() to pick the table by ppe_dev->type and to
bound the index by the table size.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43%40oss.qualcomm.com

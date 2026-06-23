Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCD3D0935
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212132; cv=none; b=q8LQAQQmXjol+zqYZYKh+uNLfmYt0uWW7hs6hwEaVoXJY+ILSroRBmat/T7pMnIvu3ds+P93uOCDvSnH9eJoHdO/SlOiMzInd+jdB9EGQUQje4HI+wWATFmUQe2P1pTZnWa+eNnASVTAJdx9I8ZJyQasolXGJLG2hfY8pbbmwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212132; c=relaxed/simple;
	bh=J30Dns6EzCy6b3UtcXpRMBKl5qMw0SAFSVF9DwxcDY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzxPyjTznQMaFnOyN1vARXVpTERIXcgChrLo+aRhNqm6pBwZXZ217NxOHF1ceS18Al91uXUrU2EgNUNKG9aBQgMc9HgvjN1Xv6ONUHWGKTc9Qtq2ckgB96S+yE6OM72WFI43rL/1abDvQKzoq6iYhj7DJ7ndhxW+1czHIml8bnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd6H/AKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd6H/AKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DA01F000E9;
	Tue, 23 Jun 2026 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782212131;
	bh=lAKwacoVI7uad9g+jIiH9ookXbWgdh+4rlS83ehVIsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nd6H/AKBBiphRBm1G0fYBB/P+tJDY3EthHSrSuOOIqxHa6P2zbJvBNW94bt7wq4BM
	 rcllD8dhyskNiOvyEehpiUPLIwJ3tjjuuVyc+NmGA1tuO2mAYiL0zclDwVkartqoWh
	 JBUmRhr6KcBb2z1TaCUVlUkV4kaoAjkb+4ajB48qoXaU1vF/SGzxVybKk7d/xjSX9X
	 DbKFzsyU/r7eKd4RVUehBiutUMpt+UdwJ70k1ZZzm3JxfNyBXGe9cFNk6BLz+1/D8O
	 W/0IqzZAHxFalUAivpxEFo1eso1fU+u/AZ6PfMIUYMwr6PI3gHIfXWrRcC3NHBcGG7
	 dQmTtiXdafUwA==
From: Simon Horman <horms@kernel.org>
To: lorenzo@kernel.org
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leto.liu@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	brown.huang@airoha.com
Subject: Re: [PATCH net v2] net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()
Date: Tue, 23 Jun 2026 11:53:42 +0100
Message-ID: <20260623105341.1076863-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622-airoha_qdma_set_trtcm_param-retry-fix-v2-1-95a83ac99dbd@kernel.org>
References: <20260622-airoha_qdma_set_trtcm_param-retry-fix-v2-1-95a83ac99dbd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: I'd appreciate it if you could look over the first two issues
            flagged below in the context of this patch. While the third
	    and final issue looks like it is in possible separate follow-up
	    territory.

---
net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()
    
This patch introduces a retry loop to airoha_qdma_set_trtcm_param() to mitigate
bus timeouts when configuring QDMA parameters. It attempts to verify that the
configuration is correctly applied to the hardware.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 3370c3df7c107..bb5c0599a4eed 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2673,14 +2673,30 @@ static int airoha_qdma_set_trtcm_param(struct airoha_qdma *qdma, int channel,
>  		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
>  		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
>  		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
> +	int i;
>  
> -	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> -	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> +	for (i = 0; i < 100; i++) {
> +		u32 data;
>  
> -	return read_poll_timeout(airoha_qdma_rr, val,
> -				 val & TRTCM_PARAM_RW_DONE_MASK,
> -				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
> -				 qdma, REG_TRTCM_CFG_PARAM(addr));
> +		airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
> +		wmb();
> +		airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
> +
> +		if (read_poll_timeout(airoha_qdma_rr, data,
> +				      data & TRTCM_PARAM_RW_DONE_MASK,
> +				      USEC_PER_MSEC, 10 * USEC_PER_MSEC,
> +				      true, qdma, REG_TRTCM_CFG_PARAM(addr)))
> +			return -ETIMEDOUT;

[Severity: High]
If a bus timeout causes the write phase's read_poll_timeout() in
airoha_qdma_set_trtcm_param() to fail, this immediately returns -ETIMEDOUT,
aborting the 100-iteration retry loop.

Doesn't this defeat the mitigation?

> +
> +		if (airoha_qdma_get_trtcm_param(qdma, channel, addr, param,
> +						mode, &data, NULL))
> +			continue;

[Severity: High]
If airoha_qdma_get_trtcm_param() times out during the verification phase, it
indicates the hardware hasn't finished the read command (DONE bit is still 0).

The continue statement then immediately starts the next iteration, writing new
commands to DATA_LOW and CFG_PARAM.

Can writing to command registers while the hardware state machine is actively
busy violate hardware protocols and lead to unrecoverable lockups?

> +
> +		if (data == val)
> +			return 0;

[Severity: High]
This isn't a bug introduced by this patch, but if the bus drops the command
write to REG_TRTCM_CFG_PARAM, the hardware never executes the command and the
TRTCM_PARAM_RW_DONE_MASK bit remains set from the previous operation.

Consequently, read_poll_timeout() returns an immediate false success.

If both the set and get command writes are dropped by the bus, the get
operation will read back the newly written DATA_LOW register value.

Will the data == val check evaluate to true and falsely report success without
the hardware ever processing the configuration?

> +	}
> +
> +	return -EBUSY;
>  }
>  

[ ... ]

>  static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int channel,
>  					u32 addr, enum trtcm_mode_type mode,
>  					bool enable, u32 enable_mask)
>  {
>  	u32 val;
>  
>  	if (airoha_qdma_get_trtcm_param(qdma, channel, addr, TRTCM_MISC_MODE,
>  					mode, &val, NULL))
>  		return -EINVAL;

[Severity: High]
Standalone calls to airoha_qdma_get_trtcm_param(), like this one in
airoha_qdma_set_trtcm_config(), lack a retry loop entirely.

Does this leave read-modify-write cycles fully vulnerable to the same bus
timeouts the patch attempts to mitigate?

[Severity: High]
This isn't a bug introduced by this patch, but the patch mitigates bus
timeouts in airoha_qdma_set_trtcm_param() while entirely missing
airoha_qdma_set_rl_param().

The latter performs the exact same write-and-poll sequence on identical QDMA
configuration registers:

drivers/net/ethernet/airoha/airoha_eth.c:airoha_qdma_set_rl_param() {
    ...
    return read_poll_timeout(..., val & RATE_LIMIT_PARAM_RW_DONE_MASK, ...);
}

If bus timeouts affect QDMA access broadly as stated in the commit message, are
the rate-limiting configuration paths randomly vulnerable to the same failures?

[Severity: High]
This isn't a bug introduced by this patch, but in airoha_tc_remove_htb_queue(),
hardware teardown incorrectly uses queue + 1 instead of queue:

drivers/net/ethernet/airoha/airoha_eth.c:airoha_tc_remove_htb_queue() {
    ...
    airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
    ...
}

Does this leave the removed queue's hardware limits permanently active
(resource leak) and inadvertently disable the rate limits for queue + 1,
corrupting the QoS state of another active channel?

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B86243969;
	Sun,  1 Mar 2026 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377825; cv=none; b=U+5lDOsseVmdQ8BWwRutjpuUVgif1Lnl9cJEpYdJ8u4LEPm12/N5jSfeby+Ow76Pumsscqv8us8yTUd8AJ3rjNoFf4KscqXvSpNhk/qFbCPmX7B0p5Q/CXj/44GgzLwZeRUJlAL3lpWdfKuiYJYM7r2PTthlfni0vwTwM9tziC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377825; c=relaxed/simple;
	bh=Kxz+c6xsoZc7JcZ4DqWUnLqDgizGrfu1X4ndZCweW94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLJhD7+FFm0U04LBvhVea/XS4d35kx26Q78xActYZIxqMJqAf/taBTxT8sk7Zu51sLyXPWPAdTajPh/tGTZPcX/P2kp48Sg/vmZBpaggyM33Uu91VZBHdWkY16rqK8VSW7DuOIPK1DcOb/ArYe4kK5w93fD5O3/GDduzk+GmoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knzhm1Hd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knzhm1Hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93022C116C6;
	Sun,  1 Mar 2026 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772377825;
	bh=Kxz+c6xsoZc7JcZ4DqWUnLqDgizGrfu1X4ndZCweW94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Knzhm1HdRIudIC5LMlGc3hobiNp/zms4Oa15Vb0t/rdZb9yNdSR0aTDdc6+4fHEzl
	 NgjxCleNqNTtikejihk1etUlKB3rlaIeSe+Pn6CqXuTPln8nJ3Z9ZvbpyEZy7ujYrb
	 q3c/RoXPZh+beS7rADNg4Oa5ip7laDc5WZtZlGgidDoYlHLO44Tn3VRdBMjxe+FhSv
	 syOtK6JQQjvJ/wfLNpWuKqNX4hbZujLjN9839MCctuQ+F7wdu8dzg2pP4KvUvctR4T
	 Up9LVz63s3d428cwBA7miqPEewhjek4/00bmNT456lBugJLsHU/rde05mxdMZv26PK
	 a3rh7tUi1dfPA==
From: Simon Horman <horms@kernel.org>
To: m-malladi@ti.com
Cc: Simon Horman <horms@kernel.org>,
	vladimir.oltean@nxp.com,
	haokexin@gmail.com,
	pabeni@redhat.com,
	rogerq@kernel.org,
	parvathi@couthit.com,
	edumazet@google.com,
	vigneshr@ti.com,
	basharath@couthit.com,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	danishanwar@ti.com,
	jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	srk@ti.com,
	kuba@kernel.org,
	afd@ti.com,
	vadim.fedorenko@linux.dev,
	davem@davemloft.net
Subject: Re: [net-next,v4,2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Sun,  1 Mar 2026 15:10:14 +0000
Message-ID: <20260301151014.460245-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224124803.3634808-3-m-malladi@ti.com>
References: <20260224124803.3634808-3-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

This commit adds driver support for viewing and changing the MAC Merge
sublayer parameters and dumping MAC Merge statistics via ethtool
operations.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23a..2176536a0989 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c

[ ... ]

> @@ -294,6 +293,100 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
>  	return 0;
>  }
>
> +static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth_qos_iet *iet = &emac->qos.iet;
> +
> +	if (emac->is_sr1)
> +		return -EOPNOTSUPP;
> +
> +	state->tx_enabled = iet->fpe_enabled;
> +	state->pmac_enabled = true;
> +	state->tx_min_frag_size = iet->tx_min_frag_size;
> +	/* 64Bytes is the minimum fragment size supported
> +	 * by the firmware. <64B leads to min frame errors
> +	 */
> +	state->rx_min_frag_size = 64;
> +	state->tx_active = iet->fpe_active;
> +	state->verify_enabled = iet->mac_verify_configure;
> +	state->verify_time = iet->verify_time_ms;
> +
> +	switch (iet->verify_status) {
> +	case ICSSG_IETFPE_STATE_DISABLED:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +		break;
> +	case ICSSG_IETFPE_STATE_SUCCEEDED:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
> +		break;
> +	case ICSSG_IETFPE_STATE_FAILED:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +		break;
> +	default:
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +		break;
> +	}

Does this switch statement handle all valid verify_status values?

The switch only explicitly handles ICSSG_IETFPE_STATE_DISABLED,
ICSSG_IETFPE_STATE_SUCCEEDED, and ICSSG_IETFPE_STATE_FAILED, falling
through to ETHTOOL_MM_VERIFY_STATUS_UNKNOWN for any other states.

Looking at the icssg_ietfpe_verify_states enum, there are also
ICSSG_IETFPE_STATE_INITIAL and ICSSG_IETFPE_STATE_VERIFYING states. The
ethtool UAPI defines ETHTOOL_MM_VERIFY_STATUS_INITIAL and
ETHTOOL_MM_VERIFY_STATUS_VERIFYING which directly correspond to these
states.

When the MAC Verify process is actively running, userspace will see
'unknown' instead of the more accurate 'verifying' status. This means
information about the ongoing state machine transition is lost.

Should the switch include explicit cases for ICSSG_IETFPE_STATE_INITIAL
and ICSSG_IETFPE_STATE_VERIFYING to provide more accurate status
reporting to userspace?

> +
> +	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
> +	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
> +	 */
> +	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
> +
> +	return 0;
> +}

[ ... ]

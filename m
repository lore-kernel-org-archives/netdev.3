Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EB30D406
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521418; cv=none; b=QD9HiNvsRDPLhhOnajUS7owk3XpxfnNGacsRo2mfYWnIKeMu/etU4EIXKMx4d9pz6HhKyRBmXOoBtByiaippyDzG2TrdM21x2XYGvKdTQDEGuEZeSiYgZeEMkjh+wyFhyyfHQID2hwE4w5Qon3aRkl6cuh3IroUYExEaibLlhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521418; c=relaxed/simple;
	bh=pbvyAJM+rCULUC9AV5t8u+o/XnjXzKnrgqOeNsVlCYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw6krvhhGBRw4bPIPALgOsHdIf6vnW6Mio1jpyRA+FxZrlkpg9SC3IZxlG6jLJGIY8octbZIwThrVyPhf1NK5RxZG4OLtDv9arQYKRD7k8MUihrnuD2UtE7+rl5BWyI7LEYOww6ANWar+mHmKUcnGNgFnaKVmZQLOyBIUBUBClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf0Y7f8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf0Y7f8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072261F000E9;
	Wed,  8 Jul 2026 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521417;
	bh=exnNu2I5aI5H24F1WtiUJW2O63f75UQrbEQvXGcBk5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bf0Y7f8LcK5njMeKKfJmq+s6ioYdgQLclm1vrgIVwKCC9dIAQv/DWPWNfgO/WLO6W
	 CumTgWja4ZYeg2DRgEINH10R5BEwyG2Qal4dSILLMNpud5LoQWUfgE4BWpQ8o1xSiR
	 fN4BPeU+dcpycQF3lCX+8o/Z1kJMATH5MdEAFzO866liybnj3pwTCewDNtoAFdl9Up
	 CjntL4QoqsBvjeHhGjOW3NP0vyJ7sUZD7OY/MSJFb+XUz97jpQHqDZn/w2A82szYRR
	 d90PaZhfzowdC3Ph4KHJrGpZyr8fWbnLCoviNrDL1MCRsVYdm7OyhMbpNj0jWHO7Pl
	 eNvTxgDHXsF2w==
From: Simon Horman <horms@kernel.org>
To: mheib@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH iwl-next v3 2/2] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Wed,  8 Jul 2026 15:36:51 +0100
Message-ID: <20260708143651.1491857-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701093830.948756-2-mheib@redhat.com>
References: <20260701093830.948756-2-mheib@redhat.com>
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
---
i40e: add devlink parameter for Flow Director ATR sample rate

This commit introduces a runtime devlink parameter to tune the Flow Director
ATR sample rate. This allows dynamic adjustments to the sampling interval
without rebuilding the driver, which can help reduce TCP packet reordering
on systems with high-rate workloads.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index 229179ccc1319..cf487efdd803d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
[ ... ]
> @@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>  	return 0;
>  }
>  
> +static int i40e_atr_sample_rate_set(struct devlink *devlink,
> +				    u32 id,
> +				    struct devlink_param_gset_ctx *ctx,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf = devlink_priv(devlink);
> +	u32 sample_rate = ctx->val.vu32;
> +
> +	pf->atr_sample_rate = sample_rate;

[Severity: Low]
Does modifying pf->atr_sample_rate concurrently with the Tx fast path
introduce a data race?

In the Tx fast path, i40e_atr() reads this value locklessly. If the devlink
callback sets this to 0 between the two reads in i40e_atr():

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
        if (!pf->atr_sample_rate)
                return;
        ...
        if (tx_ring->atr_count < pf->atr_sample_rate)
        ...
}

Could this race lead to a situation where the second check evaluates
tx_ring->atr_count against 0, unintentionally programming an extra Flow
Director filter?

While the functional impact might just be a single extra sampled packet,
should we use READ_ONCE() in the fast path and WRITE_ONCE() here to avoid
KCSAN data race warnings and ensure a consistent value is used throughout
the function?

> +	return 0;
> +}

[ ... ]

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2F78F26;
	Fri, 31 Jul 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461437; cv=none; b=aXYDx+y+1495LdqPgHCRrK/KJ5tmEMMWtm0lhXil5O4FOgyKJNhygv4XjkWfbImdJKx8KarMRNi83EIDWI8LjCnCkslzkCsZrCigMNLCVkhgUWJifas+kg9TDpnbmbQ4ay6TUqFV9Pp4YFQZ6qo1IcnGCfObv9E9SXr24w8683g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461437; c=relaxed/simple;
	bh=ZFqP/KfCXmtjDMwiRdgvlE7+AX2g+C7ZwlE+lyTxyIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In22HxBif6bwTvPObNYTcxHM0KBlmd3ngiL1CtPnvQsh7T9lRyCs11P2gkRjkKY9V4JpyQ4ojodv03UFTiZBnLA6NaGpnpV2R3nRbOH7gD/ouXESoSha3sCnz4O4NTVRA1MKWag6sGeRj32WbJiewBaJA5SMUBdvYyYzGb1oFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2jy/4lm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2jy/4lm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3745C1F000E9;
	Fri, 31 Jul 2026 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461433;
	bh=5UHDMfLJSsEF+ILuCqHZMAytaReLNBZgFZZwHcYKGH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2jy/4lmTBm5isfWHryZlsV2mlUm4I1IQs/fSe1EJ+gmU+UqKJftdn8fCjIYuVBCy
	 aUMJcTFM+mL7ry29hNs8TnoxtIEA/DJcFUIaqmGacc5lNM1eFxLoYGlaxOue/jODec
	 v/TX3wVzhxiwi7xGBUD5gGgLoW5u7UsxBSRHw3c/TLMcnDYxZAK9UPmP67MOOyqngf
	 ANxjkN72lpi7zcm3rYYU0zcsgKBJXlodjh57FX/LocYVv65QNYtPrgF98o87RCjYI1
	 H4WLqwNRpRFdXKi46EKlfr5mwPP7SRg+jmeEvIY+SKrX4jW3NFAFZZrNFVV1jXQCZu
	 aYLDwtymJ4N8A==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v22 net-next 07/12] net/nebula-matrix: add chip-wide hardware init/deinit implementation
Date: Thu, 30 Jul 2026 18:30:32 -0700
Message-ID: <20260731013032.745167-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723040110.91410-8-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-8-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [7]: [PATCH v22 net-next 07/12] net/nebula-matrix: add chip-wide hardware init/deinit implementation ---
commit c620485c32e37b926b2895bd18463f304a29e084
Author: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This commit adds Leonis chip-wide hardware initialization and
deinitialization logic to setup the full datapath pipeline.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 1c136b9e30b2a..22690cb9cc32b 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> +static int nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
> +{
> +	union nbl_shaping_dvn_dport_u dvn_dport = { 0 };
> +	union nbl_shaping_dport_u dport = { 0 };

[ ... ]

> +	/* 2. write config words (valid=0, safe) */
> +	dport.info.low = FIELD_PREP(DPORT_CIR_MASK, rate) |
> +			 FIELD_PREP(DPORT_PIR_MASK, rate) |
> +			 FIELD_PREP(DPORT_DEPTH_MASK, depth) |
> +			 FIELD_PREP(DPORT_CBS_MASK_LOW, depth & 0x3F);
> +	dport.info.high = FIELD_PREP(DPORT_CBS_MASK_HIGH, depth >> 6) |
> +			  FIELD_PREP(DPORT_PBS_MASK, depth);

[ ... ]

> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
> +		       sizeof(dport));

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 1d6d614be7d69..8e59b9d2ab3b0 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h

[ ... ]

> +union nbl_shaping_dport_u {
> +	struct nbl_shaping_dport {
> +		u64 low;
> +		u64 high;
> +	} info;
> +	u32 data[NBL_SHAPING_DPORT_DWLEN];
> +};

[Severity: High]
Will this union alias cause corrupted hardware writes on big-endian
architectures?

When fields are populated using native u64 in nbl_shaping_eth_init(), for
example:

        dport.info.low = FIELD_PREP(DPORT_CIR_MASK, rate) | ...

And then written via the u32 array alias:

        nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
                       sizeof(dport));

On big-endian systems, the upper 32 bits of the 64-bit integer will map to
data[0] instead of the lower 32 bits. Does this result in malformed hardware
configuration for traffic shaping?

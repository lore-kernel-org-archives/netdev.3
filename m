Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BB1EA84
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893814; cv=none; b=PRNE6zHsAlhDN5Nahi1OPaEd1XY8Gqc0JQkiR5lcHIoE29Fo4m9BnO9MB1LcTl+rhfp4qapwDdCz+XbydelyEQoPy0/rLhlC4stS0B/FgWn6HrHz5I0L/Pmlb2MM2+Q1QJzQRkwDgBB0CqOPHIdlRsVK7x2DjxLFNFlHsz1E5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893814; c=relaxed/simple;
	bh=y9Tl0AJb8n5ChjcVkn3rnrWN12Ru8Edez2nl7eEJK9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvLG4ItX00+eFqw6vAg918iHdBa+yyYVqvyPpdUX6zs9UMAhXL0QYke3dBC3mBwkxE4EABehdNnLdTXVp8gOHTHzKHV/5G+4aUTeeZSORGfEA0w7wjplWjl69jZOnhxiYbhGWYw6Z3C/XUNQ1rEFFYAgfmJOa/Ycw1X1v6YDk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrA48CNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrA48CNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81ADC2BCB0;
	Sat, 16 May 2026 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778893813;
	bh=y9Tl0AJb8n5ChjcVkn3rnrWN12Ru8Edez2nl7eEJK9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrA48CNE+wpwH8AAhAXmigHi2o8m+xvr1tX9ZKX6D9xCIWsnpQTDizQ/yLRC9wmyW
	 zC34AYqNgsVb8rUkdFwciEtRsCHkcfWMOpgKKCgb9UBxhnq428ZZeTDs42SFyTpXtr
	 NtNTrFNfGG3HwpCd78vj+uGH5nqIZrSqIj/hQd9qABb10xKE1Kgq+rKlCEpwwGkicy
	 nVYg0VJXuPr0Wv8xRsAXsygnPlOGslHjP37RaAlCjyPSeI2ZbuQ5zleQwTXcGjy//O
	 C6HvSkYDklcBmDa4jkp4z/VaYmu+hh4y4v+JgFi+ytrz2HUMKwBLaiR2TMcS845bnH
	 KKwt8uEaScDPg==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 03/15] bnxt_en: Set default MPC ring count
Date: Fri, 15 May 2026 18:10:11 -0700
Message-ID: <20260516011011.1857487-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512212105.3488258-4-michael.chan@broadcom.com>
References: <20260512212105.3488258-4-michael.chan@broadcom.com>
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
bnxt_en: Set default MPC ring count

This patch adds bnxt_set_dflt_mpc_rings() to compute a default number of
MPC channels when the firmware supports MPC and CONFIG_BNXT_TLS is set,
and bnxt_trim_mpc_rings() to cap the per-type counts to the current
tx_nr_rings_per_tc.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> index 9859a5f86268..cce73d56e46e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
> @@ -45,3 +46,64 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
>  		return 0;
>  	return mpc->mpc_cp_rings;
>  }
> +
> +void bnxt_trim_mpc_rings(struct bnxt *bp)
> +{
> +	struct bnxt_mpc_info *mpc = bp->mpc_info;
> +	int max = bp->tx_nr_rings_per_tc;
> +	u8 max_cp = 0;
> +	int i;
> +
> +	if (!mpc)
> +		return;
> +
> +	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
> +		mpc->mpc_ring_count[i] = min_t(u8, mpc->mpc_ring_count[i], max);

[Medium]
Can the u8 cast in this min_t() truncate the cap?  bp->tx_nr_rings_per_tc
is an int and max is declared as int here, but min_t(u8, ...) casts both
operands to u8 before comparing.

For values of bp->tx_nr_rings_per_tc that are a multiple of 256, the
truncated max becomes 0 and every mpc_ring_count[i] gets zeroed, which
also makes mpc_cp_rings 0 and disables MPC even though plenty of TX rings
are available.  For values in the [257..263] range the truncated max is
[1..7], which would cap the count below BNXT_MAX_MPC (8).  The same
pattern repeats every 256.

Modern P5/P7 deployments with high CPU counts and large user-selected TX
channel counts via ethtool -L can land in those ranges.

Would using min_t(int, ...) be more appropriate here, given the result is
bounded by BNXT_MAX_MPC == 8 and therefore still fits in u8?

> +		max_cp = max(max_cp, mpc->mpc_ring_count[i]);
> +	}
> +	mpc->mpc_cp_rings = max_cp;
> +}
> +

[ ... ]
-- 
pw-bot: cr

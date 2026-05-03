Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A37242D67;
	Sun,  3 May 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777773999; cv=none; b=GRxzZwUmtu1d32IR/qrA+N6ZvHUAvDAmUiBQ5qIzXd9T9ZdTfohGzhgxNcxfx66ptxN/afWzZNuNEskP7Z87g1q8WNP2S89oIsXlcVkIP4fMa5o4vrd0M11UOcYy5ptR12HlnWMIZR/i/ZEhb6aMHeo+XtIFDkZOBada+ocHdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777773999; c=relaxed/simple;
	bh=bfjBLVh2vMX+BVQ+AHbzzJc6KHbr7hv29LepOAC3ywk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf3so+F9C24M0cbNJeoXWn6EmMcY4uE5RKhLRz0/v7+vf5CLllb7OeKXQMNJcSj6JDAKvG3ltMLk9p70jpSkQ5VnmO53YnRLvKFM0rH8VoE6ZPlgmN3NGr57zkoDS+7GpPKlYr7amfWcpJONK+I01e4zkq+O/D659/msyeHHZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qdr0qjUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qdr0qjUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853F5C19425;
	Sun,  3 May 2026 02:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777773998;
	bh=bfjBLVh2vMX+BVQ+AHbzzJc6KHbr7hv29LepOAC3ywk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qdr0qjUgWinggThnh6Pouzc53Z63huXMs6lxGV5klczsWSdCdkRYWcgHdRSAet/Ke
	 rFhFedPTgLLiwrJ8R0HGwgyji+lwGsRAQLzNSF+Qqm1Nl0zQPSwzSBqFVbnSkks7bS
	 Cpmf3HjwX71M73iLYNyu+wYRhLpTmoqjRQBK/dzj2kni85VenhH2DHdu9ivllrppBZ
	 XIkc60LXJKLUs45L5zc5agPn2n/gjuiS1UyUdWj4k6pqHTlzthE0VdDhP2td4eEtLB
	 M+tqbOP4OpsYGoRSrdld1BPSZPM3Bqsb+3IX+4vAilCKHy3wEoerZB0CqEkz8KLDG/
	 CJjnq0R7oZAlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jacob.e.keller@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	jedrzej.jagielski@intel.com,
	aleksandr.loktionov@intel.com,
	grzegorz.nitka@intel.com,
	ivecera@redhat.com,
	arkadiusz.kubalewski@intel.com,
	anthony.l.nguyen@intel.com,
	stefan.wegrzyn@intel.com,
	piotr.kwapulinski@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	sunithax.d.mekala@intel.com
Subject: Re: [PATCH net-next 07/15] ixgbe: E610: add ACI dynamic debug
Date: Sat,  2 May 2026 19:06:36 -0700
Message-ID: <20260503020636.4114758-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-jk-iwl-net-next-2026-04-30-v1-7-6f27ae1cd073@intel.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-7-6f27ae1cd073@intel.com>
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
ixgbe: E610: add ACI dynamic debug

This commit enables dynamic debugging of the Admin Command Interface (ACI)
for the e610 adapter, allowing ACI commands and descriptor details to be
printed into the kernel log.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

[ ... ]

> @@ -106,8 +185,12 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  		if (desc->flags & cpu_to_le16(LIBIE_AQ_FLAG_RD)) {
>  			for (i = 0; i < buf_size / 4; i++)
>  				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), ((u32 *)buf)[i]);
> -			if (buf_tail_size)
> +			ixgbe_aci_debug(hw, desc, buf, buf_size);
> +			if (buf_tail_size) {
>  				IXGBE_WRITE_REG(hw, IXGBE_PF_HIBA(i), buf_tail);
> +				ixgbe_aci_debug(hw, desc, &buf_tail,
> +						buf_tail_size);
> +			}
>  		}
>  	}

Does this result in redundant output being printed to the kernel log?

When buf_tail_size is non-zero, ixgbe_aci_debug() is called twice: once for
the full buffer, and a second time for just the tail. Since ixgbe_aci_debug()
prints the full CQ CMD descriptor details each time, this appears to print the
descriptor headers twice and fragment the buffer output.

[ ... ]

> @@ -183,10 +278,13 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  	if (valid_buf) {
>  		for (i = 0; i < buf_size / 4; i++)
>  			((u32 *)buf)[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
> +		ixgbe_aci_debug(hw, raw_desc, buf, buf_size);
>  		if (buf_tail_size) {
>  			buf_tail = IXGBE_READ_REG(hw, IXGBE_PF_HIBA(i));
>  			memcpy(buf + buf_size - buf_tail_size, &buf_tail,
>  			       buf_tail_size);
> +			ixgbe_aci_debug(hw, raw_desc, &buf_tail,
> +					buf_tail_size);
>  		}
>  	}

Can this read uninitialized memory from the buffer?

At the point ixgbe_aci_debug(..., buf, buf_size) is called, the loop has only
populated the 4-byte aligned chunks of the buffer. The trailing bytes at the
end of the buffer are not populated until the memcpy() occurs later in the
block. Because ixgbe_aci_debug() consumes buf_size bytes, it looks like it
will read and log uninitialized trailing memory (potentially from the kernel
stack).

Also, similar to the transmit path, this calls ixgbe_aci_debug() a second
time on &buf_tail, which will print the descriptor headers again.

Could we move a single ixgbe_aci_debug(..., buf, buf_size) call to the end of
the block, after the entire buffer including the tail has been fully written?

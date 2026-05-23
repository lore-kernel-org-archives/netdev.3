Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06A1624C5;
	Sat, 23 May 2026 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499543; cv=none; b=hmfhrD5myLJqrX7eqPZqom+dvND9x5pluwGobIOxnH0e9fmZkUesgRUyKcs0oVg7sBEDk5gdMBJAAIT1LTj+FG/5aKeRnWPRlF7bCphfxOrU8PXVA9EcOEZBnlZ4oikjcvy+iA/vOmMKRrWXPC0kXNme1keiHgtFPwCmPNWiIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499543; c=relaxed/simple;
	bh=MLMhYJplsTO8o5Wto2Tr8QtmP41JShX3JbBIjK22gNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkqHdza84KDDkXLNQsfwolYztIQViJ6RtoN/a+fv9ntQwiKpQxaycc5VawqOubRd1I+2LKhdBf51KKo5MwtOLS0UvksFYHiMG6uzhFzBiLRdKIFJut5zW2o+dPPbtV9ZjOetXy4HAx4d1GXUNh9VyPhHMZ4wFisz9OEUl5U0LoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+tYEeYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+tYEeYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E744D1F000E9;
	Sat, 23 May 2026 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779499542;
	bh=A03yyyfJ9j/jKBpOX0Y4SEk0RJCh/ieN0kIHXHT3N5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+tYEeYfmC2FYfk12BabIsLLKG29AUaY7GtLPP8jPpildL61DsFiSz7peKPhuNJUU
	 BvZGZc+hSAKL+fytVv+quNAMpZhf7ML+1culRAZR3+zedjThVGqoH6UGSer6imjvtJ
	 ZkUAKY2HCcT5oq6OgvPw+CjCbzXxAZEi/0zM7No8p8HaVu+T3eCCtOQLv3vWIN4HGW
	 emt3v8AAuUc1bGW0D1XCXYKnV8pdPe8GL4ZjQBfEoW4wbqlbIzaDXdXgn0cVOjPZa3
	 K92j4CQ2r3NoM5sF9Ss5nJUCV9nxEH2AZiaIcCb00QXV8xa0G3w5Qs3wDoQB4u5QCl
	 irL6p7SD3m3Xg==
From: Jakub Kicinski <kuba@kernel.org>
To: sukhdeeps@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3 11/12] net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
Date: Fri, 22 May 2026 18:25:08 -0700
Message-ID: <20260523012507.1823651-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520141046.2151-12-sukhdeeps@marvell.com>
References: <20260520141046.2151-12-sukhdeeps@marvell.com>
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
net: atlantic: add AQC113 TX timestamp polling and PTP TX classification

This commit adds PTP TX classification for IPv4 and IPv6 packets. It also
introduces a polling mechanism for hardware TX timestamps in the driver's
ring cleanup path.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> index 4ef4fe64b8ac1..1da14786fe5cc 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
[ ... ]
> @@ -68,14 +70,6 @@ int aq_ndev_open(struct net_device *ndev)
>  	if (err < 0)
>  		goto err_exit;
>  
> -	err = aq_reapply_rxnfc_all_rules(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
> -	err = aq_filters_vlans_update(aq_nic);
> -	if (err < 0)
> -		goto err_exit;

[Severity: High]
The commit message mentions removing a stale PTP call, but doesn't this
remove the restoration of RX flow rules and VLAN filters when the device is
brought up? It doesn't look like these were moved to aq_nic_start().

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd8..87d680590ef2f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
[ ... ]
> @@ -311,6 +311,26 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  		if (likely(!buff->is_eop))
>  			goto out;
>  
> +		if (unlikely(buff->request_ts) &&
> +		    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
> +			u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
> +
> +			if (!ts) {
> +				if (time_after(jiffies,
> +					       self->ptp_ts_deadline)) {

[Severity: High]
Where is self->ptp_ts_deadline initialized?

If it is never initialized and defaults to 0, will this condition always
evaluate to true on the very first poll since jiffies is typically greater
than 0, causing all PTP packets to immediately time out and be dropped?

> +					/* Timeout: free skb, unblock ring */
> +					buff->request_ts = 0;
> +					dev_kfree_skb_any(buff->skb);
> +					buff->skb = NULL;

[Severity: High]
If a timeout occurs, buff->skb is freed and set to NULL, but there is no
break or continue here. Doesn't execution then fall through to calling
aq_ptp_tx_hwtstamp() while the SKB is already freed, leading to a
use-after-free when the PTP logic attempts to access the SKB to report
the timeout?

Additionally, since buff->skb is now NULL, won't this skip the subsequent
transmission statistics update block?

> +				} else {
> +					buff->is_mapped = 0;
> +					buff->pa = 0U;
> +					break;
> +				}
> +			}
> +
> +			aq_ptp_tx_hwtstamp(self->aq_nic, ts);
> +		}

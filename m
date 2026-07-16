Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF840A946
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198556; cv=none; b=quzUIHLPap6bvFYxLPs7SUL9btiuiEZ8F+zqXLLVo4g6oUwG76VhwmDXrkfdKPAce4GecC0n+1o60vzi0kejKb3yPV8nNrylC6sXX8TkSI64QCTlYu/fl78UK2k+zSYShBYM23ZsfdXH+yLPi3pWxT5wt9WuxkkcUKO4boMKaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198556; c=relaxed/simple;
	bh=dRJpu6sdg8VoO6yNOjcmJOQs3ivR9uHZpcMuHs1Dk5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezDki/RXgIVY8LYkLEiGzUM9N2w30cZG8BnRAbTGTSlmmn9UtqnuSjimp+ss/b95K2fa7iax203B7ewqODIMZLimsG2DKOKXVbzelaVNoqLLLvW2mvHYJR/hqTOCclNeRtVOjm37YL13TuJ9y3dgLp8izZgqShcz0/7T+7FuDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obGFhfJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obGFhfJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30771F000E9;
	Thu, 16 Jul 2026 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784198554;
	bh=BLp9vfm76Yd/0vFs3+TtMxXwa8V/xVY/MTryj+uNLVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=obGFhfJ9oWEVKxGxNts3U7Gft+Tp1IFs+rEf07M7CXM2C9S96HHPGe7AnZHX0UDpP
	 dA6oFNUyRM990GhyePFibuRnjAifAtBHEAWpk/Vyy6itr87p45w8MSasYRaKAoBQ0m
	 +cajaUqQcexF47r7BZkUlmPah466HiXHyZoacsuhXdnXjAHKCcpdTwsA63C9BFUcNZ
	 T9GJAGiq7eADOWv0xFqoMoeM/p+YffERastf0h2AACwSHmimjoWWVbJ8DxDMljcMSc
	 wOalf0WpQdumBVHXIPZk/FY0NSnbWKRrB36Dj1T8m17/wty0gXbCOySGqqKqvw29f7
	 0MKnOwRUbwC5A==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v1] i40e: fix set_ringparam error path freeing live Tx rings
Date: Thu, 16 Jul 2026 11:42:17 +0100
Message-ID: <20260716104217.268158-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710065530.4138116-1-aleksandr.loktionov@intel.com>
References: <20260710065530.4138116-1-aleksandr.loktionov@intel.com>
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
--- Patch [1]: [PATCH iwl-net v1] i40e: fix set_ringparam error path freeing live Tx rings ---
commit 7042e7b9f58a75bdb26437aed842a7b6780df035
Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

i40e: fix set_ringparam error path freeing live Tx rings

This commit fixes an issue in the i40e_set_ringparam() error path where it
mistakenly frees live, NAPI-active TX rings instead of the temporary rings
allocated for a configuration change. It does this by passing the address of
the temporary rings instead of the live ring pointer.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc745..6d2b076049f7e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2249,7 +2249,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
>  	if (tx_rings) {
>  		for (i = 0; i < tx_alloc_queue_pairs; i++) {
>  			if (i40e_active_tx_ring_index(vsi, i))
> -				i40e_free_tx_resources(vsi->tx_rings[i]);
> +				i40e_free_tx_resources(&tx_rings[i]);

[Severity: High]
This is a pre-existing issue, but does calling i40e_free_tx_resources() on
the cloned &tx_rings[i] inadvertently reset the Byte Queue Limits (BQL)
state on the live TX queues?

Because the temporary rings are shallow copies of the live rings, they
inherit the netdev and queue_index fields. When i40e_free_tx_resources()
cleans up the temporary rings, it calls i40e_clean_tx_ring():

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_clean_tx_ring() {
    ...
    netdev_tx_reset_queue(txring_txq(tx_ring));
    ...
}

Since i40e_down() has not yet been called on this error path, the live
queue is still actively transmitting. Locklessly resetting BQL here
zeroes num_queued. When the hardware subsequently completes the
already-queued packets, won't dql_completed() underflow and trigger
a BUG_ON()?

The same issue also seems to be present in the earlier error path if
i40e_setup_tx_descriptors() fails.

>  		}
>  		kfree(tx_rings);
>  		tx_rings = NULL;

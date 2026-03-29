Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DB184540;
	Sun, 29 Mar 2026 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774822818; cv=none; b=V5hFGFFcyL7H3oIPMYDH7OHbsf/Q4JkRRZYZdJKQjpBYU2mtJQwLz0VdS902amswGavGyeI7WJVeXqEisyKAsWv+Nfto9+iF+1ob77RlpSedniicWWBSY9VGgdruhrrb68NVixhtdJ0TWMgrC1CG/ueafw9j8q/4ajoGa9meLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774822818; c=relaxed/simple;
	bh=84/i9WgIhxZCMY0zYkj3wuR3r29mRXZuHkX/lYaK7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpPiujzHoNtvUs0IuYKwTxJs5rZXdaMBA+4I5q+w9WBogrUPpeP55cnNyPNI0UHP2LBYRsKIasnnTLYl+bf3nlnyp88Q8Nnbq0rFIzlXrsk20xyOMQ85HrN0cYiz5m3IjIe3F815FWfOe/AuxNLJ9nQMl+LrpaLU31OY5dy+/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiZqiDrJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiZqiDrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB13C116C6;
	Sun, 29 Mar 2026 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774822817;
	bh=84/i9WgIhxZCMY0zYkj3wuR3r29mRXZuHkX/lYaK7tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KiZqiDrJxxZmh8ib6lno5bn9wGfCECkmsfpq4L3Cx8HC1qnJ0CKvwnqKGqqZAffA/
	 bKom0h9AAsYwX0pZBQfkRoNhsf9XqyMeedc7SCXZhavvfl0gCcQ1LUE8IDzHYBvMb2
	 HUYmP6/jcamESIDku/ynsr+GHW/nI88L9azk/6NyvAf2Er3Mxq8DTxYjw0fUMbn4Wu
	 Rq6xUVDaa9DLqn2Lgu+21M3dEKDYRu1666W8LF8VkLjRgJ4rLqzFB3g3uRE0Fx+W5i
	 mRyR9IUV4kltZyvGAmDkooqikqrW08OX3hrZz0wxYzo8vrYxei7ogsY12IuOQd6yA6
	 D2pVKwHWVR60w==
Date: Sun, 29 Mar 2026 15:20:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 08/12] net: bnxt: Implement software USO
Message-ID: <20260329152016.27646fab@kernel.org>
In-Reply-To: <20260326235238.2940471-9-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
	<20260326235238.2940471-9-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 16:52:27 -0700 Joe Damato wrote:
> +	/* Upper bound on the number of descriptors needed.
> +	 *
> +	 * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
> +	 * at most num_segs + nr_frags (each frag boundary crossing adds at
> +	 * most 1 extra BD).
> +	 */
> +	bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
> +
> +	if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
> +		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> +				   bp->tx_wake_thresh);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	slots = BNXT_SW_USO_MAX_SEGS - (txr->tx_inline_prod - txr->tx_inline_cons);
> +
> +	if (unlikely(slots < num_segs)) {
> +		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),

This looks sus, try_stop() will evaluate the bnxt_tx_avail(bp, txr)
and leave the ring running.

> +				   bp->tx_wake_thresh);

Is tx_wake_thresh larger than the max USO even for smallest ring size?

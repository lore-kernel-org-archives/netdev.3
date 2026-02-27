Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0923313E;
	Fri, 27 Feb 2026 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155328; cv=none; b=XVNPfD/Vq1g2YC3aeuXA1djV1wElD2twePqGLVrWXX0i99J7Y1n8mIdCEtNvwbW1QTgpoefmVV/RdCCoFHcuDlPzAlo5Zq6tAYcHF2tgApWrzUoFSY/cxNht/n0E6xchd8Nsl2bAa3ymFr+lKam3U3GTCTwryyWdy7c5cxBVOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155328; c=relaxed/simple;
	bh=G4uchlvH63oz+1IjKzG/Jr/BaWL2cOYw9voZpGzc5tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eowB4ofl0fMYSOZ9e7mFIVmGJ8w6N+dMhJr4Lkh2uSn05k8EsAcjl/t6Arx28vOLV4bwgAbW7jxbE1GXoQ7lCWpr3czYEGnwvzGWhnj9Y7w1qd+wnBlzKz5kjxMAmILExwfWoq9g8jQNSe+qkoerRHXWf5JzKDWBX/jnrwPE98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5OrxpEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5OrxpEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89F3C116C6;
	Fri, 27 Feb 2026 01:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772155328;
	bh=G4uchlvH63oz+1IjKzG/Jr/BaWL2cOYw9voZpGzc5tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I5OrxpEH1wiwILSs420ljzmcg6NbjRwsycEk4fRT2Xj10Lvcr542HfmrWulkOLhie
	 MJuZ7+OPnqRobl3eQn1zIxjriD2PMDAp93wgStXlTClHqXM6uU+/hkuONAUK10sP6i
	 WSyEePW7kjuIPb8QGDZnRrcAJk7bjDmXOHpaorUNrQF1SgnAy/AQj32usPWKw0qbq4
	 dWaE4RdHboII2rW1wOn9AQ0yZAzqyx0t0G8OQtsCd5oPeHaxW0BctLEvchsN5IxGAp
	 9vS+ZLH1Z/toc1aPNSyNQMveBePqiQ/lODa7DbGDr4x4L/ggUCnxddjIv3DlaFdhd+
	 Ss+cqZ2xX5ksQ==
Date: Thu, 26 Feb 2026 17:22:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v2 8/8] bng_en: implement ndo_get_stats64
Message-ID: <20260226172207.6810e8ce@kernel.org>
In-Reply-To: <20260226182133.1566714-9-bhargava.marreddy@broadcom.com>
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
	<20260226182133.1566714-9-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 23:51:33 +0530 Bhargava Marreddy wrote:
> +	set_bit(BNGE_STATE_READ_STATS, &bn->state);
> +	/* Make sure bnge_close_core() sees that we are reading stats before
> +	 * we check the BNGE_STATE_OPEN flag.
> +	 */
> +	smp_mb__after_atomic();
> +	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
> +		clear_bit(BNGE_STATE_READ_STATS, &bn->state);
> +		*stats = bn->net_stats_prev;
> +		return;
> +	}

There can be multiple concurrent readers. Two enter, first one gets
stalled second one exits clearing the bit, close frees the memory,
second reader proceeds to hit the NULL pointers.

Again, please don't try to invent synchronization primitives.
You can probably use RCU here.
-- 
pw-bot: cr

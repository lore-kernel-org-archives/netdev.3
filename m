Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE14A4EFE;
	Tue, 15 Sep 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515610; cv=none; b=AVkSeJwxY++jxu91NyES2UlDJ9nxhtNjw+Lh5W4IfcX2q0wWr8fSWD8eNrGkucLToGVfKRWs42zXfHEkKMW4vbzaty5pZQzr67V7FdvG2/IIjSaYZ4LQd9gZm8OWbqe7ObmpOvv3JfSgYuVDr1d5itEB+oeP7+xL7mFHIrRIltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515610; c=relaxed/simple;
	bh=v5ftwrpbsDLFOCz7/Lj0IJU4Jq4TbiN615j/aMPTfMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsZsN00dIYy1LQIJzcQuHwtELIwzM3Zfo0WmFlqzsmFU9/Zg5TJN+qpyLZqeJJosl+OpfOmxALNVMAQQRUXhEGrXvoNKq9NJhBQlYGCURg0j2sh4g6mmms+gabq5d1XJLgBvh4jebKzROdscqzKt0GG+8UpBjBJdIBikkftG2H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O18Fnit9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O18Fnit9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A271F000FF;
	Tue, 15 Sep 2026 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515609;
	bh=svathgr2/JukVqx6BizuTYGJ1tslyMnbQ+afvAa97f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O18Fnit9C92yUJAzcd5e2Pti2uAOMIpdFNmEdJ5PSN/N/RfjOI5Ss1XMAmAs4jRXp
	 gm3OTgr69BM2/BVAVXmzTAoHUFUr5yVE1XQvqc0r560HqSpMPMVQ6HNvlbdy8dhOzk
	 4u71zrOr0WCo7WPRS2NikpIzOfrCyWLpC7yuUf8UBpqQB8uE/PkvKrN63rcgP4eQNO
	 7yrOUgrQlvLRsz6J3gcZZxCUSblIQX1rX6yvFdpeVOVDenMSrY0SnXzd2ae3DnvBu5
	 C8DK+QGb+rRY4mMJZXB2aHMIhObUaemABSIFUQhmvcxSYqYyQ3UV7Xp8xVCvBmjisJ
	 dsj+Z9ANjIxCA==
Date: Tue, 15 Sep 2026 16:40:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kris Pan <kris.pan@intel.com>
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, atomasov@redhat.com, oliver.sang@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: iterate online nodes in skb_defer_free_flush()
Message-ID: <20260915164008.4f65ddc4@kernel.org>
In-Reply-To: <20260911023804.3503989-1-kris.pan@intel.com>
References: <20260911020438.3502801-1-kris.pan@intel.com>
	<20260911023804.3503989-1-kris.pan@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 10:38:04 +0800 Kris Pan wrote:
> skb_attempt_defer_free() only queues skbs on the current CPU's node
> (numa_node_id() of a running CPU), which is always online, so the
> flush loop never needs to visit nodes that are merely possible.
> 
> for_each_node() walks node_possible_map.  On machines where the
> possible map is much larger than the online map -- e.g. a POWER10
> LPAR with 32 possible but 1 online node -- the flush loop touches 31
> cold, always-empty per-node lists on every softirq pass, showing up
> as skb_defer_free_flush() and _find_next_bit() overhead.
> 
> Use for_each_online_node() to iterate only node_online_map.
> 
> Loopback UDP throughput in a QEMU guest with 32 possible / 1 online
> nodes (bench_udp, 8 senders, 6 interleaved runs) improves by ~5%.

Clashiko confirms this is racy:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260911023804.3503989-1-kris.pan@intel.com
-- 
pw-bot: cr

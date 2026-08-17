Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEC3EDAB3;
	Mon, 17 Aug 2026 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009018; cv=none; b=lJmIkJKfh7iIAUpsflJhkyvn9UbquGjQD6sdoyOqU5ct35iXyLljjHNC4y+yalmfFHmXLf0Rtq0tMuubMQTRzcxEVBcXkCTgHq1t45QwOrfQZlYmtXByYq5VHO61hoPq6+lxCkxIV0TZYSPn2Mlk8sMR/n72lyTdvokrxfU9SFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009018; c=relaxed/simple;
	bh=xShEjaST7GAy5DQitAHLRRVJX36S+bJoi8mGo8pG5bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8v5RO0cp5k1SX3YtcgNtDWLOzP0mhSIZakeRyA0FlWFO+zRjUg5MzO/1uTs5ZHCLyylkF2CzaIgFQgFrg/3senGKR0QPPhsjwc2ToMFZfPkE+fXD6iK6+l3VJtOsu1FAoiSIrYfy6mctZgGKCjtkBTsgLxS9NtA9kT7ZTlf8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuBkldpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuBkldpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C1C1F000E9;
	Mon, 17 Aug 2026 23:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009016;
	bh=kphamaItq9JdCh62h+7P9z3oBolHXlZUD8JYstsRNpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WuBkldpIwVviHfvUBswFJj41l+Wt08CNpbcPGuK/km2DdvuRT991RdZdNkP7dw2qg
	 ANSsEt2znDn5NVqE/3gxemijIkYBS7Ins1sTXRXig8Zo2rYtY+k/ozhYvlSNCpDMoN
	 1LftToesBXuvnzH4GRA6Wi6GWrdUhWaZPQMbfFbB00+TLupwX3lqyd2h9PYJT9V+4Y
	 NOu5TPPO+opta2R0+Cz9xQcx7LduGc/nMza78r7MQvCpq6pm3fIBnXu0Yah8GiRx2p
	 YRnd3Nm1iQIxsXlT8cqFezPrBSjt3RzHcSlLFrZMaqYx9Aq3/sDQoV7wQGIcfa90dd
	 o+5ieeYj0jo/g==
Date: Mon, 17 Aug 2026 16:23:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Teng Peisen <tengpeisen@huawei.com>, Wu Di <wudi234@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Larysa
 Zaremba <larysa.zaremba@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Chen Anwen <chenanwen@huawei.com>, He Wei
 <august.hewei@huawei.com>, Zhang Min <zhangmin548@huawei.com>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
 <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>
Subject: Re: [PATCH net v04] hinic3: Fix skb linearization mismatch and drop
 skb when skb_checksum_help() failed
Message-ID: <20260817162335.74d22485@kernel.org>
In-Reply-To: <78d8c61cab588240948eaddcb437d59add9f77ae.1786448013.git.tengpeisen@huawei.com>
References: <78d8c61cab588240948eaddcb437d59add9f77ae.1786448013.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 19:43:59 +0800 Fan Gong wrote:
> Previously, hinic3_send_one_skb() cached the skb fragment count before
> calling hinic3_tx_offload(). If hinic3_tx_csum() falls back to
> skb_checksum_help() for unsupported tunnel packets, the skb may be
> linearized. Continuing to build the TX descriptor with the stale
> fragment count leads to a descriptor mismatch, which can trigger
> out-of-bounds DMA reads or IOMMU faults.

Applied, thanks!
-- 
pw-bot: accept

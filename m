Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966964;
	b=Ve0RAdgmcF1SJDXYytrV7RmF2JCCzFzQkCjtRXSk6VeWEIyQjSC4Z5AmfkG3pC/bq3xd
	 OAdwBxx+UdBkOQ9X3V44vV5JbU0xXh4RWMWrCQvWA/1IGzcj9Sjwqtn2Bn7mqe5ugFN+Y
	 q39A4chbTa36r1MZ93dJUvQkhpWBxfTs5Rv3ufvKlcqI3y3PCPnIB4P+5uaHX/y/dNoQ4
	 2wVZO8BSU9u8Z8iH/vMzMmDJbZDTShl5yZIQmHXywMIgcIo8ovKtem8HWA2ClCewRXoUK
	 bKM+D1h7p5BEYTgx67PzKeaCj2v6IqMsk9Q4X50rWWTlI6aQemn5ks/tZ3KI5j23cBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966964;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rIJTGu4lQFEUcai9lQo31jwOxKOMF2xzMy8/uijRKkI=;
	b=iYA5B8fNbKkQ5crkuN9IMcTwcDUf89D6gnujFb1wpQYjHLjKmpjFxonQShx0mlBEYCbI
	 MH0B7hHPw82BxI2n8o1Cu0iHsx/mjtFnUVO18HFNv8OX/CvmYzDJ/1eYXyCRL9G0gCAwQ
	 YOE/xQjxiSCQ+/eBgFD8Kh15h//LM1Sz3QkvC963vnln7Tnjcd0SErXm3sbs4mHK2Blfs
	 fw+7e4lbz2M0HICfg3dPlqP6Nu5cSaN+/e82BIQdlpbEGipAp3lY6yyr0dcc0J/6X9q2z
	 qWlVJURmBw+0NxVqj3+EblfIHI13BZ3c46qW33yn1kKS25YvGUl0/EQqSM7ZmUoYoHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ca7Tc1td;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C1606D804;
	Fri,  6 Nov 2026 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ca7Tc1td
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DA61F0089F;
	Fri,  6 Nov 2026 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793966963;
	bh=rIJTGu4lQFEUcai9lQo31jwOxKOMF2xzMy8/uijRKkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ca7Tc1td1SVOvkCWqi93cF+4oicJ5D2n86/c9DyBbfQbeVGmJXBESJQp2eN000bX0
	 bvVLAy3jSzzWeWhl2ZqBQ8HRH2529Br6caegJg/3QVBbNyUbBFcHrtL3jo5FFBhGDP
	 VzmJsUc51vWvsuyXyk+W61mXRJo0foz4rQhNnZKr4lCVGJB1fNnCf3+ZpZ4z2PhN9D
	 4twt87jfdZZccjiVJ0FuNKdrj3QxmgBCfIZV9Ma0R9cFdotSp5JRGXchyPUHni5kvG
	 B1//EVUTUyy7RSvycpLtL7L9YuWwY+L2BwIYZg756Qyi5c4T8QtLxeweP0SrQwgn4d
	 sLuBmDb8rGZcA==
Date: Fri, 6 Nov 2026 12:09:18 +0000
From: Simon Horman <horms@kernel.org>
To: Vadluri Mukunda <vmukunda@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net v2] octeontx2-af: skip NPC_AF_MATCH_STATX access on
 cn20k
Message-ID: <20261106120918.GH865646@horms.kernel.org>
References: <20261103091831.914393-1-vmukunda@marvell.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103091831.914393-1-vmukunda@marvell.com>

On Tue, Nov 03, 2026 at 09:18:31AM +0000, Vadluri Mukunda wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> NPC_AF_MATCH_STATX is not present on cn20k silicon, and cn20k does
> not set up an RX miss action counter. Two paths still access it:
> the npc_delete_flow mailbox, which reads the counter of the deleted
> rule, and the rx_miss_act_stats debugfs file, which would read
> counter 0. Avoid the access on cn20k. Counter support for cn20k is
> left for later.
> 
> Found by code inspection. The issue was not triggered on hardware.
> Compile tested only; not tested on real hardware.
> 
> Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Vadluri Mukunda <vmukunda@marvell.com>
> ---
> v2:
>   - Fixes tag now points to the upstream commit
>   - Also skip creating the rx_miss_act_stats debugfs file on cn20k
>   - Use full name in Signed-off-by
>   - Add how the issue was found and what testing was done
> v1: https://lore.kernel.org/netdev/20261026035140.666684-1-vmukunda@marvell.com/

Reviewed-by: Simon Horman <horms@kernel.org>


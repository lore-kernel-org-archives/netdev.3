Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC732E743;
	Mon, 17 Aug 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981303; cv=none; b=XZ4poP0muZKVLH4W4lwebQGUuGpWMnZ0n14QdYs6SF1zc9/fA+aECPgWUCZtnvviRk0jQe3snT996W+RgFy8fzJZCfn6XpyXISZ38/i54u08TWk35L4QN53/bQAGBS9peZhaDsvzGBKHocwvRAw7VThPcKb5kv3J6iWY/f9EUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981303; c=relaxed/simple;
	bh=BpdQUpY61+7oZIyggmUaZMgzYbz6UL49nwSeoq440/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObbXkwLF7cSbgtoznccqsohiTPAVHVQr9TuxXFFjd3upg/mtNs25WNhl6WnJnFtwzJ8K74Y8kTDhu6RRcbRJUpw8V7ZfuOe0jvDYWSdX5LlSBDiQMC+T24hkKvm7JppZ6t/3fV2WhirFqPFpTYe47ukZ4BfSQ3O6boclZMXYqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKcL8ET5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKcL8ET5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3E1F000E9;
	Mon, 17 Aug 2026 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981302;
	bh=piQnTnSDd7G6GOCF86a0f4eoEPi20L02tobUP5pIUfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DKcL8ET58ROaGfsSrp7L3VnqW4tImV6lE8yXHpEZvfvfKlHkxaRq/Nk3pARDZw1/V
	 64NeYia+34CwdjLq74nCs0ZgnvN0K3JCAw3i0QVh3VudfZic4CFHkKOsTq+fliHRSl
	 UGidJV+ob6Zc4O5jHBA1H0/zYjUV2o8jD2cIDYx3Vw5JtVGt+K7fze9Ku3AvxPCQGO
	 kUfDBTmYHDd7ZgeXjJVcgaXOi7Cyeqnv4IABhCmp5E3D9PBb+YcqBthKQ78/9KkY2o
	 TYw33b9zQNY6RtV8KTNY0i3t74/WO7j7bAz1uqqtUv+tXapdO0TXYnaWqaQ1z14gzz
	 DYEj37bJTY2TQ==
Date: Mon, 17 Aug 2026 08:41:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, Suman Ghosh
 <sumang@marvell.com>, Geetha sowjanya <gakula@marvell.com>
Subject: Re: [PATCH v3 net-next] octeontx2-af: add NPC TEID matching for
 GTP-U and GTP-C flows
Message-ID: <20260817084141.60f6029a@kernel.org>
In-Reply-To: <20260817035127.1782901-1-rkannoth@marvell.com>
References: <20260817035127.1782901-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 09:21:27 +0530 Ratheesh Kannoth wrote:
> Subject: [PATCH v3 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


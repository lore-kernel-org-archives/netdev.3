Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49C18027
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771375366; cv=none; b=n3tXg+/CNRcl+hbBAux1KqPbmiTQ43AS/2zDF3hHkJ5rZm7DLpX0lniWUh4ZuHXKVAg6/r0zyhq+1ZeKUUMDJA5RvC0Hl40PwFH1/cshOEkZZpvXHWRwTM3Oo4EkqxD13QDTWfKAeroh7Jn6e/2KGJf8DRXUy8wSt+6hxTGmzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771375366; c=relaxed/simple;
	bh=gLwbYDTQzWZ/ExH60EkTAX0d8ePuLtU0tsvEOkCke4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lgna+Cd4jtcY0Jd4LyfTwvsYK8rLKHLjUfLXHN4yLCBmzgUGdcVh/0j9a4FuIfxHet4CnxWEwN7lHE6qLUfyFBhXlN7MgxozP/TNRoVsvzo1gQeaV2yBykE7lVY00MxIyaoHWfGqUfMT6xMZQS4nFmAU8Swil0uSHNmmwTXjWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvM2N7Wb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvM2N7Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC23C4CEF7;
	Wed, 18 Feb 2026 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771375366;
	bh=gLwbYDTQzWZ/ExH60EkTAX0d8ePuLtU0tsvEOkCke4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RvM2N7Wb484CHYEccH3udSxJ4Yr5nFwKu1PxB/gHHukdW1+XDOANl670lBSGXVmYI
	 MYOnbyZjK/LZ/lo0V1tfB1SPxhtuL9Ofnigx0hjjjouLDWRCZlbuVmhQVPQJSI3GMS
	 D47y4MEbzTFNGsNQtmIhs6k3WbfNvsD+Ngg4AdmliU/clY3EGUtcDXlPxZjINjwzDS
	 9Cuhte063044miwwybOF9BK27xZA4jToT1iCS0JZXSkO6ONRGopcxJc+pYTcIjHgga
	 fpV9vCJzDigyxhf6Bi6CPw5cECq24PTWocH1SOKn4rNUZZDHCLtOvqkYBnjeZi20rh
	 3b4cAW8cw6NCA==
Date: Tue, 17 Feb 2026 16:42:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Bohac
 <jbohac@suse.cz>, Liang Li <liali@redhat.com>, Nikolay Aleksandrov
 <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <20260217164245.594e15a1@kernel.org>
In-Reply-To: <20260214091541.89659-1-liuhangbin@gmail.com>
References: <20260214091541.89659-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 09:15:41 +0000 Hangbin Liu wrote:
> +	bond->recv_probe = NULL;

nit: WRITE_ONCE()? It's READ_ONCE() in the handler.
-- 
pw-bot: cr

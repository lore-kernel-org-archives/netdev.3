Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754111;
	b=5Ffm/A4VLzDdrdcL97or0pWjuguAJDd7Iw6HaYWoJPzLZ6CYiAlN43NKDDJ9fc+LLVmY
	 G2Wq44QO5IaKJjqKO2HoTYA7S95v763J+SihnhKYN5LkNbvgQPHBoPOJGbvHNY9vayNgN
	 WQj4to8PgMh/Di6d3vY3GAKkPOzL07aOcdDWx7LYD0MEPDGgl9ieArdoPPC1u2QrfqPvk
	 KOjdbsGPPnND25d4Gl4b+JkN3Ti3VSzIplyk7MrtlaCRv7BQddsH+h/A8b7YbQU6CD8oO
	 nJqxQuOBwgxHq40VTSbQCfguHrhpA3CUrsBlUECalFjRvZ8q6v/4G5Pez6qKTrxhn3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754111;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=Ouveq7mGrLRQ0ofHONc5foFtoIgS8hdqXITyl83nHFY=;
	b=RUmOwDK6zgnOssGZnV5M7q4b99K6tRpp+jXqDXoBHqtz7DilK5g+c2gPDjsiBvOBE4/B
	 jtx9yu7Lxz3FH9nSIQDw2bwQK+Wqwgjvrztvh2mXzcccZjZSWvue5P7j9rdTEolGlypXz
	 R4ZfDSTNL0iVF7Lg7fNjkMsnbvtyldpH3Q1KKDpEmbDC5AkRL9D/1mQjzBO60V49vlxXy
	 UA+BRmQl13bSbYA7VSoNNcKt85+VBhhE8LubQMisH3agX8CI0i8ltyt/j5iAThVJ5K/95
	 oxodIOAFsUdYDfiuZErx3MY0Od+4GuLxe/s/gGDnoHKdyu+Kv2Wtj7zu0eTKrdAXMBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F8606A31B;
	Fri, 23 Oct 2026 11:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B1F8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8A38745F36;
	Fri, 23 Oct 2026 13:15:03 +0200 (CEST)
Date: Fri, 23 Oct 2026 13:15:01 +0200
From: Gabriel Goller <g.goller@proxmox.com>
To: netdev-bot+sinfo@kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <attBBLegF7iEikaQ@luna.proxmox.com>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
 <179275358416.3327.10205293492560698598@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179275358416.3327.10205293492560698598@kernel.org>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1792754102918

On 23.10.2026 11:06, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Hit during development of ifupdown2.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Can actually be triggered.
Check with `ip montor netconf` running and execute e.g.
`sysctl -w net.ipv6.conf.<dev>.force_forwarding=1`. The state of the
force_forwarding property is not returned

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


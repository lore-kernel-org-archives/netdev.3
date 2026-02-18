Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7E1F4631
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771375437; cv=none; b=LruixEXUO5VD3o8WFrrwsGNN+oFU1Heka2QbWqDIlGFVPr5i580zocz2ipMzgrMkwFTZg4UVGIDo6Lp3xg7cGuGWWDQRiHwyM2ixacKOtV4jUiwHb0pJMzURUG/kr342moMQ1rAbQ+Mgwp8EZ903HefZrv0a7O+d/LycJ77RkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771375437; c=relaxed/simple;
	bh=4TzUgARMv5n2YBtZK2hiK2Ltm4bOWquYRFMInhc/hio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTHKu8XJ692ZhO/SPalXmtMg67r3xoQDsUJwXornvRQNeLgXxUsyr315RMELdwE18b1OLWMS+ahmNidDuGpEV5jls5693mtasVRdWd8QNdJNiVc4eHfSQylJsAqJKd4CmACSvruTlmHj2jKYqrf2pk7Rph61jHCDuMMg9HqtOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPGwryUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPGwryUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340F7C4CEF7;
	Wed, 18 Feb 2026 00:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771375436;
	bh=4TzUgARMv5n2YBtZK2hiK2Ltm4bOWquYRFMInhc/hio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPGwryUjwYUbjoBZfl4SCQQu/rJ2SucHSJPcWXovIfIM8YbqetBPQns6qNUL1fKfk
	 1woBF2xziSFw+BSYwv2GH7q1N1/KtXwMko9pHp5DElas9S4yQ7J85aoIHvAk8X/NQ/
	 0qVp750wE1107Qt0aTfI9SqzwcDUx7Ajjw0MXKf9bXfK0o83pzlXD4yhdybhs9M2cv
	 W6Eg+1VEnY1bGPKLP04OHZEdMpZZOffkprI3AZgvkZiGwPv8AfpGuALbTZ4oP8eW+5
	 qr+0PudwR0MYl3RybVtOVLG/riLYu9GHyDwi26vNs6CHFn289B1uUMu1babXvpPdTh
	 96gkTslR3k+nQ==
Date: Tue, 17 Feb 2026 16:43:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Bohac
 <jbohac@suse.cz>, Liang Li <liali@redhat.com>, Nikolay Aleksandrov
 <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <20260217164355.7139ab53@kernel.org>
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
> Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")

Ah, also AI says the issue existed already in 
3aba891dde38 ("bonding: move processing of recv handlers into
handle_frame()")
not the exact trapping instruction but the hash table was used from
recv_probe so at least a UAF would happen.

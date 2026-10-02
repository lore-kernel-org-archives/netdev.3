Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F763433E81;
	Fri,  2 Oct 2026 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971808; cv=none; b=TOy2BqKeK6pfQtgyCmPNAsCkTXR7xgEu58QY8m6vmrGoROQl4jbAqe4VH2JiHigrAehoWWtKXsqnzn1bBuBAl8XFAFp1ks6CgnraFBnxfWIvG7Vg3zH+Z8Rqw4fM8Chv+O1BhhJA7yT0wDL+uI/XnU0G1mUK16ioJO9ieNT/QmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971808; c=relaxed/simple;
	bh=OSEHdv53C+HalQFUUEuG7LxF+rpCZabN0eyFrCHt+8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LhREUnUjQvTP76w9ybmlBYz4BISkfMPBkHRliMb7UqddYFAQWAXYt9pg7yWZ+qh1nvvC3iR8Y69AWy5sZJJva5CzVZu3cLQHJV54bDM/973pgZ+iRiW1q7n7eOgIlafVrKJPEMGqNgxegrJb5K0OYVWvdErIqmGJSCct1WHg57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTQFLAcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTQFLAcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB631F000FF;
	Fri,  2 Oct 2026 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971806;
	bh=xKoQoVH5BueajYJkB8F2LDUyiJns05X7P0SOuxZ0uPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BTQFLAcnp3q388HNb+G87HIVdbelb+g+mY80QEmOWAZMEKxMRUW+M1S2EydcllOF/
	 1UCu9xVCwqTzebScv0q07sET5ImDntKWsBbQEv4Z6Dl9u3pNGJGYJDzWUuwpZkwvok
	 lGgvz82MxhB2wfoolNZ8jJUx5qfIEeI/TVVxt0ErrBEog/39BnHJKcjuXwj6nr89j1
	 PpyhTJXXHarHum/ok7oBTLZf0jLHNk7nNgTW08zqI3RTwm5UdqfPP4SYr0RZKlHLdA
	 lQ0Rd+V77wdLGXptTLyVFTEeO03KKX+ovTw9BDmse2oxvuf7lqCamK2JDdzWAXpZ5S
	 zWdK1ZDGJoHeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44043811A72;
	Fri,  2 Oct 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: reject net_iov in zerocopy receive mapping hints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179097180553.3568371.386085043073981304.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 20:10:05 +0000
References: <20260930102524.1659847-1-4ncienth@gmail.com>
In-Reply-To: <20260930102524.1659847-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 almasrymina@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 19:25:24 +0900 you wrote:
> After copying a readable prefix, receive_fallback_to_copy() asks
> tcp_zerocopy_set_hint_for_skb() where page mapping can resume. If the
> next skb is unreadable, find_next_mappable_frag() passes its net_iov
> fragment to can_map_frag().
> 
> skb_frag_page() returns NULL for a net_iov, but can_map_frag()
> dereferences it in PageCompound(). A v7.2 KASAN run on a connected TCP
> socket with 64 readable bytes followed by a 4096-byte NET_IOV_DMABUF
> fragment reported:
> 
> [...]

Here is the summary with links:
  - [net] tcp: reject net_iov in zerocopy receive mapping hints
    https://git.kernel.org/netdev/net/c/8b1f0af1fd5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



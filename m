Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659606;
	b=CDa4VDrc1Q8qOnUICFhtxHBzlXU3YtXO4TD93n0xQ1LM0Fo5k2FhGt3Wbm8VgqK9HrZK
	 r1lnJNsFzI0ZFjm3DbVVvHR58n6usGeq+psCvDf5BO3Seno4lq7vLIyw7Jw7wPgo7xbup
	 I8F/XWktOnVKoeXXOdqOZrdrFjuGTap871VZSEP70nAl2vlpk1AG+sDl51rPUlcTbglrH
	 Unngw2HVhooLAvIkeKCnGYJe4Kc1PR0p5eA2dBpK0Z/dqW1+F9ggAEBDS7yAC7v+zEynj
	 hGT4cMO2T+y+sxIugo9cl5dbj0Cd17Fe0ETkebHgPrXN770XOhLrnE6cD3eswEOW1xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eQpSgGW8hmJ+axSLStFyg9hyDgGk+StyNQpQhufvwu8=;
	b=EsvzgDRImv5WDhbZvRqz0lb2E/K1vClhaqpNnt4lpwM7n6Jp4WECudZC40oqwEtRSyC0
	 aTJOgFO6xy5gt+tYk2+l9qnU1G19vRucHUzTO9HIrXJskG3H7WQxOfKnOa8G19SYtwt+M
	 kYHPK1xUA//kaT+pq6Ws8P4Xr+0EtIGfafwvyqa7SmzyO4maaAw6R0iA8kD4/fhDzL3Pb
	 8tnnY6qbqPMwsdGkIjIDzrQIwcL5qiPh2ldBi6HMKhJVYUjGMbNbKBfhNp4+kHtRaofBc
	 Zxlp+JACBz0tYnIYPfagZXfDQMkIaqcqkGBDWzmqHHKCfBci6sLfs8fMm3uWioZX+MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JHVL/1OG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51C606A31A;
	Thu, 22 Oct 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHVL/1OG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00511F000C1;
	Thu, 22 Oct 2026 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792659605;
	bh=eQpSgGW8hmJ+axSLStFyg9hyDgGk+StyNQpQhufvwu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JHVL/1OGcV/hX8f53uMYUCuPh8UxoUAuWZIMk00muJ14QkOsz2JxgMnJDf7egvtxA
	 919dbjZkh9RSVJI+oXx1W1gU+mPTHf75BT0VbARtZpm6vYhBhLmin8SOpPPDIns4rb
	 ep30zLrrSeXCnPYbcjevJ7XwwDx0Aw9skL6u1XfCoaXJG79XZ4V4z8jhBdmLhFwKEZ
	 FAbSBOXEqkyv8ew5/2f10c+DB1RFc9MyuQDeOpiFkOt/kBzSZ4paqa0f00Q1s7ULF4
	 O/KTahRn5oa9Bx9Z1hYFUpbPgw0U0eBsBH6dq4QeYISl4TNfL0ny4i5pmNEdXaTMIZ
	 7PbEuo/aXeCzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B448C380A97D;
	Thu, 22 Oct 2026 09:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tipc: fix use-after-free of broadcast reception
 link
 at node release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179265960428.1554666.5146003602746778440.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 09:00:04 +0000
References: <20261019104352.488347-1-18983559317@163.com>
In-Reply-To: <20261019104352.488347-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 19 Oct 2026 18:43:52 +0800 you wrote:
> When the last reference to a tipc_node is dropped, the node itself is
> deferred to the RCU callback tipc_node_free(), but the nested broadcast
> reception link, n->bc_entry.link, is kfree()d synchronously in
> tipc_node_kref_release(), before call_rcu(), and the pointer is never
> cleared.  Readers that obtained the node from node_list and then
> dereference bc_entry.link deep into the link (tipc_link_name() in
> tipc_nl_node_reset_link_stats(), bcl->name/stats in
> tipc_nl_add_bc_link() on the link dump path) therefore touch freed
> memory although the enclosing node stays alive for a full grace period.
> The sibling per-bearer links get "kfree + NULL" under the node write
> lock in tipc_node_clear_links(); the broadcast entry was missed.
> 
> [...]

Here is the summary with links:
  - [net,v2] tipc: fix use-after-free of broadcast reception link at node release
    https://git.kernel.org/netdev/net/c/473167593f42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



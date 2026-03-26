Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FB3AC0FA;
	Thu, 26 Mar 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516218; cv=none; b=BcdReD8Extz/ngMz4OAaaGc4YQS8OVd3CXHdeHH93WntiJ0hI6I2U4PyjiutmfN/Y8A+gwpup2kgFICofGXOx0XdU9XGXjJ7mrQSM437aL0dSYHhLw3wUKyv3Nuf7AZuhSOxKMkhS1nhDjBwj21+BE6h+uWMGAGbE4CQehfOQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516218; c=relaxed/simple;
	bh=/1xRfd6xXT565etnvNqkfEEgLZJv7ZZbnDsBkKOaf1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8+IZN55XW6Ensjnqos9xxpL1YxmvJmTXTZSkOgXKi/chc3q4jXctIYQkQhczUf8weBYu9AoUx3ySF6Kr7GtRyhEGiMo/6U29z3kgKSMyKBXJk9s9tmr/sL4p04APySF5iyl5MrQf0O6t1JLVQTj91Hj7UWTPnyQuOb7j4QafHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBEjJSu6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBEjJSu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422EBC19423;
	Thu, 26 Mar 2026 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774516218;
	bh=/1xRfd6xXT565etnvNqkfEEgLZJv7ZZbnDsBkKOaf1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBEjJSu6vUj+TDp1IJRwJXWKLb0TYeuUeuqMIwGmh4nfq9Ltey4x5dU3Et8tPQZAP
	 OrdgA6MzKyL0T8pP5/LF5YeCNO+qGHAXQd5D2f6Yak4Ew5Oq/bzaUsrjq7Zp8iPDjw
	 GxREgMOFWlHYyJZ+7M2+Lpw0VQ4iMzNMoh7HhCtB3p4rCrKknDqnUwYu79SUHa5D1I
	 OlRQvbTezqif2QWio10hv/w2STk1Swc7tBgPXTfxMjnO8j7K8xNQVudSPKxqaVshAt
	 RcPERg5iZypSzS61kvlDFC17fp5pnEIa3asYmJW6npWmP5aeXduP/OZ4daJP8Nb3hy
	 e2F5wfZ4u3Uow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF33809A1C;
	Thu, 26 Mar 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] TLS read_sock performance scalability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177451620504.2447831.2574474654524015767.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 09:10:05 +0000
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com, hare@suse.de, alistair.francis@wdc.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Mar 2026 08:53:22 -0400 you wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to
> run these issues down and get them fixed before we convert the
> above sock_recvmsg consumers over to read_sock.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] tls: Purge async_hold in tls_decrypt_async_wait()
    https://git.kernel.org/netdev/net/c/84a8335d8300
  - [net-next,v5,2/6] tls: Abort the connection on decrypt failure
    (no matching commit)
  - [net-next,v5,3/6] tls: Fix dangling skb pointer in tls_sw_read_sock()
    (no matching commit)
  - [net-next,v5,4/6] tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
    (no matching commit)
  - [net-next,v5,5/6] tls: Suppress spurious saved_data_ready on all receive paths
    (no matching commit)
  - [net-next,v5,6/6] tls: Flush backlog before waiting for a new record
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



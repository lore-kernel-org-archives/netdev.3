Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AA18787A;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848812; cv=none; b=GD2ulD/bJF2LbHlJPXQSCft4f12NL2noX4s4d9jAgXNL/abtv7wIp/hpIdOLhEFu1CuYAq9Mq00l5RQpGB0yWv0XQxLGVR9vvtj6K2hoU+QY3m9rL//uMUbuNiNzUMik7LiKFlzWjVjfMcT/gP+i+ZjVPL+lnfj4Q1RRIX1iUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848812; c=relaxed/simple;
	bh=VijgEdxT0vRaeLpxh7yCMedpS5F6JbxQlXL3z5GtyCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KyheirV5fztDOTeA6URO/ciOPQq6cSa+bzo99SLJJe48yPYRnxifCjruti0O8PKOyy+0cWy4Y/C/hM6tvCwZss2nOF9X2J67JanLVP5lZlDlpgS4F6LYx9/9kFD9QLGm3HV0bCC9frdEkaARsILVdkwNQmDqORyudZDRndgSSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6aOEVuv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6aOEVuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37095C4CEF7;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848812;
	bh=VijgEdxT0vRaeLpxh7yCMedpS5F6JbxQlXL3z5GtyCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6aOEVuv9hpLjL/6DS4cKXM0zrf+nGPu/aU8fV1ybx+exBoo/0gP1RvcLpSdrkKLy
	 iccdL2T/SeHDvMCmpfeStr+c4iKdoUsZVg0hameWD9qg2PG9YXY+zfGXcx6y2rC6bR
	 hdC83kAlO4Ua9TPc/zR4JtKbAToRS1xJI57IgXhHbbuNj97cuLUBgYu6tbC4XE7FW+
	 nBm9VUpTfV84AcjaIOx4PiXylumKMnqDLS3pVDEZTrIGaH4dMVQnErqDoQYpxdQerL
	 kyNMsdNoHfeTDD7DxfIcIQrzEGybfTzwFjNDgV1PiusRQfx1tM9w0rh1QSY2xeibys
	 fOd05d0i/FjuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAD3808200;
	Sat,  7 Mar 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc,
 afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284881104.123899.8488535259917331846.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 02:00:11 +0000
References: <368272.1772713861@warthog.procyon.org.uk>
In-Reply-To: <368272.1772713861@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linmq006@gmail.com, marc.dionne@auristor.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Mar 2026 12:31:01 +0000 you wrote:
> rxrpc_kernel_lookup_peer() can also return error pointers in addition to
> NULL, so just checking for NULL is not sufficient.
> 
> Fix this by:
> 
>  (1) Changing rxrpc_kernel_lookup_peer() to return -ENOMEM rather than NULL
>      on allocation failure.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
    https://git.kernel.org/netdev/net/c/4245a79003ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



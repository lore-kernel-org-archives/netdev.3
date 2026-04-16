Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8E381AE5
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345637; cv=none; b=e9WUhOJnAVGCTmN+S08oxYYjHIAl94LTAKL+5e7XYMwyslQ4c8Ns71VUrcbuo6FSZomlFDcr0rebj3Sj3DAjbCCu1GxITOjW3psjzt0LSPccixyH7X68VrHfakHaHTxRY0Bcjcc5MppykMCSZtB7iQXMYLrjkdn5cL/qotvI1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345637; c=relaxed/simple;
	bh=vSMpG/Y4Q8dI5iy3S3NXgYGA6xNilsvOSUCtlWiGj6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TxTH6wGA1EE+vzJvOUQvJqPE+fQM6Yko1miNROFC380xOb6ii83HswT6MRmv7fkRjLBpxthcV72TWTJeafYiiGTH49Eo9vTcmNVnsVV/iKD8KC8PfJ9eYYLnwPychwXIqssUrbREYn7f0MW7ikIjBRyfOu6JMvksdWj+xxPXJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiXyO4V8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiXyO4V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FA1C2BCAF;
	Thu, 16 Apr 2026 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776345636;
	bh=vSMpG/Y4Q8dI5iy3S3NXgYGA6xNilsvOSUCtlWiGj6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HiXyO4V85w8ZsFwETEt3Wr8WUi/t2uTm+5kQsdUxsA6ASGXaCmw1HgHTObXDE5+vA
	 xV1Cc7SOSn+0LaFrugBuTpKnjD8s5T0Von1Uz4UTij1QgY+JAGfXY4Aix3AN2ICv9S
	 Hb5O7tG5fp14Q5fc3a8IY0GxKvTyeLjiqP0LgRKMtsyUsZu41mQ3RePFtvvz4H9FQg
	 9v7DmrloQfv6BZvwiDb7mKJZKXS1pr3T4HiTfZOA0AE1O8/XXpw6NaQZTu2H0F40Jd
	 XXKrkDZSBA6QHaQHXJMj6nnB3L3BZqs9C7EQIMcVupqtZ1y4HGlRhJKELkKZOk9gWb
	 MdtgIWeyavyBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E82380AA58;
	Thu, 16 Apr 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] vsock/virtio: fix accept queue count leak on transport
 mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177634560553.2812574.4966275428192416986.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 13:20:05 +0000
References: <20260413131409.19022-1-phx0fer@gmail.com>
In-Reply-To: <20260413131409.19022-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jasowang@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Apr 2026 21:14:09 +0800 you wrote:
> virtio_transport_recv_listen() calls sk_acceptq_added() before
> vsock_assign_transport(). If vsock_assign_transport() fails or
> selects a different transport, the error path returns without
> calling sk_acceptq_removed(), permanently incrementing
> sk_ack_backlog.
> 
> After approximately backlog+1 such failures, sk_acceptq_is_full()
> returns true, causing the listener to reject all new connections.
> 
> [...]

Here is the summary with links:
  - [v2] vsock/virtio: fix accept queue count leak on transport mismatch
    https://git.kernel.org/netdev/net/c/52bcb57a4e8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



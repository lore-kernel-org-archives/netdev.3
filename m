Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D125FA29
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515051; cv=none; b=auWDx7I5BkjJL7POb2YqFexH3XreDS7eKIwIviJ7JR3XlBM06TyVRUEtFhFSz6ZD8tqvO+IGoWBhu1t7gwx/zmvT8jQariaB5NP0Z/VWUAtZjEYHVaL8i+Y6vLP8YU7MjDiKLCCOQVbRzgR4a3OkJYDe+65zHlFw7luRYhWTSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515051; c=relaxed/simple;
	bh=a1UzXaYYxk8eew7tH6jlILm+q1oKKsetaZ6dGSzp9sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bTyTn4km2NpPMQWsy6woNtV/DiGOygj62LKE3t2fH9wh/p0aH4clYjUZ04nEd54qOn7dE8/XsTU3JlquNiWd/h6JRdyuzU9T/PnzddtUpP9mDlHmUIO1KGHSR1ndN1Z6CJs+qf95iXe9nsg/xXphS9HpWP1XlpUTMWvf1LyBquQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn05qJ7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn05qJ7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9962BC19425;
	Thu, 30 Apr 2026 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777515050;
	bh=a1UzXaYYxk8eew7tH6jlILm+q1oKKsetaZ6dGSzp9sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xn05qJ7vAcgYPxLznWRllP4Mhyq1kDF7Bwq76iNCRnIwTxEhhorKD9zeprKj70fAD
	 paCo8UCJ0Oo8pMqwjsDOjLMXqag/ybQLExsJndAhtwpZMUk1oycntHwFgqnhF3wGuR
	 s5qatD6bdK5c6IgOBI+Q/vknFVJD2umKpBA2oXoZ8XIQ/SczibDddB8kc49GyMI7Wv
	 DKvWvkd+IkS1F+spu3rGFeXqXUdJXYj7Tnele9vvNbrFrgVi70vWSSn/zM8SXLLiJO
	 RbT3EYSLmPWG25VtpgvmgFDpE7LGxENmZ+t1uf7LABZ6+NR5lh8tblNDCdJw5qTby1
	 4H4/G7Q0HPjTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6B3809A33;
	Thu, 30 Apr 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: 3ad: implement proper RCU rules for
 port->aggregator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751500580.2264184.2818208802204710307.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 02:10:05 +0000
References: <20260428123207.3809211-1-edumazet@google.com>
In-Reply-To: <20260428123207.3809211-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+9bb2ff2a4ab9e17307e1@syzkaller.appspotmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 12:32:07 +0000 you wrote:
> syzbot found a data-race in bond_3ad_get_active_agg_info /
> bond_3ad_state_machine_handler [1] which hints at lack of proper
> RCU implementation.
> 
> Add __rcu qualifier to port->aggregator, and add proper RCU API.
> 
> [1]
> 
> [...]

Here is the summary with links:
  - [net] bonding: 3ad: implement proper RCU rules for port->aggregator
    https://git.kernel.org/netdev/net/c/c4f050ce06c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



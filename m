Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279302;
	b=JwHri6G0RSIOjejU8VTZHhItMARMvi0Ebx4RQvHgYppkOC9vlgbmLhQP+q+MTyNZ/O9U
	 p8Z2pZv/PEgTXh6C3yq0Ux9IHiGqkIXiZfJIuUauTSQOG22B27xVEt1cGzEnW6OHzkMZ6
	 HPcHTqgp3EdFHv4W3gvjJ5vKjFoKMRfuDHdC+qbOjwoRkLF41hXgzBnnPneG/sBqvcN07
	 DcEzYnjpRIOmxbrrp5gIRbjfgjuZpVUg4j5GJoMNPVSrR+eGDV1IR3pvVVVv886iHwURV
	 C5qShgzH3pF3ic13fg+LRD4nyMUykAbchbW47agDPzniN9Y2Ik1G0U092Zieipoaq4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279302;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cTX3T6TMAJ5HwTT0XmoAC7cwn6bo+kfJagmFjRifLaA=;
	b=WtfTek5vR56OPY+WPqzwGcTOPFXPMOA3cIHHmV9dr42tHR143ObOyDKdIcCC1Y+vIShE
	 byzIEb9nkqp9veOaEYufHbrJ3b6CUbXd6LmYPE04Ck/72hqAdc3xE44Fbwv5p1Rx1t3YT
	 FU5xsGwlI2+LnGG4jLUPB8NdVqRj4+MHXWdZc9w19V/4q/x/VIrqUzRDpyJVjPg3gt4EC
	 kxz98KBFuZPErZ76YHKxufJcUdH0in1YjIxxzhmHMW2Y75Bk0Ed6rkiwXoIvK9yXu5pH8
	 u1DkBuFUn56gWSlkO/PCpG9lfTJvn7YrBjheIXaLdVv8FkrbtJZTdP3RQL1KZOVVwHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIepXn9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667360A6F4B;
	Tue, 10 Nov 2026 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIepXn9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7471F008A3;
	Tue, 10 Nov 2026 02:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279301;
	bh=cTX3T6TMAJ5HwTT0XmoAC7cwn6bo+kfJagmFjRifLaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QIepXn9z7tGzZ8FubGGYm6oK+M7Xv0vahL6WaPAJgGRTA4jjmjuHBacrT57BlddNV
	 jcSxKwFLmuzUhC/bNasnjjkJhWQLdFkPsHsGuxVO4IdrKK6QVpmvficT1di8XIAEO3
	 DyWO85QuZs/tBqVYmDAVasljAkV9OQN+2JATBeQkfm/rpoQGchb3XXcjJvufZ4Sc8U
	 P+BrwgaBBzwirZBAMc1G6MaNTMmr56lGr2nCzgY74uSo0gqfRBYnjm8Th1qtunYpxQ
	 GxHWWhRQb4RfcGuD6tdmV4fxY20Y4jFk3GJlHdhu+CWa2cU3Uzcvi4JP6GRu5hX1w6
	 ExXX5CNSzO/sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0CA391AFCB;
	Tue, 10 Nov 2026 02:55:01 +0000 (UTC)
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
Subject: Re: [PATCH v2] team: fix promisc/allmulti leak in team_port_add error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427930017.3612825.2243864386050200403.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:00 +0000
References: <20261104015217.2222-1-lirongqing@baidu.com>
In-Reply-To: <20261104015217.2222-1-lirongqing@baidu.com>
To: lirongqing <lirongqing@baidu.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, zlatistiv@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hangbin.liu@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Nov 2026 09:52:17 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> team_port_add() increments the port's promiscuity and allmulti
> counts before calling team_dev_type_check_change(). If the latter
> fails, the error path does not undo these increments, leaving the
> port in promiscuous and allmulti mode even though it was not
> successfully added to the team.
> 
> [...]

Here is the summary with links:
  - [v2] team: fix promisc/allmulti leak in team_port_add error path
    https://git.kernel.org/netdev/net/c/ff618cb00a64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693812;
	b=iAUQ0IOqD9pBLolq686KJISuap3OLFZRke+1wN4jR90wc2fnhhV+8OBdDUu4GjKyGW+o
	 pFqw0GHqnQFSxF5L6x7ooEdcV4RA7W99cKbHFeaLNtotbDnWAz6h6budOxiCX4+oEGcGS
	 GhNP7ZwwWZVOKsuETwU+C33T3a/QLhNyvZhcxMX02N/9+8+lrp4UhkbR9d1Juiss6qElF
	 mevxcAhfpYAqr5xUU69hhF4DrEAhb94YGueJauQh6bfoYemHyHhagjPW/iSdBZZEq2Xm6
	 dE2rNGehavryfJkbmJzr85t7L1P2fKIfuFYhr95UOtqdaNoqKQaMVcTi2aWxBZB53FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=poNZhlx0vT8Sjn8+gP/uHahZJq3mmsuf1D82WqGqrso=;
	b=pDxaKlx+QfXWyz6TLHNb4S5AKKsGyJeCbkWWBjkLfRZvZ7IgRCdSlQglY6yg5jAdjtG9
	 SEg3zH+vdR7tCTsywmCDEpJqKj0AYnjNHTuNM5POyWu07pTqizayFw4W1wsDrNu225ZZu
	 ADu6jQ0g9uVa7r5yw6HbBvNF8/gga6tuHEW2JnEfzAvCc7vZzYUagFYuo7ZfOpJfbuDlT
	 dmgaszVb2rBwjFayGyIcOBNUuQ1Dl5MjVKDLk/K3YjW+7PsK1Y0cXhi1tTAcIo/b/isgs
	 41eOFA9u+KVhGxBnoLfO5LXXL8yYvUE4nZuvMpcF5dT6PdOUdytTeahkloHkZRilpiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsuT8B65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40799606A32E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsuT8B65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DBE1F01825;
	Thu, 22 Oct 2026 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693811;
	bh=poNZhlx0vT8Sjn8+gP/uHahZJq3mmsuf1D82WqGqrso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KsuT8B652YIyaKQw+q/ElVyju5AJagFAZzA5PuBbm9Q4WFgB1al6AuwmBVg/JivxA
	 dgoo3isPEMRMxljWgY5LrKfuVy+wELWsPmx0bQwvUF+Ck3xahR5t9tvgsrNSh4ntsI
	 cDW7ydoo3WwI6PDz7MgLbElnAIcTEp7bnt6r6i4Z+R5ogHyn3KvxTVJKJ6jfO2zD2E
	 dGVBboBmE89HISXDPltoCj5FPrzpO7+HMT8z34BXwxIoTlNextyCxRB0RvW+DS91o8
	 7F+IG9foS13HbIeBTruIkbiHRGJw/eItaq/Pwh5jCgE8Wkh3ObETmkTQ/zFTx+Xfph
	 WsFkE+9/gpjsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5133808222;
	Thu, 22 Oct 2026 18:30:11 +0000 (UTC)
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
Subject: Re: [PATCH iproute2-next] man: ss.8: document delack timer name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179269381032.87273.10914164445610018301.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 18:30:10 +0000
References: <20261021044030.46065-1-prijeshpatel.dev@gmail.com>
In-Reply-To: <20261021044030.46065-1-prijeshpatel.dev@gmail.com>
To: Prijesh Patel <prijeshpatel.dev@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 prpatel@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 21 Oct 2026 10:10:30 +0530 you wrote:
> The delayed ACK timer ("delack") was added to tcp_timer_print() in
> commit 37c010d59a44 ("ss: add support for TCP delack timers"). Add
> it to the list of timer names in the man page alongside the existing
> on/keepalive/timewait/persist/unknown entries.
> 
> Signed-off-by: Prijesh Patel <prijeshpatel.dev@gmail.com>
> Assisted-by: Claude:claude-sonnet-5
> 
> [...]

Here is the summary with links:
  - [iproute2-next] man: ss.8: document delack timer name
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3ae613dd2fae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7820509EE0;
	Tue,  8 Sep 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911468; cv=none; b=CDmMcl6pDuB4pxuQYrwcjeLYTL2j2ale+eYFhL5BAotcalBw4NWSQx41/3xZbP8RhKYuMApvfMggE+WTaq7bedPFsWkdw1TkvXf2NCMOEC83lamNJTNr6HmqXtzkdFcxTjo11OdX7fw4e2Ol0BJd8ElvsURwlRBYwY5kJ/pdK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911468; c=relaxed/simple;
	bh=KLY4LF5YZd6+yQU21/U3WUKhrQGJysjDLn38TLLba3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mll/XUB6/Ee5fbQgayXfXtdo6iPXLA0OmN1YPZWC9UT9MzpU64eIGqAbewsSwjaHDr2glS+FIAFfUv+S7cNxVHfVlyvtP7AwPTYSO7HyX3+5VCgbALmKtAxs4cZ67NBRcSleWr4Dcfu3JoSAArH9Jm1IK7+QvM9DrpYxI7/tIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuQ8XXmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuQ8XXmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFCC1F00A3D;
	Tue,  8 Sep 2026 23:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911467;
	bh=yMZdjIz/dPDVcdH6DM9Zb7vcMNNoEgWTc1vXlEKmwVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IuQ8XXmy2J5qgGPdk/SAQvmZXcacR0ZNWB9qTQUReg0mxf463bk1ts4dZSMnfX34I
	 jB8+0meR3aOlpNNrEhwPYZX/B5b2gKjJ2q7VyuOb3SI1RxStS6iZ2oFF8sECSX+Ws+
	 ld2v8GHUX7Ffj6jvs48ci1+1tPjAR5uN+V8VX/lSOsWbPl23eYMT0OvGFM8A7RIphq
	 R27Cb2yw6+mGETZsHGUZh5s9Cz3KTK4j+OBR3kQHk6m7NUTSBTvzKwvGqB4gzusR88
	 HrFmnzFsEhIvfV2VpfBO89j8UP2lGCthbi8qEl9/7eNYQdlBcj7GzhKiYBd8o1WtbA
	 wjA0LbTgVYsgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5677F380820D;
	Tue,  8 Sep 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ppp_async: drop the errored frame instead of
 resetting its headroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891140613.68202.2930909992157007487.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 23:50:06 +0000
References: <apkR6ZU+tqP2C3Fl@griffin.linux.hr>
In-Reply-To: <apkR6ZU+tqP2C3Fl@griffin.linux.hr>
To: Vlatko Kosturjak <kost@linux.hr>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Sep 2026 08:21:29 +0200 you wrote:
> ppp_receive_nonmp_frame() prepends a two-byte direction tag before running
> the pass/active BPF filters:
> 
> 	*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
> 
> Nothing on the receive path guarantees those two bytes of headroom. The
> frame-error path in ppp_async's process_input_packet() resets a reused skb's
> headroom to zero while claiming to restore it to a freshly allocated state -
> but a fresh skb from dev_alloc_skb() carries NET_SKB_PAD:
> 
> [...]

Here is the summary with links:
  - [net,v2] ppp_async: drop the errored frame instead of resetting its headroom
    https://git.kernel.org/netdev/net/c/8dc5d98a16fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



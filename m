Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731A348445
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894047; cv=none; b=UMQ5viEb7p1gZ+SOsVQeieuA27sKhq+1JkNalzV0Y/Gch90taIoE3W1lsAk8CKkK2/Sdyz+rV2MOI+q2sddlRK6QjEcN5IxqtGXsn/ich/Elrxhldpu2GxG2amy1Kh7FwXXTayCalSY4tkb8c+o8Fg0t1Fk0lSTs+6JZI+LWw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894047; c=relaxed/simple;
	bh=BnxIyXtXvjUj+LwdRzEFn3f2QcdjkRnWdgxFahzkfCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MII6SSmUb4SVGHCyLxVEAAkA4CCtfK91IvKqb5lGzKgJ1qwjyOxsCdNmoHicphAALMVGWefg86XTJu0DBfVVryCcVk3SufxSe5Z+tyE1uoWLYd6b5k6lIqiP6yf3mqpYauwjQAnkBn/T1MfSUUg7XW1c4jEoTy5ZgeiBfnOuHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiKweRKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiKweRKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545281F000E9;
	Wed,  5 Aug 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785894045;
	bh=Cy1NZK5XzEgnoMZoq1Wl1PTSHSU4qxMSb3jahpWcp9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kiKweRKN6kdBaIZZe9cCRH5uxatJn/sberTwWulIP02nONYTg+zi6ZzWcY0tt655K
	 71uUXcZJOAFnG/T8bfCMDtpgO4Z1Hng0NnDomcn4xnb/g9z9wEvEO2toTxHmLzSR9y
	 l+Yv5maVHMgM2VKapzhON0lDsYwQLzD/VTfxfXFOVXhlOQ+ti42n5YagoLfIf1na9B
	 dAxmkDT44kosX0CBK4Da/xYM1ZFmI2rIPHrhCK6sPAGG1EaKr34YKVSDPzG5ostkJX
	 xIjo1kXTzmzHy3STRrNosWNQG6MPxxqRqXLAGQ7J4Pl9tjlO131vUEBOuZ2k7U+4rx
	 p0unLRd1udRWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2C3926667;
	Wed,  5 Aug 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/1] net: openvswitch: reallocate update replies
 for
 mismatched IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589400580.3868705.6729374196313956645.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:40:05 +0000
References: 
 <f7bbd3c30ce81a39156e226b3872d73abed21d2f.1785644623.git.zhilinz@nebusec.ai>
In-Reply-To: 
 <f7bbd3c30ce81a39156e226b3872d73abed21d2f.1785644623.git.zhilinz@nebusec.ai>
To: zhilin zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, i.maximets@ovn.org,
 aconole@redhat.com, echaudro@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 08:29:36 +0800 you wrote:
> ovs_flow_cmd_new() preallocates the optional reply skb before it takes
> ovs_mutex and before it knows which existing flow will be updated.
> 
> That is normally fine because the skb is sized from the request flow
> identifier.  That identifier also becomes the inserted flow's identifier.
> For updates, however, a request with a UFID may miss the UFID lookup and
> then fall back to the flow key lookup.  That lookup can legitimately find
> an existing key-identified flow.  UFIDs are optional and the flow key is
> the primary identifier.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/1] net: openvswitch: reallocate update replies for mismatched IDs
    https://git.kernel.org/netdev/net/c/5d1c224dd914

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



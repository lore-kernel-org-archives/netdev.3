Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80528C5B1;
	Tue, 18 Aug 2026 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047255; cv=none; b=Fvqq28ApJW5oh28QGHTSCK2vMX/w8diS7f1LAIaArUaBDwxL9jwnWo1kr4ITNzNy+1wl/fex2Qw5uWTpLkAYp9B/zT8Vdv108CRDGf3CuLF8JNA3ZY0qUgqLrH7cb+YmeoENUPy3ba+Qwo+xqVqQXwKlBKz+COVIc/xlKBqOW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047255; c=relaxed/simple;
	bh=0LTdiNMHC3isO3KTrNmgagp52WFC46gFzc4MHeFWUAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oof6S+C1q70kcCzTTX8WagQZai+AqY3S6XzYuMyiuGycSX4IvfREitsZk4DCw7Ne/d8YUzjhqK2sgTjJYS9CrAg5FVBD9UrJVgz56uz5pLazmyFsXW6tTx/twCMWNzNYPTy0qLawxnTSpT/wnCNwdCYw7oG8DQzoiXxgwURxttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+IGDmdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+IGDmdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB84A1F000E9;
	Tue, 18 Aug 2026 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787047253;
	bh=2+wZtpclHaC7trW5ZVlz9kP3BExis0hpxfz+wYLclls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a+IGDmdquSXaUyPRn5l/0mxbr8mny9iVv+5Xc3L7P4oZndb2jvepyofmPX6RRCo4H
	 Zk/GYSw6paCvHovAuKaQqPaFf7eke+Nbvq/VySzmg8BpEGkH+nG+aEG83ldZzCG1yh
	 OFlMXtXNZhVrJb7lIKFGLN0EvfCOMrSyc4Z6DT7JW19Kl+ekUDCbecvXAILv8GBJ2q
	 0z/4jOHkfOEWI1L4nvt55FPRLuH+/y7JHMyPXl3iBeXQbIaLEbnuAh3J4AnBtxusyY
	 1bFBI6nZmmMfQ49C7xfQp//GiKsI9B7kNRcxvCLGcPgebSfk8dHH4j2kWUYmxsEBp0
	 pE+XVzoURmjtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F83926645;
	Tue, 18 Aug 2026 10:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178704720540.1996636.17975547530144489288.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 10:00:05 +0000
References: <20260814153547.29567-1-baul.lee@xbow.com>
In-Reply-To: <20260814153547.29567-1-baul.lee@xbow.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Aug 2026 00:35:47 +0900 you wrote:
> vxlan_mdb_flush() iterates over the MDB entries using
> hlist_for_each_entry_safe(), which only tolerates the removal of the
> current entry. Contrary to the comment above the loop, the removal of an
> entry can trigger the removal of another entry.
> 
> Flushing the remotes of a (*, G) entry also removes the (S, G) entries
> that were created for its source list, once they are left without
> remotes:
> 
> [...]

Here is the summary with links:
  - [net] vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()
    https://git.kernel.org/netdev/net/c/bc2dc66a6693

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737C35FF57
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190819; cv=none; b=F2V3KhBt9F64KfN7yJLHvfD1d878C1PIh3YCrQMcIB6Imb73mFO868xcHRxSrua6/FueKN3SNIsYPSHsv0vzlkIMs3F1fZaGRU6VZHP/+zNd4eMQF+1eRYaxm3SzukQ3c36J9lvNXQ5jy1TKazzpJERR6jbGfgTVxXUdS3R2JSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190819; c=relaxed/simple;
	bh=F7z3wpCvyPLjup+WdnkCrFhhUkMp8f7L7nRGeqvMdq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bMdwPm9klMjTgcB8b+wOam6T8obgsD+LdU3ffRsepsRuhj3h37s7AVNA8diUcppje6OVaBasU1gtP3l9hlatPcC/AVj5sIgUAVkYSCEoWLXcVxXtKD6aM2+h6E/F7fcBg+nhcP0sBYCx8Bc9/oL+fmIUTD/oJbbiSZtpENeN89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHQc6lhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHQc6lhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C28C2BC87;
	Wed, 11 Mar 2026 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190819;
	bh=F7z3wpCvyPLjup+WdnkCrFhhUkMp8f7L7nRGeqvMdq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHQc6lhEsHEfVEiocuKDdafvvnIB7OHHSFzEwb7somx4VtWux1ZijMisd8cSV9z6C
	 LWJtiYkZEBWcZYQo57iMIqccxBD6Uyf2m9MBU7O9bzOo2WZ/EjgjHP5FTNrbfdic/g
	 49l9W3ZDtkEYtix/UrjFhDuafYWztUCldXIVVU8X+mofwNVMB8u7j5pp7Yd+SVK069
	 A+6U66kNI69h4lTLMDc+xRpR8xrLPRIgJWkkY//YgUBRwLXrGgozNHpv8z5SWYcKh1
	 0Kanff5tbU88ptJbbplImNqr8/5xDqA1nGTW011J92f53rNXAYpYJimlNtLj9dh+j5
	 22sG18oygio/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE5D3808200;
	Wed, 11 Mar 2026 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: cli: order set->list conversion in
 JSON
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319081604.2986475.8313409993030533928.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 01:00:16 +0000
References: <20260307175916.1652518-1-kuba@kernel.org>
In-Reply-To: <20260307175916.1652518-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, gal@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 09:59:16 -0800 you wrote:
> NIPA tries to make sure that HW tests don't modify system state.
> It dumps some well known configs before and after the test and
> compares the outputs.
> 
> Make sure that YNL json output is stable. Converting sets to lists
> with a naive list(o) results in a random order.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: cli: order set->list conversion in JSON output
    https://git.kernel.org/netdev/net-next/c/b8a0e5eb6a12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



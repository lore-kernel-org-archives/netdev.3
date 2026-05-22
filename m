Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD713438AB
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488402; cv=none; b=Zuk6GbnXWF5cJpBXv/RCxdB6LcFXcRKQEChXxwNQGDCQ68xluzCbr3d0VUwvxjGI7n24aK/MPoi3Nq+spaJKpjrAHvpRp3IX+/kRV7W2Vk1y11GNbrMriLcvOHuH0lX6Owuy4vzqcn/y/IlJwN5qN2VciLUtGMc7fEm/B1ulN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488402; c=relaxed/simple;
	bh=VmcCURu8RLNauZvkQRfTo1DQegxKuOIHWcZWlQtv/NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ql8bDBkPguLsHotji3kHjgANdGNQenK5tNsXoYecJ9gsm3OevTD7md7utNVz+bRQjvjkqSS0wocnIWGpTnBVusEBLU/HGQx6OJibH98Egh7GzFzq6inXL8WT9cKjD6ilimFJMdDJTn0u19rtR+Ca4mKsmyldir9BQp/7TFwfYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKTHnqFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKTHnqFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2975F1F000E9;
	Fri, 22 May 2026 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488401;
	bh=vfmU0AYl5+P7EU4QIj7Q9JR0WtXfEvzV9OYoL6gkHpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nKTHnqFKyVYZr9qIyIwqjF1gr7gqoVTltKMdD2oJe73qUd945n6mykBsGFVih3mO8
	 bH3qM6aZ5YpjiJKvFBs500//++JSP9Q4FROuFwZn9FgAAam2DvKbFQeloAF7JRzPQz
	 IboeXNlQ25CNKXIXjR7PfXfb5IVhYiW/XDjOdMUv9fPMvvJWFYkE4m+vhax0OPzG+6
	 Qp0zlZZb8R4YHetWygx6yS8shgFJBKi1kGzzR8UuWpUZFhSqsexW9/VutYK8rhkVl2
	 z2yxWAxGxGOi17eXRdPOHQOryEUM8EoCYSYhFxIV+HQXBb2g1m079RGq2APfKUy2D+
	 LskrcuTsULajg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B73393100E;
	Fri, 22 May 2026 22:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-next] netshaper: Fix man page accuracy and formatting
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177948840989.1388561.9416850398264720043.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 22:20:09 +0000
References: <20260522030702.2671992-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260522030702.2671992-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexander.duyck@gmail.com, dsahern@kernel.org,
 stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 21 May 2026 20:07:02 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This is a follow up to a previous patch that was merged before the
> feedback was provided. See link below for previous patch series.
> https://lore.kernel.org/netdev/20260518202353.390827-1-mohsin.bashr@gmail.com
> 
> Address the following concerns:
> 
> [...]

Here is the summary with links:
  - [iproute2-next] netshaper: Fix man page accuracy and formatting issues
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=de8c3aaa3545

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



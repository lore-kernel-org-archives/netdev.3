Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B93812C2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611075; cv=none; b=abdgkOsOonxxSu8TLx03WOcOUdSSDWP4lp9M5JqJDbMrayeW79tiNF5lnXPDNesiOOzX/31063Gzw0+bx13i8JSpCaeAOcpy21b08xgf96JefO04P0JcAZsF1+F1hYFwqjoDhkoOfzdpE9VoLQpE8lcNXk+cHlf/cfslj7J5CVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611075; c=relaxed/simple;
	bh=4rj4vPImhH/SVIfKGJyqJzF1dL294fsO7v1Yfn+wXxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+OfVevcCuNlnykNzAXoTSqLtKTvNsYDgxR1BSvm69Kz5S8FdL1EKjupaXM1gmZnsEKRXXYppfPlpYSZOILzTqntt7NHj4XWEaDtBKzgvVGKiIvNzhXBoB88mJK1dhWukx6JkJWJanNlH8yovp3voHCLLXcnKnmdiTnO4B5lxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYl01sjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYl01sjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483671F000FF;
	Thu, 17 Sep 2026 02:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611073;
	bh=wGBRASkB9UJt4Eh5d9i8K9uNBsEhRO0NK01m7FYK7Ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CYl01sjL2HRulj/5HtR5l81Io1zHKFuqONOtpqdN3/X0R50d8F+aN4uSEaBhykE0+
	 /1pttlinFmcqxZSvXzfa4L+RzewX2fOwiiqwlY5MuhL0wnWy7BzLgkDcH56rXptSKR
	 3sND/Xc26c7yK37RoHk5Fjmn17KAuwiVy3gNwpcl2rRlNy4K9C+s/QOgWjh+BFm5j5
	 ROtrJ78zY1HOrmCaLRtk5QSYHb++gI++zty/beIEZqrVUUXj2Ro4popUF/jf9DzDES
	 koTE7tGJ3f9TBzYsIeUZ+wnx9nFrpISMpNaRi/h2Kyi5kTD6zhXJifxXCl3uUl3XTb
	 /46NkyJmb7w1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5678A39E9609;
	Thu, 17 Sep 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: preserve socketpair output on setup failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178961100687.3376729.11290258509445826746.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 02:10:06 +0000
References: <JyK226D0S5CWGUpAC4MO4A@redhat.com>
In-Reply-To: <JyK226D0S5CWGUpAC4MO4A@redhat.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 13:53:15 -0400 you wrote:
> socketpair() writes the reserved descriptor numbers to userspace before
> creating the sockets and their file objects. A later failure therefore
> leaves a modified caller's array despite returning an error, contrary to
> POSIX. For example, socketpair(AF_UNIX, SOCK_STREAM, -1, fd) returns
> EPROTONOSUPPORT but replaces the array's sentinel values with unused fd
> numbers.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: preserve socketpair output on setup failure
    https://git.kernel.org/netdev/net-next/c/65734bbe4a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



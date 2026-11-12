Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504012;
	b=hoEzEMIICu2b8PQvH6Q2I2bNf4JN4R76Y+mb0vpxYhC5g1ovHwrdxuYDooD5F1/9Wfof
	 0QFp+x+YFuREvq0FxwkKrutRGjbHdl/o+awVGDbJouYSir+twFo62jrpQ5qx6ThWGfldI
	 IBLGQFSTXVk/vjD4BhH618AUNOPpIkvEkOXFHDTZn3kcGNKiFUn6DaQWb82Tlaycilq+5
	 y8+Ra7gWxXnngygRnCNNa+Rl/S2yupcoRVnDl8JhnPNHDe1EWuqltkbms70eT6uaNk+5O
	 CrhxRtyAuSoszEPYIQS6XH3mN3aCZu3bIB/s3FTmpgAoTMp6sFgzMraws1dzGSO7T/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GMe02wEq6eVERv07wvbVn0lKTGvmews00dG0nM6IEzA=;
	b=LfktesY5BGGUWPanKgdXWp6tOH4myu5gYOth4QGUXQovvTVfHvFezRthdpj9OUlDOQZl
	 G+HkS9BqmlwewO3l4+LJgeTInJ7nB3scAeFkhIG+Ihw445q0ICLRuo3Dlj7YvWQBTnpxL
	 URE0P83MWjYc+5LD8GQ0wC4WSpAbZnfMq4M/RaMSD3Un2QpmyztIZv+9xnIdhYhxZ2zbk
	 EiG0MZscAvzGgXfAmRl1E4gwCS84YVNt6V5NNLXLAQjdnbVp+8DtWHCr4av3x6KiKw5ox
	 3ZqA3JhrqbYDZ66h+jJrh0oF741llTlGHZQVSLWhUljY+uqfdAaDoTG+BZ3Zm9Zulfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibiLNljb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2C606A882;
	Thu, 12 Nov 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibiLNljb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5A11F000C4;
	Thu, 12 Nov 2026 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504011;
	bh=GMe02wEq6eVERv07wvbVn0lKTGvmews00dG0nM6IEzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ibiLNljbIaWnMUwh5gVjppDfu4RCf6FCg1S7HdTxxr+ha3N/a6HWO4S72rU8SffCY
	 7pxs9+LJ5oHjKztTZlql4Xg+pCS2FBcLHXykxk5IqlaN9Mkh8VYv4b1c7u8es8/lRB
	 k+VCpmLQeAd+AyYNduhpAwQuaCjtJrWKJmmtxF5jt7FbhsK1sQfNhYMnO5XlJPnNnK
	 NkqjaMOqXpeBVc0cCpDyLQ7XKRFwWNtesjRM+EwsLcKJo8e7G3XMwWcsWzNnt7si6s
	 BGnZOF2ckIn9SfhEr2bT3nslUu5GJBovKbEdq+Ov9MenciZDQdYuKmdKlrLEDu0Odi
	 x2feZ4sJXimlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44FE380AA78;
	Thu, 12 Nov 2026 17:20:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] dql: Reset the adjusted limit when resetting
 the
 queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450401027.546493.5429797235689363516.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:20:10 +0000
References: <20261109230022.10729-1-dennylin0707@gmail.com>
In-Reply-To: <20261109230022.10729-1-dennylin0707@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 23:00:22 +0000 you wrote:
> dql_reset() restores limit to min_limit and clears the cumulative queue
> and completion counts, but retains adj_limit from the previous queue
> lifetime. dql_avail() therefore uses stale credit until the next nonzero
> TX completion.
> 
> Reset adj_limit to limit as well so that adj_limit = limit +
> num_completed also holds immediately after a reset.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dql: Reset the adjusted limit when resetting the queue
    https://git.kernel.org/netdev/net-next/c/c46ddd7d7acd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51353B6C15;
	Mon, 15 Jun 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553040; cv=none; b=l9NyZr1kx6OEKC0o7Y+UVd7so7F930NEK7KIM8Ro0RnVhFuXb7PpcK3va5tpAtfD3cD2Cv4SQseBu6rgPU0z+51SBGRV4RIwmPI873Lv/bqG2OGw84T/Z6ZrvCjksxwg3FmfvxosLFrO/YdFopZRe7GaUjzg5I/pTyWt8+dsWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553040; c=relaxed/simple;
	bh=+zjYenbvR4hNz5hqUt6lf0xQGmgyAdIvyxvP78gNJYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XnLYl7vn/ii14AobOlltM9XkaWHPWux/9tetUtr624hYzip+EUbVhAlOdBVZGrHYArjaqtfGToKffRJsjKOx0iq5plwFFTOWT5KrwEaSa1N2Wh55g2i0UbT8V9d9AIS7nQINLGS9saxZDnL6o7vVrNqBhCbo5UqJ1nM3qHnJYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcwldZtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcwldZtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845DE1F000E9;
	Mon, 15 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553039;
	bh=HRb69Vt9qNCZG1VZ44TyeKMWLcVltyKO5fVS6+m5V7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AcwldZtpKn6zPwV7MP0aaZWL0uPypjav9RX69UgvoCa5ETTRQFqmhE8hVhtK80UDy
	 cda62i3QRi/1SVjdDxU/GQ0ZavfqwawupQxijA4vzE7Cv7VtdXOzwH5r941JSYYID8
	 nQ7cBIZ0xzHvGAKX5BTyv0SX+QqdNBFEbmqHQEsOYDkZp275GMW+6NFxaD6RjqcHP7
	 VyYGXQeqp3IEOqrf4yFXzTQFI8yuAa1S84lpzNJ0WATYrEaBvhdYJPg7TW/38bb5NU
	 2RxGvA1HJ+cvRbUderwq/o7LJRZc8jD8amCjmlUgDH02sdKhVh5heTKZqkUQJYnXQz
	 x8B7YeTMjgXLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09DD3839A06;
	Mon, 15 Jun 2026 19:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: hellcreek: replace kcalloc with struct_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155303438.269508.7505045066778798171.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:34 +0000
References: <20260608045640.5172-1-rosenp@gmail.com>
In-Reply-To: <20260608045640.5172-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 21:56:40 -0700 you wrote:
> One fewer allocation for the priv struct.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/dsa/hirschmann/hellcreek.c | 14 +++++---------
>  drivers/net/dsa/hirschmann/hellcreek.h |  2 +-
>  2 files changed, 6 insertions(+), 10 deletions(-)

Here is the summary with links:
  - net: dsa: hellcreek: replace kcalloc with struct_size
    https://git.kernel.org/netdev/net-next/c/e3d202a1ed7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



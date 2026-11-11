Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355223;
	b=MovB4h6q9Bo4OXyAEv4YWvv8RTVJk/Qra5fYeiHICRlcnU0SaVeTEcBaHh/hVth8gWRH
	 6TCFyOMOdmslNoqC4N/aoQtLk+Kc0t+7hDRi+P1OXJKzZMu78YjVZ4bOg89Z1Xr22JHai
	 WRAsCl1HfNXYPCx/SOTE+itfLB7CTAyHj5MhQr0nqiC++9y9lVJdEaq6Dko36boo9R4Ki
	 toQbJTgzhUZMzaZ5gclZ9OKWThosUQGm7Dh26OZFHdj4GMSaOk6JRbRx17L/YkU6UNCBh
	 Bb3AUuv1cszBEX8+Snvkh/dGNXEJ1YDKs611mg5xo2rncuNlBYxLVDKv39+dom8dwtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355223;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qwlMeJ6DW5A5tgAFlrx0blXcJGdIlHRjDzx2BovaZag=;
	b=NYBq7lE0rUiqMlzr6ude7QYcbqp+pcwupYA20bw7IW8cuI0wPYSTtSlyvQ3ip+0c2y0J
	 EdGgFByWddna8yb//gakK3cZeFsHcpmbJ1EXhSDqmaS/ki53I+BIBS01ymsFIDenL0GFI
	 NXLTyO1bxncyLJMi1pvRlv8soIV4O5l6L8WSpnL/QsQumm1lMWNmsnjgZ6PWdurZA8sXz
	 fhg0Qj+mVvbmL74sW53WLPSBLboJkFdZtleuThrEFNS1EtuAENyTh4kvLDfBsUkC3I1bK
	 zkUJIbvlGtfAX2tIQoSMxsYcbXadgiTUyJ2oDmjmM1lzyy104zlPwf9HQLbJlP7HhDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHp7YPnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340560A261F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHp7YPnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA71F0089F;
	Wed, 11 Nov 2026 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355222;
	bh=qwlMeJ6DW5A5tgAFlrx0blXcJGdIlHRjDzx2BovaZag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AHp7YPnLgTt9CczMl1uSmCWWrTl1g/p+dcH50eyMUbTVeVMkMWn7vMCHa3K6JWkFI
	 zeix5XlYzg0q7362piAdaDyPRGo1CC6W4T8mg+SJk9yFAfL6dpE/qTAzhByqCq33U3
	 ScXcDsOsDiv9qq0Yy7RNQWiu/4FLIdPTht5NKvvnMxD5O88K/U6WmlsKeps6OXnaKl
	 QwXa6AaPLTefhl5QreaWjhi5T8kSH+FeTKvrPzS3IFP0CeoMtCZBEhP93g6VT5Y2tb
	 8iKFy7q6GVKLKqaqKlNvcSDXh8gVvrN4u2k83mwU2ldCIDPD49jW7Mvq212KSIEfj3
	 E3F4pfUgn136w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D824539E8A4C;
	Wed, 11 Nov 2026 00:00:22 +0000 (UTC)
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
Subject: Re: [PATCH iproute2] lib: do not truncate 64 bit size in json
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435522150.125436.8543717614254091272.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:21 +0000
References: <20261109180846.301249-1-stephen@networkplumber.org>
In-Reply-To: <20261109180846.301249-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  9 Nov 2026 10:08:46 -0800 you wrote:
> print_color_size() takes a 64 bit size but it gets truncated
> when printing json.
> 
> Reported-by: Anthropic OSS scanner (ANT-2026-H0R4ZJSS)
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/json_print_math.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2] lib: do not truncate 64 bit size in json
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6582d89d02bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



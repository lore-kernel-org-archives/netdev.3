Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49B4582D5;
	Mon, 17 Aug 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995996; cv=none; b=nbMudcUbfwA4NApmUicyhNs1XxOV/STVFJz3l+hArTjk/3b6jed9W7exnCoLfDTSBka2JTNsm4cxjNh1VGxXcgsjLbvTG0KZAFUq9r95ojTdWT/nDk13P5gqOMhjct7mF8T48iwV5Dgo3mrFQ9rsOVWq4AWpn2yziKMBGW9S3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995996; c=relaxed/simple;
	bh=XNAoh1kvgcOc4tautu6MbY4wjZNIY16j5bYcrn8OBxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jz1JoPQVA84NQMfEid3SaosHk1zAqZnrQ5TXLEselbCXQ14oTxh1ebNzQdI4v79NwKjZ/npm0Jiyl7xiIHgAhRrqvYqzAnH9e/QgR0HovrAkyaRR5NUk+kmo5jmc9jujkCwihrAMSaG2bPHdtFYJmsRDfSUZn1AxjsADJy5VGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQSf5Q42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQSf5Q42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF2A1F00A3A;
	Mon, 17 Aug 2026 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995994;
	bh=HdFHfoRskdrT80MBF3ImnaNbsxyD/+pGmyefw/5y3zs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QQSf5Q42e4fumPVWreIb9CRajLjEsAbKeyPDWW+O+DN/YGpXOrK2HhJ9HeK0k+Lyo
	 /Q0PFy+G71pdiizka6F8ls3AM/Aag+r5UWv7gh5k3X7gjgX2GmJVlTo18JKKrIZrEV
	 OrDBWExQwnuMXr/WW5wsNTRmt48sV0BY1DUlFWTudHfHjGPR7q5uausPubNd2y+WKQ
	 PsCAj7meHib57HTVPkjkMiplXXvplREPMFWQT5ndx6otOywBPxlBTIWvhS++3J4GsA
	 n9MZo7bw0ZGE7JVYQxodmJre7C1cfSoZvuhSw6TzIcZXN4RHR+jnaZD6Tvqz61vdkt
	 5CmUxUbUVERJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196B63926262;
	Mon, 17 Aug 2026 19:45:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: psp: use psp_dev_is_registered() in
 psp_assoc_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699594663.1691257.16405328949976310914.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:46 +0000
References: <20260814-psp-dev-is-reg-v1-1-5029e1f1eb01@gmail.com>
In-Reply-To: <20260814-psp-dev-is-reg-v1-1-5029e1f1eb01@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 04:44:06 -0700 you wrote:
> No functional changes.
> 
> In code paths that use a psp_dev reference that wasn't obtained from
> the psp_devs xarray, e.g. not via psp_device_get_and_lock(), there is
> no guarantee that the psp_dev has not been unregistered. The check
> here is correct, but it doesn't match other code paths that use
> psp_dev_is_registered().
> 
> [...]

Here is the summary with links:
  - [net-next] net: psp: use psp_dev_is_registered() in psp_assoc_free()
    https://git.kernel.org/netdev/net-next/c/cf85f810f911

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



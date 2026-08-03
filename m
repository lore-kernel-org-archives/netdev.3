Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FE2F3C10
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789646; cv=none; b=Vc77jAic1u6ksjXAQdvelp7x3td5bhfRp9MBZYVFiL6yBmoVinowMr+XBaxVGCw3vILPfbPF2BRGfqzQsycTy/vU5xVjmLfqwED5xeC8B6InHlla+jjhwARSkz6t8F72hbi0XtNEhNzqm8SgCK72mC6u2uqN/itLoNrgrvb9cIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789646; c=relaxed/simple;
	bh=Yn2yEBtra09Ir3/UxmHzHveEsKYDZGHGznbzeTkY1gY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJdTWptggb2ybQAvn/GQ4BgbNXDXyNoRWffhpyLyD8w7/wZmKaOHF2yn9kVsnM3+SpDblTQLYX2WLguxx3ZGEGPNxn/S2G2gk0LAXZsKYUN9FA5udp2G+X7LhaauPskcsytIN5He/7oJiH8VV8Z3ZegXGEzBl48KiFbvSqxQbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA4ncuz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA4ncuz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04171F000E9;
	Mon,  3 Aug 2026 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785789644;
	bh=HM9ru6MgMQy5FUIFlCqbnGPIi6Yv2UFXKOdYqWZFT80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HA4ncuz83HA5/BybQICsiewNc+IFusoCZl7X7AzKap3vdrJa/xR9fOvMci+88dsh+
	 ApawJbUqKemH4B1UqTmfRGJ1a5sQaqTaAHn+KAoe+pj9R3hqyhqu61L4OYd+XswE+Z
	 cHVk4KKuwNh1+fFz36Nj8K/gc02FU6KyrSK1AZVZzRDQCWjZn9u0eieHwnhU1gJ1WF
	 NfbVd2z+gLf3OBRdAqf9dmWUoCLxv1RxiaQJaulGbiybmUqGw+P6GCqiBb5ywVQoMm
	 kaF+pzMgB9OlqCIYL6scGAYVq3UHNtgAUO3BrR93Q+OHOXpEv16iN0dOkXnAJ0ApiN
	 6gQYP+iSbbahg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BB392445D;
	Mon,  3 Aug 2026 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ngbe: correct misleading interrupt comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178578960589.2824945.3371991947877757922.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 20:40:05 +0000
References: <147244C2750FF990+20260730065409.50807-1-jiawenwu@trustnetic.com>
In-Reply-To: <147244C2750FF990+20260730065409.50807-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 joe@dama.to, arend.vanspriel@broadcom.com, u.kleine-koenig@baylibre.com,
 weirongguang@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 14:54:09 +0800 you wrote:
> In ngbe_irq_enable(), the code subsequently calls wx_intr_enable() to
> enable interrupts. However, the preceding comment incorrectly stated
> "mask interrupt", which means disabling or blocking interrupts.
> 
> This patch corrects the comment to "unmask interrupt" to accurately
> reflect the actual behavior of the code. No functional changes are
> introduced.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ngbe: correct misleading interrupt comment
    https://git.kernel.org/netdev/net-next/c/d661abdc30c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



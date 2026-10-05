Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3303403AFB;
	Mon,  5 Oct 2026 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240608; cv=none; b=XRH5pWWHEg03WCLYPT4bH7ccp1nQ9Lu1nnroZLhDwwsXNlGbAXV54fSoGJxyceLMAUMFZfFeA1rGx5KS2+aOEgtOTxB35biuaaUNH6PRg/d47FbJz4+mrS1l6Ro/78UIpAHiRLd+Nx6hiwmz5FwArjZLJUqp4QAiFRpP6Gpbh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240608; c=relaxed/simple;
	bh=obumHIxCRzE8M7NlQiLn+Sp0atTGG2qaUGiSZ7AbvIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ae3lynXbB2yBQMsa1FHwtGPRkxzs6lKWMhTvklimeeEfy8n3T95ct5+OgVwQPgcj99iQF0v/ziloU8jzi1MKveEhEXY2gX7IVRVMUFjZXwannIFfIXjTDqiTLfXI9pPEQaMam2HEAL9DZ/4PjGkF+Jdy+JkDY4LiAZkKfK/8ddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOXGXeWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOXGXeWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B61F00893;
	Mon,  5 Oct 2026 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240606;
	bh=FN9wJFMFgdkD8CUh9pfquPqVho9UUrHIcx8HlymlWXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KOXGXeWfaozqzbDMgoFwHebWj05aVKSkHaAuQgvCu8idsN+TWxXE+C9THj9mlD598
	 +0A+I6/+8adC+HEtGoLbDIsuspZQoV8W+ksZoHNNVfFI8bUh1nW9GB5VktgJDL/Mah
	 VE7JWYNTN7JAHWZFwsNN5BAsKYT24Ggrz49S/JicFnJy6dEtilKflglRJIxU3i34bO
	 UIL4bMWppxSpjEWUe0cHlFHEThXT1k0XicAEWr4lHuJ1bU+tzEXSL9yTk426GlAkM8
	 hjg2wxK8OFTBbBx8XOm3BigA5mFdddSuXksyzt6gzRF5bgvZSRJSQvZ8NPcid1mzVY
	 SxNyUXWpRzSjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772F73926677;
	Mon,  5 Oct 2026 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: Disable unsolicited checksum insertion for
 AF_XDP TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124060528.1926729.1824950688409199711.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 22:50:05 +0000
References: <20260929121032.20835-1-jszhang@kernel.org>
In-Reply-To: <20260929121032.20835-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 20:10:32 +0800 you wrote:
> stmmac enables TX checksum insertion for every AF_XDP packet on queues
> that support it. The driver does not implement tmo_request_checksum(), so
> it enables the offload regardless of whether the application requested it
> and ignores the requested checksum offsets.
> 
> Disable checksum insertion in the AF_XDP TX path. Applications must supply
> complete checksums until the driver can honor AF_XDP checksum metadata.
> 
> [...]

Here is the summary with links:
  - net: stmmac: Disable unsolicited checksum insertion for AF_XDP TX
    https://git.kernel.org/netdev/net-next/c/ecf5985006dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69523B61B;
	Tue, 24 Feb 2026 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896603; cv=none; b=WZdaAw3v/+V9cGyngk4WLwjkXxm2FWTTYX0Rxxr0NnpI36ysGWx5ncMyz6AWFCYpoEZGCXZlfqvvaqTC8+72T4PYYgNkrev9NiW6iN6jVojh3Y3xonWr19OfRDPg3pdrt5hbY7bkn0p1oFsVxduCvV5aJVdG6RWJkUlvQ8qBWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896603; c=relaxed/simple;
	bh=JImHr/j8gVhgyf01mszCuGEkilaOKkIy4VPTZXn73Pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxNkBcCtv/mUQSbz05w2Mz44HuSZ2jle7ibanKVjUw5i+mAHK6EbkdGHKXuYmjBjL4UfCIV+7ojKhQjHOdHmRwTTvldi5ma/OHlqYSST7ShHkLDv/33bSTEI+nAoNDYoox0oEG2bi8MfUNq4XPWdcbH/GE37GkwmqvmqkJDCBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsMUHX39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsMUHX39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C0EC116C6;
	Tue, 24 Feb 2026 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771896603;
	bh=JImHr/j8gVhgyf01mszCuGEkilaOKkIy4VPTZXn73Pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gsMUHX39lojDHn+BVov3PaEhdcbi7FnxFI/SwDk/KbREqjeI9kRi1L1WaJ6oHHlI3
	 hK1VktAW/WLOWJTyIEX6+2QD8X3EHTQG4l63W7St9qAlWsb6kvJLWuqm+741t5M7pz
	 ACg6YjUi6BXz2lW85vOQ1LBzN928Y5u+MjOrr3sqqlQqGfz+wFIPhypaN/uKJEiqqH
	 Fl7M+HnreatmHb5o3D7Y5vz39uRGFdjpKYJvCPoPK7FlYIWvcbkp1tj05b/9dicVIM
	 DFPv/NLqG3OLS6GrEQ47oC9lFaTa/am8ugQCKL8yh1SlZFTpXX/bR/r4lqzZ9ZWEDU
	 wzLKGuK/WDTUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA06D3808200;
	Tue, 24 Feb 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189660930.3265070.13817796502597457271.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:30:09 +0000
References: <20260220215324.1631350-1-joshwash@google.com>
In-Reply-To: <20260220215324.1631350-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, pkaligineedi@google.com, rushilg@google.com,
 bcf@google.com, linux-kernel@vger.kernel.org, nktgrg@google.com,
 stable@vger.kernel.org, jordanrhee@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 13:53:24 -0800 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> In DQ-QPL mode, gve_tx_clean_pending_packets() incorrectly uses the RDA
> buffer cleanup path. It iterates num_bufs times and attempts to unmap
> entries in the dma array.
> 
> This leads to two issues:
> 1. The dma array shares storage with tx_qpl_buf_ids (union).
>  Interpreting buffer IDs as DMA addresses results in attempting to
>  unmap incorrect memory locations.
> 2. num_bufs in QPL mode (counting 2K chunks) can significantly exceed
>  the size of the dma array, causing out-of-bounds access warnings
> (trace below is how we noticed this issue).
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: fix incorrect buffer cleanup in gve_tx_clean_pending_packets for QPL
    https://git.kernel.org/netdev/net/c/fb868db5f4bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



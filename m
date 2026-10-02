Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B646328B71
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904013; cv=none; b=ZOwcoAGBllCfhl7ee7aRdu3crSGa0BGdRN7CF/8S7PZ3MsNcb6ZwfJdYWYpTCzJqPLnfMfrN5uOF4vH2BVUkXBIN+esHcez3w7ecCNBEnDzBEt+28yYO4G7pte8IugareakvjVJmhVHCCw0BdJZe0TsR/8b2B+Dw9HOoR7vl9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904013; c=relaxed/simple;
	bh=KF6FheBITdRP5JXwk9RCKcUQDW7O9/1fn2a2x8vTmjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4DKl33VIfB6u3MaGt0NoW5DYmL8gqM5z62BK4d7bdhh3Dui2Wfb+3F2aKebzF+5NoJD/sVqmtBR9yhzXSlCwq2HZpxTyjBomwCvD9j/ClqpQ3WEylmHmE6xON8Mlbc0bxDcHHlfhK4CRoevg+WSrsgbU6P4b2ZmawYek49OKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTueGeoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTueGeoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8046F1F00893;
	Fri,  2 Oct 2026 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790904011;
	bh=c6yjNQ5/+fJXUkS7y/xY1f0Ae6g9MwFxy+YKQTIcKuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kTueGeoBad7U5RwVlLt4JNGl/h5b4rmh6n9S0ItD8ADFnOprH7VWfQmHsTG3jPOL0
	 m/K5u/r5//qBOg/asBmWcGo1e+EutSSEmAeCDzNUMQty42p6pXG/8APusavamtEjGz
	 khObBy0MdkPPT7TOdQzmM7ttdEUzF3P3VU0a/kTn7vLK3RiVzUQ9KKpqToNhVvOqlS
	 5cbmAI/l/DScfDmES/7NypKlUKGNZJX747qV8WhzYYu5miHLHE2LyITm/Doh1sHd5h
	 Jw5exxZXCcueBlxep2n2TFTXecSHZY/qEblxdW7Lp08Jkx0FQ1gaVZ5OYF/6qF/eZ8
	 MxJvm4FjX1/Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7748A381197C;
	Fri,  2 Oct 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [next-next PATCH v2 0/2] eth: fbnic: Update BMC MAC address
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090401002.3168550.17513563940881597735.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 01:20:10 +0000
References: 
 <179061185153.414394.13396934246780284806.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179061185153.414394.13396934246780284806.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 09:12:00 -0700 you wrote:
> Update the handling of BMC MAC addresses on fbnic, and in the process also
> address several issues identified with the changes. This patch series
> consists of 2 patches.
> 
> The first patch addresses issues found in the bmc_present and
> bmc_tcam_reinit handling. It started out addressing the fact that present
> w/o a MAC address was flagged as an invalid message. However, we ended up
> also addressing a potential race in that setting bmc_present and
> need_bmc_tcam_reinit could potentially race against the bmc_rpc_check. To
> address that the bit flags were moved to a state bitmap and are now handled
> via the test_and_clear_bit and assign_bit operations.
> 
> [...]

Here is the summary with links:
  - [next-next,v2,1/2] fbnic: Rework the BMC state pulled from the capabilities message
    https://git.kernel.org/netdev/net-next/c/d261a371e3b7
  - [next-next,v2,2/2] fbnic: Remove BMC routing rules when the BMC channel is disabled
    https://git.kernel.org/netdev/net-next/c/db99b6fae21c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



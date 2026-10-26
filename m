Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056206;
	b=AJxd2f+p0J5J6Zm/8GqsGC3X5527qheFSINRzKv/Gms2eu+BdOsYbYOJbPKnhdqnyQ8B
	 848YeqihaZcS96VYlzAK3W8JA2DZaaaXTT7cOmuzvLVsFvESyzRxEqPVZhfjmWDt73cBn
	 SK8ZUu714Bpy1CrGsEg2w3a4K2N7ITbfEJ6caS/2ooefhyO3IP/0HfE78aUF+hcZalqL0
	 kr+N0mKB0EQK4VU+RZAuXxDTFD07AcRTB2imZayQSQnRoaOiXuQFnnqbuXCG/PHi7rX4M
	 DRR9GuKOTQh3W52EzoYyTJ1qWc7z8WHZwDPgySWIiM5PKncsTdE92VOzlaIDbgQWE2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8BIpdA/wDgue8dy77oW+PBKLiAzenjqRF/ndzkLXS4k=;
	b=jvFb0GU4nGr7GiqJ/MCjPipAwd9xW3G9Q1iaIh+ZjWoK1qE1U3kJMJyWhLY20wMkxb1j
	 HAWxRbF4weWafQKXFC67XdT8RdYECvjAZoc7qDfXg2o3V9hc8EWH9gDI8yN9UmfsgQ5Zd
	 Jok5Q4A9GhoEr2B0EdR7X5gwew6qsCvndi6DeexYVA+Zl/vdgRSAiq4mltKeh+hEbaJK6
	 ZAv2o82Nae/+O8az70djCZVAmLMG846KmwpWVKNKNeitYdL6zZrnf14Un4iH7OiewHwWJ
	 SmnObupzEj7nSmYJ8BQ6a5KTocqTtdS5pBMShZpD6y+ryJU9iPoL36ytRF0XWm4xghA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar3YETeU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9381606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar3YETeU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9181F01825;
	Mon, 26 Oct 2026 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056205;
	bh=8BIpdA/wDgue8dy77oW+PBKLiAzenjqRF/ndzkLXS4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ar3YETeU/xVyH7bEH8JW7U0gm2nSQxCpMaHMwx57uXRRAXVWi7neXzi2Vhxd/QCxL
	 gEuSQ1MjEk97wKqJ32RdtKuA42Aa7ixm1we8yEwLsk9YJVjnPG32unx53xOYwsRSmU
	 Yaa9FApEUjcsmm06aMgD4ayWSBzQLk7hSfjpjBVHSLhoN8NypraQLBPyh8p0q1SP+f
	 r6zmDExgOTqUatdwmWOBl1BnLp1ypuMlikk/C1bdX5WLVdo2hpjnDf765VHKemj6o5
	 VdaGtqSEU25o3b3+OZ8NAyIt5NKgEa50DrYR0PWVedz/6+9nJ6aj28Dhcsk4mqia9z
	 ENk0MM2ZPJihQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815873AA80F0;
	Mon, 26 Oct 2026 23:10:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net/sched: gred: keep the qdisc lock while updating
 the
 table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305620432.3447040.15713481915535528978.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:10:04 +0000
References: <20261021155434.66572-1-phx0fer@gmail.com>
In-Reply-To: <20261021155434.66572-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 23:54:33 +0800 you wrote:
> gred_change_table_def() publishes table->DPs/def/red_flags under
> sch_tree_lock(), drops the lock, and then keeps writing state the
> datapath reads without it:
> 
>   - gred_enable_rio_mode()/gred_disable_rio_mode()/gred_disable_wred_mode()
>     set/clear table->flags;
>   - the red_flags_changed loop writes table->tab[i]->red_flags;
>   - the shadowed-VQ loop frees table->tab[i] and clears the slot.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: gred: keep the qdisc lock while updating the table
    https://git.kernel.org/netdev/net/c/306f788134a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



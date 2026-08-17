Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96A47140C;
	Mon, 17 Aug 2026 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001057; cv=none; b=cuuWk38Z2BA7h9Gqg4kgWRxOQ1gCNJYe9x8MHO03BKwimJ37CywKrJUuJLLcnvclOTkDhHxN9FyXfimBL3pTutIEoapTJKzFPef3aBkK6lwo4oT0ioqgSsIueQTLaDjIc79cs/6gSPXXf02B6pPtG5bYAM/7vPk9RmWzz+0GkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001057; c=relaxed/simple;
	bh=3ZIOr9ryOuybNiOdmEhxdlvtAC93eoavzr7vTkiyYoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OWh/1NzimXfzUoephcXnjnRrmcMmEJAkAitX0YAhL3XCB8YnptxCMqp9cHA9H9ujtje94HkRXvDn3tXlZjTzRtx+4Egp857Sl9iMkzCCsRUlf3Uv94wpNY6F+k2aqoih81wlBu/Fa+wnAh/dzJDalraUft0BlJq21i2V7PfloAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0wlcLcf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0wlcLcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6821F00A3D;
	Mon, 17 Aug 2026 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001056;
	bh=fIrzngXQlBq+RnMoyY+Mh0sQWAVH5ZSCaIb8DfdjtOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m0wlcLcfcGuQChD2hOPvzXDUOH7/9oC58SXLL9oB3qavS17MKmxuEaykdIYP/ByR3
	 UtgJ5MmcxZWN3al9rDhkHPWTZX0c50WsgvmrPwc8ncm9iF8uc4oH0ZCKT+Lxvuz/JU
	 gJhosj83KL34ou8mPq2pmY7MmqImzszV2/TzlNED3lzY8z+CrDfBFzzxfiDJlPMkj0
	 /XYaswrbyW7QLW8TjVkLQjATm0VdxdzpGp8U73xya+zZGaZ4CIygkPtvKLbSc8dAf7
	 JOYZMwbFTqdddq1OJwHjeXxUmCZ/hbAVbsPOO/OL46r6kiTlcw5E8SnyBKclD5sa3O
	 59T5PiD1m3OCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939423926265;
	Mon, 17 Aug 2026 21:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: free learned nodes on device setup failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700100816.1739106.8675748817726006578.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 21:10:08 +0000
References: <20260808110814.1637-1-xiexinet@gmail.com>
In-Reply-To: <20260808110814.1637-1-xiexinet@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com,
 fmaurer@redhat.com, luka.gejak@linux.dev, kexinsun@smail.nju.edu.cn,
 arvid.brodin@alten.se, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  8 Aug 2026 13:08:14 +0200 you wrote:
> hsr_dev_finalize() can fail after a lower-device RX handler has
> already been registered (slave A is added before the failable slave B
> and interlink adds). RX handlers run in softirq regardless of the
> master's state, so frames received in that window can learn dynamic
> nodes into node_db, and the error unwind never releases them.
> 
> Free both owned dynamic databases in the unwind, mirroring
> hsr_dellink(). proxy_node_db is provably empty on every current error
> exit (only interlink RX feeds it, and the interlink add is the last
> failable step) and is freed for symmetry. The order is safe:
> hsr_del_port() unregisters each RX handler with synchronize_net()
> before hsr_del_nodes() runs, which removes remaining entries with
> list_del_rcu() and defers their release with call_rcu() for readers
> already under RCU.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: free learned nodes on device setup failure
    https://git.kernel.org/netdev/net/c/7f16289b91eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



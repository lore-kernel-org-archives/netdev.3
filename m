Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FB346A1C;
	Tue,  9 Jun 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970412; cv=none; b=FPMS7n4SSu21VWhnJEXS3Bh/3O1JKEY+bG06HtvKNYgPYURrywHSTxV6bsBD/0Hwnk3Fd4obAt4uOI17KkhgnDuofdw1d2gAgxV05QeLB2UYHGNmtLUQcv0sx5UY2rRYnmqVotr9WVBOGAANwilh7CFPu+Eu1Bi/iogQtR/rRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970412; c=relaxed/simple;
	bh=KESPk0QeYpFFH9I9A1lE4B63HdkTTM/pgWzw9ZAdF1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ClYnsZVxaCbe11Dgb+OKCVOFaSG6A786/5pVAnKWUl2VBzTDSPPaZEnnhX7OsueBxHo+twi56hUhl9elYbwxUgk/eJZ0I4JriC1M48+Z3Y+bz+S/9zaPEMVsPYMXT/COR7BGaJdQMF84lCi8D06ZX+5jZVevxUfBXhmwdDxzMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKa0IqxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKa0IqxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9171F00893;
	Tue,  9 Jun 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970411;
	bh=HFAYLzKQKH47om5PVR13EZ5CvS9CvmSNS1aRsyzyMEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hKa0IqxF9V85paARbeibuJc7gIOOeTO1xVzEY+2LDlGmw4iZtwg42J4mdhwowsARN
	 AcN4oo9QNY88ni+12hRQnB3PYiLYFCWrAKVWMcQcMbyew8RAKHSwDAicQsRfPkVXRk
	 tsUPuOaiUIpbeXQBnwAi/VjmNY+kDiHWcIu/h+MmAfMdtQ35q351S54LZZc5kCVncF
	 eM4c6iicqIQbIPrUbrLCUBjjU+Jvw4VtA3aywRvbldZh7fidW10T+99yGJOiFM4N54
	 34LWbCVJvbfaeXdbK1G7AT4hCUTOpy3ucVMKCE4KOxjhHtNBIt74Gq01/vVYUBD20o
	 2Ig2zE15dG/UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0C3822D43;
	Tue,  9 Jun 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: qrtr: fix refcount saturation and potential UAF
 in
 qrtr_port_remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097040939.1753037.3386694182969051861.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:00:09 +0000
References: <20260604064801.1180388-1-w15303746062@163.com>
In-Reply-To: <20260604064801.1180388-1-w15303746062@163.com>
To: w15303746062 <w15303746062@163.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, luca@lucaweiss.eu,
 andersson@kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 25181214217@stu.xidian.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 14:48:01 +0800 you wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> In qrtr_port_remove(), the socket reference count is decremented via
> __sock_put() before the port is removed from the qrtr_ports XArray and
> before the RCU grace period elapses.
> 
> This breaks the fundamental RCU update paradigm. It exposes a race
> window where a concurrent RCU reader (such as qrtr_reset_ports() or
> qrtr_port_lookup()) can obtain a pointer to the socket from the XArray,
> and attempt to call sock_hold() on a socket whose reference count has
> already dropped to zero.
> 
> [...]

Here is the summary with links:
  - [v2] net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
    https://git.kernel.org/netdev/net/c/a2171131ecda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



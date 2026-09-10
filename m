Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326544C66A;
	Thu, 10 Sep 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037469; cv=none; b=fafS9h8aATv+RY+4UK+vIoh3jvIZRSGrwXbrxkUsLsCQhf3ZmXHf+xk2SbNw36zsKm/y0FLEhEIsvf3kl1zoIRJMgzYFkglW0Pds4JdT7gnNhlaTWr8BR0GFS0uZludcwibHcv90sHGTyCwr/eX/kqIQCI5QrY2xi0y30edPdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037469; c=relaxed/simple;
	bh=hcX/Wzh18B0xEvLUuC8996HuBXqQDPboMYJotPMXoqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LjwJpGkwhh8C6D/ZQZEJ/NIPlR+CFOnVhf9qh8/VPumRtdmpZGUcfkKcma1j1+ij+zF5/7jY7IT37FkAxdujvFpl2fqDBBsIWDPjfbPJsapzik94hJP8F+JOp3LObPhD4FTBl0kMwdItfRmX4qtNYjxgcNTPYkYcmKPoeYoDS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2DrKoTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2DrKoTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C337B1F000FF;
	Thu, 10 Sep 2026 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037465;
	bh=5GjY0j/R6ED7lm0xHq/P65B2El2rJF5CCY1sHN0I2xU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T2DrKoTo5KXJMJRMc3BTrTWWTw7Umkc7OqWzZuesU0zOYyXQPXKn3YyPvCxYQzr8a
	 dKuWuTyr8ddSMsfBqH+UwqRC6nsXY6/l4lt3PcdkV753wBxbCapbfBPO8QhPudK2hD
	 vjF4NP7kuZ2NDVn5kbj7/n41A1hbWrx2TWkM0zYTKBc7hdBDvS91iz0fku4QOKg9sL
	 JOOzWBiieVSJuKvEqa1hE2HQAmqAO9jEjqIuU/t0MPoccPG2bHfUINT8c3gawFUnW4
	 leeCf1ckn3nWA1FAsdfUlplS/ngjvl9nSVCWXFD+2G1OtsXfMhYVPpx538sSBkhCgU
	 BxA7dO4RCkfaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A5380CFEB;
	Thu, 10 Sep 2026 10:50:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: hinic: fix mailbox segment buffer overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178903740339.1353310.14983402122262555236.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 10:50:03 +0000
References: 
 <AS8P251MB0001AE870B09020B46B5D7DBC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P251MB0001AE870B09020B46B5D7DBC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: cai.huoqing@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Sep 2026 02:42:34 +0000 you wrote:
> check_mbox_seq_id_and_seg_len() validates that seq_id does not
> exceed SEQ_ID_MAX_VAL (42) and seg_len does not exceed
> MBOX_SEG_LEN (48).  However, this allows the last segment
> (seq_id=42) to carry a full 48-byte payload, writing to offset
> 42*48=2016 for 48 bytes (ending at byte 2064).  The receive
> buffer is only MBOX_MAX_BUF_SZ (2048) bytes, resulting in a
> 16-byte heap buffer overflow.
> 
> [...]

Here is the summary with links:
  - net: hinic: fix mailbox segment buffer overflow
    https://git.kernel.org/netdev/net/c/5d4d98595743

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



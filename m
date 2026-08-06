Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE761A682F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976247; cv=none; b=cXkfgQpFX8z68LWMyyxnw9xnX8CEU3LyxEjNCbr5gT32XTAn2KiQZ/3LEEV3XMi40AQMb/aamovJteNQ5y8IH/DwCN2fGLjlPDPO4UcP/1sLtRXuo4NIDz4QwGk9BMNFqNh7jSxzx5WjlfDDKnnaaJlW8JAOLFLJNI4Te981sTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976247; c=relaxed/simple;
	bh=bB+rfGU9k52jfDU4379T6fhk2hOpOTi3izCxXjzmfms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DavgJftaHPf+iPBBxxKf4P1bc9VOc0AuTtZs20K2FKHAf7ibZUw/xt5GWNQgwZ0ss6SGevqMmnmoj2AX75SZVOGrSU12CJv7aBw1xFNmvxr6k+6GLTiSC6YtpyR8S+S1XVw5mfQYiZNZpG+fj4R/FUaPOvO7VEOKa83imo39Hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB71H5/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB71H5/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86D51F000E9;
	Thu,  6 Aug 2026 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976245;
	bh=780sIrNn7R2dsgQ6LHQMvmn3M55uxuh8uCBujWQ3EgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NB71H5/qqk7ulPyx+UdxB1WfOLgXkWmI53E13Z8bIQS2rE35qZOI2/9nzrACuugfs
	 mTc4E2JAL0iz0YlP7OUJPAhzmovmQ6KWfhhMQvc9XyZJySUvLojV/jNurFeX7gl03I
	 cDDNiAt0BZ+9z/mPz5UiU5Q5qy+JMZiIB5O4VSLJqvDcBqacF1MGgRDAtldSF3tp7B
	 Jc5KBPoNWlSzetEYDfN1wLjdlYuM3lfDXvcOb3G2fpEd/BvKTNVwzfdCR/6K2AT1+l
	 ikozHDCo2JX0XuLzYbeDayd4sFo8ftHFKDrX58ue3pUHSo4L5YCH5FBMZi9dYWdGHm
	 yvPSdk7vyVJAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A9B392FFD8;
	Thu,  6 Aug 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597620539.577272.4729655307092478580.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:30:05 +0000
References: <20260803043618.3210301-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260803043618.3210301-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: netdev@vger.kernel.org, sam@mendozajonas.com, fercerpav@gmail.com,
 joel@jms.id.au

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 12:36:18 +0800 you wrote:
> ncsi_send_cmd_nl() takes the number of bytes to copy from the
> attacker-controlled ncsi_pkt_hdr.length field of the in-band packet
> header, while the source buffer is the NCSI_ATTR_DATA netlink
> attribute whose readable size is nla_len() - sizeof(ncsi_pkt_hdr).
> The two length sources are never cross-checked: only
> nla_len() >= sizeof(struct ncsi_pkt_hdr) is enforced.
> 
> [...]

Here is the summary with links:
  - net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length
    https://git.kernel.org/netdev/net/c/afa58b738491

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



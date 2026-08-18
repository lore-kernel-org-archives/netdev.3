Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C8134CCF
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016055; cv=none; b=D7rcB77S5l/pBKWnJ0eWDjLTyNMDrxUyzDglId8P/chBQloXdiz1gDZBKb/trG0AkkkUZNzQyNuMZ/rcdqGDelZoqj8wqsvhVNrPRyDX++jmsAeIHI/jitVRTr1VtGmTxwIUo5U6oMNZktEdTpu+zwn7S6/xfkWqCR5/ch0tfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016055; c=relaxed/simple;
	bh=A39C6bBPwnsBR14IdvSlbxQvFEMMxot+81HXlFbOSX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jDPgukZpq/0Cmvid8M/vYXlKGjS4nWdlDGVrdXfJtOFiahcMVxKbUMvt1keN0SsFhsqbBT2h6xboWVP1cNwTEJ50pbSwykWrcrwy6eoum6olLC/iHmlbOKtUsGqlo0BGMKuycwBCeudv2DHmv/YE04Gcw0sSvCVQtEHReV6CJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euOFGddl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euOFGddl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A65D1F000E9;
	Tue, 18 Aug 2026 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016053;
	bh=JZnzfsfPU+0NRE/XEe2vNnPQcj5i/+x4Ahgmi9Sa6Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=euOFGddl23NcK5luPdvqszibXR0yZLc59omU3AVsweyq8Fuei6aZP6w0elnepm2i1
	 TdbNBKUcpfePM4KCmXJymeomDqU0dq6y+QlAzBYROSqD9Pn2SNXM4HCb/A62MDXPm1
	 jwrQR0j/lrGF+ihJVTei1mEf37d0FncLUFJrpvxmOx9B6FJBH8CKIaE64GnFLHfZ7k
	 1kTxL0vmmS9QuPqtrWDAPmFgyzsTRjN6M3FLNwP8q/D9BGtvGmJENOYCqHK+Z8+807
	 wsxpjXKsoEvl9RKlFPNZPu+Fq3a+5KD5gcI76D120FbnSBikWcMA+Y2qQLVKtFTzzf
	 DAtoFBZJHu9Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C923926279;
	Tue, 18 Aug 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tls: fix RX desync on overlapping skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701600540.1817778.12632713486409028409.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 01:20:05 +0000
References: <20260813121337.3300688-1-maxbr@linux.ibm.com>
In-Reply-To: <20260813121337.3300688-1-maxbr@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, svens@linux.ibm.com,
 brueckner@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 14:09:44 +0200 you wrote:
> The TCP receive queue can hold adjacent skbs whose sequence ranges
> overlap. The tls fast-path reads the record header with skb_copy_bits()
> by byte offset, which assumes skbs do not overlap, so a header split
> across the overlap is misread and the connection aborts
> (-EMSGSIZE/-EINVAL). tls_strp_check_queue_ok() detects such overlaps but
> only ran after the header was parsed, never covering the header itself.
> 
> [...]

Here is the summary with links:
  - [net,v2] tls: fix RX desync on overlapping skbs
    https://git.kernel.org/netdev/net/c/9466ef3ec972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



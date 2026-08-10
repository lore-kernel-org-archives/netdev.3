Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E872877C3;
	Mon, 10 Aug 2026 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404688; cv=none; b=LGbbblsBh8TVORDWtT0LaayRSDNuG3M778a6e7IWaN0SB+X4TFvABZ525KhtctPraBoM7U11OjZkTviQ6efm0gXObVFZMxVW6yE8Z4RVvkAmYkCimKgVZ+rG5Te6LY4eenvGtpA/DpA30YzSSlON1zKAMki7P3OoixEmeL4XdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404688; c=relaxed/simple;
	bh=In/z93l5IXG90SUxrU93rlsvLaIb0JfBG+J3Q4KZbm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNh5iVU8Od46aaAItulDnLN9O9N0wBOxowilrzBw3khfRmEpFNdr8cv7lgK2eN5rkfsNAHMZWHYXihMJn574cWLF1D7uPl2tjsMn1S3AKFo2G7PStSaK+TDc5KiY6LbpM/FNBkhCT/wObiSynTh+LR4lRGw91jCu7UC4RRNMyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e27rjdD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e27rjdD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16EE1F000E9;
	Mon, 10 Aug 2026 23:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404686;
	bh=XtD6jRe0JNx/lSspmAA7VRMMoMs3mfWDzUfiDwItiUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e27rjdD4+rE82sbbbs2HdQ5dOO1WeK4K9N7Ogg/dB9vGCGfoRev1/fAek7kTOaERM
	 8x4q16M1eGjRj+4Al2RH5xi7+8evr+YX6nbSSrjHBrhKkvJnl1h+Q0bPMLl2i/eN8i
	 5PwHFJZYX8OyCFD5hQjCsEGjKfrWa0IzJgcDD9AyJptKTXIDLxjwO1n6vIQ5E2VuIU
	 7wUrS/oKgQaqs11UvFs+763QpxJBrAKLfkVGR5oj2fx7pbEbgOvJZvWOWKUmuBADQ+
	 +9dEUMp+h2MLelznFCW81x+U/+iSxTIGmJOHHrXribsRCV3jDnPbNdVeshFN79dY8o
	 LFPO8N+IqoCzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93986392626C;
	Mon, 10 Aug 2026 23:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] keys,
 dns: Drop unused NUL terminator from upayload->data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640464339.252892.10493634079145220840.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:30:43 +0000
References: <20260806200454.245444-3-thorsten.blum@linux.dev>
In-Reply-To: <20260806200454.245444-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tim.bird@sony.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 22:04:54 +0200 you wrote:
> upayload->data includes an extra NUL terminator even though it is never
> used as a C string. In-tree users access only the first
> upayload->datalen bytes.
> 
> Remove the redundant NUL terminator and allocate one byte less for
> upayload->data in dns_resolver_preparse().
> 
> [...]

Here is the summary with links:
  - [net-next,v4] keys, dns: Drop unused NUL terminator from upayload->data
    https://git.kernel.org/netdev/net-next/c/f1529936c0b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



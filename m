Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA2274FE3;
	Fri, 18 Sep 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698675; cv=none; b=QzLAAVSKY4PRK2bFadE04cgUqYKDwEACPSqmoMuNWTQ1Lp+0UBJCfZemBqvLuMq3Fh2G0bZHtu5yEjcl1YVDvGYd2h65gb8e22piBGUJBBM7Q9L/samosUba8fuD3LU/UspGf4y7B2q/hOb9+ZnnZJCmM1Iu8kfa7VyN/lSD9bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698675; c=relaxed/simple;
	bh=gGuZcpFkN8iV7wK0XE6yFOLGViBFy5OeY1cUbrexNJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J+3hNjLuwonw9cW6n5oM6g+9tBTIIHzvPlTk/VEvaG2mkK5/JWFLnXgltNwyZnUaSXHCVbv0fOQ5Yaiv0YB/OJ+uht6D+fm44G/zVYTsfufZDQDZ7LzgJejiJNOcJRXdBzcCIQ9X3/jhTjWkFjy7bHR1yk5G+pnrCGgy9nSUj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYncmO1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYncmO1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5281F00893;
	Fri, 18 Sep 2026 02:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789698670;
	bh=nnuDwb7ieaArIudOF1zZaOxpidCwiEEJUj9MbgAN8t8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aYncmO1CJ2+gdksxu+fEqo3j9RIC0Lt4djIKO+Ih/vjisFc2fX2CsV16dRfSDbWbU
	 Ht7K8nMcLCUWjOqeOOEXp8o7AFc3CXdFsV/EzinOkwwoBbvD+Q2vcE42e+TFOzQ+pb
	 WVZqmRa/e2t1Z0F1ea2gdPFHsO6AOXoXPIE8T5BG4GDhtCXZQroXvAOfSlScVVIyeJ
	 KHp8LxZwbRNrkEBNTyS5RGMHyeSeu0E9vRfLSvVL7Q8CjEAJdLwkvdJU3d4agrert9
	 wFR13xZMWBPFU7upx3/tWmViJYAuE89R3G+QRigtl5Lt2/DKUbYrRMyUiS/JW9ZPUV
	 98XrGWvd1sSYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB4380820D;
	Fri, 18 Sep 2026 02:30:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] tipc: replace deprecated strcpy with strscpy
 in
 tipc_bearer_get_name()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969860364.236125.4397809874433283947.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 02:30:03 +0000
References: <20260915145641.2434403-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260915145641.2434403-1-ajithpv.linux@gmail.com>
To: Ajith Parappalliyalil Venugopal <ajithpv.linux@gmail.com>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 14:56:41 +0000 you wrote:
> The `strcpy()` function is deprecated and moving towards code-tree
> elimination. Replacing it with `strscpy()` fixes potential buffer
> overflow vectors by ensuring safe NULL-termination based on the
> destination buffer size limit [1][2].
> 
> To make the interface safer and more robust for future callers, refactor
> `tipc_bearer_get_name()` to accept a destination buffer length parameter.
> Replace `strcpy()` with `strscpy()` and pass through any potential
> `-E2BIG` truncation error code up to the caller. Update the existing
> caller in `net/tipc/monitor.c` to pass its array size.
> 
> [...]

Here is the summary with links:
  - [net-next,v6] tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()
    https://git.kernel.org/netdev/net-next/c/4bb9710c6a68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



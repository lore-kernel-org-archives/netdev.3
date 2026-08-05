Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020530F55F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892858; cv=none; b=p4gL9FHpCKmSrbBnbKYJV9Blj1nNJ/F7vILExfs6Sf41AGN6fh1mHfbaihPWFsx/H4+IZE3hFDGbVmhceB2A59DlnPXLwSOUt7ho5YmgfhqLkdeYCZO2UqwzuunVxIyotqqoDoJDLjHpq6WvaDQIreYCkZQRs2vZm7NRfvxdHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892858; c=relaxed/simple;
	bh=+Rh+JypfXdCnP7jf5pLwuFyCLWUBr+FDKsdxcSX8dSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSlKEb1oeC6H+aaFeQeNXN3v1SH+UzIZQebxJdJCxgmAEk3sOckh2j8cBwS6c7FtaQItzI37YPiH5vWN559Rlp5YfSrb4fCDmdPq7SUBGuZPOX1Z0ARsjG3k4L/m2VmGisJaVjiiJfjBy5Q4xzoaSP31zKXO+zMtxxLKNAT/Abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfDwoKUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfDwoKUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F4E1F000E9;
	Wed,  5 Aug 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892857;
	bh=KBorOO60tthNgCMvKA7AkvPAUqQirDICF1AJXiSNB+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hfDwoKUaR0XKZ4FFpUnt/ljb7cBnoFqVpnYkekzt1JfVZalXSo9DTQuAB4Ujcr0L5
	 vR4rt1XbWeOU3ONTrZW9Uampmr38lt6OxhHLQ/A5AE0uz/Uwc1B8vw0dtJGVDqUF9n
	 pqRbWGMu401jYzLetEdVEdDiB0mmYOBexfcyVdDXIZzE+V+mstPckGpdxqGL1vW/vY
	 86YHQRUctWoIsHXogotCwricyjcNipTU9+RM58wjvHDx1VULpYGeNH6XxumTL2uqhJ
	 /Ll8QxXxfvmR/ivlnn1SuTnmMbfR4PyqvajNNqTBq9qjKCr6uWeMd8dBl15gmpZcxN
	 aqbJnOP/n7DLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A4A3926666;
	Wed,  5 Aug 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: use int for bnge_fix_rings_count() return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589281739.3863162.14624707410200751632.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:20:17 +0000
References: <20260801100923.1498570-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260801100923.1498570-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
 vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Aug 2026 03:09:20 -0700 you wrote:
> bnge_fix_rings_count() returns 0 on success or a negative errno on failure
> However, bnge_adjust_rings() stores its return value in a u16 variable,
> causing negative error codes such as -ENOMEM to be converted to a large
> positive value.
> 
> Use an int for the return code variable so that error values are
> preserved and propagated correctly.
> 
> [...]

Here is the summary with links:
  - [net] bnge: use int for bnge_fix_rings_count() return value
    https://git.kernel.org/netdev/net/c/2cbd8a4e5e09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



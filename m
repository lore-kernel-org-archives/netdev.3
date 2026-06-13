Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D803A6B77;
	Sat, 13 Jun 2026 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388613; cv=none; b=P6h9pQIFFQGZFzkzoGVLVf8uzWkumvblEDP6PStCHH2OwM4pRv9uG3o3rvwFFGQvCNSXS73UrYUHr/P6Vy7cRFU4Nbp8No1SWEV7+fFxQWcKuRJTzyvDhxdf/1ix1AhuCq/2AB4sjuwuNjLFg85uAVVoKWb4MU7SA+U8FKP5kFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388613; c=relaxed/simple;
	bh=qllnoP1ZEdDLJhsz2nA7rqtk/LdKtle/nr6qTDVT/Bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmmFpkbOHlkAFAkPGPQKkykEE+MT9ttNJnD5LmERYWI+GofEsF1C46XqYX+2zClq9d4XTSQmn0HILNLl3P4VA2sRJyXPmWoscAYts54V5JCHDr5WmOyt7DLp7Voxg2+O+hQ2tdKg6Ywlb8tbxH11TDENGKaylBPp20r5SXdcahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKxz/xqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKxz/xqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED091F000E9;
	Sat, 13 Jun 2026 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388612;
	bh=hbrn9gotVmDDFoxWO2TedVmUacu02FnXsSonAm4K1C8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DKxz/xqmY0fi+hiNrpWt55h8DBwnNSNZhbliKcfEdH6YiHUuUWdAnbdFeARuZufgJ
	 M4TYxEIkY6z39493/m/7AKXIQ7hb42dgPoygwbo55ppazCtWmMI9kDAEzflT0cqoKm
	 ho8JRkhDfdkC3Ob6VIGm6+SEKmfJPIlMS6S8GmPmowuutCD9zYYo2XCuPOv+Uj30mN
	 t3JXk9vdDNfU7fi9ydo1yrzOu3OE3VBkvZB9subx6Q/UIQEffOrryatFybP/lHfMcL
	 KWWTRSLiJ3DDv9uH+yLaC3APMyJdm/y+sWocoB7ujO9Cso2LIx+CWuiAEbqzbATdN3
	 z4S1les4eCvbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938B83A54A32;
	Sat, 13 Jun 2026 22:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix NPC mailbox codes in mbox.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138860813.1607522.9390359001132329665.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:10:08 +0000
References: <20260611083330.1652181-1-rkannoth@marvell.com>
In-Reply-To: <20260611083330.1652181-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sumang@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 14:03:30 +0530 you wrote:
> Several NPC mailbox command IDs in the 0x601x range were assigned out of
> order. Renumber and reorder the M() definitions so each opcode matches
> the stable contract expected by userspace tools and applications.
> 
> Fixes: 4e527f1e5c15 ("octeontx2-af: npc: cn20k: Add new mailboxes for CN20K silicon")
> Cc: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix NPC mailbox codes in mbox.h
    https://git.kernel.org/netdev/net/c/925551c944a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



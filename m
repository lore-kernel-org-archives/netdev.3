Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B136EAAB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280066; cv=none; b=cPRzIeeBlzChCqAMaceeKNJoXUtJECVskop35SLsOhtnLe6L4dPxwpPdNFft2WzNXqwiRcx7zkijT5VO3E/3vUeUfbQ2v5BEFE0pWs04LLkLWfEMxjtj1FvPnYT1fyLe12bB9qdEVdRRsxZjQH9jD5PaEaQQ/ALgrCFJ7/I7Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280066; c=relaxed/simple;
	bh=JOx+Gv79sX5VEO0Ez3PwfbrmHXwlk6I2pbtK5Ir8+mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a0cxoCiXCncBP3TzafOhjD67c+cWHOL5Tt8RnNX6OGTXzkezYqBm05wS59B3Fhx2GtiEN/oeVs694DyJpIZ7mOvY+njAXWzVsM7xU2X3oDfK21IDipzx/ga3zzKdq4jWyqSX7/MUY7Ta9ddegjk0scqIe+yAq4ezQk53kPY9qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4SMMbCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4SMMbCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA23C2BCB4;
	Fri,  8 May 2026 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280066;
	bh=JOx+Gv79sX5VEO0Ez3PwfbrmHXwlk6I2pbtK5Ir8+mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q4SMMbCwMb5VSpK2jYvJsXy5BrbNi9JhjKjUT4q505RxBQlJqguidro5EPN/jRjGz
	 Lf+4cNknkk9SW+djIAYAJVFyASYdHTAZvTj9Xi3knljQ8cHMVxVgVp9cNLgqJYPxCt
	 H9Upbu3tZH7iKwLPYvtqzZfIoyAdrMGfD5gbk7bMINzeSwtKTFBxA3byMEWDSWfP4m
	 m+WsMP/gyGvF//UBlvqTqu0aENBbhdiUNNOStzxI0e9Wb45rL1+4U5Lz2Aws9Oti8w
	 NPWkkC06HZI3AoHtwtpbtoIwUyE/biDdzWDR27Cf83/LDKPc5/U7hPodhrrU8BQf3x
	 h79fxM2JcK3qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB838119D3;
	Fri,  8 May 2026 22:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Drop pci_save_state() after
 pci_restore_state()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828001429.878212.2689311902325619728.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:40:14 +0000
References: 
 <39de1b025928d9a457976010b2324e7e99baa92a.1778158755.git.lukas@wunner.de>
In-Reply-To: 
 <39de1b025928d9a457976010b2324e7e99baa92a.1778158755.git.lukas@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vasundhara-v.volam@broadcom.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 May 2026 15:04:59 +0200 you wrote:
> Commit 383d89699c50 ("treewide: Drop pci_save_state() after
> pci_restore_state()") sought to purge all superfluous invocations of
> pci_save_state() from the tree.
> 
> Unfortunately the commit missed one invocation in the Broadcom
> NetXtreme-C/E driver.  Drop it.
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Drop pci_save_state() after pci_restore_state()
    https://git.kernel.org/netdev/net-next/c/04ae0d54c1b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



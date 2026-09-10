Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602937F330
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056678; cv=none; b=JW8sfE36feIVLPdxlwPZt2tcM3PomUidYcp8FWT51Ngqs5kRQUKzHmt0pHyX/a03bYzIx3LYMo0jUtxFXEdxpcqoyvV0Yg5cN6jNPdJ8KLr1973NVz0qpIVdh1MNbxNxnX+/8+IXaaI7Bt9USgnazhsookq7FgjbHXvVGh4A+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056678; c=relaxed/simple;
	bh=kLdsDNPmGksF6Ej2hPih03ONdsUMSeqzel+pmJpfreU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJ44OVUjb8D2L1sYp0033Q7HWmxXo/lqyQD2upkNF8VHBlqEoZzU3anZgzGLRpGqtcbEBNJ455yVTAUtfFeSxXD251rKEikikIo3CQWXNy2wd8yXuDnLXAXgKARZT2ihB/SsiSqaUAFY4W5cH1Nt4UeE0HxZuew3O+qJpI3NnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViwlKXpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViwlKXpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD451F000FF;
	Thu, 10 Sep 2026 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789056677;
	bh=hCMvK+BBYmQxsAlBvVQVAkt7qKb+CEF8PhFbR2eF8j4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ViwlKXpJsGE3IIaexApRZVvOvQS1sZrrulgO53VGuJi+zEr5/9rz2L4N1JsaEiHwA
	 KiUe5eGWOef1iP2XSp1XkYdauI/JO4XW0bM8d5a0g6+bmD8TvXXk/s6h9mwTqeFjSp
	 7T/RDhBQ7ey7Ru9b57ibxGIbmLmgx47Aphs47R6k1LG5m7Bl/VgB2sLMduYpV4nvqQ
	 /mWlerGz1TyhVYvDO9Txjz7BzN9tZGzPxUvKJ3ErAdPwxtUGwUk/NRT8RXwTh/tuY+
	 yllkGi4AV8e5f1w6Xucer8NN6hXfZWUikDyDjTr1z7SsYRyHC/FqX3cnIyHNRJ/GUO
	 YnpdxpEXoFX2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B91380CFFA;
	Thu, 10 Sep 2026 16:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2026-09-08 (idpf, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905661464.1519745.9773724483651279344.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 16:10:14 +0000
References: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 ae878000@gmail.com, mhun512@gmail.com, joshua.a.hay@intel.com,
 sridhar.samudrala@intel.com, milena.olech@intel.com,
 vadim.fedorenko@linux.dev, willemb@google.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  8 Sep 2026 14:44:55 -0700 you wrote:
> For idpf:
> Myeonghun Pak adds calls to disable DIM work and PTM to allow for proper
> cleanup.
> 
> Josh adds check, and adjustment, for VLAN headers when processing RSC
> packets.
> 
> [...]

Here is the summary with links:
  - [net,1/5] idpf: disable DIM work before freeing q_vectors
    https://git.kernel.org/netdev/net/c/7dd4c829bac2
  - [net,2/5] idpf: disable PTM on probe failure and on remove
    https://git.kernel.org/netdev/net/c/650f197d8ea6
  - [net,3/5] idpf: account for VLAN header when parsing RSC packet header
    https://git.kernel.org/netdev/net/c/cc6d60ef9227
  - [net,4/5] ice: add missing xa_destroy for sched_node_ids
    https://git.kernel.org/netdev/net/c/53432c4c3e86
  - [net,5/5] eth: ice: don't dereference pointers from TP_printk()
    https://git.kernel.org/netdev/net/c/b8bf9bfda5f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



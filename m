Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EE2C027C;
	Thu,  9 Apr 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749928; cv=none; b=auf+v1XDLfCCU5en4imluXUH7GX/0OF1MhzpnMTxqrcJX4E4PFW8oKHTGxAbO4TaH05FymySc/YIfqmNqHdUpQjSKgR883RLSxYOGqaYHaB6IXEQoEbZv2Inzd8J9tbGWdPyD19uPFOkSSZGcbivOxsbshXxfElyuRLj7s4JxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749928; c=relaxed/simple;
	bh=XUnp5KXSWx68sIpIEYzrg3KYEexlITMdS0Ff00KI95k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LpC2zLpi4JBteAEqgkklITMovvNqW9EWxg0BozkwT8/kVlKKEe3Hh8AqUOOt74Iuk7zlx7Sh+MXyaOWHeg8jAvEMRzdLpQOe0FJLDrkXDzrcz/S5MzhALcd5pCuQbpzyA/uybgl7rsS2xZV/F5FKioMJgU3kaJclrlRyKhzEMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riZz5TH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riZz5TH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA183C4CEF7;
	Thu,  9 Apr 2026 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749927;
	bh=XUnp5KXSWx68sIpIEYzrg3KYEexlITMdS0Ff00KI95k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=riZz5TH4+WW/JDo7DSk1mc+dkIHjWZIM6CbBD+VChOKfxz/cKGPKVMldgC2RkD6Fn
	 makr9yF+7lCLkuz7oDfUittdevGiqGXF39I6l17yZlL0Wg6kliQGsSVWcOX0eR7k75
	 JfQCnQb+kBnPmxqwCAkqr6OsjljIN1z449qMcbRE1Np4s6TF865wmPd69vVcd2y+lw
	 HIZMH7CENhI8wZ5J3TOyM1WBW5nP37/3WsX3oCHjW7VeB9lAns3KlXYy89BLWAckg7
	 jETvqSguzj4Uf3h5IX9kf/X2/bKcLiXdeTsbTjTxrOCdjNVySh4UZ5hjp2itj+rKzd
	 QfgpKYsd7Tscg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0C439308AD;
	Thu,  9 Apr 2026 15:51:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260409143217.456564-1-pabeni@redhat.com>
References: <20260409143217.456564-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260409143217.456564-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc8
X-PR-Tracked-Commit-Id: b4afe3fa76a88ee7d3d8802b43fde89aa02f8e0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a55f7f5f29b32c2c53cc291899cf9b0c25a07f7c
Message-Id: <177574990336.1627667.183796140525083179.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2026 15:51:43 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Apr 2026 16:32:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a55f7f5f29b32c2c53cc291899cf9b0c25a07f7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

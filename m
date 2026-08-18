Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B16282F01;
	Tue, 18 Aug 2026 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015476; cv=none; b=gtAMtkUvHT+mCLeKirg1Q3arhyMKH0zThH2PJ3NK783z/apY+w+dAC5NatnpCMqpXs1fEBjjeSosx+t0NSIj7HxxVYgV82jhIDsp40HAnng+bZo4yP3YyF3gW1s+/DqmBdomhy6R7HfXpKQzvgvNYhpEawMA9C4EGE3k1o3OpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015476; c=relaxed/simple;
	bh=Ttq5Mo+El/2+yDFw2peOzlYdNKBSQUe6szEAkOBZrs0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k8hO+n6IVs0mit8IMeSuhkDWn0GQMdnj0tbMO3kjub9yXcF+cr+nJ+QBRAxjRpnJTXSrKAOIlEODR3S3b0DM7mVKrAdENLRNd8vIA2bMuRimX8mCkIm8rsWG+HazRXTVAVI8dH5yyFBc0PiymFpVRb7H4ynMHiCw5fDlr+GWESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWlLt9hG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWlLt9hG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74AB1F000E9;
	Tue, 18 Aug 2026 01:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787015474;
	bh=w96S3DbB6ypEk6Hy821mNcZ/fshjEsIuCphF4mgm4rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GWlLt9hG2nxXJrn1IqJyOkqdkn534E8a/ZHY8tW0x1OzaFi+4q3ezf7PpiiRPF7IY
	 ZpXrSTckYjOB9yIY4Fvvguot9yWV1uFa9l1tJEtYFTFAjmtp4/QMFpu5+PDEzJRScZ
	 CYIhyQLDOlZeEDZ66TtUd+GhuqV3lGGNBuQRfKnRxKmHgjN/KMkR/lQXktly4J/Wme
	 PywW6YCZMS5NvVRE8vj3tgr9A6nVPaz805/pNE5gWQnigki4SIHPOfdbF2Tfw1WDdN
	 iol4EWotivMBcsG2DM90Llj94GvBxeWhRP7aTTNSfNUM5AORAtOIedDPVSrSIr7Z8+
	 7hRgI0Jji/Nrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E03926279;
	Tue, 18 Aug 2026 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 00/15][pull request] Introduce iXD driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701542689.1815375.5651927878332683260.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 01:10:26 +0000
References: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 larysa.zaremba@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, sridhar.samudrala@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, richardcochran@gmail.com,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 12 Aug 2026 14:25:14 -0700 you wrote:
> Larysa Zaremba says:
> 
> This patch series adds the iXD driver, which supports the Intel(R)
> Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> exposed by the same card. The reason for the separation is to be able
> to offload the control plane to the host different from where the data
> plane is running.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/15] virtchnl: move virtchnl and virtchnl2 headers to 'include/linux/net/intel'
    https://git.kernel.org/netdev/net-next/c/e44908175d50
  - [net-next,v8,02/15] libie: add PCI device initialization helpers to libie
    https://git.kernel.org/netdev/net-next/c/dbe9759c215a
  - [net-next,v8,03/15] libeth: allow to create fill queues without NAPI
    https://git.kernel.org/netdev/net-next/c/354c28830add
  - [net-next,v8,04/15] libie: add control queue support
    https://git.kernel.org/netdev/net-next/c/caed480f2991
  - [net-next,v8,05/15] libie: add bookkeeping support for control queue messages
    https://git.kernel.org/netdev/net-next/c/b4ff4e626a7c
  - [net-next,v8,06/15] idpf: remove 'vport_params_reqd' field
    https://git.kernel.org/netdev/net-next/c/fb2bebcffbbd
  - [net-next,v8,07/15] idpf: remove unused code for getting RSS info from device
    https://git.kernel.org/netdev/net-next/c/8760a06e4553
  - [net-next,v8,08/15] idpf: refactor idpf to use libie_pci APIs
    https://git.kernel.org/netdev/net-next/c/6b284aa2ddf3
  - [net-next,v8,09/15] idpf: refactor idpf to use libie control queues
    https://git.kernel.org/netdev/net-next/c/deaada4f1807
  - [net-next,v8,10/15] idpf: make mbx_task queueing and cancelling more consistent
    https://git.kernel.org/netdev/net-next/c/047cdea66752
  - [net-next,v8,11/15] idpf: print a debug message and bail in case of non-event ctlq message
    https://git.kernel.org/netdev/net-next/c/1150ca4085af
  - [net-next,v8,12/15] ixd: add basic driver framework for Intel(R) Control Plane Function
    https://git.kernel.org/netdev/net-next/c/bea44e3892a0
  - [net-next,v8,13/15] ixd: add reset checks and initialize the mailbox
    https://git.kernel.org/netdev/net-next/c/31ddf7965a92
  - [net-next,v8,14/15] ixd: add the core initialization
    https://git.kernel.org/netdev/net-next/c/29735d99c383
  - [net-next,v8,15/15] ixd: add devlink support
    https://git.kernel.org/netdev/net-next/c/f290d48f0299

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



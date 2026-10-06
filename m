Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EC2D2488;
	Tue,  6 Oct 2026 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305296; cv=none; b=YcAk+TQNGgSZarIsG2uds+TZdYnV/ixrdWB2yxkPjFn/b5AM3Ie/6L7zSEnkq2woPKJZbdUw1sw37mcdO0A4cLDqSizw+fJYR4UKNiQgUNcSkeslOcLoaOhRMMyE3VBz1XrCYR1r59+Yn3DxkUWduPBX/War1ksTLkRmzZNMVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305296; c=relaxed/simple;
	bh=zN6GZeLsD4ipIyBAsUKJLG8w7put7Yz3aZZIfQOmyqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwYTQPhzNquzDNFfbGewB+iZRAFa5m0XAtxn+LQZAUdJvYE/M0odnmLady/bX7yQOr3FEwf1XXt3vk+wWVwf0Kyp2kqKSh0l9dn2vauKrtJ/Hf3iAZtF41YTIk7sQjNMV5FJcic78XJEO7diry03XnE/0oybAd2jNNp0Sm2YaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MirE2a3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MirE2a3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185CA1F0089B;
	Tue,  6 Oct 2026 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791305295;
	bh=IPFOHkcIIF4ReC4suyOiiSRI7+Myt5oo+510tjuGmJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MirE2a3D2LhvM6yBBlMSxvE75REamWzyrmiPT3lryrYCqIxpVxYETGp3tALaWwxw6
	 Es/VEeVHQujwjaPq03VDRicVy2bfRzpd0S0+Rf4ab69/b8+xI3IYny+bxZRgfiNJyg
	 wJdDzCdvn71X2xP/72JfjWWlTk3NIcSS7MUFi+83TORyE9Yg4reGCKW7AHk77hxJIk
	 su5ulVkO582tw/DM8wJhFMVUpS8p4mm6qIx0rDNFo+u1Yhu8ILDBHftGW0qWL2QYV8
	 Ae/3L+FQDMgp2vZrMglR6IqyfjZUK/6yZqygTy2xlQo8BWtr/pz7jCIfEtKcuccZ0p
	 i5h4Fz0qitRcA==
Date: Tue, 6 Oct 2026 17:48:10 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: satishkh@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sebaddel@cisco.com
Subject: Re: [PATCH net-next v2 3/6] enic: recover V2 VF mailbox when PF
 state is unknown
Message-ID: <20261006164810.GN83879@horms.kernel.org>
References: <20260929-b4-enic-sriov-v2-vf-receive-control-v2-3-5962c10061b2@cisco.com>
 <179105705474.434549.8884325756137736298@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179105705474.434549.8884325756137736298@kernel.org>

On Sat, Oct 03, 2026 at 07:50:54PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 11 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 6 · Low: 3
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] enic_reset() now has two new error exits, taken when
>   enic_dev_soft_reset() fails or when the newly added vnic_dev_init()…
> - [High] The patch adds vf_datapath_open so that "a failed internal reset
>   cannot stop it twice".

Hi Satish,

There is an expectation that the author responds to these messages
in order for the patch-set to proceed.

In order to move things a long a bit I've taken a brief look at the two
issues above (only) and they seem both related to each other and
legitimate problems.

Please also look over these and other issues reported by
netdev-bot+sashiko@kernel.org for this patchset-set.

For those that are non-issues, please indicate that,
e.g. by responding to the bot on the ML.

And please post an updated version that addresses the real,
non-pre-existing, issues.

Thanks!

> - [Medium] The commit message says the timed-out DMA mapping is left "for
>   admin-channel teardown to reclaim safely".
> - [Medium] vf_mbox_recovery_active is a plain bool.
> - [Medium] vf_mbox_recovery_active stays true for the whole run of the
>   reset worker, including the time after enic_open() has committed…
> - [Medium] The patch makes several admin-RQ drop paths trigger full VF
>   recovery (RX quarantine, carrier off, sends disabled, a soft reset…
> - [Medium] The new V2 VF error exit in enic_open() (`goto
>   err_out_dev_disable`) runs after enic_dev_enable() has succeeded, when…
> - [Medium] The new vnic_dev_init() call in enic_reset() issues CMD_INIT,
>   or on older firmware CMD_INIT_v1 + CMD_GET_MAC_ADDR + CMD_ADDR_ADD,…
> - [Low] Concern: the patch has no Fixes: tag even though it fixes V2
>   mailbox behaviour introduced by commit 1f0c856b596337.
> - [Low] Concern: the commit message and comments assume a VF MAC/receive-
>   filter mailbox protocol and a station/filter replay that do not exist…
> - [Low] Concern: the new enic_reset_addr_lists() calls in enic_open() and
>   enic_admin_chan_reopen() run __dev_uc_unsync()/__dev_mc_unsync()…

-- 
pw-bot: changes-requested

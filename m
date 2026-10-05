Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F817443C16
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241211; cv=none; b=D86LYtJzhBEfa7VCbQ++3Qt95nbQ7pWlkspkq4IjVWAmhYDlP9LuOewpVola01zdXevH1Pq66DZRyMnFmkL0H4yxjqAw7ja6e7yo3SfAkZ2sWNVXG6nTSIxbpd9pGUYQ+lmnE8bm3h54N9R0Ax5wSlND252H2LFzXmvQFHSg2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241211; c=relaxed/simple;
	bh=bDjnPaCyuDDYLZ5YKJrl667uzK8FUUQeOiwjBlaMQLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=plnawS8emfc22mPflfkpFXjZS6Aro2JntCQe4kljckBJwTiHKuejlgvDZn+jzresbPc+fsFlizvSvp2jUN+9C7F+0JU+gx+HrpP5lPUtPKYiy1KtH4QLHLc3qlpiCOYYXTcx7zRunZWq/R/IgfHX5QbieFk7W1l66QNWYlxGLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF26E0hE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF26E0hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00CB1F000FF;
	Mon,  5 Oct 2026 23:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241209;
	bh=LBF6qzvL29eu3XmZS61Y5XUTkmD7Ofx4wAQA+X8esBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bF26E0hEqPscPv/a6JquMWjPCx5Jy61ekDeWejFoEroTF/d/7p9M9gHbCFDcTG+J7
	 bensPyevBMMsKA65mhPwg5VfHBdXq4GNTN3JC36G2Bv/C9gXjULEsbMPsSk+EZsSHW
	 79FwkaJRMYanIQnr5ltyFkZgrL9cU044F5ppixpJTbS6D0J63nBZLePuVWvrza85Qc
	 sbGPXXY/f6/j0eShpJbYJO9Xyfh3lE+pLBJymTwLyanmVWhMuxUhgDHTdFNQ/OO3IH
	 4623qvND1HlRzM0r0p8OHnM1zttHIHhrhklabClaV8efPo+Bj142mLr6zCHeVsZ2ix
	 PlHxJmsIlei+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43C63926677;
	Mon,  5 Oct 2026 23:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3][pull request] Fix i40e/ice/iavf VF bonding
 after
 netdev lock changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124120830.1929441.16774751070635503188.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:00:08 +0000
References: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260928224454.483072-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jtornosm@redhat.com, przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, horms@kernel.org, sdf@fomichev.me

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 28 Sep 2026 15:44:48 -0700 you wrote:
> Jose Ignacio Tornos Martinez says:
> 
> This series fixes VF bonding failures introduced by commit ad7c7b2172c3
> ("net: hold netdev instance lock during sysfs operations").
> 
> When adding VFs to a bond immediately after setting trust mode, MAC
> address changes fail with -EAGAIN, preventing bonding setup. This
> affects both i40e (700-series) and ice (800-series) Intel NICs.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] i40e: skip unnecessary VF reset when setting trust
    https://git.kernel.org/netdev/net/c/74bbbc9359a5
  - [net,v2,2/3] iavf: send MAC change request synchronously
    https://git.kernel.org/netdev/net/c/436729a56dd4
  - [net,v2,3/3] ice: skip unnecessary VF reset when setting trust
    https://git.kernel.org/netdev/net/c/0a01e1df137f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



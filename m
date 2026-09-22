Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4678345CCE;
	Tue, 22 Sep 2026 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038728; cv=none; b=pN3o/QAvnCGXjzoO+pMamJc54JTSzC5WEP0ntExBS7+nfCXFcJjnhHvAHOqUOFpXZZ60x8SFhmHj8acx7BfC/Q2/8REWZOTA0+JzcfTwhQtm9Zr54vH6sISqUzPnrPi0fIw4Jdb6d0jiZ0M1ewHr20W+HHYrHj7xa4FHv9diSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038728; c=relaxed/simple;
	bh=Jn/706L1DwIn6qPJCXfpbHUcSISKIvqVUOfpmMry1mM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxci+0waPzTambDcGy5hyNMfkyaYxJigfoIFmkoB21onUTH/rGr/WtUnRxIfluQOnesgOxEA+bC4L6cs4jQ0tPw5CamL3MdMSoV5dR36wDua3/QcsTGFXWPCO22L19b/KZwvdTtpglXfb+9mbs01ks9LtSJZJrIzYTfuxUNZnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1cMhxNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1cMhxNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923231F000FF;
	Tue, 22 Sep 2026 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038726;
	bh=V3bbRbekCvB2cOuljHsCe4LsqUP4+8XrR7d+r7i+4yg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L1cMhxNg23hNxSVBiSZ0K2vcBIex20djvFVeQGghn97OXOUivSGR9ds9QKuT9emFH
	 OsoAXrz6pAs9NoEHpM8rSJ6KbeED6FbcEEoGOknpu2XbUCiPmjNHNiFLwPkoaXOFrA
	 AYnPdgDeKkzZ4UwLRcM4vtDP4jJs+WEfrlSI9arB47a0Kj/PkSo+EiEsGN3Ofl6J64
	 G/pO62yHKLNU6O+CREuC4igVnjdt44+8rLT1H2LAItbqCnWmAeNBxS/ojuked9ZknQ
	 EucjHFSd3OlFby7Nxf3FjossoQ07Ddq4OMVT4m0udaJGx1g7ILBdYyE05E2t9bliPg
	 9/+aBIDLKeHLA==
Subject: Re: [PATCH net 1/8] net: bcmgenet: fix 64-bit RTNL stats reading in
 ethtool on 32-bit systems
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:45 +0000
Message-ID: <179003872507.2160803.13505344843089267862@kernel.org>
In-Reply-To: <20260918000732.276506-2-florian.fainelli@broadcom.com>
References: <20260918000732.276506-2-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "net: bcmgenet: fix 64-bit RTNL stats
  reading in ethtool on 32-bit systems" has no Signed-off-by: line, so…

--

net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems

This changes the width test in bcmgenet_get_ethtool_stats() from a check
against sizeof(unsigned long) to a check against sizeof(u64), so that
STAT_RTNL entries pointing into struct rtnl_link_stats64 are read as
64-bit values on 32-bit architectures too.

No Link: tags are present in the commit header.

The code change itself looks fine; my only comments are about the trailer
block of the commit message:

>     Fixes: 59aa6e3072aa ("net: bcmgenet: switch to use 64bit statistics")
>     Assisted-by: LLM
>     Co-authored-by: Cursor <cursoragent@cursor.com>
>     Change-Id: I3e9f2f8d4fd136392148d6c0cd4eb40f7ccbe4ef

[Severity: Medium]
There is no Signed-off-by: line in this commit, so the Developer's
Certificate of Origin chain described in
Documentation/process/submitting-patches.rst is missing.  Can this be
applied as posted, or does it need a respin with a Signed-off-by: from the
author?

The remaining trailers also look unusual for an upstream posting:

  - Change-Id: I3e9f2f8d4fd136392148d6c0cd4eb40f7ccbe4ef is a Gerrit-internal
    identifier and is normally stripped before submission.
  - Assisted-by: LLM is not a trailer the kernel uses.
  - Co-authored-by: Cursor <cursoragent@cursor.com> does not match the
    kernel convention, which is Co-developed-by: immediately followed by
    that co-developer's own Signed-off-by:.  Can an agent address provide
    such a sign-off?

The same trailer block, with no Signed-off-by:, appears in all eight commits
of the series range 46bc52d1..e6810d7c, so no later patch in the series
corrects it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com

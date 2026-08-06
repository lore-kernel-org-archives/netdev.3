Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C8388E63
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037447; cv=none; b=GcsyUTOGVHuCgJzfz0CmTWuK1LautsY37BcBb5TZ2mkjoAcDZ/FGp+RC8N+orAg1A4VcJIO4IEWxxW6Pe0JpCANAVr1vDYES6kvH32nbOxzotzqatgwrnmir/yW2mVUlin4DLJ8h4MWfU2t723qdjm3IogmaNA0sgrTaLLZfzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037447; c=relaxed/simple;
	bh=e1MmJQRodfLj7fAZGuLusgNj+7Mfo2MpT7Wobo/0nTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AHwnYLvJN1IY9k+AX+xDOC2IYWeqIwsSFJ3nf+zBTndm0Z26F4FCwbOFLt2epCVYJBC9/N2ZKbZcq+i7B3YTK5OSwMoQnFgbGBzZ/geTtfzse3IT/r9pRo5bs+LgRLEAfwrpHiBMAFF6ToHcp1XafEGpe03DjhSMEvlVLNWGDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLbZxK63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLbZxK63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572581F000E9;
	Thu,  6 Aug 2026 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037446;
	bh=rs+ju0obgfu+tGkao5Agp4atcOSX2hiVR7pH6/OcOJc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FLbZxK633vJLPWcQk79o0CR/DZBaTeCjV2LeDprGvxaWkfs8WkN/9CSMidhO1UuV3
	 H8s/sMEFd9crElu/LjtsfBQREN07K0UY2tXyyyKZnMaCahb/MJ5EXXG2PBGUCmx0QE
	 Q7//FuSl6qCE9sMak21rDjbtiOfbzDQfA/9GB7Flbjsfv/y7eydOOIFqnmeeEyfivT
	 Xs9dx8mpX/81UypbDJJrc5fcCEY/hsxq+7GxEynpVzJrorYYvCtetGdNS4MHAc2/ta
	 A8P67tRgTwLk3UDUF+9KJH9wo72KatPvBxVadIB9mc8c8dW2jRFPKFSJOAbtP/49Pd
	 GfkqVJgU5FS8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D33809A0C;
	Thu,  6 Aug 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates
 2026-08-04 (iavf, i40e, ice, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603740539.1397170.8040078877200983730.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 17:30:05 +0000
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Aug 2026 15:21:53 -0700 you wrote:
> Jose Ignacio Tornos Martinez fixes issues with VF bonding that came
> about with commit ad7c7b2172c3 ("net: hold netdev instance lock during
> sysfs operations").
> 
> Further details:
> https://lore.kernel.org/netdev/20260623101800.991293-1-jtornosm@redhat.com/
> 
> [...]

Here is the summary with links:
  - [net,01/10] iavf: return EBUSY if reset in progress or not ready during MAC change
    (no matching commit)
  - [net,02/10] i40e: skip unnecessary VF reset when setting trust
    (no matching commit)
  - [net,03/10] iavf: send MAC change request synchronously
    (no matching commit)
  - [net,04/10] ice: skip unnecessary VF reset when setting trust
    (no matching commit)
  - [net,05/10] ice: move ice_vsi_realloc_stat_arrays() up
    (no matching commit)
  - [net,06/10] ice: fix stats array overflow via proper realloc
    (no matching commit)
  - [net,07/10] ice: eswitch: fix use-after-free of metadata_dst in repr release
    (no matching commit)
  - [net,08/10] i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()
    (no matching commit)
  - [net,09/10] i40e: fix netdev leak in i40e_vsi_setup() error paths
    (no matching commit)
  - [net,10/10] igc: fix netdev not re-attached after resume if interface is down
    https://git.kernel.org/netdev/net/c/b0ce5fd9fabe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



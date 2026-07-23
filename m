Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064B4756C1;
	Thu, 23 Jul 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820658; cv=none; b=Mk5SaDPZRQnfjrjmqaPrLXvzcrh9EKe1veHGBhUnIuzIi3B/4XSwGOYd/AbsH/7BiLBAtrPsyUEmSHiTJZec2aQurRJV9qs0TMrXlmAvUl0i4Pbvx9hxdujvzMILhi/eqzOMYE4EK6BPFpwq2ZM/PrUAsWbxVhV01tI6Tnm3hu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820658; c=relaxed/simple;
	bh=cKgVEDwOnfVrADGb5RAxRHoxxeRAc94JeGVOhpswPIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EVpH8g1Yr9stywHq+FVuh+TUUn2xKj+jupvPz49J94Ikk14YsHzroas6QpMYXbvEOOe3k6oBgTZaUN6zBoYzduSLxAjwuvAzwkI2/S6cHubg7puajw7jCBYlEemZxO4M34nss+Io5vHiCVGpU11+SpANTuhNvkgnPa+iO9lx8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69DD1F000E9;
	Thu, 23 Jul 2026 15:30:55 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AF8392444F;
	Thu, 23 Jul 2026 15:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: atm: ueagle-atm: reject descriptors that confuse
 probe
 and disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482061640.2321119.12288067082123578966.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:30:16 +0000
References: <20260717080704.1264-1-diegomancera.dev@gmail.com>
In-Reply-To: <20260717080704.1264-1-diegomancera.dev@gmail.com>
To: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: castet.matthieu@free.fr, stf_xl@wp.pl, 3chas3@gmail.com,
 gregkh@linuxfoundation.org, mfo@igalia.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jul 2026 02:07:04 -0600 you wrote:
> uea_probe() distinguishes a pre-firmware device from a post-firmware one
> using the USB id (UEA_IS_PREFIRM()), and stores a different object as the
> interface data in each case: a 'struct completion' for a pre-firmware
> device (to be waited on in .disconnect()), or a 'struct usbatm_data' for a
> post-firmware one.
> 
> uea_disconnect() instead tells the two apart by the number of interfaces
> of the active configuration (a pre-firmware device exposes a single
> interface, ADI930 has 2 and eagle has 3), and casts the interface data
> accordingly.
> 
> [...]

Here is the summary with links:
  - usb: atm: ueagle-atm: reject descriptors that confuse probe and disconnect
    https://git.kernel.org/netdev/net/c/9dfd800b374c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



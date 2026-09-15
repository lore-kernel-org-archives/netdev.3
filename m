Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A39747ACC6;
	Tue, 15 Sep 2026 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467673; cv=none; b=JURvwjevQy2R6cpE6dNeCwVwXn71Fp2NzsqVWAqv+zvn/gpTWUehqYon3Kjnsw6LJHY7ZNFP0lGb2+dCBxjrDrIe2JVm7/4vPGaiKOLnQWCUFou28pkiwpG3gJcbrS+dgjz5jnU3biclEiNabXmoL+Af224uidLlQsO3KfWNe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467673; c=relaxed/simple;
	bh=j2FwAU6Oc/8C613M05UKW5TkX/+ZWeoDiJRoL501X3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YuEeHXlNyqHpUEiV165SveEkIyIWQh/9vm/2b3FZHxH2sIsjm4eGvXTPuh46ogX6p1osPuqdYE7DKb2k6VJnW07528HdYQ42g3L+ZlG+ePNy/4W026D2qLxEILtp7samOGZlEQA2g1lchGNgyWm/nKEL+PH/dKk6UKWscJlI70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrTewRqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrTewRqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD67E1F000FF;
	Tue, 15 Sep 2026 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467671;
	bh=20/7wnbF8nfIl3EGX+jvo0C3k5EWfhud03KDBQFoyEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NrTewRqYp2tmxhdV4vca9LV/gg5fBNLwrcLjECSN+V1lZ3KyI3pcMYEi0NhQzbMhb
	 H6LkLgFKvk+I8mDZ2yt8OIrPjKKsTT4+CBSVbcXo5yGpFuj2l++weSewuKhJeS4a4c
	 Emj5VyzR5c5EyyrMz0n5UUR0zmmbI5ITPwobqWKFtlNCa17UvF3f4Vf0NAeM1J4Vrs
	 3106/MERHkyzuM51yXJ/uOuD/yA2enafGoEePHpfTOo8v7VLUPXxXs7CmgByqPeVw9
	 eJR4boyWvLxYwOWBjIChdQYS7MoSKcoQGX4dLKGZEeLf9XZoW5Og4xqxQGVy1e7Gz0
	 eVELDL7I1nO0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09B03926263;
	Tue, 15 Sep 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC
 v4 VF support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178946760664.1496640.10712113445214724532.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 10:20:06 +0000
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  9 Sep 2026 18:07:18 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> This series enhances SR-IOV support for ENETC v1 and adds VF support
> for ENETC v4. For ENETC v1, the trusted VF management and per-VF
> configuration query via ndo_get_vf_config() are added. For ENETC v4,
> preliminary VF support is introduced for i.MX94 and i.MX95 platforms.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/15] net: enetc: add trusted VF support
    https://git.kernel.org/netdev/net-next/c/aeb505f83f7b
  - [v4,net-next,02/15] net: enetc: move msg_task and msg_int_name to struct enetc_si
    https://git.kernel.org/netdev/net-next/c/99ace7602482
  - [v4,net-next,03/15] net: enetc: add link status message support to PF driver
    https://git.kernel.org/netdev/net-next/c/83d385c67af5
  - [v4,net-next,04/15] net: enetc: add link speed message support to PF driver
    https://git.kernel.org/netdev/net-next/c/f7e86f8ae699
  - [v4,net-next,05/15] net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
    https://git.kernel.org/netdev/net-next/c/fba13302b996
  - [v4,net-next,06/15] net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
    https://git.kernel.org/netdev/net-next/c/f37718e9210b
  - [v4,net-next,07/15] net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
    https://git.kernel.org/netdev/net-next/c/18c66a9a4fae
  - [v4,net-next,08/15] net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
    https://git.kernel.org/netdev/net-next/c/261be512194d
  - [v4,net-next,09/15] net: enetc: add MAC address filtering support for VFs of ENETC v4
    https://git.kernel.org/netdev/net-next/c/e7ac83644e28
  - [v4,net-next,10/15] net: enetc: simplify and rename PSIIER enable/disable helpers
    https://git.kernel.org/netdev/net-next/c/76fb8ad66d3d
  - [v4,net-next,11/15] net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
    https://git.kernel.org/netdev/net-next/c/f539a68b0aa1
  - [v4,net-next,12/15] net: enetc: add VF support for i.MX94 and i.MX95
    https://git.kernel.org/netdev/net-next/c/fd793705e62f
  - [v4,net-next,13/15] net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
    https://git.kernel.org/netdev/net-next/c/e05f2902925e
  - [v4,net-next,14/15] net: enetc: add PSI-to-VSI link status notification support for VF
    https://git.kernel.org/netdev/net-next/c/36a16ed591b3
  - [v4,net-next,15/15] net: enetc: add ndo_get_vf_config() support
    https://git.kernel.org/netdev/net-next/c/5822ab0f3e89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



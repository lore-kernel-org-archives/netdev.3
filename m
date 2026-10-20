Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530024;
	b=Om6EDoJg/qxohyiS3esgpU45cvkWoeUnweVLZfMFRGz8YR8a+vuirol9kagXbzHtcr58
	 T/lYEj4/v9ejHetCtrJPlhfvz0EE0+GkUtwo9/Qyz0C+aDffzF9l5MH/CKTGsv/FUm81R
	 c4gwdlRJQoUmBEw6MJzTP/vAOaqtTnE5tTpcPm0MTcK2KES5W5wU9Ng7zWXedZBgTk3J1
	 IdRtvSv8fFF6E/MqH0UIzSQvfA071bq/hmFLje9fqM7qRHP4nomHpfSh8HQrau79Ek3Yo
	 ehJtqzbxpKROxKJe6Omo6PalCOKMX0CZOa0WfYL6qDb1Oi7NTSdtBazbLRs0o4P1epQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530024;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XX3XLV0xHg6luX3whJrUDl/guabkVK+4J15AfwA4RJY=;
	b=lkD2/M4qHAXlebFBNHUQdGloNuaPlHkYHG7SB5w9HTup18U8ijda2zgxQity7s47PJ7v
	 88DTRIlQng/7cKIbHmX5pdY3crPVrviTtZEOb3QppCEu17Km1GnHdwGUt/U34rIIWbZc8
	 sJAPp9jjX0KpMnMaIRAHPWRUPqcPLx7ue0LxW3/xEx3/VdS082oCsAmQf9vn/IKc0VxV9
	 hntHo1EV4DDfx87qda2cO3CkhbGRDB7rCrAQCVAEHqZD545x3BT/R03F+f/vUcKWZhT78
	 QcfUEcl6k6/HFOqnA/eje5GH82q5Blp1B9AFEO1mH2i/5lBVDZ56QGDWYFbsd6Wo1zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8vUMbvR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877E606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j8vUMbvR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E401F000CF;
	Tue, 20 Oct 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530023;
	bh=XX3XLV0xHg6luX3whJrUDl/guabkVK+4J15AfwA4RJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j8vUMbvRPTZc8qeYxyVx+Tucj1PeGloQW9hh4wnS/6CvYppTwv2MCz69dVqH4oBGA
	 SEsGELHuUkZ5/qvknsPVzH3kSg0csouXHfIXbd3i8h5Loxi3edUtMIXnFjSkPAz5rp
	 9KYAP5FbIMRQ75HMyfQQmxLX0IeMMuIVx1+smaU+LeLRcohoWJ7TJytyKWFDTrjXHO
	 Z4s492i3s+V77wgS0nyVV3jR31vjwWGulUmDu+GK90xmox0k3mxh/DfNKv8m1Asq7V
	 TgQIIa3Yc/exhf9FvS8O3zpOH5UCZFhZsgCmWMhvNtS6R105EkKmDqv7d8m0mLuOUi
	 z6UI47l8B7MaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773FA3809A09;
	Tue, 20 Oct 2026 21:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Update netdev features only after a
 successful
 ringparam set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253002202.208021.1423217243586983766.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:00:22 +0000
References: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 bjorn@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 17:54:01 -0700 you wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> mlx5 couples HW-GRO with tcp-data-split. If a user sets rx-gro-hw on ->
> tcp-data-split on -> rx-gro-hw off, the driver will leave HW-GRO on.
> mlx5e_ethtool_set_tcp_data_split() calls netdev_update_features() when
> tcp-data-split goes from enabled to disabled in case HW-GRO needs to be
> released. mlx5e_fix_features() reads the new HDS config from
> dev->cfg_pending, so HW-GRO is released before all ring parameters are
> validated.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Update netdev features only after a successful ringparam set
    https://git.kernel.org/netdev/net/c/23dd5be7e19c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



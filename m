Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F230D3E8;
	Thu, 30 Jul 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450711; cv=none; b=e9qG+DcOdVEhZiLHpAA9XPPruYu4YiiHRCuOwZwl8scYsfEclmHlBZt/w3JaLSQj4Au+AO0qyOt0SNUP8uXYggAOhu+LZBiSG3wsYQ0d4dlinnWjnWJCofCoQRUZTjIk79VMqJ2q9sPMB5nRebqi34m6Dfcz1/6frEjlKWaF0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450711; c=relaxed/simple;
	bh=KV9nwFT0dKGcBPFFsar3vVw+aEmGqm1XWImZfSz2GP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCn0K2JRPMQfSP3fTQ4+5MpOjcRxqZutDlUTw8zFGr3TGFEpYawDHyJdR4c8w7xIRuIkIMSgPI+mF9ZkB+3udGpObCEt+LWJD1sYFjxDp09fE04l5Twk61rejDbtvfE7tzhfEOXmlO/R6O0kMNnLsg7ApZaG3a4XAvq/gkApwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHRYPcHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHRYPcHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB0F1F000E9;
	Thu, 30 Jul 2026 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450709;
	bh=lia3VttcYmNU28MbjTLvi9iby44TkIBK7PduY4/5a4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MHRYPcHl32Os8tLIr+AZQxCTXycWR8ryuEvpKsT108bOjmnJrjtwLNDWnaQd27FAa
	 UwXtYFeWV7lbRfUntzIOGku5tj33PDMJAW1TTI7jJ1kJs9VR4xSdsFE3VKY2sPdn66
	 NcARGkHHdhN2zVzvgSw+XdiguKBRVJd/wo7uE/hKN0taiAerNwp2AwBhO3K+Qrgko4
	 ppOyYpS3WNYKofJc8BPiKBLZf/hu8SpXaBz3kh+yMHiDeknHuNE4Asq8AdjHVA8fIC
	 cutMZ6Jjze/RNuqwZPM0nkwZCCKKdvFIVYs1bzN1mFFMC1fc6EwMjowPKixiodWEW/
	 vgXvNdE3mLP4w==
Date: Thu, 30 Jul 2026 15:31:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, attinagaoxu@gmail.com,
 alchark@gmail.com
Subject: Re: [PATCH net-next v3] net: phy: motorcomm: enable the reference
 clock for YT8521 and YT8531
Message-ID: <20260730153148.3a4052ed@kernel.org>
In-Reply-To: <20260728055659.1211459-1-gahing@gahingwoo.com>
References: <20260728055659.1211459-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:56:59 +1200 Jiaxing Hu wrote:
> These PHYs need a 25 MHz reference. On boards without a local crystal
> it is fed from the SoC and described as a clock on the PHY node. Get and
> enable it in probe, in both yt8521_probe and yt8531_probe, so the PHY is
> clocked before its registers are accessed. The clock is optional, so
> crystal-clocked boards are unaffected.

does not apply please rebase on net-next/main and repost
-- 
pw-bot: cr

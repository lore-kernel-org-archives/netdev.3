Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C45187F8;
	Mon, 21 Sep 2026 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028548; cv=none; b=mlt5LmyfglZD0lUFxT3oyWZY9DtY+DEXlEAAdJmwAmoBoh8h4x4l03DTbW5opiffLkEJO3oh3If2dw+pRtncmJJ0/NZue6Pib7v0EYSMtOfrB675LD8iYx++ZTupsvaFGgMU2StSNr42sgOfqkaS/kOtgqorA5Jm2lk35PEco40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028548; c=relaxed/simple;
	bh=BRFqJ3nLDa37KhjMwCsGVdbPSdbd5ZOJ4ntYw7W1xGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4ZwnHE093qBNHvNF2wlsDi16j8uDGRza2HM9l8vR+FWOnQQR4MpErOGJp73xbr/ZommvvUPC44MFMStL4lSnmDLbdIdGv3KEpfRqkr8gf8wcqX/gzNx77DtGQimeCgiQYrSjXc1JaltLAMkFS0dRx2+XbMyKuPO6d46eiIfY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMAPTQ44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMAPTQ44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DDE1F000FF;
	Mon, 21 Sep 2026 22:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028545;
	bh=ZHl92j8VdeRj+raOZsH8jt5z8UIZB4Kd0dWwKYJs4Eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aMAPTQ44LavJJyRaiz+T8ExtWIK3MJDhGqvScrAI1XebMaiM7uZfkCwaKA3EAn4Cn
	 NXUld5EpFO6yZijn778QCOwGFpgQA28WangMANGK/9jrHqoA9KBoa+CW70ApwqUIfe
	 aNK4GOBUkareMFDBxPUaSEWD2FBWAbTStrcs99872ShlOsemPvBHO62JGSnvtA+wfi
	 an7nhNEWrVT2yGBw2DnCY5yZznDO/JiZpS9UNKf4w4JYPBGCFCkgbcMXGpObvn87rK
	 bgHhkGPGYvGYChdHCCm8Px1krmDke/zRzGCsU8+temYVl1UfqUmdNINlskquKqGcep
	 YIGoraYvXsInQ==
Date: Mon, 21 Sep 2026 15:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alishmery18@gmail.com, netdev@vger.kernel.org, idosch@nvidia.com,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vxlan: vnifilter: reject VNIs outside
 the 24-bit space
Message-ID: <20260921150904.65a704eb@kernel.org>
In-Reply-To: <178977729000.22033.11804607706102932436@kernel.org>
References: <20260916193449.2552039-2-alishmery18@gmail.com>
	<178977729000.22033.11804607706102932436@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 00:21:30 +0000 netdev-bot+sashiko@kernel.org wrote:
> The top-level nlmsg_parse() in vxlan_vnifilter_process() uses
> vni_filter_policy, where the nest has no nested_policy pointer, and
> lib/nlattr.c only recurses when pt->nested_policy is set:
> 
> static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
> 	[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
> };

Sounds legit, please link it with NLA_POLICY_NESTED() as patch 1
in the series

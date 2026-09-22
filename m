Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741731F418F;
	Tue, 22 Sep 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035989; cv=none; b=EdhT5napUHM67LRzFZy7NEwkH/ysJbNUicFmgG6b03cDONUYLgXz+tgosyUzc3M5Ud5Bs3cH68sO7oxZw9K0ReptqeqCrJ7uDeMZtBUcsW75AVsMSzN1REHLtyt6anEuYEYEylJcRtoLJCgiFM3bJgm8QjNsxxvbOXS1+0qomog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035989; c=relaxed/simple;
	bh=JjQLzpYpzi6+EIL40lnAthaQLHiDc9oLR2y5XiQU9qw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaX35gCmbRUvDA5b0iWFWsoMVEcm1ukCwH7Xc6kvgOEHhdlj2qEWs6pOTL+u3YJtK3j0ZD7+9TpHAF+5gLDYLPhlI/iCi04gLKRaxmHYM7g0FgtDmRRTO9XXPi5MmGmQfNAf4ISyXNvVn8OAKEpE0oXcfLMacAASCKztZBMnD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYayYgjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYayYgjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC731F000FF;
	Tue, 22 Sep 2026 00:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790035987;
	bh=bJmeASWMRtbK0V1j7SJ1MCYXQ8XtE4OhoMrkDYs8Who=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YYayYgjQRq2Q+zuk6Ley3QPIUo8nAqZ7eqaA5yA6A8uTumXn4fHYbtOaAcPJTFSaN
	 fMF8go8lNrEAlhGOj189KeTjaqBSDfR3oQ+zTld5VRNZ/iZ7sW6l+0swXQ8RRtLaYP
	 DaoKoRaVWv3avfHwZDn8aYKezLUd83WcfCoYstFkt0iy092ctGcC0v3YfShhBagAY6
	 uKKGY0CczZCCQjUWHZAiLTVubRED+vyrwU8j90JGnZzoQDQH02rU89nYenr7P5UuDQ
	 Uc/UhDGcO0DzwO/ZivRihVlB/P2RFF7gFK6YTp2efAjELqncHI5IJqItB92At3l+kG
	 OTL5hHgpqqZbA==
Date: Mon, 21 Sep 2026 17:13:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhargava.marreddy@broadcom.com,
 rahul-rg.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com,
 ajit.khaparde@broadcom.com
Subject: Re: [net-next, v3 00/11] add features to bnge
Message-ID: <20260921171306.137f5e36@kernel.org>
In-Reply-To: <20260917064548.773334-1-vikas.gupta@broadcom.com>
References: <20260917064548.773334-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 12:15:37 +0530 Vikas Gupta wrote:
> This series adds ntuple filter, RSS context, and flow steering
> support to bnge driver.
> Patch 2 is a pure refactor (no functional change) that relocates the
> filter and VNIC related code into the appropriate files. Patch 7 drops
> the refcount usage from L2 filters, also with no functional change.
> The subsequent patches then add the ethtool commands for configuring 
> ntuple flows and RSS contexts.

Please look thru the review here:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917064548.773334-2-vikas.gupta@broadcom.com

We had 3 models enabled for some time and 3x the huge number of
findings in this series seems to have choked the LLM's input limit 
on patch 9. So the review won't get emailed out. But the first finding
already looks legit so..
-- 
pw-bot: cr

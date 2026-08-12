Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501642B30B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553989; cv=none; b=U6oShj5qBL+yB5b0XV2X5AFFI2lqkKfbvA1Woixy2c11XWDLRob2wwC3Fue39h6I+Mj3KyjMjtwoP75tAfFJ/9Jp6lcLTFouurpwUtj7BWkxhCSTpa2sjNduLXAVbs1k3Qp2hmEvvx5i37+tLAFpxOIhtCZgtMeaAV0II1V+dhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553989; c=relaxed/simple;
	bh=czm6ELTchyuYHxJFpARhZe+gYWwiuzdrfsxm3UgTLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmIAZWZxfEOF0T+mF3/ejz7xo7GqE62g8k8Z8mLHVh7EE+yzrWdNgTEaFct2p6DfXIwv5tjMCpY6pZUwwoPHN/Pff00XNQOpEtL43tDKrWOq8l0u7jPveXo1FE+fF6kG+t1LASDW3V1xE+zp/z+6rSPG3QtgUJqYgOpDZjXuBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnPAqeWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnPAqeWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666091F000E9;
	Wed, 12 Aug 2026 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553988;
	bh=uV3b7TDpwcB6pS2iGPTX+bnSYqa1m1jLpPkXxoyS9ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EnPAqeWStcg5HUF76zhlpOtk2tn/cMt7Uc3pFAP8nrGBRe7X3Pg+u7f/6GlLNI11g
	 UiNTR99p+r7uQ0h9iIkeJH/1z9Pznvy37obdyyOdgB0rdGxvYuCi7lnFV2MM4EnB+G
	 8iVVCLyUYbRPfQ1TDbXhnRTfaNf8S8l+hhQqwOmC5dztRkzEcFf3NFW6yIVID6vN7D
	 2A8By18j59T1QZA5FMXwfQamn/u50spuj6IZ8qb/c2Nd4jZGXz9RfchehOX1CbD3Hi
	 zVZIfUKSM4sMwt9kLdB1+/NSqFMsha7GvEaGQ+dRzFuunzjo2h8NANAbfcWtE3g1M3
	 nH8Bi6qJt+s/Q==
Date: Wed, 12 Aug 2026 09:59:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260812095947.3d0e6ca6@kernel.org>
In-Reply-To: <2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
References: <20260804094518.53b56d24@kernel.org>
	<7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
	<20260811080433.26f404dd@kernel.org>
	<8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
	<20260811103832.28e5c8d4@kernel.org>
	<2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 19:31:09 +0300 Nimrod Oren wrote:
> > 10min wasn't enough, bumping to 15min :(
> 
> In these runs xdp-py took ~9.5 minutes. Both pp-alloc and rss-api tests
> passed:
> 
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/774403/test-outputs/
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/774889/test-outputs/
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/775361/test-outputs/

Ack, I'll send a patch to bump the timeout shortly.

That said, the page pool warnings were probabilistic to begin with.
And they were hit in page_pool_unref_netmem(), I think _some_ bug
must still be there?

IOW mlx5e_page_release_fragmented() is draining more references than
the pp page use counter, that's not normal whether some command timeout
out or not.

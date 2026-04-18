Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D62D0C8F
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530949; cv=none; b=KVRSCbcVEjYGTQlORflYaoQ5W9+P++rRkyuseP4eJjQeOFVdoh42RI4sP/qtsHAbRzpbRqOhrH6MVVI9sooTgwMa+d0DVkNZ2fluD6eB5nYtJGfQ6xM/LO5u9/WnN7TZ/ZFbv+dKSQEeZF8bHYHGFlU4jqGAN2mDvShN7fNe3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530949; c=relaxed/simple;
	bh=zsFhT7C4RRvso6WDxH6i2cC6oqq51ld3WwQr2d/gdDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIHchBMmLYBbJ686BKeVfxCmj4fbJbjVO13pgqkbU02igOlnPDR1olcTcf9lRBxPgIhO2sgFpSYD7Xiaa+yCYUtZrHC4xCxh0/XsPYCNAxi997ldF8Ix+r/1zvumb13nWRwcPgNK4D6b76QMDRmGyciYCQQOkhpbNDEd4vqPWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eolK7He/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eolK7He/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EAC19424;
	Sat, 18 Apr 2026 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776530948;
	bh=zsFhT7C4RRvso6WDxH6i2cC6oqq51ld3WwQr2d/gdDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eolK7He/mx32ySTLNNqZ+OVK1eShLGdL3TMgsCS1HxMF/BNAGz8nDiiDNXj9k9kiO
	 Ag1D2wdiGMmFh/manYoNAvItagA8zjBXQnO5SW7nj1bV1/sw74IKO++bo6rZDQqc+O
	 FErhvtjjVvrKsRuUDOHfiuLg+t7oixrxuwV/HKv2boTehVelMOyAOFP6rw2e8t8hTL
	 eO4iRpNktpQzEDgq9YcxSDCxD1nw54Ingt8epBN8dpvUjSeoVPo+fcRKBSFbVhN1zF
	 Unz2bZ8ojcRJqskLwKm/wvD8OCGifdnn0acons9evLGLXqnX3MLlZYRLZU8rBPelL6
	 2WU1qJmm5Vp4w==
Date: Sat, 18 Apr 2026 09:49:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juanlu Herrero <juanlu@fastmail.com>
Cc: dw@davidwei.uk, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/6] selftests: net: multithread + rss_multiqueue
 support for iou-zcrx
Message-ID: <20260418094907.3cde57ca@kernel.org>
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
	<cover.1776444379.git.juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:49:46 -0700 Juanlu Herrero wrote:
> Add multithread support to the iou-zcrx selftest, plus a new
> rss_multiqueue Python variant that exercises multi-queue zero-copy
> receive on a single listening socket with NAPI-ID-based dispatch.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

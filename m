Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B134A68B9;
	Mon, 21 Sep 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003466; cv=none; b=kso2jEmSGpz9/ti+CwfHeJ9S1JhJ5aUyRhaH0woZo4GWMbit8MOaMYD567cmPKfaqSVdAM0PHuoNC5GCA9BP9BpIzh2i6C2sMVyLXJFnkB+tF7XWQWd3GG2qy9gNZLoZYvvLikNiI66baP+zdpGaVpOftpT0CfyWqNA/NrTRGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003466; c=relaxed/simple;
	bh=OzIIvHEz60mPGH9HhSZU/0pn3Blb/TTdPe61g6CGBjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGSM4GX4lOAt5UtATm8TiAh+xjMizbx2sazUCqj5vudGLvSHM1tD3L7GU9AykFo0gi74E6HAHXyBM4NXCXoOFo6eD4FK7pusxe4HCdALgchvjwEO2eTyZzot0ncBYri6rOeckwr29m9s95u6KYSvWRh2l1Hhj10OQqo9PdopSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HULFqKT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HULFqKT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E501F000FF;
	Mon, 21 Sep 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003463;
	bh=jwuHCvpRjDwcPzN0et8g/sbfQ7iL+GiR2dvV9td42mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HULFqKT8BKg5ZGubPlte5WmZ9VJyLxPpPAhD5yoka18DYfYI5fYhU+XOBlAR22SGS
	 m1WBj8O0oC5zP4acSVyMsertUKaGF03XOkQBPkwWFFTrzCxvmXQXQJ5tw/DTKdJmyg
	 mQ/J0UnReL2DguDm7mzLRo+ntV0Zyvge8kHYpD4Bw/1iDIOdXQv5LrHf7vf0YA4E9o
	 r+RsNG6F4DdjpURSZeOoZq0izS+lYGkF3ehNCJNyQ2skTV88jJlF3MlMdbXg3ydwx+
	 DuXB+zeTqEbyjnBGsuu9kb+vL29IShm3c1xRbbPAHsdiRldL/e8C/Fgqjq63MY5cbr
	 qraXVnNUv9/uw==
Date: Mon, 21 Sep 2026 17:11:00 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com
Subject: Re: [PATCH] net: slip: fix out-of-bounds access on short CSLIP
 packets
Message-ID: <arFJA2JwCf8isMwH@quoll>
References: <20260919223432.3882500-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919223432.3882500-1-benquike@gmail.com>


On Sat, 19 Sep 2026 22:34:31 +0000, Hui Peng wrote:
> In drivers/net/slip/slip.c, verify packet length before invoking
> slhc_uncompress() / slhc_remember() on compressed SLIP frames so
> truncated CSLIP headers cannot read or write past the receive buffer.
> 
> Fixes: b5451d783ade ("slip: Move the SLIP drivers")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof




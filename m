Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D92405EB;
	Tue, 15 Sep 2026 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432800; cv=none; b=tov9ECzZyGz/+JrK4eJnOee3x3XTqlXlSCCNKU0ass89MwwAtPACBr8MDHPVp6MP1Tmg7CC3pMkeY4vX7m0rxEO6Qmy1m/3UtVpEAUBwK38oE96+6qhQZDOJ+IHnio/JX8Y9bBqMwuZjqUPghygaGzIcCRZkC4aBEIEgbqRJKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432800; c=relaxed/simple;
	bh=5ikgTSJ27kP0NjtGHt8QPalloQSVfFsOQww4XrmTOfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSgfUYR8P/tINf9LpmSvK9LEfJT1CB/qwBPrU5qU/xsJInZvvNNcgkGk7IXv7Zuxv4P5FJ+wkhhmhfoUd5QkFNAhyj+IGViWd1t9rLLAO2gtuPmSD+4VPBtnyz8HvvO5saafAtHYATbDGl/OzyfGbsIICFMnlgFpOGoVJ822jsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTjGOcrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTjGOcrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A51F000FF;
	Tue, 15 Sep 2026 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789432799;
	bh=ch6+6vYbUzQVMfiq8DwLwWKcs/ndKeS9HK3EtR7RETo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kTjGOcrgOE4cI8VdASAkLN5P3FvHELMmIemm6WnPw5KCF5H+6XTvKqipzEgmL+rCr
	 OPcDW5xMPzfhczUpNWfbcLk+prypkRQLfcZIRXmjKUU2hA5KVlmMtbkj7jZ2l7FeuC
	 aN9ZubGNIh4WkgXOAuBdrW+zOEDkPKXXBXQnhgCLmaY9zlONqE21c7db/k/PtjgJsX
	 /5lHXdSydCux/jUuuEU4ZCqTK1DKtKh0BY3R+Xezb3wLcyqgRQdyDrz7ScNOgV+kDv
	 Oc34l0XH5F8mQz4DOz9byGSh4cz//RySc/173spbojYiTJ5qXp89bwC8lIvI4gYX1A
	 8LQIc0e+p7r1g==
Date: Mon, 14 Sep 2026 17:39:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Clark <jjc@jclark.com>
Cc: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH net v2] net: macb: fix ordering around PTP timestamp
 read
Message-ID: <20260914173957.2840e0e3@kernel.org>
In-Reply-To: <20260910040658.18359-1-jjc@jclark.com>
References: <20260910040658.18359-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 11:06:52 +0700 James Clark wrote:
> +	/* ptp_read_system_prets() uses smp_rmb() internally,
> +	 * which does not guarantee ordering against MMIO reads.
> +	 */

IMHO the fact that the gem_readl() is a relaxed read is more relevant /
unusual in this case?

Also clashiko points out that this function may be called per packet
with sts as NULL so it's worth wrapping these barriers in if, I think
that's a good suggestion?

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910040658.18359-1-jjc@jclark.com

> +	rmb();
>  	first = gem_readl(bp, TN);
> +	/* Ensure the PHC read completes before taking
> +	 * the post timestamp.
> +	 */
> +	rmb();
-- 
pw-bot: cr

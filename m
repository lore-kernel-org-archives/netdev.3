Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963153431F8;
	Sun, 18 Oct 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327196; cv=none; b=FHBQGc3s5DiYBulKc8mwBHVy4XKU8bqvVttRKigjIfzpsDP4xuamt7HLqNZFN0vC7bvMIs9glRb69n3XgCeh9k6c0hJ4n4ZFqnELfEfCgXwV3y2rddFsfUNwYFFKWg6/p6LZkIH27tjHbiBGqbkKJ6KQda1jNnBV7f6n10S2XS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327196; c=relaxed/simple;
	bh=7CGVnbHH4ifPSoUPixdAOSutf0VYqPE3Hbqah0O8Qq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrtFyq1RcQNtlBy/qlGOa8uNygnu8M15p9spKmGC0y3rK0SNF+ufNnNBZeLOW8WWtyi/zly86W7+WGP5CUp/0W2W9yeGKixJ7DFUrL06lwgUQ0Ygs6H5ajhcKOsHr84kfj6xpbPq8FpkQjOQtWviZ5nobWjyJ5YfyFW1xOnLdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKa7SeSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKa7SeSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407E61F000C4;
	Sun, 18 Oct 2026 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327190;
	bh=JCOD22BRtjV6rZLwmWMzFif4/7LEJu4Pe64WMeMhP4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SKa7SeSC5caf8X1Z2FYTFJHtr10vOfefnsoYcYGzgXcWWSGa/m/rSLf30mCDM5Ld3
	 zMcl9MT2mhofzSeGAk8wc79UIUjLImQPFeJWP/YreaN4gPlCO2CeJn7/PY0zuZRmqV
	 4KmQxp8mCMNw2gUoWkjfJLClxnUrtGnVxJ6FGcgqrjZwXM2KMMiAhlS450skCB02Vh
	 wRo6tbIXP0gIFbzWQJXp+YBCU+XPxxlKitYJMB6tW+PvBPUpKoRCodSh5FYhn6dMs4
	 X5mR37lO4ydhbhEPzQS59ZqaEmm07rs+qSA+Y9RI3Mfru1o/EhCxAfq0YwY1p23XOr
	 CXq5beqB6YnYw==
Date: Sun, 18 Oct 2026 13:39:44 +0100
From: Simon Horman <horms@kernel.org>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Subject: Re: [PATCH net-next v2 05/11] net: ethernet: qualcomm: ppe: Add
 platform support for IPQ5424
Message-ID: <20261018123944.GC503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-5-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-5-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:11AM -0700, Luo Jie wrote:
> IPQ5424 integrates the same PPE switch core as IPQ9574, but has only 3
> Ethernet ports plus the EDMA FIFO, without the EIP FIFO. The PPE clock runs
> at 375 MHz instead of IPQ9574's 353 MHz, and IPQ5424 requires a different,
> smaller set of interconnect paths. The register space of the unavailable
> MAC3 to MAC5 must also not be accessed on IPQ5424.
> 
> Add the platform data per SoC to describe these differences, and add the
> IPQ5424 compatible.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


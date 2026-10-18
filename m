Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D0E399003;
	Sun, 18 Oct 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327291; cv=none; b=DUx2rG2lZwQU8XZ3jRFjWl3jhj8rbDEO3ynjOrfzhiRUdCPx4hFPVoLBjoxV03e4LtsvZFX6sO9AZun10sqKD8Iqw+buSduQr1VlS1DXqsSLa+gwgQJAIN0ZomKEyURNtKs5iXIlNx7MM7KAy0kJZ5c0Q/1mhng9pBF8NhUfPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327291; c=relaxed/simple;
	bh=z/TqCkmWGBYR2I/oEI3War4WwygPOudd6H4pY5cQdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCfg90SNmu/dBZfEEAPwTEgZV7AHAd7lh30996axBqO0R8bJBODO5npuPVNvDSaIVXuohejFibyrvWHkE8jnEpTlP9NBrAmxVyDkmx/bn0EiMvK9+3WJEGFkDwNMob4rCwmqsz+5itrxn3097ZN8oOgDvq+Df22v/LQZfmb1J4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJMvyxHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJMvyxHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D816D1F000C4;
	Sun, 18 Oct 2026 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792327290;
	bh=yaU2mmS9KwTD0r/VuHUiyEXCguJyqVDeJsliKq3Cvz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJMvyxHaK8HCzmM39dHB/sJkwIoczk4f0Q/T60jeKx61Z8B4KLo/bq2bWoAKwede3
	 q5ZEcAP4zYsxPQKeKo6DAnzTCmzNfSmw+VYwVqmpm4e+uq6pWddmhlxXItHs6Ff3rS
	 pYlSfGUsxL5/JeZdCfTnFfjoS7j+PC09ps1p0/lwjkyPjdsLdIA9lGAV7YIiTXci+c
	 hdFeNmqvcKYP6XfGE15UwdBqimWed9ndJaTRhOS0Pk6enjs+TTYdH9XT9v7cyDSNP4
	 jy+DpsQQrHGCk1SiXsbipVg6bvEF3DYVLhjNm+rOjOHtICEBxQ/7NY4FZcqNO20uft
	 6YQGYF+BYTOiQ==
Date: Sun, 18 Oct 2026 13:41:24 +0100
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
Subject: Re: [PATCH net-next v2 10/11] net: ethernet: qualcomm: ppe: Add
 IPQ5424 service code configuration
Message-ID: <20261018124124.GH503057@horms.kernel.org>
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
 <20261011-qcom_ipq5424_ppe-v2-10-8c7b057e2c43@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-10-8c7b057e2c43@oss.qualcomm.com>

On Sun, Oct 11, 2026 at 06:02:16AM -0700, Luo Jie wrote:
> The entries of the L2 service code table are 0x20 apart on IPQ5424, instead
> of 0x10 on IPQ9574. Each IPQ5424 entry also has a second word holding the
> extended egress bypass bitmap, which adds the bypass of the source MAC
> multicast drop, L2 flooding and tunnel exception counter control. Add the
> L2 service code table stride and the extended egress bypass bitmap for
> IPQ5424.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


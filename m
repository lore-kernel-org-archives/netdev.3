Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399729;
	b=YybtfBti1DK+kZ8sUwuPKuaG88GP5rM97jaBifFY5J6I85f+Dl1iZPlMdUYyPn5eW7Z6
	 R66cOON2V+xLmu/Q+66fJznyGfh3hBuDpVD66tVAxQQx2i0lbim/NE9fXJZHf4GVBMiXN
	 iaKbOzfdNEeCCOwADkjPNgS44dav9F1NAdGEhqCELgqL7tSC+n1CPui+8qEZppP80MD7V
	 /boNMeqoMq0IkDtEfuHC20wYHtoGaJ2aHTOFKD5qqteBFDuPFldo24hWUhZNl27g7qsOd
	 flvrHd1p4ZMII8G3PwYVBLpab80J0zWKqK3ditMtRrMclc2TzV+M0lhzTjM5FE1WMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399729;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c5FNLKpGPBXCzLoL9l9FYqQQEEoOEWsMsTMyCRl19Zc=;
	b=RUOqaBEooDZQOFPGKiA0kIehvb1MzX0Z4/7lf4tygjxE+pSNwY7xDKLWEcNGvpwzCGuN
	 81njK/pB5GobTILXhTpf7VsAuslLNIosgrk49QW7ig4pEVOCRnjrYi2zKNVdKskCQ6z/R
	 fGuPhIWGqhARyTyIOwL7Izj06htEg3PjGHKvWkHLvzALz02SuoEER12AF2XIF4bKF08gC
	 sUsar+sN9Xdb51ONLlN1SqI+l+EWbyS94Vf6cGU3JcFhbV4I11A87wmsLyb10OuNrv1yq
	 vC38Y2j55mYMj50X8f6bFmGp/lPQ8LNNBKjyPGjGe2ltG73o9WRSWfMsGEZXZP10uCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkAVJTFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF6606A31F;
	Fri, 30 Oct 2026 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkAVJTFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413221F000C1;
	Fri, 30 Oct 2026 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399728;
	bh=c5FNLKpGPBXCzLoL9l9FYqQQEEoOEWsMsTMyCRl19Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OkAVJTFC9nkaS2ADOIv0tIoJtyBH5qhu95EVA4oWXJ/9qsc1MQ49NQkqmXHuTpWJB
	 5v4axZyEgRpEmHfSq0Jx8tpk1n+Zd2gKVOmVc8a3+IWqMLdlmcpfdSQJ9zfSqd6KqH
	 JpDExDI0wOP1MrsvLnPWUplPPLGexHaWt8pmY3YWUOULaZb793BmI6Le7gGSD84csb
	 aY6K7OEsA93vjujjjOZtJGFnbA/QmhnpevRepB8vdSmKj14O4YPXRvrvIXNYqFLZ0f
	 K4omWD3TnJtL1ES/mSuYcX390OmnuLkv5suaeQ1/2w7K+vmXHMvJm9qoehM+AAIXJ4
	 01OiWnCU8Dsfg==
Date: Fri, 30 Oct 2026 15:35:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next] net: ipa: Drop unused qmi_elem_info arrays
Message-ID: <20261030153527.161df2d4@kernel.org>
In-Reply-To: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 12:11:00 +0100 Krzysztof Kozlowski wrote:
> 'ipa_mem_array_ei' is not used anywhere, so can be dropped completely.
> 'ipa_mem_bounds_ei' and 'ipa_mem_range_ei' are not used outside of their
> units, so they can be narrowed to file-scope.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478673;
	b=SzEj6ceik8+tjnkgWikf10SqRxdJGV1kIxuTSRu5gkV+F+D+llkwbEJrw0tmjm160dmz
	 9sqy2Kx5fkD2cztMj75cErGny9rCXuoqrxd8zNMvlRpNl//JppM/E+WzkFI3tPPuJrFdw
	 cR72lI+buEH0EJ18nMRNaLd58R1PRy/dq7SyOtx2zC+g9VeBS8vz6rnYbSEZ9YWPRhbBX
	 jmMNgT5n2Pj/HkcFXq+e6YFv6uH1wQ+YjgjZTbfqK6eYPrjVb1lIzUOyJkcWNzu05RNr1
	 qgr+Pcd52iEJJT1blxuWJrQsI2H3Si/OTgwmDVc00EEcRf2rWC9Vn0OFMc1QKlizGpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478673;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=n18gPu9ynUrFFEWOzkb6UNwldNeglT7fx4isg5Ir/4+kOMdFBiBnt7Vl4/YeIxfHzyWl
	 fMASi7Zniqo6VbLCk7d+OpTDtntsDTTrxVgY1QOsmslAN+HFCr5b+r6jhReWzwQ3muq8R
	 dOgGakLlOsD2g3GWBhstSxaem7w4z8FtFEV+Y+2DT6q2o7F0AEvM9wJeiylWsjKG6493c
	 HuUDs1f9TxxAQOh5pvVa68ECqzOh/tGGT34FP1d+7tAtSqWfsx688V/8HvKVyf93Bj2xh
	 EKjGRZkI0f4ntrwsN9+07W0LcM8Ee6NFX4aHxNZvKfR9bNBM1S0EpnDxjarwyjGTe3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2r2+5aY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FC606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2r2+5aY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7BC1F000C4;
	Tue, 20 Oct 2026 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792478672;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2r2+5aYj+sqfTgDMSoIBUe7QP32sPyPU20E17uH7y0XQPB9EgJS2/+WwUchUSg8V
	 jPs+aLb1+OC21Oto0nWrmPFI8lMj7CG0H4Bzxv1DujA9lXWuYdEBXqhDg8fD4nHZl2
	 j7n5Tvm38VjW2oNHQn9fP0FVcLMVf9O9/2VHScZHC7TMy08WeDvBZe6dk4i6mHsSFo
	 /wO+3cMVjAGC2CRSE6eabevAeceFrDJrvgQ0LG5/XhW9pgecmSXN75LEZGalrLqgS0
	 nmFUXudIIAKREutxpmVvckK87LJG+qPtYbUICk0hpMTS+LvusUIfiaFHfFS3Zz6GJt
	 5LWWmvZNv7mlw==
From: netdev-bot+sinfo@kernel.org
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v6 0/1] ipmr: only copy pktinfo to cache reports
Date: Tue, 20 Oct 2026 06:44:19 +0000
Message-ID: <179247865901.3290.5065733117090403931@kernel.org>
In-Reply-To: <cover.1792476357.git.zhilinz@nebusec.ai>
References: <cover.1792476357.git.zhilinz@nebusec.ai>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

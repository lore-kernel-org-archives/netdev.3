Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310D1A5B9E;
	Sun,  1 Mar 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378362; cv=none; b=KPOG/cskEJq6sHW/J/qNMz5J1Gr+dPvv1E9uwUR1ccGMT6bGxscRspRvDrDTFuopCJZNMrsVI2vtyJUTPS8Nr66mPPHWfrC2YnlT4D29JvAaCDAFKXmaoWjvEcSY49RYePtsATWkh0PR8PAU6BrJnSA06Ptqba7UhEB/wwl73lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378362; c=relaxed/simple;
	bh=hB707/+Ouy6yZ/tsRxs6mF6HK0lnz1ZcYlJIo3R+opo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We5h28n0MrIvHiuanVEOPrqz/FqjtBZOjo7QnC2A2a4lbcYpFvnsph9KBkGnDArfxpgZpkLFBEcKF1qbBPt44PcnBC40U0mURPXmug6FTbvt0IXVNRFSoLpJQ9k3+uxirou80DaL3LBzYr/YID/r/dEpmjdoVq3SVewo67hoR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qABzX0wG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qABzX0wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58C5C116C6;
	Sun,  1 Mar 2026 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772378361;
	bh=hB707/+Ouy6yZ/tsRxs6mF6HK0lnz1ZcYlJIo3R+opo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qABzX0wG9YYwmJGjgyJ1WmDXMAlIE+uA66pUspO3Wah1T/gMpPmVxDqvJ7Q3x49RS
	 /zUJ8mExjYuhVD9XCjeiLEIHMzx3uOSz0E4pQsKEzv/YGqAzNnwdslvFvAInep+Hwg
	 4HbQo+qaJt3X3hcAa+PefeFJiUT7g8tV5knOeD33lF3inZxr5EiGoU9cfzvb3nwLP3
	 H0lOoTEh3KeN3tNNgpmpTzgNE8h72Rm0zCVRinFIZH772xzQkrcindULVCrOffqhgj
	 qXSmtTBpB7B9OgxRBCVZQouiinNQj8CzdLTr7X3k9aiiqF6DX/gvCgmgsi+c6e8UbN
	 ZUjBmjv4nqBbg==
From: Simon Horman <horms@kernel.org>
To: ynorov@nvidia.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	akpm@linux-foundation.org,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	david.laight.linux@gmail.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [RESEND,1/3] bitmap: introduce bitmap_weighted_xor()
Date: Sun,  1 Mar 2026 15:19:11 +0000
Message-ID: <20260301151911.461034-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225000007.255837-2-ynorov@nvidia.com>
References: <20260225000007.255837-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bitmap: introduce bitmap_weighted_xor()

The function helps to XOR bitmaps and calculate Hamming weight of
the result in one pass.

> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index b0395e4ccf90..5485076bb2d0 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h

[ ... ]

> @@ -352,6 +354,18 @@ unsigned int bitmap_weighted_or(unsigned long *dst, const unsigned long *src1,
>  	}
>  }
>
> +static __always_inline
> +unsigned int bitmap_weighted_xor(unsigned long *dst, const unsigned long *src1,
> +				const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits)) {
> +		*dst = *src1 ^ *src2;
> +		return hweight_long(*dst & BITMAP_LAST_WORD_MASK(nbits));
> +	} else {
> +		return __bitmap_weighted_xor(dst, src1, src2, nbits);
> +	}
> +}

Should bitmap_weighted_xor() be added to the API documentation block near
the beginning of this header file? The documentation lists bitmap_weighted_or()
at line 48 and bitmap_xor() at line 49. For consistency with the existing
pattern, bitmap_weighted_xor() could be documented similarly to:
"bitmap_weighted_xor(dst, src1, src2, nbits)  *dst = *src1 ^ *src2.
Returns Hamming Weight of dst".

[ ... ]

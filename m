Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793573058;
	b=dUvJscVDYdPLp+qjjv+kQ7Y5xQJJdznQUJcQ4HYOYEHM0x2ArX2eRsURC2M8JRfXXQDZ
	 pa/vMES6id4bZEVKv4nXMX6D7mWRW6SwKK+iXX/3fQG1rZpJM8OLmsurywgvp+eorwXGP
	 k9u0ZMRI7DBoAR9OMiCpGoNpJ29oaRtkNkoCkLKp1Eb/zW1LpO5r15h8FEfCDenB8ZvR4
	 LhZubuquownlBU44WmQIQdNWNqggJMbnghRERk40LhzVK+wkOIzTscOSpqt90Rjg1b8uz
	 YmpfQLAABWy+kwgIa5GAT+1E6g2vnRL6LflEgP4GuRsz/Vb5hEpU2pSZCrFX8mC2Xvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793573058;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MD/ud5bn1lltcSGfJDPA5Z7qCcJ2gM0givQb8/vfVIA=;
	b=1MfxvmE5OfAFuofIclP6f9bl/gwwq2D1WiBDOwVWvB+0eLuGMiHdupPkF2JEWbhNFmfA
	 vtOuHxpn/Ht8qot2Gmbu7VHeQvyY2FuY/SUekRzeEHJSSqTC6PplmwqgUeiDyvTB20bmX
	 Hw4cmCa2t9grloPhghGHC/kZb5GCHqbB+/zAQ1GvTOnLftO6LZ6BroB5Rxzb1gDqnT494
	 jCucH7lD2KaeIUdRt2NF06qEzI9FpDvGHCSw6GM9i4cqn3Lt5xKXcejdbLjPOkeET/lEd
	 3z8Fdylk7WdMPiXDSFN6OmvHf6N9+KSen+wGntHYp4oTNlGZ0MFtC3Q6fza2pyvtYzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gr5Evwy/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5E606A324;
	Sun,  1 Nov 2026 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr5Evwy/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AFD1F000C1;
	Sun,  1 Nov 2026 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793573058;
	bh=MD/ud5bn1lltcSGfJDPA5Z7qCcJ2gM0givQb8/vfVIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gr5Evwy/mzkVY6iMhTqthJIBmxhEOY8fNWU70xm4NNhLEyRs0rbrQzYfn5Rv7lcP3
	 tyHeIrtvP2VZD3JWwedOEHOxHljajeeQC4KEfZf0NRXAzmfWzSOH8pCHtzzCqXZ8V9
	 4csKCjl+7fsZ3R7BMbruYW7YepqhcW538tjenuo1aJv3EUvI1St8qUROn2JOZ99sMJ
	 jlgj2LUGct+A+8P0ZHIOfmBJgYhg7pf6txxwh8d24dM5vOkU8GiGFm0bHYra3k9xPi
	 lUTtwNcEr5oiq6MTGTHbvvj5i7kkHLWmhjwRsUaVmbEZpQ1DD/2b4L7IGwhzFNxXhz
	 tyldoud8rPfQA==
Date: Sun, 1 Nov 2026 15:44:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Demian Shulhan <demyansh@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>, Ard Biesheuvel <ardb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] arm64: csum: Add fused copy and Internet checksum
Message-ID: <20261101224412.GA1185206@ax162>
References: <20260927131838.6774-1-demyansh@gmail.com>
 <20260927131838.6774-2-demyansh@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927131838.6774-2-demyansh@gmail.com>

Hi Demian,

On Sun, Sep 27, 2026 at 03:17:57PM +0200, Demian Shulhan wrote:
> diff --git a/arch/arm64/lib/csum-copy-neon.c b/arch/arm64/lib/csum-copy-neon.c
> new file mode 100644
> index 000000000000..bfeaf2beba39
> --- /dev/null
> +++ b/arch/arm64/lib/csum-copy-neon.c
> @@ -0,0 +1,168 @@
...
> +#include <linux/types.h>
> +#include <asm/neon-intrinsics.h>

Please avoid combining these files, it will be forbidden soon:

  https://lore.kernel.org/20261029135020.272082-9-ardb+git@google.com/

-- 
Cheers,
Nathan

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12C3C344C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165114; cv=none; b=FIMRhTJzsA9RFk/2u+D7XGuKKbTiRSNVYY3hycGLGHVsbCS8SemotgISOoPS/MkcXXnWfw9PUvxKCu3n7FN0viAO6tzN9qI9h7XG3z7bUQTB7Qzb/CrbPsh69K8Jnt6jjCd+awJA4cK4zfyECa5UTAzjTPTEwFBWUTsUFlAVsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165114; c=relaxed/simple;
	bh=TSnXaaPqruXs3gdxV+Buu8nwmDzSwImeABfSOuWuGv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwKqV1KC/KfwsC5rHb45eM9rEg42J65Kl7l+a/f8oNHVjOLbFKvLfIud5gtvOcVARS6uECxt5Zw731K6uKxctqFN05t1AHt7DoOsOSamq75ztUvsMZSSBqwzG2vIlj423INKLI+NIk33KJbXlHjYhaeSL6/Fg8ZEy78iemGxF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAZXCOiL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAZXCOiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A0C19423;
	Tue, 10 Mar 2026 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165114;
	bh=TSnXaaPqruXs3gdxV+Buu8nwmDzSwImeABfSOuWuGv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAZXCOiL/xL4Sih7BB2s5ifjEcM5ZQ4GsEZyHUh25UGKNh0rZl54QgmkiI8K7UjxQ
	 Fn9beUR7PZAgdDnbREr3By/WMb2HRh7P32Edhl4Y/fWC8okChGNRKF8PyJXAUftEx0
	 6HL/CnsvmSW9h9BsmERMEcI/SWNIwPUgZaKMcHXgAquoqG20RewLwC1jcUP56lSG2s
	 pF39y0d8Y+ye8/7BZWc3OHbXGxWfwg8bolKnGtHSrmLXYWO3XRa+jbuOrmc+bZZFU/
	 6jRWB4Qjj0uoC7YDgh0gsrrnvEEoJ93/PMyenMe/RjiBDWxKpFwQa7bCKmhjLLYZjT
	 IgMm4/96kyPdQ==
Date: Tue, 10 Mar 2026 17:51:50 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 00/10] xfrm: fix most sparse warnings
Message-ID: <20260310175150.GO461701@kernel.org>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>

On Mon, Mar 09, 2026 at 11:32:33AM +0100, Sabrina Dubroca wrote:
> This series fixes most of the sparse warnings currently reported about
> RCU pointers for files under net/xfrm. There's no actual bug in the
> current code, we only need to use the correct helpers in each context.

Thanks Sabrina,

I'm really pleased to see this addressed.

Reviewed-by: Simon Horman <horms@kernel.org>

...

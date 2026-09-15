Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8C1A0B0E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431902; cv=none; b=bqioQW59qoRfWnAJmjEmQIFBySL2NoNqN93BUN8bBIFWsvyJW+vdozBj5xO87iaToUQOXRszVnYHjlahtv2lrZOKyfODVlnomDRU2qzVDjrQHdGSMNyXCRXfGwRfwB2DFsONFwGhVzXbIT75Auwj/rX/7XvGb4jITiZfYhaju9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431902; c=relaxed/simple;
	bh=skyTWLyhpbZvo8IGXazH3wp8Hu28Ab9t2e6O9YRhwQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMNFYCtUI7FsuHpkslz4WMgFuuKrs9lybn608VEkzPCqTw1BtRhQa+REu/TiVP8YLV0wznSjQ0AZwbct2zJ5Rvu/yrsVoxCDalN6IKvHDpOpp/Dp3GJqOszRYpUDCIcmxeK2SSXe3wDOXjqUayW1iVHmSUIZjqtL9l+t7+m1iJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7Hx8W67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7Hx8W67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CBD1F000FF;
	Tue, 15 Sep 2026 00:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789431900;
	bh=skyTWLyhpbZvo8IGXazH3wp8Hu28Ab9t2e6O9YRhwQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z7Hx8W67LW1f8IJ6lXHUiOTy4rvdEDkUUcJcAVZA+29nWvThfigsxhndcyO4b0cCY
	 QCu6OF2wpFStUON1nbbhuLO1ejLSbkNjwFv2cNhuVUrmMNOVsyVcS+bmaCsLmXswMG
	 atmsFY31TwPgeeVhwHujx4LrLtWJgBA33i1wHisHN59r/akiRZcb8KeVWNWCZxlyW5
	 L1LV8VogmcSl0sarJX7v3BMI2e6Cw1R5AK/3jh8znTEDQFN1HoOJGfPnceiYWYFQWd
	 EhbXRZWZYroW4O1rTgjDiIG1pbqzMl1WLrYHWnAaXqSEAsM3QSc/9K8/HbwEjsV4+P
	 Sp/bNiZLjukpA==
Date: Mon, 14 Sep 2026 17:24:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCH 00/13 net-next] Allow compiling an IPv6-only kernel
 network stack
Message-ID: <20260914172459.04db43b2@kernel.org>
In-Reply-To: <20260910144914.8025-1-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 16:48:25 +0200 Fernando Fernandez Mancera wrote:
> The primary goal of this patch series is to enable the compilation of an
> IPv6-only kernel by decoupling the core networking infrastructure from the IPv4
> protocol.

Could you useful to know for example how many of the recent CVEs were
IPv4 specific, if you have enough token budget to get such data?

High level, I don't have must to say beyond what you already know -
the code movement may be too painful for backports. There are too
many ifdefs (as Stan pointed out).

sparse also complains about patch 9.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542B30595C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029898; cv=none; b=gmgqL/7kq+4zKRtLbwAtSKAChlkxLEtwAyWeQwPdjRmn5VY4JcVrpIB2sJVnqDbOX0o4aDEJNI7DVijvLjWHXe/p5xfVTX5f8BlioVXKsIUXXa2vMjE6JeN/yxBFrAxoIj4e9rA8yglX1BRgFef2JAtkjj/srYIiTgnse8Oyrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029898; c=relaxed/simple;
	bh=MWjx9x4Xl1BkLqNJhEJUVwdMpzVxVl0W3+B/XEfda4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6NRdiwHHA36hkZyM2u3rN49DTBLEPfjE0GuhCylaNDzuv5kk2b81D70vU+Pqxm1uDeEYftldgb0MI3rKqKVOT6hPYnIrc7vhcG8nGfBxicX881xGB6xiKa3OwTFJUlRdScW/CMPw1Mno0fFM7OSbSvBFX1RmsAY2kj4Tq75F2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc0AiC8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc0AiC8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCA6C4CEF7;
	Fri, 20 Mar 2026 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029897;
	bh=MWjx9x4Xl1BkLqNJhEJUVwdMpzVxVl0W3+B/XEfda4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dc0AiC8HWTroundPkJREjzoBqtTidxTGkbEz+xDedXhWDrPx+RDNPXHM2KD8gmXYP
	 KpwKXdRQsTfzAR63tQ32OonJdjglD3N9CjI0f0kYajnGzR7kYcx6YSPu9sgB8on4YR
	 rTia+oqnQNk2Q00ZewQsImi8HfDjswi89+oGBuhAlq/Jw5q3H5333iefqkdemL3GWy
	 gI3OYciTiYbAeIInMnOA/CbABpSZYZtbYo+jWofrouZ6jFius9a8Pes+KTxxdnIptf
	 DmchDyYme+S4+lisudfyRW5i7gtFUvY8zjAdR0tigvgaYXtVzBmzLWPpBY+5cuiolK
	 iQUrB6KfH10gw==
Date: Fri, 20 Mar 2026 18:04:54 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Subject: Re: [PATCH] ice: add missing reset of the mac header
Message-ID: <20260320180410.GA151863@horms.kernel.org>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050518.422303-1-aleksandr.loktionov@intel.com>

On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> 
> By default skb->mac_header is not set, so reset prevents access to an
> invalid pointer.
> 
> Call skb_reset_mac_header() before accessing the mac header from skb.
> 
> Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Hi Katarzyna and Aleksandr,

I am curious:

Is this a bug? If so then it should probably have a fixes tag and
a bit more of a description around how this can happen.

If it is not a bug, then is this defensive? And if so, is it really necessary?

...

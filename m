Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DA31D371
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221923; cv=none; b=HJ3++EidEk3oG2X6H7oozGVS+8GlbAH7YYOucfWQq65kECLWDk4lXm4/vaJIg/9ypSJPbLemznfiHUlHo6ht430ozmq9tK1RPuD0wHORgewTVgefLyrVtyLtdXuVDGCG4gNB2suSufoecsWrNO9o/IXnmXgNbhEYyyjIqfkCESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221923; c=relaxed/simple;
	bh=T+s+iCoVRkohAWcg4ruPmHUjFaW6+4Csag8Svk489mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAqJgQhB7WEYtgGEqB46Fm5kb13MCKHFhvjjkqOgquWcY4eTA/Jet82WHafoOnPd5Tm/qCDKnIZKIpvxhUuKBXWiFR2ND6zCV/WbVnrbKBMTeaMLzwAsQWoI1D/YSgA2yov5TilRy9Z8hxQeB4B/ckfMIi3NpyZOYjdpg9oCDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ettOQZC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ettOQZC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B15C4CEF7;
	Fri,  3 Apr 2026 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775221923;
	bh=T+s+iCoVRkohAWcg4ruPmHUjFaW6+4Csag8Svk489mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ettOQZC72jVo3u/L/CyFoODG/udj45u2YKVbfWwiOZk1/Y8KlwbuMQRtr6ijz8bJs
	 ozXBpcOV6UiNPMV05noWbgZ+oUSH6DYQFJ2mUbHzz5i7/jVSvm9mtqe0B+ZzDCodcO
	 POMirP6GmG2KvyIuyu1lvVhHPeAB3L38sKh6JaDY6YtQxLigwQMMRuTT6VmnxUIJFB
	 U3cE5WgV2x6vcbl+JUARBITVSg7emiN5qORqmbDx/Gz7Rgq2u3D7HJOQ5jT6I/0VSi
	 vFO9rc0wb1k8HaW3vX2QDGEX22grwJz6CVhHJLbwBYTgL7npywONgzBRVddc/THW/T
	 7V18u18tLxwBQ==
Date: Fri, 3 Apr 2026 14:11:59 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
 ixgbe_ptp_reset()
Message-ID: <20260403131159.GA114708@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-5-aleksandr.loktionov@intel.com>
 <20260403131035.GA113102@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403131035.GA113102@horms.kernel.org>

On Fri, Apr 03, 2026 at 02:10:38PM +0100, Simon Horman wrote:
> On Fri, Mar 27, 2026 at 08:30:39AM +0100, Aleksandr Loktionov wrote:
> > From: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> > ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
> > avoids the unnecessary intermediate ktime_t variable and makes the
> > intent clearer.
> > 
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> FWIIW, this pattern also seems to exist in e1000e, ixgbe and igb (twice).

Of course, with this patch applied it's not present in ixgbe anymore :^)

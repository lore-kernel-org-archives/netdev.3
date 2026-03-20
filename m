Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422D3CFF54;
	Fri, 20 Mar 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026570; cv=none; b=X4z9jhROF2pS3OxXOkA/IrkceN2d9gTiIsoDo/naASB0xULrkNFSTXPk0KO8GeHfWI2DnCbC/gjx09yINU8Bujhsb7uHFgc+oujQGesjn1Ff8AMAlbd3BQ+FQXwVikMlgBRPP8cCn8kbhe247TTYeWNtRXwU2hi8z8E63Fq5vd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026570; c=relaxed/simple;
	bh=lRbE13y4NP2q1YPi151RjqScvqFxmQUg5LjL6Onp7Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3NLEnsfCfqb5Qx99hVCHMUIqmozAcKqpU/CTv2NXfhTwefqSi35/0poVHpH3tjrd7Q/8Ko/ASr/UGzVNaT9fgfts5DdzuzSn+US8Yn3lXbg3I/gsFzI6PZ2IeUIPi8cVheJyssYu6HHKtmhDAYIgbyEH8lDS5kRC4fq3r1bS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA+BhzT1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA+BhzT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E1BC4CEF7;
	Fri, 20 Mar 2026 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026569;
	bh=lRbE13y4NP2q1YPi151RjqScvqFxmQUg5LjL6Onp7Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DA+BhzT1JbT/eC+GkBCKUPLNVjcEM252ppfZC+ReJ0qVaF8PvftLgrU53I01sReI+
	 UBfnIQHKbWTgGcSsSW/Zkj+s9r9TqamJRVLFfSk6VQs8vHNs0OJV8pQEqtPZfmInvh
	 htxzvxLM7ho0Q2Xg6gSC/a+kERxrzWP6Hm1G9N9RBtrfCKCy4nw50c2yN738vDJYLh
	 z1Cdl/hNsavUazIMl01i1N6lEdiWupiqW65ugfoQwv8/HdxZCgAfely7jYQO1OJ8p/
	 T66NJP/ytYil7Go86OnWAxQtgm0tNTwes0nZFHJ+ISz3asyx1VyBjluJ9o67CW4OWN
	 d636jAkIV5mnw==
Date: Fri, 20 Mar 2026 17:09:24 +0000
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2] ice: fix double free in ice_sf_eth_activate() error
 path
Message-ID: <20260320170924.GD74886@horms.kernel.org>
References: <20260319135859.690041-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319135859.690041-1-lgs201920130244@gmail.com>

On Thu, Mar 19, 2026 at 09:58:59PM +0800, Guangshuo Li wrote:
> When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
> aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).
> 
> The device release callback ice_sf_dev_release() frees sf_dev, but
> the current error path falls through to sf_dev_free and calls
> kfree(sf_dev) again, causing a double free.
> 
> Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
> avoid falling through to sf_dev_free after auxiliary_device_uninit().
> 
> Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
> Cc: stable@vger.kernel.org
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - replace goto xa_erase with return err after auxiliary_device_uninit()
>   - avoid xa_erase() in the auxiliary_device_uninit() path since it is already
>     done in ice_sf_dev_release()

Reviewed-by: Simon Horman <horms@kernel.org>


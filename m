Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F37569F11;
	Wed,  9 Sep 2026 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971698; cv=none; b=j4cpI0TaWq/OxgyR+7a8ef3h5QTCHhfanpWIjBTiK2F+K4+wWj6Bbu4z4NRRqbY/+XY35QsUlBGUCce9eiGTxPG43RnMOFGQPZkU2jWkFrh6GzN1f7bxrIQZQXSHtiNk688Gl4CAxzOdWeP2/wpeLAZfPlpCfYV+DjbOcSRV8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971698; c=relaxed/simple;
	bh=AJosHRiltdaJQeJuYItimoOXrUKLXOoLRzS5Fbg4pIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC/PlElToSJXk0QdZbtTBXUEmRmD8puSK2Q6l8mvLQhB8iw1Tx7nNupZxvC2k4ZFWgVOD2U31iI57kVyCXdKLQKlX9heL98/k0h1EapRCfwiCW28UWUQlrqCE4xVRplVMthR9jC2IcZf6o2VI7gaCWY1fZhr0MEcBITfiV4edjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFxjTIeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFxjTIeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFEA1F000FF;
	Wed,  9 Sep 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971696;
	bh=5ZW8mJSSRbt4z8FIorznTchbxNHwNY1E9R6Ym2XRaPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HFxjTIeQlXwoKgzvENuYihkIOroeXm7nP7YouPDAiNEnHnCcKVoByNUW/6wj7gFIa
	 +Qy4FRMWxDmN9pqSO81Pu9Za3+rwYbzZ6vPqe3LJBygxKO7Hf/Phf/aPl5euMGrvVd
	 h2MuHMHSoPSVamT1hxYEYy5/D/1wQFDv7DVizAYpVE/MobT+/3rssJTV9j0e1/Ya7k
	 iOPmEI6zX+ZNR/dpA3HbFHm4JsoDQMd+kJBw7USuZKErk06+yKRWTviEuDGcEErUJA
	 /po5+qUCyeAT+E3h6SSgETqEn8MaW6N59GbB9PixvT1Xs8cTo+4JhG9FkEn85A7ZmE
	 Pwe+S5V5WQbaA==
Date: Wed, 9 Sep 2026 17:34:52 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Hangbin Liu <liuhangbin@gmail.com>, Kees Cook <kees@kernel.org>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hsr: enable promiscuous mode on interlink port
 with fwd offload
Message-ID: <20260909163452.GJ40544@horms.kernel.org>
References: <20260908090856.2876114-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908090856.2876114-1-danishanwar@ti.com>

On Tue, Sep 08, 2026 at 02:38:56PM +0530, MD Danish Anwar wrote:
> hsr_portdev_setup() skips promiscuous mode on non-master ports when
> hsr->fwd_offloaded is set. fwd_offloaded is derived only from the ring
> slaves' NETIF_F_HW_HSR_FWD bit, so this also skips it for the interlink
> port, which never gets forwarding offload. Without promiscuous mode,
> the interlink NIC drops unicast frames addressed to hsr_dev's MAC
> (e.g. SAN traffic to the RedBox), breaking RedBox whenever the ring is
> HW-offloaded.
> 
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


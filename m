Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341A331200;
	Tue, 24 Feb 2026 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925589; cv=none; b=cAVOKVXMOP5Pz/7zdkzPovdf7Z61KBv6fDdwTEtuca1bTSlRkknyMd7AyrybaNnEIYcIsbSmzKMZOFvXqI/cPc0AN8DXH1SU0Fn9Cwiq/OtMliIKiAOFjwmlJBHrkyBnjFN8pH2UPl7d/ql8G0qevliOaRsZ4vEZcHLaw9B4k1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925589; c=relaxed/simple;
	bh=KCNvZegegypdUKwkKw7IGULuIhmCSY65Uy0Enab9uww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvQAiG3QkdKLMjLZ7kqAZWjnUgyg0ED+SHy9wtMt0/5BZVIQM6fPgnqbzVanJimylkqpbfDJ51HFbieaZyR/5vCsbdAbcwYD3Tp4hUpfBv2MlW7iIAddAgBZ6KuFA6KHYSFsqAJnN7Cqu/Y62NNhLnY4etF1n+c14sBlTIFJeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLafBy2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLafBy2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B86C116D0;
	Tue, 24 Feb 2026 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925589;
	bh=KCNvZegegypdUKwkKw7IGULuIhmCSY65Uy0Enab9uww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLafBy2qtVlyPWiBaZOcUPnvM4NPh70XwsIVf4VKgIySnH6RoSygMzPpW+ip/Itcz
	 KHBQp9/Iwhv2g4HNli2hhT3/4kInVh1yY7C4rkfU3rIOzCacI3lSWJ8XdLLRJxaTaZ
	 vPIHdvZ+EBy6xbHPg2G+VtwbcY2v9Lc+0NVhz0vYMHFXJagPilhTmJZ4a7EHdgvEeH
	 vbArteSTWDKPghp70tflYpLsgWClTNfTCwTlxvegWiwvAaByQR8LhSLb7OLBzEAQdm
	 JzaEYRe9iTVK6Qyjb2Ypdpxq2Jv2Xx5U9vZs7Vhkvsq+JlaF9I7FOIxt3v9pss6xjm
	 R+LjvEW5Zi2tw==
Date: Tue, 24 Feb 2026 09:33:05 +0000
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH] net: usb: kalmia: validate USB endpoints
Message-ID: <aZ1wUS9hs9WZTb-o@horms.kernel.org>
References: <2026022326-shack-headstone-ef6f@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022326-shack-headstone-ef6f@gregkh>

On Mon, Feb 23, 2026 at 01:59:26PM +0100, Greg Kroah-Hartman wrote:
> The kalmia driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg,

As a fix I think this warrants a fixes tag.
As this seems problem to go back to when this driver was added,
perhaps this one:

Fixes: d40261236e8e ("net/usb: Add Samsung Kalmia driver for Samsung GT-B3730")

Regardless, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

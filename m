Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3644FD792
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744392; cv=none; b=GV6XwfzOQpHcASFR/4ZP7DxxF3QnCut8ZKvid2RuRuOEvpf6Rv+A4EjLF8GNTgOFEwUWYU+ZFPZ4+0rW6pxUdkmYkuI89EnNNspkHMpD055qMonjiH1KC3Ko5wXiIQkq3GeI7jizl13KgBsCCpRHOY0SsHP8Yzs0cVbcKKzBDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744392; c=relaxed/simple;
	bh=8Rd2gAmqh7PcyTaNtd6aLSunPNFcmK/bklUDKAjBd4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tla9NMUiXausOYL1jhkZLuCazw7PrAZV06SKis54nrlk3nIb7NDpa8vzpMoq8EIzd930ztInDFVITgwmYUytybD4J4R3Lzeoe31vQSFm268B/M+eAigrtTSxNqXRg0Tjgn4ZQSeHJ8OxJjkNEMT7wNfBO15K/rO0cbVx+RoIppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvXcNz/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvXcNz/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BA81F00899;
	Fri, 18 Sep 2026 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744390;
	bh=L/nor5Xs+3qqWQOS1MAPVghILT3WgphX5IsnR0FN3ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IvXcNz/3eYR8O06yvOOhBgc3YzBBSJayfQOMfy7wW7FOQXrh8wxC8B453SOCl3s8R
	 NepUxD4eK6lHOMSCZBean/rjNIaZf+g0H8COIl6jy4DeG43Dm8olLZakWLMQ/2SNb9
	 9wMrf8AVYyEfX+zM/mJ2J3UWy+3IA8XYGy6kaUOqJDQpJOdg8tTeiTjcSMmOL6CTHx
	 PIYyTM29JyCH145e4jaGxU22pQDF7g/bblVckc6+hBClGUFXPsZyVjO90zavdcwGaI
	 tXkc1tYQrINnDL42PBiKEtn/+vRO2XfAIzdeHgJmrih/uhaTvyv2CNr4TegR4ov+IZ
	 4rFunxzlTB5cA==
Date: Fri, 18 Sep 2026 16:13:06 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH iwl-net v2 5/5] iavf: return 0 when TC flower filter not
 found after qdisc teardown
Message-ID: <20260918151306.GO51261@horms.kernel.org>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
 <20260915125551.3976068-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125551.3976068-6-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:51PM +0200, Aleksandr Loktionov wrote:
> From: Kiran Patil <kiran.patil@intel.com>
> 
> When an egress qdisc is destroyed, the driver proactively deletes all
> associated cloud filters to prevent stale hardware state, decrementing
> num_cloud_filters to zero in the process.
> 
> The kernel netdev layer is unaware of this implicit cleanup and may
> still try to delete the same filters individually. If the filter is
> not found in the driver's list and num_cloud_filters is already zero,
> return 0 instead of -EINVAL to avoid confusing upper layers that
> believe the filter is still offloaded in hardware.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

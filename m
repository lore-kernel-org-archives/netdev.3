Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CD3385A5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510683; cv=none; b=TVkHm4ABPOGUiLw9wnuIlCOIrHPLeR3+pbtXYJL4ZjkUnrRE3wOPAMm/7aZwCm2KdhUDV5qsGD8JJEENNUwQ6bnZ8DmWQHwz0eRgKsd/1rYWDkurN82fjQk4vVGwI9Yf9qWKRIhqM1jCk6rbQX6cVgZR8jmFBGIPYMsTTPCLg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510683; c=relaxed/simple;
	bh=FUOyaERmeKclYDE6yxWhoi69duTHXEWQA7W9f4AoZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZ0AeKFvtsjmY76WxzTgglfFF4RYkL2gSi+mxU9lhyczb3l/BsDq2Y8zMB6CUvEv4CCyrfFi7XXkkiQ5lh1U7lvv2BzVgWN7FHEz4fmU1BR4KlY2HsajGgCDAQxQvkY5R4olR32K6VpGEo3lNXyAgJ7bxMVVUiVIZJm0ySNpua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQYmCfAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQYmCfAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886421F000FF;
	Fri,  9 Oct 2026 01:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791510681;
	bh=dyKVolkUsYjBDwgzYq0OWno/Kd3bSWqcNAkFS2vz3pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kQYmCfAoqwRiIxMMrxcZ5Nz2W+JX254mMZ9H14lYUvtnYCO43vkbrWr31BQboYWnk
	 kmY7c5PALoTD1rwhYTZeUplCA0q3STZ7rtJpwSH6+bn7S/Tv/RuWc3/lKXXMUQYAyZ
	 ijtrsvFDRRryOIbAfgjanF/4WVwUCc3adNg9yUWmM7/B2bxZ4VeL4Z56r7rsmPQFQj
	 NNAgwdv7pVFzk5LN5oDsWmy/vHfUeFg1jaLdieLMzd8HBqfqkvlaRF5QqS8pq3jCav
	 hKTY4tY7FALMLzJW0JZFShcvu1aSlxHpKQ+pUp5uqFIaBk0gjfsRRG2HGaM/F10rN1
	 Tuqd1JP1TdyJw==
Date: Thu, 8 Oct 2026 18:51:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
 petalzu987@gmail.com
Subject: Re: [PATCH net 1/1] net: devlink: fix reload error on netns
 teardown
Message-ID: <20261008185120.45c9b4c5@kernel.org>
In-Reply-To: <51b31e529d844b075e34a3595ba9b0eb183d325f.1791019703.git.petalzu987@gmail.com>
References: <cover.1791019703.git.petalzu987@gmail.com>
	<51b31e529d844b075e34a3595ba9b0eb183d325f.1791019703.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Oct 2026 02:14:42 +0800 Ren Wei wrote:
>  	err = devlink->ops->reload_down(devlink, !!dest_net, action, limit, extack);
> -	if (err)
> +	if (err) {
> +		curr_net = devlink_net(devlink);
> +		if (dest_net && curr_net->is_dying &&
> +		    !net_eq(dest_net, curr_net))
> +			devlink_reload_netns_change(devlink, curr_net, dest_net);
>  		return err;
> +	}

A bit of a weird place to put this code, and IDK why you're using
is_dying instead of check_net()?

I think the check belongs in devlink_pernet_pre_exit(), where we
know the curr_net is dying. Instead of trying to work backwards
from the netns state in the generic helper.
-- 
pw-bot: cr

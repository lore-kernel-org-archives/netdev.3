Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465923D2A4
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426885; cv=none; b=XDBq/RP9w0oFCR1Gfy57UyxrdViVlS2NBeJZlu99bT9agDJrrLQXz01/yQqrk/oAyBsSFTuOdC9APartk8CqIMY426v13DjIKQyTZ0TbUC6NIAR2W1qLjfmIsqBaKjNoRUlwoISEOEbK1IFAJ9dLs8Bkj5ZRTCVpgIfFgxwCaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426885; c=relaxed/simple;
	bh=nhMuiXZftuCf+MLf587IuIlv7dBC0qDdcGlF92pu/wA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/jIXW1Yfo6Gl1+K0OqyqOYxREm4dHJ2DwuYbv2nQSgTCoj2CTS8V91ER4NiMsIOWN6dNjMdB3yIpiWuVchIjvdvYp/J/x9oPG/0NmH+aNWU27G6qoGFxZtu6ICIJwg9RzlZvQSvLfKW9SfqmpWLJpTFuym39kp6wJ38s0gSKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdfAPSyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdfAPSyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7680C2BCB8;
	Sun, 10 May 2026 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778426885;
	bh=nhMuiXZftuCf+MLf587IuIlv7dBC0qDdcGlF92pu/wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GdfAPSyltheFpGxg7gDgIUBQhfGZWjl/HVycP0XpJVFoHfdHW5IzT5lHab3U0u/nf
	 U4YlWFbfQ1LiHFOqdd1mCH6MjH7JDmq+k9BIQCLmDd92V+0m9PLfT0xbv0ordfuKEF
	 HxUTj68FPnkdCPhKJc1aG/x4adn9qVYv4K5+6oVhfmQ9NhQzHMLcBAbarbkHsAzFaC
	 XeOlj49os/Jj3Wudk5sjDID9oMRzCcula5ylnJXtzIzxk/SicMNTmWrfu7dFO2FUBg
	 udeQ/X8SPTTqO1Af4gpmT17w/uy7MLHq1vpYhDv41GCvVYi5XyJtx33zXxIQJ0ha6p
	 6njbA18yG1D8g==
Date: Sun, 10 May 2026 08:28:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno
 Leitao <leitao@debian.org>, Simon Horman <horms@kernel.org>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: fix ethnl_bitmap32_not_zero() bit interval
 semantics
Message-ID: <20260510082803.5555bc7f@kernel.org>
In-Reply-To: <20260509005711.127828-1-zhaochenguang@kylinos.cn>
References: <20260509005711.127828-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 08:57:11 +0800 Chenguang Zhao wrote:
> -	if (!memchr_inv(map + start_word, '\0',
> +	if (memchr_inv(map + start_word, '\0',
>  			(end_word - start_word) * sizeof(u32)))

Please adjust the continuation line to match the opening bracket.
-- 
pw-bot: cr

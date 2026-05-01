Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677A3CF039
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647731; cv=none; b=JuVfjdexIxNTLZAxkTevG7+ptwFcVowfxi2Hld0hfdd5Xxw3ZIO+6kvkv7udF7BxFmUOtpxqp8Jv/A888W0+xnuwRdIWk5+MbYSEL7xEaWsSYCqwEkFxrXjsnHMXqEG2OIdg6UJOnofMZqJ0BRJDADY36amszjFI+X2zNDs0DKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647731; c=relaxed/simple;
	bh=2+lUXkYdAyRO19omrbm60C8bx7jTn78/kzL5Z2wvlnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAjojtnM4qL2e1uhhKtEmncD2FfvmcBI1xd3JqlF1Mbp8jO5OjJ7GSjciqofdbqozJkxZNq9xYOEmJ3RqlqZid2uuxDB6r9uHxShNAgc5XJLzAdL4LIpwhvnWfh6jDKwf0MaEBFKun3YS+0wDS+ZmR9lst27u7edB1zDIRmGfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0+mtjPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0+mtjPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701FAC2BCB4;
	Fri,  1 May 2026 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647731;
	bh=2+lUXkYdAyRO19omrbm60C8bx7jTn78/kzL5Z2wvlnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0+mtjPJrXYKeMExKwcwsLKt1nEQY8cVytuTiO226JEvUIs57U9MiTwrmhB/K1LUo
	 f79SspvjQehz385zf+6cX2jFqEkc5YJxa5X69CEjCZ2q995B1Z1RgnkVVEidbhoEg8
	 8drfGCqUvGExirPX9M3GbMSPezf5ZcWh08hvNZ/taBEdOl5XQ4ZFk03zrqpx56wbE2
	 uRjOiYnqgEsGt+DohAchzhjXXsEshajbk/MHF2OEVamIgJz9u5zggUJKxvG0SneIrs
	 kdjZFsGxba5p8tH0Yhsdv9QLVLYOaQXVeHsws5RNnitp+XwpOqg3zwX1MP5uVO2OQn
	 1024bD/+/jo7g==
Date: Fri, 1 May 2026 16:02:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, john.fastabend@gmail.com,
	sd@queasysnail.net
Subject: Re: [PATCH net-next] net: tls: reshuffle the device ops check
Message-ID: <20260501150207.GI15617@horms.kernel.org>
References: <20260429213001.1908235-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429213001.1908235-1-kuba@kernel.org>

On Wed, Apr 29, 2026 at 02:30:01PM -0700, Jakub Kicinski wrote:
> We try to validate during registration that the netdev
> has ops if it has features. This is currently somewhat sillily
> written because we have a dereference before a NULL check
> on the ops struct. Straighten this out.
> 
> No functional change intended other than saving ourselves
> the very theoretical crash with a bad driver.
> 
> Note that we check earlier in the function that either ops
> or TLS features are set for the device in question.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


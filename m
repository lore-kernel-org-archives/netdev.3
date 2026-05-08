Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D07328610
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279487; cv=none; b=HKNNT1ezhG66KnAIhQdBsWM1YpajLwocFyuEj+wko8uGlRw0qf6bnS2sCdih1J9TKvL1lwztvQmGzHQmza12APpgPMt4BrV91UIetW+eDWpMysn1H0XMFttDaWSVPyhuReTIesqaZOh3uCpo0k8oTyhmTNcUVI9pF0h+dWHqI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279487; c=relaxed/simple;
	bh=gp1oxCM8WS/+tfiiQbATPlG0HVQ9xgnYnjJRwHZC6FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwwADrW+OTuI9CEicOQiw8PLOK9fQHMPftyF0G0f/3VJ0KK4XYejgGkvw+s6sQOlxo7eA22gpLKdUezywZOwnfGFxfe349D+3SS4lfGFS7MIO2bg+iN4GDRe5s8Hys3wv1EpJcGMhNEOE6RDHzAqk42wJyoInXGzJE7OlTNSvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OneB1QJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OneB1QJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65504C2BCB0;
	Fri,  8 May 2026 22:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778279486;
	bh=gp1oxCM8WS/+tfiiQbATPlG0HVQ9xgnYnjJRwHZC6FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OneB1QJ75COGN3eQY9uic6zA8QqoVsaVFQgus74OtF6UQXVIOT1Ps19MhcsDxKvKK
	 s5ME6oMKoJd88aCI07cUz/4xQ3EDGdcifh2EFSjOt+DZuqnBhC6pYoSS9tS/XMmExN
	 K0xhew0zmVEGzuI5aN94LToLThh8BnkepzC6tqeHro23rrG2cgRlO9E6TmOc1UpKWU
	 cxvI8YG+Gm4w8koK4Uu8vA4Og71OpZW3gN1jkETcvr/iPzXtrsagkZ0QwTyZp+MoBk
	 Olz/w82WuoFTHggXgafqvavoPQrvQpRKWekHJLX44ZyPZkxqATObVVYG2FirTUME1M
	 YuokvdDjAcOpQ==
Date: Fri, 8 May 2026 15:31:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, netdev@vger.kernel.org,
 andrew@lunn.ch, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: ethtool: fix NULL pointer dereference in
 phy_reply_size
Message-ID: <20260508153125.4a11e9b5@kernel.org>
In-Reply-To: <329ee928-2694-4348-a6f7-099618081dde@bootlin.com>
References: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
	<329ee928-2694-4348-a6f7-099618081dde@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 17:39:57 +0200 Maxime Chevallier wrote:
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Related to
 4f038a6a02d2 ("net: ethtool: Don't call .cleanup_data when prepare_data fails")
I guess?

BTW there's more issues Sashiko flagged on in this handler.

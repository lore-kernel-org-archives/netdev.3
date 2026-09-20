Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BD3C1F
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864099; cv=none; b=Rc5NpYyoPJacV8Yn3Kse+sEM/47rU+YJdOOXIE1AEYya2RneDVg0TgM0JkkwCMx53ZblnITYXNt33B6GRTeEx/1Vp/PLk8uZu0pFe1oNEDBHGp/1b+wl4LKdnQwjk2PWQfFGe52HT4Dnn+AC6lRldSBdgKQywGSeudFlmavYJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864099; c=relaxed/simple;
	bh=CwKp3gCAWe7MiOHfeL5/uRbyCvj3bZrA20toJkHYOe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1wZocEQ6etXj7CfYh8JyZVc5yesy1ZHmb19Ml3Bck+4WQiWo8Uhu0xYxBhKmq1hgqj3sgXsn6gcCaC7k4liocxSdTsAba0K6EVeMEOSS1h/MtQV259hgY5OxD/mL9kQA06A1asyh5anXGtDb+5Q6e1cST7X2ZC19cSljkswc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrMnLVye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrMnLVye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14411F00893;
	Sun, 20 Sep 2026 00:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789864098;
	bh=hX9zpmKZdH5Vl6DHzHNFBE/CCeviQ2KfaYrvvw7bK2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FrMnLVyeEeObAf+x2Xjt8LSrTihP+45y+54mJPe6s+0KEjcrMajwvt2BUwHJXipa8
	 J94xi21hAoj1XwBDle/hu/1UQmjIoEPMvSpx1v7CI/ckVf9p5FbcuDoLe9cuEQqbFA
	 SXRtb9ns/8DumvgLYw8p0VAwLwYWCI0/ZFHNCouf7U+DHG76taLZs4pWzt8lLlCA7/
	 xKkv7YaVZ7RexdgMJKYMrZ7tWzBuZlP86yIq+I6PhjGeJsHO/RPw0ZMEnjSkbU13/8
	 xCKaQUO/H5S9FGRrVIE5bX6fdi+rV3B7m2+JEvDbdTdISLZbzM6chnBnousieHBYkD
	 ivvbmmzxSwRDQ==
Date: Sat, 19 Sep 2026 17:28:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Naman Gulati <namangulati@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 kuniyu@google.com, syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: gro_cells: prevent enabling threaded NAPI on
 gro_cells
Message-ID: <20260919172817.7d8673ad@kernel.org>
In-Reply-To: <20260918173413.3222413-1-namangulati@google.com>
References: <20260918173413.3222413-1-namangulati@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 17:34:13 +0000 Naman Gulati wrote:
>  	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded NAPI poller will busy poll */
> +	NAPI_STATE_NO_THREADED,		/* Threaded mode is not supported */

Adding state flags per entry point we want to prevent is pretty bad 
sw engineering :/ What's the property we're trying to express and
isn't it effectively the same thing as NO_BUSY_POLL ?

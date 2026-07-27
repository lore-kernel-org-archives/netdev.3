Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5063F1ADC
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196271; cv=none; b=g+MAtaNoFOf/69dIdSU9UI0ZOaNXsZTMqvOVMin+yFe8ITr9De+OGGfzmhqd0XzJm8y6P0OpVf82fjhpnCzlxVcXkumb7p4OuV6mR2FMdbaeGZHlcjH5hKjB4EC5GYqefiO5vpmMHkI4tPwrdwxcz7l7Sak6G1j7VKx47LGhTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196271; c=relaxed/simple;
	bh=9nn3i7bcx8QJbTZo2Ok9+vuHdnZSdIiMKrhjoqrSm6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udLQ9HAtKL/oRlHjOS2nEkLOSdAYtp+sfhjyVUduoxLQwG78SglofXMDnSIQX86YbpuXmHPhvwpWdWCKVHGxtq+DN+j+VIQ/Yy8d0A43Aj5agN9P22/eJn5sgb/A2j1JHyhdSi4bmOyD/3naVsil5AcLwEghihYr3Yy5g2ci21Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzpzhHSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzpzhHSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C111F000E9;
	Mon, 27 Jul 2026 23:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196270;
	bh=qQKwN2wPl2/Y4x5vLyHKnHImlk+WQ7G1MEW1/p3rjmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WzpzhHSYGXyWhlNlhwFCUUzHXJval/yD74nEhzmnqBhE7K+YJcFcu04TxrWK3R3IX
	 KRzFFpGxwbaUGdA21qhn/zDLwt6jxpklzZjFStHk7zyX5w83F5FtaOWU9HEmZxS/IX
	 3jfedgXLIjLtskKrMg7M4YGqDbyIeLduT0FcVxBDXJJy1SvY10cC3jtzAdwcL2OsIm
	 zaP5UHgBcZYnj7Ru7PqHy+ZT7TrGFYzFjUzbukhuGE5NU5JZ84vmZQx5cRSkxXBOep
	 KeQkS5V90Lqc2y4BPpiMhZQ899p5zWB1CDBgpBEGdbafYi4smJO9dheRQaxBcDP9u4
	 4EVwwSqt4PatQ==
Date: Mon, 27 Jul 2026 16:51:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 mohsin.bashr@gmail.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: add hardware pacing
 offload support to rings
Message-ID: <20260727165109.439c0f74@kernel.org>
In-Reply-To: <20260726202902.760552-2-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
	<20260726202902.760552-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 16:28:45 -0400 Willem de Bruijn wrote:
> Add two ethtool rings operations:
> 
> - get pacing offload horizon: active and max
> - set pacing offload horizon: active

Could you spare a few words on the fact that we already
have IFLA_MAX_PACING_OFFLOAD_HORIZON?
Since it's already there and patch 3 only adds device level
configuration (not per ring), sticking to rtnl seems tempting?

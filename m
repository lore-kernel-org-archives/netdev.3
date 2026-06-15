Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E2F39AB
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566635; cv=none; b=M+UMZoKG/fnry0DyC9v8emnby36Z1IMlruTsXl4N/BE7fjKcuEG+MnbHX+burPwxHoK59aFhmRqznPJY1JtutLtxZi3qTl4EA7L/FtRTJqIbdwko5BM6Z5oTollCm0kep3NTuQV1oVOMaNR+YyWKoMNx6hc+YWaxzLxt20n4Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566635; c=relaxed/simple;
	bh=M3uHz6S6dlPGpnLhYfNGPPHYfW5aJkasSCsiLVh+VIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXsn3FVNi8UFYIt7luH3UfZm0nIVbi0Hbbqq/Qkc1RAch26S6ETnGXEfD3VOiOKmKMl8i0Z0esFxWnnH1ZcHvr4sHAb1xsrTUx/+KrEFsfIUErL52JTwkIBAY9JuirTKpCpnArD2QJInoGwLgr5MT9yQHhwui6YxJC9IniLpDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNRBRDKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNRBRDKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137551F000E9;
	Mon, 15 Jun 2026 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566634;
	bh=QyebWGkoDw0IMLgVd+AKwJCgIiDE52FQKr4Rqkznajk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HNRBRDKOOEc3w6UWCswmMwcS08k8VXC8ghVYfQr2saEu6CmfXrbaT9eu02xZvY4Mb
	 05hO7jVky7Yo2Q37OGLDJ0EF2U6/4NNoojmfdqo9IXmeRurxeRiq2kjvFJ+ul5ZAss
	 djADX5tBYXJLHfXf0+RmRqEjHETK7O0LwU3b/hqST27Ct2HUfsBNY2a5OArOoBDhBW
	 N1TEPRI89ijWa5pzTFWqsh7aDSs5a84Jni73Iu1wxh6vtYhEtXHLfKpCH1Z7SGZrmp
	 OXYH5p8Qe+3M2Y709/Y7D8l+9GxkBOZ2OEcWOFVGmq9Q0oftp15s6RPc403q1dkuDP
	 7F5V8C3k2mxhg==
Date: Mon, 15 Jun 2026 16:37:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Madhur Agrawal
 <madhur.agrawal@airoha.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <20260615163713.665271a2@kernel.org>
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 23:55:50 +0200 Lorenzo Bianconi wrote:
>       net: airoha: use int instead of atomic_t for qdma users counter
>       net: airoha: refactor QDMA start/stop into reusable helpers
>       net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

only the first patch applies cleanly right now

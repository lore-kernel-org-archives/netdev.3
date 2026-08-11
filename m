Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88C38A700
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411880; cv=none; b=CSpI2tXf8ui3KHRADwgwsZ8htgYmPEQknYdyNdbdvF30jG+YOQ5O2JYhT7o/EtZ5f2A6m6Ht/wxfZowcXICx/hIHlZaB6dAflQUoFnMo6YmALLdxgex9TMQ3J8b9Hp6oCQ61XNURb/opewmiv8Ya4mOS7SvfWao7Y2vUyWkLXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411880; c=relaxed/simple;
	bh=/zWMMt0CVKIqC7BgUk2PTIXhwpoxR9PzkqFfwqPqyuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co/2wv3w6FhWuHUf1HH+S4bhHDpLNcoeC7fy1oBI2DU55bSJngNXs5R1t6KKIPXlPZOzduHquN1E5V5QzMcCZ6Hn8duZw22lCSYChP3XfXOLFo0ybyX5ItIiYdGPDOOYjl/sFjqWf9m+lwm9puzIgX5T91AtIt91jB6SFaiI238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X69/f03E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X69/f03E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8711F000E9;
	Tue, 11 Aug 2026 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411879;
	bh=dGZc7TYSR+RJymshCcKLB1+8+9gq6RuSGzKTuZmCTwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X69/f03EiDYkS2tZTTAjLxlPy4bw526wTE+CEvf7b/TLLhxxPTEzjZRXyhtxQ68a7
	 uUifA0mdNgOoNj/GTJVUoHdyMgZH74y6NJHyZhMa0miz4eKOj9wxKn2TdZZKZZmPB2
	 lP+5bj7p8ztdmMjQY27u2hAfbtuBn1PrP2Y9KtTlRuzefTYUEQv0qiKUgEtd9FEUix
	 ZTz5DEndJVwHr757clY/LQw7Jfxyd1wdofEtn28w0ROSfasr1ri4T3gmOTW+FQfqvY
	 MEV87etCSfP+Tg5wW8aZlibX+N5Yc/CZK/pxdr1FRPn4DyoH+HJa4Wy0HfkauzURHK
	 rybpJKfXaT9uw==
Date: Mon, 10 Aug 2026 18:31:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next v2] selftests: drv-net: so_txtime: only send
 test traffic to sch_etf
Message-ID: <20260810183118.32d5c06a@kernel.org>
In-Reply-To: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
References: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 12:00:44 -0400 Willem de Bruijn wrote:
>      orig = tc(f"qdisc show dev {ifname} root", json=True)[0].get("kind", None)
>      defer(tc, f"qdisc replace dev {ifname} root {orig}")
> -    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
> +    tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")

Ugh, sorry, I should have checked before applying.
Looks like this regresses the test on all setup in NIPA.

Random example:
https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/X710/results/772526/test-outputs/11-so-txtime-py/stdout

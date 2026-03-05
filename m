Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035D3BFE29;
	Thu,  5 Mar 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723998; cv=none; b=ipcV+czDP5iPOItu7RU2kSrvQR1oWQjAMRdrWPg9Nq3Pe9vO3wqX55G/KjSwUdiL2oqvXpi3IijeoR3XiJBpaGROQqegtbu+CVH7gvm3/wsORePAwtSWV1Gr0yu7WnSBbSIoJXYUvu9TqHNPBuioCnwjYF9nNQMckyNMjXpuuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723998; c=relaxed/simple;
	bh=fiPz7wtqOY5BeMkxwRsGcfzBJ/wpg9ehDqfpzlZwBLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNafmD12HkhtO/rPkyzO7NYZOZR3K8NGcksdwIRma3GdXbdKXb5r73s12bOLVSxS2V/wMovuWxoWvCuf2KbCMBUrem21s0SMd0zY8C2y7MYsnuvNdZqq8OcCXp2RWM0pqQHBNd9BTftTjvNN5WocSHOtwujX47W7l7P8T0KGqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy/zFlEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy/zFlEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E616BC116C6;
	Thu,  5 Mar 2026 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723997;
	bh=fiPz7wtqOY5BeMkxwRsGcfzBJ/wpg9ehDqfpzlZwBLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cy/zFlEmHAifNQfbSTWPYDYipTTH6trB82Oy0edkNFgF3YpPGscbwDmMl6vOh2a1o
	 cpLko/5dWTKLyg07VjmS9LvqLoqnVHOa10DVNy56/V8v9skgkhMOnmKQiBd13OF6ka
	 /p85yoP6L6p3fmrqnArS85XXxfzOKNwC6EDHgH+oBU82lczxgd0IXLvSjUnlBq/k+l
	 +YQNjeZKi1l1nUxwuU4utBs0zt/8j5Bey0RfbuahW3/7fg8yk9OFdVfa18aPtLZbkr
	 f0hmeSriiIJz++KYt3Q7i1jDkiLdKpJbo3FOMMZWy/DCGjGDbww8vzd28fbZQEWa+C
	 u0XPYXxW/UvsA==
Date: Thu, 5 Mar 2026 07:19:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Chen-Yu Tsai <wens@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Samuel Holland
 <samuel@sholland.org>
Subject: Re: [PATCH net-next v2 1/8] net: stmmac: mdio: convert MDC clock
 divisor selection to tables
Message-ID: <20260305071956.08d49615@kernel.org>
In-Reply-To: <aaly2p34HoJAIJbx@shell.armlinux.org.uk>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
	<E1vy69y-0000000Btwd-3oq7@rmk-PC.armlinux.org.uk>
	<aaly2p34HoJAIJbx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 12:11:06 +0000 Russell King (Oracle) wrote:
> On Thu, Mar 05, 2026 at 10:42:26AM +0000, Russell King (Oracle) wrote:
> > Convert the MDC clock divisor selection to tabular format.
> > 
> > Note that there is a change for 300MHz, but this is not a problem,
> > as the MDC clock remains within the useable ranges, which are:  
> 
> I notice that checkpatch complains about "useable", which it should
> not do. "useable" is perfectly correct, especially in British English.
> As I'm British, I won't be fixing this checkpatch complaint.

Yesterday it reported a warning that someone repeated the word 'very'.
As in "this is very very wrong". checkpatch, eh? gold.

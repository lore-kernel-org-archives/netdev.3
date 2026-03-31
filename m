Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CF40855
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916946; cv=none; b=npmFPbxkHX4PVJsPCFIHykdta89tw2DgJ9pnlk/be36zQOwkEVQs/k0PcyExT8XZXBCFYPCF1F43hn6IEdvKF2ECv7Fuhy+DyBJExWfd4jn9wUr+kgdrQD3vrS4kbDlxprn3fUVujxhHJcxilhC7UMfrV3AYZohCi94NmJeUcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916946; c=relaxed/simple;
	bh=HqldPgKp9TGGyn7L65pc2nORgMdMa6raZULjHCR1jCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRXYI3MFPKalJEWFZRg9Mh1IulyMmNAGmdaCcYyEUsB3bIBjJwyWNEMA+rrIewTtpo9lmS3ei6PKsb5NRZqf2dMnJRye9+KGHQPRR8nw6M6LB526dPkE0mgpxpIQYMYrjDsgFczRP/AZeAmK6EgOlTljRqT1Y5UFLBp+KUVwV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaignE4T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaignE4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E3C4CEF7;
	Tue, 31 Mar 2026 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774916945;
	bh=HqldPgKp9TGGyn7L65pc2nORgMdMa6raZULjHCR1jCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UaignE4TkOdCWR+vxfEaWiwNOgV+brzQ80h1rNgUJxsm/9PunnuneMchdQcMT8OOZ
	 WDYsGFF0bcd8yNT7kJgVuOpNiyHk4+fj6pDzKnokCN9tyJbeAuDRcOgdeC4QymVtcv
	 t/vDxrU5q/MUz6+ViW+XGtvy8u35xBJy5QEW9o/ulNtuZ1b3gXE/RAWLooVujhpry5
	 7Y0pG3yClGmoojWnWmbDulqcrmd7+hu8WmDVnnLx/gehIAymFFskNMIWNNjZC+MX7L
	 4Xgdn7NPhQhGM45M9W3GiwU2kuSMEzJFoO8ZcY4//w6JCGT4h9mVaBx0gmVfTohZux
	 4FlkvsJ76abvQ==
Date: Mon, 30 Mar 2026 17:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Madhur Agrawal
 <Madhur.Agrawal@airoha.com>
Subject: Re: [PATCH net] net: airoha: Add missing cleanup bits in
 airoha_qdma_cleanup_rx_queue()
Message-ID: <20260330172857.0c94685d@kernel.org>
In-Reply-To: <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
References: <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 10:48:21 +0100 Lorenzo Bianconi wrote:
> In order to properly cleanup hw rx QDMA queues and bring the device to
> the initial state, reset rx DMA queue head/tail index. Moreover, reset
> queued DMA descriptor fields.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Tested-by: Madhur Agrawal <Madhur.Agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Take a look at sashiko, please:
https://sashiko.dev/#/patchset/20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org

Looks somewhat orthogonal to the current patch but probably worth
fixing.

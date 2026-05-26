Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224253C0633;
	Tue, 26 May 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823348; cv=none; b=IMsXbcKXmkrgDAv3SZ9ywaHG8TTk65pwpf2ZVRoFJrH/yl3CZb2Tw67xYHF/L0h1mcHfiniBfxgB8yl+pw1Rg1EjHs8wFldlNMJNIYPbGP6jD+HCf4c/sGIjg5nsUYm16Jh5b67JJwHQ+TylFlSUMCKPol8oIRLrHSm6XK20shM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823348; c=relaxed/simple;
	bh=2IqGpm/obDxNgn0x78Z4cjkdInTkjoo6bStjCvwL2sc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KZYiXMgo6M6pR6cuqwCX3TZ6CZ/A0d9M+QvtENSQiL241v2Bw1P5o2/hrYbzpzucUP944/p4u/TWunrkDXn+h8ZqXO14MT1dkDUbuhiI0dmn1LLnZ1ZFMt6LnHzEn+gDObv5oWlc0YVIZf+4ajTzHlEk87tABwGK7BgUgNBZ9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LMnihLru; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LMnihLru"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54B33A0025;
	Tue, 26 May 2026 21:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779823342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WA9U5/aga7HNi12SnNFYa5cfnfKbHcoSgoN8mlKqLNo=;
	b=LMnihLruJQl1BYv6fnnSJZFI/3CEseYNziDHFDmxQtJiYmjnUq+Coqyo09mS9vnqlb+Dkz
	C91G2UVMXqWRlioVir56+T0VPvkXLDv/K377iCtzpzvPYsWXF36PXaIIV+dWRzYzYxDqrK
	vOex3zzRScfB7TcbRbHguAwFNolHWdbX1mdC8pK7JehjnlXcC6yL7gthGcr0AbO5g6b1ZY
	v+E7V1wcg2xV8cCmkWT/7P6dXbGxRii8tumoOfzL1FsaqGkoMgqmesme3lVINnAbiQNouF
	XLTbzhrhPqHTFXdCbJFGRK1rwdgw/NEqH5C+h0WxIJ53bjuKp/L3UkZNOJcttQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 26 May 2026 21:22:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 tariqt@nvidia.com, dtatulea@nvidia.com, linux-doc@vger.kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 2/4] docs: clarify page pool NAPI consumer
 requirement
In-Reply-To: <20260526155722.2790742-3-kuba@kernel.org>
References: <20260526155722.2790742-1-kuba@kernel.org>
 <20260526155722.2790742-3-kuba@kernel.org>
Message-ID: <c04f87ca8b70baf7a0fa6b8f03a6a476@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 26.5.2026 17:57, Jakub Kicinski wrote:
> The comment about requirements when to set the NAPI pointer
> may not be super clear. Add more words.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF202D46CE
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027032; cv=none; b=GxMcN+xzbZ+CbCz8t0FxDBCVSNs/sHvbypZXcPuG44tIhDOv2xoWGUtzDvE6A7+cAR7zAbZEYiFFCyFG3uBg5QqxgDaiGchasjP8i6yd0MrOuGcSP2N62CfXy5i6J0h0RJY/CBxzbb1lTvFzZdRTH7iStoI78Ddb9LbaGxQIedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027032; c=relaxed/simple;
	bh=OFg7gaIIJENLADZC81W1MxkKRviL+wIHPBMCeJeFUYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPf6C57hYVGG7Gy0gpsBdr3AvlZzhT9xQ6ZAEOtd0IF577W5g7VkAjb0RntH8aMcNSlMO3T46MV9qYWtWVWnMoFWtkisArOnGYY1DB1YZHChD4W9KIQ2/vVWxV7dpAdn0EH2d7WMbI2SWqLMeewyDG9xhWmUjiNHJVuD643CLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SM2tG9gC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SM2tG9gC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e82c23840so8689275e9.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779027020; x=1779631820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6GwYArnaeioyDwurWj9r+Vzo/oXg0IJMt1SOHyO9K8=;
        b=SM2tG9gCr3cA/BEhJcCWWa2RHhlby8RYt6zm0MAjna1a7HyjRe3WoPhY7adXA4Kryi
         J3esYWriGhUKTSIKm+F8uXobkfnJl23eaf+qgYS0B//PXDPQbjZHtZ/CaIstO4r8KLBg
         CuRmXEG9TdN+J2EM7fsNtyy5mKFtrhgWtJ1Es5P01F+T/p0fbnYra7xfeTYm9kAGWQAY
         eF7ykb7ZZ0zhcCXB/b4rViwYFoerE39N+TFD7FqZoPKFTxlg0Lh4T/CtgeZqiuu63j00
         CrjCcY4zWRkYnhB0IeO6n6oEgGqL7qp/iMWDry1Z2E3+psDNn6cTMDdD7w6+dVntcsx+
         M95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027020; x=1779631820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6GwYArnaeioyDwurWj9r+Vzo/oXg0IJMt1SOHyO9K8=;
        b=ip2KFqQfaSJvobVlBmI+HJm8STGKcqizAQKeKvv9WrBHd6iDMKpNJywEGu90MqwMgm
         UNUlOnoc4gmo4LUqN4Vr/N1Xd8lLfQu4BUXK0MIayzz9xJxEFu8HTV6NNeb+Xj8aadqi
         s35fUrT1PT96YYAnfO/1HblOvh2zaNTRlnnc4em+JfY0b0BFwLXi+rSVXFhyMlMHFnWg
         QQKOwcSxYTpeJGYdQoSNUCnxpmnc4jUqhdPhcuU4clC9nm5CYBbN/TjVUQJsE28RT4hS
         L3cL5m3nI1DJVmSuVZB6KGGtMru1tM6e2gIMFl3r4BrKHaU+nNrAXfaXjUPCn81S0t+w
         1gZw==
X-Gm-Message-State: AOJu0YwznFR8kgLvnA4sKk25Z3oW5wb72x5HZh69Ccc+b0AED4YUFfOC
	g4DUSl6Jl2fkzXZFpCX3kwSxkS7yuhHqPkI1Qlu+4HBu7i1sKRzXPoeXsIm2ttQyNPQ=
X-Gm-Gg: Acq92OHaHHrvEh8W40yAUr2JtEh6V9w+cQCyKl/SUIqINnVFLSoK7RBy/1/HWXTVNmK
	Rb9plZ9K+FGIVB5jd1MAA/J6soRzfAE0cRH+M8wGEaExiCSW2+v9ItzLoE81TVy4xnkp/jJD2zW
	XBcoHWUvL8pgptw+Mjpqx83OzsQdII8NZcuneqZbqUhrJfl7rh0yd4EFDSISSUu7gqS6CbJxtK2
	7rpuHqB+whZ+m3gP/V+DR20Lj271+fDf0y3LsjhwpQPcJtro60PVgg+Vzm6QsTq0NEza6NKT45a
	sBVjjTxEppZr1CXv2L9tBcKpJxiw0R3N6izpTNFNsIL3Ma4Gy38THFVHvor02BkjYvN4vXHIALe
	QzgEGpnHtFali7PlifsKz9KMnHwKdTnkSnixHQo4w+ky/c0Wlw5us7JOIQScJwSfLrk6t3CShqa
	N/ZE64dU6wPRdF+sgZsloQCW8rKCQ97FlhEhUW9QebXf+wa9WnW2Nmd9fB9g==
X-Received: by 2002:a05:600c:6383:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48fe60ea4ebmr169793665e9.9.1779027020119;
        Sun, 17 May 2026 07:10:20 -0700 (PDT)
Received: from localhost (176.111.181.159.kyiv.nat.volia.net. [176.111.181.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab26ed9sm87218235e9.2.2026.05.17.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:10:19 -0700 (PDT)
Date: Sun, 17 May 2026 17:10:17 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH iproute2-next 2/2] bridge: vlan: Add support for
 neigh_forward_grat
Message-ID: <agnMSaZF3eNRcbFl@penguin>
References: <20260517082501.899009-1-danieller@nvidia.com>
 <20260517082501.899009-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517082501.899009-3-danieller@nvidia.com>

On Sun, May 17, 2026 at 11:25:01AM +0300, Danielle Ratson wrote:
> Add support for controlling gratuitous ARP and unsolicited NA
> forwarding at the per-VLAN level via the neigh_forward_grat option.
> 
> This allows configuring the option via:
> $ bridge vlan set dev <port> vid <vlan> neigh_forward_grat {on|off}
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>  bridge/vlan.c     | 18 ++++++++++++++++++
>  man/man8/bridge.8 | 15 ++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

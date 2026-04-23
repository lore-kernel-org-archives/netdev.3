Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1529BD88;
	Thu, 23 Apr 2026 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916068; cv=none; b=cZqWIID/aCLnip82jcslEgyEWtDhaoFPh4WrMVLJqmU+6j+rTw5ghYeTTpQTmN9SGAHQsqZsBZV7j9pUTjhs5TLYFwLIuoJWKPQ/7BgVbO+jNqK4mcVxeRg+hUgUJfUMDmhRlhAmhdzFmrWpMYDWwQ30I+sm+KjlhujRHqjvohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916068; c=relaxed/simple;
	bh=myw7ZTpn9gMXSm21wlGtbOrh9RMRrxiiucKRfDPOqHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4doBZ9mZLYvh92iGu0/bXZM1xTOsAHwQw8pl8605EEd5/6qLaZWXzHwA3qlrOvKt2HBIdnK40ZsEhFFy8sXLbBA8mj4szt5jKfq4UBzeTGQAwhQ6X3Um06jGeX0te8XDg7oEQb8WYgjqjAnFp5rgt/90x97avFmbIkWQyt67lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Jp6uYytX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Jp6uYytX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1776916058;
	bh=Ux+nMIXL7cNshplZFHu+0KzGGmmYTX6xWKBkbRqnbjo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jp6uYytXzByo23WQ3O4+kBi3nX+y/XitG95VKJh5PYZ6KVLlE8WNyNOM7we610wMX
	 aic6N8pWKXrCPR3kcfpOeqOz2wJAIt9qDUGtuT7r2N+4UQI3MkRf+EVBZBMJVVYCE0
	 2t71R1RIkdgjs8bcvWGwzDrcnB4Kfhbf6UE49/cL+W9fa4Z2VqE1M1uHz/wmi3Y50N
	 xfG6WWqNnvnIOAtDRO0/XAPi9tHA9NgG5Zz8mgJgUU0zIIoGhXG+Z+rdQdnZPU7waG
	 9bH2V1gAIVxhN0c6i4/tx9/Y9SbD9+PdvghD9yNXuKgPD6x39XJETAXhGzUf902zNJ
	 Dc7IVpXMW40iA==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 27D3866031;
	Thu, 23 Apr 2026 11:47:37 +0800 (AWST)
Message-ID: <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: check packet length before marking flow active
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "William A. Kennington III" <william@wkennington.com>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Wolfram Sang
 <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Apr 2026 11:47:36 +0800
In-Reply-To: <20260423001517.79219-1-william@wkennington.com>
References: <20260423001517.79219-1-william@wkennington.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi William,

> Move the mctp_i2c_get_tx_flow_state() call to after the length sanity
> check to ensure we only transition the flow state if we are actually
> going to proceed with the transmission and locking.

Good catch, thanks!

> Subject: [PATCH] mctp i2c: check packet length before marking flow active

You'll want to indicate that this is for the net tree, rather than
net-next, so something like:

   Subject: [PATCH net] net: mctp i2c: check packet length [...]

With that change:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Out of curiosity though, how did you hit the hdr_byte_count mismatch in
the first place?

Cheers,


Jeremy

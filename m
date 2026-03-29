Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178637AA7D;
	Sun, 29 Mar 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805815; cv=none; b=HAK0JK0A2unKNg0FI8bJDTbwg4uH4AAgaEO8Jj2Zuq7C40yXQkXJGE8nH+iDXk2DJGOxihD5mBzpBwBPOvBt8hzdbbAjKiuateR0BUqJ1Ph13DVREO8iQx5HiFM0VtvjzXUAFG7Rd1b+C2JwrHrmSbr82Zuo+mHYnAXJR2hxO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805815; c=relaxed/simple;
	bh=INKh6Tf9/+Lv0D2IsKobLvoX5JdxAlriktIbLJ9mA5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHJOi7jKp2xmiA8SwL9J2JDKYf5G1HqpXJQtiOWfrMtooTizo9gN0UiOyCbncVwFwO5IWMVWQ5Syp9yw5/YRPbVPf7Z3ksCscWE/zEn8MtSj+x4aiw2lzacOgf32KRixzMxEeZRyWdztBl62Uf674rz9JWjdJXCz5WmCA6209pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXxPKonG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXxPKonG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FC4C116C6;
	Sun, 29 Mar 2026 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774805814;
	bh=INKh6Tf9/+Lv0D2IsKobLvoX5JdxAlriktIbLJ9mA5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OXxPKonGybrKSvL0N7Xkeuru4Fe5bfOR3H0iVqvuzkxbjtzINxwtjh+btmD4KYSyn
	 v/cssZIm8RIrNDnvUlbiHGfGIiFSsNLXWmgJabE/mfq4HOZtz1PrMFtA7wjH/L5ICZ
	 qWiw27sLVcw9jqQsmn1z5I9k+pIXtdGg/AOBVEH1EBApvLPnyMJfK5AMrP9qF2E8Xo
	 2/HWCYCJlwrytob387UUCTMCFTBa8gQys+Dc3czh8niVjASdx94/MihWEYEg6jg5rA
	 XJwkbb8QN+utfycn+R/W7kKZegwCYncIYYBnvaJJEtdUKrLgQ0aOyzO6QIcAyguCrw
	 GUOqzBPxEbUxw==
Date: Sun, 29 Mar 2026 10:36:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christian Marangi
 <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 00/10] net: airoha: Support multiple
 net_devices connected to the same GDM port
Message-ID: <20260329103653.7593cbb2@kernel.org>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Mar 2026 15:07:50 +0200 Lorenzo Bianconi wrote:
> EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw multiplexer that
> manages the traffic in a TDM manner. As a result multiple net_devices can
> connect to the same GDM{3,4} port and there is a theoretical "1:n"
> relation between GDM ports and net_devices.

Does not apply.

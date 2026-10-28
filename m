Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227494;
	b=PmBFarpxjR20qX/WXpS/eJsqqhU6sHOEe7BNU7Z2zZTNZA7I3EpPN/+r8HTxjGk7Mion
	 WWS+oQ9jCShOlDHme1EOLPwUB2lRu4JKjDde0JO8s025bUnqark3D10ctCa6LIQsGClQd
	 hxF4nPMrvpxZCGsiol6gEuF/iYNHbKAoHcfJr0R9LlYCQy7evOlMIL3BQ1TQ2VAbLSLte
	 h+WfdQcqVYJKb4iCXgIGyD2NWmq6xYW2Y05/U3BZcb7PE4BngnKLOCHdyLEIStZ2p4z+Y
	 cUq4aBDAxgwmRgMeZFRPqdxfzAmGJuep/k+y7PRfMxg79Fym7fQKiwNpwtK/67msqbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227494;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vntf1ouSZ918PY9WVTF/AUp/25MS6HfreTfZ8g0AaN4=;
	b=lWe+3ej2Sd1c09eIHotRoa20GKenqW+odemEvjLLjbtfoxYMt1fnRexkgVOzWmOsNKtd
	 +hsVMhha/aHankpdFTjKPNXXSPWXeo3/8gUwxfgSQlnZH/dcy48YoNMxCCgIpEBSPTZAb
	 3NwUSs9lX3BN3CYl/0yS2XtZAokjNMc7cgbtPodx701VIJhafgro1IGe6aXMM35KP1rY+
	 gfmysr+/hsIh/ec9WJXDGi1G4PLZCc1b+jsB6y8Y/yPY8nXfby+ciHxwxAdjPzOoJNDIB
	 Pik7ro6dntqG398GfwZPSTdLPi+KsZzMJtNaxswsdHG3Flk5rSXzJyKzL1CxFNTQKaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+qtWZUT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA56606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+qtWZUT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8FC1F01825;
	Wed, 28 Oct 2026 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227494;
	bh=Vntf1ouSZ918PY9WVTF/AUp/25MS6HfreTfZ8g0AaN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T+qtWZUTVERMdrXhLeZQNl9qrUzNqMzJEk5Et6huELC2B9WVoMzays6ZI+yuB3HCd
	 1Ost6QJMwoRq60nyEeM2BO0tg4451qmP3JYtYV5eDqm9tYOpo6SAKTr9lYK5TImBU2
	 5QaFfDlBWcgW8OYV3orFzR1BnUjDasgqNae7cWhipSgD3/OrZzDFd8xtUWqIfhxB2f
	 XqreCbqXi3NG2cMTVHApUJsSIyA9CMkOR+sXL1S76TEg9BDZMdUIwjzsqvfr1xohwy
	 57jnRrxKz5P9Vqoaux+e2JwRiskh+4Rsl4XRHjQiSePCsbNSBtryLswRyaOY1wwOmm
	 e6b+UtyMzFDew==
Date: Wed, 28 Oct 2026 15:44:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: dsa: mxl862xx: bound FDB dump walk and
 validate BRIDGE_ALLOC ids
Message-ID: <20261028154453.5b5e703c@kernel.org>
In-Reply-To: <tencent_A40150C474B4D2DDBAEA56D8B20F03130506@qq.com>
References: <179278829990.3327.14694215720214654641@kernel.org>
	<tencent_A40150C474B4D2DDBAEA56D8B20F03130506@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 05:03:22 +0800 memoriaru@foxmail.com wrote:
> Same context as the v1 thread, replying here for the v2 series:

Please add the relevant stuff to the cover letter when reposting.
The v2 did not apply so respin will be needed.
Also - please make sure you add appropriate people to CC on the cover
letter as well.
-- 
pw-bot: cr

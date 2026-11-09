Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266504;
	b=11SArIRw1fTW3M354Xf9TB00IgXNscD/OvJtpdvDabB8k5RxcdNrD9DdcZEHGN8WgiDH
	 u+5EVCg0nw4lpnKRmX4SsGu3lLAY8SwvFMNktaXizL+NiEWQBbjXpQnYmH5bAPmEABAZH
	 X3kYDnoh2RQ7aSORXbXshQ12sb4hjqfvWj+Nv3DwBeFHbWMhkdMMyT6ju6giFH3ZvnRW+
	 sse6lZ21qJpat86OsuvlDEMr7LxcStwedJW5g8YiwuLMDv0hEL/Xmwe59GuvpQZlP2cSj
	 piKqCrfS+91Gln1grxjXnAIL0NAbSHB/BankXiMb1CaZeA7oRNTLfxgFV7fVc9htNbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266504;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=SmhMFLn1pD5xdL192Nn1266bL4SZb57SNC4MA7BB0n4=;
	b=uxrt5FEA/xP5C9CWHyD2oWQT4x0EitdOoJUO4cpB5sa8JWeeK+N94wQRdGXDr/OXiXHU
	 hTbbsfM01aV8CUfNOwE3EnfCc58i8kPoZ7UcuIkwETn0yaRsLuN6DMYWtY0k8tyfG8bqP
	 NVXrrIDQC+aW78zJ4SVPdt7ClzVCE1c7Qap5307Q6mmJOAlU1wFXdIn6n6gNd8n0a8iPT
	 kxIw76oROENjS1DItnnP7S72oXsqCcjvmYx13hzGTjD13VNuEm9XJSzIWNczO4e/dKDcd
	 JFnzPd+DyWVKD3F0XJa6S1yd/VDZnzuPnjIATEuRnKYtMwTEFr0Fu1HKgO5JxH/sJMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=oTt9gfRV;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F49606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03F49606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=oTt9gfRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794266500; x=1794525700;
	bh=SmhMFLn1pD5xdL192Nn1266bL4SZb57SNC4MA7BB0n4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oTt9gfRV9IDu4tuqFf9eN3u+BKAOUjVOSTtyE24s9MTxzuluURCCCoWIDd7zq/PAw
	 1KT/GBPG58WJttkY0dkY+cXU6bQowJEGjDdG8J1IRfUXdXDTO1I+RzTVFZYfYKDb0B
	 N2UNzzi9V4Zaj5F8V63izt1zpLq/zE6ay+qtxi+49q/YOICeQuDmV81ZObccItESMu
	 h4p4QQ2ciXgpm4gN1AU/R3wmuzVibRz33Z6EJ0NXvKxHeC9SirNYJkQseu3CE02/mx
	 XFtERUzoDggmRdALG1ascye4xYV8yaLNbnk04YTQKdCMDNXw1dB7Dfhupg5hhn5Eqv
	 M5iOsiHwRFAmw==
Date: Mon, 09 Nov 2026 23:21:36 +0000
To: netdev-bot+sashiko@kernel.org
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: bound reassembly size in tipc_buf_append()
Message-ID: <mHuZAf-oFGkrZS2NLMDwNKobclne-YUo5tKMP7IZ53h15EAX-S7xraUmY5K99QcfwmggaWJgTcdctsXFPaMuAbooTWyQGhoJFfx7hlawo_g=@proton.me>
In-Reply-To: <179426495025.994134.5478434430372728777@kernel.org>
References: <AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg=@proton.me> <179426495025.994134.5478434430372728777@kernel.org>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 621fe41e638a70783770d9319623ec813d65833d
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review. Please disregard this version of the patch. Sashiko =
identifies a possible NULL dereference in the new check, and Tung has alrea=
dy rejected the original report's threat-model premise.

Noah

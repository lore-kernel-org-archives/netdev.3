Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252137;
	b=Nx3OXvbLeDzCYD2trQcW/S4XLkxkWULtQiShaNnB1pn0cxSTBULMSCBuF5IJFXur9VBz
	 q7M+NuvlT1pje02TMo4auDDOh+oEM4XVjUltVcVOAd+S/aT3BdK45eRMKydjkypNEltqE
	 wrB07N4Lu1N4d2d8xSEwOd97AEuHTVWRUGlxuU6q2nphTxz6sgkGtJrJek5gX1aKhjzM9
	 675TzsnBVYNFvfE60U013AUZ4XYROay4BARF3+i0NCAHLH0o5/4qBdfEdzMhR/sequ0WD
	 xIbe8BrYjYpBxRkrk6HvEjq0rBIorSXfh+iyXR0KRvKvZr8CtxsPJG81jpi+97h+Y1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252137;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QJa17Q7OdwzlBQv7nUR+cRX7s0aoQiVCyDLj4cbyqjg=;
	b=H5OotRZ4XJxcOhCrOP3BPEcsknt9Ax4rADxRmrUp/1PdFTNMa/ALYFPZs/dTGe3TeL6h
	 lN542vScRPe8a6Bo4vINUi5wKsZ3X6EKtpj18mtcJBpqp2K7VZOx/wVWYYjm/bQEpGE0k
	 k8shXQsgB3HXZIWvMslHuqKsonLGuxFYn9Bkedv5TWsHtZgFuLeKgHmBNFceGazL1h4f3
	 b4fytwjcObPKH9M12yebkgYhCFsbChFfBplAUjpJiVpgIPeMuRO0v+Zl5jq07vpR9n5TT
	 Lp0lShEcxa1J6tWoeikw9Xy7/GioTj2/epysMcBVCB81paPPxspPLl9PRXvPGKdSCYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=hVwUW5VZ;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80A606A334
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B80A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=hVwUW5VZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1794252134; bh=QJa17Q7OdwzlBQv7nUR+cRX7s0aoQiVCyDLj4cbyqjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVwUW5VZqa4tQZgKwfUJMIJQ7Js5Mgl1vHPIN6OjL+9aCl8eAQ9tTKz9GpQfyzGH2
	 RQGMWA1KcBUTYocj7Mr3+Br9wRIgYn/Lka6lYR3FuGjEB0sSaVWS+oKkHeDzlV8YON
	 fcoO1kTPazMI9Yj0KaH1U1EfBMgNVA3jFQawSECncHmMc+5aGo+rlC/jC8W1/r72FP
	 c05uZqPRp5dJP+6gjMXjGGR3H9wWcqdY5+ZsixBtPU1qM8RKb/4DuCfponmPbDqDxH
	 ODD8WhjtS/ZtCUuUu0EUisYtrloWLxj2f0bj30fA/ETIZn0ugYteVGHELlZiAPsHZo
	 z1pAsoWTWI0SQ==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 553EE44C05A8;
	Mon,  9 Nov 2026 20:22:14 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net/sched: let hardware only actions drop per CPU stats
Date: Mon,  9 Nov 2026 20:22:07 +0100
Message-ID: <20261109192208.1322568-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104214607.556269-1-acassen@corp.free.fr>
References: <20261104214607.556269-1-acassen@corp.free.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 replaces this series. It has a new title:
https://lore.kernel.org/netdev/20261109124618.933149-1-acassen@corp.free.fr/

pw-bot: cr

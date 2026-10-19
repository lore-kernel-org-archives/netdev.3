Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439793;
	b=Oi8q6O03m9gdPk8FJoMJyBqMyhTHZ3yNnj/F0qfHxbmAb7YifIIL4pk2brrLG0TAlt6E
	 DLWYsLZEP6GoaLE75vKPc65lzo5UsF4ZPyoCDOKwTaQVXLmUsICDKi7vk5+VLOsVWxvUM
	 2wrZqccwIIwIgRRlowpuzm6bf7nEqD8a+Q6U3oPVlTjJjNXwG0CqZ0c0nOvJhZqcrKPV+
	 lYsix1XjLkxUKla7/UpKR67WDBdXh3LrBJOxPMl3CLkKKz+3zu43NVd5bWrdQjKLx+DLE
	 WjEqCzgqQA2k6TAsvAvId/P4KvZqS87SZXlVggphf9JMx1caCQbvmCe7WOJKmAAgarQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=KFD18Kuk8KHVtzolcXm8lj+hVkPEiZqVnIQH4s6TyNI=;
	b=pXHhSOIJ6jMoENglwn5jDCEuPnqS9kQUxHvrrOfET3/nlTQZxQR/W7XQjp5SBgEWTfqG
	 iztP0pAwuFnAL7y3NXP4qybsybTRO00fzThcUAcG6ZkbJFrN574plaEZdts0LXZdEaszH
	 eNjHKbW3piuVB8wiArZ5vnBiiD06Dsd3DPc1UPcXaoMcNvI/ewc1A+kDrRjeStnKuDTEu
	 JdPuTtKOgYVfuqP0MWj7hXJGp+oZPtd6tOjHDWhk6EpR0oq99NE1gRmfvjoWObmXJ1rGS
	 CQPze5IfztrIYjC4aePqHykkTWH24+Zp+xltHiTSKqSz2/nIJMkxR9eHNom42n61qNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=anEI1RzC;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48F60A2629;
	Mon, 19 Oct 2026 19:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE48F60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=anEI1RzC
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 09C2AE83AA3;
	Mon, 19 Oct 2026 21:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFD18Kuk8KHVtzolcXm8lj+hVkPEiZqVnIQH4s6TyNI=;
	b=anEI1RzCaFDGHxN2ZhpFdYcpqf3WWvfP5xZrmu1vZQF6flfxmbO6a9EtKQs2aVcZ0mqMwv
	hAtuqQXtdwap+oxIERKdGXzu21ORiyvOoyhAWwjvOqr2XUVoUh2BSA2xfIIN1nrybBSTY4
	2YCbBio7edCgJ0m+bNhbprWvaMJTxRxFOaDQnO0lJ+qJDjRWya6R/cTe11shqKSHLr3TQS
	+Wf3b2Lclxn6ErxMHkLsTTaFoKbY05xvbfpAcFSytc0qD7+Sr037WLS2bFVFkF1KMiqN3o
	0wvz9TcN7Dk+ex7y0T2e8H8OrfP/8SmxAj3uc+VYxA+bNmA7/XRD8h3QhYEWow==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id ZzQ5QgEu2xVn; Mon, 19 Oct 2026 21:56:30 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:30 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 10/10] net: pse-pd: reject a power limit whose current does not fit an int
Date: Mon, 19 Oct 2026 21:56:29 +0200
Message-ID: <20261019195629.308080-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8f1a899c-e026-4887-8d5d-400c5c73581f@bootlin.com>
References: <8f1a899c-e026-4887-8d5d-400c5c73581f@bootlin.com>
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

On Mon, 19 Oct 2026 14:53:02 +0200, Kory Maincent wrote:
> Same as patch 9. This is not a fix.
> Can you send both to net-next instead.
> You can add my R-by tag to it.

Thanks, Kory. Will do: 9/10 and 10/10 go to net-next, with your
Reviewed-by.

Carlo

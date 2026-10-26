Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995979;
	b=icZKWnBSfMulqxegsijUWZvpqlRfoivCAvnQRAVwIblKO0IGGRAYoXCem7Am8+CY/b7A
	 0Ob9GUVUZ1QcNSsqNEtX59sGI/+ZNPIhn8H/1oOj9lhbRz/nIePmbdf8qvCUy/XEPc4DF
	 8hOoUroIeyqfB2KPAjrwzw8AYbqL4BGOBXgiiSj9Frt4IUtAcnnMvwYY2+waNQysb0Rv6
	 5W/yA+s0VWXnxw3pH0xYZbKYEn3VVFsOoOG2lOh1VB3wtAG1smHwdV/SAaF7KK/8HJbb+
	 YmP1TeTOdALTdQGAYYqn/UF6+7CWyZrwDFAn5w/EcCu9od9g2iAuJZP6v+zabjBXRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=bUW74J2qmHhxGB28eutwe1gyvRdDgGbRLcrvRy8oQs4HQtS70HtxIMxdk6rWY5tNOSN7
	 u3GY+i73Za1UtdjGEGNWiFWumusJJ+BG9D1Huf8EiwFNNQ28C//ahQESTrn2Kl7cYle6B
	 wc3esBEVL3pkNhn/zc2P5rGaC7mfxz3sDErGGv2TP0SNytZNz4ereWjj4iUZZSE3oAdke
	 CmBRdl6jzYXQHoWEfWNIo3UqnouJi9dfazdL9WNsd7DcmGCzZKdaqcHICGoRBJh9fQkg0
	 1I8ueixRvJFDt0T0B40TNJKY2l4EfKB8bjJc9HFkrPODbgz+vQDNSXk2GqFYq5ApNWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xj7JVViG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51BC606A31A;
	Mon, 26 Oct 2026 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xj7JVViG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9442D1F01825;
	Mon, 26 Oct 2026 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792995978;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xj7JVViGp7AIOg76fYp/E9qW1xAp9ct+81k8y+atycnD5QK1elL8EF3VeDNPvCQjZ
	 RkZFRZw75zSQJ+3UoJ5/Raf+GTDHW/LHMhTQhj5BAOzktPtUB02ktW7VuFh5qtoZzQ
	 /8b3hMXHVK5w8ONsQBVjd9T3eSDnjJQQnmpaRDXr021NOWjaSqsTZRk9gGTOXaYhH7
	 jc75/jl+zn3VTyU/vH/Or2yiGofvmsCp5CatdJWpBjn69DKQmIfd63g+fXO9fms69t
	 m+DF1W7c+e4VVciZ4Bc8wwADel8ZrK/xAnEPRpIKyMPFJN1DUFX71z+RVLBzECUrcd
	 JdA4Co9k7jZDg==
From: netdev-bot+sinfo@kernel.org
To: vmukunda <vmukunda@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>
Subject: 
 Re: [PATCH 1/1] octeontx2-af: widen TX scheduler queue index to 11 bits
Date: Mon, 26 Oct 2026 06:26:17 +0000
Message-ID: <179299597715.3327.15310609508099737343@kernel.org>
In-Reply-To: <20261026062316.754904-1-vmukunda@marvell.com>
References: <20261026062316.754904-1-vmukunda@marvell.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

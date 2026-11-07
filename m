Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016840;
	b=fuby2jicz5L28pFuCbOEWnPcZXpzafH7vd3oMqNWzRLSMQccqwGxrqRmJywYg1DJxwBs
	 TZjuLM5U31LSXTfRFopuLrdoGCtcaXDUMT1qEGRkzZ2wVzu+EZSJjKZ7U6hjayw3z3vIH
	 BV6qx0HpCBcss9QEPtD5tgLLexcWIiwgYXY6vZTE7vqMSCuGJemrwoP5iXIEkYxdR6Z3C
	 F1cKojaHXI+iaF5j+w+vwVmdZz/hcTbM/Hdx89CUOVK3UqOfDsE4M9fIU/2xHL+6BjXex
	 zM5/u2EW8BzOIZvsn+KOlnN/QsUj6eFSz8asPU5QlXd1fWFZAd52aZuD+vC08izuvWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=dA5YV+qLfyZze2o6q7xGuUgyxN3HotO83G+wCkli+Ib0cvUAYW4EaEB3UI8mdUOvJK2/
	 MdpmhsQ/gXM8gh1/rXtECssc+Izn/otCtnJTtCP2qyjoypF3t12jHK1m1p/X6JEJ6RnSm
	 9nDdrsKYQrODcbzmUVQJ5HR4e3K7zrdcefLhz8nTTKzv0NT0iKcEO++/bgRSB9PTkUotl
	 3bwmaJzU0XN8SDqqtRzsvg23oQpAdAZ+tub8xxgZud62JwcKoCK8LX6CtHTRRhS+1OPiR
	 IXZSwS5LKIy8RqOeDiF9mP9obnM2FVnacoL/NRrNff4edb8jAH7YLCIO4n3Kk/ky0Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzaJX2PE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A35606A32D;
	Sat,  7 Nov 2026 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzaJX2PE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636601F0089F;
	Sat,  7 Nov 2026 02:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016839;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WzaJX2PEUZtSIwg+mUAun/Dfo3sTBzjtqMAx8IIBVkbVAXyknReSBYZO67hWB0NlS
	 sqKhZ5NCO9R57WS9cZ/ctHqaDl9aF3Oi84dtSw9MAP60ZDmt5CPFAMNSozxYBoxrCh
	 uT9A+xLTfAfVCYb0Py4P2Z9nlm7mKRkb+kzWlCQKqBSb+874336dIBPvCuBSeE2+PE
	 w2Azzk6wy0w027zcoRsbFrmlo86e7AUrzFJGedBf/Gk0s2DFfmqd3TYuqMh35H1C5e
	 jBrznRjOb8gswWhFcYnwy5k4BS7XN2mBzH5bkMv9Y3kXccAwEDGqDDonj8YMmIGmDN
	 Vm4G3vcyb6waw==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v3] net: dsa: motorcomm: Prevent rx_bytes/tx_bytes underflow
Date: Sat, 07 Nov 2026 02:00:38 +0000
Message-ID: <179401683893.488859.14756679871319417849@kernel.org>
In-Reply-To: <20261107015447.335056-1-mmyangfl@gmail.com>
References: <20261107015447.335056-1-mmyangfl@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

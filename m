Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007032;
	b=uAgx5wYlugmcP24JsIjG4fNP2qljj9JqJDgFpAR+MoMfYis+/r1EFIEsSxS6e68DKXXP
	 l4UDSxtQW6UkpIQR2nZUTimdDoxbTd9o84O58c6pr4AVZpASRKSoOGmYkXRLZ0xbOd/8N
	 lrlba8QlJ90eq1gW1N9ZaXG2XVzPuZDnMoa1pp771lkwXtasFBDTbfItbMuK83br+GSXK
	 QP6ImeKQhJAPI5Ta7I/tKH1ut1G791EjFcqkfBb11jXtRr5K6NGhOvDFliWCbe13pTlSU
	 c6N51Yvkz4X+sl839t2Vbh4roykTWzgCsx7gC0tZ3z+6LwoiavpP8+6KKk3UeyFh6yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=YxQkmde9XGQzPUMvFq5nejOQr86vQvET5g8y93UYOfA3dq29BUYdcKjBVjv9QdDQ4e1j
	 mrFl5anTx0xNkA6zFhiXp3rmHv1ssDgG+gUqPz28XEKw31+mQaeGQcZudHZqZJu5cjl1e
	 JIlDjoJfRbTtA/xdyNM7Fk3rRWYX7aiZNpLiuR0Ea+2cny90WirGGPVCPZAQ1ZeZPtW26
	 vASjt0ipVNZdvpOCIl7WMCky7x+omdlopNDd5mRoIGtz14lqNRwsHr0VGEe/6Onyih3Ec
	 6Z3hcDyqKMyxOLc6P7ZZAVR6ReF9e+iPxNyXrvkFbYwIoifo+cqUGaqZJUzum9OvbgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv77looW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C724606A31D;
	Mon, 26 Oct 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vv77looW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024C91F031E8;
	Mon, 26 Oct 2026 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007031;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vv77looWRTbHe5XHvAcRG+ugZWwAKh/iEVebYHous0O9JgfNQ14FXYgG2Hm2Ehh5q
	 +0/uUN8Q3g6OZI1OWJZ/ovYsOrRW+uBaJZoEcxQ0TW6hHTSETP1eqQl6GTwnCl6Q4n
	 93locO4oryXH9JjVPJz6F89rmNwjs0R5j3VcKh+8GJIFONuwJjFzfJ0s2udneMUj9D
	 ZeTUPaq0V9+xA3jKa1j8ipGZcqvAetgk4820v9p4ZoqROPcErVbxvPhAux+VZip7jY
	 1pRFd+RkoPYnHdyQepGIWYOh8hZNUk8k61iZb9zEzuy4r5KIzIPGMctQ5cD7hQnqTN
	 4CUVEKDI/gkyg==
From: netdev-bot+sinfo@kernel.org
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
Subject: Re: [PATCH net v3 0/2] bnge fixes
Date: Mon, 26 Oct 2026 09:30:30 +0000
Message-ID: <179300703050.3327.1854487549237861268@kernel.org>
In-Reply-To: <20261026092757.9168-1-vikas.gupta@broadcom.com>
References: <20261026092757.9168-1-vikas.gupta@broadcom.com>
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

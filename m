Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956309;
	b=TRmKeWstGYgq7CT7hY/lUq4E41PHUcAMGPpDw7xmc9W+Zc+F3cYIlD1XTJEw/wH8xEWb
	 WS3iJtHZIoIbBj0MYufpgQHdfenPYB5XQDxJGbUFf1wE4kIkh+YHwSzZTlIaL6W8n+5oz
	 7lFP+Wqjzjo/l3WW4ZReveg0QxiRENta1ZswWtZv7JZH8e0wZLMd8/8P+a0UgOrDC6U+4
	 kLBi6FT2zWm5m/8jW01uhzXNj/46q+G9rvr2VnGF3GrnjY1QMUgCsguxrXti3T1rxBhjw
	 hZXX/jPrMcaoiv5Y35BrC8EgDZ6LlgeumtASt0WOu349vWgMbhTgWBCnsIkRW5QIA6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956309;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=Jf18l1IGlMqetL2mYxMuzRF8dySzLjesGajEOdzqOGv1W1AZTq/UymTwUcysZ99GCnE/
	 YyfGsavLexjk1XqdFyP/5NjEbY+KnjLE+6aN4/jP+p44oCJUhj21ixf4VHclJPsEXlkDo
	 CJMlV7SKaXVXVfLmPU3+H34v6nRdwXnzuTef7+lMJs5M7pgnbuZiTP0+FaLOhfPc+2KL7
	 IuWm2JCrLtTycX6G51ES+UIQcHZS/LeTPbJzpWdvFd4SbX646hCkX4dMwZIa88dqGRH3x
	 NUFKkICM+Pff/fSFyBLRa6RAV85CJjJ3wB2wsATQpdZ3j+TxBqFNh3KH+MLNNfDvBiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4ZcNPkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAE606A328;
	Fri,  6 Nov 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4ZcNPkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D7E1F0089F;
	Fri,  6 Nov 2026 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793956309;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4ZcNPkSyRQJZ0ssAxyOMZ6NFqyoKY/VDCujA8FssoHINi3z2X3hPbUHDPdeXI9vc
	 eYCG814CQSAlEICIRTKLQ0GM88EyBjkhZ+qdk4fqN1/egDjG9IK4Zp64lxEV87Gdu0
	 IBCJIeac5mBite0gVy9eUWdY2B1MMyUR3VlVGaV1L6dpHIgEK8MUeBC4zv73EQ/PK6
	 TPtzgyakdQ21r3JF8eZQQOHd+Us4Xo6p0ETmPwXoY578Lvmkt/svBechSexZLD+tLv
	 4jlJugHLDXDXRx9e0giw3MySAaf8XEcHaych+oiYGidzNOERGrbfvMgXTeLgmMUGKq
	 frDF3t+wXlFWw==
From: netdev-bot+sinfo@kernel.org
To: Ding Hui <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Subject: Re: [PATCH net-next v6 RESEND 0/4] net: stmmac: fix DMA descriptor
 ring cleanup issues
Date: Fri, 06 Nov 2026 09:11:47 +0000
Message-ID: <179395630778.488859.15565408556126944757@kernel.org>
In-Reply-To: <20261106090507.1020751-1-dinghui1111@163.com>
References: <20261106090507.1020751-1-dinghui1111@163.com>
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

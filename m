Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654912;
	b=v7RLKRRJH5PcXmH+nSjdNm8KshuOZ6Gm33yno3YKM6nIO1OT6cWgXM++h4hfhG+SVr+s
	 D0RuWlBDPi5wZUurj6ycB/sUzig8wORSYzrOmG741u6dq1Wv202u7NW/o85iq573ZKZQE
	 cpIkTcQ4w64jsrdUSgOOef8HAYzGAIl5qApjg/TX6eJrp2OAxPaJgHT5JOwSZ9dNLi30T
	 fO3XR898MAs3x50+QcKeElEi22/A49V+LZtNQfGrfdBYeCtDaUfH8CYGih6YQDPDB2aG9
	 8XgbsPrC5zHwbV572cYIyxRNBq+thp03ghpqhoVATWT/M2eoEJNX76C4PC6nXbZ41Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654912;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=D0L8YmXUsy3VAr5yASjqxojAgTx8Bq8rChpwYZFvnlaTJ2Glmq2O/YEItxYxmDuehNNL
	 XQz/28h5adw0tUTaftG2/mOdjM/uAJFKfjw6UzyTHPIQSAclOA6zJyblqLdOrZ8Ig/cc0
	 Ah80CQqc1jYo2CD9o4WDFK+gCAHfhJdRSvT0oxJAaWVfLK/t6XjkbjhZUWHbRYjt9ZFQb
	 at/5FqGirZc9GOgC0BMVPut2Lkwf8QKjgdKDZOGqbZdID46R+C+0Qj9mNhC9tON+SWAqz
	 GiZMx2bHwo7wIz5aG/rlHmAAKHMwoxPOcKkhzccTf48DjoekjVOntP3Cwzfe4vQhYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qe5/Svbh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA7606A324;
	Mon,  2 Nov 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe5/Svbh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA91F00A16;
	Mon,  2 Nov 2026 21:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654912;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qe5/SvbhKKwLWj5mfyz5oAv5inKcfZhSP0OYWBMm88v9+hzdwOTsr7Jr4Sy2umJpG
	 HH2KGPgc5qopGZZu3kEyvdCeDHTEQLkKzNew7Z6L+s7hllfw+UeqExAz/IQ5UJtXef
	 2xTFkNm6eS7h6RXsoH3f6fXe0yTKThDI+7zgWkaHuXb54bJYVq/sMoXTGQewui6m6P
	 dUvDRWT0LPLijoGZM9maAAXyiSKwDFaQTkSXrpoM8Hfuq2KvMBaMAevNoBQW46rN6t
	 Rih2qHeRosl/Xt0AAq0fHkLrrlYZuETLMsqfm02fRTtAvPZyUOZRGxYf8Cf/L0duBK
	 L2WshtVfSrrbA==
From: netdev-bot+sinfo@kernel.org
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Fabio Baltieri <fabio.baltieri@gmail.com>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/2] net: phy: fix PHY interface mask
 initialization and XPCS usage
Date: Mon, 02 Nov 2026 21:28:30 +0000
Message-ID: <179365491082.3286.2704718831529133016@kernel.org>
In-Reply-To: <20261102212506.3348537-1-coiaprant@gmail.com>
References: <20261102212506.3348537-1-coiaprant@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

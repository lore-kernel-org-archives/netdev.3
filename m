Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270198;
	b=t9B3obpzMWqpEPS+fBPBXTg2VO1c4x0Z5mLz90ZeLbJ/awkFjfwEvkmYQMvCnPPyjEMT
	 a8bdEGi1PPBvt/PS8S8erRPYN7zrkq8jmuak9vzk4KAbZnYfNPQjsYhPML3GudM+8S2px
	 ekL4Du3cRdRAgehSyCQUDVLtn7WDIdd+uR0/sRoK6cLO/DcDavYE2gFIvB5tSDdwGkLxG
	 kEKxdzuSEfCMgLfN2A/CfGrrnvOmt+eY2ZtVoRW7rIZNowRwGE29pCYyBU676i54Ps3NT
	 +Q3fdj+tQVsOYS9Zh41IEE6Zjw6LXXlv0scjHK29M7tPMfozA/mq17Iqw7GoWvbMhRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=kdD9bY/JabsXAmUpl9sbxbktmT90uL5j6Y8VHdGLIcpw7JJAp3G0HgFLpOWdgK1ywF7p
	 3gGECFpP+xSmxbcZparEGSIMTm66NpL8N0t8lTu1sPRwFSXMgyMqM2T78A/aAa+Nv3HfE
	 Ex81n4AI/1RVobOQ/WJ2XK1kVtrbX3MtcyKTEqmbD6QQKm3jKpXt/tzmNpBzeaIS1k0wu
	 KU2olbSYk2bSl3td+k5waPrblhveSEITZPQNoH4XwuwkD9bywyKw/FOKFhTVV6PPubSAf
	 HFksFzRR5kqBVX5oD+EYVuxnE+SVBfXlHMshFQlZHqL414VKekxE+8rBL3XqoLq+pEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQ3yFViw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FD606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQ3yFViw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13F41F01828;
	Thu, 29 Oct 2026 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270197;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQ3yFViwYPi3Zq5+ILxvqHXckmFlySr+JemIF1HMaqHQMNgGufL4GjH4eWHs7OjhY
	 E2Zp+t9hM67MMIdz+kmVRHWopr+IT/7HOwb+/2IPh/J55Px9dveEL+8iCEIgjZaK7R
	 8QpHNTnV/13whuBgw5JiijAozrwlTNZMfjZqk1ZA+3F6tYYtCfys2TyYgvNYZseUx5
	 RFO8mAlFPg74F1K3g7l2ueBLUCLHss4YwCrjFh8Yj3FFp+ZA1jaTJ4ALDcRDXu2my4
	 kqWb0zzD0SvCHuuWEXulmKZCxeihYR8l+73U077NsuvSvQWYDrZ3YR7dJqtUNZ9CO5
	 ilTcAtgMfPtlg==
From: netdev-bot+sinfo@kernel.org
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>,
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>
Subject: Re: [PATCH net v5 0/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Date: Thu, 29 Oct 2026 10:36:36 +0000
Message-ID: <179327019639.3327.12142593314341295904@kernel.org>
In-Reply-To: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
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

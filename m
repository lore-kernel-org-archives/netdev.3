Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796836;
	b=wTwp8szp1cUgKqmy/iWqmgVsLF4dJW7tHbmaMhvEKMzgu6aIPJB0VAy0bLyB9MCxkKQ4
	 t+Tc42HKQ73/Hqeavxj5xBAB9lab/ZDIjhghEhMxrwxuG1eHBWKJ9UiugCTlY5TT0E9Ey
	 iNbYJyE4Cbv2fgPJApzg9d3EH5v/aKyADltNnJSIs7O34vG9yBPgKoQ+cKxvw2e0vM8xm
	 REfhIN/R0lFyI8ohchtM3wUv7JAxy0CmHF+eIYS0oRRMtmAsAS4Cc4kp6Y5qyse2rxIii
	 Zn0t5rPlL50c2f+Cs3KJ0UiHtqwQMluZtGqSEx+KXRJuDzjBhrHqw5BwKCsDw0Gfj7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796836;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=4T+b90u3VqsvDgWddU+IyKQ/VU/v6atkrI1415sJL14R18mdPpnmG0zz9gz67artOq7C
	 LVcdI53nefzu2Npi+5Hh4+k6UWY0fQKoSTb2Ztq365IMu8smGXUDan6D/okE9Gsgiuew3
	 fxvmLwgE3N/VacfW5kJEZbShoiapANAf3hz+tPVHAFC332ShajoVYwQkc0BFHqo/I7wJS
	 mQ9h5OtYzMBT78yIhCUg1pVxnMzmH3eFCHqMMGgk+udaB7ne0Mk0AXuOnmZg+UChCS3sf
	 HNL3AN2+jUex3HNGH7iqqjYc+2hMFQ9SoIurnJRGIV9E4CHDbMxHrfEqAO20ywo+Obw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELcn5Pf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43263606A326;
	Wed,  4 Nov 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELcn5Pf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58521F000C1;
	Wed,  4 Nov 2026 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796835;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELcn5Pf6ekrt6q/OOW+QGXy1IWNsRt2ltoT+vgwlIrqRYQeWWtgFoQi0M1Eu85KWW
	 mv3ZiCLceR7BT5OInMHTfPaPE9t+3w97mb09La/0CvA3dz4YF17e/3N7saIzUZ7Cbh
	 46gDlvq5O507Xfe0dcquic7KlT2UiNUl3SIIM4gz5RANHHDN0irY7JOcoGhGZTzPO6
	 SfMqGZJLy6fMB4k5YX9JqAV8aStM46LJ2p/5ooYS1hpUoBNxzrOrhmvlobnlI1Jysb
	 g109tXurQA+H509haO8cJz5vmpxrYKm6kpYGXoaoZSNZyrJP9UMTJ1g+Yb/P/XBEoh
	 UnD29lbJJTgXw==
From: netdev-bot+sinfo@kernel.org
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, o.rempel@pengutronix.de, wojciech.drewek@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
Date: Wed, 04 Nov 2026 12:53:54 +0000
Message-ID: <179379683436.488859.17901811413050625483@kernel.org>
In-Reply-To: <20261104125030.1183146-1-zxyan0222@gmail.com>
References: <20261104125030.1183146-1-zxyan0222@gmail.com>
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

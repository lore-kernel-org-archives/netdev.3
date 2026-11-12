Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492137;
	b=DeIYJSwbyvmqphm2jWG+yPyQiSY9Yff+vgUl9khBgVF0fIivwOF3VADlWKmbaj0ubroc
	 XY44N6GHSZpUW+/Gr8XEyF9hqsOcBiVAfN3s2ap63xGCrtz/qwXbjJsKGPE0Wzohbbx43
	 gwVmbb5LtT3j08GnSG2oAWl+bHoVFOtxAyn/JUEh7IICwgoEC6GQKo064fdMyl6+2Saim
	 wkRJ56yfrjBRMWg46ZV1GS1gJcl9PhhimOON0lCaN7v9oJ8FFLLlnnfMF7mATNlBCyclk
	 DGfDSIj3R2MO0XMsRS36YnDHB3u2JXk3HXO3uDKOKqSz49s3itxpY9gOwfMYxwAVe+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=OGeYaZ6HMVQkBCuxKI7YcJ1FEQ2WMfwGOoxt+UmcTUrC3Y3giT1qo2vK3HMqPtv0pPfd
	 jWRNwvrH3exDHy1sSuVl/pCTSnxfmFEAn5UwJyoBidlxYpeXY38U/XUQmQ3e4DDK4bEng
	 NPT4JRE+lQbdk0VanBR6SuwUOj/joB33krEmNnBpRA2CjxC+3MXrQPR3RcqAmy46TY9Kx
	 WvYXN49ACNG6oRUcumxyu99Nc6GnWLreNlULDC4M2ySGaD6BOH1SmFFM8/+wpFZ/dq2j8
	 88R9SEPsyfGcs5ag0El/gTxKoKWedEr9sDwML2J+y9OPd/LxlV/SCgEETJGC5SDPpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyCNKNBp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14586606A330;
	Thu, 12 Nov 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyCNKNBp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EF71F00A05;
	Thu, 12 Nov 2026 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492136;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YyCNKNBpysLCemDZZfCc/F7vDencDP1Pi2Tlq8tELy9rXkatBVzAOHrqGzPLREvTv
	 3EugFEpVaEx7gw+p9pYcraR8NCmVJLrdZDrKRneUbsK5aYwHyQ7u6o/5z2ONY5H+uC
	 Vi3tib2d8pdZFDNQd1Ih6P5gm89J+D2Eq920ss5gB8muXviyaCVbZZwYDPgxAuJD/0
	 KX19mbNrh7ropLv8yEQJyulvRHQedqHidDk4byAha0nHUVldjghZoi2fOn2J8BJuLU
	 KFsmuffgEt7ykLEIKgrKJ3xsDcItZlX5u2RGnH59NXUjpC+Q1YLBrE0V9GmuDWBX3v
	 g9Xmlwvw3C54w==
From: netdev-bot+sinfo@kernel.org
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: 
 Re: [PATCH net] net: ethernet: mtk_eth_soc: Fix potential PPE hash table leak
Date: Thu, 12 Nov 2026 14:02:15 +0000
Message-ID: <179449213543.2168702.9560735261651362363@kernel.org>
In-Reply-To: <20261112-88a3a7ff32-net-mtk@mail.sdu.edu.cn>
References: <20261112-88a3a7ff32-net-mtk@mail.sdu.edu.cn>
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

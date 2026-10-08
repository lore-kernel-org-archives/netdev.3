Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C54C77BC;
	Thu,  8 Oct 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471275; cv=none; b=Acd2xcoipaP+voIFLwfC4FGh+JTBHjKrMQj2laSYLgAfGr8hOjpRCebHGkzNSy+qkjToVQIhYlTFGUrbvJ6bM7U91pRLKQ4MkFzumyERkD+n3R9Jl4jiYhvQluz39v1dFR+uH4WS3FuTWL+UOhC31/wZQxb7BtpaMILiK1TZWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471275; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ObD/O/800tnQSs2Ypd2sWTv28aE5rAPvFTyOFYz1A8o0cVd1Urb9EZMBCEseAq+GZE7c3Mt/oKwmYnpO8zoKM2PsJdBW7tVtDHzH13WAQEZuM2ccONUS7DVhCjyFZbALZ1fujtxe7uKOxBMXB8IJnBF4KBORZslDaXs5Nl/BxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoIzxkPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoIzxkPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2501F000FF;
	Thu,  8 Oct 2026 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471268;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoIzxkPUgogaxwEZ2p7NA5OxPZoODM6gidderU9MBF0NLEcuLoTMSfJ2mBSOR2uHD
	 5YYegl/htA0rbm9cyEfVIKTUmcr4yFY7XRHIHuL7oM6lQz3ULlGft0+4muXQPi/gTv
	 u5EsCyWK6rt3mphl8JnbZj7CQ8FAwnHRbumjNZ9YAA+fJG9+GaLR0BsbdauFq3ARbE
	 bxsRQByBzKyCktim1Hia73u0UFAdXyPpP7/PL6jCMnxLCWf65Vuo0qJDRq2ygZM2Qt
	 tTDt1bmzJaeI/x0g9yRHFH3Fq6XHW/f+f4WzqBSedtCOaMJD+Z87R0/qEPsRKJUg2l
	 BtF9iunBiTM9w==
From: netdev-bot+sinfo@kernel.org
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>,
 Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Subject: Re: [PATCH net-next 00/11] net: ethernet: qualcomm: ppe: Add support
 for IPQ5424 SoC
Date: Thu, 08 Oct 2026 14:54:26 +0000
Message-ID: <179147126645.2527009.13829110581548714861@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

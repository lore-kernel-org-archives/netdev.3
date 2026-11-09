Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221741;
	b=PEUZAY/W5jdG7RVWBRBSsEMvyeybgeWjantWef43DK0mMvvR7Jwns3FH5dqSCZMQ/oBH
	 nD31oZPkxuC2J4uLYPZQKHzFkomcbBecs/FUnklfgIWsdcaJfxodgF6Tc6JkkX2QbP+D+
	 kATuDlCOVbWz1U0BOAK+loQ7E2kQLVeRwc3E4nfNoB/O4U5mEc3BgRrGWZpgemq/ioU2I
	 3BLcyaXEurKqCiBJhPzjKDPiLhrvZbaVKy3dQRdfA/u1/hSv4KzFLii63Qc0kH2HVSUiz
	 w6RYWnah4dDMjVunhRy/8LwECnUkVdBdGmGxCF4Hj/tENyX8fwIgb9qQjEuFk0dMA0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=q+s822aoyOQcLk/M2/YgWQ6S9BG0XXraAhsgxIcPi/6r4jE+ynK5QRKJhhNmfu5Zwp2g
	 gtSDHGrJevgFgSFn1+Tas0mXOdN0r1QiWm0evrLiz/AaiVWHirpBv5MTJW2iyJ9X78gCQ
	 MeQZJHb7XF1VQoQQ3Dh/dfENt83yVpJRaWpYyOxYAELQNv+DUJUPVoyxBsfwnR+ZdUfdB
	 kraOQGz13Usf4J6AaloJkqJkf9hjet333ZJflh/z37yzppQ8iXRptL0IBRhklh+QpIm55
	 tBQsAFNxMa8RutFNFTLpYryh72j3Q0J/gCdPF6sQJCpYcxA7gFr04Mycx4Y7QpmJL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdjXmmdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AE606D803;
	Mon,  9 Nov 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdjXmmdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321F01F008A5;
	Mon,  9 Nov 2026 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221740;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdjXmmdgpD/Q7naIbJqzKqIhUpEFXgDfOW1C6M6lLN1NuZicbb90CybLL9sc3idKc
	 7wwBBOuA2vpcFgaQr4QaGe7bRPmCukLUHP3vcguIWZWLMpEm8Kdop/X2kAt0ne95Oo
	 5csRE5aEdZyErVJc9jupzJt8McbCpP9t8aZDKuz2v2lxSBsrNWetCm6LWB2GcNFohM
	 hx5dNAsYnCH/Ygk3vLw9PY9p7J6SH0oo9LonpXBflO1gZZ/2r2AV/9pmpzfcHgY8Te
	 rSe7Eyyt0+7vai6/rRho0n1rFL01uVk1TGL0G+T7WdMFwbo9X7M2j67lcvyO11/cxO
	 4dZOaxz3n58og==
From: netdev-bot+sinfo@kernel.org
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Aditya Thapliyal <athapliyal@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Fix keep PF_FUNC match for AF TX rules
 in rep mode
Date: Mon, 09 Nov 2026 10:55:39 +0000
Message-ID: <179422173977.488859.15568451328984924402@kernel.org>
In-Reply-To: <20261109105043.1986921-1-kmahammadraf@marvell.com>
References: <20261109105043.1986921-1-kmahammadraf@marvell.com>
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

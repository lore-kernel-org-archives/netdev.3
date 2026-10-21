Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550364;
	b=kp39t/2DIBHMg7SCaYPMiUxB2uAnJT0g2VLxAcC1c9M55OL79c2lH9vmbdsVyvd++kQ6
	 00jNrms0lAhSHT3w3Dz3EBiM2D/KL/m0OEcgo3y1YgZW/5AhXcgYf+ahFgN6jC3gmY/i1
	 hkDAz5rheh+Z7DHBMVXh3KqEarXSp3N/dxjb6qw07SZ4f9JDY4VDx/3HzKj6fPdpZoCz/
	 QZ7RIfoYwqp52MsGpXsqjC7I/20vt0lbKqtv2jiJckE88TOxUpAJ9tOjPtfsu+XWZ6Qsx
	 mpl2yGNP41QPogr3cIETB8uUozNAP+oDA5u7PJy5dmXUIw/ady5NK+VvnHwxIuc8q/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=lodPzF5K0TWMm2XZtn6Y2ZrbtyODQ8Qo7LaECiOwhyTGjvAt/NNMtH6G5kN+bKf166IS
	 A5VC5rYhGHor5c1tQxREvIQyneDKk+22zL1mIlR0ojJzffA1ZclvrdPxLZRocRbTngHvh
	 0bmZrxJ8VGFOc9/na2N1r4AeOtLIs1mNPDjRp1Gwe7q7uwJUBaofBZWeafZiE1md0drPh
	 nysQ8AQLIaCtMOsaWsb29R64qm83Xk65h4oD9/BCpHgXW6SVTt4LLVskPcPGCVh+Jn6le
	 x/OuRlHldpuD6las86pcpf9eor60eLYS/I132t2+A5h6u2encwUib/atjYfXzbJvMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inyxHeGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E20606A319;
	Wed, 21 Oct 2026 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inyxHeGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526D51F000C9;
	Wed, 21 Oct 2026 02:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550364;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=inyxHeGD34CUTKiqzw3ZhWbqSxFr/FNn3PsBkoJoNXHg4Hwgnrn7dLhrvk1VKuVgj
	 OjKjv2UQW89Wl4ALLCav7OAdcX7KOAZi92W9LnVXsA5qw8pirzZFlQ4A9PNU9hKuVj
	 BAcST1HRy0VXzfMxAzwLv36jL8aZhQRivH3iBqGy2jHg6e7qvHz+qfagWsM8cOupfT
	 IW0SyseeMw/wv3q1TOx18jyXHa+JJopCn0bzkErAVRlQPd4HJw8sprKk9jcBUsIMd9
	 m1JCb4Q3n14KVcocYEDRNFgEywXrxy0bTbG/Lbt3x+UK+vPL3MvlbaB6z2JQ6LoHQh
	 GnMcElDZyNNXQ==
From: netdev-bot+sinfo@kernel.org
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>,
 Taegu Ha <hataegu0826@gmail.com>, Tom Parkin <tparkin@katalix.com>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Chapman <jchapman@katalix.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] ppp: linearize bridged packets when required
Date: Wed, 21 Oct 2026 02:39:22 +0000
Message-ID: <179255036282.3290.8488375760281728576@kernel.org>
In-Reply-To: <20261021023608.55867-1-qingfang.deng@linux.dev>
References: <20261021023608.55867-1-qingfang.deng@linux.dev>
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

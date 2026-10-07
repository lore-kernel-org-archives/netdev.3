Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0F3F3283;
	Wed,  7 Oct 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398710; cv=none; b=CTBzM7C93kQTWjlyClEbgZdmWwzVhE8cqlOcjgdLLPM0W/RC7VNMs4EWNivM8Hm08jP2l3zvrLFjDkaqg26GnMUx5UDy+KsxiVfrDUc7GgZhdIVpHvHVrVtmq/BdiuxK3ld8fkZMZcz9nGAyybxKbdrMXK8m22K/9cuUVP2TESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398710; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+GYxDlCseVqvwMMUIwftGVmD5r/+filEIfbILaF4G7Rjx0cpN+LO/Ma/h3ePlpxYPVfVNH9E1jnyCoXawFte2ea3cYU/F4CYS7U8bjXFDDhnZTgeQBxkkZL6vc1kfPKOLHIZag8uM943X76tNpsxnocoUgngsem8vcrsV490wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk8TGR3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk8TGR3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A351F000FF;
	Wed,  7 Oct 2026 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398709;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bk8TGR3C0vT/A4vcYA5XqVzKi7dpkyNLedsQS/yg6GGWPNAkFA5BNxA4i95JMeED/
	 BtOBTeInt4zRTlHtTNobHgZc2WnWin6ZhJBI7wxW90sIqjNKyiiVR5tDUpNm5utTNq
	 10sLCsYjdWggFwqQtYUxixMVHUTI1YUdotD3ydMqIhwEYDXNQbNXJDSBoTOrATcshm
	 wpAeiDnIcZVnWrW67XEJD7VRQ9f3/lwApnRh4jvpngVg/COR/AW6253McfjZmtkACs
	 1wD7Mxq+5qmwNhojhP5Cvwkjlkk41PIZFE/2vMIrf5Ev+rE7mmKD0Fh2NAfqOVtbny
	 vY1fhrYvN2Axw==
From: netdev-bot+sinfo@kernel.org
To: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Hongmei Xu <hongmei.xu@oss.qualcomm.com>,
 Abhishek Chauhan <abhishek.chauhan@oss.qualcomm.com>,
 Sarosh Hasan <sarosh.hasan@oss.qualcomm.com>
Subject: 
 Re: [PATCH net-next v2] net: stmmac: dwxgmac2: enable L2 split header support
Date: Wed, 07 Oct 2026 18:45:07 +0000
Message-ID: <179139870780.2527009.10360336120395360082@kernel.org>
In-Reply-To: <20261007183905.2582759-1-sagar.cheluvegowda@oss.qualcomm.com>
References: <20261007183905.2582759-1-sagar.cheluvegowda@oss.qualcomm.com>
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

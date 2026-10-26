Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006429;
	b=xSNIIlJenwPqm6DLG1HtRCNcfXKHl8oCe0X3/iwH9yYqiYkOrJIi/V54V69zqGMRRJIA
	 ECP1txNqFzhqOIudZDakwxgraJjqn7Fo9nx4m6RLLq9kQX5XRNH16G7c16kT4NuR8RNWH
	 h0FVK4jsgBoy1o55+QJFUzFvtwjHjRCXrW+JJJtrqBAm5VgmN1UN81UHNpdp7g7WQV5gp
	 /o9zMSW9fiT9d5Q4A2PTqVt3XJSK2TyTLjQpGW/50bDk/lA4whfEySP3qtrwXjTN5Ip1F
	 zoWnLvt2lOOhnvMecqgX4b+30Z13033GvpP/RAqkwiRiXWPFTJ2DNJ1G1DDFLsNekVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=U4TVtGKo/fiGPaT+dXAjf6JSM+N/2DXwi2N+GS3A0nbRZUFWzorplfyW8obCGNpVgpu7
	 qsD6mT4rp5Ap5pHb68XYhK49UKrvX8PHy5dHY/GCd0JAXu1+rA/BhW7dbi2ZCwlEEWA2v
	 N8Xgmk63XFOTu0EJzsb5eoLWjY2ha0gMJZ6iaKzN8W8XLNmXAC02MCirXryM4y1F5Zk4V
	 9bckKFNf00YiUUj2TeTvghXw4T/+c3D0fnhIh8iw7LB+3j8kbiW33SH1XLsUPQE1KP1ot
	 kFB0TxyW94kmPGmf3p7Eey5pyeMYlC0pBn+LRpFFaGkDWNl5uIk/pKEnKdBLArJH2/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z71U8dI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDA606A322;
	Mon, 26 Oct 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z71U8dI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093211F01829;
	Mon, 26 Oct 2026 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793006429;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z71U8dI2QvKTJynspl15J6gQC6Isn2+VTBjxhFitQebvW7UQ8orPMQoWasdkB4VYp
	 YGSWd3olF68KmcAGygnO0PFtlZ0S85iNoacvgXG4zvbDduQVsmjWL10pMX6uD/4vIa
	 mKQVIP6oe+Sl/UOTqYz6eEDJqzzFMWD957elaUtbA3MMc5pA0v3DofKBvw0plb3aWc
	 g1HEbKMZWulfE3EicsJbzvMqHvB/qQZ1rMQj3IqaeSUVOCbknJ/uUlltz9wlxovGYJ
	 Im9haTqcMaM9m3IrKHiNCwfTPtn0GVpqBjeTIQ8JyK+G6hgYvUfXOnAKBZM1R1F6HD
	 jiDR0+P2wQPog==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com,
 aduyck@mirantis.com
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
Date: Mon, 26 Oct 2026 09:20:27 +0000
Message-ID: <179300642756.3327.8776904148998915275@kernel.org>
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
References: <20261026091549.605810-1-p@1g4.org>
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

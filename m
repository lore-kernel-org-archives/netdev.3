Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699668;
	b=NBpGGuDSJ+Z4tIcQ5VkL37IkDQFMCdMSFO75NQpsi+lTnY5mTf3eNEiyifs7RkCUKG/l
	 XFfp3HRz3O8gUNz98svuWelrGCPwP+yA4OJik8Dn+pElEIY4Mm5Dsys+IlyMMuBZnGj6p
	 m2vJfLSHfMoA9Ly4UG+ZwsRc9IIfVZovz3gGD+C3HNV36haVVgPlVkTgQz15CRHbGqqel
	 6UgtBidzJ7LKLx0rOiHWuns2C6Bxcf9dvNS0a1x6zDGttSVl6xsxQPj14ZilEcqEejrry
	 AqAvaRr01kS0aqPs0lhXXEh0DQU7QxSwTP7xoe2wAMuKusAvWE4SOvwXgn8AdxW8CtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=VyIOdfTY0JrJm8nyANwzCvw4GnPZNsxMOSISEpKMQmRxyFIfs2rZXjFrDXbTUDeSgfXx
	 deurKhxpl7gAk6DDf2i5yKnrTRQ+9s3Hgo9iy9ooKhLlcJwmxNMk47/vQvpmi1j53QkD0
	 1u3+Tm6NvgGtGf2HvXNeVlFie0D3MRZwwhvZ1AITX6ijI80BDqUj4RJdRtt2KO+i9sgao
	 PWuzF/ozNKgcCKxxLdVEADfESOIMyEPNOv2MWz9na6YToeTBdmXtYBKKSmy3nhycgaVOi
	 jVywCo0H9rkphrSiwPXxUIa6yTJ/bQRbvGThpZj1koFVXcPRsicp2kFcZ0P4FZjrRGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Csj51Nj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E75606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Csj51Nj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C064F1F01825;
	Thu, 22 Oct 2026 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792699668;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Csj51Nj592hbAEXDJDq/fH5FL5gQGABxXrHOiE1rMwZKGVYHlJt5EyuzzLrlX3kDP
	 3MXzNRdTJmV0ijWnzZmvKlqt+6s4NbFPNntQZHzqco2RVAm78+kZxToxGffhxmQZDR
	 FRCpP5kxvJYQTX5pNRmkTOGcA6yFuk1hjO+20nN7VT16IcijIGhQhCraZ3dZFNCyfW
	 8TEY9wBMYuOKFckJgxMEtos8rANoM/G04S2zYVrFN2u6Od2pDcjh3pKnokqlF9hzOv
	 WXgAUEXCWKtW7kfMn8f5Nl+iNzIvZrc0zizQuNGERTCEZmY6TSF7GLTOdQkCpxK8B6
	 VZS+2/wt34qQg==
From: netdev-bot+sinfo@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 olteanv@gmail.com, johan@kernel.org, kuba@kernel.org
Subject: 
 Re: [PATCH net 1/2] net: dsa: mxl862xx: bound FDB dump walk by table capacity
Date: Thu, 22 Oct 2026 20:07:47 +0000
Message-ID: <179269966728.3290.2627206928544645649@kernel.org>
In-Reply-To: <tencent_A56873DA4A296F5D794B6A5989A180A21C05@qq.com>
References: <20261022200434.80182-1-memoriaru@foxmail.com>
 <tencent_A56873DA4A296F5D794B6A5989A180A21C05@qq.com>
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

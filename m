Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165409;
	b=QEqXlP0FbvpO6n97jjW+0kxH/IUxXTAQkCQRQJz/gnDTnJxqzjmpXm6tXN9QpBR13PDD
	 xUfPyjQjO2WQwlCopBQomBD4pLJgB0bpj0YPBSZB2WBPv7zcFH3K5ysdy55qpXhVSoetx
	 9wVHIUDZ67vieVA5XED05Vs7TdLiMUlQBNAEpADMNVE8Eg0d7vPDICJMb6SZZ6adNJXTB
	 0YWGan752sThI8+snjI2aMoqhnztjsFdHq8z6eKRH+N45enmuh0nbfCr3rfPD+LgDx8j+
	 5UlSKRzKKnyWXlr9k5cSv2NXcmAnjte6Uo9bjDEZAzhikwabncAqfk1MOFwXJJp832w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=RU0VW8puxko1VgPUXuZDHjicgX85Ou/sztsF0NyqWMe5gQ97KPFnxEM4GIhhKAkN9Qhn
	 nUjLYC4uKp7vReOds9I2BLYp4JpWkK/PIqMywK8jbMod0V6tGHvl5PWcHsIEbGnc/a76C
	 3aKdxp9yvtRUKKT6aM6V1+eVRxyN8fFNznhjtB/1yYvZleAUI20Qy87V/nWPyup+GvrCU
	 BFzG/2fC249s+eHIn2sv1AltieyFhDAQw+FBH9wu64fCHd1J62yJZelYFMWtXFkSm1s+6
	 Y7Sf3pRIC2iWv08vWGiBt0rmTQM9Yt8lAPA/T6VaGSV0dwhkROaIWQsBzoIVfL6R50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEGtXwVg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACA606A31C;
	Sun,  8 Nov 2026 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEGtXwVg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1651F0089F;
	Sun,  8 Nov 2026 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165408;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEGtXwVg5cj2Dfz0QfESHU3AAZmsbnE5nnxPy82r+VzItvHKR0YtDC9n97TuavStY
	 kOZHHzVJD/XbVgvNpWDaK0mJPdBQS1Qtf6nHTMz+0EYzrSy7mzVDnC1qrjik/fs0S7
	 LAjytQDcvhrnPei28FhoyiQYgqTj5OKOpHBZMSxB4Cr4+3Nee5ikZ+4HdcZoEVIcYe
	 4M/APL4RndAf5sUaaquiZIGsavQ1ptV4MwMAkaunIr8vfGJlQnm8PiTfu0X3bmMN/5
	 NlzGq9Wm7H8Uji5C0DRMkDyVLf3GRzheUMtR1N7dhD8qtRGsG6JGnl1aYV1TCL+vF5
	 /PrSFwkpuXDyA==
From: netdev-bot+sinfo@kernel.org
To: Ofri Zangi <ofriz@xsightlabs.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vakul Garg <vakul.garg@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guy Tzalik <guyt@xsightlabs.com>
Subject: Re: [PATCH net] tls: fix async encryption race on weakly ordered
 architectures
Date: Sun, 08 Nov 2026 19:16:47 +0000
Message-ID: <179416540733.488859.2191045262399137766@kernel.org>
In-Reply-To: <20261108-tls-async-tx-ordering-v1-1-f9a1844ca88e@xsightlabs.com>
References: <20261108-tls-async-tx-ordering-v1-1-f9a1844ca88e@xsightlabs.com>
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

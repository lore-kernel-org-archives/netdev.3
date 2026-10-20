Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532951;
	b=Q70H/K6YLRYXJi8OsCyY28wyJwb+/Jcv2QqFlMa7/UonL+xUQzD43fJD39KDXE3/S3dN
	 7lITxXFT7YjeI6Loi48CkYuyPRKwV7BlWYJFewakKgOb8yBhx5KX1YxBCYSOecQXgY9ov
	 kEOUSgh06AdUc+zhUePBUmwzv5MkFI5Jj7gw//lSqjzd7yL18RbbajalTiWY6HlehhL5c
	 pRfuYSPhGoPUk2pWwR6FEnUZieXbpP4TS1pS/QvtkKMzkKwdPwmqDRi9KkuBGXucBCNyb
	 XAeW/+S4GwBgW/lDUrtm//PnnjbQfXd0JTZWQTmH1p+f+OupQEbSVz6Ahg+gNAdIbAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=3ptrElvTYQVveSEHizjM94318C/Y/YzS5uckJdy1l9eYjomjPWY7jAXylMmaLSPX6o2H
	 lCA10tKfMmpUqF1PXRT3Cj4E+3RcVORVTfI2jdO7EMbbrZYGSTuH+Ycor+YAL8svz0y9+
	 /8w6f9HiraIxQI8QlpkKtwh1cIUKM4ytr03k12tLnIvSMahi26aHEt5LKvmwGts+DbeHD
	 dBJJPs9a4QXFCVvKWYKot1wG7orP2nXlo63VE6rsKeozLSzz04XptRabpU7Y2yw5LiUAb
	 3NUGndUXPweTGzaFO8xppp93RVmsVCZHKV9Pn3tiqK7yawB4HOHyLXRpBWGL7/BvUjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQECKffF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFE606A319;
	Tue, 20 Oct 2026 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQECKffF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84F1F000C9;
	Tue, 20 Oct 2026 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792532950;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQECKffFdEi7NpLzZzIy/04o3wWLLGCNd5D+UkajbJz4uPWtcDEjyRTUjHUymaOup
	 aZzHutBtyHS4UUt76js9ZR/qQuBO7HOdq1aPrOPCXDt39paHobQAlVfZ+lWFkFUVy5
	 RYdnHQrTKAe3mPNARjQHx9eaSSczSfqHPsrPJSXnzgHqCCMyZj2e5jG/vKBuIIJKcv
	 rY4ElqVfSdY9UdJFcejNX13xsq8A6wObBIHe+XdMd7ku3DTZAY/COU0LBoI5cL8P69
	 Vtxye0fuOH1eNmE4VnK8YOdV7QAOhpMEvzVDtGlUCp34D8cIHnjVCjyu8dvq9/FS4A
	 xZ546GeiX9wzA==
From: netdev-bot+sinfo@kernel.org
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Boris Pismenny <borisp@mellanox.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] tls: keep TX and RX hardware offload on the same device
Date: Tue, 20 Oct 2026 21:49:08 +0000
Message-ID: <179253294887.3290.487147499123330924@kernel.org>
In-Reply-To: <20261020214500.972308-1-rjethwani@purestorage.com>
References: <20261020214500.972308-1-rjethwani@purestorage.com>
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

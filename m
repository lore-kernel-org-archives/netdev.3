Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107330;
	b=ct+LW6BBkaiQRNNaHhCB0VkKYUpBGYEHBm3iPe6rkEu7qr+pQ9gtmDVFSo9c3ZltahFV
	 iCsGukudNWTM6vxdZZf5HnXTVQlCHu64i0DrUf9lhv4nEjukIDSH4CRy1hFICKBLGK8E3
	 QQtdkWyP6L++Ny1+ELjCnXvNvfn34XZbxem1YqPd7EPwEB+iGJN2WPHskUKFu3+cfzonr
	 eBCRLm0rcJ87B2BxpT722Y0n2kiLe+GIMWjo1PiZingV8jj9z4E8Jjrtpx3V5YxmA4oRp
	 S1dqdvQ5yYUGk3B7AsjauS6WyEpFFa6vRWDIL8PmCVZfGi6UgUWXrZRJxQhQxDWhaVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107330;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=gmx34mrj9vRY2xj+MbHSF7EGyplCSGdY3jG5rquAjsx50XppYjnSC4+qRWBjDOm9R0f8
	 HxKa7L2Bv6yz8UrZjsPinQ1cU39uWucKHXFCWvCn9VWCMQFdCDLOM7ObjQVN7HXwL67Us
	 pZFYO6tJfu+U6D2ZBYURCt4/+DZp45J0+MBMciWipa/JG0QxKMoQDO9cs2dP970luGboj
	 ftcA5sFUOLlRzWOZNEda4wRXUGHoGCTZxobsb9rJ9Hk0PXyT2T+OCXXYFK3HezmZFl2FZ
	 nUcszjmsTTsfBQ2DyKS9P3xiGNH9pVpuHlD0ufy8mUJq+twcMur59Z6ctMA/mCcpJkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvYtp0N5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE670606A31A;
	Tue, 27 Oct 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvYtp0N5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AF71F01825;
	Tue, 27 Oct 2026 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793107329;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvYtp0N5JHXgaDWI+G+zdVt/oggEZWpBYPUXKXGOhjpQSzp0YUuHTDhDDu5pgDVHe
	 2UB3qU1XthAtPNf6Sh7SYD5Nzgv5tXH0iOPO4nVOj1KjKbuFtyZ29m35/diwzlH2UT
	 6NurtcmD8qVEh+VJfXoLGODJR7y0f9iAgYXRZfKgYYYc2tSQXVCgdUtLWsaE4kzsXd
	 URTCr39/xmvMVAteEcZRJHt+e+tYRqvk/nYkntgINZJrHzFk+Ryf4zaXlukMuT2bum
	 gBsg/cUx7Lp3XqxdxW/h8qQ9Bo7mk1mi2/iixnlg1ziDV0Gf4mbaY0IkXdQV/7lOQ6
	 UUIm/bJU1oQVA==
From: netdev-bot+sinfo@kernel.org
To: Meghana Malladi <m-malladi@ti.com>
Cc: haokexin@gmail.com, jacob.e.keller@intel.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
Subject: 
 Re: [PATCH net v2 0/2] Fix switch mode for offload and non-offload cases
Date: Tue, 27 Oct 2026 13:22:07 +0000
Message-ID: <179310732792.3327.10198783590651043272@kernel.org>
In-Reply-To: <20261027131732.3411403-1-m-malladi@ti.com>
References: <20261027131732.3411403-1-m-malladi@ti.com>
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

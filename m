Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420632FA3C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934616; cv=none; b=nIFS5psIYAoInpzPyqiHUg/cyS3FPny2zhIKyFjrBzmU6B97ZsAwHj5MzIY6MprfmYAI6SRy/g8wXTNb0E8pM68VA5vhXy9jdTcoJiGMr56CALMeNIQzgBfAfaVq/NQnEcAi+8pMIv1dbAYpqlwC8XXBLdfxkPK8/6fXxAfZ3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934616; c=relaxed/simple;
	bh=oAUFrV7Dcmzu+Gtgt2bMcwfnBbwk5+eFMBwXtUsRYBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKFB6KZ8LFju0dSIr3Sr8ptMbGtVeZ7v9eMtseNKOlna2ejkV6V4iv9sCrLJY23mxZTEHTvouGmbnI2p36QlXcMfFzJjtRsjkL/O+w0kLeyREeR0HU6V1/shs/OcC7GWEk13HaGarM+rZW22d1fU1w7QzbHa+LOi0PHoyU2Nl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi/WSke0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi/WSke0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995381F00893;
	Mon,  8 Jun 2026 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934615;
	bh=bTFwLlP9Xda5SAvgZ1W/YNCfrYnOgGpX1iJxi+v1uJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xi/WSke0bT7EQ8BFzZx80hHvV4g+lTsFkERPCp9PRpM67t99R1KGFKkmaEbHYUiet
	 v8bOqqjIaz/SC9hJBLneob8UGUAg7SbRw+CZlhEw7GNlAMDM94e4sV0ZsOXvrIA9sE
	 yZRdHOvNUmnDd1aTE6ZHwovN9mRxp0AjWkLLAxf2iZ/l0174+tvLIY2+Yvohu2sKjK
	 juDxylZMmeo+NiQDFKKOwasXWswfLFpcx/OMSpJoxuni97QDMnedQDeuNuXrA4sSEC
	 5CpcLMfrwdh8xSvkJ5q41m1uy4OLpE8YatI7QLCHbXWwhLTj/6J1AuJXIDzTxShiQN
	 hVWCut513PBAA==
Date: Mon, 8 Jun 2026 09:03:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH 1/3 net-next v5] ipv4: centralize devconf sysctl
 handling
Message-ID: <20260608090333.21c94721@kernel.org>
In-Reply-To: <20260607110123.5939-1-fmancera@suse.de>
References: <20260607110123.5939-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 13:01:21 +0200 Fernando Fernandez Mancera wrote:
> The logic for handling IPv4 devconf sysctls is scattered. Notification
> and cache flushes are managed in devinet_conf_proc(), while a separate
> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
> is used for properties that solely require a cache flush.

Hi Fernando!

Do you have the necessary iproute2 patches pushed out somewhere?
I'll pull them in the CI to make sure the test works.

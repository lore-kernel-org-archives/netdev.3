Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F519343E;
	Thu, 21 May 2026 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328174; cv=none; b=TESa5SGcvVkBmG6jdNF5OQA9MZcoZ6017UgWLWSWjFP7g4SdC6xYK2ZE8m+ppe+KwksWQ6HQqMFzJVgxZyg8DX787v8Iph2fku2l77Uz0QxMQlKGgryAKjdlIbzzK7J+QkRCNDOFKxTjzFaHWoq/cwXTOT66ASF5a/ZS/620FTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328174; c=relaxed/simple;
	bh=x8ctS9Asmc1d4lCUZfDZRdOKVGoWuPhzFcm2wXMwB7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzI+xLpM3KLZD+BU9Zstx7TvzVURMTSOrhc59RVByjHnvGhxkLoF0ZDBD31oKmfGi1qSTMSXHKDBXrVYiv+LiMmN5kKTtfTq7RgpZv6bDdStdmzOKOsKUFa1PD1qfGskMFNqj3eDPBO875X78qUJqItWdlM87SZbDavwUHKwzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZigaY8Qs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZigaY8Qs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C571F00A3B;
	Thu, 21 May 2026 01:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328164;
	bh=OD6GWrf7FT7kC8TzxXWlYbBvQrCafhf6Fikr8Zg5Gnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZigaY8QsHNPPSCOOcz+Q0guFXGG4WB8O+utL0iqan3GoeRiB1NykSMYm06bkOLHvW
	 AWC1LpBVy4oSCEayJ8hO6pMpJLppvQhpvCCSU86VLy4KSrZ/vLZIYomX1qeZJNm6Gx
	 wrmzcKrX0CZVmO0uJtLp43r8hANbgJHccCz/zNKZq8FZFZL+5w/NIPinhDOtVkIfFF
	 LM/WjSUOqcJnsBqoXrI/gbig4ZpS1tOSQ7MLYSX3tMfCpKVjFKe24qM8tGafqeTuKP
	 3jA3Ucafvt4tFDCIkVSa++ay/LBwEmCSnyeX82ZeS1mcYFqK4qOjrqUyVHiBiIQCVs
	 wchCTtNmrdpPQ==
Date: Wed, 20 May 2026 18:49:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Pavan Kumar Linga
 <madhu.chittim@intel.com>, larysa.zaremba@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 sridhar.samudrala@intel.com, anjali.singhai@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com,
 jiri@resnulli.us, horms@kernel.org, corbet@lwn.net,
 richardcochran@gmail.com, linux-doc@vger.kernel.org, Bharath R
 <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v3 03/14] libeth: allow to create fill queues
 without NAPI
Message-ID: <20260520184922.34c36c74@kernel.org>
In-Reply-To: <20260515224443.2772147-4-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
	<20260515224443.2772147-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 15:44:27 -0700 Tony Nguyen wrote:
> +int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev)

Why do you have to pass an opaque void pointer?
Just add another arg for dev.

 int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi,
			 struct device *dev)
 {
 	struct page_pool_params pp = {
 		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order		= LIBETH_RX_PAGE_ORDER,
 		.pool_size	= fq->count,
 		.nid		= fq->nid,
-		.dev		= napi->dev->dev.parent,
-		.netdev		= napi->dev,
+		.dev		= dev ? dev : napi->dev->dev.parent,
+		.netdev		= napi ? napi->dev : NULL,

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151C23BCE3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830747; cv=none; b=kFMGAILqpTuYb6to304QZ+Vfam69rKWt7r3T2Y25hBrG9HqmuBiBN4vjuBlvQh1UfNerljinZqEqj6US4pR8qtO0xczpehcZBdkzsltEiJKUlXxB5qtJSJyIVvMOxiwQJriWv2sA525khumXmQDGhmZyR9uKYOhGMJQ+xjX1hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830747; c=relaxed/simple;
	bh=Rjd+V97MCbLCcsgQyw06CwHPqH7WvB5NMS2aRmiXJUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGeXat6JZXq9qG40CPRtX+DYmqyftk3dS58j2hV9h15hJlOfePz7SyAyHu90VVemIN5sP/O4L26/LrI3dSMQmaQAcpVbQiDZp+dSdM/pefIDzl6NN8N+Eg8XnnlVq+4VTZvp0XhrfW9+E0cFzNrm3z9WDCmVY2HJocezRUxHb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG0uX/Jb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG0uX/Jb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904B51F000E9;
	Fri, 19 Jun 2026 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830745;
	bh=9hWlDqf2WyRdwxHrN6yAbJlUjDaNZ1F+xSraQBqQXf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NG0uX/JblLyIWMXuMDOsrxkoPdxEYSo5/djD7aDhrFR6hJ4CCYGJmFJTLg7gl7NCy
	 sYyrPUnCceiTFE3+hgpPt9+/W8G/cyn2FUjiN69GqGS3S0ZimYRBAfzQ6pgNVzazvR
	 gC6bwZRtVuGPi/rUn95FEyJTjRUHEb+/EJaQtjP8OXjlgYfCudbYKw6YWnHp1K6U6z
	 5inTXTrKNEDtB4HQfS0bfbfgRI2/QXW/nYKp3yjAxtz16669i1fYaWUjHnTt46OvhY
	 ps+b66Kjv6hLl+E4zViSGGWIZmR0HEKSQp2ibV0Tetwh1MShNVDr+XvVES469kH1U4
	 E8Zh43mxMU82Q==
Date: Thu, 18 Jun 2026 17:59:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [net v2] net/sched: fix partial tx_queue_len change rollback
Message-ID: <20260618175904.4833cea7@kernel.org>
In-Reply-To: <20260615031824.314112-1-zhaochenguang@kylinos.cn>
References: <20260615031824.314112-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 11:18:24 +0800 Chenguang Zhao wrote:
> When dev_qdisc_change_tx_queue_len() fails partway through updating
> per-tx-queue qdiscs, previously updated queues were left at the new
> size while netif_change_tx_queue_len() only restored dev->tx_queue_len.
> 
> Pass the original queue length and roll back successfully updated
> queues on failure.

I don't think it matters. Also net-next is closed.
-- 
pw-bot: reject

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02141D21D
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814169; cv=none; b=SWJ3lYFmo0hOn2uxutDI/IiloKaOU5AieeZvWU6mi3PYuJvLYE4LqRwaqMdJbzDZTiZscusSXL8en+oOjXHAveov5P6TURv5R0z25/ayw84x9G4XtzjtbLs2deAep4gt94vvKOJobgQwDTQn7dlHNTlVsG6Gr1R/kLdCqlLtQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814169; c=relaxed/simple;
	bh=aRb9lpq0XymqJdBsQ2VOB/8oDXbMd0zC0tMopgh1k1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HD0Q2/bfZUlNae+ZVMoe4xY59bbxXlNgP4cHA5Ux1L0cpC/Nj+cf646V/JlC3wDOpkNVqhu6C9tQLO6xDP/sE/GhH7mYosetcvt6HzOZo4cVe+d7fNXNm1hNUnPdpyX0WAAseHOe8quw7yjlF8QPZsnUdVZnpvE43779yngVEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A161F000E9;
	Thu, 23 Jul 2026 13:42:43 +0000 (UTC)
Date: Thu, 23 Jul 2026 06:42:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: bh74.an@samsung.com
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net v3 0/2] net: sxgbe: fix descriptor ring allocation
 failure handling
Message-ID: <20260723064242.58d58526@kernel.org>
In-Reply-To: <20260723021820.203960-1-chenguang.zhao@linux.dev>
References: <20260723021820.203960-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 10:18:18 +0800 Chenguang Zhao wrote:
> init_dma_desc_rings() leaks already-allocated TX rings
> when RX allocation fails, and sxgbe_open() ignores its
> return value and continues with invalid DMA rings. Fix
> the cleanup path and check the error.

Byungho An, please review.

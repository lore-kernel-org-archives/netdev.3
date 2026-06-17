Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2D280A58
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781740024; cv=none; b=KFpC7YdYMdzOb20BJIFqg8/VQEIc8zQkrJtq95knGQ3Mh8EOO6mmW/sDuRP8FYJ45Rfy3nNUDfp0Oqj0tfn4P9SQMJwcF6c0JWUnu7/TdCVL4+nhCBmAO6aH33rWoKfMBCyahynI9DMIhlTBmWA2N7sLDwvdmDV0UP/HxfC+xRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781740024; c=relaxed/simple;
	bh=VH93vblaMqJ/K3v1N+MnPdIOelYOWuuCAwyhN+JixFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WItnB7HP9VgXehC6QHim3OLTFhZVffhb44kcn9U6/Ph+dQHr6GdZD70eWpQwuk/ckU7cmPbfuRr7GjMHtQPZxcmW97+I2FEhR41DQdPG+OwMPIr9RlnFfOVcerULaZRq/tPZaovZ8w8mkK5wm8uBKwNKrp5nD5t6xoBJUtao5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGC3JDnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGC3JDnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297901F000E9;
	Wed, 17 Jun 2026 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781740022;
	bh=dNfGF+DW/UJTT4QcLtQQaDo5D+dHZFYxNiVjjXI4rcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gGC3JDnh1OaY7JJ3rrvmUUmVAoqVOfLS448ILuwjE1BVMhprCeyP3ued0ZFByPet9
	 y5ZwRt0j+8wTfWYmoAE5n+nZonqz8Hs8qER2NvyEbAaIcFizKR9jfmODlnVScAG/gG
	 kNGqMs4q3Ttqi8eSSZfF2tJNfE6IxP7J//ACFRcMTEg+2XkFtzbwNBv6mhhxRpvaon
	 A/bL0wL72vk+TP5ibYUHAp3c8b5jlEG/G+ysnUeuAKerVHk7Wo+E41f9hZ0ZcbEIc8
	 W7rrgRTHD0XxxpPXR35kby6Qi1ZCxrCMDgKDneL+pqqEvPCPczUX84AX2W/Qe0QrC1
	 MSa3XRoFHzJSw==
Date: Wed, 17 Jun 2026 16:47:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lei Zhu <zhulei_szu@163.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ionic: Change list definition method
Message-ID: <20260617164701.3276216d@kernel.org>
In-Reply-To: <20260617023243.61595-1-zhulei_szu@163.com>
References: <20260617023243.61595-1-zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 10:32:43 +0800 Lei Zhu wrote:
> The LIST_HEAD macro can both define a linked list and initialize
> it in one step. To simplify code, we replace the separate operations
> of linked list definition and manual initialization with the LIST_HEAD
> macro.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

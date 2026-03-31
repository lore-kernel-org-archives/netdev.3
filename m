Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9D20B810
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922722; cv=none; b=kYfUb0T36LiXnJygGbMTDUzEgAyY24NCVK4AYCIDBuMOweUwnAapTwJOsqBQJHRXJ5V9jLFEAEXGr294W5t95azC1YJORgXAPIO2AsZ5zn0sQprvmPDqp04WGEGh2XA8gVz5gY/JAX1kvzcHJYpuZkQJfshlAmH+D3RzHy5uWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922722; c=relaxed/simple;
	bh=3VUo7hidnWbhKnZlfxzV8rYkT77hLlyjr3jQs8W9obk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNl1FTp5PQi3gvtzQEAt9OySDJiTzpEE7HkIHBg+hSNrvKDQWrUES/OXFtojJDKnHVCRWyO00LVmwOkDV9+mATp39k2vmvD6f/+tYO9d032qiO6a+ESFl8v3ikbMYZfgoqXg7BjN1VXoaYouwZhvfl8a1pct1ZTZSPMRSqCEMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/Qmf6NO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/Qmf6NO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBCDC4CEF7;
	Tue, 31 Mar 2026 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922721;
	bh=3VUo7hidnWbhKnZlfxzV8rYkT77hLlyjr3jQs8W9obk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/Qmf6NOGhoohkreJkfzxJtbROcS9aSStjaVhP9ugv2VERlnfjL5TCOOMF/5ajToI
	 dxE+FkRC0f3oQkw2eCNAPVJoxF8jJOe/sp0HboRwVm/Yw6qbAx+cj4gwNMxUdri5iP
	 63uHH7qG5YOQPBt9PCqAoHIgZqIVAniLYtRslwGPUd2dQwlJ2K4Ws1D5dWqBEuK7+R
	 WXJ2tNquewMYIbuNIS7PjxigIwaWNnFUOytAyVftY1W1ZZ/k3TwE9PBb0vw9dMmMYg
	 ETxRj+02ge/x+C0kMuiqDY11BgE4jJ+SjeHcBl38uqHdZmYc5hXHI8KetnYxKA7ovN
	 jRDIBTrumce8A==
Date: Mon, 30 Mar 2026 19:05:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net 2/3] bnxt_en: Don't assume XDP is never enabled in
 bnxt_init_dflt_ring_mode()
Message-ID: <20260330190520.13fa773f@kernel.org>
In-Reply-To: <20260329232528.870637-3-michael.chan@broadcom.com>
References: <20260329232528.870637-1-michael.chan@broadcom.com>
	<20260329232528.870637-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Mar 2026 16:25:27 -0700 Michael Chan wrote:
> Fixes: 93550a9c7939 ("bnxt_en: implement devlink dev reload driver_reinit")

Fixes tag: Fixes: 93550a9c7939 ("bnxt_en: implement devlink dev reload driver_reinit")
Has these problem(s):
	- Target SHA1 does not exist
-- 
pw-bot: cr

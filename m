Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1604314B73
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435293; cv=none; b=jOqQ+MwMsABORA2QN0Z3D4Qkh3Kb8WONlwuqectFbpF6Nj53s1Gp2Y2RF5bQAMAu97pvqNgCsTMmXFAHqS30uKZUtwFsMSNTX+IyrVdBNjR34+yYoCT+2P8Du9S0UC36AM7IHgUU/AwFeAOhK2qDRWcHTlrHXP4wc4PuPywhOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435293; c=relaxed/simple;
	bh=2ePUoyQdu5xq1IVgOV7LYUnpKW09dFKRx9lGkb0Y9a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSD2VDxmI2SJfcJmLtqNjB7GVDyrk3802E7t8y9q/hYPz+SxOv27/sH47rwMCPFGjwlTja2DmC3Ekt3PDQk0mxX9JzKSAhOSHA9e1zR0Eddh+s6lHhoMNgeQItTcZih4D3MUHSL4MUWotc31elZ7WYYXjXr8J9G3J7pqOQHui0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeU8GdVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeU8GdVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503361F000E9;
	Fri, 22 May 2026 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779435292;
	bh=GwSFI1KrtXMkVoVeQc9kuIvjDERJU5MFhk8YH6brL/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NeU8GdVh9bsQ6V43UeH/iPlBm8ZuakikpYaXAjGVHH4QjUPNYWj4dyIEb4fpHdSFx
	 M8//EB6nAuPwAQyRGgZV53PYakYxeHSfAR67gOLsCPoQ3pjh15l0KjzghFxg0y5Hs7
	 ZaTqnPGZZq7x7A//g4jCgScclTOcdd7H3M2Ic57WQBIrAY5yAW52YK8Am5+K1LiSWX
	 DngLCVIY34S7KGdgl4a8hLk/HmF9Gs2G/NyNbp9W54tkCNsb1ti6t2RR/zzaeb2h/7
	 qODUzU7hjwnrpxie3dkJGi4nerdXuYsTpu7zdUwwVLqLP2qDGvXy9I6f2Vud9i9RcC
	 yqiqsrTs9yA7Q==
From: Simon Horman <horms@kernel.org>
To: jiawenwu@trustnetic.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v1 1/3] net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
Date: Fri, 22 May 2026 08:34:15 +0100
Message-ID: <20260522073415.2032087-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519080048.7448-2-jiawenwu@trustnetic.com>
References: <20260519080048.7448-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state

Replace various netif_running() checks with an explicit WX_STATE_DOWN
state bit to track whether the device datapath and interrupt handling
are operational.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 746623fa59b40..69fe197376796 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
[ ... ]
> @@ -3314,7 +3316,8 @@ EXPORT_SYMBOL(wx_set_ring);
>  
>  void wx_service_event_schedule(struct wx *wx)
>  {
> -	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
> +	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state) &&
> +	    !test_bit(WX_STATE_DOWN, wx->state))
>  		queue_work(system_power_efficient_wq, &wx->service_task);
>  }

Can this leak the WX_STATE_SERVICE_SCHED bit when the device is down?

If WX_STATE_DOWN is set, test_and_set_bit() executes first and sets
WX_STATE_SERVICE_SCHED, but the second condition evaluates to false.
This skips queue_work(), meaning the service task is never queued.

Because the task does not execute, WX_STATE_SERVICE_SCHED is never cleared.
When the device is brought back up, subsequent calls to
wx_service_event_schedule() might always fail the test_and_set_bit() check,
permanently disabling the service task.

Should the conditions be reversed to check WX_STATE_DOWN before setting the
service schedule bit?

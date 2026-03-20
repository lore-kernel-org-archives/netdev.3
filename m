Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24D2E92BA
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992152; cv=none; b=FcoqFAwhNrZ9oNhv5yzadmvP7zwqSeN3nwlhx+gd5an8gBtYt48ylmIxwMrfNhQneFGdmJqfusisW1T3Vq/XrU7x3lt5VTwCQ/BA5hMYVk1/kHMTkRdHmM3bVr/pqmENFJXN485ylc68AUEjXwa7i4f2SmVxlrUnTM4EBj4nEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992152; c=relaxed/simple;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsac0EzeDcdpbKzK2odg9NeNFUIY6AorcWXtN5ff2Q/xM27pDnBCTQbYibsLgyDQlMNXRPuzFgr/bgB57NGLZ+/pc6lecUz+CdewtTa3GRePC6WKztH2r3HGYfW+y2S7boHaG2W9SY7i/SxrnBF/oneC2mDK8mwQAu3bvZd4K7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8iAz9sM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qgNGs6Co; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8iAz9sM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qgNGs6Co"
Date: Fri, 20 Mar 2026 08:35:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773992149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	b=y8iAz9sMFwZkvlKFSdTHirwcWs3fvhGdg5WOKx0k0FboglbYAI2uVBDTeJ4HudeZaucFbS
	mEubXpZlkuLgCARmp1E9jHuSo5VDW9abwOyuhJKAeFYc+ss8Owc8b5RBpfPoTFD3Yphu34
	iG7fSXsV5KHDfhH6reFd0CZqFR8vjDX/TyBs8LpLIkCuRxHgi2TC7w6bVkIdT0zZDQraeC
	ilA++MWsRDx0V/p9ZibE+vCz04512ddMJgdYhIL5rTOu/V7spGMG0b7KbC1J03GEd0g7T5
	D3rlgWe9B6PyAiIYJ6l0MQATSM5NCQoGQsVKXtvlj8lHsMDLUH/ZGpA3alXPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773992149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PeuPaUAxF6wPEe48zv31ASlM/mVrvhkQC0Ge3mlRlI=;
	b=qgNGs6CoO3SkzuiELhVxh1HMQGJLy4PnEV508XLHDphAOGU1JvTy8pDdYgOhJ3QcpHnm4l
	vPwlXd6i/0uW63BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com
Subject: Re: [PATCH iwl-net v2 0/3] idpf: virtchnl locking and async fixes
Message-ID: <20260320073547.yqDmYQ49@linutronix.de>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319211335.23236-1-emil.s.tantilov@intel.com>

On 2026-03-19 14:13:32 [-0700], Emil Tantilov wrote:
> The main change in this series is the introduction of local spinlock_t
> which replaces the previous use of completion's raw spinlock. This allows
> us to make consistent use of the xn_bm_lock when accessing the free_xn_bm
> bitmap, while also avoiding nested raw/bh spinlock issue on PREEMPT_RT
> kernels. Additionally, we ensure that the payload size is set before
> invoking the async handler, to make sure it doesn't error out prematurely
> due to invalid size check.

Nice.
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

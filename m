Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C738F941
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058877; cv=none; b=W++Jlml9sXRWWj35CwQT4vQ0OtDhNvgiaQSisrirX+HTzsw45nYTDVe5hrbNHxFltSF6aARt2u90BBdse3h+bNXggwLoZw+kX+nuAs0jn4P5sFfAar5BDYWQ12UFCqn22w7iTXDkhgmT5GGN570Ll6VdTHwHMPXblNMXhB8Z9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058877; c=relaxed/simple;
	bh=oArezgWyFhis7h+D95RiEJFKqQoyNxZhTG6d2v5vWaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbz+FF7d3qkdpqz10SgFgUMHkEqittyWjmmFSrfKvafaKtkl4tJ1dPdWHRz/ee+u8Ka8pDv2rTOkNFoQHOhfCpzKGetBClERfgm9Aub3cKd+XlHaV5Men6c7QjPybDz6J2hAsFXgdgBOK8E2abTSQjTH2t3F68BkImzS13KpFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JFcauEAa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JFcauEAa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lJwbGZzNOM8RlX8jtr1xDwGi2Qs+1RFxXDbyzBIYNcs=; b=JFcauEAaFi7n3RWHYrErK+GXSA
	mYUvXYLKsBQBuXb+VvsPwKSXz2aY824DhokFrOSYyyl06p/OBgHfYcV4YH0t5UbDIPlPuIWt9qjpk
	1fGt5RbWOEVBi3eB7jvMpuZ3rqVqXXE9UN63S5CChLt3FIK48V4EpBLh5TS4PxYfuxpryGQ3nrSZs
	OeghyFe124CtQiUY1VA1O9FLUjZojKrc+THRCipwh+mYgQCPszci1hmzR6qm6TmQkhu+jRpCa67oq
	R6sJdvgiz81+233vWdQ1zk4Ci3s9srGaCl3PB9q5mvdBoGhZWZ3F19nhrn9CRMJ397vKC2F9Xv0Py
	9ARe7y4g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzZbc-002DIi-SK; Mon, 09 Mar 2026 12:21:05 +0000
Date: Mon, 9 Mar 2026 05:21:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, john.ogness@linutronix.de, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: Fix compiler warnings when
 PRINTK_EXECUTION_CTX is disabled
Message-ID: <aa66vrLUgShSapoP@gmail.com>
References: <20260309121233.135231-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309121233.135231-1-chelsyratnawat2001@gmail.com>
X-Debian-User: leitao

Hello Chelsy,

On Mon, Mar 09, 2026 at 05:12:33AM -0700, Chelsy Ratnawat wrote:
> The netconsole change that started using nbcon_write_context for CPU
> and task information assumes CONFIG_PRINTK_EXECUTION_CTX is enabled.

in fact, NETCONSOLE_DYNAMIC selects CONFIG_PRINTK_EXECUTION_CTX. In
other words, were you able to get NETCONSOLE_DYNAMIC without having
CONFIG_PRINTK_EXECUTION_CTX set?

> However, when this option is disabled, struct nbcon_write_context does
> not contain the cpu and comm fields, causing compilation failures:
> 
>   error: 'struct nbcon_write_context' has no member named 'cpu'
>   error: 'struct nbcon_write_context' has no member named 'comm'
> 
> Guard access to these fields and fall back to raw_smp_processor_id()
> and current->comm when PRINTK_EXECUTION_CTX is disabled.

Please don't do it. We want to disable NETCONSOLE_DYNAMIC to be enabled
(thus, not using ->cpu and ->comm) if CONFIG_PRINTK_EXECUTION_CTX is not
set.

Thanks for the report,
--breno

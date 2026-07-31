Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82961C28E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541449; cv=none; b=CIiAQkRxeGtmFNGZWQlaAuREJP0gXKQoVpC+TNPP/0zPZQ+nUPvZQ86fKtlUjg5pY0iA4vTCaKV3Qaz6WhSokOkgzy2X97clrmSp+oF9/OCcYFRQ/wCrxfU+A6HVnLpkg23KyPKZrFOs6J9VfyAk/7JZNd+/oF7MfleeTJJJLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541449; c=relaxed/simple;
	bh=H+1vVSMb+7p1IXf3HHteCMYkYbXE7D2+H2KFUFvld5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlPEqu3aMYnz5vPSq2nt6TQcKK2wtDOyUoPvx8rEHYWRA3R/BRCC9zpnGgY/mBXaIsvVIT+8pqhTJEMtJNHyXLyJouscNg3TG8KiyYAZcql0hZV/xKdSnY9HmlZX/X/Yl1rDt6ZzFaIfKKL+JBX+bTEQCzPFzMnB3dzIZ2Zsox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkViP6Dz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkViP6Dz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC781F00AC4;
	Fri, 31 Jul 2026 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541448;
	bh=H+1vVSMb+7p1IXf3HHteCMYkYbXE7D2+H2KFUFvld5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gkViP6DzcUlzFp70muUyvMV2Qq7WFVQylLtVpmlqA1Eg2L8lMsNPjV4lgMQ2F7G9z
	 zA6FeSSwvOA6Y46Q5zAmViMzJYfmsR4UAHMBaxQZRBMZxGOhUuAL+p8lgg6Lsb5aOk
	 Yn7ZRfeVbdKataGc6YP8Wxi9TcLEAmJhxgz06pfLwlQJdKuNgWyUckLjL5PHzNdUuE
	 W6UqUjOPNVyDLRP4YtuqaB9gBQ4AzwD37YVmeEqn7tkoaY+DoKEqOWxXbhYt4JVVfA
	 cvrYk8tnklB0aXqK8TnmSN9RoSxinnI5x0Mui4u8vrdm5UjTdvQSERnWobw/mvN6z4
	 HU56P7hMydvqA==
Date: Fri, 31 Jul 2026 16:44:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 0/5] net: wangxun: improve statistics support
Message-ID: <20260731164407.4ca13f14@kernel.org>
In-Reply-To: <20260731074958.19333-1-mengyuanlou@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 15:49:53 +0800 Mengyuan Lou wrote:
> This series improves statistics support for Wangxun drivers.
> Currently, VF drivers do not periodically refresh software statistics,
> do not expose per-queue statistics through the generic netdev statistics
> interface, and do not provide ndo_get_stats64().
> The first patch fixes the suspend/resume flow for wxvf so the service
> task and device lifecycle are handled correctly. The second patch makes
> wx_update_stats() safe for VF drivers by allowing it to cope with
> temporarily missing queue pointers during queue reconfiguration.
> Once periodic statistics updates are available, libwx can implement
> netdev_stat_ops, allowing Wangxun drivers to expose standard per-queue
> statistics through the generic netdev qstats infrastructure.

Were you able to run the qstats-related selftests against these devices?

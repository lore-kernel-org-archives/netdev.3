Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411603EDACE
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169477; cv=none; b=CZyF4kWA9X2M5sRze1/aQMrXPvuGQPlD57099AA9s0OXzk7tO3fZ7ihy/fGpMv8SRrl9DvG9H0TxURUPrFveB3lUIQbzdQx0EXM+PXSxt8zQ4xXr0Wk3wgvA4CFbwvCOGJ4QQlY+CIIYcfV7kwfhBCF1H1toDjcV0Z9X6+uCkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169477; c=relaxed/simple;
	bh=Gf+QMZ1/yY7+JHZoQhr2wmvlD0Ar6Dya65gRQEh5iyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODw7RAA7rcCQeGzoiJMj0Jv1Mp7VTHKAbeUh2bI2HEVFvxpiCRKGDmaSBPk8hYAgkGYUlD3saSomWkjujjSFsjJbYrMPk7+bTUwlbLEqlsMsZy4gKRt9ltzd1dNxLaF5bPJJT5a59YLho7bqPfMjrEGZI43lQIIgSllCFwvgFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKLH0Y8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKLH0Y8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFFFC2BCB2;
	Thu,  7 May 2026 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169476;
	bh=Gf+QMZ1/yY7+JHZoQhr2wmvlD0Ar6Dya65gRQEh5iyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKLH0Y8M2smyyDLPCsz2FVHtlyUbwZE3lgrxEpqKau5LplpI9Rvh5eQHSHoxlu8hb
	 WXW5QLm6MDG86IYhfo88rjScgIzhV7+Ztlx/9+gCvNjYpGQOPN4oTYQZ4gDP1MywMV
	 KEQv2sbmyq4khKvnBsNDIVyHQcWHSpQk+cOirXA0Iicjn1sQ36Msoix7asLbXByhuL
	 oM/zjetsjssemPE5LyU/ew/VoF5KnHg0IxL/IOR9pTXOh0g++Tga7UuRBUW8uvplYY
	 CKav8OGHzQluAwGED2bqAQTxOJL8S1bQs7zaH7BjHpk2IQzCyu+w3sUwvUHfF2fESV
	 MvbOK35rUWX8Q==
Date: Thu, 7 May 2026 08:57:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/5] ionic: Allow the first devcmd to trigger
 deferred probe
Message-ID: <20260507085755.3717cf80@kernel.org>
In-Reply-To: <20260506035706.12373-2-eric.joyner@amd.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
	<20260506035706.12373-2-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 20:57:02 -0700 Eric Joyner wrote:
> There's a chance the register signature value is set before the
> firmware is ready to respond to the driver. This doesn't mean the
> device isn't there, but just means it's not yet ready. If the first
> devcmd fails, then return -EPROBE_DEFER so the device can be probed
> at a later time. As part of this make sure the reset devcmd, which
> is the first devcmd, is not so alarming when it fails by printing
> an information message instead of the standard devcmd failure
> messages.

I don't think that's how PROBE_DEFER works / is supposed to be used.
It re-tries probe after other devices have been probed. So if your
driver is the last one "one the list" and the system is completely
stable afterwards you will never get another probe attempt.

At least that's my recollection. IOW it's for use when you have
dependencies on other components in the system. If you just need
to wait for you own device to become ready you should simply wait..

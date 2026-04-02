Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEF35A385
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099796; cv=none; b=CHkDGR1DGkXnZnXelO5Z/G7giddgAmmQcsrSue/fKpTapm60/zbIOc/M89/eQiPMobGfZCcAblCs6RW444kKvWE2ox23vhAyhr/Z0FKQHTm/t9daKRJKscoZaNbp2YxuXT7ANHDaAaC47n+yt4M10Axd2eGPMOAjWPJgzloHukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099796; c=relaxed/simple;
	bh=laNjVhkpMZB67NluoMJC1gWZz1GJnqmR8rJrROP9T1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee1PuR3wElyXcpU8OZ3loLfnXxuNo167NWY7/atXW6nn79GazG4sPKDWezuRNdBOOK0Fa8f7fVj/vMELfYPjz0qlofUNJPNtPeoc4twrX8rOz3N4Tg/uazKUBAPpX87rgx+jv28wDTURviokd1uVfMq3LdqdMzSFZmLhIsDgK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofG1iFJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofG1iFJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDBC4CEF7;
	Thu,  2 Apr 2026 03:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775099795;
	bh=laNjVhkpMZB67NluoMJC1gWZz1GJnqmR8rJrROP9T1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ofG1iFJw4BIMGgrN1lx2qwRhXJ2Su8IXk//jzl3L+kF0KgkbvJM36O5L8to27wNvi
	 avU5iZMGhs7lKrDK8qPsJPmW3C+1hg4yOD+0WeP7KOwDJ6nHXlmn6g8dIysN4pjFwz
	 lTOqD0xKFhWsK8RWhUW8hdTQJqmTWYLc/EvYww4t+PsAJ+VKXy+zHoQVwImbf+S97d
	 B71dXHTmFCJ+sg0yHp94FNkraPx8Jkrmz2/TgjvHDP3tVLZ9/5wQ0XiRIKg4OtMhZc
	 Y/AIGzo+OBkd3nKLgO90Xd5XBDdl6fKJg9WfKohr2DGv6qRZj3n3s7aUILjYYY9Cw9
	 MYZp7Yj9QWcnw==
Date: Wed, 1 Apr 2026 20:16:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH net-next v11 0/6] tls: Add TLS 1.3 hardware offload
 support
Message-ID: <20260401201634.01d70821@kernel.org>
In-Reply-To: <20260331155859.1f34ef38@kernel.org>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
	<20260331155859.1f34ef38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Mar 2026 15:58:59 -0700 Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 10:37:51 -0600 Rishikesh Jethwani wrote:
> > Changes in v11:
> > - tls_device_complete_rekey(): flush pending open_rec (from MSG_MORE)
> >   via tls_sw_push_pending_record() before switching back to HW offload.
> >   Without this, data in an open SW record would be silently lost when
> >   the AEAD cipher is freed.
> > - Selftest: enforce MIN_BUF_SIZE (16 bytes) on both client and server
> >   receive buffers to prevent KeyUpdate handshake message truncation
> >   with small -b values.  
> 
> Not more than 1 version in a 24h period, please. No matter how trivial
> the reason.

Series does not apply.
-- 
pw-bot: cr

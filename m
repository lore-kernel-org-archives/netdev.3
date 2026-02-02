Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8391318ED4;
	Mon,  2 Feb 2026 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076694; cv=none; b=uGT0SRT5tb31f+Uj6YTXXMFqoGJPvjTZFtw4JS+YpMy/mjRm4zV92T7qBfM0CmR7j2+WeJWyp1MI7RS1C9eCSKfVGupmdDEEueGHN4vsLkj7ZaLw3ksn61vpWjTeA+Ecl2YVmsWGFtYrRf/tlHjrcLBYzKuvCgU/y3o4m0L3zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076694; c=relaxed/simple;
	bh=BRzLYgVhduJBkOdpDGMvQh4aM+Uyxm2O3nUvq4ILHMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4gERo2XMv47I7z4Dxp0I1vI4uToN4PsL93fqiMb9lapu58N09u7rCXzzMhZVQzzLUO8fL6JmdWvYp2ZM4d/kvUdYN8ihwuFEgnyVC8CH0R5Ffs4jRrfBsqHDH4IxP56rQacLf6kTPBK2WHTGKcVe8CmjnjJELxBQ0UFTI0IiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIR2hMpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIR2hMpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15747C116C6;
	Mon,  2 Feb 2026 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770076694;
	bh=BRzLYgVhduJBkOdpDGMvQh4aM+Uyxm2O3nUvq4ILHMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIR2hMpkUMbhV1MpUhritR1FLGXUgquvWgO+cNXu5uIv3h6mT47Es8QhNileswiVR
	 BZWZgFSxGoU5G8yrZQDufhvQ3Mj0Wqb1knY1oX+J3pPveV1n6c0u9DuUdnmPeSLa9g
	 /rrIDZHPlJwzvMEpL3e8OlvzExblqQrdLksg/Ll0WWbgSiLO0MxudHUM3+kiQn1BTU
	 xiY5lHWFewarOGX+MX7o12YOYAQTiLQR3Z521BySibAmGmXjDIYmUPKNKOhBYslXTU
	 MIw71MZsNU8LpfTMksiQbcSIrzo8r0cdHnu08MkYFHwIRYSuWW4pzY7lu4VxkQRsWu
	 tYf+Rr9Yi3V5A==
Date: Mon, 2 Feb 2026 15:58:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com, mschmidt@redhat.com, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] iavf: fix deadlock in reset handling
Message-ID: <20260202155813.3f8fbc27@kernel.org>
In-Reply-To: <20260202084820.260033-1-poros@redhat.com>
References: <20260202084820.260033-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Feb 2026 09:48:20 +0100 Petr Oros wrote:
> +	netdev_unlock(netdev);
> +	ret = wait_event_interruptible_timeout(adapter->reset_waitqueue,
> +					       !iavf_is_reset_in_progress(adapter),
> +					       msecs_to_jiffies(5000));
> +	netdev_lock(netdev);

Dropping locks taken by the core around the driver callback
is obviously unacceptable. SMH.

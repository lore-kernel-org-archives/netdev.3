Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDA518158
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748112; cv=none; b=ON+15/VYeF/22mNVm+AllSVkWU2uPzkzZmbJhvay+TkgWR+s+f2fIWlID68FkDDysPn/eduu9hWAZ/7mXC2sL3tr0HIq2K9UIP/ES503SASPSY9bms9TQ/d/h+QtSh6UA5C/wH8nOvL7ThzoFxqkZDzDIu1OHJZF3i05hQZ6L2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748112; c=relaxed/simple;
	bh=bwYTVxpNzg+ky561EwzugH9LgPm+uj11vHIeD/B9b90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPQB60OlkG4I4Jv1MNa0FemG4JSZ8a4GDM8f4/nOLLX+C7jiR2oaGMGA2i8O0ZVJA8D4ZguEe72YClLjPXGoUFJZehwNYxD2nLSK7klAQiyxFX8RuEVsf9G69pAATUmm7AJx1BFvqMHczVMW3jCVEq7Wp0hwwTNrZOZkLbvx1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKaA2ifV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKaA2ifV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3267C1F00899;
	Fri, 18 Sep 2026 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748110;
	bh=RSVhNQB1WVcgRlS40BiRzBVR5Sa57x7VLJhqga6yMeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKaA2ifV4EOP4q8A1bjTB25wu01Lwpm7SpBwqEsx0Ofw0Y9go9qcYENg7fPtixt0H
	 0rSAQZlmXQUMvVpNpceRhF9ePCDvJsaYcLjEKDAqzK+37bN9S03UvGqBJaY8npXQVr
	 uLNxV+jBshEyNFzMWkuTueJ09khNpOKh/ym+zFhrv1410RnuK1x+Qq6FAyKBRkXdsa
	 kl5e5fACiNUFAWDBqoCTRNSp2NpKm1fopIB3TN4KLBtd7BRL5Odo5vnt5m6ZQi7G2h
	 9XUFqow53YztHwG5abVc+SS1o+eew0+OdsnXQ2x6Iu4EjKhUujtChvDPHjWWq41xig
	 flDMVe963tC3w==
Date: Fri, 18 Sep 2026 17:15:07 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@meta.com
Subject: Re: [net PATCH v2 4/6] eth: fbnic: reset num_napi when the napi
 vectors are freed
Message-ID: <20260918161507.GT51261@horms.kernel.org>
References: <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
 <178942021809.7700.10804028989308077839.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178942021809.7700.10804028989308077839.stgit@ahduyck-xeon-server.home.arpa>

On Mon, Sep 14, 2026 at 02:10:18PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> fbn->num_napi is the count of live napi vectors, each of which owns an
> IRQ.  The PM path had freed them without clearing the count.
> fbnic_pm_suspend() tears the datapath down via ndo_stop() and frees the
> IRQs, but leaves netif_running() true so resume knows to re-open.  Resume
> rebuilds the datapath in __fbnic_pm_resume() and fbnic_reset_queues() sets
> num_napi and __fbnic_open() re-allocates the vectors.
> 
> When the datapath is torn down but never rebuilt, num_napi is left
> pointing at freed vectors under 2 different scenarios:
>  - a PCIe error recovery that fails (fbnic_err_slot_reset() ->
>    __fbnic_pm_resume() returns an error -> PCI_ERS_RESULT_DISCONNECT), so
>    .resume never runs; or
>  - an __fbnic_open() that fails partway on resume and unwinds, freeing
>    the vectors after fbnic_reset_queues() has already set num_napi.
> 
> The netdev is then running with num_napi > 0 but napi[] freed, and the
> eventual remove/unbind close re-enters fbnic_down() -> fbnic_dbg_down()
> and dereferences the freed vectors:
>   BUG: kernel NULL pointer dereference, address: 0000000000000210
>   RIP: fbnic_dbg_down+0x28
> 
> Clear num_napi when the vectors are freed: in the suspend teardown (a
> good resume re-establishes it before __fbnic_open()) and on the resume
> open failure.  A redundant ndo_stop() then walks an empty napi[].  The
> normal ndo_stop() down/up cycle is untouched and keeps num_napi for the
> next ndo_open().
> 
> Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


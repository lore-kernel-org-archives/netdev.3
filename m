Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74159128395;
	Sun, 10 May 2026 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438872; cv=none; b=b4d4j40fGeOyMl95ipb3faHxFdKjFk7cDtmjn+Nm2B8bFFtYeOQJIzW8gTx3XldBD+MLtZoNscpOHRofrFac9FsoKPDmOVxfG9h45EzX0sg4eVPWIElOS4HEan6AhLfOhLcOWC02r7RUObn19vBQP+YnuYrwxEDPkaG7JPTi8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438872; c=relaxed/simple;
	bh=n7VgOciu3rvPWfPH73tA2Fjh2ko9kNaCORNBN7S6Pqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+eOf53GeA8w0N09xg0onyTjhEGWuyAezf95RAHlj0Oe1TOulk4uK0U0Q7cus9ToorDiZ1HAlCrgNQYavDgX09jVWVuQsmT3KaxJz39djNAxlF5n+HW2hcLsUXFANBEEkRMhDgSSSm5+wMIx/wviuyhZvTrv0m1X9D6tNzkMxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcSPj1rX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcSPj1rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028BCC2BCC7;
	Sun, 10 May 2026 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778438872;
	bh=n7VgOciu3rvPWfPH73tA2Fjh2ko9kNaCORNBN7S6Pqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcSPj1rXUzDrIu3dHgvrFK+GWaSVm3XfXo3+MdpkYbwn/fPwzV8yp3fkVo6QISNCG
	 jlP3riqwj+Z7rlzGOE4CQRMGhPhwtK5T1CfLHIZ/meNMEFVVPoLrcrnpax6mXRQVK1
	 MNq4UQ3D0krr5wNqOM1087UFuvOO3+pP//l7qVkS0gxqpgbJrWAtOhuIN1CVeFVSs9
	 JPZ2ZMopBWz47AOmSFzQoLhruwJnFfKjdvusVNbqzANztImke575W/lbCtpph/lMBg
	 JaZ673vLxpYAiSdSAMG660EPgM3JOq0XN02mFFzcQDXpo3LaQzAEPEE3OL3iGBBVw6
	 +zx2g4hdd+uZQ==
Date: Sun, 10 May 2026 19:47:47 +0100
From: Simon Horman <horms@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <20260510184747.GX15617@horms.kernel.org>
References: <20260507154203.3667-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507154203.3667-1-mike.marciniszyn@gmail.com>

On Thu, May 07, 2026 at 11:42:03AM -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> The DW IP has two distinct PCS address ranges cooresponding
> to the C45 PCS registers.
> 
> The shim translates the PCS addr/regno into specific CSR writes
> into one of those two zero-relative ranges.
> 
> This patch fixes a one off in the test that could allow an invalid
> CSR write if an addr == 2 was called.
> 
> There are is of yet, no real impact for the bug as no PCS writes are
> present.
> 
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> ---
> v3:
>   - put back into the series based on https://lore.kernel.org/all/9ec11642-8035-419c-a896-52f902020bb8@lunn.ch/
>   - revised commit message will additional details
> v2:
>   - omitted from patch series
> v1: https://lore.kernel.org/all/20260428172810.175077-2-mike.marciniszyn@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610A249EB;
	Tue, 12 May 2026 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545290; cv=none; b=Kcpd9aHVF9kF9cahH9JgDW0pcnqauXr1Hdwv+cwj5R7QbOTADedI9KAn/vc8rfGzlaRjVzU2I84GZC0vh4e7T2bCTjoXqTdL5cuYuomLdiq+LkzPICi6A6u/afz6Kfqw6T9v1d+1nIoIaPys7+SLNqaejy0RENfntGLnCFE60gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545290; c=relaxed/simple;
	bh=m3dOl51vgiXNVH5J9h0yitdbqqGVC55XsK4fvuDChzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c//oAii0HHB3ww2RUbCKMESHCtRcPwVfmg+I5J5DU2/usbvu7nWKlHmOAUWGVXlS/8tBLFEIN9Qq2GlTAfROcFdGE8IQ9cbsVIljLc5ldS9bpy7gAOKJfgTjps9GtefPhXc4Iva2+xw6Co39j5fpK1KlnaSd5a8VmxV/AQGakaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTGIhXmQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTGIhXmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0803C2BCB0;
	Tue, 12 May 2026 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545290;
	bh=m3dOl51vgiXNVH5J9h0yitdbqqGVC55XsK4fvuDChzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HTGIhXmQ3pkv8Fjgw5KgyvwmQ++JUCMza15Fg7uDvejFbY54F6dWhF1zuSpE8yt6s
	 40MFhbc89m4Qt5y8/pT+4LnSwBRXub7mBnuB8JirnYuUwRm/SBeYcmoXbbGgzaHckT
	 oiJPZ39hTr2Isz1wZ1zntQ5A+aNzcPj8k7TUxqWPLhA1Olyxn7nEMDKoyNzjHGf7ke
	 9ho+YDLmN0/ettls5A5QVaFQTM2k9PThTds2Dn2cm7cdMQSeS3UHHWz/Op+whcqqNz
	 80QKVVrJNGsszjX0EN/Um/CP997LL1NUAdItSkyDcHVqUxR7qTMGoMG63KHc+a+MUS
	 5ziDjXqBRwmeQ==
Date: Mon, 11 May 2026 17:21:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mike.marciniszyn@gmail.com
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <20260511172128.57af5c5b@kernel.org>
In-Reply-To: <20260507154203.3667-1-mike.marciniszyn@gmail.com>
References: <20260507154203.3667-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 11:42:03 -0400 mike.marciniszyn@gmail.com wrote:
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

Applied, thanks! (bot is not replying for some reason)

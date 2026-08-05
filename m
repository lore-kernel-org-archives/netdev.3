Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB117B418
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899090; cv=none; b=KHCh8b4uiJ2M8j17UEI8R3rRyCIlXLnd6zorqxOKl0nx69m3h/Qf9pKeWfRMBWlQmcj26sW4vuQtUwzsSfAi7xvbxYjMAVMiNJ608rrNBK96NdwZKEFolX+yj+GUL/tZg7iXNVVsStjZGU+kcEn6QZbs5NKdm8JlzdTfmkgzv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899090; c=relaxed/simple;
	bh=QKlgFGpwDeWoCfNHSXgWI4JlMFXmafPpPkvRohxc24I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjbkiSx4U0uw/yce/dUirVLY+eFxD+HiqL7a9wocYt6OuA2Fvwd5EJWspDofoeAvM99vcOTtq4DZmzoBHN5S54STvaEDBhPRcPjf0qgo7i1S+kpCl3RA7svvtjVwaA6RWEGz01r4mCeFdb/9heCBwQ/4tN20vfJ4M69V/S3p0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Q4rLCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Q4rLCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175F91F000E9;
	Wed,  5 Aug 2026 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785899089;
	bh=kyPddDSwVuZwIIVKO4mP62e/EHTKyIrVdow3YdmZ/kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A3Q4rLCsqHdiRWzLQeddKehblB/GooGhZarGaW1a6sPnLhxiixAsNE3/wPvBVxJpK
	 LnBKZ8dDRuBaqOe0vWzoS5DaYvhGn573HQ8fCZ8hBRHcFF/o2xvmqJIAy3vcZXkB+j
	 0u+zM4hDxj+fO9G/VBBsjC6Dhbfjj8ussY0Dyldg/Pdqr0hSCb5c+0mGExezAX6Rev
	 znOPb1jJsW45wWl0fm0x67Bi6yreyV7/JEsVrnwsX+uavN4s4OiI9COnwGD3C+9EBe
	 +N9S5nhtVtrN+Yy5UPFHHQ3ovIbDgR6eDU5SFeICNmOIv1upiIDNiYBDw8JVKMmJA1
	 6pBVJVXcQFUTg==
Date: Tue, 4 Aug 2026 20:04:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net 0/5] bnxt_en: Bug fixes
Message-ID: <20260804200448.47984111@kernel.org>
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
References: <20260731190937.807270-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 12:09:32 -0700 Michael Chan wrote:
> This series include 3 bug fixes:
> 
> 1. queue start bug fix on the VNIC's default ring.  2 refactoring
> patches preceed the actual bug fix.
> 2. Bug fix for TPA data corruption seen on some ARM systems.
> 3. PTP PPS setting bug fix.

Just to avoid any further misunderstandings - you can have 15
outstanding patches per tree, so 15 for net and 15 for net-next. 
There can be multiple series for each tree, as long as they don't
conflict.

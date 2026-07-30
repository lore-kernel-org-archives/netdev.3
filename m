Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6C358D32;
	Thu, 30 Jul 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441866; cv=none; b=QEaSKizbeekgDV/SIORo3IDelMasy1Fp5+6MSXTV364p+6WvoTvfAJ8cDhwTIVwW2MnUu7GUb98fttVlL8XnrSqnO9DLkQvMvR2tq435ZFVw8FkdoqgBYITuSnW1CKLWQ0Sd4Pdp2pzAHqdZwuRBpzChZhwePnz/GtkNnYIyROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441866; c=relaxed/simple;
	bh=aJck0Y7scb0vU+rdVfgOpL/hJqCtMuUYNeqMKEdT+y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsH4/2rH2YNk8dr4vwfTD0uKpDrYN9knbkV91aCqZN0lWDo121zkrRwFOoTRKj93bVF6+/nWgEYQ9ndrRknC93bscWfm2MKM09rxxfVhw51v5FOkrPdo6uKb6oeX9OLrLMBRB5jmvnkK8iaV5rjLlMfIrksY6Y9uzboOKYozRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRlMHH7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRlMHH7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DC71F000E9;
	Thu, 30 Jul 2026 20:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441865;
	bh=DkfozPFfZasEvd1VpRhx4EMyFWUQPWlRrdgk7MquWrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bRlMHH7M4As5h+paPhR9/dQgbnEXELAo8DyzM43GawpISJlXt43UYudo86A6gU4Il
	 xNJIYRY3EV5a3JH9sqfok4w8VJAYyiQdusJFINPJjTgWAjUQEbl/f/Cojypyv5UaGT
	 jFE2RFCg/pEhDjUuF8p/lrheZEyxFp8nrlvbxByRIe2zVJt0aGEjb3vWiccR398/Az
	 ND0RJwGHQScvIh680IMzqSGg/hYn4GcbS99d7O63RryVsnuaPldoUNGsceVGn1tyf6
	 V7wHriMsAg//RYChnMLeTvx3m/uoAticu9H1OFU74GUmhTeiFKMRtda2v7ihAyLV+E
	 T6tXeFHyBdMFQ==
Date: Thu, 30 Jul 2026 13:04:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Message-ID: <20260730130424.77a90fa3@kernel.org>
In-Reply-To: <20260730134401.20241-1-maimon.sagi@gmail.com>
References: <20260730134401.20241-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 16:43:50 +0300 Sagi Maimon wrote:
> The ADVA TimeCard X1 (PCI device 0x0410) uses a Lattice MachXO3 CPLD
> that is programmed over I2C using in-system programming (ISP).

coccicheck says:

  if (IS_ERR(fwl))
          dev_warn(&bp->pdev->dev,
                   "CPLD firmware upload unavailable: %ld\n",
                   PTR_ERR(fwl));

drivers/ptp/ptp_ocp.c: WARNING: Consider using %pe to print PTR_ERR()

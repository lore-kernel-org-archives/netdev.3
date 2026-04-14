Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F63909A6;
	Tue, 14 Apr 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179373; cv=none; b=Brr3qjeW39sgRKMfH1S4QvJk/jXygswDytqSYM61eCyemiA4h0Y52DpeDifdozOWxIPByKIFQPJjWs+yPwgDW9IrxJI7k4ppsLuap4y0HvGSN4za516nGkUS5ZhCz+SV02ujoeBwrh05R6vfnSFIXsp99+ZQtcQwtdawfhW/FC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179373; c=relaxed/simple;
	bh=2rhxeax1OI8uTiHdRJmuYz3GYs+VdzeWhg48SRaHWOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3qMjm5+AeLAm1pnvRmFS1bDvL4R5WudBdmmorag95FNz4GeFd8fMhAe1ciPGFWpk7n44yBujG3ZLU1lbpH0R8jFvXfee0fi6wPRqoz/uO3qBixE3BNl2fE30tCVcHNOn7vEjDwuNFY5Gl/DlwVoRO5gBtgvRB1GbhRJgRjK3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STot0z6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STot0z6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFBAC19425;
	Tue, 14 Apr 2026 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776179373;
	bh=2rhxeax1OI8uTiHdRJmuYz3GYs+VdzeWhg48SRaHWOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=STot0z6qolyTE/bNfqK4TV9nSboTLZmNcoNJZpUUJ90t+F9SceiYmc+aBfyolabQI
	 LUadzyEyQplhvUZQ9YBtrdukWFl8qVgitm4uTR1vImd9loJW6FAVqTqJRAOdc+m/Ho
	 li7ZEDkRxM9ajI6ifDdzxOwM21YR+OdyMmuZ6o3VeJPC4vclIy3P4tIxOMfMFa++sx
	 6PDSOFKTzzSVMKM9BWopGlLp4epodQh9l2K4tKFUAeeFepUsbuoysSP4fhxfFrcTpz
	 InIGQtqny8hJDwgIMQjXt//+VGj/dpqB6LAhZ9GiBu0NE8rLw03ZdI+qRGvXOpae9P
	 I+zggXkGcXyrg==
Date: Tue, 14 Apr 2026 08:09:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Nicolai
 Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260414080931.3aef9df4@kernel.org>
In-Reply-To: <20260414125753.Im6GAIHn@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
	<20260414125753.Im6GAIHn@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 14:57:53 +0200 Sebastian Andrzej Siewior wrote:
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Maybe I'm not being forceful enough.

Putting workarounds in the drivers is unacceptable.
__netdev_alloc_skb() must be legal to call under an _irq spin lock.

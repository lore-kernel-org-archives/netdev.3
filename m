Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1338734D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529244; cv=none; b=R0OhzeyXTzDo5oGRKfRN0EFtoXTUvlvlqyP8PnboJzDaMwhm2bF+1aVz3PpmqhlxN0DXqqe+LYXpLLFZGHhdpuXixhj9gCtKiMTJryNJwgehLpoi2oOZz220YGuIAdsbK3xXuuHxPJJlITIFdzl5YGcAx6sXixYm9agyXe630+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529244; c=relaxed/simple;
	bh=WhkDCV8MRWCpI+s9gfqDUKBwNNe2xrKESkRmMARl7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKaFKgJpDfljl9Dq5xIy05hyumEF3Vt3QcrzF1NcUGNuFAsmzXec6L8yi0ejn31OL4RpGuQhBft2HXiSctuS2wCqJh1jCs15Z/pUE4g1K9Zm47OIeLvLUjsL00xzz/0goHBpikfCKkHZPJ33YvUge5UGBgiw8b83OEla0c0ZkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRydAeaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRydAeaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E131F00893;
	Wed,  3 Jun 2026 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780529243;
	bh=ECJq2k0//e+KfT9lEIHzgkXSu8ZoOMqmHUI6DkW7+/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LRydAeaGHDukJxXctVXVgnPaCdwMrNNtdaY4m7MsJWfwA/7cXFRFTLT+lQNyb/FpI
	 0h2iuV9Gd4PdFgE9IJg1H6FY3m84JORX3PqDHmWg0wQasyoSPEb8gpvd5LY5/voULW
	 32gWGErj1fe4MOVQL81Lv0eYdru98CcohiimLkBMgH+ntBFOnkYuyo1cm+9eJCCmrg
	 Nk+eEahhWoslw5ClkY2tqemQcuVJMD4CJSuz7cp6O7Q66yYjXQJ/+z1Ttj5CZ/Vjky
	 Tx/ytIAiG1Xwpdm//22DZCjhJ7s8pJWWOTV7W4DTXBtwWenIkVLTz+rscyAR/dVJzj
	 mUM380XdklKFA==
Date: Wed, 3 Jun 2026 16:27:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 2/3] net_sched: sch_fq: convert skb->tstamp if
 not monotonic
Message-ID: <20260603162722.43c5b2b1@kernel.org>
In-Reply-To: <willemdebruijn.kernel.f08367f74d8@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
	<20260603190243.2789335-3-willemdebruijn.kernel@gmail.com>
	<20260603152224.596d46b6@kernel.org>
	<willemdebruijn.kernel.f08367f74d8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jun 2026 18:59:31 -0400 Willem de Bruijn wrote:
> > fq_skb_tstamp_to_mono() has a likely() around monotonic, this one does not?
> > Is there a reason?  
> 
> Thought process is that the first is a standalone if, so predicted
> not to be taken. While this is an if/else, where the if is predicted
> taken (which is why it's first even if not first in the enum).

Oh, I see, makes sense. I should probably learn the prediction defaults.

Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF034677D
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991974; cv=none; b=MmDAKQpesS6qIuzc0fe1Lleyr/xhmsuVT9V8hC9rkPoIzp59T2oLPivgmGjyqwOxYD7/MbnmdBWOl1kHbU+I/TgD9itsEzOI/qlwjQnx3cw8GNjml/RQXaALo8npwYZ1ZHrCrbF5YDXBVyWgY2amZqYPHs2Z/qpdnicTzwBVISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991974; c=relaxed/simple;
	bh=pLzPHPW9u/yM2bgjbKHk4jmN5UjVuJuiQYDrgHGFO9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adpdegtfjPZn2PvEe/3KppBmNsXRU/IUEL4OmM0Mp40MVX32lV04FdYRDp4jnFg4mGdvL3QNgh/w6qnNyWnxJ50xUeBlTRaZVOmZXqm1uEGLMYHvo7SC5TsenNRFBveKX0UvtMDgGUxK6E1cYUFtOS1xJJuY+ADzGIHDGnObf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJjGPzBD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJjGPzBD"
Message-ID: <c4536ec6-48cd-445d-b627-7c28d2bb63dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777991971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6mdCaLFeEhtNj/1mrLO03arMKdJ+5uwHkL6Pzx5mys=;
	b=eJjGPzBDimvPC6Nac+m4VB5s1NMmoqRNPe3qo1fARhTLdSlEPp2Fd8SDYHFMtOZkSuwZ5R
	HNho8+E1SZxUGUkxUUcHnycEV9tPOO1JbH7ZBl7pM6f0UYSfmhgm5ofwjmdr1Ake1KX8aV
	9Csm9VbvtbCEFpdVrOxqX9l0BtpxLog=
Date: Tue, 5 May 2026 15:39:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 4/4] bnxt_en: Use absolute target ns from
 ptp_clock_request
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com,
 edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org,
 pabeni@redhat.com, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
 <20260504083611.1383776-5-pavan.chebbi@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260504083611.1383776-5-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/05/2026 09:36, Pavan Chebbi wrote:
> There is no need to calculate the target PHC cycles required
> to make phase adjustment on the PPS OUT signal. This is because
> the application supplies absolute n_sec value in the future and
> is already the actual desired target value.
> 
> Remove the unnecessary code.
> 
> Fixes: 9e518f25802c ("bnxt_en: 1PPS functions to configure TSIO pins")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++---------------
>   1 file changed, 5 insertions(+), 24 deletions(-)
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

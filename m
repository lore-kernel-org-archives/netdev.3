Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72F32ABCA
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188569; cv=none; b=V7TVwnvw4x9F2pbk7h1q82vvnQgd4cKAiwH8bn3wMo2MGP8zUsUJTPZXYO8prjQFKLFaX4KMaVo+vluxm0D1jkhgvyu5O9g3uIe4DsSE/HJqNntxt1Pf6uNjtc6MO3dvFQ6rQjB/vM8G6ump/A6rMsiAITdn1ECU9w63zo7E+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188569; c=relaxed/simple;
	bh=XdwCaT+wgt9zSQ350Ca7faeH9Tqe+csmqqfvyLjRa1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL3vIcMazj9btjxGBaEHgSrprkAdArQLw/6J4RrorFVZfXr53g4EjMkXkhNTCnz8Xy6HES7WX6V6L80YWW12mMMnsZa5p/8WbCsTxTdyVHvpY0NlP+cB93HbqseThyPLkC0+vjfQZYPHvtLxXBAK70oh+2b92+l+GS8UPIBH1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vjs/z6lt; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vjs/z6lt"
Message-ID: <a0100b31-d961-4f5d-ba42-31fb126481ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784188563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpcceSQZdt8u+rC5/ETmEGtETiC3v0zxR4dWFBCtWz0=;
	b=Vjs/z6lt0FGgabLPDZBNiGuppoJufrLg52JEDkOOoyn13+zvQ3HUUCmc1zzxEMHuOTbfFM
	iTIjNBZzkQ3IAzfaAUvcrX50kyYnyyA0OmhVI5TE6P4sc0WrX0oS6rRONr0Vn/5swG22xI
	AQpoiVo54TKkgXmn/WNwFsUQl6ApKZQ=
Date: Thu, 16 Jul 2026 15:55:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ppp: annotate concurrent dev->stats accesses
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260715055541.1147542-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260715055541.1147542-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/15 13:55, Eric Dumazet wrote:
> dev->stats fields can be updated concurrently from multiple CPUs
> without synchronization.
>
> Use DEV_STATS_INC() for stats increments and DEV_STATS_READ()
> when reading dev->stats in ppp_get_stats64() and ppp_get_stats()
> to avoid data races.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/ppp/ppp_generic.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
Reviewed-by: Qingfang Deng <qingfang.deng@linux.dev>

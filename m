Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DD2AE68
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784428896; cv=none; b=go8Lt8Bb1KEybUOCEaG/1H8kfBkQ7P1A2dlGbJPWiVcNyKqXeyDmGEw+oTvoBv5RyqQMjXSBkTm6XPpMhION/6TxFtxoYUMHqJZK1737M9rNQgozU3YknGERTY0hRLn0D0JD/2UReJeYoka7nAwg+94/MLjmbm5b7n0s2Up6vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784428896; c=relaxed/simple;
	bh=T+IMYh0kKqAALiojNf0eEsOBjqE5iDv5moDtT6Yy9JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS0Q2WnXTzNmToP0hNwo63cnN16m48/cx0135dVLvnwF34mFlU74HmJ9P4glDiS5nU2K8VGgGrwn4qLaUrr4Uh0oNTS2VRb74V/mPW0eMwcEVJ1jc08F7Crim8euyNSACCUJh6K0FWO6KvdGtDawF01EXInOjM0t759CXjx1PIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sn+IkZmx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sn+IkZmx"
Message-ID: <8638d68c-4bb8-476f-97d3-98f433949ab7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784428891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtJfWQYyZlCwt5055dITLF3UyUsl6gTusWicTltj6lI=;
	b=Sn+IkZmxVcsADg16l30+ATSEaY8uJkAhyNOphUNHjIaw8UCaqKBtlZKexW6tdh3K9+GfnH
	UTdm+7r3MIfSQssOQt9fNOudr/eabf+Czmmr60JitM0bLarweEl99lXQVdETNYyq5SKo1I
	DdRqhEjo6LAyxTlfFl2KfyfnlxBU0NM=
Date: Sun, 19 Jul 2026 10:41:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: use
 devm_mutex_init
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Luiz,

On 7/18/2026 1:59 PM, Luiz Angelo Daros de Luca wrote:
> mutex_destroy() is needed while debugging mutex. Instead of calling it
> directly on driver .remove(), just use devm.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>   drivers/net/dsa/realtek/rtl8365mb_main.c | 15 ++++++++++++---
>   drivers/net/dsa/realtek/rtl83xx.c        | 14 +++++++++++---
>   2 files changed, 23 insertions(+), 6 deletions(-)

As you're fixing a missing teardown, and the two files were introduced 
at different times, you should split your patch into two (one for each 
file), re-target your series to the "net" tree, and add a Fixes tag 
respectively.

Best regards,
Qingfang

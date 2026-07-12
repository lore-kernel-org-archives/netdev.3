Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662937A4B9;
	Sun, 12 Jul 2026 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894836; cv=none; b=Ql4bnVzQgscb1td/kjdWVOPnpL7uCAaJXGm0Kwn2OTeAWHh8nODhfZS9OKuRtYfHlVGepXtN+B/GXHiD5n6P/FA2wnfhyUlee7+gl/tpfQ6wrgvefK6dAZejFpnsfiDCGNsvHE2lSWRIxyYRLtnhMtiZyOSSxv9wEGqTEwfqqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894836; c=relaxed/simple;
	bh=l8L1S0WVJd3eIxG600JhnGrxD1zRu3/XiIkZq2hIjPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cac+eiMZJyC/I9uIwBCIVkc0Qae4H273dKog3HtzXlBzcWXVbyIjwNoxA8wCsTEG6TJF7Y2wc8lilyefXfHyKa1+br1teYWA1mYw67PjDlQBo5Ajfp2qWudYvp8ayHURczrVunGojMFfweTr4xEOK1QuVONXKafgVg79TAg6TfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zlz/oish; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zlz/oish"
Message-ID: <165fca2f-2259-42c0-bac7-58685a4c5ebd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783894822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6q/hlROSEnFud0PHhVOe6WrK0uQOXKUk0FXkjVG+KKw=;
	b=Zlz/oishFwOb1KgPbTqWMa2/pW9Au8C36nuXU/NgYYU8l/sEKuyLaHd6q95t7HcLRKKN0x
	OdofgN+is6lVy2iZdZd4PHrXEdD9DXaMjXH3Ut3EL9cN7G/SaTdpCvWkbfBG9T9aPIB5l/
	bvQhJL10FL2Gdt6qmnkCw7s+XvqpwEk=
Date: Sun, 12 Jul 2026 23:19:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Yibo Dong <dong100@mucse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/07/2026 19:35, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 12 Jul 2026 20:25:10 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “rnpgbe_rm_adapter”.

The null check in rnpgbe_rm_adapter() looks more like defensive
programming, which got into the code unnoticed. pdev will not exist if
netdev is not allocated, where mucse is netdev private data.

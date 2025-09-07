Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6742225D6
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266893; cv=none; b=c26jg7ALHM76wjxdRbXUmvWLwjE3HNhrDl7wdoo6jv/yw8J1rAHtJdrnBO6M2PR3djzEbOV9dmeDxKuYHZAm5zzi/R8ZhNpNH4cEVGbHGv32ugy3guz7mvOmHi38Yii7HKOcDKh79+Q/zjTofGJBs1tQdXRhslSieAaJQafKZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266893; c=relaxed/simple;
	bh=vEEh8/NUEHKuAlj68cbZhgQqD/5B/8B/EJHd3Ged6PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEs5/NAGIKU7s3ed8FHkI8mBa4X1vWKxai1U3ABncN+JZclfFa4qFYfWEnyzIEF/49i8gETp0jwgJfWTsfb9rLkjRWxG609Q8Hv6INlZBBxPkwErQSXvqFfZVtPFGphv5nxNOTqPrU5qKuY3MHvXZc0HCceoXzwDl20OUYPO5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYo5Wyza; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYo5Wyza"
Message-ID: <a49cff49-3fe5-417d-8f71-7ec63a68112d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757266887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEEh8/NUEHKuAlj68cbZhgQqD/5B/8B/EJHd3Ged6PQ=;
	b=tYo5WyzaTgugqiK/oTEOefKmgSagoyoO5h5BjVK83l73Mdkfh1vxQug8voG9pEhlljd8Ki
	fbp7QHRfhLGvMgpkuh8ZyrljysAZ57sGFfsNSfpiPGkBaCI+W4U42pVgrggtjavRhkA6v8
	nPSxhFfqVDzWehQbexLABjaF3KzhGu0=
Date: Sun, 7 Sep 2025 18:41:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: stmmac: prevent division by 0 in
 stmmac_init_tstamp_counter()
To: Sergey Shtylyov <s.shtylyov@omp.ru>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
References: <58116e65-1bca-4d87-b165-78989e1aa195@omp.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <58116e65-1bca-4d87-b165-78989e1aa195@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/09/2025 17:06, Sergey Shtylyov wrote:
> In stmmac_init_tstamp_counter(), the sec_inc variable is initialized to 0,
> and if stmmac_config_sub_second_increment() fails to set it to some non-0

How that can happen? Do you have real kernel oops log?



Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA673BC696
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685289; cv=none; b=DB4XlEUPn2/tHtTVGpUeXxE90KUMK2sMnlGFUZ0Ggo6RlXsHFUnFb6RPjpbY6tZGBIaVVo+ydVQ9Te4kfIZj0iSMfPD5gvIKjy5OpfYRpUNLFsfeQZLU0HIQq6yHQhUtRKiQdE2i/kS6wf82tRZziJRUqfbtkDz934xaI22KqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685289; c=relaxed/simple;
	bh=y5XvCgitT9kdCWv+PywisGMr6Q3n0tEns6fgqvf8TXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyP7I9mE/AW4xWZejkIB3VDCARG+ehNBLCR0pWzJcPens+IalT+FZpcXoS+z8+lIH4l09NxHNrrYvRD/VCk/3GFr54FPdFkAmqJ1xxvo4r/wZ5VOIj1ZtIY5IrJ75g0uEnQwveUEvKXez7DEwDh8tYygdT2aMh+kMi8J7Vjf4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 719DC4C1F29993;
	Fri, 10 Jul 2026 14:07:01 +0200 (CEST)
Message-ID: <b4d17a58-f6e5-48c4-9bf0-230ca710ea2d@molgen.mpg.de>
Date: Fri, 10 Jul 2026 14:06:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [ANN] E830 NIC join intel's netdev-ci
To: Adrian Pielech <adrian.pielech@intel.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org,
 Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 andrew+netdev@lunn.ch
References: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Adrian,


Am 10.07.26 um 13:20 schrieb Pielech, Adrian:

> I'm pleased to announce that E830-XXVDA2 NIC from Intel Ethernet
> E830 product line joins the suite that tests ice driver against net-
> next-hw branch.

Great news! Thank you for sharing this on the list.

I am curious: Is there an overview of the test lab?


Kind regards,

Paul

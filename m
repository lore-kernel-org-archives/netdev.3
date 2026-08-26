Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED23A7F69;
	Wed, 26 Aug 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731910; cv=none; b=qHdfjvXZ7GNDj0jZZaNq5ZU9HUIMnJ17I/vE2vVtHZtIbZ3EqRc6+J8Q/Wfodt4q6yS5IGraHFA1evt9taSQnYXaKgAZAqiedOOnDnLp3AMNGEN9HUuK5VnAscte23FWoPtgvhohae4jl/m3dD7Pga9+cqh1EwgGsVGjEs2eSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731910; c=relaxed/simple;
	bh=ZkafoNqP+Vh4hEVwMr7TSabaUF7ebujKtOy4/cjHk34=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D/EEu0jIzVuXnC1ungptOSXJC8VnGxsfLpmiOzL1WsP7QcSSTz9rd0XW+V+khvPpUCQHxnp3fuTg5LbJ1SsHx1rZ8TIuQrFNS/tg6SljijR+GRb1m+0JPMtfnHT7TRTXaXKbarqDo5/yqdYWpQNKGAe+2rkrrQasjFMaycoqVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.22.74) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 26 Aug
 2026 11:11:41 +0300
Message-ID: <66531ce2-b927-4aee-a088-5c43ff2c6851@auroraos.dev>
Date: Wed, 26 Aug 2026 11:11:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2] r8152: simplify loops in
 generic_ocp_{read,write}()
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Michal Pecio <michal.pecio@gmail.com>
References: <20260825195736.56257-1-s.shtylyov@auroraos.dev>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260825195736.56257-1-s.shtylyov@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 8/25/26 10:57 PM, Sergey Shtylyov wrote:

> In generic_ocp_{read,write}(), the *while* loops look very strange:
> the last iteration is implemented differently to the previous ones
> (doing some useless assignments before *break*) for no good reason.
> Merge the different iterations into one, using the local variables
> in the loop bodies...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
> 
> Suggested-by: Michal Pecio <michal.pecio@gmail.com>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

[...]

   And of course, due to my stupid workflow, I failed to insert the version
log. Here it is:

Changes in version 2:
- instead of moving the code for the last iteration out of the loop bodies,
  merged the separate iterations into a single one as suggested by Michal
  Pecio (adding the Suggested-by tag), rewrote the description accordingly.

MBR, Sergey


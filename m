Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899733B97B;
	Sun, 23 Aug 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787474239; cv=none; b=a9eFKTi04XcfTaFkcJinJH16RHD5Am02lvFtJ2xmT2bgwqWBIznJB8WzM3Ir+6SIW+mLEZaWR0k8/u1wBtjug398p5u7Y6YcjUtEZyQXvq/S9zGTeIkv1+WnWhVfJ0VAsEwhwMbRlN+YtzLD4V6qyQT0/YvsXZgPzetInopnf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787474239; c=relaxed/simple;
	bh=qVIhIFCe2D0WN2zdJQbaBudOoWzVMbEjpgSPLmzFVKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HLi0qVuAh2mHQzKROlOCUUfILhI6PTldDz/q7QvNFZ//BKC++MHZsE2qaERzKeeMPgpPxieX9eyFnfWj9XBxruQMgrOgPRrcTodb/kxfNgArzAsZgXW3ucUM6Qxsp7n+bJpzxldoFH9SDfPGeMjIAtLQRlYL6+pPEmrICul8x6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.20.171) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 23 Aug
 2026 11:37:11 +0300
Message-ID: <f68c123f-12d2-4704-b9f0-a26d17ae87de@auroraos.dev>
Date: Sun, 23 Aug 2026 11:37:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
 <46bc8a60-8979-4b0c-ba43-f99256561a48@auroraos.dev>
 <20260822135832.274fe2a4@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260822135832.274fe2a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 8/22/26 11:58 PM, Jakub Kicinski wrote:
[...]

>>    And of course I forgot [net-next] in the subject... :-)
> 
> And to check if it's open ;)
> https://netdev.bots.linux.dev/net-next.html

   I don't do much netdev these days, so I just forgot the usual
routine (and I couldn't wait so much with posting the patch anyway).
Is it still possible to send net-next stuff with [RFC] added to
the subject while net-next is closed?
   As I'll have to do v2 anyway, I'll try to wait for net-next to
open before posting it...

[...]

MBR, Sergey


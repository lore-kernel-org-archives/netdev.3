Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E84078D7;
	Mon, 21 Sep 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020766; cv=none; b=YH2/TcHFdze7m6OxnNER9z1HFuY9k3pE2bLzWPYqJTK7jiyehgvK11HhIZkY9TwXqYnyUjsbpLK30LIp/IctZu+h1OdGPogtMMgDs+CgHxGc3iAQ+P5uXdck75t48UIW05e5mVnxw1PzWuTVSzYZ9cf2zt/Yq7tWUEEgx4EK7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020766; c=relaxed/simple;
	bh=hZBaJieRUltWL78Xa6YSzSqoN1Erz4TgkJc8CyvQ4Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kPJV1x9IMY8xtYVgZWX84wUMx5rVs+YvGUbs+sjFz4OIdUfZ/34RxxpOQDCpYALDinvN7FVRUxpeqOnBnNbC0m30tRXlXxfTpq80yg/e7YhtdSk8FoF726CvX1GtgLjHRvyY1DsmRJ2aYgU4LSJ4lj3jyMWPODcZwc+BXqtTyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.36.28) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 21 Sep
 2026 22:59:10 +0300
Message-ID: <354d72f6-35bc-49f0-a4f4-3555b03f0ad8@auroraos.dev>
Date: Mon, 21 Sep 2026 22:59:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ch9200: do return USB errors from
 control_write()
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
 <178954341078.22033.8722936070498955076@kernel.org>
 <b43350d5-09d7-4fc4-9791-16bb4322d794@auroraos.dev>
 <20260918182124.487edd13@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260918182124.487edd13@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/19/26 4:21 AM, Jakub Kicinski wrote:
[...]

>>> There is a second point about the resulting contract.  On success
>>> usb_control_msg() returns the transferred length, so control_write() now
>>> returns a positive value (2 for these register writes) rather than 0:
>>>
>>>         err = usb_control_msg(dev->udev, ...);
>>>         if (err >= 0 && err < size)
>>>                 err = -EINVAL;
>>>
>>> Would the obvious caller-side follow-up "if (retval) return retval;" then
>>> treat every successful 2-byte register write as a failure?  Would it be
>>> better to normalize success to 0 in control_write(), or to check
>>> "retval < 0" in each caller and update the callers in the same patch so
>>> the errors being returned are actually acted upon?
>>    That's what the patch I linked to does...
> 
> Please fix the issues in one series or not at all.

   OK. Series against net-next, right?

> We have too many patches in flight these days to be chasing people's
> linked series. Too many LLM-happy "helpers".

   IMHO these 2 patches are not so heavily linked, that's why I posted
them separately... And no AI was involved, of course. :-)

> Please explain how you discovered the issue and how you tested the fix.

   As I noted in the description of the patch [1], the issue was reported
by the static analyzer. For the patch [2], I saw a problem with my own eyes.
   I don't have the hardware, so no testing; there was some hope that e.g.
Matthew Garret (the driver's original submitter) could be able to test but
his email bounced...

[1] https://lore.kernel.org/all/20260914202503.52920-1-s.shtylyov@auroraos.dev/
[2] https://lore.kernel.org/all/20260915185805.38712-1-s.shtylyov@auroraos.dev/

MBR, Sergey


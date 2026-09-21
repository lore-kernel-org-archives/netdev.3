Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612A4078C1;
	Mon, 21 Sep 2026 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022308; cv=none; b=OiXU/oFWPYPpOKyy/0npfrNnEojENMpGJtzZHoK5EYjUULkKisQdQF5rnoe/2sU5A447NFUzm1km+BdxqpA1UA27ttYHR6u9AYpqAdcN3wQemqwqnOtaF9cPox+qDcBU/0xDSRmqmu8AamNP0rgv8RFl+VIv6iw9HzCwl4URa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022308; c=relaxed/simple;
	bh=1qHM737Do/QGbex2exKUPSjnrwiXVYmKswlC197KgGo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=W8WGqvSWeJcmHcghXfnEZly/IXMz/TOi//ISgu1s3abopr6vjkoppK7H1+8Ys8yPhW1bc0SU+zn9TIZYeEymLRydHIpd76rRGduwCn9hQeNe/D6JHjPp55e50AmLNIVRjNYNUxApmCaXB1sqvSNzpPBZu2CsEVGew/4EwWqcrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.36.28) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 21 Sep
 2026 23:24:58 +0300
Message-ID: <4a2ae45f-71d0-49d4-ae44-b5a588f6ac43@auroraos.dev>
Date: Mon, 21 Sep 2026 23:24:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ch9200: do return USB errors from
 control_write()
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
 <178954341078.22033.8722936070498955076@kernel.org>
 <b43350d5-09d7-4fc4-9791-16bb4322d794@auroraos.dev>
 <20260918182124.487edd13@kernel.org>
 <354d72f6-35bc-49f0-a4f4-3555b03f0ad8@auroraos.dev>
Content-Language: en-US
In-Reply-To: <354d72f6-35bc-49f0-a4f4-3555b03f0ad8@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/21/26 10:59 PM, Sergey Shtylyov wrote:
[...]

>> Please explain how you discovered the issue and how you tested the fix.
> 
>    As I noted in the description of the patch [1], the issue was reported
> by the static analyzer. For the patch [2], I saw a problem with my own eyes.
>    I don't have the hardware, so no testing; there was some hope that e.g.
> Matthew Garret (the driver's original submitter) could be able to test but
> his email bounced...

   Sorry, it's Garrett. From searching on lore it appears he still uses that
same email, so not sure why it bounced...
 
[...]

MBR, Sergey

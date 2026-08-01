Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C32DF719
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785619664; cv=pass; b=seevx0Z436BY87V4I8wNIiDDNQqam5T3UWCaU0GmAZg1YQs8vbcRl1NU9OBPJ2Y88MkGKMnGPMzDq6JtZV03W7KBNtshQeYA2Bdco70NQ38tkuD3PkDwCSXMTg/v4ZV9hsn/XmgQTPe1KfSl0sM1qj6N8KGOMsxLFGfmmvjJlJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785619664; c=relaxed/simple;
	bh=COpMihg+02wPOtii9fR01pxJ43jvQUmCztAjLfLkc0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHLdKVAPL+AdNBxNi0D9w6Zk8ptPAhj52IAZHZyn/Fi2Qe2ovaoicoSc3AITbT1mWuNOJHQMQXgG3PDGfosJ88Ws5AaGcFQu/VxZ71bx8NckOeb5HW0DdU2Oh07oAS/2RUEyVn4GkL+5vBZnuTScJBPN3PTfClTLQYUv1LgTLJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=GBQAXjvR; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="GBQAXjvR"
ARC-Seal: i=1; a=rsa-sha256; t=1785619651; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a1WOIOsq2aLguUajG9rIL6uHxw1Q0/fj1r/fmLg2R6W5qTZa1eDHIDMZpf0yNbmDUVuMzN/la9sadg4foCRNYAdK5Kz7voYm161U88fBVcHOjb8AhcrOPyhrlt46cevASgGsyWrTTjSntoyJ3/Eq2MLaM+m5peAH3SahyydVNVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785619651; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XD+8eNuBzZtY+IdT33YsCnlswPhkg5kQOFsV1EKo1vE=; 
	b=XdPsI3m3QfG7lVqTe2thAgGIEvfJ9pJSZ7D0m8ZAn8d0i2okNRghrafIpspsXFpy+9dItQ7UcsEzWNjBy5Wcu6GTrRloFZXl8/ZX79bw0LYA6BJUgPRYVV12xr4OLyrUU1DsDoF3a+4JOCKQc08BO53przXleUv1rJRWOM8642s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785619651;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XD+8eNuBzZtY+IdT33YsCnlswPhkg5kQOFsV1EKo1vE=;
	b=GBQAXjvRappB4p7y/PWmsTvyDIWqtXAKCf5C08Go0tGtzatY1hCZHu8Pvmyx8iSp
	NJ87oNzpJlj6CkejJSuN6KpAk+AZPfopO38SprZxJ1eCFamQrKYJ82DT5WSN2zGWnhm
	e04zepOpDcIRWNciauUIvXb9xd4KWWNd8IgoLJaeCBGgXmPCzzVx2WOp5ejgt13+pPR
	7AiyLw4mtOnnyWO4Dw0orKv9uxjz0ItXlkuy3WuYCbPKQ33O/x0iDOxmGDlIEX31mrU
	nuM7A7+7x8KtwLftNBZOmZUojjCLfJAqWKU0ZW2r9SQtjjaKefV0aZlvMb9nPdINr3H
	jf4uFsQQ2A==
Received: by mx.zohomail.com with SMTPS id 1785619648751825.7035204177052;
	Sat, 1 Aug 2026 14:27:28 -0700 (PDT)
Message-ID: <03ca755b-a585-4fcd-95a8-d7248846eed3@machnikowski.net>
Date: Sat, 1 Aug 2026 23:27:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 2/3] netdevsim: Implement basic ptp support
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev
References: <20260720181113.3293-1-maciek@machnikowski.net>
 <20260720181113.3293-3-maciek@machnikowski.net>
 <20260727094344.GM418547@horms.kernel.org>
 <20260727132049.397d3d1d@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260727132049.397d3d1d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 27/07/2026 22:20, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 10:43:44 +0100 Simon Horman wrote:
>> Simon says: I believe the issue raised below has already been discussed.
> 
> Rings a bell but I don't recall the conclusion ;D
> 
> Maciek, please fix or beef up the commit msg to explain your thinking

Sure. The copy is required, because the stack will return the same
timestamp for both Tx and Rx packet if the same SKB was used.

So - in the "working" scenario the code will copy the SKB and return Tx
timestamp to the Tx netdevsim, and Rx to the Rx netdevsim, while in case
of failing copy - the same (Rx) timestamp will be returned to both.

I believe it is a better approach than dropping the packet, as that
should be a very rare event resulting in a "perfect sync" for a short time

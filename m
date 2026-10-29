Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296892;
	b=c+Ep41WhJzsY6kNXo7Pgwl6xU5uezP9kTNmodWslVXXbpvzwHPQwtzIv6rUJv6+NIhYV
	 NCZOhh5o9YgdezFSImGJmxQGAZ4IeTZP9gLMDpBlXvmTZ/x0uaHHT6T72MyQoIPUGO9Wn
	 AollLhHDsbtKQtikSrlGMzoEZzUULJPJQqfgt+BTl89EXVbTj/5lVl+Wh+SPpjWco2GpA
	 TQbHr3gWNRaZaqDV5nwwo/oNpeSTeCq/nXcaenVwYH7e40jyS/6ogdhROBMdYU72ZA//G
	 x3NmoqX63W1CAEKbDTv8Ls1qarUJsq1RqfTrm1M8yvkZUaJixjmrQ6+3fTeFRwbqo5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=B4eTJHn4TTOASzt/SQ+5sPzNMRm3Go9vQbwBUweEg1c=;
	b=ED43WaPy0j4/oSivFaTwguMmmo5tjJOzy7WKU0S81IKlw1KJ2FlZUCPmU9S5mJptsu2r
	 x3dcMSaAbwA8eyEwgqZHb+4Kffs61qq1Di+3notEigkW5x+ay3hEYRVTLxbnWGFbyLMXU
	 ZsHxnMcT/64gBFY5XdB5SL2PS9XLOZbbxk6hG4ZKHFZPTLozTAHvHdyZ12JHl2CpaXEjI
	 v1T28BdxL/kDIdnnAFEo44vOeG3xatfEZ7lsLV9Q/IXpJZ140yS11t9Xn4h05vz8R/aFe
	 XNHQxPlRjRc8Oj7qI+JyKYcJK3uZ3eXM1772dNg5NYChc2Sbijci6aEQJoi9TkmYQzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=kEMKhG30;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC17606A324;
	Thu, 29 Oct 2026 18:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC17606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=kEMKhG30
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFsVg4JyKz1XM30j;
	Thu, 29 Oct 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793296887; x=1795888888; bh=B4eTJHn4TTOASzt/SQ+5sPzN
	MRm3Go9vQbwBUweEg1c=; b=kEMKhG307bOBz996LWLy9Snn8sUeHjPjPaqORQP2
	h/tlSCrYWJ+x5zEQyPBmtpt5dwuilumnRre8mLLiXw+vppyKGMyluEVthYOlku3b
	nYK3hXzjzBazhc6015IZVwywOtmxZOdkRO6fwGr08v7IZfPmRc3hJyygrLN2caPV
	iEem1H0mxfpipPAwjbCWMShn6AG46/RPMhfJTD4flzsMGcCSCrO+t+s7vVboOt6l
	VYzKFAI/t4duW+XwwyrpuO8MrnHI0KYilmTHV+Xu36rA93alHdACB3oSc+Y/+HCy
	RTlMgTiv88xb6EiqJWt++kaixZckbTYbpiYOchuf36BGEw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5cumBTMNO_Bt; Thu, 29 Oct 2026 18:01:27 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:bc59:f725:8fec:453b] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFsVZ66lXz1XM4Tl;
	Thu, 29 Oct 2026 18:01:26 +0000 (UTC)
Message-ID: <61f025c8-69e6-430e-94ed-fd001232e678@acm.org>
Date: Thu, 29 Oct 2026 11:01:26 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mctp i3c: Fix locking in an error path
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Leo Yang <leo.yang.sy0@gmail.com>, linux-kernel@vger.kernel.org,
 Leo Yang <Leo-Yang@quantatw.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
References: <58aab766b8ce35d1a7ff38880853cedaec244bf1.1793044759.git.bvanassche@acm.org>
 <e291eaa8-c090-41a7-8e8e-9f86e58723b2@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e291eaa8-c090-41a7-8e8e-9f86e58723b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 5:00 AM, Paolo Abeni wrote:
> Why the additional churn? Just return -ENOMEM, no point in freeing a 
> NULL skb.

Thanks for having taken a look. I will send a v2 of this patch.

Bart.

Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476D2BE7BE
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786292275; cv=none; b=My6sTMFSsMduou+UZ6uYe9yyC3fBRGNKzuIJuD6ynqL5Rr0IpiuyMEWep0r11Fak7vKRu/Vwk+UsakokO9HNDw9ESyve6HXGTLfgBfPxhwvx1y4PAVgvGDnB04mc/qGFMi5D4guZ77cZCt6d3n99oQTi79CsCIlJNI2i2F0ahsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786292275; c=relaxed/simple;
	bh=kkuhIvMKFJGt8PwPK5cBJmhyC4XRoVGVt596xAwcDko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/yMtiuarxVkYrW5ZZvFRMYR2c483g6lEUTrUW+UTJYkUUT4oLx6+05cdlwCSVzSJV4jZS+7w7lXJPkE3HNHHwTni9ajtz4D4orvX3L3piI8fbEgy4arCjeAQvE/kY232hUK3LKEUx9m7dQlUoqxLZn3wB5Kf64XJNFwxsydi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nv6ALJOG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nv6ALJOG"
Message-ID: <76232f9c-2a5a-454a-905e-e046b6c78cef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786292260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls2P09148Go83H2loQoFgJtdvJmHErvM+XPN0s3rcp4=;
	b=nv6ALJOG10X55r7JEcAZZOgGsyyLV5lBh+WfqocDGq+Cv4swqNBSfSx1AYUnvq5f+jvT8z
	uWlpIqeMzgS6X5gMtI57SZL7o8ugwSrswq1XSQzHLbKJlTz5AJVg0qKcTkO3BNesd97lPL
	i8KONKrnwLInuJqhuvQ2WlrCsdOvFAY=
Date: Mon, 10 Aug 2026 00:17:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next] pppoe: remove session socket receive support
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Guillaume Nault <gnault@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, Asim Viladi Oglu Manizada <manizada@pm.me>,
 Eric Woudstra <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Michal Ostrowski <mostrows@gmail.com>
References: <20260806091626.231225-1-qingfang.deng@linux.dev>
 <20260809145836.5pqf2rgf574fjlds@pali>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260809145836.5pqf2rgf574fjlds@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Pali,

On 8/9/2026 10:58 PM, Pali Rohár wrote:
> Hello, I would like to point out that "no know open source
> userspace implementation" does not have to mean that there cannot be
> some closed source or not publicly available. But I agree that
> probability is too low.
> 
> Anyway, could you describe what is this functionality (which is being
> removed) doing? Or how to use it? From the code and description I have
> not figure out how it is suppose to be used or for what kind of scenario
> or use case can be it hypothetically used.
> 
> Would be nice to know what exactly is being removing and what userspace
> applications cannot do after applying this change.

pppoe_recvmsg()/sendmsg() can be used to receive/send PPPoE session 
packets without the generic layer. I just found out that the RP-PPPoE 
package, maintained by Dianne Skoll, actually provides a standalone 
PPPoE client that does not depend on pppd and instead uses these 
syscalls. So long as the package is still being maintained, these 
syscalls should not be removed.

The state transition still needs to be fixed, though. It's done by the 
PPPIOCGCHAN ioctl. Note that despite the "Getter" semantic, it actually 
alters a socket's internal state by setting the PPPOX_BOUND bit, to 
indicate that the socket is now "bound" to the generic PPP layer. The 
code is carried over from the very first version of the PPPoX driver and 
the intention of this behavior was not known. A fix may move the 
transition to a non-getter ioctl and drain the socket receive queue once 
a socket is bound.

Best regards,
Qingfang

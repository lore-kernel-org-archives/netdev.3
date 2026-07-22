Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF3332EC5;
	Wed, 22 Jul 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702589; cv=none; b=SRC1ozRl+8TlbKUwC8YngbefufHKgRjns77onWwSCKNSaXI7EkSdju0TWYIYkVrZYNDFr2y9yUz0EKhHY4ZrfNapFIzXWFSnJa09wfLwkdqCSkIo2WP+TDsbK7EWYlDJkQViX2lKAyYjBfug5bFHs5DxRApZqPxbQacDgNQkZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702589; c=relaxed/simple;
	bh=fLliyUhfO9MEYoMPKNVzbH/pGortgBb+2gh2z+j1/7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKm7PSl9MaRbRcXHqKPz0EEtsUeC0hQ1JmF0O8t18JpoCQiPzJnccP/TAvTG+yfGs2R0BRiuLdMeQgSRW4UF/NxYfMCIH2VIMT0d4XjEH6VP1Ni2nyoOJwmw+uUKzi4bE8JKG3vESZDz8TWrLac8o4a8GktOsNtwSLajRM3MWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=sxox2WPe; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="sxox2WPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1784702380;
	bh=5JERmTqErEb4Ui1kJm+K8rgaXsXmw8kOVXyUKZCKmgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=sxox2WPebn5ER7Ad+vojA86dQP8FUHdMFF0unSfDL3929Za5zjBog2iMzAdwHCbk7
	 gZCvbtXJnSyNacSebhoIID0GL270k5KOL8FwCCHGU/OK4fpMIYZxCSAiYnDoctVF2h
	 HgEdO8sNtQB3MFWMP3+WP0q+TAFUMl5ZvB7ClrJs=
Received: from [129.217.186.87] ([129.217.186.87])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66M6dc5X009437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 08:39:38 +0200 (CEST)
Message-ID: <8814700c-7549-4d12-b657-c990dfeec14f@tu-dortmund.de>
Date: Wed, 22 Jul 2026 08:39:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer
 <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
 <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
 <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
 <20260721105853-mutt-send-email-mst@kernel.org>
 <20260721100715.5b43412d@kernel.org>
 <20260722020611-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260722020611-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 08:07, Michael S. Tsirkin wrote:
> On Tue, Jul 21, 2026 at 10:07:15AM -0700, Jakub Kicinski wrote:
>> On Tue, 21 Jul 2026 10:59:52 -0400 Michael S. Tsirkin wrote:
>>>>> I prefer applying it, but you maintainers must decide that.
>>>>
>>>> Hi,
>>>> just a gentle ping.
>>>> Has there been any decision on this patch?
>>>
>>> Hi netdev maintainers. Given there's a perf regression otherwise,
>>> we should either take this or revert the original and reapply
>>> in next.
>>
>> Revert, please. We were AFK and are now working thru a backlog
>> of 1k patches. The new IFF_* flag needs scrutiny we can't afford
>> at present.
> 
> okay. Simon can you post it pls or should I? And once merged post
> re-apply for next with the flag included?
> 
> Thanks!
>

Would be great if you could do the revert.
I don't want to mess it up. :P

For the re-apply:
I can post a v13 to net-next soon with the flag included
into the existing commits.
Or would you rather take v12 plus this opt-in commit as-is?

Thanks!


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582360;
	b=HRkKFEDhFoCgR/Qg+pypdICsSiC5MvBi7REDpiEQLtIK3F0wU2VydSCutRzenKXNVAWm
	 mS9ZB00cFFAmCV2udCl0kkboeWYKhlvEHgusVBm61IZCHPr4lqpei5JjHe0+5aUeuILZ7
	 Faf6ncRmTW0fg7KFQb/KOJvozJ9SqSFPInJarFMsKlFl+xQucj4a6N+Sg7SA51z8C9RBJ
	 lXyroFYIus3PsP5LEmQbfzLM991DKZpNM7BtVAdjX+oiczNkx8prUX8PJHUA0Qgd+a8Sl
	 vL7gUVMMSHrePBN62JMU4UycldRvXYDVFbB4FufQZYh5Vb9uSciHIaYNo4Xd58RIapA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582360;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xyl3CnVvMpFrRVxhlof0NYmw37iq2GNFSsVdxr9ncrc=;
	b=160wVp6qmxKmPGZCkfLSXVx54IVxdOm0dgxJUXxtj4+1SeDtY58l5rGq2BJ1nNSX7JHI
	 ic9Z29wAni/8E1jRsfSUdA4ubXYc7okYzB9KKxq7O79NG7RUEGG/494XzJM2XPhlj+hDk
	 yvrPP+kXOSwCa/QkyXMjEabH1Yz05edaFopHR8QCeREi91LMjcxEbfHpqM2TuSOwxQOcI
	 ukVzUqXZ1jNTBaaP0863PcR8wnGZ4rH0WanCBg6oQ2fo/SYUniOtmzGjuZuMF3yDSX+9g
	 bAGJ/XOcPT2gKlzT5dgFzdXx8zliSuty8u80graY8FUyMs28Fo9N0i9fZHs6uEI0PCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DWQFTKYP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=neyGB9I+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D29606A32A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D29606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DWQFTKYP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=neyGB9I+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792582358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyl3CnVvMpFrRVxhlof0NYmw37iq2GNFSsVdxr9ncrc=;
	b=DWQFTKYP0f8Z2SKXci9XgvqqzP/D1QsRFQcuuAjnkgWLLMDL3bVzlg0WoQoV37zLLBhjLt
	RermL9qO3Q0t5R5Gf3+ZFrXlUbi3rJ+7dmuLJRvBNPMKOkqHxTie4F/0KcrLvcAYTjfoCR
	Q06c8Ki5FzEzN88Btri/o+jk4dL0Wg0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-tqX_vzLaP3O4fVuXFOHVvw-1; Wed, 21 Oct 2026 07:32:37 -0400
X-MC-Unique: tqX_vzLaP3O4fVuXFOHVvw-1
X-Mimecast-MFC-AGG-ID: tqX_vzLaP3O4fVuXFOHVvw_1792582356
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0461e040so472588f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792582356; x=1793187156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyl3CnVvMpFrRVxhlof0NYmw37iq2GNFSsVdxr9ncrc=;
        b=neyGB9I+UBWtnQnBAiSIIx8sSNKcZo3FCFjhirHRInG7kttXdJ6krZFN5cw7FGTzlN
         tqdkEAJzDWBouVp7FAtyDivGsaq52+tYWFPNxuq7zWBSv6lJXFv/yWwNQCFqSeNEUvJj
         xVlsGu7ojvzOk39d8VIFrpGq58oB1zL3S/sRcn/7hbUyZEJ87GUSnwm2rx/xdIULu+dt
         ebc9IHQOijuMZzlCpvcexhSLuuD5n1voVdAneBze9PN7Gy5VKlrwiCgpXy96PlDVVoQR
         6uminrHtNj9B2bad3nkIbR23+SpMh4C6E5PCRIEleOOcRbYcAm5rvH9hdFNmw/cI/IE6
         GSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792582356; x=1793187156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyl3CnVvMpFrRVxhlof0NYmw37iq2GNFSsVdxr9ncrc=;
        b=ZJYKerL0FeLfZ2WIPTXttHhHhtPJpYKwjNMUyLgz77lyYv8A78M2hJQC9+MD5z0BmF
         ohShp521pcwY15jMjCT4VInsUXNdctv/XNPLUPT3ukWhBDIUQH00A3K01+6D6ljISvla
         8WJ21mZDL8i5LU71GjYH6kHuDZj54xG28RdJHowgsqYEy4n1QUroVdkFlIRofW5kcWzd
         qVOYFuuzP1SCmBpELV0/KVq/QranzFdxXRQYtQt0y9zOjF2a0PB8qI3s4I/ql4sbhQP4
         78qdyibBFgtJP2aYHdfldXg8vHibYIqery4iEs5acFcI2m27ZFJDEuMkwpb/IyxTJNg8
         IvXA==
X-Gm-Message-State: AFq9FYKR8ac857YzRhbPkFhkkaYAc4OQ2qTTQxxYPO/vQaaXyXf3+lyT
	XumImUPjDVf+N/sJI4K7sYeaCSWUQsEigR7jT3UXU5DUH/TJ8BEPBtAor2whq4B82zO3hzJjuuK
	jMOjExbTq7EkHQOPDrlcV4InZ2O/OdrQJliYcRznEPyBHBQeOu3zusbUaiQ==
X-Gm-Gg: AYBFou3oS2atQyIWrYPREZN2qEg6+csS5CgdC1njmOBSlUwhXwt7XkyO65znnCzsIBp
	93ENDJfQw/DjFSsUHtNuIyz7X/i4FeFgC9ayB25MIXhx/pKmVTAcunlsNJLs+oVgrGOGREbz8B6
	Kgz6sRN6l4tvhgP9UKziQTkbV4jC3IGXeZV22tIxGLITUc8mBI8kufORKUeRk7uLrxSo0zP9OYP
	p1TXpsJnaDf1mY8XRtyQPX9+vJ/BNvqUlMWB0vyPkdxuK1YeJLB6FuzUliivBzX9iqn7fDjV+og
	BYD9LZ+ueCsLxW+aX0lPvxqYTW/rkEEvbvKlat8lNmtuY2QywhBd033eEj5gR0Ny2pqmfhFp7dt
	vt3yfZ/nBm9s4dq0NSeUJF+GLn/5DiPaCxmbXGRk5rOLW0dzC39QmqRyb1AK8AOP5lXNHEpIdFA
	==
X-Received: by 2002:a05:6000:1a86:b0:48a:ffc4:72e0 with SMTP id ffacd0b85a97d-48e26427bbemr3945592f8f.4.1792582356087;
        Wed, 21 Oct 2026 04:32:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1a86:b0:48a:ffc4:72e0 with SMTP id ffacd0b85a97d-48e26427bbemr3945544f8f.4.1792582355599;
        Wed, 21 Oct 2026 04:32:35 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm4908466f8f.22.2026.10.21.04.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 04:32:35 -0700 (PDT)
Message-ID: <bad72d8e-f424-4be7-8376-30ff0155e2d7@redhat.com>
Date: Wed, 21 Oct 2026 13:32:34 +0200
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
Subject: Re: [PATCH] net: sfc: run hardware-classified UDP packets through GRO
To: Edward Cree <ecree.xilinx@gmail.com>, manpacket@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20261018-sfc-gro-udp-v1-1-f7bf378178f8@gmail.com>
 <e6e5a292-0512-47d0-964b-249ff35074ac@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e6e5a292-0512-47d0-964b-249ff35074ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 15:38, Edward Cree wrote:
> On 18/10/2026 22:05, Michael Baikov via B4 Relay wrote:
>> From: Michael Baikov <manpacket@gmail.com>
>>
>> This commit partially undoes changes made by the commit e79255de8581
>> ("sfc: Do not pass non-TCP packets into GRO code"). Those changes made
>> sense back then, but now GRO can help with more message types. Instead
>> of passing just TCP packets driver to GRO now also pass UDP packets.
>>
>> Tested on SFC9250 with a UDP_GRO socket.
>>
>> Signed-off-by: Michael Baikov <manpacket@gmail.com>
> 
> This seems sensible enough, but I wonder whether, instead of doing GRO
>   on TCP|UDP, it would be better at this point to just pass all protocols
>   to GRO and not try to be clever about it in the driver.  I don't know
>   how likely other ipprotos are to grow GRO support in the future, or
>   whether the front-end check in the driver (potentially adding cycles to
>   every RX) is more expensive than having random IP go partway up the GRO
>   stack to then be kicked out onto the non-GRO RX path, given that
>   there's not likely to be much high-rate traffic that's neither TCP nor
>   UDP (whereas when we wanted to separate those two there was potentially
>   much more value in doing so early).
> So on those grounds I think there's a case for a straight revert of
>   e79255de8581, 

I also agree a clean revert would be the better option.

Please note we are in the merge window right now, you need to wait
until net-next re-opens for the new revision.

/P


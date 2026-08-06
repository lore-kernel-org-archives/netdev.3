Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83A34FF45
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033688; cv=none; b=c7SeQMl7/4q//fosmCwOlWvTFPhdsOE87hZcc1TKaB3Mjh9FXt+6VHKSSWZT9dYpmA7oIC1DMeWhr0zovD5TeETT1JTfhydf4DpeOWx5RokQxHlZWiHrDXnEqR6PZ4MA9aX35wR1WKKmerAS6XAPK7u42VWDfRTduNUJkoCCarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033688; c=relaxed/simple;
	bh=eca6ulYw6IhYDxuNuTjkwWtFZPOSiHxyXG97xC4xopA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3Xu4T84IY1phi+PJ/DticboK/y1l+J6P++QpU6z/AMU35PR0xcHTpbGCtJgHGVPl7CkYyBkcMIySD27wtvtdvUga/iYfpyTbz1jn0q/mVdYlAX7gOn64C/JMDadWiV+C4VK/ic2bD/x5xA1ixKZX4YiY1C31Wknwkq76FbnXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kc0eZo41; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzTZa4gG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc0eZo41";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzTZa4gG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786033685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Qo2sD1DiW4hwGNIaIcBNKzEZ4LOhcbsiPbnRysRHis=;
	b=Kc0eZo41lpH/N0kA5EQtH0vt92c5CitwJmJj74V6nB9TY+4ypJfugSm1xpLWC96vDb/YVO
	GpP3UCT4rHBodgQuLrI0oKUeOPBTvpL7PFGKLcvEOKRpR+OjDa6OpBLSMqWJsigxswsaJN
	vqZH5P/xhDtjB4lZhOWL+iR/4k7FOp8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-1VeVceJ5O7Wp54eMPYQ8HQ-1; Thu, 06 Aug 2026 12:28:04 -0400
X-MC-Unique: 1VeVceJ5O7Wp54eMPYQ8HQ-1
X-Mimecast-MFC-AGG-ID: 1VeVceJ5O7Wp54eMPYQ8HQ_1786033683
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472a798fc7cso1553738f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786033683; x=1786638483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Qo2sD1DiW4hwGNIaIcBNKzEZ4LOhcbsiPbnRysRHis=;
        b=CzTZa4gGoenX+Qehbn1h9ykyeJR7K6iPwYS9I8VjwqiRJM0+VDIdkawb9yfBS9cPun
         JOacK9/Wxsc8w+B+nls7sejHc5jZm4JWJkdbTtqiwYG7Katjarav63tCMp5+/QS1FfgV
         ftQl9IphmSvngJb1GNPuzkzHnLP5xektkPOaCoLs7SGmOnJT44KiFyTT5i4dvtgG5/Fa
         bn8ZJogWIoQ732CiJwmb/p8f/tk3vIYkl/q0SpqOoQT6/D2ze6VBb8ZznfdnlCUmkW9G
         Rj+u2agTyehkXRQyFSs98BDJjuolEg0i134U1jdwcEJl9Kjv1cZHmvSi9fN0Un12d77f
         2Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033683; x=1786638483;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Qo2sD1DiW4hwGNIaIcBNKzEZ4LOhcbsiPbnRysRHis=;
        b=Wk+3zDw+PH0DR77YKntaCMmOoSRvKse4yWG8WrdVGBo2A89SSSzh7VnmJUTlRHQ/RZ
         gg/oQ/a3zvwYIE00vLwL5t3j3ZVBy/TOx6rw1p7VaLQwhHNALkmYnns8DAesRdHF3ymu
         AN5TsW/gBs+hNediuaoENmuqVzRxGjpyGW/3ejhj+FCCBm0KC5GqlVSuWOZSfUES5Lof
         QMqWL6wIWeafKKGMCdmRM3AV+d+n/Jy1ViNm6Y6DzcqmW87Uc/ftoh8txRb6O3GUJ+lT
         PI2TEt8jgoCWQZPP9TufSRUHSpNJR6JCsAHHVc5O/b0y714aijEgWe4/a3MSdz1UXDeP
         T0Lg==
X-Forwarded-Encrypted: i=1; AHgh+RpewKTx9znx8RbHjhMp83eMi9YKvZit8uXHKRNOQbQIxaqb4FsZf9TcCFUHl03liUQkzIZ6g+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlFnHIOFKDguvlv4HISKx6P5w9FKr7/ggQpvLbkoTymqu6yn1
	Bzm3anL2dMqNvVPvtWcPMjFbfc/RrOuWz61xKf82WLFv+0/rSSQuVUgdOdXsTaYG3KZc1jvlzjM
	XfzjsiQrigJrRprGhXkXjRIGKpLQGCDmbt74m1sb0Op9ZdU3M9uiieBVTRw==
X-Gm-Gg: AR+sD10bv8CMMjYgYmRUj8ZuZJHKtzp0a+NaiI96Fz6XmJioaCqD1x1Eb+eTPcaJHGJ
	z3/YZIVVHRplfCycrMpv3JmOsYLp7wxNcuH6t5tj+EiU/DXwenZ0+AqQ4Ef17aLcQ0KgVsN9i3e
	hedet1kH9lKq9Z3j4k6A6f7sxwj58bwnpCl90tEBiLuUc7z2KBhFXgDpoNZBlupuXDS2k5N1pi1
	PyKEMWKi8FGJsRQ2lOTt5GqHZUPLoGbEk6W9wqRUuq9n0zJLzLlPVsqAc6mDT1XNzFX5tNAYHYK
	33yopT2myNdbV1EIPk7CshhP2Ae61zjQaJXt/7IdrKJI9nFiZjfJKrSxOw8rARn9LI67FXgIZ/i
	jurdoRKpxv0beba9Le1VZZ7WlPSuzgVoBAFgHnrWdfcPi7ylvzT4mTU2pnLAYeHy5WjbGSA86j0
	E=
X-Received: by 2002:a05:600c:354a:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4994e7b72dcmr220252935e9.9.1786033683407;
        Thu, 06 Aug 2026 09:28:03 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4994e7b72dcmr220252145e9.9.1786033682962;
        Thu, 06 Aug 2026 09:28:02 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954221f32sm83719565e9.9.2026.08.06.09.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:28:02 -0700 (PDT)
Message-ID: <ae905b11-1b13-4f3e-8705-8a8c2ea7f54b@redhat.com>
Date: Thu, 6 Aug 2026 18:28:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
To: zhilin zou <zhilinz@nebusec.ai>, Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, tom@herbertland.com, vega@nebusec.ai
References: <cover.1785734738.git.zhilinz@nebusec.ai>
 <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
 <20260805090721.GA1364862@shredder> <20260805172902.27c9bde0@kernel.org>
 <20260806085214.GA1748060@shredder>
 <CANB6i5xN-rrcVe9foAJ+nUP-6VLrgXa90kwh5banCUVDOwG=1A@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CANB6i5xN-rrcVe9foAJ+nUP-6VLrgXa90kwh5banCUVDOwG=1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/6/26 11:06 AM, zhilin zou wrote:
> On Thu, Aug 6, 2026 at 4:52 PM Ido Schimmel <idosch@nvidia.com> wrote:
>>
>> On Wed, Aug 05, 2026 at 05:29:02PM -0700, Jakub Kicinski wrote:
>>> On Wed, 5 Aug 2026 12:07:21 +0300 Ido Schimmel wrote:
>>>> __gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
>>>> before calling ip6_tnl_xmit().
>>>
>>> Probably just me but can't they all be buggy?
>>> PKTGEN likes to send shared skbs around in funny ways.
>>> Can we get a good explanation in the commit msg or maybe let's
>>> keep the check?
>>
>> ip6_tnl_xmit() is accessible via two Ethernet devices (pktgen doesn't
>> support other types) and they both clear IFF_TX_SKB_SHARING, so if
>> pktgen sends them shared skbs, I would say that it's a pktgen bug and
>> not a reason to block this patch. Note that pktgen is not available to
>> unprivileged users, so it's a less severe bug.
>>
>> The patch also makes ip6_tnl_xmit() consistent with its IPv4 counterpart
>> (ip_tunnel_xmit()) which is already using skb_cow_head().
>>
>> Zhiling, please add a note in the commit message that ip6gretap and
>> ip6erspan do not expect to be handed shared skbs given that they clear
>> IFF_TX_SKB_SHARING.
> 
> Thanks, Ido. I'll add a note to the commit message explaining that
> ip6gretap and ip6erspan clear IFF_TX_SKB_SHARING and therefore do not
> expect shared skbs, and send a v2 with your Reviewed-by tag retained.

I'm not sure if it's too late, but since a v2 is required, I think it
would be better to keep the skb_shared check: that will avoid a later
patch for the pktgen/shared issue that inevitably will land, possibly
via the security channel.

Thanks,

Paolo


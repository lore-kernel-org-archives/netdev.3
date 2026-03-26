Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085193876B5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522490; cv=none; b=UQvDE1rPWuMfdy7xsRmPwEhFKqQfs/wvMgsBKvqxNLUrkfpQLV05OTEUIpO7AQ/4+q2BrttgQRc63aRCeQmjR2EKquD/NcSANUG6bTHEn0ii9Be/qKRoGmA7ETa6P+B5M8Wa9z82U/aj0MJ5zCsuiZGqFTkeX6YEfWMVyrktC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522490; c=relaxed/simple;
	bh=YFWNJ/3lNDIRnqBs1+DDl56h16Xs6SvccfOduX6eJWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgxJKtPuNX9kWFC3SijZrMeAIisAiUInfrrV2qxuKkUm7yQ1h9+PJhngjF7bW1OxCq8U6kyqYwrmh4BlYeGv8C5NiWkmkWc2Y5kZh1utVJoiszn5zpAbP9Q+OGqdd8XeixBwsre7lpYR65+DePOKa97TSfnkhs9JizFKUfkkhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IU8lUqId; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPKe5NdY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IU8lUqId";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPKe5NdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQyYxg7ABGBbUtlt/fVW7qUEWYEXN8azicKwPpeysDM=;
	b=IU8lUqIdH5XRxumbxn9vkOFq382dlJKPazA6LaBaiTM1APdvxu9hmOCGSYFi4NoF4yCGW/
	3udZOLpQZGEeZ97syChfclzJ/F0jDa1ElLB4fqeQKeZX1pfR6LKenaivHvtlOarlZI+9dG
	sCm1A8s17k5oH7bn6T3xx6WtM+bn6k8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-txkoFBv4MAmZ136NGRIeEw-1; Thu, 26 Mar 2026 06:54:47 -0400
X-MC-Unique: txkoFBv4MAmZ136NGRIeEw-1
X-Mimecast-MFC-AGG-ID: txkoFBv4MAmZ136NGRIeEw_1774522486
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-487018c8244so5675565e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774522486; x=1775127286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQyYxg7ABGBbUtlt/fVW7qUEWYEXN8azicKwPpeysDM=;
        b=iPKe5NdYviWF/wPtdt5LDq0t09XxuYwm0Q9mjNTdCZnKkiPEkpexKl9n1L96wOHvHH
         cTxB220+2tr3nofL1sNT3j9gVXRDZu3nlBqiylvb8vNFUR1QEHz/DOn2kLhlDkch6e59
         ApiLxS8vBP7YLnVYhkySerZe+nu/07GCfACgpcC/4vtMt5HoDGnHm3V475bQ3akLrecu
         RP5C3e9MP6ep9eg2cXbq/WAvX32TMmAsulXsDkf0rLalAckLHhrDNek0GkeGN6KGoHgU
         q6HQzBqpAvN/k+vHVq5GnmhEwj+w2xeQO16nflndhHj3SEH9fXRJJjnzjQrGVvzC8TiX
         602g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774522486; x=1775127286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQyYxg7ABGBbUtlt/fVW7qUEWYEXN8azicKwPpeysDM=;
        b=UkE7l2o0wt39Mw5jH+ofnfGDP306RFPzOv89hXuhJpYyj/CvQtryN+DdCgFEZjPVaC
         ES3cuoM9b03W2mbWBHCWezxAF2N1CoRwGAwcZWehzCWpvSzG6fKWuwUA0RmrJFeZBG1N
         uYpSP4OWzLEJ0C4XMMdLrEY0FjpEylp212Ume63Ns9ykq6SCCEtQ5ORyZTDx8ohv+V6W
         w5YuVH1/3oTShEmH1zS0OKYEsdtbbm5Sq3mDq6Qptdt2IgnQt6LYUMQUvudHGG/xHrgI
         xf0bJEE83bb0lpPWM0+YVU3l67ECkadcbtm7n66UkhE8oc+jo/xzrKJS9uPzFj2tTrP/
         bXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDn/JlU6RERJtornWwP43IbwCgBf509g289LiY206npD5sIjPV/CNCaLHx1Ojw0vIk1AGJyDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyevF8t4jVVOT2eZnQi+qwno5VXn07f6vp+58Nk6daOchAD0HHT
	uVmU0ZpjVEfcZpt7xL8O8lkmpJbGv+agjmj+EhHvYrIJporzSqueAbTV3SVvZjxPTpU0tGJyfLM
	I2YuhWqCBRmioGwel66H8fQ1vBUaO6aVS0YucEpiu+aqNDMvFWaE0Q9JaMg==
X-Gm-Gg: ATEYQzx92ThSy9J6J5NmGAzjN5CW6DL6IYbIW/ektq/qvVKVXfMEO7HwscZRajQEKJb
	v7S7Adr7CmGnr/Bb+8C4+UmK2U/NKe1Yj5q8AkJWDt0Ix6Ud5FGr9uem/VmLDgWrJPtj/4bxXqE
	DgCjPnjR7ZmNSxoZ6Usu4AXTb3+dMShgCSxsgqqOgTzu2lmaYkl0z7kAK4XQeUBU6B1JTUzaL11
	bhwJzF1VivYg+Bo9fGA3VqTVns6tsPuAD4ZXknSvgSnJXybDvgedJWuL3hB9DJnZdEwA4O2aQj0
	g9J2fpGnDlfHAAm65/gPpB2SP0zoM6P5jsdx1MrK4U+c5MiMOecmApDSimSDvbf8NtKhk3/KMEf
	i4/oFyInSM5qivADyG8/n53IAEO5qm+Vv398g4qw/O+SLCA+rVkCTvuWJ
X-Received: by 2002:a05:600c:630f:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48715fc37acmr100312625e9.6.1774522485722;
        Thu, 26 Mar 2026 03:54:45 -0700 (PDT)
X-Received: by 2002:a05:600c:630f:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48715fc37acmr100312325e9.6.1774522485269;
        Thu, 26 Mar 2026 03:54:45 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c8cfdcsm36225815e9.8.2026.03.26.03.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 03:54:44 -0700 (PDT)
Message-ID: <3e352003-730e-4215-b91b-86f876965f3e@redhat.com>
Date: Thu, 26 Mar 2026 11:54:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qede: validate TPA aggregation indices from CQEs
To: Simon Horman <horms@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, Pavel.Zhigulin@kaspersky.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260323072415.60149-1-pengpeng@iscas.ac.cn>
 <20260324175701.GD111839@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260324175701.GD111839@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 6:57 PM, Simon Horman wrote:
> On Mon, Mar 23, 2026 at 03:24:15PM +0800, Pengpeng Hou wrote:
>> The fast-path TPA handlers index rxq->tpa_info[] directly with the
>> completion-provided tpa_agg_index field. That field is only a raw u8 in
>> the CQE layout, while rxq->tpa_info has ETH_TPA_MAX_AGGS_NUM entries.
>>
>> Reject out-of-range indices before touching rxq->tpa_info[] and recycle
>> the affected receive BDs instead of indexing past the fixed aggregation
>> state array.
> 
> I'm not sure that we need to guard against out of range values here.
> Can it actually happen?

Seconding Simon's opinion: it looks like such bad values can be possible
only due memory corruption or the H/W going wild. In both case the real
problem is somewhere else.

If you have a good explanation for the root cause, please add to the
commit message together with a suitable fixes tag and re-submit.

/P


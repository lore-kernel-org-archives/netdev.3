Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3594415F3B
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616300; cv=none; b=KCRrcrOxFvGuNzVE7eh2yTUNv7eQEL6eBAeQbxDWaJpdC+Xc3RuhkrdNm7p8ZbN2jI1ZafS7wB88Bg5hKnquuDFHCrdqvc2bPFTw2MUFOPSL3WXqekxSQlrstRN4L5k1PitTQCL3/Mp7esqflfKYfytME+7BzoRA/uWROtFe+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616300; c=relaxed/simple;
	bh=j/NIwXvPAxTMl7x2mvti7Jt54oR9iZD6daoZYqKMH/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af2UEZvXXmtyCKMncSJCPaeC5o6t1MfsGRm0irEN9F3X0Rkeaq2G4pk3GzGV7ILrhy51KV59p6glxnoQvcqVWOnHXVo8bJCNJvvxWvDNfu6FnG2tVHsUQTUXDwjzY+hKHPPs5+nUobuvds5Q+8LHOIsltJuyLTpI3xKOcHJkuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cF4mbxy1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cF4mbxy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786616295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhVOT1NBoJWCMrs6MKS/xrLWaLicxdeO10OJF9EgLYQ=;
	b=cF4mbxy125ql//ePQeTTSK4Qkk9VIwsKbWNiWuatjJebP7mkuJAFuTknUBo+Uohd5ezbjn
	V99LET3koFlAJOVaMnFguDAFa3Ng/w9K7rGz1TNqhADCfTqHZIitE1p/nGrkKWgxBFmM02
	9wz4R5ksCH7D1XoOct6MCWBj4YbTTR8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-S1IWFIC3NN-jCEXUX-Ocgg-1; Thu,
 13 Aug 2026 06:18:12 -0400
X-MC-Unique: S1IWFIC3NN-jCEXUX-Ocgg-1
X-Mimecast-MFC-AGG-ID: S1IWFIC3NN-jCEXUX-Ocgg_1786616290
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F4CB1956096;
	Thu, 13 Aug 2026 10:18:10 +0000 (UTC)
Received: from [10.44.48.137] (unknown [10.44.48.137])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9043930001A2;
	Thu, 13 Aug 2026 10:18:06 +0000 (UTC)
Message-ID: <42682bd3-8291-4dec-bc10-23a0afe0b0a4@redhat.com>
Date: Thu, 13 Aug 2026 12:18:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dpll: zl3073x: add ZL30643 chip support
To: Vincent Jardin <vjardin@free.fr>
Cc: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
 <20260724-for-upstream-zl30643-v1-2-ea93ba4d85c8@free.fr>
 <4CCA3CCC-C687-4658-8ACD-BC0CB3294A39@redhat.com>
 <amuE9yIaBsFSgRhL@L30177.local>
 <760d9664-14f6-4cf8-af55-699ea3021b47@redhat.com>
 <anzQ04ySyCbjQPD5@L30177.local>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <anzQ04ySyCbjQPD5@L30177.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/12/26 10:00 PM, Vincent Jardin wrote:
> Hi Ivan,
> 
>> Yes, minimal reference frequency for zl3064x is 1000Hz and also
>> supported bandwidth range is different (not relevant now).
>>
>> So, we need to
>> - add new field into zl3073x_chip_info that will describe minimal input
>>    reference frequency
>> - add a check into zl3073x_pin_check_freq()
>>
>> Let me know if you want to do it yourself or if I should do it (I would
>> send it along with your two patches).
> 
> I'd prefer that you add it, please, cc me so I'll be review it.
> 
> Thanks for your help,
>    Vincent

OK, will send it... thanks!

Ivan


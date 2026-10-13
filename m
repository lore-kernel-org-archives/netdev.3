Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3994078C1
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882900; cv=none; b=KIMzuKXn8f8VdphES1p1f1S6HdxyVy2pFIIqbt0e1NhJwG7a+LYvRQLJ2iULkopcGDXiDl32A9tRadZHw+SWQIdRzYdPrIyDUgDx5MZeBz4SrrshqIzutgYAJGFQEjidI0nfdLyd2ngiXJhFRC5jkkAAtSqrfr+cLWRGW0b1Lkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882900; c=relaxed/simple;
	bh=HRzu/NeteCSAqDRszJlhquR7COIV1cN9uotsLhhDSbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbVo4vFX7qxHB1JT0J5F2aO3hraYG/Mzqg45YyiFcK6dvP8U+wfIMgsvShigKKpk8P/+zKApCrRM1OuztICNkiwWfCnY265/2H73zNuFxWeVrv5EswNPtow1r00kSvvtWkDyUn43CcwDJA2kDxB2DXXC8GLTkPVUoDEIzfClsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKPDbhYJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKPDbhYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791882897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6s5PxnFvY+34GX/yIqUx0m5MKvROFlmTvgdbaAooWs=;
	b=HKPDbhYJCXLk1cyKsI9nBMqZPrE2UQ3OQTn+0nlpI4iAA6UqscuDf5Lyc+ZEXzXNAcggOP
	bZxerf3xuGDkyccuftc5pRbp4bKnrg1ibqoiTgHCGGPqXUBhagV5D72aAeuoy4kryHSdld
	zOWPjbgULmGGl7D2rf4iOGJK8OcEONo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-N6SVC6UsPXm-ahh4pDJ6aA-1; Tue,
 13 Oct 2026 09:14:53 +0000
X-MC-Unique: N6SVC6UsPXm-ahh4pDJ6aA-1
X-Mimecast-MFC-AGG-ID: N6SVC6UsPXm-ahh4pDJ6aA_1791882892
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D83F1964CD2;
	Tue, 13 Oct 2026 09:14:51 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C929C472;
	Tue, 13 Oct 2026 09:14:47 +0000 (UTC)
Message-ID: <f145db3d-11a2-4786-a1eb-b0f939542b22@redhat.com>
Date: Tue, 13 Oct 2026 11:14:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-5-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-5-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> The DPLL core wants a type per device and a property set per pin: a
> label, the direction, the capabilities, and the frequencies the pin
> supports.  None of that can be read from the chip -- which frequencies a
> board actually presents on a given input is a board fact -- so they come
> from the firmware node, with defaults for a node that does not describe
> them.
> 
> Input pins are interleaved P and N lanes of four differential pairs, so a
> logical index maps to a pair and a lane, and a pair configured
> single-ended presents two independent inputs where a differential one
> presents one.  The labels follow from that, and the two extra input
> positions -- the crystal and the inter-PLL sync net -- are named
> separately.
> 
> One of the advertised properties is worth naming.  An output whose node
> lists no supported frequencies is advertised as a continuous range rather
> than nothing at all, since those pins do accept a frequency set; a
> request inside the range that the integer output divider cannot produce
> is refused when it is made.
> 
> Kept in its own file, and introduced before anything is registered, so
> the registration code that follows has nothing to say about firmware.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>


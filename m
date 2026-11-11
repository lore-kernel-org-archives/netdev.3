Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394730;
	b=cDEddSiy2fTNIFsTl/e/ICTPId72Jlbsgyi5UVLLz75L4Uw0u26HzTT6XJxCfyzbNpOm
	 7PUceR8jsKzi/aobome0Az1LRJ9dcpDasQzVawmLgoRXlt2A65DurMFQgD3pPZjmAgcfm
	 0wfAO9U7Jcl0fkL/sDRKH4iwIZa8Ue/kuX9qS1peGpnpXi54Z1//3husuz/bX0YR87bPV
	 Fx9ZuJFoiKqvi7Jv1T6u1LXMUkDYWejHHtPGXw3zOQfUN7dOhyF0MYV/m4d1LVxgCHZu4
	 V+QGPp/jE+Y4z6GFkqeiq4jDZOGOm5IhjIe2CJCiH7ND8Tasp25dgjLqmZYH0JJP4+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394730;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
	b=eWRDMXf7/Rfwx6Kx8qubE/Qf7J1GFQPQhRGbDcW1SndvwSsdVBuEcexNgfi6m1xqDWEI
	 N1pC5CpohWhaGy+bH9OUtx3anvLuC2A1sPppnMo4mnhN6DcAVcH1Y/tXcexvK/n8EdfOR
	 Lomnn8ohemXW5WNEc9o9O7vIO74mBsahT1abxzomV0ATwvPECmrYgFcHDMy2aMqzgEZhY
	 ukhBe7ARqaspyB2Kj4GaWoP61060L1ZnQ3q9lqSNnSHHt4lGLlB0pTYPQNq+RnQ3TEKIO
	 1aXaHWZP8U9I1LRvyiwweuMIym4DajYFzcmj2iiU2Yi+vC8PTnZpII2oZHMPN6HbLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8dnlWCt;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84A606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE84A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d8dnlWCt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794394728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ihetc2DxDCVVTHEoFYuGdLd4AvFTx8i+2f03biFLNnc=;
	b=d8dnlWCtsmXWFzSobKkj5jXct0X2mK7Hq2KnkRDOZl+UmlfbVcQmCIU+kKUSC2oKaAdsqB
	1Di84e6g7dRhYmCrrieYvCx0bsWf6ZzHi0Mr/Oq7mOl0tmU50tQMDM3go11eSx78qBgqTb
	QAw7014+ARoXI1hMHULqpL4TvQZXXB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-_cNDg14-MKmcaMnxWv85kg-1; Wed,
 11 Nov 2026 05:58:45 -0500
X-MC-Unique: _cNDg14-MKmcaMnxWv85kg-1
X-Mimecast-MFC-AGG-ID: _cNDg14-MKmcaMnxWv85kg_1794394722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 398A51955F6D;
	Wed, 11 Nov 2026 10:58:42 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD9F718004FC;
	Wed, 11 Nov 2026 10:58:35 +0000 (UTC)
Message-ID: <38e49109-be77-4f81-a663-276c0e6301c0@redhat.com>
Date: Wed, 11 Nov 2026 11:58:34 +0100
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
Subject: Re: [PATCH net-next 03/10] dpll: add domain object
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
References: <20261106121005.1327603-4-ivecera@redhat.com>
 <179433320288.994134.11961533455589849486@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <179433320288.994134.11961533455589849486@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/10/26 18:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The comment on `lock` in the new struct dpll_domain
>    (drivers/dpll/dpll_core.h) says it "Serializes the driver callbacks of…
> 
> --
> 
> dpll: add domain object
> 
> This commit adds struct dpll_domain, which groups all dpll devices and
> pins created with the same (module, clock_id) pair. Domains are
> refcounted, stored in an xarray and freed along with their last object.
> It prepares for serializing driver callbacks per driver instance instead
> of under the global dpll_lock, and states no functional change.
> 
>> diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>> index da8a369556ed1..6705e81bc11de 100644
>> --- a/drivers/dpll/dpll_core.h
>> +++ b/drivers/dpll/dpll_core.h
> 
> [ ... ]
> 
>> +struct dpll_domain {
>> +	u32 id;
>> +	u64 clock_id;
>> +	struct module *module;
>> +	refcount_t refcount;
>> +	/* Serializes the driver callbacks of all DPLL devices and pins
>> +	 * that share one (module, clock_id) pair.
>> +	 */
>> +	struct mutex lock;
> 
> [Severity: Low]
> This isn't a bug, but is this comment accurate at this point in the
> series?

[...]
> Could the comment say the lock will serialize the callbacks, or could it
> be added in the patch that starts taking the lock?
Right, nothing takes it before patch 4. In v2 the lock will be added by the
patch that starts taking it.

Thanks,
Ivan


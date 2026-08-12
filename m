Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C259399CF5
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517946; cv=none; b=IfeICgXXwzrk4zIw6gGc679CH6IKW5XfJIWhITGph4by6vdtGaoVtAzryG0RedXrKFJzgwLAw+KWrK7dDhWxh1xCiVJW3YIaUFTrQXaBT5b3c0ARFuS6DSW3WCM8jeM8VgjnAyYWRGJ3NGtW8wKhnBT18tQ/WdFLHyzL0BvU0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517946; c=relaxed/simple;
	bh=x40J7rlkMaI3fQO00vN6AZhk7btbbEYXuOWDvdbYHzo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nCJrGNfI59VcEMmihuuEHK2uTQN5M5kogTMlaPNZ9n93NLmlnY3VnK9Ryd4nVn+A7+jj6vcRUQC8J1iWOPQVU6I8QTExxTETzCr5RNaF7rfjcCGfHpUPo5VgwXNtzDwwi4rHBbhF4Xv4quTmXxEjhj3x2zCGJPKbYlFVuNcMmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlZBjhJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlZBjhJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786517944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x40J7rlkMaI3fQO00vN6AZhk7btbbEYXuOWDvdbYHzo=;
	b=VlZBjhJcu3w2JoZt9uT5z4eAJYiW/OVS958RcqGj9IFaUFcehwkKXoG/6JEaSv/SYIxxRS
	YjZ3eLzl7/mzYf5ElQ3HAO71CuHEeCzDyuF4jSusaxPqM1oNIIMQ9pcL0G7TD3I66atfOI
	qRxr2TbmmMYc0QMTG/Jz3HQ/XHoM2KI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-ycxrNbHCP3yQKT7z2NTxeg-1; Wed,
 12 Aug 2026 02:58:58 -0400
X-MC-Unique: ycxrNbHCP3yQKT7z2NTxeg-1
X-Mimecast-MFC-AGG-ID: ycxrNbHCP3yQKT7z2NTxeg_1786517937
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8EC0195608F;
	Wed, 12 Aug 2026 06:58:56 +0000 (UTC)
Received: from [10.44.32.148] (unknown [10.44.32.148])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9118180034F;
	Wed, 12 Aug 2026 06:58:53 +0000 (UTC)
Message-ID: <e9898fd0-32fa-4b9b-baf7-fdea2484abe4@redhat.com>
Date: Wed, 12 Aug 2026 08:58:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] dpll: zl3073x: add PTP clock support
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-4-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260811134700.1211010-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sashiko findings. Replies inline.

 > Since there is no delay or sleep inside this loop, will it exhaust
 > all 20 retries almost instantly on fast control buses?

See reply to the same finding on patch 2/3 — testing on I2C at both
100 kHz and 400 kHz shows each iteration takes 17-19 ms regardless
of bus speed (dominated by device internal processing). 20 retries
give 340-380 ms of budget, well beyond the 20 ms margin window.

 > If zl3073x_chan_tod_ready_wait() fails here, the function returns rc
 > directly. [...] wouldn't returning an error cause the PTP servo to
 > retry and apply the seconds adjustment a second time?

If tod_ready_wait fails, we cannot be certain that WR_NEXT_1HZ was
actually applied — the semaphore timeout means we do not know whether
the hardware committed the seconds or not. Returning the error is
the safer choice, because setting sec_adjusted = true before
confirmation would mask a genuine hardware failure and silently
report success when the adjustment may not have been applied at all.

Thanks,
Ivan


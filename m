Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962275;
	b=pq+gBVjQlZXR1yTupa6LOXtR/Y7rJAz1jKAuwkQz2qHBkX4VH42UnRqFFwLpJM+ORtRG
	 7EqsCbD4aw5cFRC/oi4bgayjzc1Lpn42vUelgITswxXuqMrQ7FvsgP8PykeX1MmiTKZPd
	 7+MFYQyrr9uIZAPfg+cJLFfNtNoXiwPYRtYfMWxo6mf8uVqoUOGgQjq/aCQps8uknk6Fa
	 vGWNT1eGocq+iEEYhqQ6u8lFGuQi3/euZXtDZdT8Oww8ANNM+2rgEaqdMUM66Mo5EwUwI
	 Z/vub2mcTWlxubR4o1l+FU+qyFbA9ltph1j+qDwJH1p+k+h75zfwB7t3Fkv4/ddTzKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962275;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=o6OVcQuOohxB4bAo0IQsYDmoDq5Xn+lMRQTdafduBjk=;
	b=Sia/o1812i/cUXznmvU4w4gYSNlzM3bpDDksVC4kEf8ko5sLcPYFc13qqAcaDXwm4huD
	 QlryD/W15wNdI+5C3X9l6bdZwu3+fo7Er3BGd/sgcs+7gNFN+4P9ZMbuj6GfZgZ+xCVRy
	 YrkM2TCkWo965+VKCoVn30LLHLShoH6dVkkdDXap/iih1ax4U2dPBpWOoVkUL7xSDSi49
	 Y70eIvVhuaeap/q33DNudMeivdJK3YDowBtgj78mB9LkLxaYmflY79ozPopzbbEEz6n5k
	 /D4TnJqcj/PAMEYz8EXHOZT+oFH7MsUoYKvkzEWY2VyIiNtDFD7i0nWQ1yNAipgIgig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dslhwubi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BA606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 10:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 151BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dslhwubi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793962274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6OVcQuOohxB4bAo0IQsYDmoDq5Xn+lMRQTdafduBjk=;
	b=DslhwubiIKpBe7iE7RIY4ft/C1WlICX3TNjXFrHRqq5pWyFvATrdwyoIuVyRZCswAvAuts
	rPscUqnvZD20AalcuYb1xnf9IRpfFIqXhTUmZ/USKV11BsFWVwlGQkbRBhG8CY+p6NPeCb
	ZFhEKSH/T7/AM66IvcRqzIsz1TSZQjU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-zUZcGdCyN-e2SMk0vTIzzA-1; Fri,
 06 Nov 2026 05:51:08 -0500
X-MC-Unique: zUZcGdCyN-e2SMk0vTIzzA-1
X-Mimecast-MFC-AGG-ID: zUZcGdCyN-e2SMk0vTIzzA_1793962266
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBDDC1800359;
	Fri,  6 Nov 2026 10:51:05 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C7053001DAC;
	Fri,  6 Nov 2026 10:51:01 +0000 (UTC)
Message-ID: <1dfd2621-5b33-489d-83e5-84ae0ba0a825@redhat.com>
Date: Fri, 6 Nov 2026 11:51:00 +0100
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
Subject: Re: [PATCH net-next v2 10/14] selftests: dpll: add pin frequency test
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261105151852.1844305-1-poros@redhat.com>
 <20261105151852.1844305-11-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261105151852.1844305-11-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/5/26 16:18, Petr Oros wrote:
> Add a test that picks a supported frequency other than the current one
> from the frequency-supported list of an input pin, sets it, reads it
> back and restores the original value. Both ends of every advertised
> range are candidates, so that a pin advertising a single range wider
> than one value still has one. It skips when the dpll tool lacks the
> frequency keyword of pin set, and the restore is deferred right after
> the original value is read so that an interrupted run restores it too.
> A pin that reports no frequency or advertises a single frequency only
> is a skip on a device provided by the user and a failure on the device
> the script created, whose pins advertise several.
> 
> The driver may refuse the candidate. A driver without a frequency
> setter refuses every value with EOPNOTSUPP, and a driver with
> constraints of its own refuses values the advertised ranges allow,
> zl3073x for instance wants the frequencies of an output pair to divide
> each other. On a device provided by the user a refused set is a skip
> that names the reason the tool reported, which the setter keeps in
> DPLL_LAST_ERR, on the created device the simulator accepts every
> advertised value and the refusal is a failure. Once the set went
> through, a refused restore is a failure on either.
> 
> Signed-off-by: Petr Oros<poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


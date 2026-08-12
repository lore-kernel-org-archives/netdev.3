Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128B372691
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517889; cv=none; b=VZ/ZY6O/QZkV0/kgadmkTReXXx/5SlRXLX7yUIySYvsWdTqwC1lgRjrM1hUJYqgSYBN0wdo/PGVgXYnacMhpWMTJ2y6rFYJ0W7i/603d5HApyq5qDzR0CeBuyDLkFmbNVkt9D4Wpt6VPaPbXchnXWacPUEqF4NpPyWV/QhbUSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517889; c=relaxed/simple;
	bh=5O+76LGsv1wbgQcYBy5mCo8iUlONKLfCAehFIy3xXmg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=soLIllG1KjTbAos43wdpKAJdmmdZA7HsvBW8DqaDrMJ+Ymt9YRGHeCJLifrevnLQFwCdu0yTy8T6Bh9x9i40Jm81mBnuAhd2Mmv2zXC671PkeI+JB18AtzoMV81ORIyWv39pPZN+fxtQdOTOmLAxiVE7lS4niiDc0Cei0CunTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaPjlajZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaPjlajZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786517882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5O+76LGsv1wbgQcYBy5mCo8iUlONKLfCAehFIy3xXmg=;
	b=AaPjlajZ/7px548R13/HycNoE1JYKW9VjQmMeA9zSG7ajFnfR4m3eQIMabgGc4Td9Iyhwo
	7FliZAzrJ3rOnGqYWcDyruCOpfrUK8Uv1+Kopdo03ploiHcpJfBtpYLl/KbVyCWm9HyBWK
	6Wx3oaZkimOZTSgCymLh2ulcFRh6eIg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-uH5dLtvVNqKYQRHUNAQOZg-1; Wed,
 12 Aug 2026 02:57:59 -0400
X-MC-Unique: uH5dLtvVNqKYQRHUNAQOZg-1
X-Mimecast-MFC-AGG-ID: uH5dLtvVNqKYQRHUNAQOZg_1786517877
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A88619560BB;
	Wed, 12 Aug 2026 06:57:57 +0000 (UTC)
Received: from [10.44.32.148] (unknown [10.44.32.148])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C57043001DAF;
	Wed, 12 Aug 2026 06:57:53 +0000 (UTC)
Message-ID: <452e52d5-c80a-498b-b12a-ab539ed9a2db@redhat.com>
Date: Wed, 12 Aug 2026 08:57:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
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
 <20260811134700.1211010-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260811134700.1211010-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sashiko findings. Replies inline.

 > Could a transient hardware error bring down the system here?
 >
 > If an I2C/SPI bus glitch causes the device to return 0xFF, the SEM
 > bit will be set and the CMD field will hit this default case. On
 > systems with panic_on_warn, using WARN_ON for validating external
 > hardware states turns recoverable bus errors into fatal kernel panics.

The SEM-first check already handles the most common bus glitch (0x00
return). For 0xFF: the CMD field is only written by the driver, never
by firmware, so an unknown CMD with SEM set indicates either a bus
error or firmware misbehavior that warrants attention. The switch
structure with WARN_ON in the default case was requested by Vadim
in his v4 review. Systems that enable panic_on_warn accept this
trade-off.

 > Will this sleep-based polling loop destroy the timestamp's precision?
 >
 > Should the postts be captured immediately after the trigger command
 > in zl3073x_chan_tod_ctrl() instead?

The hardware latches the ToD value when it processes the command,
which completes when the semaphore clears. The post-timestamp must
be taken after the semaphore clears to guarantee the window contains
the actual latch event. Moving it before the wait would risk the
timestamp window not containing the latch moment.

 > Could this loop exhaust its retries and return -EBUSY prematurely?
 >
 > The loop spins without an explicit wait [...] On fast SPI/I2C buses,
 > it will execute all 20 reads in a few milliseconds

Testing on I2C at both 100 kHz and 400 kHz bus speeds shows that a
single iteration of the loop body (two ToD reads, each involving a
ready-wait, command write, second ready-wait and data reads) takes
approximately 17-19 ms regardless of bus speed. The iteration time
is dominated by the device's internal processing, not bus transfer
time. With 20 retries the budget is 340-380 ms, well beyond the
20 ms margin window.

 > Is it safe to use WARN_ON to validate user-controlled input?
 >
 > Since delta_ns originates from the clock_adjtime syscall's tx.offset
 > (via the adjphase PTP callback) [...]

The PTP core already validates the input via getmaxphase, which
returns NSEC_PER_SEC - 1, rejecting values with magnitude >=
NSEC_PER_SEC before the driver callback is invoked. The WARN_ON is
a defensive check for a condition that should never be reached
through normal code paths, not user input validation.

Thanks,
Ivan


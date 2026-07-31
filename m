Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DF4499AD
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514841; cv=none; b=Wwks/tq30L6aph8eAKVJyj6guCBR8hkdv0R01BUXU6oew/h4d0PvcyANQkNjyLhACNPdd5u/m6yRwWNPJ5TZB1X7xAgJPSPu1K6+bJ0P+kViSmHMkElnw/OTzVdApjkxzvCfuwY8Y6GWV9Ql4tog81I9nDhsK+qhXNbyCpqIqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514841; c=relaxed/simple;
	bh=qpv3DHry4Dkqen6DUIMXxeuoa6RsXhpWHLXbXdXFVww=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h+gdQJE1V6Yg3EOaFEu1NoabmNL9nmGg4zMe9n63p6fsEJSlbruq3LS3WFhsI0C75PtNSwrtJ9AQZT1KejcDVe8mG69ckha0f56zSLnm88MtrciosXusHv0hc8/AjB3wmM59hpKyYJp8u90PYMxUot37/Q7dIH6FLLV2kjSplq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AueAr7iZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AueAr7iZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785514834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FizlaT41BQCyXtwmmcvs2tLMfyauHPiKH4AgQlCrdCo=;
	b=AueAr7iZF/4NCpJknYzlObcYF/MMh8d/Cfm9yzYUv/fF1hLpUYkwmKAk8P/MPc4HT8jT+m
	XlcPI5Myk5uUVGE/7HTCzAHhqfTlHnex1Nqq0joonnms0jbJDeeOjihJBmNyfb6A0cHQ6H
	8brlOrLcUArzcAFnfQPapf9kVZHAnfQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-FKx-oQ5-M4e4OpmzfrMvLA-1; Fri,
 31 Jul 2026 12:20:29 -0400
X-MC-Unique: FKx-oQ5-M4e4OpmzfrMvLA-1
X-Mimecast-MFC-AGG-ID: FKx-oQ5-M4e4OpmzfrMvLA_1785514827
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4611955F44;
	Fri, 31 Jul 2026 16:20:27 +0000 (UTC)
Received: from [10.44.32.30] (unknown [10.44.32.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A73F18004AD;
	Fri, 31 Jul 2026 16:20:23 +0000 (UTC)
Message-ID: <a380e411-b8a3-4a7b-8270-ab7200d2b950@redhat.com>
Date: Fri, 31 Jul 2026 18:20:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260730132150.371376-1-ivecera@redhat.com>
 <20260730132150.371376-2-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260730132150.371376-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replies for Sashiko findings:

 > ZL_REG_OUTPUT_STEP_TIME_MASK looks device-global rather than per-channel
 > ...
 > Would struct zl3073x_dev (next to clock_id, phase_avg_factor, 
freq_monitor)
 > or struct zl3073x_out be a better home for it?
 >
 > Related to that, zl3073x_chan_is_out_stepped(chan, out) takes a channel
 > argument but returns the same answer for every channel.

Good catch. The register is indeed device-global. Will move it to
struct zl3073x_dev, read it once during device init and change the
helper to zl3073x_dev_is_out_stepped(zldev, out).

 > Can the diff.tv_sec < 0 path here end up writing the ToD with less than
 > the documented 20 ms of margin?
 > ...
 > For diff.tv_sec <= -2 ... the single ts_next.tv_sec++ leaves the target
 > seconds value in the past

The two tod_read() calls are back-to-back regmap transactions,
microseconds to a few milliseconds apart on I2C/SPI. A tick crossing
between them is rare and leaves nearly 1 second of margin after the
increment. The diff.tv_sec <= -2 case requires >1 second of preemption
between two regmap reads which is not realistic.

That said, the code can be tightened to handle both cases correctly:

	if (!diff.tv_sec && diff.tv_nsec < threshold_ns) {
		fsleep((unsigned long)diff.tv_nsec / NSEC_PER_USEC + 1);
		ts_next.tv_sec++;
	} else if (diff.tv_sec < 0) {
		ts_next.tv_sec -= diff.tv_sec;
	}

The first branch handles the normal close-to-rollover case with a
sleep. The second branch normalizes by the exact number of elapsed
ticks, which covers both single and multi-tick crossings.

 > Is reporting a failure for an already committed write intended?
 > ...
 > If a servo retries the same ADJ_SETOFFSET delta after that error,
 > wouldn't the delta be applied twice?

Good point. Once WR_NEXT_1HZ is latched the write is committed and
reporting an error risks double-application. Will drop the trailing
tod_ready_wait() from tod_adjust() - every subsequent tod_* call
starts with its own ready_wait anyway.

 > Why is the item count here 8 rather than ZL3073X_MAX_CHANNELS?

Should be ZL3073X_MAX_CHANNELS for consistency with the other
per-channel page 5 registers. Will fix.

 > regs.h is otherwise one section per hardware page in ascending page
 > order ... Could the phase step defines go into the existing
 > "Register Page 9, Synth and Output" section instead?

Agreed, will merge into the existing page 9 section.

 > The value column of the new ToD command defines does not line up with
 > its neighbours

Will align.

 > the kernel-doc of zl3073x_chan_state_fetch() ... no longer mentions the
 > added ZL_REG_OUTPUT_STEP_TIME_MASK read.

Will update the kernel-doc.

Ivan


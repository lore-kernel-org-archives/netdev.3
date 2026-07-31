Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E231714B
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515019; cv=none; b=sH/qBmfYEnFdIbNtIWQq+E1HHkovX2An2uyfFACFpEiv00trTRcnGsFg7n0Fg71AZ0v1pc85WyX8HN5Oop6VJBtNO/xkb0vctgXMNYgsd01tJ3VI+7v9JN+Jo7VmaJS40iWBH4kvPKlyJ4C4seCtKepvzkPM57dvO4APG5r0AdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515019; c=relaxed/simple;
	bh=eZfWFgX/f0ZijcToz6G/tsXHbupH+mczotaSXjdDLkA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5vaM8Mmfpn7InOKUzMJ2qS2XJtxKeQeMdRCbBaJw97WNnP7h7T2fQaFUCN1ZM2lf8SOpX8HX/EvQv/921gYJ11/2rZL9n57pN9B1BpAOx9h60O8IeJf2LDXc8bkRmZ/YkVb0ckUavNJsQjJMO0IDgDaetGM/OSh/05VpOvgwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS95cLpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS95cLpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785515013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZfWFgX/f0ZijcToz6G/tsXHbupH+mczotaSXjdDLkA=;
	b=cS95cLpyM+lmDj3NUbwMGE27YNHzZhycD//fIhRbkcIyO8lSUUP3snNKEIdBttb+IFFb1C
	Ut7lf5UUo+kSiqmcyDBGUk9K5eVoWUVDgyGrgcxVps1DVttT4T/UbVKzq3/7g5rFYBJ7mI
	tPgh5jWYhiFK1v0SlKd8E8cb8BHkiBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-q1befVfVM9muiMwevabm-Q-1; Fri,
 31 Jul 2026 12:23:32 -0400
X-MC-Unique: q1befVfVM9muiMwevabm-Q-1
X-Mimecast-MFC-AGG-ID: q1befVfVM9muiMwevabm-Q_1785515010
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 298AB180044F;
	Fri, 31 Jul 2026 16:23:30 +0000 (UTC)
Received: from [10.44.32.30] (unknown [10.44.32.30])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5610242A;
	Fri, 31 Jul 2026 16:23:26 +0000 (UTC)
Message-ID: <b9175d00-7580-45d0-95f2-325f19a9aa89@redhat.com>
Date: Fri, 31 Jul 2026 18:23:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] dpll: zl3073x: add PTP clock support
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
 <20260730132150.371376-4-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260730132150.371376-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Replies to Sashiko's findings:

 > Is a hard dependency on PTP_1588_CLOCK required here?
 > ...
 > Would "depends on NET && PTP_1588_CLOCK_OPTIONAL" work instead?

This was changed from OPTIONAL to a hard dependency at Jakub's
explicit request in v2 review [1]. His rationale is that OPTIONAL is
meant for NICs where PTP is truly a side-feature, while this is a
dedicated DPLL/PTP device. Non-PTP chip variants simply skip PTP
clock registration.

[1] https://lore.kernel.org/netdev/20260727125921.2e16bed9@kernel.org/

 > does the kernel-doc match the implementation?
 > The body has a third gating condition ... zl3073x_chan_is_out_stepped()
 >
 > Can two perout channels end up aliasing the same physical output?
 > ...
 > Related: for single-ended N-divided formats, is the P-pin channel
 > usable at all? ... out.esync_n_period ... truncates to 0
 >
 > Is reporting success for a disable request that does nothing the
 > intended behaviour?
 >
 > How are the two userspace interfaces that can now program this output
 > pin meant to coordinate?

Will drop perout from this series entirely. The current pin-based
design has the P/N aliasing and N-divided truncation issues you
identified, and the disable path needs rework to use the hardware's
glitchless stop mechanism (output_ctrl stop bit). Will rework perout
as a follow-up with an output-based design: one perout channel per
physical output, eligibility checks in the enable callback, proper
stop/start via output_ctrl, and output divisor restore on disable.

 > Does settime64 need to compensate for the next-1 Hz load latency?

This is a known hardware characteristic. settime64 is used for large
absolute time sets (boot, initial synchronization) where sub-second
precision is not critical. The PTP servo uses adjtime/adjphase for
fine control, both of which handle the 1 Hz boundary correctly. This
matches the behavior of other I2C/SPI-attached PHC drivers (e.g.
ptp_clockmatrix) that have the same HW constraint.

 > Can delta * synth_freq overflow s64 here?
 > For delta == S64_MIN the negation wraps, so abs() returns S64_MIN

Real bug. abs(S64_MIN) is undefined behavior and wraps to S64_MIN
on two's complement, bypassing the >= NSEC_PER_SEC split. Will add
an explicit guard at the top of adjtime.

 > Should a partial phase step really report success?
 > ...
 > There, clock_adjtime(ADJ_SETOFFSET) reports success while up to
 > ~999 ms of the requested step was never applied.

This is intentional. The seconds part is already committed via ToD
read-modify-write and cannot be rolled back. Reporting an error
would cause the PTP servo to retry the full delta, applying the
seconds adjustment again. The sub-second residual self-corrects in
the next servo cycle. A dev_warn is emitted so the condition is not
silent.

The same reasoning applies to the partial phase step case: the ToD
counter and some output groups are already stepped, so reporting
success with a warning is the lesser evil compared to a retry that
doubles the seconds adjustment.

 > Does first_synth_freq match what the comment describes?
 > ...
 > On a multi-channel device those can be different synths

The code is correct - first_synth_freq is the lowest-ID synth
assigned to this DPLL channel, which is the one the firmware uses
for the ToD-only conversion. Will clarify the comment.

Regarding the empty output mask with tod_step: this is a documented
firmware feature. When output mask is 0 and tod_step is set, the
firmware steps only the ToD counter using the first assigned synth's
clock period for the cycle-to-time conversion.

Thanks,
Ivan


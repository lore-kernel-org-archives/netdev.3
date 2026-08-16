Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225119F12D
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891994; cv=none; b=Hsn0o9S/8GsHmH/WkU5UskjvIWC1LTFL0HwMnNJMElLJXwdC+hc46e3gV2pyn4quvrbDTi6C30qKtglBs88xjiVqgjQgRDxW1BejqWt0WgdmPBCwf/E6QALEY6GTZ51SjI90orrDthAHP2LAWv9ttha5yeBi4X478a2FBtR3nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891994; c=relaxed/simple;
	bh=wEx4fANkxRRtgYenpOZ0xcjGTWeExckZFkVEsEHq1Rg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=prvzB33QJBcxmF9H0aG1A+8R1eRZwMR5bSEYHWYfvhi0u/bibvaMwlMBSSvVsQmz1aB9ZzlEeOp7Wx5NG2TQ9r4Oy+O6byiPpA2jQ3RvNF3dO0JVMLDQeilVgyjjgY4elgxldTzyQg1ngUJEl/UBGCBDf2QtiySoIQwIKkKRnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/xMKIgi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/xMKIgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786891992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEx4fANkxRRtgYenpOZ0xcjGTWeExckZFkVEsEHq1Rg=;
	b=U/xMKIgiOvj5g62nWs/pGl2AGpv4XewuyPYwWr93SElDJmkTilfJfs7V2SuYfXL4vLqJMa
	EYiv6/ENyMqIUqpehFUoaq9KYTWhn56ecFus9CPe4WQOcqS7frAXE3FkE/cm/sOpC4vYt9
	PbXr4LcWonhyKU6bfNaqglINjETblO0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-U9jkqVAzNw6bEY7oRaUVVg-1; Sun,
 16 Aug 2026 10:53:02 -0400
X-MC-Unique: U9jkqVAzNw6bEY7oRaUVVg-1
X-Mimecast-MFC-AGG-ID: U9jkqVAzNw6bEY7oRaUVVg_1786891981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A6A3180028A;
	Sun, 16 Aug 2026 14:53:01 +0000 (UTC)
Received: from [10.44.48.13] (unknown [10.44.48.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91BD61800346;
	Sun, 16 Aug 2026 14:52:57 +0000 (UTC)
Message-ID: <7be0d9cb-7dc9-4ea5-91e8-d67ead2839c6@redhat.com>
Date: Sun, 16 Aug 2026 16:52:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/3] dpll: zl3073x: add PTP clock support
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Chris du Quesnay
 <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260814082656.306534-1-ivecera@redhat.com>
 <20260814082656.306534-4-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260814082656.306534-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sashiko comments with my replies:

 > Should PTP_1588_CLOCK be a hard dependency here?

Yes. This was explicitly requested by Jakub in the v2 review [1].

[1] https://lore.kernel.org/netdev/20260722135848.2d401ada@kernel.org/

 > Does settime64() need to compensate for the deferred ToD load?
 > [...] does this leave the clock up to a second behind the requested
 > time on every clock_settime()?

settime64 is a coarse "slam the clock" operation. gettimex64() does
not return stale values — it calls tod_ready_wait() which blocks
until the pending WR_NEXT_1HZ completes. The PTP servo handles any
residual offset in subsequent adjtime calls.

 > Also, ts.tv_nsec is written raw. If a caller passes a non-zero
 > tv_nsec, does the ToD second boundary end up displaced from the
 > DPLL 1 Hz / output 1PPS phase?

Yes, a non-zero tv_nsec displaces the ToD second boundary from the
1PPS edge. This matches the hardware behavior — settime64 sets
the ToD counter to whatever value is requested. Phase coherence
between ToD and outputs is maintained by adjtime which routes
sub-second adjustments through phase step or TIE write.

 > Is this error return reachable after the seconds are already
 > committed? [...] Does the caller then get a failure for an
 > adjustment whose seconds part is already applied?

If tod_ready_wait fails, we cannot be certain that WR_NEXT_1HZ was
actually applied. Returning the error is the safer choice — masking
it would silently report success when the adjustment may not have
been applied at all.

 > Does the same pending WR_NEXT_1HZ hazard exist across callback
 > invocations? [...]
 > Would calling zl3073x_chan_tod_ready_wait() unconditionally before
 > the phase step / TIE write cover this?

Phase step and TIE write operate on independent hardware blocks
(output phase adjustment and DPLL input phase respectively) and do
not conflict with a pending ToD write. Any subsequent ToD operation
goes through tod_ready_wait which waits for the pending write to
complete. The cross-callback sequence described (settime64 followed
immediately by adjphase) does not occur in practice — these are
fundamentally different operations used at different stages of PTP
clock management.

 > zl3073x_dpll_alloc() and zl3073x_dpll_free() are moved verbatim
 > [...] Could it be dropped or split into a separate
 > no-functional-change patch?

The move is needed because the new PTP registration helper
zl3073x_dpll_ptp_register() must be defined before
zl3073x_dpll_alloc() which references ptp_info. Splitting this
into a separate patch was done in v3 at Jakub's request but was
squashed back when the refactored helper was dropped along with
perout support.

Thanks,
Ivan


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE73321A2
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025819; cv=none; b=P84fwse8pICOBWJouTE9vIuf597rQI1HGqeT0jpYDgBvWESSolvpjFoe6UJR+wCrcKsQds8ESh8+wcP9C6K7EdeBScYg55fK9/KTscXph0ChGB3HnEm5VITIsCznyqK03qXbJlmgsH2qO+TXFs52fBD8k5GII0cKKQbKLaN7iFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025819; c=relaxed/simple;
	bh=f63s5PNmjoIMbJJl64IcPFZQnQp36WdlKBpR00TZkdI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fsYviKtsYtBdiXA2Sng8ss/cevSDiU4miicubv1v6aFeMeIB5xgdIruaCnYrps+B/d72Nin4R+okYdHkkdBSV8r6s2XB3w1PtjMe6M1M+RcRyeIx1WxCDCKCpmPejMtFJVQ1YGWwBA4tbL7SiEeWpEn5lQoNdnUnPESyWNMFg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nz7smOTx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz7smOTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786025817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6cTxNBhBd5FGLMHGggNl1htRb7ff0y/rb4fu34/dVs=;
	b=Nz7smOTx7LD1OFkFwccm+JUT7UTaNpw6YEXGV2+DEC32R1vmz0eivJgiviysH7E3yVPI7Q
	pxA4VH84RBxxnBOHUK93JMRSLME8BW7xGjfJsCIPLi1XneDAkGGwNQZ4n7DQDskjPWC+Ne
	FhxnESGRlEmQWvYRlymfCFXMJvPy1G8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-232Y23oZO6OSrRdJvF6zwQ-1; Thu,
 06 Aug 2026 10:16:51 -0400
X-MC-Unique: 232Y23oZO6OSrRdJvF6zwQ-1
X-Mimecast-MFC-AGG-ID: 232Y23oZO6OSrRdJvF6zwQ_1786025808
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B2918001E3;
	Thu,  6 Aug 2026 14:16:48 +0000 (UTC)
Received: from [10.44.33.193] (unknown [10.44.33.193])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D40E1956049;
	Thu,  6 Aug 2026 14:16:44 +0000 (UTC)
Message-ID: <c8af201a-c610-42fe-8941-b90da2d13664@redhat.com>
Date: Thu, 6 Aug 2026 16:16:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] dpll: zl3073x: add channel ToD, phase
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
References: <20260803140637.102339-1-ivecera@redhat.com>
 <20260803140637.102339-2-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260803140637.102339-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sashiko findings with replies...

 > zl3073x_poll_zero_u8() hard-codes the interval:
 >
 > #define ZL_POLL_SLEEP_US 10
 >
 > so the new timeouts [...] all wait at a 10 us cadence. [...] giving on
 > the order of 10^5 bus reads while waiting out a WR_NEXT_1HZ command
 > [...]
 > Would a millisecond-scale interval variant be preferable for these
 > three cases, so the shared bus and the driver's monitor kworker are not
 > starved for up to a second?

Good catch. I did some testing and found that even the existing
registers typically clear within low hundreds of iterations, so the
fixed 10 us sleep is already unnecessarily aggressive for all callers.

I will add a prep patch that replaces the fixed ZL_POLL_SLEEP_US with
timeout_us / 50 in zl3073x_poll_zero_u8(). This scales the sleep
interval proportionally to the timeout, targeting ~50 iterations
regardless of timeout magnitude:
   - existing 30-50 ms timeouts: 600-1000 us sleep
   - new 1000-3000 ms PTP timeouts: 20-60 ms sleep

 > Can the tick-crossed branch skip the 20 ms rollover guard and shift the
 > applied time by one second?
 >
 > The margin test is gated on !diff.tv_sec, so when the 1 Hz tick crossed
 > between the two zl3073x_chan_tod_read() calls only the seconds get 
fixed up
 > and the remaining margin is never compared against threshold_ns [...]

Good point. Although this requires ~1 s delay between two consecutive
register reads (practically unreachable), the fix is clean and costs
nothing. I will restructure the guard to separate the tick-crossing
fixup from the margin check so both apply independently:

     diff = timespec64_sub(ts_next, ts_cur);

     if (diff.tv_sec < 0)
         ts_next.tv_sec -= diff.tv_sec;

     if (diff.tv_sec <= 0 && diff.tv_nsec < threshold_ns) {
         fsleep((unsigned long)diff.tv_nsec / NSEC_PER_USEC + 1);
         ts_next.tv_sec++;
     }

Thanks,
Ivan


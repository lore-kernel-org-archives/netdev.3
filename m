Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB842DC32C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451137; cv=none; b=Pl1SJKtd302QzyGIOkHMGyRzUPxU54u+vhGV1UNpFbVjC3+Hmxv/tKhf+tlCsw5nNHNYTYEc4O6uBKohEF4U56kAIPyq+d1JfuuxflUyAC+WyWpfvq24r5sqTVrrVC9lDjPPignCvCvJwVNCqX8ntvNQwvio9YgmLm2SfzJWzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451137; c=relaxed/simple;
	bh=ialVvxyjCVKcgb89/PzFSUBLWApaezqledsu4ls7L0I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JWOsHocTb0ARDKe96rRVtSf+Cyy0jcCcrDMR4FGg1sYwrJOorQlWjH6FNsgTCe1/eBnkX3Pa2+dkLGEJSRLoFtnjR+SiJi2Q3Oa3MixS8IpuMfpnRnvv2+axzEdZT2AQ/X36Ngkdvt0wz+qmArSw5KyT8IQo2ybW1dh3wHrTt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5Dv4g+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5Dv4g+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786451135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ialVvxyjCVKcgb89/PzFSUBLWApaezqledsu4ls7L0I=;
	b=V5Dv4g+Fzrc+jZVMu4tRapDxpygn1UM9GYKK7GQUlUJqtEkRUcmLvHbXY/EbXVkPNJZVT+
	3+SMcQHXIXqUckW0lz0Xy8YdUrikY7X4s6M5c+ygOcod0fc0Zaz/UmZvtTK4hv/K5L+D2a
	EKQXGFwDMcPlYoPhJYNviGsRuSH2b2w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-gpUd9JUhNmebUvTeI1oRpw-1; Tue,
 11 Aug 2026 08:25:28 -0400
X-MC-Unique: gpUd9JUhNmebUvTeI1oRpw-1
X-Mimecast-MFC-AGG-ID: gpUd9JUhNmebUvTeI1oRpw_1786451127
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D933B19560B4;
	Tue, 11 Aug 2026 12:25:26 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 999BC1800346;
	Tue, 11 Aug 2026 12:25:23 +0000 (UTC)
Message-ID: <a16ae174-5e15-415f-9858-e9ad7b4bef26@redhat.com>
Date: Tue, 11 Aug 2026 14:25:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] dpll: zl3073x: add PTP clock support
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20260809182340.1081610-1-ivecera@redhat.com>
 <20260809182340.1081610-4-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260809182340.1081610-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sashiko findings and my replies:

 > Is the hard dependency on PTP_1588_CLOCK intended here?

Yes. This was explicitly requested by Jakub in the v2 review [1].

[1] https://lore.kernel.org/netdev/20260722135848.2d401ada@kernel.org/

 > Does the requested timestamp need compensation for the 1 Hz latch
 > here? [...] gettimex64() keeps returning the old time until that
 > edge

gettimex64() does not return the old value. It calls
zl3073x_chan_tod_read() which starts with zl3073x_chan_tod_ready_wait().
If a WR_NEXT_1HZ from a previous settime64() is still pending, the
wait blocks until the 1 Hz edge applies it, and the subsequent read
returns the new value. So the written timestamp is applied accurately
at the edge with no drift to compensate for.

 > What state is the hardware left in on this path? [partial phase step
 > failure returns 0]

This is intentional. At this point the seconds and the first synth
group (with ToD) have been committed. Propagating the error would
cause the PTP servo to retry the full delta, applying seconds a
second time — a much worse outcome than a sub-second skew on some
outputs. A regmap/bus error at this stage indicates a serious
hardware problem that dev_warn() surfaces appropriately.

 > zl3073x_dpll_ptp_adjtime() documents "Return: 0 on success, <0 on
 > error", yet it returns 0 with rc != 0 when the seconds were already
 > committed [...]
 > Could these blocks spell out that 0 does not imply the requested
 > adjustment was fully applied?

Good point. Will update the kernel-doc to document the partial
success semantics.

 > Should sec_adjusted be set right after the successful
 > zl3073x_chan_tod_adjust() rather than after the wait?
 >
 > Once zl3073x_chan_tod_adjust() returns 0, the WR_NEXT_1HZ command has
 > been accepted and the firmware will latch the seconds at the next
 > 1 Hz edge; the driver cannot cancel it.

If tod_ready_wait fails, we cannot be certain that WR_NEXT_1HZ was
actually applied — the semaphore timeout means we do not know whether
the hardware committed the seconds or not. Returning the error and
letting the caller handle the retry is the safer choice.

 > Does the template need to be copied here [in alloc], or in
 > zl3073x_dpll_ptp_register() just before ptp_clock_register()?
 >
 > ptp_clock_register() writes into the driver-owned struct
 > ptp_clock_info [...] On the second registration the leftover
 > getcycles64/getcyclesx64 pointers [...]

Good catch. Will move the template assignment from
zl3073x_dpll_alloc() to zl3073x_dpll_ptp_register() so that
ptp_info is always fresh before each registration.

 > Sub-second PTP adjustments can be overwritten by pending hardware ToD
 > writes from previous API calls.

The PTP callbacks are serialized by zldpll->lock. A pending
WR_NEXT_1HZ from a previous settime64 or adjtime call is consumed
at the next 1 Hz edge. Any subsequent ToD operation goes through
tod_ready_wait which waits for the pending write to complete. For
phase step and TIE write: these operate on independent hardware
blocks and do not conflict with a pending ToD write.

Thanks,
Ivan


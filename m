Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9830C366
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021705; cv=none; b=YgyX0p/GL0j6B7yqGHNwJwOb2SxLdcv5T6G25DLAMnBuwnVfKmnNzwOeReNJ+sGi6sqlxv2bj6RgaDXeBKIm04q4r4yBSnsMicl/+/ljiOXNfgIo2fZdAPeTJBFunpW0baqJLSDr6Ow6C59L5bGlu5b/Ot1Bf0991Ma/gxmJmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021705; c=relaxed/simple;
	bh=RsFN4L8ImZTEDdhOF0qIQJ0feKc62Q+S4h7MLQJ4KIE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CSJnZ836+oxo293Zi5czlNj/mSSUvJIhGEIgjJl1syu9gdQLYgoJZH6sx7R3Yz0lDWnPw65g9OwJf4XXMsezoCEY18ylKSFEREsbDJnRd9OmaUyFGDNgglY1mhLCHyNE40aC2cOocj3HvhxUt4fUjbqjcZQizmG4RmTAq23Ql08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zxge1qj/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zxge1qj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786021701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Wf1DXbc9TbnFuiYMypKp/vkltfg2vTLeB/NDXh9BBw=;
	b=Zxge1qj/CqKVlDDNeERab86P67zOnEHD2sFb6K8ZIEb7BHQWhJ7GhDWDPArcMtnOtDhKBx
	ddhlrrg7xkXf2N+cg15jV8Kh0v441p/R/tdMXhRo6tiCQxyslLeo+tTNmsxJOlXLoVeAHa
	Y4hiVX8l5qJ+A+06aPYaSgKbCZu6Y/k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-b4gU9CpMMPyws3rsf62qaA-1; Thu,
 06 Aug 2026 09:08:16 -0400
X-MC-Unique: b4gU9CpMMPyws3rsf62qaA-1
X-Mimecast-MFC-AGG-ID: b4gU9CpMMPyws3rsf62qaA_1786021694
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DAA518CDD98;
	Thu,  6 Aug 2026 13:07:05 +0000 (UTC)
Received: from [10.44.33.193] (unknown [10.44.33.193])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32E6C1800347;
	Thu,  6 Aug 2026 13:07:01 +0000 (UTC)
Message-ID: <b2d3902f-2e93-4385-9749-976725424802@redhat.com>
Date: Thu, 6 Aug 2026 15:07:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dpll: zl3073x: update all DPLL channels
 on ref_sync_set
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260803120245.56046-1-ivecera@redhat.com>
 <20260803120245.56046-2-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260803120245.56046-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Replies to Sashiko findings:

 > Is this only a preparation change? ... Should this carry a Fixes: tag
 > so it gets picked up for stable?

It is preparation only. The old code is correct — the DPLL core's
xa_for_each loop calls ref_sync_set once per registered DPLL, and
since zl3073x registers input pins with every channel, each channel
gets its own callback invocation with the correct pin_priv. All
channels receive the priority update. The bug would only appear
after patch 2 removes the xa_for_each, which is why this patch moves
the iteration into the driver first.

 > Is the invariant in this comment accurate? ... 
zl3073x_dpll_pin_register()
 > reads them with no lock at all ... can a ref-sync DPLL_CMD_PIN_SET on
 > channel 0's pin enter the new loop and write zldev->chan[1].ref_prio
 > while channel 1's zl3073x_dpll_pin_register() is reading 
chan[1].ref_prio?

No race. dpll_lock is held across the entire dpll_pin_register()
call (acquired in dpll_core.c) and across the entire netlink
DPLL_CMD_PIN_SET handler (acquired in dpll_netlink.c). The device
startup loop calls zl3073x_dpll_register() -> dpll_pin_register()
for each channel under dpll_lock, and ref_sync_set also runs under
dpll_lock, so they cannot overlap.

 > Should the sync pin get a change notification for the other channels?

Good catch. Will add a sync_notify flag — set it when a channel's
priority is actually changed from non-NONE to NONE, and call
__dpll_pin_change_ntf(sync_pin->dpll_pin) after the loop if set.

 > Is the downgrade of this failure to a warning intentional? ...
 > The new comment calls the priority step advisory and "not fatal",
 > which reads as the opposite of the changelog statement that "the
 > priority update must cover all channels".

The ref sync pair configuration (zl3073x_ref_state_set) is the
essential operation whose failure is propagated. The per-channel
priority exclusion is a datasheet recommendation — the ref sync pair
functions regardless. Will align the changelog to say "recommended"
instead of "must". A mailbox failure here would indicate a serious
HW/bus problem that would surface through other error paths.

Thanks,
Ivan


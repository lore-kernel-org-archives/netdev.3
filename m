Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743651CF79
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864702; cv=none; b=eSLFjz7Vcs2212cS7Q4Mng19uwXwrddFlYlWQBB/b7241tFQMts6Mcsy+kJCHT0ASUQG4IRgLwPoaQbgxUzYp7k1BUD1YI2VfBc0z3IZmL065B7WWweXpNTAi55c09fautgE+HlGdy99t7mAjZ6j7aXCT1mfIoMYM1XENkcKMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864702; c=relaxed/simple;
	bh=/xcTDSWCbk5pM7p8qnK/WVZeRS08djZx8bVhdbQBd5Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VLqdu+ePlK/mmcoDJvZiED1ccjirup3Ehi2zuBPD2NcTs+bjSIqZMPrm+rXOq4matcdROK8KkdAcRnLPe0urLYhN4HGtMcglTKw+qf3hKghzZZdKYOxjVDBOITOc4Nylj7T96eiw93kfQfLBsoS+ZWN55wcHNWddkNDFXSCz3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWjGygEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWjGygEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790864692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4H73h7S4dMjm2zegNZZAD/L3qe6gjYIfZH1lraT+3GI=;
	b=NWjGygELt12MSXfycjCljneXMM7Bv7hCGTcXVTulu+2UtM7q58zLPl3YWsW+5GGIqI+vkW
	COtDi22NFZuKdXFNSkjGTsi7/KU2wKL1/aljN06qmPojc2oyOP165KtY2dkSlcmhppCWi1
	k1PvPanNswixB0Z5lJ2tEwmc0sl7wk8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-cDH3BM9aNtmR88XyREtwGw-1; Thu,
 01 Oct 2026 10:24:49 -0400
X-MC-Unique: cDH3BM9aNtmR88XyREtwGw-1
X-Mimecast-MFC-AGG-ID: cDH3BM9aNtmR88XyREtwGw_1790864688
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF491193611A;
	Thu,  1 Oct 2026 14:24:47 +0000 (UTC)
Received: from [100.90.87.156] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30E9630000E4;
	Thu,  1 Oct 2026 14:24:44 +0000 (UTC)
Message-ID: <8c609bc7-be81-4498-8612-3a8f3b4a2401@redhat.com>
Date: Thu, 1 Oct 2026 16:24:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] dpll: zl3073x: add PTP periodic output
 support
From: Ivan Vecera <ivecera@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Min Li <min.li@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, Petr Oros <poros@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260928185552.1103515-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260928185552.1103515-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 9/28/26 8:55 PM, Ivan Vecera wrote:
> This series extends the zl3073x output pin support and finally adds PTP
> periodic output (perout) support on top of it.
> 
> Each zl3073x output exposes a P-pin and an N-pin that share a single HW
> output and most of its configuration registers. Patch 1 makes a change
> requested on one pin notify the sibling pin as well, so userspace on the
> sibling is told when its effective frequency, esync or phase adjustment
> changed.
> 
> Patches 2 and 3 add the plumbing to control an individual output pin:
> GPO override registers and a clean stop/restart of an output (patch 2),
> and then per-pin enable/disable through the state_on_dpll_get/set
> callbacks - differential pins via the output stop condition, CMOS pins
> via the GPO override bracketed by a glitch-free stop/restart (patch 3).
> 
> Patches 4 and 5 are preparatory: the per-pin 'esync_control' boolean is
> replaced by an extensible 'caps' bitmap, and the divisor/N-division
> computation is factored out of frequency_set() into a helper that
> updates a struct zl3073x_out without committing it.
> 
> Patch 6 registers a PTP periodic output pin for each output pin that
> supports step-time and declares 1 PPS support in firmware. Any perout
> channel can be assigned to any such pin; only 1 PPS is supported.
> Enabling a channel programs its pin for 1 Hz and connects it, disabling
> disconnects it, reusing the helper and connect/disconnect primitive
> introduced earlier in the series.
> 
> Ivan Vecera (6):
>    dpll: zl3073x: notify sibling pin when shared output config changes
>    dpll: zl3073x: add GPO support for output pins
>    dpll: zl3073x: allow enabling/disabling output pins
>    dpll: zl3073x: consolidate pin capabilities into bitmap
>    dpll: zl3073x: factor out output pin frequency helper
>    dpll: zl3073x: add PTP periodic output support
> 
>   drivers/dpll/zl3073x/core.c | 117 ++++++++
>   drivers/dpll/zl3073x/core.h |  30 ++
>   drivers/dpll/zl3073x/dpll.c | 539 +++++++++++++++++++++++++++++++-----
>   drivers/dpll/zl3073x/dpll.h |   4 +
>   drivers/dpll/zl3073x/out.c  |  50 +++-
>   drivers/dpll/zl3073x/out.h  | 138 ++++++++-
>   drivers/dpll/zl3073x/prop.c |   2 +
>   drivers/dpll/zl3073x/prop.h |  21 ++
>   drivers/dpll/zl3073x/regs.h |  20 ++
>   9 files changed, 834 insertions(+), 87 deletions(-)
> 
> 
> base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d

Hi Jakub & Paolo,

I would like to send the v2 series but now it depends on two bugfix patches
that were submitted to 'net' as

https://lore.kernel.org/netdev/3c4e8106-83d0-4c1c-a3bd-8d9343d2d557@redhat.com/T/#m0caa2ce66da8213c8594bce7d0ff55baeafeee05

Without them the v2 is not applicable to net-next...

Can I include these 2 patches into v2 so they will be present on both net and
net-next? Or how to proceed in this situations?

Thanks,
Ivan


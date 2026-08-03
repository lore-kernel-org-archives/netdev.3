Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C63E5A38
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757902; cv=none; b=pqoziWjoLye7p/dzn2WLhWQ+UcPdZOVY6GOLWM976vTudjuQVOEofX4jjydNQmtWw7n7ppdMDc4JFqs36ibbz1EPt6O+vnJxmdLaRZhYbh9fu5OcFtClGcXwNODxf54AoTj8CJfS0CMIayi6SjUd3MH7s1Cjbn7mq2GxDxgnHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757902; c=relaxed/simple;
	bh=Gt4TTDkgbjgDqdzkkX8XFlaBL23bU2EzA0Ftl8TbBTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OArsBC2dhRWwUMdu9aAadHqMH3xQ2MUBNO3Lv59Gk1+0C02kKb9htsSjUIRxtofPXkOaKlYaFitZL+e8EtSITsoFaWB91e+KSN4nmQPLSeZ/rIczhBQeNdE5ty+b2EPsHoGLzCx7pODdz4LSJnwCJFOD3oJanqUML4vxn+yMXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PThF+Nns; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PThF+Nns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785757899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUAOQMzjYiynO138/0Rtw/7oG5P6xr2MxjpkKxKIOJU=;
	b=PThF+NnsO+ytPGtvFk/71i2SCQhHLiBv874eWs1icyWe7ryrxWbr0GVmEVMI67c2AlSLqB
	3W/FFnuxAB6l71vgAP8Jz2i1aVkmOBJUm5aXxDCFX/ZeLM7XdZK8j3+M9/gGbbE3Wf6HC0
	UgpondmPf7m5mJckgaYioAPgrsW4anc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-8IXOUgSANjC1aCqnaXoGtA-1; Mon,
 03 Aug 2026 07:51:31 -0400
X-MC-Unique: 8IXOUgSANjC1aCqnaXoGtA-1
X-Mimecast-MFC-AGG-ID: 8IXOUgSANjC1aCqnaXoGtA_1785757889
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EB5619560AA;
	Mon,  3 Aug 2026 11:51:29 +0000 (UTC)
Received: from [10.44.33.235] (unknown [10.44.33.235])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A357E414;
	Mon,  3 Aug 2026 11:51:25 +0000 (UTC)
Message-ID: <760d9664-14f6-4cf8-af55-699ea3021b47@redhat.com>
Date: Mon, 3 Aug 2026 13:51:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dpll: zl3073x: add ZL30643 chip support
To: Vincent Jardin <vjardin@free.fr>
Cc: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
 <20260724-for-upstream-zl30643-v1-2-ea93ba4d85c8@free.fr>
 <4CCA3CCC-C687-4658-8ACD-BC0CB3294A39@redhat.com>
 <amuE9yIaBsFSgRhL@L30177.local>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <amuE9yIaBsFSgRhL@L30177.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 7/30/26 7:08 PM, Vincent Jardin wrote:
> Hi Ivan,
> 
>> Hi Vincent,
>> I'm not sure that all driver's functionality is supported by ZL3064x. Did you test everything?
>>
>> I need to check datasheets for this chip models, maybe some device flags will be needed.
> 
> I checked both datasheets. They are the same registers:
> 
>    - the register descriptions are verbatim identical
> 
>    - same chip-ID encoding (base / A +0x1000 / B +0x2000 / 7x7 +0x8000)
> 
> So ZL_CHIP_INFO(0x0E3B, 3, ZL3073X_FLAG_REF_PHASE_COMP_32) is correct
> and no new device flag is needed: the ref-phase mechanism the flag
> governs is identical between the families.
> 
> The only differences seem to be non-register related: line card vs
> central system and the min input-frequency spec (1 kHz vs 0.5 Hz).

Hi Vincent,

Yes, minimal reference frequency for zl3064x is 1000Hz and also
supported bandwidth range is different (not relevant now).

So, we need to
- add new field into zl3073x_chip_info that will describe minimal input
   reference frequency
- add a check into zl3073x_pin_check_freq()

Let me know if you want to do it yourself or if I should do it (I would
send it along with your two patches).

Thanks,
Ivan


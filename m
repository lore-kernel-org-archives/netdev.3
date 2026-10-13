Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB73F485E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884156; cv=none; b=dovKaSEGGw8sZmNosKKsE/vnG/kR1etdlNSckLPxL6pMdaUlEAs/UCyd16AYE0UtLQKbtHV8krWAHd6qfENK3wgOHe4d9wSV+T6vw+lCsypsnxIEmmplxUkpDIVirDKkgc5sKY5gxWcuMIRMKnPqGqILyzJfhjWeCl6eoe9MnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884156; c=relaxed/simple;
	bh=qSkGUohML2p/xeSbT4MWkS/eFydJi+duS3OhUaoaXUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDZiTyMkIDDXhfWIk4FFzlosikH3j+Wm6ed+r4Z0EW55gGZwGFV3CShNfPc7+GIilk5zxF9oBCC/sciHTRi4Ln4zH9zg8QTug1aHrL7nf5kGNRHdAAPoOM4WOTGiy98IIVrfqUNPuE4NSAbdRlbp5XvUdrw0eT3Q6YDAe7aKyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBTUPoxh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBTUPoxh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791884154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymRVYAINTCGe65FkaCIpcmD55uZ5dvwqAGaT9G+s7bI=;
	b=dBTUPoxhpmcapQvY3f2SPJFH5VJbuhxutRyoes30JqZI85qpV+RFp6ojVoozXiPUeM9uN5
	WqMedBmnPZ1XKyzSKkWXffzDCIZEOxrCDFBSiwUyY5u07WUwWDSHGSooWmhgH7fix3ryuf
	bdLaPr4RtY9L1KE+TyxcGT+7p37+sRg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-pU5W5lYsM7q3g9VjC4EBpQ-1; Tue,
 13 Oct 2026 09:35:49 +0000
X-MC-Unique: pU5W5lYsM7q3g9VjC4EBpQ-1
X-Mimecast-MFC-AGG-ID: pU5W5lYsM7q3g9VjC4EBpQ_1791884147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8F7C180133A;
	Tue, 13 Oct 2026 09:35:46 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C1FD1956086;
	Tue, 13 Oct 2026 09:35:43 +0000 (UTC)
Message-ID: <ce4b7f56-70c6-4436-a453-91fdc13ef634@redhat.com>
Date: Tue, 13 Oct 2026 11:35:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/12] dpll: sit9531x: register DPLL devices
 and pins
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-6-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-6-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Register each of the four on-chip PLLs as a DPLL device, and the crystal
> that feeds them as a pin on each.  The inputs and the outputs need a
> state callback the core insists on before it will take a pin, so they are
> registered by the patches that add theirs; what this patch builds is the
> device, the pin machinery around it, and the one pin whose state never
> changes.
> 
> The callbacks a device needs from the start come with it -- lock status
> and the operating mode -- along with the direction of each pin.  The rest
> of the pin operations follow in later patches.  The device selects its
> reference by priority, so automatic is the one mode advertised.  A
> profile that sets manual active select is still reported as automatic,
> since nothing in the driver drives a manual selection, and probe warns
> about it.
> 
> Both need somewhere to read from.  The chip reports its state across
> several pages, and a netlink call must not turn into a burst of I2C
> transactions, so a kthread worker polls the interesting registers twice a
> second into a per-input and per-PLL cache, and the callbacks answer from
> it.  Output state is not polled: it changes only through a request, and
> the getter reads the device again when one could not be confirmed.  The
> same tick compares the new state against the old and notifies the core
> only on a change; the first tick takes the baseline.  Where a board wires
> INTRB, the interrupt schedules that tick immediately rather than
> replacing it: the poll stays as the fallback, since this device gives no
> way to be sure an edge was not missed.
> 
> Which PLL drives an output is read from the PLLs' output-enable masks,
> which PLLC and PLLD keep in mirrored bit order.  An output two masks
> claim goes to the first PLL, with a warning.
> 
> The clock_id that keys a device in the DPLL core is built from the SiTime
> OUI and the part's position: sixteen bits of the I2C bus number and the
> address.  Bus numbers are not bounded by the number of adapters -- a DT
> alias or a mux child can number a bus 256 or above on a board with a
> handful of them -- so the bus gets the width; the variant needs no field,
> since one address on one bus holds one part.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   drivers/dpll/sit9531x/Kconfig  |    4 +
>   drivers/dpll/sit9531x/Makefile |    2 +-
>   drivers/dpll/sit9531x/core.c   | 1763 ++++++++++++++++++++++++++++++--
>   drivers/dpll/sit9531x/core.h   |  258 ++++-
>   drivers/dpll/sit9531x/dpll.c   |  411 ++++++++
>   drivers/dpll/sit9531x/dpll.h   |   68 ++
>   drivers/dpll/sit9531x/regs.h   |  259 ++++-
>   7 files changed, 2671 insertions(+), 94 deletions(-)
>   create mode 100644 drivers/dpll/sit9531x/dpll.c
>   create mode 100644 drivers/dpll/sit9531x/dpll.h
> 
Reviewed-by: Ivan Vecera <ivecera@redhat.com>


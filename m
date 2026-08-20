Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14E476CED
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248689; cv=none; b=awS2xxeI06iCj2rxkbUajw5NalbwZU8Dh0U916vEKX4Hj1afCug+B5HlqhCbqBNqbw7Nqk7kJgMzmmjAgZDY4KWCRKW3qsPEStQB3atqMH+P5TIjrNHxeuX4L++aCnw0pP5kOY0506YByraEGEg47awxsI5eWuXF7VTehTk4rU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248689; c=relaxed/simple;
	bh=dBUILXeDbLgCpqIojDaWLeWOsHEzHE/OpBXGS1CLw2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srpsyj5mQGlChzLnGVp0yUUFxIGN09V8ZPRoPKDu2hDUAO3RGExs1Tyo05koI1XetXKM93cs+4zGScSuOXS12y2kJJ9FAGoErdbQ2eiCJYC9fo+J46oDWTMObz39EcPaZCzBHm3RZLDucu4oalp2mAgIiL7CBxgCddWnrfEy3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdKx4pyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdKx4pyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787248683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDjB7NM2e+ReWvVEfnrpGhzlkQza1sURMIB/MgF4wuA=;
	b=QdKx4pyPpfruLciE8JV+LgvX1bE5oAr9bTgW2vIp/x9fOsRjJiMN5noP4F1iPNI3kGXKZf
	Qe7I87IY2omrN36ZdgKyOdwsjE6NrUzaiViIqMxVrIQqyyxC5F2Razmw0Jt1Op/crts49D
	U0hIxis/zr4MxK7c7w7OzBCPCngr478=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-I3uzaMH_OgiVAnRGcbX0kA-1; Thu,
 20 Aug 2026 13:57:46 -0400
X-MC-Unique: I3uzaMH_OgiVAnRGcbX0kA-1
X-Mimecast-MFC-AGG-ID: I3uzaMH_OgiVAnRGcbX0kA_1787248652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435B1195608B;
	Thu, 20 Aug 2026 17:57:32 +0000 (UTC)
Received: from [100.90.87.156] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC3253002D26;
	Thu, 20 Aug 2026 17:57:28 +0000 (UTC)
Message-ID: <1ab30a5b-6c55-4a3a-8e6d-d94c6a64aa87@redhat.com>
Date: Thu, 20 Aug 2026 19:57:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
To: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260815221919.64226-4-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/16/26 12:19 AM, Ali Rouhi wrote:
> Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
> clock generators. These devices provide low-jitter clock outputs
> commonly used in telecom, networking, and data center timing
> applications.
> 
> The driver exposes all inputs and outputs through the Linux DPLL
> subsystem, supporting:
>   - Lock status monitoring via register polling or optional INTRB IRQ
>   - Input priority management for automatic reference switchover
>   - Per-output frequency readback from hardware state
>   - Phase offset measurement via TDC (time-to-digital converter)
>   - Phase adjustment for fine output alignment
>   - Embedded sync (esync) pulse control on outputs
>   - Fractional frequency offset of the selected reference
>   - Optional reset-gpios for hardware reset
> 
> The driver reads all configuration from the device's on-chip NVM
> at probe time -- no firmware loading is required.
> 
> Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>   MAINTAINERS                    |    7 +
>   drivers/dpll/Kconfig           |    1 +
>   drivers/dpll/Makefile          |    1 +
>   drivers/dpll/sit9531x/Kconfig  |   17 +
>   drivers/dpll/sit9531x/Makefile |    4 +
>   drivers/dpll/sit9531x/core.c   | 3111 ++++++++++++++++++++++++++++++++
>   drivers/dpll/sit9531x/core.h   |  372 ++++
>   drivers/dpll/sit9531x/dpll.c   | 1232 +++++++++++++
>   drivers/dpll/sit9531x/dpll.h   |   69 +
>   drivers/dpll/sit9531x/prop.c   |  397 ++++
>   drivers/dpll/sit9531x/prop.h   |   39 +
>   drivers/dpll/sit9531x/regs.h   |  371 ++++
>   12 files changed, 5621 insertions(+)
>   create mode 100644 drivers/dpll/sit9531x/Kconfig
>   create mode 100644 drivers/dpll/sit9531x/Makefile
>   create mode 100644 drivers/dpll/sit9531x/core.c
>   create mode 100644 drivers/dpll/sit9531x/core.h
>   create mode 100644 drivers/dpll/sit9531x/dpll.c
>   create mode 100644 drivers/dpll/sit9531x/dpll.h
>   create mode 100644 drivers/dpll/sit9531x/prop.c
>   create mode 100644 drivers/dpll/sit9531x/prop.h
>   create mode 100644 drivers/dpll/sit9531x/regs.h
> 
> ...
> +	/*
> +	 * Convert to unsigned absolute delay.  Negative phase (advance)
> +	 * is rendered as T_out - |phase|, modulo the output period.
> +	 */
> +	if (phase_ps == 0) {
> +		abs_ps = 0;
> +	} else if (phase_ps > 0) {
> +		abs_ps = (u64)phase_ps;
> +	} else {
> +		u64 t_out_ps = div64_u64(1000000000000ULL, freq);
> +		u64 advance = (u64)(-(s64)phase_ps);
> +
> +		if (t_out_ps == 0)
> +			return -EINVAL;
> +		advance %= t_out_ps;
                        ^^^^
This causes build failure on 32bit systems... You could use something
like this:

    div64_u64_rem(advance, t_out_ps, &advance);

> +		abs_ps = (advance == 0) ? 0 : (t_out_ps - advance);
> +	}
> +
> ...
> diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
> new file mode 100644
> index 000000000000..5c3dbeefd86b
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/regs.h
> @@ -0,0 +1,371 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SiTime SiT9531x register definitions
> + *
> + * Copyright (C) 2026 SiTime Corp.
> + * Author: Ali Rouhi <arouhi@sitime.com>
> + * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> + */
> +
> +#ifndef _SIT9531X_REGS_H
> +#define _SIT9531X_REGS_H
> +
> +/*
> + * I2C register model:
> + *   - Page select register at offset 0x01
> + *   - Each page has 128 registers (0x00-0x7F)
> + *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)
> + */
> +#define SIT9531X_PAGE_SEL		0xFF
> +#define SIT9531X_PAGE_SIZE		0x100
> +#define SIT9531X_NUM_PAGES		32

The comment at the top of regs.h says the page select register is at
offset 0x01 and each page has 128 registers (0x00-0x7F) but the code 
defines it differently (selector at 0xff and page size 256).

One of them is wrong.

Thanks,
Ivan


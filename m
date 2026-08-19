Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03D37F8CC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174194; cv=none; b=CMNjIFv2aIIYp/t3fX1wryvlh5I/dxcr06mHHvl+HZ5lXkp4IBWSE0NX9sNnzGFc4hDHqV3Z1iPYP1ImPzWOmujFoFpBMsJjclTzjCDKzttc7TmUXFPm+H5aU40Ekh1vXhsnaX45oCZax9Mj3Onfp4qlMRElZDkwW9P7dTH6y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174194; c=relaxed/simple;
	bh=DQKnKfj15t5G/xxNfos2zBkkB/DcPAwgAfXZn2ydPuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kzz4E3deq6KvnbPGG2kWqsawOmut7aPZ1yBxfRm7durvR1BhRF1vqRHbVyGPZ3FJvQ6gZ9flMZJmubd+nan0eFQL8TIgrZq0LZ9XHUHqHstpYf95+V8sSqyh/npmUGjPA6wdrmxH3KiAFk2LeTytN/Y8OnM3XUkfckRlolDW9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPKwsMQr; arc=none smtp.client-ip=95.215.58.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPKwsMQr"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DQKnKfj15t5G/xxNfos2zBkkB/DcPAwgAfXZn2ydPuY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787174190; v=1; x=1787778990;
 b=hPKwsMQrG79xKXX/3/4NXh/oqZftiElvxNkiWmvUOdViBJWio2Bf9pft0cOpCHm0Igddsc7L
 2//A8nXhWYi4Cg1vMHXrAQ3YdZ0xPocolLJRxd5xMZtf1+L14i93o5xsvtDKTxR9UWAeWjuz3Bx
 XQi4YRMxkNpROJWaccamo0fI=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (109.76.127.113)
	by smtp.migadu.com with ESMTPS id e914fa40502dc47c;
	Wed, 19 Aug 2026 21:16:20 +0000
X-Mizu-Trace-ID: e914fa40502dc47c
X-Migadu-Flow: FLOW_OUT
Message-ID: <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
Date: Wed, 19 Aug 2026 22:16:18 +0100
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
Cc: "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
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
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260815221919.64226-4-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2026 23:19, Ali Rouhi wrote:
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

as the new version is need, could you please think of how it can be
split. reviewing if 5.6k lines of code in one go is quite tough

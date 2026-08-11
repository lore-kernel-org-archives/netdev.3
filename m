Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60845629C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467865; cv=none; b=POyF6FXBInqkbof0Zq9lWQ5bZ8rMf26bEeTglTrZQqeermqcyLonRDLYf0hVabCDmX2H0ZJ5rIbUDM8io3OeL0k8PLFLjB/DUjDYZUYwSoBMhIBiouZGAsMXSnRW2B1bCD+fO66lYPfWBu/eESAOv8PeehMierYftwK/LehZ8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467865; c=relaxed/simple;
	bh=5gcyVK1ktdCvv3Gw0MABamWs/7y9bxgwwIrweU2aEsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhVQfnZ+x5lsjOEq6NRaw9JuMx/pV1btvhBZ7N4yzRCiJS9RFfGDVZpd83sRWCEHb71fNzGU5l5V2EYoC47KjLDD7isqTEC7/JedshO/BrP8T/BF/sV42KiuQKOVDcskwL4hVxtAPPD+wLu5eI68lwz9+WI8oB7s60BTqD8wPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tJv9jKNt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tJv9jKNt"
Message-ID: <7d68bd52-29e4-4d60-94cc-4f15fefb47e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786467859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHNUyGmeXnDef3iFRRW5BvcbyRmiVgDUr639t4XT+hk=;
	b=tJv9jKNtdggw4g86MoH+PV7t7yko9E08G4De6jvE2qu4aFvt6A6aKr5oz5KOs/ycGumZD6
	VZoXbgP1BUKB4nPlZIgLqm244Pz11RSP3HzdqkCQdIKe1+fTQc52XJjR6x842w+JJgrOVa
	1dH76xsnU/pBH44l2uMD+T8wEDrMg9Y=
Date: Tue, 11 Aug 2026 18:04:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bnxt_en: enable PTM function
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Pavan Chebbi <pavan.chebbi@broadcom.com>
References: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
 <CACKFLimm+_nUX4s5MoNw+cavA6pXr+1ZDpRO+4Fya-ZBfzhreQ@mail.gmail.com>
 <8d21f245-abde-47b8-a7c8-b62a1ada6200@linux.dev>
 <CALs4sv3A4bY6-+S9kid5BQEiyQ76gbpnYoS5r+=KUKsB48fyPw@mail.gmail.com>
 <a43426e1-91d9-4d8c-9514-3808928cc792@linux.dev>
 <CALs4sv0pZWUJiWcUTj5W-zyV7uu5NFBTjT1nSD4yY=9H+p6xbg@mail.gmail.com>
 <a8ba2491-186a-47f1-8222-1b4dc67254a2@linux.dev>
 <CALs4sv17EUFZ8vG_7tC0aDJhVT1NbCk7xnzEET8ZZdoHrPW4ng@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv17EUFZ8vG_7tC0aDJhVT1NbCk7xnzEET8ZZdoHrPW4ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/08/2026 05:39, Pavan Chebbi wrote:
>>> Ok I understand you now. Maybe it is fine to have
>>> pcie_ptm_enabled()/disabled() called for this version of the driver.
>>> Since FW currently always enables it, and these calls are harmless and
>>> turn off .getcrosststamp on platforms that don't support PTM, both FW
>>> and driver/kernel end up working in sync.
>>> Only thing I would argue is should this be done in bnxt_ptp_init() and
>>> clear()? Since as much as PTM is a PCIe feature, the cross timestamps
>>> are tied with PTP.
>>
>> It makes sense to have PCIe things tied together, because PTM is PCIe
>> feature. Cross timestamps configuration are already in ptp area of the
>> driver, so no need to change anything around it
> 
> OK. Fine with me.
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Thanks

Jakub, it looks like we have to drop fixes tag and apply it to net-next
as it has never worked on upstream kernel.

Sashiko's comments are not really valuable - underflow of
ptm_enabled_cnt may happen only right before the device structure is
freed, so it actually doesn't matter, all other drivers do not care
about ptm counter as well on destroy path. And validating result of
pci_enable_ptm() also makes no sense because we don't care about the
result, only thing we can do is to put debug message, but that can also
be figured out in run-time.


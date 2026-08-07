Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88B40D57F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130879; cv=none; b=TW3HzBKCWJEgkX4iBjNVHLf76xHxSdMxQEk8cPuISdqwekdt7bP2aftcZOgrbrk59Jc5rr1rH15cSROUY8d/jlxDDJIQb+gYjF7u4QzZ+t85JmcdQd6pNfr3HZ3Va05uqJrutYmWy5PY+sHSuVg7OkPRaxJu/cpJrz/o+inBAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130879; c=relaxed/simple;
	bh=w/TyOVs68rDRc9f84TCmo6jD9M6hYmCkRV2RW1bLU5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8T6e08O5APCsIVCFwJucF4zb/Gg5Xh9ZXuK+/CoYENf+bczW19/XGkT701h5+cL8NPeYMoJW7ryq4xy3Th3gkpdCgLkLlapZH+AI5iLlfll5VI4iM1pMpaN2Rgh4p3Uj/V4xRiZyJL60/VfNju8AZqn0E1lDjU9QZOkx6U+t+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1DcnGj2; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1DcnGj2"
Message-ID: <a8ba2491-186a-47f1-8222-1b4dc67254a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786130873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ozp1+wDfK2Oh07K+pRfkmNYY8UTsiX7noFeIp3LpDMY=;
	b=t1DcnGj2bOLKxDF1TBLmmOmlI967UQzd0OW0BvXTpGkvpSco+eMOVDL/Z4O5tleF2rkjA8
	EjTGLojv0TQwA1VsMc67gHEAquML6bkrkxEgWpjTIZbMiA9m3ZWc/uJ3nJ1kOMDnxtBhrY
	wpvmhR/4CCd38QbNzIg821Am888i6iE=
Date: Fri, 7 Aug 2026 20:27:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bnxt_en: enable PTM function
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
 <CACKFLimm+_nUX4s5MoNw+cavA6pXr+1ZDpRO+4Fya-ZBfzhreQ@mail.gmail.com>
 <8d21f245-abde-47b8-a7c8-b62a1ada6200@linux.dev>
 <CALs4sv3A4bY6-+S9kid5BQEiyQ76gbpnYoS5r+=KUKsB48fyPw@mail.gmail.com>
 <a43426e1-91d9-4d8c-9514-3808928cc792@linux.dev>
 <CALs4sv0pZWUJiWcUTj5W-zyV7uu5NFBTjT1nSD4yY=9H+p6xbg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv0pZWUJiWcUTj5W-zyV7uu5NFBTjT1nSD4yY=9H+p6xbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 07/08/2026 17:13, Pavan Chebbi wrote:
> On Fri, Aug 7, 2026 at 7:30 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 07/08/2026 13:51, Pavan Chebbi wrote:
>>> On Fri, Aug 7, 2026 at 2:16 AM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 06.08.2026 21:35, Michael Chan wrote:
>>>>> On Thu, Aug 6, 2026 at 1:22 PM Vadim Fedorenko
>>>>> <vadim.fedorenko@linux.dev> wrote:
>>>>>>
>>>>>> The patch mentioned in Fixes missed one main point of implementing
>>>>>> proper PTM support. To make it fully operational it has to be explicitly
>>>>>> enabled. Add missing call in probe callback and disable it in teardown
>>>>>> callback.
>>>>>
>>>>> We were actually discussing this internally just a few weeks ago.  I
>>>>> think the FW always enables it and that's why pci_enable_ptm() is not
>>>>> strictly required.  I'll let Pavan comment on this further.  Thanks.
>>>>
>>>> In my test even though firmware was acting as requestor, pcie_ptm_enabled()
>>>> returns false and disables setup of getcrosststamp callback. This happens
>>>> because kernel doesn't know that PTM is enabled.
>>>
>>> I think the right thing to do would be to first check the capability
>>> from FW (which actually decides whether we can support PTM on the
>>> installed RC/platform) and then enable it in the kernel.
>>> This is what we internally decided to do. Can you wait for us to
>>> complete that work and send the patch?
>>
>>
>> Could you please be a bit more specific on how FW decides? Does it
>> remove PTM capability in case it's not possible?
>>
>> As you can see from the code of pci_enable_ptm(), sometimes parent
>> device needs PTM enabled as well before starting TLVs, will your FW be
>> aware of this?
>>
>> What I'm trying to say is that it looks like you try to reinvent what
>> has already been implemented. pcie_ptm_enabled() is harmless in case the
>> platform cannot support it, and you are gating getcrosststamp() by FW
>> capabilities already - why do you need another check?
> 
> Ok I understand you now. Maybe it is fine to have
> pcie_ptm_enabled()/disabled() called for this version of the driver.
> Since FW currently always enables it, and these calls are harmless and
> turn off .getcrosststamp on platforms that don't support PTM, both FW
> and driver/kernel end up working in sync.
> Only thing I would argue is should this be done in bnxt_ptp_init() and
> clear()? Since as much as PTM is a PCIe feature, the cross timestamps
> are tied with PTP.

It makes sense to have PCIe things tied together, because PTM is PCIe
feature. Cross timestamps configuration are already in ptp area of the
driver, so no need to change anything around it

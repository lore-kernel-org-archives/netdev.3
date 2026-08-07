Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBB378D70
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111248; cv=none; b=n2ZKit9bOkWLHvbYASWNZMZcK2zqSGd2+qLYtRUjKZW0beg7wGAi05slxiGkqOkqyKwdLra0+dXfJRZajYCo8drFr4Mk8keX/9n3mEtNiNm5MeCmd/m7qNQGq830BXOoo24KbAHc5k3XxTSOolwpINHfqCjjCKM8KvQe2D7skas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111248; c=relaxed/simple;
	bh=g/a1tPkxfETPDZdQFZCLI2Zy7qmTnWWKxh2/+sKJhyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsN+jgEqR7SychVoYlJ36GvIzs4AZNhH3mY8lCwo44NTr0G09UZaiMaNo0jm0dMMJ6JBQ5i491DUOm644hb6TtMYeEmiLGuZfLGZfwlr7IOzg2Psm4JZsY2VPsKDJPSKFKlIhA0fiqBoXY+I556oaHEsbhNco/eVDe6fGrBwnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vtF0WGyn; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vtF0WGyn"
Message-ID: <a43426e1-91d9-4d8c-9514-3808928cc792@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786111239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPI1MZyc7UBJ8aRc1ZIBFnzu8rRHAdPJNfe72w3PzPA=;
	b=vtF0WGynBZdyLHqsMCXjSEvmBpaSU1Ce+8eQcW84WPZJYroTu22x1t6+ml85j5BZfOZym6
	jYcUSPzRdr56vXftsUV9v6b2JWZJWmecCe4pf6ahRwOX0HLrcZNzd/fJcqhsMCEVWNxX6N
	LKVpHrpOebITc/lU2cQHvo2DutAqb/o=
Date: Fri, 7 Aug 2026 15:00:31 +0100
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv3A4bY6-+S9kid5BQEiyQ76gbpnYoS5r+=KUKsB48fyPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 07/08/2026 13:51, Pavan Chebbi wrote:
> On Fri, Aug 7, 2026 at 2:16 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 06.08.2026 21:35, Michael Chan wrote:
>>> On Thu, Aug 6, 2026 at 1:22 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> The patch mentioned in Fixes missed one main point of implementing
>>>> proper PTM support. To make it fully operational it has to be explicitly
>>>> enabled. Add missing call in probe callback and disable it in teardown
>>>> callback.
>>>
>>> We were actually discussing this internally just a few weeks ago.  I
>>> think the FW always enables it and that's why pci_enable_ptm() is not
>>> strictly required.  I'll let Pavan comment on this further.  Thanks.
>>
>> In my test even though firmware was acting as requestor, pcie_ptm_enabled()
>> returns false and disables setup of getcrosststamp callback. This happens
>> because kernel doesn't know that PTM is enabled.
> 
> I think the right thing to do would be to first check the capability
> from FW (which actually decides whether we can support PTM on the
> installed RC/platform) and then enable it in the kernel.
> This is what we internally decided to do. Can you wait for us to
> complete that work and send the patch?


Could you please be a bit more specific on how FW decides? Does it
remove PTM capability in case it's not possible?

As you can see from the code of pci_enable_ptm(), sometimes parent
device needs PTM enabled as well before starting TLVs, will your FW be
aware of this?

What I'm trying to say is that it looks like you try to reinvent what
has already been implemented. pcie_ptm_enabled() is harmless in case the
platform cannot support it, and you are gating getcrosststamp() by FW
capabilities already - why do you need another check?

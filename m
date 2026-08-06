Received: from out-178.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5E3F4853
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049177; cv=none; b=X/7vs1IfH9F23W4J5VZ1kYsqBxNt/uHHqu0IEnUn2CmXLoX0B5S/CVBFgmP8goAh3wyQuuaWiXlIjLXNzzT5q2CIbJVdaKPLzusMPFgDvGmvJJi5KvGVNMMHuv7AaB21xH/YunJgB2tbNMRmWZRVoYPOJrZSe5wCgfva+9WdSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049177; c=relaxed/simple;
	bh=PAyELalBTEKpTyBKgdhzhBmhaLB6VTI0fGD97minp3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTmaK+SFAumAjTgRBYRdaNlBqU21n/zdpg+0NLGpM3vYCae0yh7HrjuaKd/Eb4FmG+681AaMQ/1Z5NAn+Kffp7fkFJzd4SLlIT9m2fja+vLFM3u2JCDxTJL2L6uzLN9/Yue5/0C2yQgvIyPMamWt6slHyaRCUgTs0CMqOYv64xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TzROExPv; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TzROExPv"
Message-ID: <8d21f245-abde-47b8-a7c8-b62a1ada6200@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786049170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkentHlvlEP1Fn9u9U6DbCrziFDiAg5rtcsrsKIc7yo=;
	b=TzROExPvf4A0zpqTLHRT/HhaLDCcv8n5yYz90lLj5qBh8XBox/N1+DKKqRdNotb2W/ZUUN
	SCsAX6AGigtY7eoSRyLv1HflQnj3batx/vapNNya/LcGoI9zlIFlOMMpiG0S3OMdZLlto4
	wB4/hjwB9gKbi5rYZfOvbAvuJp77hmM=
Date: Thu, 6 Aug 2026 21:45:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] bnxt_en: enable PTM function
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20260806201849.3161402-1-vadim.fedorenko@linux.dev>
 <CACKFLimm+_nUX4s5MoNw+cavA6pXr+1ZDpRO+4Fya-ZBfzhreQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLimm+_nUX4s5MoNw+cavA6pXr+1ZDpRO+4Fya-ZBfzhreQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 06.08.2026 21:35, Michael Chan wrote:
> On Thu, Aug 6, 2026 at 1:22 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> The patch mentioned in Fixes missed one main point of implementing
>> proper PTM support. To make it fully operational it has to be explicitly
>> enabled. Add missing call in probe callback and disable it in teardown
>> callback.
> 
> We were actually discussing this internally just a few weeks ago.  I
> think the FW always enables it and that's why pci_enable_ptm() is not
> strictly required.  I'll let Pavan comment on this further.  Thanks.

In my test even though firmware was acting as requestor, pcie_ptm_enabled()
returns false and disables setup of getcrosststamp callback. This happens
because kernel doesn't know that PTM is enabled.

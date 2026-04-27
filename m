Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F022EC0A7;
	Mon, 27 Apr 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314418; cv=none; b=XxBgHizMAxUPZ9gaN9O/xbnTdky7tX9X+6/VGysDWmL/kBS4YBYYbFw5RPk7MJjuZVoz2iuLZ8nlhLF3TdyMobD8PxcfyKDSBohO2OvXja/Bej1fI2k7wJtbtJOKgKRBCgz9bGRnZNwgCmtzPVwXLE1m4ZXuHmvOi1mBQtCpAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314418; c=relaxed/simple;
	bh=mBk1EgAT19wL6bdZ5pqnxKIy8oKBJcRqqcMmbFytKa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apBzWGQktG/AJO6GvZ4B0OHNuT28ThTsvK08P0bSKOPzlICE5vx5u9ZdNx2O2C83KRYnWETnU4uZUBgAewP9rrS5RD4Dh8KZx+o5LCRf9AAHxkpYNaLoiPTKGBel55y6QTXiTds3VISnZfoMlmE1b5w3WcQW3Ex54a+k2POjZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fq1mkcXu; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fq1mkcXu"
Message-ID: <cdce7fbb-671d-48b0-95ff-56b882d3e9a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777314405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZxsQZ4URB57FsMrtoaktWFHoc/WtO77TGk8yqurP68=;
	b=fq1mkcXuqiFr9btfrrj/BIueSgTsSnNGEj3109scN+WwRJF3SwCFT8X5/d/Vsz+gPirt2h
	Z9U+CXYptnFH2/TEtInnMMTYKO6qLcg9kJ6fAFjOUqC98YZXGCcoX3ZTE4y2Emvvxo2J0v
	65oia3H8rziMqxJHqUekrqBcmkEm+O8=
Date: Mon, 27 Apr 2026 11:26:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming
 broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length
 adjustment with GSO_PARTIAL")
To: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev>
 <5293b717-6a8e-40b6-bd6b-61043a062451@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <5293b717-6a8e-40b6-bd6b-61043a062451@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/27/26 11:09 AM, Gal Pressman wrote:
> Hello Matthew,
> 
> On 27/04/2026 2:20, Matthew Schwartz wrote:
>> Hello,
>>
>> When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.
>>
>> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.
>>
>> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.
>>
>> Please let me know if there's any additional info I can provide.
>>
>> Thanks,
>> Matt
>>
>> #regzbot introduced: 5b4015ad833c
> 
> Thank you for the report and the bisect!
> 
> I will take a look and try to figure out what's wrong (though I don't
> have real hardware to test on).
> Is the userspace app open source? can I see its code and try to run it
> myself?

Thanks for the reply. The code for Sunshine is available here: https://github.com/LizardByte/Sunshine and the code for Moonlight is here: https://github.com/moonlight-stream/moonlight-qt.

I have been using the Arch Linux Sunshine package which I installed by following the Linux instructions here: https://docs.lizardbyte.dev/projects/sunshine/latest/md_docs_2getting__started.html, but there are also binaries for other distros or it's buildable from source. For Moonlight, I have been using the Flatpak distributed on Flathub because the client device runs an atomic rootfs, but you can also use any other device that Moonlight supports.

> 
> I will be OOO for the rest of the week, hope to have some meaningful
> reply by the end of next week.


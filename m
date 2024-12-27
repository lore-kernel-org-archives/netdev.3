Received: from va-1-18.ptr.blmpb.com (va-1-18.ptr.blmpb.com [209.127.230.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48EF4F1
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735271549; cv=none; b=W0/3cvX0X4ZEym2j4Pq2qXvLaX/DqlPE4ZVEeRruvHcSML9m6iKSZ9FzsWez0CbW+ej1OFHJcSFu+izYXNo6L8j+yxkCUQERj9GfIJltUzXWym3W7VQusyvfdDyMIzs+zRc6INqOMEb7m0tTvQm5n3/eNPP/nG4A5ERciju+Q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735271549; c=relaxed/simple;
	bh=5A2+CeqVsKY3hhlquu/mmxIABboq/mnPf45iiIfSHjM=;
	h=Subject:Mime-Version:Date:Content-Type:References:To:Cc:From:
	 Message-Id:In-Reply-To; b=fdWnVeA+EQPQ3ugsbCtJaQUT07IgYUNRmDGdP+x8lIaMGUeDFf61NWZyRNcZwt/aPlhhSzB7P3EH5D9x9moq3WRCmbFYUQO1dx8FFDthuvflbyxvZ/MxCXv4AfU+bkvBVfEu6fyYBU83xwCkeYiL6yiCAjGb8F1KQOGvEgKSQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=hSWplUOU; arc=none smtp.client-ip=209.127.230.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="hSWplUOU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735271530; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5A2+CeqVsKY3hhlquu/mmxIABboq/mnPf45iiIfSHjM=;
 b=hSWplUOUsB7s9lm8/HtaJae65ySGrSMVNjdEWGtpyPN9H7gE7bbLphWvI71zdN8bCDhsBR
 Dj6VTYmpfrunr5I2nIsYXL1W6/UCF6blvgCf4BG+pj3tXom0nqN1prr0xTyWYCGohA85FT
 +GZ1wQvm98GhzoyVN8qMwtvEmi4TNAVYUZYaJ9iEGsaoJS0OxLK2qHqD4ScRmycfhibbDz
 ZDlA7ZK3oz5j8NvlPuffTfDSZpKRr7BhJ1PT9xMD1rxuhe19GH5+Arw6cE5CqTTDtKxz6Z
 E4cdjkH6XwaNh0n+5M4B2gsTB5xPY4mZJoqI6UUB0pMU+aEnjbTsSCmdIUmJXg==
Subject: Re: [PATCH v1 02/16] net-next/yunsilicon: Enable CMDQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: tianx <tianx@yunsilicon.com>
Date: Fri, 27 Dec 2024 11:52:05 +0800
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218105026.2237645-3-tianx@yunsilicon.com> <173cb6c9-18d5-4e5d-bf52-5e23653f27d1@intel.com>
X-Lms-Return-Path: <lba+2676e2468+2f3e5d+vger.kernel.org+tianx@yunsilicon.com>
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <netdev@vger.kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Fri, 27 Dec 2024 11:52:06 +0800
Message-Id: <a9c75ef6-88fe-4cf5-9d27-22c3ba153ac5@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <173cb6c9-18d5-4e5d-bf52-5e23653f27d1@intel.com>

>> +=C2=A0=C2=A0=C2=A0=C2=A0 * complete and we may need to increase this ti=
meout value
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_TIMEOUT_MSEC=C2=A0=C2=A0=C2=A0 =3D 10 * 1000=
,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_WQ_MAX_NAME=C2=A0=C2=A0=C2=A0 =3D 32,
>
> take a look at the abundant kernel provided work queues, not need to
> spawn your own most of the time
>
>
Hi, Przemek

Thank you for the detailed review. The previous issues will be addressed=20
in v2, but this one needs clarification.

We need a workqueue that executes tasks sequentially, but the workqueues=20
provided by the kernel do not meet this requirement, so we used=20
|create_singlethread_workqueue| to create one.

Best regards,

Xin

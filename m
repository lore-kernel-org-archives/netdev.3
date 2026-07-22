Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13A40D560;
	Wed, 22 Jul 2026 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696324; cv=none; b=lbL8SKVxAVhQaWJndF6l9Te0STb0ctgkuPnQ0bzHMmIYgkL48+SIJ2BV7/zllXUlLS4u+M8wDwxmflLcSVpbwRQXcp/2WUj5EMtSBMbw3V7CCAX7jVfJ6ksUgnMe0XsNLbpCRKxw/GYR6HDd53h6OoQ5EOJ+qaF4e7oGeZ/cK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696324; c=relaxed/simple;
	bh=HUe35KNPbQG6UTm94YXfKkvkEkYbODFEHu83ivASSr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nQMKP7Oe0Zo8eBobGd6ShuM/mLZh5uQIYdc6M1/XvLrob9XiLRcqszohL9Kfuxbb41hyj1ZM06SmqLDKVLA+/jV06LoMRuDPSVmlyEWWitKHceMEAs5jSJtL8+cPpOv2lrQKGyTWgU9/89AXoEMK+svmSv4k5VKzxGqMXfvoluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yo3lnR5f; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yo3lnR5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784696323; x=1816232323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HUe35KNPbQG6UTm94YXfKkvkEkYbODFEHu83ivASSr4=;
  b=Yo3lnR5f1OVFqyT/nha7XFHRtBaPILuwnw5S3pbgPI3vXcMuTaXby2b6
   07yCKu05j04zGWGwGms8QSL8FcrVm/ydnxa2Y1jlMBxHcPH63tofApMG0
   V1BeIRLKoZ6yA5OD3uFk6FvfgLdwH2BfmUnLDZZKWWV91VxEYZY+Tgz3r
   E8d3dCrYZAZY6B8UXoKIHl5HQv42cGneKIMoslFjmGEF+wXgyuwzEZCCR
   YB71oNs8fiEa7NQ/DFzaY8Rec3pGy43N0SnwhtM74ymbZO46pwcDFWXKJ
   BCDgQDHIm8deQWgXLaXmuWLJmlXdAEfExcEwA4oHElmrY+k7KiCFb4mjA
   A==;
X-CSE-ConnectionGUID: 8M4SxKmVQ/WYKq5NJd2O8g==
X-CSE-MsgGUID: WU4Ns3efRwWfu82lyG5bPQ==
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="61304965"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 21:58:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 21 Jul 2026 21:58:42 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 21 Jul 2026 21:58:37 -0700
Message-ID: <d8cdbaf9-193a-4d23-b5dc-f8262983146b@microchip.com>
Date: Wed, 22 Jul 2026 10:28:36 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Andrew Lunn
	<andrew@lunn.ch>, "ciprian.regus@analog.com" <ciprian.regus@analog.com>
CC: Simon Horman <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
 <20260710142019.1619159-1-horms@kernel.org>
 <DM5PR02MB33693344BE338A70BC70FDD283C32@DM5PR02MB3369.namprd02.prod.outlook.com>
 <b86c8bff-6f78-42c6-8de9-ae280df5c18b@lunn.ch>
 <DM5PR02MB33694B53700F25B78E40E65683C22@DM5PR02MB3369.namprd02.prod.outlook.com>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <DM5PR02MB33694B53700F25B78E40E65683C22@DM5PR02MB3369.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Selvamani,

On 21/07/26 7:57 am, Selvamani Rajagopal wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
>> Subject: Re: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer overflow
>> handling
>>
>> You should probably repost it.
> 
> Thanks. I had follow-up one line change + comments. So, I submitted newer version.
> 
>>
>> The last couple of weeks things have been falling through the cracks
>> due to vacation and conferences. Reviewer time has been limited.
>>
>> It might also help if all the TC6 developers work together and review
>> each others patches. Patchset having Reviewed-by: is more likely to
>> get accepted without one of "big" reviewers looking at it.
> 
> Agree with you.
> 
> Parthiban, Ciprian,
> 
> Please add your review comments, if any, when you find some time as changes are in common code.
> https://patchwork.kernel.org/project/netdevbpf/cover/20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com/
Sure will share the feedback as soon as possible.

Best regards,
Parthiban V
> 
>>
>> Andrew
> 


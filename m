Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D62F8EA3
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736000; cv=none; b=Dsy9iN0DcZFHT9uv2PCbdti/ZgbOGhbFW0aJwC7/ksUbJIHLVscXpKeUlnZLlr8o3M100qTv4HLdJO9G5gu84JJ25Vkwbn2d59HJIleCipAHaETpp6LG1L6uTRfghATwy01Uc3odCuCv0Z7gdmklOwjwSDQO8Y9aKjr5dJl6Mfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736000; c=relaxed/simple;
	bh=CEdoNyKQuBDBkZDP3UXuiDezKbVw40CdhAMAHoAtbaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiYeAhcpGvEcRyjMymgbuLhedHKa8hgth8sCKLU9b42lLjWkcv3wTZpiSWdOrov0dr49Dcwuizx/3VKyzRxTnpjPD22TsRn3ISWfO4EnRmJmK0xGJuwnBsLaeCr9z+fhZqMA5Hhc5+QsJkXr5xZhqOzzjaKLZe8rRmRGswv1MDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32b7057abc7811f19a56ed5b684f684d-20260930
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e588c88f-367b-4a10-a16a-91d09993f2b4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:07d400e52f8fe9660bd7a249e35e36de,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32b7057abc7811f19a56ed5b684f684d-20260930
X-User: weirongguang@kylinos.cn
Received: from [10.42.124.137] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 789462195; Wed, 30 Sep 2026 10:39:45 +0800
Message-ID: <a859aa22-10e5-43da-9496-112439f62aed@kylinos.cn>
Date: Wed, 30 Sep 2026 10:39:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests: net: add TAP socket filter attach tests
Content-Language: en-US
To: bot+bpf-ci@kernel.org, clementwei90@163.com, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260929093712.131096-5-clementwei90@163.com>
 <e92415377895ae97294773add38549484b30c54f4b3e1e968fcfe89348ff6696@mail.kernel.org>
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <e92415377895ae97294773add38549484b30c54f4b3e1e968fcfe89348ff6696@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



on 2026/9/29 18:34, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
>> index abe488bac50b..bf8d4d6f21f7 100644
>> --- a/tools/testing/selftests/net/tun.c
>> +++ b/tools/testing/selftests/net/tun.c
>> @@ -8,13 +8,19 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <unistd.h>
>> +#include <linux/filter.h>
>>  #include <linux/if_tun.h>
>>  #include <sys/ioctl.h>
>> +#include <sys/mman.h>
>>  #include <sys/socket.h>
>>
>>  #include "kselftest_harness.h"
>>  #include "tuntap_helpers.h"
>>
>> +#ifndef ARRAY_SIZE
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> +#endif
> 
> This isn't a bug, but kselftest.h already provides ARRAY_SIZE through
> kselftest_harness.h. Is this #ifndef block needed, or can it be dropped?
> 
> Looking at the include chain: kselftest_harness.h includes kselftest.h,
> and kselftest.h defines ARRAY_SIZE at line 63-65. kselftest_harness.h also
> defines it again at line 749. Other harness-based tests in the same
> directory (tls.c, ip_local_port_range.c) use ARRAY_SIZE without defining
> it themselves.
> 
Yes, thank you.

I will drop it in v3.
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36552651982

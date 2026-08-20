Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87D3DC850
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214152; cv=none; b=HtAmleJ+005sY6meWOJYwZ1du8UhnH8hY+wHzfTYUW6F45v++DhdqEvfUVEY0fJvxyG0dfGBNZ7whsYKFvc+WxLblNOS4srJS6NCpnIrNJ9an3d3sG0gHpaoLNCVw/SyauBnkVB0axMiMggZ8apVaEthV4ow8KoDR+1rw0BWdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214152; c=relaxed/simple;
	bh=5e4/NzEnnNFweGYid+yLmS17Rqq2lfwGeVusJa5NcBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfDq377gSy3l/cYZBVxFYXF/7KBcZwMizDECIL0FaJTAmGxqfmam+bwxHZPjEhWJ7CS9WqZwONgFubdS/ln/PKM2wMKlzPWvcVi3OYrQIxt2g3jnwt6egVFnJGjSOhxjG8IslEuNRV7BDdS3aeVh+ehwk0+04Pr+U2WJDusiVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pI6SDRTG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pI6SDRTG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5e4/NzEnnNFweGYid+yLmS17Rqq2lfwGeVusJa5NcBI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787214149; v=1; x=1787818949;
 b=pI6SDRTGgKp0zCOOtW8IZ/vtti9gD+QAHQXSoOnyDv4HPTBds5dbXhkxAcQswHCMH/69n5y4
 C0rIdfQJaDkzgLJiIKLXI2wq2y1Rik/IREgz7nDKPVHrcz4fwzJx/Id9tT+DPHlVZp5a2A9t+cZ
 JqbVvH0y8dNSKG/hIHStN040=
X-Envelope-To: netdev@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id c68b9dbf0f5c289f;
	Thu, 20 Aug 2026 08:22:28 +0000
X-Mizu-Trace-ID: c68b9dbf0f5c289f
X-Migadu-Flow: FLOW_OUT
Message-ID: <15476f67-1484-4af8-bc5e-ce32fb24607f@linux.dev>
Date: Thu, 20 Aug 2026 16:22:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] general protection fault in espintcp_sendmsg
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: horms@kernel.org, linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr,
 davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 steffen.klassert@secunet.com, zylzyl2333@gmail.com, sd@queasysnail.net
References: <20260819155349.3555804-1-jjy600901@snu.ac.kr>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260819155349.3555804-1-jjy600901@snu.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jaeyoung,

在 2026/8/19 23:53, Jaeyoung Chung 写道:
> Hello,
>
> We found a "general protection fault in espintcp_sendmsg" on Linux v7.2.
> The issue was found by our own race fuzzer. We have not analyzed the root
> cause, so we do not have a proposed fix to offer.
>
> To reproduce the race reliably, we applied the delay patch below to the
> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
> crash log we observed, the delay patch and the reproducer are all included
> below.
>
> The following kernel config options are required to reproduce the issue:
> 	CONFIG_XFRM=y
> 	CONFIG_XFRM_USER=y
> 	CONFIG_INET_ESP=y
> 	CONFIG_INET_ESPINTCP=y
> 	CONFIG_KASAN=y
>
> We hope this report is useful. Please let us know if any further
> information would help.
>
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Thanks for the report.

I suspect the issue you reproduced is the same race that Yilin Zhu
attempted to address a few months ago:

https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/

I have added Yilin and Sabrina back to Cc. Sabrina reviewed that patch,
but as far as I can tell, no revised version was posted afterwards. I
do not know the current status of that work.

Thanks,
Xuanqiang


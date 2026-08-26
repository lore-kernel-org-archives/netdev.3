Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340DD333439
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787722704; cv=none; b=s5YmMKFiucOxPPPpCY5ViQdjbGiOleEth9bf0/o7zEj4gL4uZI+yQJJj2J62v0Woeeo+59peiMYWJYgJTyhOTY/12eS9+f0670y124RUE5Oxahl25gmdQjLgIQf+GaN723tE3LNKw5qFtyXCpBfC5+YsD36+Mb1FPcNhCliYzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787722704; c=relaxed/simple;
	bh=qwiPevUVxC4HbDb6mnNEuMiwDcUKPc5Co7Hl7T7UNxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjfDcN285e4RChMMUO7C9wqSTKfahdRZW7jZBEtR5e0MAhHb3dzjKO4kjUe+nJf/a1MFQkwA+nHO1gb9+2zRBT3Kj0RcFkKQTXDDX73SMMUhr/vRvbg0Xfft8ANI7ycRnX4VALYikyl9qZnBfQLdh/vchDhAnI7qo9D4M+8PhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FzeHXx7t; arc=none smtp.client-ip=95.215.58.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FzeHXx7t"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qwiPevUVxC4HbDb6mnNEuMiwDcUKPc5Co7Hl7T7UNxg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787722700; v=1; x=1788327500;
 b=FzeHXx7tdPQ1G1BOqAHeUL1P06/vt1CsEM3E85XHyKz2U7jBVpqSv6tnZEquBwVK9uE8E7Yc
 wv8tLJZ9gJbUOvo3LLGiW0qIW2wdob2geY3blmb/y/nOO+/PSfNLAclWn7b0JajArZF/6TWCNGg
 ausfuwFSop5UDwvjxMmiDnPQ=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2408:820c:2709:4101:c80e:c4e9:a56c:6f95] (2a14:7586:6109:1::198)
	by smtp.migadu.com with ESMTPS id 3a4306510f3658bc;
	Wed, 26 Aug 2026 05:38:10 +0000
X-Mizu-Trace-ID: 3a4306510f3658bc
X-Migadu-Flow: FLOW_OUT
Message-ID: <8ea9c9ce-e1ed-475b-90d3-abf1bd86c3d7@linux.dev>
Date: Wed, 26 Aug 2026 13:38:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KASAN: slab-use-after-free Read in slip_receive_buf
To: Eric Dumazet <edumazet@google.com>, Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, 726ksm@gmail.com,
 kees@kernel.org, linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
References: <20260825150655.1450271-1-jjy600901@snu.ac.kr>
 <CANn89iJE_HosLBRhZGM-GVpgPCSNtHiS9vnCc3tEmTVaamcJ9g@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CANn89iJE_HosLBRhZGM-GVpgPCSNtHiS9vnCc3tEmTVaamcJ9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2026/8/25 23:27, Eric Dumazet wrote:
> On Tue, Aug 25, 2026 at 5:07 PM Jaeyoung Chung <jjy600901@snu.ac.kr> wrote:
>> Hello,
>>
>> We found a "KASAN: slab-use-after-free Read in slip_receive_buf" on Linux v7.2.
>> The issue was found by our own race fuzzer. We have not analyzed the root cause,
>> so we do not have a proposed fix to offer.
>>
>> To reproduce the race reliably, we applied the delay patch below to the
>> kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
>> crash log we observed, the delay patch and the reproducer are all included
>> below.
>>
>> The following kernel config options are required to reproduce the issue:
>>      CONFIG_SLIP=y
>>      CONFIG_LEGACY_TIOCSTI=y
>>      CONFIG_UNIX98_PTYS=y
>>      CONFIG_TTY=y
>>      CONFIG_KASAN=y
>>
>> We hope this report is useful. Please let us know if any further
>> information would help.
>>
>> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
>> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> This rings a bell; I had a local syzbot report for this issue a while back.
>
> I think we should remove slip_hangup().
ppp_async.c and ppp_synctty.c have the same anti-pattern. Should we 
remove theirs as well?

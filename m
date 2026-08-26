Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFF382388
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787723637; cv=none; b=FrN66c4IMS+jM2/+iLP6e1ZCsaUjNWQ37kGjXe+vX5qAjN9SOqf9UkKjM/znVFZaA3bFG4TqiCca70FYU9nJEPvWbysuZtuF4s+w1qPqjP3EN95IwFYjk2nZwxyYgEObalJ2/PvZqPl/x+71oZyKfNX/IWTQFloeGe2QYE4vBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787723637; c=relaxed/simple;
	bh=xqFPkKWkvMVqb8K0mdDwcjHWu2dAWcNjliz0PX3himg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIIensPk6zU8UwEhEHdAhqT00AjRxWdsWAq1RrzXGMB5XSnF7PmXRfnDQZrMIb0Ecdfs439nYD2S/ja1y0Jefxei+hDJwMdijwxCwvEkeaW9sThtHHcayLTGGn5sBAZxZgW0rp+fS6PiMqhJ1PAeKV3PKMBYo84aDI10pkcR0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYCLsWZ0; arc=none smtp.client-ip=91.218.175.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYCLsWZ0"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xqFPkKWkvMVqb8K0mdDwcjHWu2dAWcNjliz0PX3himg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787723634; v=1; x=1788328434;
 b=AYCLsWZ0w83m6NmCdRF4/D7PbEO5KGLZLzMoBeaxEoU6dnGgq+z1Ndgaa3cjHuuWzEdJgSKL
 HFQKnyWRKQ51dDXeUageHCbamfE21BHqprhjiv+QEmTuUlzVRe6bdFyNVsES648E4hDTyG8pKjk
 IsJZDtKUm3SYRBNF/qYqO0GQ=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2408:820c:2709:4101:c80e:c4e9:a56c:6f95] (2a14:7586:6109:1::198)
	by smtp.migadu.com with ESMTPS id 64ee1563a0433a48;
	Wed, 26 Aug 2026 05:53:53 +0000
X-Mizu-Trace-ID: 64ee1563a0433a48
X-Migadu-Flow: FLOW_OUT
Message-ID: <f68f55d0-b012-4ea2-9623-2b8a63b2d0cd@linux.dev>
Date: Wed, 26 Aug 2026 13:53:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KASAN: slab-use-after-free Read in slip_receive_buf
To: Eric Dumazet <edumazet@google.com>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, 726ksm@gmail.com, kees@kernel.org,
 linux-kernel@vger.kernel.org, eulgyukim@snu.ac.kr
References: <20260825150655.1450271-1-jjy600901@snu.ac.kr>
 <CANn89iJE_HosLBRhZGM-GVpgPCSNtHiS9vnCc3tEmTVaamcJ9g@mail.gmail.com>
 <8ea9c9ce-e1ed-475b-90d3-abf1bd86c3d7@linux.dev>
 <CANn89iLr7+c_Hgxgj-odS10LW7CR_aTQr6ozFezKtYC6=vXG+A@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CANn89iLr7+c_Hgxgj-odS10LW7CR_aTQr6ozFezKtYC6=vXG+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/8/26 13:46, Eric Dumazet wrote:
> On Wed, Aug 26, 2026 at 7:38 AM Qingfang Deng <qingfang.deng@linux.dev> wrote:
>> Hi,
>>
>> On 2026/8/25 23:27, Eric Dumazet wrote:
>>> This rings a bell; I had a local syzbot report for this issue a while back.
>>>
>>> I think we should remove slip_hangup().
>> ppp_async.c and ppp_synctty.c have the same anti-pattern. Should we
>> remove theirs as well?
> Probably, akthough ppp_async and ppp_synctty historically suffered
> from this exact race, they added their own workaround: a global disc_data_lock,
> refcount_t refcnt, and wait_for_completion(&ap->dead) on every callback.
>
> Oh well.

Then the workaround should also be removed, according to the FIXME.

Relavent syzbot report:
https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/


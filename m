Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE447987B
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017802; cv=none; b=QuFEjrm7pO3zf1AmJYyDC5L0b3NgMAbnmGPBQumQAQNGVwSzVp5Gvt2hf4XnHymSeQ15oEgpWbgmKC34IkAF6RXNx0SgmEMI8KZlLcKEn7sZAeEoSu2THv76Ghg8mn5Tiz/f5jn0pWUv3pqMvQZWev+F75Mqu8XeNZOm31B0Am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017802; c=relaxed/simple;
	bh=W3D+9NixwQLoTJ1aioJtP64oWgPvbWXj8SUgRrzVThc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/mEhU2CqSuf1NhZBmHGnzNCV4Cx6dIO9DIA2qXXK0KrmDPE0ZB+8Uf/E2IygAhIZDiy7UglW4jWjRSKm69BsHXw4HTU83ifll16qYzWjA/5UagMsFdHA8iKcphJJdJr4YRnqqjOj1EIlTK0OUwC9qH/DPlizEIfpxv2L3IeOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+z8oKtv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+z8oKtv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4994c49f588so9131535e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786017799; x=1786622599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SboEURbqMkITdM1PZFfh6XITB55ibq8iUKBfhFu40tQ=;
        b=V+z8oKtvo/6y8vZ3VnzWvymxDKEFnRu3sHHAJ22YvVOiP9NFNhkMa9p6sIwNcZk1Wu
         dz8/GXhumx+6cVOhSq+DBwBzue0oJR18nSEyX+rFcl9Ig76DmvLTwPToIHeZEXsze8nR
         Oa5f/vMBq+VY0ILhKQa0dLAQSxlg7RO0wRw3O1yKAgRGkKcsFMqcGg/DrnEWHxH7Ra0/
         D6lqN14BhhugrolvcAWAaHPIwa6DwaLUuCZrjtZHGacYlekciDOES/6MoYCyudJuvOhf
         apeU4t9NppC2lmhBTMliJLxoYaG0ABXd6hU+bzoSpBJ5sxDmU+reLfbXlifQRYxo7nbn
         2blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017799; x=1786622599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SboEURbqMkITdM1PZFfh6XITB55ibq8iUKBfhFu40tQ=;
        b=jJyevS+1v1p2FAgth9Xq6CU99PH8pafOq/qxKx38F94/Rxv6kuDU8W/prxixSW3MPW
         H3lr8C9H1fpp6tnQWf7kTkSRUMBqwOHR+FOLK3p9ymPcIRorh/HKBRpEd5IkXrvI/F+K
         2HhbixDYv0j1zJQ5FLGBOU5+DGHcVgFMEZ3JLzHm7xWR0hn5AlzprTsF1Q3gv5S2qMV+
         Me92StaQ/ClEx46U7dDv9rk0WqhK6l1jomN0wb5nhO9xdXKtTdP8TWvpUCaNyOcCKVnM
         GveHZjxf7SMJd2OojFpa6QKPqLVKecs2+Z8P5iHtpEoORR37y1KpjaA9bT8Sk4Cea1sH
         fuQw==
X-Forwarded-Encrypted: i=1; AHgh+RqFXQOi0u6Aza1M5rog1cII4uQCG5Thx6YSz8TbWBOFR/TGm1TcwlT6uRAkAbaqXdg3ILJHxNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzecH6iFk9ko4LIcmMLs5dLIYsv1ydcf/QHRyexewSHePjG54+M
	/fXD14P7A+kO11tLpAVGk/DValS4bkKECUYXCU4BuHXzAAs6svW/XelB
X-Gm-Gg: AR+sD12ig0d5gNIbpp4RdF4dUbbXK4cwFWQh8PhyCAnEpXRS21cQMvfedd3XFK3QUTb
	mHOIvbioCQf/ywaMWSpuEFzAfIdLAwkxTOf0tw0yySYbt63Z7Bcouyy90QH+XbLyZbaV9zMUojB
	MtFTSB8S50cZHy6F15+2Bkcbh0xCRsrPg880T0LGJEN2NMur374uoCfYx6UplVxTlnSCn+RtXAM
	Ply5e4ihYjqC5QjtfF0dyf3O/Jy8YRohO1ITVXfYVMGYn4SsiJzy83Em+LAR5tI2gzoA4BP9DJn
	bx5tzQ+eTC5nH7byJpgfuBFKCaNir0CkmU8Qf7TTi/0TopOKXGhMDW/l2+yClw17PfgGz2pfPBP
	An7IcZJcTr7plsIT/d9GOUQ5dxPh2cg7d75BDGAn5uP5HcIMLAtAaLE2iCM2RYOtK580W+j3p98
	qSVKDogpDpS50cJ5eIxF5uiTfixq9E3MtCXvumNAXJPgg4CCciK8kixqUiz1KErPL4PQGWgptuv
	5mIxOFZXSBRWmDa9gF7cvGltiFsrTwKpRXINpfRBzuCbgVAbfZYIJAI2vM86o1hH5HymtjWEYBm
	udqHEEMEqvnyIO2fH43cgLVdvB86+vPcq9LjKA==
X-Received: by 2002:a05:600c:42d4:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49959fddc5emr4260805e9.1.1786017797413;
        Thu, 06 Aug 2026 05:03:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e98fdedsm127208355e9.4.2026.08.06.05.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:03:16 -0700 (PDT)
Message-ID: <6fb5da63-526f-450a-ae8d-6a7d97f1bcf4@gmail.com>
Date: Thu, 6 Aug 2026 13:03:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in netdev_queue_get_dma_dev
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <6a71f80c.40259c87.584f4.04b9.GAE@google.com>
 <20260804140006.0210f6ca@kernel.org>
 <0a419b0b-18d6-42a4-962d-301ddd9d4498@gmail.com>
 <20260805165817.7e1fc367@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260805165817.7e1fc367@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 00:58, Jakub Kicinski wrote:
> On Wed, 5 Aug 2026 09:51:10 +0100 Pavel Begunkov wrote:
>> On 8/4/26 22:00, Jakub Kicinski wrote:
>>> Hi Pavel, could you TAL?
>>
>> It complains on not holding rtnl, so the netdev should be not
>> qops-enabled, and we acquire it with netdev_get_by_index_lock().
>> It's going to be rejected later, but not sure whether netdev->lock
>> protects its device and leasing logic well in this case.
> 
> Hm, I see.
>   
>> As a quick fix, let's fail it early in zcrx if there is no qops.
> 
> I think we can switch the lockdep check in netdev_queue_get_dma_dev()
> to netdev_assert_locked(dev)?  Nothing should be calling that function
> under rtnl_lock so the _compat() is a brainfart.

The assert was useful in this report, i.e. flagged difference in locking
expectation at least for me. I was thinking maybe
netdev_queue_get_dma_dev() should fail. Or maybe even
netdev_get_by_index_lock() is the problem; it's odd for it to
return w/o rtnl lock with a device that expects it, but perhaps
I don't know what dev->lock synchronises for !netdev_need_ops_lock()
cases.

In either case, I'd just fix it for 7.2 for now and defer figuring
sth nicer for later.

fwiw, devmem tcp seems to be fine as netdev_can_create_queue()
should check it.

-- 
Pavel Begunkov


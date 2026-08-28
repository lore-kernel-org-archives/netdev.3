Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DD37187C
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912588; cv=none; b=EP0sOpiURQcKaCqRTC4VU4O02Ltlb446teghw6VXQ/sy84gepXW/Y/oBCuDAsnf9ZRyOEjUDk2jIU8fRj8sp6zZsdmwA/ooMpiubEDZvzBzrfwAV7q/DhQ4xKonLLQFY7E0UUovLS84XKGI7A/7dP6qw3OAtbIw5cNps9TdoEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912588; c=relaxed/simple;
	bh=EfQtWsR8HhNL/FTZFFNCO2u47LKPG7z6X31K2hLCtXI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WylKZX4WaXODQgxKmZbjadgdNu7N7LwFGN+piriiOpdi0VlL2fYz8gZL+XcsbrQRt7N2Vi1yhLAePLBCwE/ZpvHvMVMCcXZU5W+pk1D42L1KnLs4hIHObeYN89AzUSGbt1E9O5YVkEkDPWn6GNwi2DHuLFVTC9cqeJIb91ttac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=enTTJrnC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="enTTJrnC"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482e61a34e5so296119f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787912585; x=1788517385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud1SVn2U/zjHi4VSWIq5F5o3aDeRY2u2GtAjGiMvvok=;
        b=enTTJrnCy2ayi4dRWe4RCSOzfzTJ04daSBCBPlYzRUjSAkxTJi25TF8AU/fOFXqVJj
         UzfhcWBtEInaD+qjJiVTUpnj+sgKiTzr3ldR6/BmkLaCKEkTw1P8j9SuD8CDOMup+Mji
         S8873gt5bSjEZ2DDIaPppW+UBGf0NEF2R6f5T4LTJksZGLRkoe+A/Xc97eYGrIUuXCh5
         HdGgFhlLlQ/iJvvkvhi79vvk7q/LNlotZ6xC3kUeIb76Eft91HIQbQ/fwjJVAmWC87EE
         FQJ5iiitG28JTgU69DstuRjWQAjaG7cyvSHKuJSKNM/xoSjyU9d8UghI3ugEN+zChti9
         8yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912585; x=1788517385;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud1SVn2U/zjHi4VSWIq5F5o3aDeRY2u2GtAjGiMvvok=;
        b=dr6+w3sRTq5u+l12SA0K/pUu9A+TrOy/KwxfYtKPVaHRjaIWiGBz6uSAxnzXKB4DnL
         44Yfd5DfR34pknrrZOR4vbI1YtZlAsNHe7sf7v+a+l9MirjaBgv3G+c86QMlO3Sv/VhK
         7JRjvVUyWk+kFm/bV8I7GzrksQwsYex3r7poqfWnsPL9Zkzl6qF9QD+VWe5h6b6j7QFG
         OI1GPfQazmdacw43w6P5tylqo1vwz4+VlsRhtxWxQ1ME6ybT/mPRgJbRhitg0on38jAc
         Li//v+oEAPYpoGrH1ptlh2cmS/VU9JDhJMGxQCdZL2qM8y2xrIXtRamHjfo+TeVrqLdL
         3Gsw==
X-Forwarded-Encrypted: i=1; AHgh+RpQ2iT15r8Fly1sro/LeUEt/q+gdeskc/hD0dEBrEIKrxvVHk8jZ/fovP7ORfWeMh0H0ckjjl4=@vger.kernel.org
X-Gm-Message-State: AFuF++lx7JrddbDMEjjIEbYMKCLIPg+G7mmNEvih91OR7Ur3uRCsiI9M
	6zgEOQbNE9cSTsOFLhJz5Pn0XykH9DiT6cVVVXmFrzn7f0WiO5emzDkgNNNgyDpAkNw=
X-Gm-Gg: AR+sD11+GUZuQOTuE0U7xH/zQj+K+WWjTddU7PTULSqZdnBRne0gZ9uhTpYffsp5zAT
	7zKoWewy0P8+Z4OxL8FonU6d49OwY4PvTN9Kb4k1MG3s8YFRjNix+zwT686MaD6GNhyT8VysRZa
	b0UjzaeYY+z1sLqQOT45ZHkVf5dSJhTypWoW6zKSEuXaKlbkX20EMUV80kmuJWCCN5qBfEiTCZs
	voCvMBsEMDIs/WPXRcRpdRV1Budt5JBSfJCWiS7UO8jjMTPHkXZ/cPw5D4bI0LKuvnsptiTzBIl
	cPBdX58Bf6hPtazLrGxgAXz3m+qOnj4h7smWbyTNDSTQC5FA36b+i/sAq2NEv8NNLSdDlgKwHW/
	Ld9S47qc6wmeiq1HV//UM5fHHSx0Y4ZVphWfnRYdnPAR8YJ8SQEaodfNgi5xgsYljaroVujKllv
	MeDGCJSSY79EMSjKssWSRqWp4EEZGk85UQwS6bZDi6DO9g7MeDqlhLeGluNs7EA5xFdRPWTVNUG
	vf4ZnrQ1XGX3yTECsQ=
X-Received: by 2002:a05:6000:2401:b0:482:dd67:3a57 with SMTP id ffacd0b85a97d-482f7989684mr7352129f8f.4.1787912584753;
        Fri, 28 Aug 2026 03:23:04 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab5a2csm2775134f8f.4.2026.08.28.03.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 03:23:04 -0700 (PDT)
Message-ID: <6c1c6972-c212-4139-b629-4603a8801cbb@blackwall.org>
Date: Fri, 28 Aug 2026 13:23:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Yilin Zhu <zylzyl2333@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, horatiu.vultur@microchip.com,
 kuba@kernel.org, henrik.bjoernlund@microchip.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 ronbogo@outlook.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
 <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
 <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
In-Reply-To: <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/05/2026 11:09, Nikolay Aleksandrov wrote:
> On 12/05/2026 08:21, Yilin Zhu wrote:
>> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>>
>>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
>>>> On 10/05/2026 12:15, Ren Wei wrote:
>>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>>>>
>>>>> CFM registers a bridge frame handler when the first MEP is created and
>>>>> unregisters it when the last MEP is deleted. The registered object also
>>>>> contains the hlist_node used by the bridge-local frame_type_list.
>>>>>
>>>>> The CFM frame type is currently global, so enabling CFM on multiple
>>>>> bridges links the same hlist_node into multiple bridge-local lists. A
>>>>> later unregister on one bridge can then operate on list state belonging
>>>>> to another bridge.
>>>>>
>>>>> Move the CFM frame type into struct net_bridge and register/unregister
>>>>> the bridge-owned object. This keeps frame handler list membership local
>>>>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>>>>
>>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
>>>>> frame RX added.")
>>>>> Cc: stable@kernel.org
>>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>>>> ---
>>>>>    net/bridge/br_cfm.c     | 14 ++++++--------
>>>>>    net/bridge/br_private.h | 18 +++++++++++-------
>>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
>>>>>
>>>>
>>>> I think MRP suffers from the same bug, but I also think we can contain the
>>>> fix within the packet type structure instead of making the already huge
>>>> struct net_bridge even bigger. Also, linking a struct within net_bridge
>>>> to a list within the same net_bridge looks weird.
>>>>
>>>> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
>>>> dynamically and link it, then br_del_frame should take a type instead of a ptr
>>>> and remove that frame type and free it with kfree_rcu. That would require
>>>> br_add_frame return value to be checked in the respective cfm/mrp functions.
>>>> Warnings for already existing types on add or missing types on del should be
>>>> added.
>>>>
>>>
>>> Actually I have a better idea since these handlers can be added only once per
>>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
>>> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
>>> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
>>> not compiled in. Would you like me to prepare it or do you want to give it a go?
>>>
>>
>> Hi Nik,
>>
>> Thanks for the suggestion.
>>
>> I'll give it a go. IIUC, the idea is to remove the shared
>> br_frame_type list entries for CFM/MRP, track their per-bridge enable
>> state with bridge option bits, and dispatch the CFM/MRP handlers directly
>> from the receive path when the corresponding EtherType and option bit
>> match.
>>
>> I'll include MRP in v2.
>>
>> Thanks,
>> Yilin
>>
> 
> Great, thank you. That should simplify the code and give us 8 bytes of Rx hot
> cache line back. The important point is that there haven't been any new
> handlers since these were added back in 2020, and also these are not
> common, so making their impact on the fast-path as small as possible
> while fixing the bug sounds good.
> 
> A quick & dirty sketch of the fixes gives me:
> 5 files changed, 47 insertions(+), 66 deletions(-)
> 
> That can probably be improved (i.e. more deletions).
> 
> Just please make sure that if CFM/MRP are not enabled in .config, they
> would not affect the fast-path at all.
> 
> Cheers,
>   Nik
> 

Hi Yilin,
Are you still considering fixing these problems? A few months passed since
we last spoke.

Cheers,
  Nik



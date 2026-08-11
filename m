Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EF416844
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481168; cv=none; b=brmCZJFrEFW929AyLp8JoGs8gaDGd9f+Dw57pcm6I8oZr1gmlOErZ+7J9ZJB4P48fhltOyD2/Dz1vIJ0GhJJkbXttNblblKjL7cXGbDhBW1Xo3uL9M1C2jYvYIMoZIbzVFBRdrDJImDdJnOM6stMod7aNEU6uf6XdBmx9i70+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481168; c=relaxed/simple;
	bh=LrvLJfAY7L1vt9PcHDjiJhIvMvofWRrRsBxg0y51ekI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqFUI9487olLwgdpmdzztP1a+oHU5embtl38K3US0QrhbcuXQiDLD+YgEWIfHiUXsmHr5FQZACaXqRH6PcpyugImTTAYJZktyZxZbTaEXymt5tJs2D1Apk6+/+g0jNxkdc+/cIpLeMInPDn3nOPGQ83VfGHNnu2CKMxPZ6ZNcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso41052f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786481164; x=1787085964;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Z1sd/UmWsFc+oR/gAfLE+mwCaN52YEqoKnHBCL8tTo=;
        b=mG4v2fiSeoqRnihBLZJJoe9tuKQ3AZ7CK6RvLqG1zg4aSYbUrk2nWlPYL+SE7S2aY3
         GbSGHmlIIG3XJqsWSNwCEIfhODT+hj5kTtwgd6p5msDmag4Ff2Lry6t/DUvGbkFXI+ky
         ClddNKK+s6iXjrffPlYZ+ReHA+f8McEXFHfeu2N/TSAWKM2568GkN+ZPq4TW9jq9AO5p
         2Ua7gTVGUTr5mNHfUwfPwkyNpGXgTII0GgKLf6LB72CZR9sbVPGwIBIsqVaJWt4PpMX1
         mE4IW79kltZ3pOPGE9xZmGhZpqV7kzVON43AMRwmO/tLVn79JCtBUq28m4XU/62aKoxh
         jYGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9UNfIrq6CHSRE24pawK454LINElZIFlGOtBSqRttRUQUczQl42JJFJhFbIbfDZMQFfO0jJrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKAZov8UE0Bv2NxnJSdFi+fBTW+4mfyhJnUzvBaqZbQeaalTU
	t2e1pcM2QQY6Cuk48ao0w2OHyN5N1LQ/krpGm9KOaXQ45dZmFCx1Qiym
X-Gm-Gg: AR+sD10qHN8UFGIVkinJ58n9+kc+RQwmAMVXGjgZijtZAkObgPieIUDjgLRp3yZcNjp
	8ja0wfDQhxxGgHgtwZRy7NSuVHc9gOi5m+19uEs6M1rz9rG3/snJxzLL5TNg30n2AN2Dh2DIll2
	p23diL9Sx9umkL274bTeVTH6Qpjqs+Mc8SIPiHIwW0Mj2E4gStMe5fRtRtwCVOw/ltn+VFz5plG
	IPYh1rLevhyy3Ytzn50Qv9ZJEoxBGWtQQhUQ640PnVvSGXiUeMq6EO3nn5Ly3zL5xFH4bPr5/aY
	8OhmwZc5i8SxzCWaARUJ+j7CEZjdds+yZzKYgy/izbpKFc60vJBcS6H3CqtDWfyk9vNxLCYaoLK
	9v+7pc61knLVR0t1YO6tKCI4S/P6ouABq92XMxOAmUtY7XQsVSBLcOMs+nIeF+wN1CT1eQg76P8
	tASBGUORnuvNuyjpeIJE7oCC6huA5Qnq0GaiNF6FyZyUonPhP6fkMIBybj6rkSLSROxZ2fAb9yP
	dXec+EgYwLR0FjcRA==
X-Received: by 2002:a05:6000:2c06:b0:47f:9441:51b5 with SMTP id ffacd0b85a97d-4814ad7b6damr8946439f8f.5.1786481164448;
        Tue, 11 Aug 2026 13:46:04 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d7010asm1110105f8f.33.2026.08.11.13.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 13:46:03 -0700 (PDT)
Message-ID: <d91a2ae3-2aac-4fab-b041-d3004ffad39b@ovn.org>
Date: Tue, 11 Aug 2026 22:46:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Ilya Maximets <i.maximets@ovn.org>, Yuqi Xu <xuyuqiabc@gmail.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1786441097.git.xuyuqiabc@gmail.com>
 <3085b885bb348a9245c5c84364fea903d9942863.1786441097.git.xuyuqiabc@gmail.com>
 <d7471dde-43f6-4c31-a380-8a3f91b26d59@ovn.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <d7471dde-43f6-4c31-a380-8a3f91b26d59@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 4:02 PM, Ilya Maximets wrote:
> On 8/11/26 11:55 AM, Yuqi Xu wrote:
>> Packet processing uses CT limit state under RCU, while netns teardown
>> frees that state under ovs_mutex. The CT limit pointer was neither removed
>> from readers nor protected by a grace period, allowing packet processing to
>> dereference the freed state.
>>
>> An unprivileged user can trigger this bug from a user and network
>> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
>> netns is torn down.
>>
>> Publish the CT limit pointer through RCU, remove it before teardown, and
>> wait for readers before freeing its contents. Keep ovs_mutex around
>> individual CT limit updates, and use the RCU read-side lock while GET
>> traverses the RCU-protected limit lists.
>>
>> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
>> Cc: stable@vger.kernel.org
>> Reported-by: Vega <vega@nebusec.ai>
>> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
>> Assisted-by: Codex:GPT-5.4
>> Co-developed-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
>> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
>> ---
>> Changes in v5:
>>
>> - Remove unreachable command-path NULL handling because netlink sockets
>>   keep their network namespaces alive while requests are processed.
> 
> Please, add a note to the commit message on why the NULL checks are not
> necessary for the code invoked from netlink handlers.  Otherwise, LGTM.

May be also worth explicitly calling out the synchronization while holding
the mutex.  It can be avoided, but should likely be a separate change.

> 
> Best regards, Ilya Maximets.


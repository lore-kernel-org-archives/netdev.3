Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2F4746CE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719174; cv=none; b=g1CqAVRZZhff424d9ltA0FurwXnUy2TgUMgerEYxuFrKcetzIrr6OZRDgpXW0jtBRbtZmG/kK+tW5segcXmcagXAFNFc3fwj16JKea5ZZYzJdghVWtU1meIEYYhlmikm/QroUEoYwVBJJh23Ijmv6Jpow9oVn3PlG1w28Zx8Y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719174; c=relaxed/simple;
	bh=g/Gw848JXxdNuh+VjCbMWhnuGqydbkkd8F28iGEFmbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8G/l+yScWU/6Ftqevow/RJEaPzZ0mekDvFimnC0qbVJnor6b/j0WYrK/iMDIrKJihGqlk4aHBtSF0dFyrSWUXwFtf28OmZYtlsADkjuzbckQJdI+uEB1oyqEn8EuXaro4b6Y39513dHqL0m76rU+mmwZtFNQEYKJNL+US8aUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15ef474e72so46495166b.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719169; x=1787323969;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAQfQVPAqMa3KLc7IjUyNhl9yD/CzjtmZf6XA3tM6Ks=;
        b=C/OQzmte6IwDEHQHLq08E7mmljut/Cq3H4luyd2ZlCMRbN++kHNu3wUBgxmGaiyYlK
         eAFtiEnx1A776iIK5WvgJjKt+3+M24Ew3Bf8s2lx4TDX0zfdubuEwD8FgznQKTsBa5A0
         hiMMaKdSUzEZ3UDozskMzvoFqlbT8cY669L4nhD75Bq6TFN/WvL68ZMDwskuu8eA2Km1
         j9DPc/x/+f9lhOrvLNIPWrbAlC0OYxAKif/jN7UjPrqiD1VgVxOsvRazjXoOmjfPV+Yo
         eW1gd0EREKOhQQH/zhKzYhakjTatzefzbtXjJniHCDW+G46kY5MnmRNAUuFM9jXCPHnm
         0B1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqJ9iu/OmcovrJdNjCIHohR3qEqWpbJQAKtfvBsB6+Fj2p6A9nHaMWvXm9p/3M0elvq7bmVqpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8J1txN7zOClIjD+FltMb0wdl6T8VeBJdq178Tuop00Ee+PmxY
	ubiBlMlLSJkrmbznZ7T8xWgJT5tqC+M0Dn2bJA4cFU9+0TmRDDowfTY7
X-Gm-Gg: AR+sD10yh5s0H91zyznr0m3LUAhJ5MhYYaZFA38vBXrM3h4r6NbuSiJnlApmrrm4wQ4
	t9/L7VaeVMqJKpqEe390EIZQn8J9IUhO/juu8aw49EZvOH2WiE12UyqTEYrj7dncSy98dpufW0i
	rOuRfcGbmySJ32ltvLw/kn1WDhc4Q11wR3JM8xQ7bryK6lwacWdHVMHZjLXvKnTfREW5+dap06u
	iAXFy3uKQTWIUZXZpVCevB07StjA5taiEhxyEY1MEZQci37ZYCJjGOTBDEgKZwRiTsiXcucStr7
	X7yPlV4DpCvmqgHNEANDFPJsovVOPuUbqHuBwCb1iHkr8z/Cysb6JFibOYJP92AmHMJ38vo5Lgp
	h1HXdA2XoHK/u27IYMcRbLYcXeaVuY8D7YiBgsbBxQoldxXjupiwyW3A/dMizVzt106Syu5EBqY
	330cOxLebJkrourDhh7HtDvLp0HSete8nko9HGDUyo82UIwJl08Q+QId6n+kqfRPr+EocZL33WT
	JzRmyoz/KdRPBlO
X-Received: by 2002:a17:907:e002:10b0:c21:34a3:4d9c with SMTP id a640c23a62f3a-c2134b2e09dmr146940766b.21.1786719169075;
        Fri, 14 Aug 2026 07:52:49 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123821bfasm114089866b.51.2026.08.14.07.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 07:52:48 -0700 (PDT)
Message-ID: <f45ede29-44a7-4fee-bef3-e4a1f0242a7b@ovn.org>
Date: Fri, 14 Aug 2026 16:52:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] openvswitch: only skb_tx_error() a packet we are
 about to drop
To: Norbert Szetei <norbert@doyensec.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: Willem de Bruijn <willemb@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
 <b20650c2-1adb-4902-b2b1-9bca91b95dec@ovn.org>
 <741D4072-50EE-437B-BFC3-CDFE94C93F8A@doyensec.com>
 <00a1176a-8b1f-47b1-9376-349cd08ad313@ovn.org>
 <C8A61CEF-FB36-47FA-A38C-5BA0968D6CAA@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <C8A61CEF-FB36-47FA-A38C-5BA0968D6CAA@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 3:40 PM, Norbert Szetei wrote:
>> On Aug 14, 2026, at 14:31, Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 8/14/26 1:01 PM, Norbert Szetei wrote:
>>> Thanks for the review. Sashiko flagged
>>
>> Hmm.  I do not see any reports in either of the instances.  Do you have a link?
> 
> https://sashiko.dev/#/patchset/C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com

Thanks, looks like I was trying to search using the patch name and it
only searches sets.

> 
>>> that the moved call may still be
>>> reachable through the RECIRC action, and I confirmed dynamically that it is.
>>> With 1/2 applied, a flow matching recirc_id 0 exactly, with actions
>>> RECIRC(1), OUTPUT(0) instead of USERSPACE(unbound), OUTPUT(0), reproduces
>>> the same issue. So please hold off on 1/2.
>>>
>>> Moving the call to the "default" branch assumes that branch only sees a
>>> packet the datapath owns. For a non-last OVS_ACTION_ATTR_RECIRC,
>>> clone_execute() does
>>>
>>> skb = last ? skb : skb_clone(skb, GFP_ATOMIC);
>>> ...
>>> ovs_dp_process_packet(skb, clone);
>>>
>>> so a clone lands there while do_execute_actions() carries on with the
>>> original. The clone shares skb_shinfo() exactly for the skbs this series is
>>> about, since skb_clone() -> skb_orphan_frags() returns early on
>>> SKBFL_DONT_ORPHAN and does not copy the frags - so settling the uarg
>>> through the clone clears SKBFL_SHARED_FRAG for the skb still being
>>> forwarded.
>>
>> AFAIU, operations on a cloned skb performed via proper skb helpers must
>> not affect the original.  That's the whole point of the clone.  However,
>> in this case indeed it looks like the skb_tx_copy() just modifies the
>> shared info not checking if it is shared or not.  And this sounds like
>> a bug in skb_tx_copy().
>>
>>>
>>> Removing the call, as I originally suggested, does fix this in my testing.
>>> If you would still rather keep it, how would you prefer to solve this?
>>
>> Just removing the call from openvswitch module doesn't solve the problem.
>> Packet may enter OVS already cloned somewhere else in the stack, and at
>> any other point in the kernel where skb_tx_copy() is called it may be
>> operating on a clone of some other skb causing the exact same issue.  So,
>> it needs to be addressed inside the skb_tx_copy() itself.
>>
>> On the other hand, reading the history of this function, it seems like it
>> lost of its meaning with commit 1f8b977ab32d ("sock: enable MSG_ZEROCOPY")
>> from Willem that changed it to just call skb_zcopy_clear(skb, true);  This
>> changed the "false" signaling to "true".  So it doesn't even signal an error
>> anymore.
>>
>> Later, in commit 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
>> Pavel added skb_zcopy_downgrade_managed(skb); call that takes extra frag
>> references.  Though it seems pointless for an skb that must be freed right
>> after.
>>
>> So, I'm not sure if this function is useful in general.  Feels like it is
>> only harmful as it directly modifies shared data with no regards to clones.
>>
>> We have two options here:
>>
>> 1. Minimal fix: add something like skb_cloned() guard into skb_tx_copy().
>>
>> 2. Remove skb_tx_copy() entirely (all calls and the definition) as it

* I meant skb_tx_error(), of course, everywhere above in place of skb_tx_copy()
  that is not a real function...

>>   seems pointless after 1f8b977ab32d.
> 
> Thanks for digging out 1f8b977ab32d.
> 
> Option 2 sounds cleaner to me, though it touches tun, ovpn and nfnetlink_queue
> as well. Option 1 would not cover the reported case on its own, since there is
> no clone on the OVS_ACTION_ATTR_USERSPACE path, but it should work with this 
> patch 1/2.
> 
> Curious what the others think. I can write whichever you settle on.

If there will be no other suggestions, I'd say what we can do is to have
a minimal fix for net and stable, i.e., a 3-patch set with 2 current patches
plus the new skb_cloned() guard inside skb_tx_error().  These should be
simple enough to backport.

Once those are accepted, we could remove the skb_tx_error() from net-next as
a follow up, so it doesn't muddy the waters moving forward.

> 
> N.
> 
>>
>> Any thoughts?  Willem, Pavel, others?
>>
>>>
>>> Thanks,
>>> Norbert
>>>
>>>> On Aug 13, 2026, at 12:00, Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>
>>>> On 8/13/26 7:47 AM, Norbert Szetei wrote:
>>>>> queue_userspace_packet() borrows the packet skb -- it only copies it into
>>>>> a private netlink message (user_skb) and does not own it; on return
>>>>> do_execute_actions() keeps forwarding it through the flow's remaining
>>>>> actions. Its error path nevertheless calls skb_tx_error(skb), which via
>>>>> skb_zcopy_clear() does skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY,
>>>>> stripping SKBFL_SHARED_FRAG from that live skb (skb_tx_error()'s kerneldoc
>>>>> says "skb must be freed afterwards").
>>>>>
>>>>> For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
>>>>> what makes esp_input() skb_cow_data() before in-place AEAD; once it is
>>>>> stripped a later local ESP-in-UDP delivery decrypts in place over pages
>>>>> the sender does not own -- an unprivileged page-cache write (the
>>>>> "Fragnesia" primitive).
>>>>> do_execute_actions() ignores output_userspace()'s return value, so any
>>>>> action after a failed USERSPACE upcall inherits the stripped skb.
>>>>>
>>>>> Move the skb_tx_error() to the flow-miss drop path - the "default"
>>>>> branch of ovs_dp_process_packet()'s switch(error), before kfree_skb().
>>>>>
>>>>> The call has been here since commit 36d5fe6a0007 ("core, nfqueue,
>>>>> openvswitch: Orphan frags in skb_zerocopy and handle errors") but was
>>>>> harmless until esp_input() began relying on SKBFL_SHARED_FRAG to gate
>>>>> in-place decrypt; only then did stripping it on a still-forwarded skb
>>>>> become a page-cache write primitive.
>>>>>
>>>>> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
>>>>> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
>>>>> Cc: stable@vger.kernel.org
>>>>> Assisted-by: Claude:claude-opus-5
>>>>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>>>>> ---
>>>> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> 
> 


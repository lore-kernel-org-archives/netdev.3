Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332838C423
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735717; cv=none; b=L+Eh5Bi17ljRl0KCx+KZ7XL9lVn7kxWQ2i5QT8emIWtsPLDp88M1a6d5+7DPK2CDOxj/6lKltYVkC2WdPIR2AmJmOWfW68hvMs0iZqJtgfiU/2crTlfTS8BxVTe/hOfJJAWojPDWTwVvI22lJo5fLRSasSBO1/B2VxxooXNGJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735717; c=relaxed/simple;
	bh=tG34KnOtOtty2r9c3ZFO8a/N/vlj/M3nQ86M3rSu+do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCGFYiMQndlv8KKCCqTnoFWTZhzCAXSVaPFxUqUwVRLUxHrh/xV8pLxWEr9kg9OMg518UBRqTWtDqxvhXBDz1XO6DRLHh3kmTR5eg/4mJihfphaUE0odjOC7IeAugVeoNhPvXasZhQ/jipvhaM6aKbJ5QpEfvU2EApxL1kdxb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so4784855e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735712; x=1787340512;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xfB7B/KQ884Jy/PAQTWuh17GQPWSAVFUTPqPdhSC2U=;
        b=TF6+vqgC7v8m6urKid6wjnnln9L/d1Uh+h3qFPvZVdkyGXzFbobYcCowUWEcZEL2x4
         3l9RQp1E6NvMXXrzwgjrInN20siaDizZp/ANQF6MYiJKeqGvgJnuhmqZcVjvpSIH9pKJ
         n/KkhglbOMErvJCpO9QJPHeGjtWUY1GGuAaFJgmPk7VgalaSkhQmHQ/4lK1lEqX7M5iZ
         kXfnHUIE5+iPrhkdlB44jki79O5O5esICCSax8oycBXqBO7gqLy7EUAlYaS+b6DsNcWW
         77hhc6QPfBz7sNDLVNOZpq0EGDMRB3xNUXwQPUYJvg2Gv0PY/GRp0qcEPkqwqMQBgDid
         DumA==
X-Forwarded-Encrypted: i=1; AHgh+RoPp8svswGEtA2oFeXgteJ9Q0+U8Ux3Qti8Unu8QF3PHVyCuwmDEGsM8aGoUbfjuw5P9ppr8so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKYYOrdGChc7TlOp7b6c//wEOclSugf+Y6BsoM3LlfKHiJade
	j6r7Ip2crngod15BchpZ2ZkRGLfj1De+xiCNkl28aUlROw6qCb+BDmee
X-Gm-Gg: AR+sD12izUqVcamq30ds5xJP1O+lMvQGoavTznLd3xoVH82Gwu00iPUi0lbmPEwTzat
	iMZ9LK4olnhIJQPpjn1aYryyt24Q27ph83RJhuIXAaWxouBz7MMnWw+nmCuZDhGyZhT9HFJUrQG
	c9iVhFZy1Ijbu8Y4WG1pQB7RsdRqPGC9k4p4f5S5Bi5tiIprJwYaPYhX/bULqYoATterE7xrD6Z
	EKv445VsELZzMvHph77MI0P/oYoZIDEohbxLiX++VPj4gOJfi1i20ip3T7/tyELDpc7SDVmnWUI
	g1jZPDVW1DyYL5fC3yrW6qdNwEErKXY8yqgnzWoP/cZtY5W3cV9bs3icHIWA3GjvD/W4qP8J7h2
	Mu/eYmQE41W1iu7XrNRTbQ2+7GrqnurAKnZ/q3Yoc3OSJQYWf1sWXfuz4l3wo3VJYChzLTNI9X7
	Pr+AnRWVxCd5YWBr/Rr7npa8qa+D38pM8hSPh0MwcrHFUZL4F17zvNGVjYPn4VQ0KUitzxrIAAH
	afoJH936umLCe7/
X-Received: by 2002:a05:600c:5494:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-499879a52aamr108993665e9.14.1786735711724;
        Fri, 14 Aug 2026 12:28:31 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc811sm10355039f8f.33.2026.08.14.12.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 12:28:30 -0700 (PDT)
Message-ID: <a7e1ce0c-4c3e-4fbf-b9f9-da4e9d42c4ef@ovn.org>
Date: Fri, 14 Aug 2026 21:28:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: core: propagate unreadable flag in
 skb_zerocopy
To: Mina Almasry <almasrymina@google.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Eric Dumazet <edumazet@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>, Florian Westphal <fw@strlen.de>
References: <20260811195405.3979177-1-almasrymina@google.com>
 <e532f313-447c-4ac5-806d-b686bc9181dd@ovn.org>
 <CAHS8izNahtYM3AFvbNa_coHMb9n_uOz7dJNUQ4LaLpRwmWQQkg@mail.gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <CAHS8izNahtYM3AFvbNa_coHMb9n_uOz7dJNUQ4LaLpRwmWQQkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/26 8:48 PM, Mina Almasry wrote:
> On Wed, Aug 12, 2026 at 8:52 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 8/11/26 9:53 PM, Mina Almasry wrote:
>>> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
>>> index ae69b2cabab9e..482893a5f67dc 100644
>>> --- a/net/openvswitch/datapath.c
>>> +++ b/net/openvswitch/datapath.c
>>> @@ -467,6 +467,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
>>>       if (!dp_ifindex)
>>>               return -ENODEV;
>>>
>>> +     if (!skb_frags_readable(skb))
>>> +             return -EFAULT;
>>> +
>>>       if (skb_vlan_tag_present(skb)) {
>>>               nskb = skb_clone(skb, GFP_ATOMIC);
>>>               if (!nskb)
>> FWIW, the devmem integration doesn't seem well-designed.
> 
> As is most of what I touch :P
> 
>>  I understand
>> that it is for performance, but IMO there should be a way to copy the
>> data on a slow path to avoid dropping the packets.  Clamping without
>> notifying the users that the packet is truncated is not a good solution.
>> Not for OVS, not for other parts of the kernel networking stack.  It's
>> a uAPI breakage.
>>
> 
> FWIW, it happens that the fallback-to-copy in the context of the
> devmem TCP seems to be useless to the userspace. As a matter of fact
> there is one current path where we fallback to copy/CPU memory
> (SCM_DEVMEM_LINEAR), and my users decided to write userspace to
> completely barf on that condition. We ended up rooting all the reasons
> SCM_DEVMEM_LINEAR could happen and preventing that (mostly flow
> steering failures in our case).
> 
> Broadcomm also added a devmem kselftest test case that fails on any
> SCM_DEVMEM_LINEAR as well, so I think they may have independently
> reached the same conclusion with their users.

Just for the context on how OVS works: the very first packet, e.g.
SYN, goes to userspace via this upcall mechanism, then ovs-vswitchd
runs it through the OpenFlow pipeline and figures out what actions
to take and where to forward.  Next it injects the packet back via
netlink request to execute those actions and in parallel it installs
a datapath flow into the kernel.  The next packet that matches the
installed datapath flow does not go to userspace and gets forwarded
inside the kernel.

So, in theory, very few packets go to userspace and the rest stay
in the kernel going through the fast path.  In this situation it
doesn't matter too much that the first packet takes the performance
hit as long as the rest are not.

Depending on the OpenFlow pipeline the syn+ack and the ack+psh may
need to go to userspace, out of which, I suppose the ack+psh is the
most problematic as it carries a large payload that will end up in
the unreadable memory.

In this situation, It seems to me that being able to copy the data
directly to the userspace would be useful as it would not have any
performance impact on the fast path and will allow openvswitch to
work normally for the most part without any changes to ovs-vswitchd
in userspace.

Best regards, Ilya Maximets.

> 
>> As it is, there is not much we can do here without extensive changes
>> in userspace applications, so for this OVS block:
>>
> 
> But, a future user could find such a fallback-to-cpu-mem useful. If
> anyone is reading this wondering how to implement that, these are my
> rough ideas:
> 
> + some dmabufs will support the dma_buf_vmap op which will map the
> dmabuf to the kernel space. if the dmabuf supports it, we could use
> that op to map the dmabuf memory to the kernel space, then copy the
> memory to a normal page allocated from a non-devmem page_pool, and
> create a readable skb based on that.
> + If the dmabuf does not support dma_buf_vmap, then I don't think
> there is any copy fallback we can do, sorry.
> + We'd need to design a uapi that tells the user that this particular
> chunk is in cpu memory. My guess is that recvmsg() needs to return if
> it notices a devmem/non-devmem skb boundary, and return early. Then
> the non-devmem skb can be given to the userspace with
> SCM_DEVMEM_LINEAR on the next recvmsg() call. Then the next recvmsg()
> call gets the next devmem skb without SCM_DEVMEM_LINEAR, etc. I think
> that would work.
> + We'd need the driver to maintain multiple page_pools per rx-queue
> then, I guess. One for the devmem, and one for the possible non-devmem
> fallback.
> 
>> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> 
> Thank you! I'll submit another revision addressing the comments on the
> other patch.
> 


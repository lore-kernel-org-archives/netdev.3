Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31744BC87
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710699; cv=none; b=pBk/GhzDnEFpRBDYMO9Yzs7RvfQ8ISc7W37yI4dt2HQDSr5a4pZOxrmstEgWFC4s+t0m6sO8mFYKG0D7nvq9hEWBdLUsbDlu1Y0wRf24jDQ+NOyZ2xxuRfDA0mHfKBBjbnyju5gziw+eFr2o3012iv+tlal8sFZAYFzAEgsIbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710699; c=relaxed/simple;
	bh=qjLkC0II1gWuixXIMLNRItr0stMYFMauGKoO9+GqDyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpQwsvg29Z+yAeI2w/gOzOIAOsYSqKOhVb3j/1YHj8lztcKUTkhwjaf88O89QGgHm3OgOtSx5LAUdlWZgv5Y3Zvm6otHHhyCknTlTHt4+ugk43+i37q9DgrbHKbfj2hVjjMBGRj9GLcqPR99PAuLb8rJzvXpeqWRWc2a80IeDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso220815f8f.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710695; x=1787315495;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwjQek05MIazSEQ3Y5aXRo+nFR/zivlxhlf5ewgEipU=;
        b=B2dgogWM0To8HE4nwv4GLLUc8IgazbdMStN7I8eBVUiZ9RPMieCj1ZRKXKZoqXYjl9
         Wsr6gN7MiA52yMrNxieZDaGitW5UVKqrUjSrDR/j9ENvFlMwJryC9UX0mZvirIGO/vUU
         Igd+KzDVeDzuxASDl0VQgJV1wRXIuQDM+2QYEaiGqZ62mEMEcP9B3dIQpgqrdoTDVnr6
         EQXF7ba9+lymonlfgRLdg9XN2KePCnQsitH2Kx9eqtJij/ncPWgQ/PCcLckvFCqUTIvj
         6j13fH61bLlIsDz2rX7Ax+K+RoEOQwD/FoVvQmvLwLL7RWSGlFeOrUL9AXTgupomlXFg
         rnNg==
X-Gm-Message-State: AOJu0Yx4Z0bxezNL7bv+UwM0gEm84r1/yrlJrBQYPWL9Qyd3zhAqiyyC
	cL+Lx/+T1KMFqla8jyW9ReE1yhcEatQ1Zx7ODgz1kAOBFNuVPo8d3tmU
X-Gm-Gg: AR+sD11kRWxCcBOjOohBQHmAMEoeCB81Tiobj7L81tzMdaS3QKZCtSbTenmp6C/XxpU
	jgdfgDk23VAZxpG7XlJCA7hB2sLzLYs+XLB1wlAvN1DWcM9G69pufAu7rPjuk5M3kLCgdtYoSxI
	QHbIjspZCfG4Ybim0m8htR6nPnBTedZB4P7DgXEmFwmI+tR18obkVtYQhrGDOT3HcE0Ey1+bs7Y
	HzrOUm7xFcTQxTp/J9qYH+Abui2MIiaC6w99qU/G2J1glrdST/tIBDTSzPOXAEcHLLKSQESJAgr
	1oNOXkjTdLnBzj5k9NVxa40/sAlYftiuFhW2aAgLXDso+olJ9AZhZYZ1CRRpzKJOfCbLhMqpTgn
	nRrDE+kEcTOPtXt9Jb5Cvw8VWZIGGKVzOF2oTk3OSES5aAmkuvus5wB7BjMIdH6yLebvZLuJR2X
	JCcpPjbKuV8OCFcDVFiWw/O0UuJ5TaiJWV36qzXNGgHKv6bYrhPhA4mbAiwCoqPCbQvUmBVRR3f
	qJMsPKb9BuOADC0
X-Received: by 2002:a05:6000:46cf:b0:481:5048:1b78 with SMTP id ffacd0b85a97d-481606f7266mr5720430f8f.5.1786710695234;
        Fri, 14 Aug 2026 05:31:35 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c129dsm7841103f8f.26.2026.08.14.05.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 05:31:34 -0700 (PDT)
Message-ID: <00a1176a-8b1f-47b1-9376-349cd08ad313@ovn.org>
Date: Fri, 14 Aug 2026 14:31:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] openvswitch: only skb_tx_error() a packet we are
 about to drop
To: Norbert Szetei <norbert@doyensec.com>, Ilya Maximets
 <i.maximets@ovn.org>, Willem de Bruijn <willemb@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
 <b20650c2-1adb-4902-b2b1-9bca91b95dec@ovn.org>
 <741D4072-50EE-437B-BFC3-CDFE94C93F8A@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <741D4072-50EE-437B-BFC3-CDFE94C93F8A@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 1:01 PM, Norbert Szetei wrote:
> Thanks for the review. Sashiko flagged

Hmm.  I do not see any reports in either of the instances.  Do you have a link?

> that the moved call may still be
> reachable through the RECIRC action, and I confirmed dynamically that it is.
> With 1/2 applied, a flow matching recirc_id 0 exactly, with actions
> RECIRC(1), OUTPUT(0) instead of USERSPACE(unbound), OUTPUT(0), reproduces
> the same issue. So please hold off on 1/2.
> 
> Moving the call to the "default" branch assumes that branch only sees a
> packet the datapath owns. For a non-last OVS_ACTION_ATTR_RECIRC,
> clone_execute() does
> 
> 	skb = last ? skb : skb_clone(skb, GFP_ATOMIC);
> 	...
> 	ovs_dp_process_packet(skb, clone);
> 
> so a clone lands there while do_execute_actions() carries on with the
> original. The clone shares skb_shinfo() exactly for the skbs this series is
> about, since skb_clone() -> skb_orphan_frags() returns early on
> SKBFL_DONT_ORPHAN and does not copy the frags - so settling the uarg
> through the clone clears SKBFL_SHARED_FRAG for the skb still being
> forwarded.

AFAIU, operations on a cloned skb performed via proper skb helpers must
not affect the original.  That's the whole point of the clone.  However,
in this case indeed it looks like the skb_tx_copy() just modifies the
shared info not checking if it is shared or not.  And this sounds like
a bug in skb_tx_copy().

> 
> Removing the call, as I originally suggested, does fix this in my testing.
> If you would still rather keep it, how would you prefer to solve this?

Just removing the call from openvswitch module doesn't solve the problem.
Packet may enter OVS already cloned somewhere else in the stack, and at
any other point in the kernel where skb_tx_copy() is called it may be
operating on a clone of some other skb causing the exact same issue.  So,
it needs to be addressed inside the skb_tx_copy() itself.

On the other hand, reading the history of this function, it seems like it
lost of its meaning with commit 1f8b977ab32d ("sock: enable MSG_ZEROCOPY")
from Willem that changed it to just call skb_zcopy_clear(skb, true);  This
changed the "false" signaling to "true".  So it doesn't even signal an error
anymore.

Later, in commit 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Pavel added skb_zcopy_downgrade_managed(skb); call that takes extra frag
references.  Though it seems pointless for an skb that must be freed right
after.

So, I'm not sure if this function is useful in general.  Feels like it is
only harmful as it directly modifies shared data with no regards to clones.

We have two options here:

1. Minimal fix: add something like skb_cloned() guard into skb_tx_copy().

2. Remove skb_tx_copy() entirely (all calls and the definition) as it
   seems pointless after 1f8b977ab32d.

Any thoughts?  Willem, Pavel, others?

> 
> Thanks,
> Norbert
> 
>> On Aug 13, 2026, at 12:00, Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 8/13/26 7:47 AM, Norbert Szetei wrote:
>>> queue_userspace_packet() borrows the packet skb -- it only copies it into
>>> a private netlink message (user_skb) and does not own it; on return
>>> do_execute_actions() keeps forwarding it through the flow's remaining
>>> actions. Its error path nevertheless calls skb_tx_error(skb), which via
>>> skb_zcopy_clear() does skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY,
>>> stripping SKBFL_SHARED_FRAG from that live skb (skb_tx_error()'s kerneldoc
>>> says "skb must be freed afterwards").
>>>
>>> For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
>>> what makes esp_input() skb_cow_data() before in-place AEAD; once it is
>>> stripped a later local ESP-in-UDP delivery decrypts in place over pages
>>> the sender does not own -- an unprivileged page-cache write (the
>>> "Fragnesia" primitive).
>>> do_execute_actions() ignores output_userspace()'s return value, so any
>>> action after a failed USERSPACE upcall inherits the stripped skb.
>>>
>>> Move the skb_tx_error() to the flow-miss drop path - the "default"
>>> branch of ovs_dp_process_packet()'s switch(error), before kfree_skb().
>>>
>>> The call has been here since commit 36d5fe6a0007 ("core, nfqueue,
>>> openvswitch: Orphan frags in skb_zerocopy and handle errors") but was
>>> harmless until esp_input() began relying on SKBFL_SHARED_FRAG to gate
>>> in-place decrypt; only then did stripping it on a still-forwarded skb
>>> become a page-cache write primitive.
>>>
>>> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in skb_zerocopy and handle errors")
>>> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: Claude:claude-opus-5
>>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>>> ---
>> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
> 


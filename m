Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B83C8705
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787898499; cv=none; b=JR2DK1CmuZuzQedXQwzqt8d9U/Z9qVdwwI5Ul077m6LoKL5D5xsHyXBGqOHbpZFAjTD3jBY1w+SZFZeuOaLhdcUHZCkoS4nrxi03byrYyZthQWg1sgQn7vf8W1zkvYgdeMK1m7bJMeNyce3bLE1yVfUjm96nHdEcJMrM+4gVUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787898499; c=relaxed/simple;
	bh=iylSaV0d0HRd+S2GPFe5/jKSghYie3AtA0Grqnoy3Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8R2kOk2Ag6IcdIkBkUUnqOCRWFDzyyuNMm6SuHO9QtOzH+ExpH/8tStT1NGSK4SBYtjtjkw10zPJ/8AGOHna4okjsd70lqv3m1KYD7TUy6xLe8c3zzw0fpVrAvJezjNN1JQWtvF12ExkCUkOwWzUlyf4qTLFc8UGyxZl3LH5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2WAPh60; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWa0JYMx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2WAPh60";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWa0JYMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787898496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHGnCVhNuLFnG/5OVisM5ogzmWXFPIK5JB6VW53vdI8=;
	b=B2WAPh60GR74CtI3xOzSOHDQ+Pf15pZz/Bp/9ylWpjJnH9YhZ7hLW+wAWRSYCqJApKy9Oy
	/+v+Nfa7tX5I2YlHdEmLeXk1RHWXzkVkGFT4nEf3+RqDjjt2g0R/SVWgCM2XHOBbQry8dw
	/Kqpcq8B9ga6jc19lsDrfHqQDfTyMbY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-o5MP__pVO9GR9hpUbeGNJA-1; Fri, 28 Aug 2026 02:28:14 -0400
X-MC-Unique: o5MP__pVO9GR9hpUbeGNJA-1
X-Mimecast-MFC-AGG-ID: o5MP__pVO9GR9hpUbeGNJA_1787898493
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49991beee7aso3942485e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787898493; x=1788503293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHGnCVhNuLFnG/5OVisM5ogzmWXFPIK5JB6VW53vdI8=;
        b=CWa0JYMx53xORfKNv/JtE8lOfg0NFQ4xCKgFXa0aDsPQKd8nQv12OAjSn2Qyz3JjoO
         X1KoJOJMiOQhoi1xs75ryDCxOe4rXjrrZMJMcnCJICm/MLNcwxNHrHlQ+GV58UXFUQSy
         ia/Hzy+1yMKrIvOMaEgeB+Z+MtU2pHOGWGBTjdQEY9/zFLubNXvkwJRB9qQSDROOJkHh
         1/PSt0vxII6DwCgdFkIhgQxlNbm7LFtzOp3x/4rtrsGEiUJxBn4weGV1kQ+fLmRoJsub
         nkqqEAV9p9uxxvUT/frTlbsfpriunhu606iCha5NYrpepEau2fEaqa1pqb7RpqkfgjpC
         icjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787898493; x=1788503293;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHGnCVhNuLFnG/5OVisM5ogzmWXFPIK5JB6VW53vdI8=;
        b=KI5+UpjBbOj4FNUhYwreAqon6eRlW3Z3ie7Uv7XMbZcQC23Tj3q9in7bjXQMA5KLSA
         Tx7Eug0d9xBoOGnhsu8o4KFANgujgDhJDl1vRlTbwE1ZdUjhR5Kb/AQQMUhn/iaPX/GM
         OwKZ41lLqn0Ig2s6eUK2Pu0edt/z6VOsBlfNd1ZtUcpg2GgPZuNFZb/QFNPINglmPthC
         5m6oOcHBLGqPNiWn3TKScRnUWr+xHen3fJeQqyM59/hAhAFt+Fr48yfbltGovajauXya
         0mavEAZm8Fr7QGHcs3PqntMuy0cHayrxIxnpg2ssZKP6IUM1mUcMFydtLd6vm2rCgnEL
         KTGA==
X-Gm-Message-State: AFuF++nRiDsOhVXt6SjEPqATyCH9LSxFsZqLgy2/hlegAUYaZT9gCX/K
	TCqG8LXFJzB6f/5joLhQq0u3UCcd1Jy/9sVlPTqtre8AhmOitG9/1C8DCoK9C748/dV3Nwb5oMf
	NmviXIjOIsD+tNHNy2A8oEdCYUGUS2ThmQtMtpy6KpQ5dJEUNAXaSs1yN86lPQq5NnA==
X-Gm-Gg: AR+sD10jF88DKdOhrC8mnARhHHPYdjN21QIugEB6ADl2vI869CMhS5DfJ7gbmdxWxFV
	4m+/j7sBHGzTKMtL3yZY47L0aEqmUWOoPDF7MhhqMrUGR2id00K+/KRNXkFihBvZ+0DDs0dKEzf
	Xk4OrhOVD8T+mlw9xVxyaV1ZYimftDL7vP/BSK2PmMRE/TGhoTsoEWhwglm7F+xlF4D4Z1HubBV
	et20hXXcK0t6G9hQxa/1GQCnu2aF/pILYo8ETaSLMUysdRCUqSHr130IhhUZsP/IXInAsrkFeqE
	3sH3KYiAjU6t/TnGWYGdga4jhimRgx3D2uz016I+28q15KeUfmCWwUDNyiEjoU32Pa39jvI+RWY
	TNq81z41PZEykUUk47XTR6tP2htM9X+tVeQy37PZ/BD9A5ccVGvWb6s/aX2IaPxeXjf9/cis=
X-Received: by 2002:a05:600c:3493:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49b91c4792bmr62738075e9.10.1787898491952;
        Thu, 27 Aug 2026 23:28:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3493:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49b91c4792bmr62736365e9.10.1787898490772;
        Thu, 27 Aug 2026 23:28:10 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942366asm99143435e9.3.2026.08.27.23.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 23:28:10 -0700 (PDT)
Message-ID: <38a2e111-799f-4c8c-b46b-501999f71e52@redhat.com>
Date: Fri, 28 Aug 2026 08:28:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org,
 vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>
References: <20260825081751.134086-1-jhs@mojatatu.com>
 <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
 <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMkJdo_e5VYPRcPN2mZpNyrTQ43FxNvkqFSNDjyV9x45dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/26 7:39 PM, Jamal Hadi Salim wrote:
> On Thu, Aug 27, 2026 at 7:26 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
>>> pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
>>> ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
>>> bound. An unprivileged user (via unshare -Urn) can set a huge
>>> tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
>>> memory, causing a system-wide OOM.
>>>
>>> Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
>>> in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
>>> Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
>>> via extack whereas for the resize path, the error propagates to
>>> netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
>>> the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
>>> are charged to the allocating process's memory cgroup.
>>>
>>> S16_MAX is the virtio virtqueue size limit: the virtio specification
>>> stores the queue size as a u16 with a maximum of 32768, so 32767 is
>>> the largest tx_queue_len any in-tree driver can meaningfully use.
>>>
>>> Conditions to recreate the bug:
>>> - CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
>>> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
>>> - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
>>>   while the devices are down.
>>> - Attach mq at root, then replace each child queue with pfifo_fast:
>>>     tc qdisc replace dev veth0 root handle 1: mq
>>>     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
>>>     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
>>> - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
>>>   rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
>>> - On the unfixed kernel this exhausts global memory in ~28 iterations
>>>   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
>>>   tx_queue_len is rejected with -ERANGE.
>>>
>>> Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
>>> Reported-by: vega@nebusec.ai
>>> Tested-by: Victor Nogueira <victor@mojatatu.com>
>>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>>> ---
>>> v1 -> v2:
>>> - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Jakub)
>>> - Changed cap from 65535 to S16_MAX (32767), matching virtio's
>>>   virtio16 ring size limit.
>>> - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
>>>   already prepends KBUILD_MODNAME).
>>> - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
>>> - Fixed tdc teardown to use JSON list form for acceptable exit codes.
>>> ---
>>>  net/sched/sch_generic.c | 14 ++++++++++++--
>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>>> index ef2b4bf51564..eb5c0d3f67c2 100644
>>> --- a/net/sched/sch_generic.c
>>> +++ b/net/sched/sch_generic.c
>>> @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
>>>       if (!qlen)
>>>               return -EINVAL;
>>>
>>> +     if (qlen > S16_MAX) {
>>> +             NL_SET_ERR_MSG_FMT_MOD(extack,
>>> +                                    "ring size %u too large (max %d)",
>>> +                                    qlen, S16_MAX);
>>> +             return -ERANGE;
>>
>> Sashiko noted that setting a large tx_queue_len to a down
>> interface gives an inconsistent behavior:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.134086-1-jhs%40mojatatu.com
>>
>> (all other comments are IMHO noise and should be ignored)
>>
>> I don't see and effective way to avoid that, short of falling
>> back to v1, WDYT?
> 
> I changed my mind on this. See this thread and let me know what you think:
> https://lore.kernel.org/netdev/CAM0EoMk8fAACt11fe1pUsFeG9np3SdsV0YUNmEevLu=i=b+xKg@mail.gmail.com/
Whoops, I missed the last message in such a thread. I think it makes
sense and will cover all the sashiko-reported concerns. You can probably
also additionally get rid of the old test:

	 if (new_len != (unsigned int)new_len)
                return -ERANGE;

/P


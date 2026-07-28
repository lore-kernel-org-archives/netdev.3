Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00778439351
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243930; cv=none; b=J3vg8yKEsBO3DcoglruMM24zG3zxgEVCbIry7FtBXdCCi5afs1vdbSUyxMvkRt+SsZy4ikiPjUblPGHHvWiJsYeS6DuvGNePyOa7bSG9B6RdaP2er2reRMXI5IN7s1bMEjH1EBWG/bZ5dWLryxzM/xfBYGp5SwXVtPKtFKlCoYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243930; c=relaxed/simple;
	bh=VZUu52k9Z5MfA1fYd4LT55UaXLqszf/GacD1Ov5Ezso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6nA1/Am6BL3jkL/8fvQ/5DHbnPvpthdtjfo+yPWZb/jMyL/vlgsJsnGdZTvPTfTUu1A1EK88IKRg4kUFqhTx1BqpH29oVn+Xaq+cKbD7slUP9sGfQop8HuEuFFpXj1lNT3wkqMrvGOgOXGkXghGSO/K03N33pcaZE/oeMPmnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSiF+epV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUuG+Fws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSiF+epV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUuG+Fws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785243926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZyVt2V6D6nQ8yu5WvKNeFjpvQegaEAq/A8BjMLpajk=;
	b=gSiF+epVw11JquoDKqK1W4/fTXUabuGuu0XSiKhJy6YSd4oxtMdw0L6Xogu3J5P6eF5Avc
	zsc4/jRnzjsr0c1dWemn1F/a+aNGayi/GqXqQIa0coCE144NM6Z1wmHvATXljg1gBj/nM6
	t0UFJWEvwsP3AsAPyD27wDpP6crL3IM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-m3pKSpEIOLuDSTz8XeIO9Q-1; Tue, 28 Jul 2026 09:05:24 -0400
X-MC-Unique: m3pKSpEIOLuDSTz8XeIO9Q-1
X-Mimecast-MFC-AGG-ID: m3pKSpEIOLuDSTz8XeIO9Q_1785243924
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47faa02f707so763276f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785243923; x=1785848723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZyVt2V6D6nQ8yu5WvKNeFjpvQegaEAq/A8BjMLpajk=;
        b=ZUuG+Fws1/jfcoxWSVaYORCEBYaCjjDWOFzNyFG4ZLmsSwfZ4I1VfQ51sPyARSM36T
         e0D8SBBD7NE0sHhnKnqdQu0mTqmMr9IlbwuEbq6ibcOPaEicuDAJ07lBefepeoqwYKQd
         GeRQXqsMCWaGLOOm/JhJA7eRmT9zEiDFVNNfljqCA+RI+0iw2VwFc/OdM5gFGxZ3WXE8
         3rS9Fd6s0v012GYOufQpig68Lo1SAE4BCFfb1N+hgJbfT58rCXUZsGsNzIVF3REssXCq
         k8Ar0QtE0ayWfyjIZrpDMNcVV0W7+IrDiH+FJpWhQr3MtrdoYZYH7beID+LXldWsO5EZ
         OoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243923; x=1785848723;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZyVt2V6D6nQ8yu5WvKNeFjpvQegaEAq/A8BjMLpajk=;
        b=CSJtoIxgVKOqkkiwe5xmfUukQnQv+gTYtVmIV9QSdlGe40ODAuLbHh1e/38QEcv68Q
         /nXN7BpAPaegZbOUD3STcmQscFqKuJj4qiPnaUJuP99h97A5qxnFkdLr3PGsU4CwEa/2
         jvnVyJUKYaN7dv+6C+IKZAXpL33Rw04IabljAuIOqS0g6n9vzMxj5Jd8tSvcu3mbkpSh
         tuH/sl8UlloZvB1Q76yZAFYXz8sHFe9J6eVjT3o+Smxe6fgNeP0ZOV46aBkn98TcKUJU
         4i56tSNPYSgdKDxle5E9az34wN+ty3ULvrIk2GOREPgUfWSs3QkfCr50ZxMA/hPIvIOn
         Rwtw==
X-Gm-Message-State: AOJu0Yw9fhF+L1GU3Wj5OMioiVkOeRzcVEFfmezS0I+ho8ciXO3f6+qF
	BFXpSs3aoU4z9FX/lAsdZUO0QAQNCnO02cU/POJEKIPkBfWn6yrtsnY2x1XJYNBxIYViwvRT2ck
	OohlEy3edsoHVImicRGjosjGyyMprl2Ss4dThl8SO1gyX8L8kz9VnF/CW9g==
X-Gm-Gg: AR+sD10Oz7UUViLYLh1GcCuxWMGgUhwyos7I5FXY/Y/8FKq6oJx+T4prpXqw8h+YcPp
	i6ggeCd4CEwMo+9NJywp0yV8fXGT0bZIrPkNdHjKegGuS4KqQwTrc+LhkWx6jqX3Jg6F01Qsru2
	sQFq0cR7LJVPdHnIg7oADltrA3rMf8X+S4s+HO2jEfUQ06D9HIwPeU3ll+JFRdS1V7x9qYwH+e3
	gOwYlqCr2JkSV2wSMLH5QBnca04VRvCkyjryjQj8byNH9WOE1dqGbnU1yZPPfda/5JuetugXQda
	PPC4EM39Ya4WKjYLtSMVI6dIfnM5xgrMnS+n23IPKobZNv/wdtSbnWYWD6frj07/rqpHctvOFNR
	oZFTHbxERTe2ly4epbeoGBKRml6hPpS6uVj8sVIBfrvuNPl4Zf2e5JVOjTsK8AhB4VMVskdIgDC
	1E4A==
X-Received: by 2002:a05:6000:310a:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fb1ecab50mr2857058f8f.14.1785243923385;
        Tue, 28 Jul 2026 06:05:23 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fb1ecab50mr2856992f8f.14.1785243922897;
        Tue, 28 Jul 2026 06:05:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm63979180f8f.1.2026.07.28.06.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:05:21 -0700 (PDT)
Message-ID: <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
Date: Tue, 28 Jul 2026 15:05:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
 jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 Santosh Kalluri <santosh.kalluri129@gmail.com>
References: <20260723105210.817079-1-jhs@mojatatu.com>
 <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
> On Tue, Jul 28, 2026 at 6:34 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 7/23/26 12:52 PM, Jamal Hadi Salim wrote:
>>> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
>>> index bd6f945bd388..700f878fc3cd 100644
>>> --- a/net/sched/cls_route.c
>>> +++ b/net/sched/cls_route.c
>>> @@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
>>>                                       next = rtnl_dereference(f->next);
>>>                                       RCU_INIT_POINTER(b->ht[h2], next);
>>>                                       tcf_unbind_filter(tp, &f->res);
>>> -                                     if (tcf_exts_get_net(&f->exts))
>>> -                                             route4_queue_work(f);
>>> -                                     else
>>> -                                             __route4_delete_filter(f);
>>> +                                     /* Always defer the free.  The direct
>>> +                                      * __route4_delete_filter() path has no
>>> +                                      * grace period and races with readers
>>> +                                      * that cached f in the fastmap.
>>> +                                      */
>>> +                                     tcf_exts_get_net(&f->exts);
>>> +                                     route4_queue_work(f);
>>
>> Sashiko fears the above would be race prone:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com
>>
> 
> That was fixed in v2. Is there something i can do next time (message
> patchwork?) to not waste your time looking at an older version?

Usually the tool properly updates the old revision status, but sometimes
it fails do to that.

Double checking that the old revision is marked as superseded in PW
after posting the new one could help.

>>>                               }
>>>                       }
>>>                       RCU_INIT_POINTER(head->table[h1], NULL);
>>>                       kfree_rcu(b, rcu);
>>>               }
>>>       }
>>> +
>>> +     /* All filters are unlinked; no new reader can find them on the
>>> +      * chain.  Wait for in-flight readers that may still hold a filter
>>> +      * pointer and have published it into the fastmap after we unlinked.
>>> +      * Then flush the stale entries while head is still valid under
>>> +      * RTNL, matching the route4_delete() pattern.
>>> +      */
>>> +     synchronize_rcu();
>>> +     route4_reset_fastmap(head);
>>
>> This really looks like quite a big hammer.
> 
> It is.
> I viewed  it as bug fix to original intent of 1109c00547fc - that
> commit even though had the intent of protecting the fast map as as
> well (based on the wording of comment i saw).
> If performance is a big concern: another approach that maybe worth
> considering is to totally remove the fastpath. It maybe more
> performant than imposing the rcus.

Given the amount of effort involved in rtnl lock contention reduction, I
think it would be great if we could avoid the synchronize_rcu(), if it
does not block the fix for an unreasonable amount of time.

>> Since there is already a
>> synchronization point for both reader and write while acquiring the
>> fastmap_lock, I'm wondering if something alike the following could work ?!?
>> (completely untested!!!):
>>
> 
> Your approach has some holes, example misses the most dangerous part -
> destroy(), etc
> I will mull over it and see if it can be fixed to handle all the
> issues. I think it's possible i just need to put time to
> validate/test.
I would appreciate that, thanks!

Paolo


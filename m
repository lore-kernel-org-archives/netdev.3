Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4306211A14
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986894; cv=none; b=DSOSNDmsIqGu7G6Js0ZUAN3upnLzkbMdZodsrbPq5r+vY+Ger6z1RKHW5l7c3JYQiOcPK5mt9UxTI7Qkj/eH88mxe+pkZRU2JhW5Ju1dNqiJLsnrf/jHN5qyusPUuWBiz7hpRePhurMZpveasghyhehnpnCQEaPgonKmylurgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986894; c=relaxed/simple;
	bh=o3VumL4n1F9L3wdHGdyo89N5SNYZOxFXNvPB9xYfOwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PX6QvEFQd7Xo2q+3WGi0ZyBP54TM4d3VWACZ/Fpzbx0ywEIT98umB1v4NLOwNBmQklQyyM61jaeJ7Auv+XjsLEbGab1eCrm8TmlIUMShfLCRjFmBlk519ik8dlQIHcjLe4AhXeOgYlWvx0e4xJ1b2xBw+0gu8itiUhV5CTlS3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuOQKgmG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuOQKgmG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceb096e675so22684745ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785986892; x=1786591692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wy2teMLMsXQgihU2TjOQqhHKl5ccc/qhFvBF59Tujoo=;
        b=RuOQKgmG+nq8MOJmjvj9zvIx+utf2ny6iLaT1tGJyeMh3Hm+tsyHWJBOyvbCnbGvDu
         /zUOdly/UY6/N0qSnDe1Rf39eOL5VCfcg7vITdk7G7qrdXnZN1eCDtVjFRMFRKF2TH30
         mVE1VMintto9NdHll6Afefo6AU7BKYiKHIi6YM4O4WIUQDb7GIQlxDdpUSNWzKGRrorv
         36+qglh7Y3J/3LRkeKKoIKMfnE9g9w7v2vLCNDc+bpgwYZ14KBBmta4ck4CAPlk7QdGw
         RTv5LQP3XlNOGj1/q7V7a8EnlH0S0uIobDM1bRpp3cgcJh+zLTALXTKEYlb6xZ49BptF
         8rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785986892; x=1786591692;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wy2teMLMsXQgihU2TjOQqhHKl5ccc/qhFvBF59Tujoo=;
        b=FhwHvQjLLasOBsPPiwMbjAeQ0XprTNOGQqB9/VziE95BmN2CZhirq0Ng6uhSeQzlPR
         8TASiUMmXK6O8kaFT2amdR9HbulrKrBigpG5RQ/tViVRGNKu6hsrh9VY9xN43sfoT4Gr
         RpRfQheHJFxqOZLN3lLyGW0Zs7YHufzlukzfkXcNbYhhGE6fA/g8gZFMIvFGlCYCLger
         jvKPG4D0DYmcepqdcMKE6t8rF/o4Mk5kNxxfCHytA8F9V41gyciW+kQ+mRg6Xt6zoIZV
         SaHBIBdxI1ScaNi6eN2oBqPUgJHbuQnbn76qbkOzFTAl1cvQO1mFXSNyeTv2lH4sc7qM
         Y8mg==
X-Forwarded-Encrypted: i=1; AHgh+RpPo0DsVkfjYr/HagYBoMzKprI/PDJgawdTmZU1VUvfH0WS/jTzVHmopvDb2DTnFEspEetBrtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+3G0a2TMk7Bu/rtsHJ78ZExQJpPWEpU0UqlT4ZrUDv2z+hPT
	Ufp3Q4HL68bFVp/9wef+xotTqua7s/MkFiBoc0p+4318BTKy9k6Cb6i2
X-Gm-Gg: AR+sD10N7DrXKrt3dgdQUK5YgnwCCT9N6UvIDgCLLHBM6qqbN0C89djIAwTwH3+jKtd
	dDSJ3cTdxSNF4ZeAGnGfwwIgdydtDlJJwJntt9Kdvehoxi7qoUPDN750OlHl9p8+3QvCaWEiiOk
	IR7M/72pj8rluwwLE6iOI6dopNL6CUIR4Q3avjXYz1KBi15Q8M832oVXTBjP2nQf6YXoomiN868
	dGw7QY/CydVTHinBMfRfxmN2i0eV2gx9Bl+jcFPgPjSxwQZAbReQY+R1WEbCdmMabb9ORl4OIQY
	/zlBW13usS9pTBoBggWzu1O2F3ES7LvEFzoMhTaLO3cjTRJu6f8qadllKW2DrVS/wvannr92XM8
	YtTQLr+6acmbQrWYnd3Vlac1YfPHlHSa5wF/ekHyccLekLACJwgR6sUmqVPQzj/8fs09JdCMdjw
	zCYDsQN7SfKuq1QkwQ19uXjWG3NAOR8L3ObCQsG1t60l+eOatXMnLLQlH9VK8uYG3xs6OWu3tij
	XZ0UQPabWLXsU2N8Io=
X-Received: by 2002:a17:903:2b0d:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d0ca7afcc1mr141641525ad.4.1785986892002;
        Wed, 05 Aug 2026 20:28:12 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b6c66sm23504135ad.55.2026.08.05.20.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 20:28:11 -0700 (PDT)
Message-ID: <aabdf499-20ad-4667-b289-626c09a56c0a@gmail.com>
Date: Thu, 6 Aug 2026 11:28:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_api: fix tp_created race losing
 existing tcf_proto
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, corvus@tencent.com, henrymei@tencent.com,
 stable@vger.kernel.org
References: <20260805093012.95155-1-henrymei@tencent.com>
 <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
From: Aohan Mei <ljp1205831794@gmail.com>
In-Reply-To: <CAM0EoMmZGXhHL2v=AyjR9xSs8-s9EfkA9FkpULqtFBEOUxHQQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/6 01:52, Jamal Hadi Salim 写道:
> On Wed, Aug 5, 2026 at 5:30 AM Aohan Mei <ljp1205831794@gmail.com> wrote:
>>
>> tc_new_tfilter() attaches a filter to a chain. When no
>> tcf_proto (tp) exists for the given (protocol, prio), it creates one
>> with tcf_proto_create(), marks tp_created so the error path can clean
>> it up, and inserts it with tcf_chain_tp_insert_unique().
>>
>> However, tcf_proto_create() can sleep, opening a race window in which a
>> concurrent thread may insert a tp with the same (protocol, prio). In
>> that case tcf_chain_tp_insert_unique() destroys tp_new and returns the
>> *existing* tp, but tp_created is never reset. If the request then fails
>> (e.g. kind mismatch), the errout path calls
>> tcf_chain_tp_delete_empty() on a tp this thread never created. For
>> classifiers without a delete_empty callback (all but cls_flower),
>> tcf_proto_check_delete() removes the tp unconditionally: a live tp and
>> all its filters are silently lost while the owner's change() still
>> reports success. The race is reachable because cls_flower on
>> ingress/clsact qdiscs runs without rtnl_lock and can interleave with
>> rtnl_lock-holding classifiers such as u32.
>>
>> Fix this by making tcf_chain_tp_insert_unique() report through a new
>> "inserted" out-parameter whether tp_new was actually inserted, and
>> gate the errout delete_empty call on it instead of tp_created.
>> tp_created itself must stay set on this path: the chain reference was
>> consumed by the destroyed tp_new, and errout_tp relies on tp_created
>> to decide whether to tcf_chain_put(), so resetting it would underflow
>> the chain refcount.
>>
>> Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurrent execution")
>> Cc: stable@vger.kernel.org
>> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
>> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> 
> This is the same issue Sashiko found. A patch is here:
> 
> https://lore.kernel.org/netdev/20260805134049.927864-1-victor@mojatatu.com/
> 
> Also, please add assisted-by: tags going forward if this was ai generated.
> 
> cheers,
> jamal
> 
>> ---
>>   net/sched/cls_api.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>> index fee4524ad..9ceb2b538 100644
>> --- a/net/sched/cls_api.c
>> +++ b/net/sched/cls_api.c
>> @@ -1937,7 +1937,8 @@ static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
>>   static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
>>                                                      struct tcf_proto *tp_new,
>>                                                      u32 protocol, u32 prio,
>> -                                                   bool rtnl_held)
>> +                                                   bool rtnl_held,
>> +                                                   bool *inserted)
>>   {
>>          struct tcf_chain_info chain_info;
>>          struct tcf_proto *tp;
>> @@ -1948,6 +1949,7 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
>>          if (tcf_proto_exists_destroying(chain, tp_new)) {
>>                  mutex_unlock(&chain->filter_chain_lock);
>>                  tcf_proto_destroy(tp_new, rtnl_held, false, NULL);
>> +               *inserted = false;
>>                  return ERR_PTR(-EAGAIN);
>>          }
>>
>> @@ -1964,6 +1966,11 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
>>                  tp_new = ERR_PTR(err);
>>          }
>>
>> +       /* Tell the caller whether tp_new was actually inserted, or an
>> +        * already existing tp is being returned instead.
>> +        */
>> +       *inserted = !tp && !err;
>> +
>>          return tp_new;
>>   }
>>
>> @@ -2254,11 +2261,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>>          void *fh;
>>          int err;
>>          int tp_created;
>> +       bool tp_inserted;
>>          bool rtnl_held = false;
>>          u32 flags;
>>
>>   replay:
>>          tp_created = 0;
>> +       tp_inserted = false;
>>
>>          err = nlmsg_parse_deprecated(n, sizeof(*t), tca, TCA_MAX,
>>                                       rtm_tca_policy, extack);
>> @@ -2382,7 +2391,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>>
>>                  tp_created = 1;
>>                  tp = tcf_chain_tp_insert_unique(chain, tp_new, protocol, prio,
>> -                                               rtnl_held);
>> +                                               rtnl_held, &tp_inserted);
>>                  if (IS_ERR(tp)) {
>>                          err = PTR_ERR(tp);
>>                          goto errout_tp;
>> @@ -2440,7 +2449,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>>          }
>>
>>   errout:
>> -       if (err && tp_created)
>> +       /* Only delete a tp that we actually inserted ourselves. When
>> +        * tcf_chain_tp_insert_unique() raced with a concurrent insertion
>> +        * it returns the existing tp; tp_created must stay set then (the
>> +        * chain reference was consumed by the destroyed tp_new), but the
>> +        * existing tp must not be deleted.
>> +        */
>> +       if (err && tp_inserted)
>>                  tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
>>   errout_tp:
>>          if (chain) {
>> --
>> 2.50.1 (Apple Git-155)
>>

Thanks for the pointer. We tested Victor's patch locally and confirm it 
is an equivalent fix for the same issue, happy to defer to his version.

BTW, "TencentOS Corvus AI" found this bug; and the patch was mannualy 
written and validated, so no `assisted-by` tag here. Noted for future 
submissions.

Thanks,
Aohan Mei

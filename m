Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E941F37C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206789; cv=none; b=u7gTszngBebNrJaJS5QK0r9iJCBwoIdnE0obKvUzdvNmyLuRRzOkVY3XfuGUbndFWCI3uTK8kHhLhwlmx6MQ17lgfsvQrcejN1Ffq3M1bZWmwvAti++skoBuJT+SsgE8XJWiQxT4ZB+xCDe4nDk6/DdSLdUOZ2OEsApBeRZL1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206789; c=relaxed/simple;
	bh=rpmjjD9ixMN3vKIYQ51So5awvszP0cmojx8AZD/MAyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mgYGML6l2/53g/LS2r5di+caJKDbpd30I7z9ubD9DJi93i5qSbc4eO8tfumaVw6jArQ3o6sEHoyWU5OG+81+ljlAmXsIQqpSwvUEERtCQK5L5B2UOZHhb1gTkYZx4BLA96Qwe+5eqs2VmrEyKmLoeBxY90tx9RCmLKVORT+zbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LuH0ZQwB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LuH0ZQwB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so12739395e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784206786; x=1784811586; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZvfawR8I4GAicdLgeKPOlr1vtxHRZ9vVAdVAAu3ReU=;
        b=LuH0ZQwBkpheF40QdkRq7vYP/3gL7NFHsEpA3E3qO0fuettH+bMv56pTR8JMMZMpmY
         E4Ebw5Keh0YmAz/BjP2AQRVCaiyZJe22mX+QldkraT/Hv0yOlAYsUQ6IpgLtq3PzfGDK
         c0fJH9ZOOvZoEBhZAM3F7BGIbTJHUin8pcEajwpdpjBPOaIFpEEjfCkJ1IBMEsUA3iv1
         SJG6xxa/7ykBT4jBNObwAPg3yC+FuiNcpyMf2FpdtQZid4bjfaP15ClMFzLnq7cJD68p
         SkvRqtMkh1L3YxZfn8NC6OdO4bgF+o7Aq6hUX4Oor7cn0xNtxwC5BGM95/UPiyN0MTBS
         8m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206786; x=1784811586;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xZvfawR8I4GAicdLgeKPOlr1vtxHRZ9vVAdVAAu3ReU=;
        b=e/FkZZahljsPwxhGVNzLIhyetH6TM133xCnhXgZiHcsJbXdlbXADYc0bU0EdKhg8dn
         SKpINwkZkVhTqNiDpz6umUhAMHOczx0PdaKeYNhs42TyAC1wlOIZDyXoGinWe5Pg6VLm
         pT3vls4wx7zgyGbPN5dwhebg44J4XMGVM///8gxhdWmNHF3JmUZm91n9XxCtKhKl8vHg
         qvW6v8cFYVhV1AzpAiI4UbOf0EbUbUyRFPK7J8lUuZep5+no7L6zjrDiYLoZo9Vb48ge
         yKsPxxBi7FrsvqIQsqO94kn+HOgx2kgfPBdkp00DNL80T16QPuKhVHIvcW9PVMwhOAw2
         tt0w==
X-Gm-Message-State: AOJu0YyhlDcmIiVbGEBjc2Z5V2Ishjm2wBFurGvUDxXNk+bb6k8lueP+
	qVV7o2OadvrRcPoCXF8Vb7E5wbNdHiRrwhsu+CjwKnzPzvysXYvGPyJCJIJtKYDt5Cw=
X-Gm-Gg: AfdE7cmCSKHpD1fMJ/iFhyULe7I+O29AhziSdkBEVA/cH5Y+nh7DtRKtMHMvct9iGer
	BsNKpqk3WbpEev6TfhTohqVWmoPZhchQRqkRL1w58E+jqnOCC50JBZLifGN7O2b92WW5i6OyOAq
	Yasg07DrDKB7H0YBFF7qPULw0eem5QTDe5CTGk0lTclpops19VICD51oqZOoSgYtBcL6BYQwLD3
	g5biqR7Lz4dfXm3W+vnsSLtN48syRZwvdd/yif6HV7azKCX1ilZypSn57SnVoJ7jURIehnIYth7
	tp4C/pWX9aP7KlgJdGEGFqGwo3+WpA8ovMbE4ZETNfMxEh10n8heVd266z6101iq64c8tvE9J2u
	yAV0K19GVbhzgoKkF0rPc4u57qMYMexc0xd4cXcGLTP0iI+7Wr9vjUcCE2JQ436rZNkbjGlyxC0
	epV8pjNw==
X-Received: by 2002:a05:600c:4ed2:b0:495:3c8c:c16a with SMTP id 5b1f17b1804b1-49541248d08mr36567905e9.0.1784206785670;
        Thu, 16 Jul 2026 05:59:45 -0700 (PDT)
Received: from cloudflare.com ([104.28.189.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb0343sm57827975e9.10.2026.07.16.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:59:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
In-Reply-To: <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com> (Stanislav
	Fomichev's message of "Thu, 16 Jul 2026 05:11:30 -0700")
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
	<20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
	<aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 16 Jul 2026 14:59:43 +0200
Message-ID: <87a4rrjdj4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
> On 07/14, Jakub Sitnicki wrote:
>> skb_scrub_packet() drops all skb extensions unconditionally via
>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
>> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
>> 
>> This makes it impossible for a BPF program to pass metadata via
>> bpf_skb_ext through a tunnel or across a netns boundary. The extension
>> is always lost at the scrub point.
>> 
>> Introduce skb_ext_scrub() which consults each active extension before
>> discarding it. Extensions that request preservation are kept while the
>> rest are torn down. When the extension slab is shared with clones, COW
>> ensures isolation. Replace the skb_ext_reset() call in
>> skb_scrub_packet() with skb_ext_scrub().
>> 
>> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
>> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
>> creating the extension signals that its metadata should survive
>> scrubbing.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/linux/bpf.h      |  1 +
>>  include/linux/skbuff.h   |  2 ++
>>  include/uapi/linux/bpf.h |  3 +-
>>  net/core/filter.c        | 11 +++++--
>>  net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++++++++------
>>  net/ipv4/udp.c           |  2 +-
>>  6 files changed, 86 insertions(+), 15 deletions(-)
>> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 6b918a5b61bf..a46ca53c5b27 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>>  #ifdef CONFIG_BPF_SKB_EXT
>>  
>>  struct bpf_skb_ext {
>> +	u64 flags;
>>  	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
>>  };
>>  
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 584d8440d352..66afa5489007 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
>>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
>>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
>>  void __skb_ext_put(struct skb_ext *ext);
>> +void skb_ext_scrub(struct sk_buff *skb);
>>  
>>  static inline void skb_ext_put(struct sk_buff *skb)
>>  {
>> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
>>  static inline void __skb_ext_put(struct skb_ext *ext) {}
>>  static inline void skb_ext_put(struct sk_buff *skb) {}
>>  static inline void skb_ext_reset(struct sk_buff *skb) {}
>> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
>>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
>>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
>>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 3eee4467422d..02da170205de 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
>>  
>>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
>>  enum {
>> -	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
>> +	BPF_SKB_EXT_F_CREATE	= (1ULL << 0),
>> +	BPF_SKB_EXT_F_NO_SCRUB	= (1ULL << 1),
>
> Do I understand correctly that you do prefer the NO_SCRUB mode? Any reason
> we need to have scrub mode? If it's all produced/consumed by bpf, maybe
> we can just carry this data unconditionally instead of having a SCRUB/NO_SCRUB
> option?

Yes, that's correct. We definitely need NO_SCRUB but I don't have a use
case that relies on metadata scrubbing. I believe Kuniyuki also would
like the no-scrub to be the only/default behavior for Google's egress
use case.

I've made it an opt-out mostly because that the existing metadata
(skb->mark, skb->data_meta) gets scrubbed. Although as Jakub K has
pointed out to me - you can circumvent it by using bpf_redirect into the
target netns. So I guess we have a precendent?

I could use input from folks operating in K8S-like environments, if
no-scrub-only mode would be acceptable there? Daniel, John, any opinion?


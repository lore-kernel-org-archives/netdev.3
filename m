Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F346A608
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766073; cv=none; b=bbX9nD/h5HmRSsOCCmHrC7XLe7rQsZNrnBAB07KWw3E1NiSpZnGrQ4OAeQ7yZ8Ka0FIfXylvEay65RnSJpx38G21WKha5ZmsUHABIQy/UQKyMlFIAitXQiMelqC9FPgGWYjcXjoKgD4N33mrNQsfBzwXPRzZGWHzuTa16QYMtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766073; c=relaxed/simple;
	bh=XpiM9HZ5DHiauBMJ/jKuHr8lg8YITlsCNh3301l2Avw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7HpttEKNnXEmxRzxEYue+cltyM0TH9MMeyDWhgxtE/LO4FShqIj2c5YvOfi4RxfBe2WJvT1WnhF8V+42l6obdbHyenY+tvexP7nmNlsh2Lof1DfFblB1O6xrTW3RIKkomTXGfiIY34QL3jwUw42aMrVOfnj70AnKYENQYAo69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=jXAOH78O; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="jXAOH78O"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so2092431a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787766062; x=1788370862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwrnltloowsLt76VfmWZpLlhcfqR0x3FThArEgY+QI0=;
        b=jXAOH78OEKIKDOuUPk0jML8PVHo8wJClw595ipwUdb7qlMDrDBQ3o1NCLanJsT4FAP
         x0r+LWMMrNvRhcFsnsszcS1tSD3GWJ/NZeKe0O6Uz3bKmenT85hosjkk5FDu65zxJAO+
         ogIA5/L9GpcDX4v0V3PlN0Z7YLBK6s7sK3HnmgF+iMa6hHFBmvGNWC7Yp4r3NF1Zf3c4
         PWGTrpVMSo4Hy3yTsqYWhKud1txRpZLI2WkXD6AL/eL48oupztUmvX4kbItJX9Qt9Xqe
         lb+F/hYHWNjbDDH9+dzjQFnqLCxskvvx04VCEJbJm8n9uku7t5Sz1i62FHSeDcAZCEZc
         S44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766062; x=1788370862;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwrnltloowsLt76VfmWZpLlhcfqR0x3FThArEgY+QI0=;
        b=fdYP3rZwedkKHNoWs0f/3kv1+xlJ+c4hiLgvRIzR4oP6Ls3IObLJYytsyiok9iezrX
         +KWO/LCjlpBoe/7n0a3h2CUD2RTSZr75iDQ5Cn9zax8ModlV1lMrszlJ3B0G1V0thg96
         CLCh2hLxrKWh9X35gRBH5ChGJ/KlAX3MDg672sqAqMi/OI6RAhm6u+ADZ5AIqgYLXvn6
         7WtvE+bhmEKYYnbwV8PlAKcMR0/+CKKMRdQvK8zaA7UIsEMD5Bixg8r3tEjbizX2fLMr
         t6YAZSEnkHipC1G6s2yJhsD9KfatIfuuAwMdA7+rxol8SkE3itXyHRyYZwcJgxKPUEbS
         o2WA==
X-Forwarded-Encrypted: i=1; AHgh+RpNr3n+KxubngZeOkBSc8jPY4mY8VhOp3vjmjhyPz1zSIlSru+l+TlEcZcMpaWW3LWQ84qeQ5c=@vger.kernel.org
X-Gm-Message-State: AFuF++lte8mTQLsnl5ArORZA/yj8CWwOtjEygC9CvfT/mdaBi2rAc5Zv
	Fb1JMI1uw5LnOBffQ8ZVR9nBH2w1KHNdjcTZTeP2KpFiCjwbTWlkNn9spBxbWd+LTfU=
X-Gm-Gg: AR+sD11xlch8GQxzGUeCdvZQM44/Sp9M1GLge0rwH+zbdSPMivcb8ogqvreuWcvyjkJ
	e5IG7Tb6mNRJCf3FWaz+lGDNKlXe64ESt1mbaF3undl4UdiZG9BRqBmEJoGvcUho4TdMIIYpjwm
	XALjUznPaljRGhXk9yBq2jTJLAT44LsmKVAZentFNVffjQX/q+/X8zreqzFbxdVKuwrH3pcq/Ym
	aC2PsaItfTN7p+H0ODQnFXLtmX49CEBQRYj4hWXJ2lv9+Vgmvpw/XSPNwrj2V0yUfaTOyH19yli
	RIRsZ9yDk5bWQh45Vlv0tEIjcuSkiI6JvND7xqcQkTJyO7ihv0bFYkqHcNq73AQz/HLnbxCcMeb
	jjiTMSHndTiwAcL4J9LRiJUbK+EKbG3WPsKqHcv527bL8Jk6qkQcpP99wBwC8L+kPI/JbduNKul
	XDO6VrdYuFUalBu3IQLVPJUzZgVZCTGXznUNSpkdp5Qf+tIQbPW4Nqk7aTbHGeXoruXJYcN4x/A
	fOZXrrmb+Pj8KPbKa8=
X-Received: by 2002:a05:6402:a245:20b0:6a5:f203:ba4b with SMTP id 4fb4d7f45d1cf-6a5f203bc23mr4034912a12.16.1787766061900;
        Wed, 26 Aug 2026 10:41:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d1afcsm7141021a12.8.2026.08.26.10.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:41:00 -0700 (PDT)
Message-ID: <c985ef2a-3e0d-48fc-9e21-33501bb92cf3@blackwall.org>
Date: Wed, 26 Aug 2026 20:40:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] vxlan: mdb: Fix use-after-free in
 vxlan_mdb_remote_src_del()
Content-Language: en-US, bg
To: Baul Lee <baul.lee@xbow.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
References: <20260826173604.90158-1-baul.lee@xbow.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260826173604.90158-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 20:36, Baul Lee wrote:
> vxlan_mdb_is_valid_source(), which validates MDBE_ATTR_SOURCE and every
> MDBE_ATTR_SRC_LIST member, accepts the all-zeros address.
> 
> A source list is only accepted on a (*, G) entry, whose source is the
> all-zeros address, and for each member of the list an (S, G) entry is
> derived from it by substituting the source. Entries are keyed by a plain
> memcmp() of struct vxlan_mdb_entry_key, so if MDBE_ATTR_SOURCE is present
> and holds the all-zeros address and the source list holds it as well, the
> derived (S, G) key is byte-identical to the (*, G) key and resolves to the
> same entry. Omitting MDBE_ATTR_SOURCE is not equivalent, as the key is
> then left with a zero address family.
> 
> vxlan_mdb_remote_src_del() removes the forwarding entry of a source before
> freeing the source entry:
> 
> 	vxlan_mdb_remote_src_fwd_del(vxlan, group, remote, &ent->addr);
> 	vxlan_mdb_remote_src_entry_del(ent);
> 
> With the keys aliased, the first call deletes the remote of the entry that
> owns 'ent' instead of a separate (S, G) entry, and frees 'ent'. The second
> call then runs on the freed entry, and its hlist_del() reads ->pprev and
> ->next out of it and writes through them.
> 
> Adding the (*, G) entry with NLM_F_REPLACE and no source list marks the
> all-zeros source for deletion and reaches this from the sweep at the end
> of vxlan_mdb_remote_srcs_replace().
> 
>    BUG: KASAN: slab-use-after-free in __vxlan_mdb_add+0x1cd/0xd70
>    Read of size 8 at addr ffff888102852500 by task poc/84
>     __vxlan_mdb_add+0x1cd/0xd70
>     vxlan_mdb_add+0xc0/0x140
>     rtnl_mdb_add+0x157/0x2a0
>     rtnetlink_rcv_msg+0x207/0x5a0
>    Allocated by task 84:
>     __kmalloc_cache_noprof+0x153/0x360
>     vxlan_mdb_remote_srcs_add+0x2eb/0x440
>     __vxlan_mdb_add+0x803/0xd70
>    Freed by task 84:
>     kfree+0x14c/0x3b0
>     vxlan_mdb_remote_del+0x129/0x1a0
>     __vxlan_mdb_del+0x4f/0xe0
>     vxlan_mdb_remote_src_fwd_del.isra.0+0x162/0x1b0
>     __vxlan_mdb_add+0x1c5/0xd70
> 
> The MDB operations are netns-scoped, so an unprivileged user can perform
> them in a new user and network namespace.
> 
> Reject the all-zeros address in vxlan_mdb_is_valid_source(), which covers
> both call sites. A (*, G) entry is expressed by omitting the source, so
> nothing legitimate is refused.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---

You should wait 24 hours before posting another version

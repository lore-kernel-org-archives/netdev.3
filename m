Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1C39EF35
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078916; cv=none; b=t/1KlvSxwKtmWTIQSSDUFXYClzg+kRJOaqM+nd73siPSgJsdHfZRz67W1A23/tchSrs4ifKoksCbQQMai/aY22unLudLlaj00ZPqXZRPHQ/kwMShD4jbr03LusmUqZHZpxH+w104lDlDLNoVABp0PA5aGz1/HINt9HKN4yQp9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078916; c=relaxed/simple;
	bh=c96ZSUeJEjcxvGP7WpBQGII8OiT+vmcXUz7HcyhNHDY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a67Szoosx3JVRb90aai47fYG5AzI5EjrSCFKD+eP8maV+/M3Y5NGFtQTErwKN8as0J6OPrIEpNhk6a6eMUzAibjtAaHgjDVx9Ld4GBNKYRC5XWmyrF27KYLoyjvulIhJ2hDnR+PrMb4Uc3nD3runiR6ZK4otqEz8PlWvycDA5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VoM/Sqek; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VoM/Sqek"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48431648f33so540698f8f.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788078904; x=1788683704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPERQ4gNn92lOKV4sdrKZ2WIeiK7tfsawsRQ1ZqnsKg=;
        b=VoM/Sqek1wdX2Uiko4C91WcBS4ollQ/LqPJKwI1GaEHQVtpx3skyL845CEY4XA8IEi
         W2gmNpLZCX0QiY/RmK3oOe1P8sfaNYH4Euppb0G7xPtY+zZ1qUmFDVcA5XtURNiojfoS
         Gmu2VLCTsurXeNp1Hubd5zblRUUBydYC6o0WPRd7isaxVLzfJhubXy0SoEJFeL3EcFZO
         LENtUrWXLw0Qlma8E+Ny7jCG5aC1znkZZtAof/YHQnYzDyYqU4Niu1mvciuoDL+Nzhf2
         1M3M+dQHx/rAC2QxQGRNEtr872J38g7soJHjakMwDOYYVeT12XMLk7UDNRFf41USLLcD
         iLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788078904; x=1788683704;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPERQ4gNn92lOKV4sdrKZ2WIeiK7tfsawsRQ1ZqnsKg=;
        b=XayBUM+Bx2A0skLXIIr8RK5n+F7m0fpcVUgo76CfLho3avjaJ/45FXS0Lf2E/Bunsh
         1fAvSMuLdN6hRyTXIPUZTEALfJwTKkKAw++vpLI6xlFjTP0HbkziAZ6kOni6KhnU1/sL
         0H3UbGAQNXk0djobQJimaNJK6/oSZ1N6HV4Bb5tabo5y8NbTrAvyXAcG1NVLkkDc4Dpj
         gHtxknNg5+XRbC2D0mEmj1fDCnjyZicSsBnX45LJaVuuNrlWnmoF9wrWSJMpMi2eFwW8
         St3CilJiV84clwF1qafpyekmHqIej8KGNGU1xnCZ2+w2wJ//ZYphhXQvsr5BBeH8c7OD
         KXaA==
X-Forwarded-Encrypted: i=1; AHgh+RrtGmalbolcnc7TNgMo8npYKvjmqCcmooRWNhkmfQUWNkYf7Z1h8ROvFoHR7fe9B9aqZkEYnUo=@vger.kernel.org
X-Gm-Message-State: AFuF++mZjR0LUhOSlFeEoVhpscEhSc+/gxk6Bsuj6V82Y0jK+7pmNaBd
	1OW+Ll+SUh1Wk8OKyJozusy8IbJW96AebLSESNJPpyj3B2vJNva5gp8tpVt7QTLhZU0=
X-Gm-Gg: AR+sD13gE5nuxOuSp6T3zl/pQA4qIjILNhgMlAWwaL0fp3EvfajDZ1u5LP5UFVI+igb
	JYRnA++JBL26iMcMk0WRTHwxwoTNbaucmlBLj1VwEehMKt14B1L+O34i40dKoFrK5+XnJ4bAwmU
	s0QSDslYSaNOVc6vo8g9GUCCXn9OR2mu9zORhmWTNzAggkKC6MpcFLiFOUE2Y5TBKIAOTiB9EzW
	4iTJNzL4PGw8zXSR9OuwE7TfGJuWehkdMljj/f6pUCrH52PfFFKg6Zv2ywhNmf9DK6lo8cU6aUS
	uQB72mleefzPmS9r/G9GD+Dmzb3LTGyOXH2Z1cmIK95KiM3Hh5dc29E6WdJK+Ir5adEhe609WzE
	OVCqQTnqv5g8erMmO03YPkIYiCYrF1/DfBQm5IV482sGALjoZZGPPCosRqVq5yXjNOy4azUCfdd
	WeEwM+IpTCp0jPwencZXk+hkhvb6yd29GqjTlKXX/eSnpYOVmg/q5dB0gdcUDUaYsD2SYij4wlU
	G3PQcQQZVDxCdL9gBQ=
X-Received: by 2002:a05:600c:870f:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49cd538cb5fmr21200585e9.3.1788078903667;
        Sun, 30 Aug 2026 01:35:03 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9617179asm85766775e9.2.2026.08.30.01.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 01:35:03 -0700 (PDT)
Message-ID: <2ef6bf41-8626-40ce-8ba8-82dbd3f0c30e@blackwall.org>
Date: Sun, 30 Aug 2026 11:35:02 +0300
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
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Baul Lee <baul.lee@xbow.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
References: <20260826173604.90158-1-baul.lee@xbow.com>
 <c985ef2a-3e0d-48fc-9e21-33501bb92cf3@blackwall.org>
In-Reply-To: <c985ef2a-3e0d-48fc-9e21-33501bb92cf3@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/2026 20:40, Nikolay Aleksandrov wrote:
> On 26/08/2026 20:36, Baul Lee wrote:
>> vxlan_mdb_is_valid_source(), which validates MDBE_ATTR_SOURCE and every
>> MDBE_ATTR_SRC_LIST member, accepts the all-zeros address.
>>
>> A source list is only accepted on a (*, G) entry, whose source is the
>> all-zeros address, and for each member of the list an (S, G) entry is
>> derived from it by substituting the source. Entries are keyed by a plain
>> memcmp() of struct vxlan_mdb_entry_key, so if MDBE_ATTR_SOURCE is present
>> and holds the all-zeros address and the source list holds it as well, the
>> derived (S, G) key is byte-identical to the (*, G) key and resolves to the
>> same entry. Omitting MDBE_ATTR_SOURCE is not equivalent, as the key is
>> then left with a zero address family.
>>
>> vxlan_mdb_remote_src_del() removes the forwarding entry of a source before
>> freeing the source entry:
>>
>>     vxlan_mdb_remote_src_fwd_del(vxlan, group, remote, &ent->addr);
>>     vxlan_mdb_remote_src_entry_del(ent);
>>
>> With the keys aliased, the first call deletes the remote of the entry that
>> owns 'ent' instead of a separate (S, G) entry, and frees 'ent'. The second
>> call then runs on the freed entry, and its hlist_del() reads ->pprev and
>> ->next out of it and writes through them.
>>
>> Adding the (*, G) entry with NLM_F_REPLACE and no source list marks the
>> all-zeros source for deletion and reaches this from the sweep at the end
>> of vxlan_mdb_remote_srcs_replace().
>>
>>    BUG: KASAN: slab-use-after-free in __vxlan_mdb_add+0x1cd/0xd70
>>    Read of size 8 at addr ffff888102852500 by task poc/84
>>     __vxlan_mdb_add+0x1cd/0xd70
>>     vxlan_mdb_add+0xc0/0x140
>>     rtnl_mdb_add+0x157/0x2a0
>>     rtnetlink_rcv_msg+0x207/0x5a0
>>    Allocated by task 84:
>>     __kmalloc_cache_noprof+0x153/0x360
>>     vxlan_mdb_remote_srcs_add+0x2eb/0x440
>>     __vxlan_mdb_add+0x803/0xd70
>>    Freed by task 84:
>>     kfree+0x14c/0x3b0
>>     vxlan_mdb_remote_del+0x129/0x1a0
>>     __vxlan_mdb_del+0x4f/0xe0
>>     vxlan_mdb_remote_src_fwd_del.isra.0+0x162/0x1b0
>>     __vxlan_mdb_add+0x1c5/0xd70
>>
>> The MDB operations are netns-scoped, so an unprivileged user can perform
>> them in a new user and network namespace.
>>
>> Reject the all-zeros address in vxlan_mdb_is_valid_source(), which covers
>> both call sites. A (*, G) entry is expressed by omitting the source, so
>> nothing legitimate is refused.
>>
>> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
>>
>> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
>> Signed-off-by: Baul Lee <baul.lee@xbow.com>
>> ---
> 
> You should wait 24 hours before posting another version

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

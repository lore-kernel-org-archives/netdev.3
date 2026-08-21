Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5323AFD17
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347747; cv=none; b=f2duzLPnrlBxjkhZMaxHl6L9HhXAMciZlLARq13M7PN6eKPybecDAfuZDDmUnrj4vXREXOxNjDfBGiJTp8IKZi0AhD8XiQsBs3OGcmWqAcgxbQTsnW+WsUwggSMBRKeKjOenl7u+VcMqpnjh31a348NGw12dUkxgy85bCHxPHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347747; c=relaxed/simple;
	bh=tVdqKeaG0OTIzYLJmKkqZTI1/D8qARAPY7iq/8VBbyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p806QiPHZCGeClA9Gh8NIhOq1Fy4ZhnlRaxWVvWi2y26Pn0hG59dT1mylhstTvLGRJnjrBTLz7UVVr62hUnP3wH+8eRnfrJ12MdGHpyGTsPeeGCa40Z7hgjF/EmdPqfn4HMlk54tYRVzQtB4CZKA1V6Ny2gt/v+Z755tYFMhSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-6a132717f10so726571a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 14:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787347744; x=1787952544;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+GmzNqksTBpBR0EQ6KSJSFIhgzJggWy8LIdV2wdJCY=;
        b=a9ULSH57UeCGqDd1P3GhTPxSS9i+hc3o/VON8iCWYg5/dvY5CoJCz1LZvE52UfBGRJ
         17BT10rIwZ6iBMaJkRnHwnWz3TOMPUQYSeMRqtXdB0vXQO0g1l2g6sfauDjlTd7mzFmc
         KPDFo/7626g/zYGhFJv/mvoH4wqAaZpGg8e00MFSX++kMwGgTpnD0v/uuWBFId4d+7W3
         Z2OlA0db9q0u85NXkCdKON6N5NXtxxX8RldHWnYdTtn6NGc/4C7cWPIGvFRTR5cpdkCn
         h4zxTJNKMJ5sKzihyafM/qXVCsfqtjNu+PD3P+0vnZGzELnAhUR1N+Daq1zJoY40+0Am
         PPLg==
X-Forwarded-Encrypted: i=1; AHgh+Roii/qGsY3bm+5LplePYqViHC/enakqZAhnFWKZCLNXLZ5ylkHrDBGz9qJ+/6vqf2y4pCJlCSw=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ23NoVJT6Y+Q6U3sjdh1aqADyVepilU28LHNbEnm+aalvPK0F
	XbNHsFCE7m8iFNkoXO1jtetBfwOi/WnryrmrOFXRCaeK1fgDl1lHIywv
X-Gm-Gg: AR+sD12I6/4JrKxm0iX4t/WHOp28zwkkhoTZIvknyLZp1QNJjwMdOJGoTWNm/2eyyXF
	9VXw5s5yBe6h3+Ev00xw31Ak5AEMZYXFlIEzqk4tGXXQWYc0KNAMHpmzR19g2sWxEsa/GbxS28F
	QtuUt7pabXqxLHFnTgqVCkcGIbWuY3OKa09a87CcnN1cyXvWpu/F+BpSEY+5WZxpguO7IZSLMw1
	OqaNrYkgdA+kTt3zuYLvFczP8aHCY18zcNctYX02+1e7jgktz60f+1VjOzv7850f+CfM6Vs9T1M
	AOw21/By3ato+E0AGsNhbAu49SwE6sBQ50APvsWRW9I+oNUn2rNuK/SzXUSYAmYjDiMfbLl99XD
	TRfeSkVuKKGypihxg0R/D5fGo1owtiFvk7EfsoeNN9uHLGVXgOMYwWm6PrXtxAgHnlcYFwhCjU+
	jqswbr/h+hbjA8GDF3aJut3g9hVyDCnbKzOgyUm8dgyYaYIyEGFsloP9FxPkpz5fBZKoZ5LX7CZ
	O5Za1SdNo+hW4Zr
X-Received: by 2002:a05:6402:5d2:b0:69a:b38d:403c with SMTP id 4fb4d7f45d1cf-6a42f18f10amr10638106a12.7.1787347743745;
        Fri, 21 Aug 2026 14:29:03 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff17df84sm11194134a12.31.2026.08.21.14.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 14:29:03 -0700 (PDT)
Message-ID: <5427770d-f16d-4bcf-b86e-af82506fa2dd@ovn.org>
Date: Fri, 21 Aug 2026 23:29:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v9 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1787280296.git.xuyuqiabc@gmail.com>
 <288fbd5459d92b9dd0dcc6faf625f04819161ff3.1787280296.git.xuyuqiabc@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <288fbd5459d92b9dd0dcc6faf625f04819161ff3.1787280296.git.xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/26 5:19 AM, Yuqi Xu wrote:
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> An unprivileged user can trigger this bug from a user and network
> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
> netns is torn down.
> 
> Publish the CT limit pointer through RCU, remove it before teardown, and
> wait for readers before freeing its contents. Keep ovs_mutex around
> individual CT limit updates, and use the RCU read-side lock while GET
> traverses the RCU-protected limit lists.
> 
> Netns teardown detaches the RCU-protected CT limit state in the pernet
> .pre_exit callback while holding ovs_mutex.  The pernet core guarantees an
> RCU grace period between the .pre_exit and .exit callbacks, so the .exit
> callback completes the teardown without adding any extra synchronization.
> 
> The netlink command handlers do not need NULL checks because the userspace
> netlink socket holds an active reference to its network namespace while a
> request is processed. The per-netns exit path therefore cannot run
> concurrently with SET, DEL, or GET for that socket's namespace.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
> 
> Changes in v9:
> 
> - Rebase onto net/main.
> - Drop the data parameter from ovs_ct_exit_finish() and read the detached
>   state from ovs_net directly, fixing the build with
>   CONFIG_NETFILTER_CONNCOUNT disabled.
> - Rename ct_exit_data to ct_limit_exit_data and stop moving declarations
>   around in ovs_exit_net().
> - v8 Link: https://lore.kernel.org/all/cover.1787129643.git.xuyuqiabc@gmail.com/
> 

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

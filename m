Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B29524AE8
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810221; cv=none; b=QeAI2Ea8yIhSIyvKe5HRGuIXKoHm8vAbZb3KI25JzuE4KAEYSMMmLERbbZZNRFCXoMhoSWul3x5SPGkkF0xiHMpfXA9S4egwtm/T7LIBGrRMrgrmEGZjkH3GYbBF0vJTS1xyiNyxh1ppUw1ba5BBlThJV0hJfloupbStD2V/4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810221; c=relaxed/simple;
	bh=zt6tPYeTJ6z3A9sHZPVLCj1eXyavQmhvb0jRjJTqZ8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMMlaj2xzDKKxJsOCKtWL7X9RDNLDFTsLS/JbaRpgANSJZJBKjfitNFbGHwBLyJ8blVh52iMLbxfUG/NSVFaoJJTlhUxIcs+U2TEKIvoWQLSMoiOF8s+MvzLolOoFtGyv4j+YHm4b8UWCijCna3EB4+eyDRMpIplbYIFw+3qWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso16136305e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 12:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788810218; x=1789415018;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WX7dZxFpo/r4ebjE0VazIWqU/Uh4+WxO6eJuc3HgArE=;
        b=Li0wART7+MTKI9ot0+/uhnX+G69a7G48eRsIhnU7bRDQBGtyvlHcY/PuMkDsHEhgE4
         TTVjNh1MNEhEN5KiKmxqUpEZ9k2V3VUaIPZehcKnnq6qzs4NOb10JKKXb3MdoGP/mzpT
         Q8XScVrnl7RHKkARHtxNnSRI3vVm+5KjnOdc/+RwRrp1Vh26GTaauwi7efQyuy0lRWaQ
         L8VeFgBktYlMTSquLtLZ+fi1wkLg5DgtO5MLoT/QwucIsFpQH12dmOhxnSn99W2Mo1cN
         7dy3EAKpOszKKI4eIUAjj0oeIiwqc/vobQnRsQYzIwlQYvzLlgsjrF6c/WzKtGxH2yJp
         XCAQ==
X-Forwarded-Encrypted: i=1; AKwUvByOWPVwllQAzXoRRR4PloIsIR5HtRBkDQxZR28aJEM9i7svj+G9DZ90+aNpHYO8LI1uSbYiV8o=@vger.kernel.org
X-Gm-Message-State: AFuF++llEhP0ujZSwApwP7neHWSQ7tE3eIFCGqrbNsLNZWjMEosPCavA
	CCc/lKLa5tuNa8GQkmur5DoNC2lk/TDaFYmTSFjaHycNKxkSGJnIXDQi
X-Gm-Gg: AYBFou1xW+d2R8GaarSGyqKrgHdd0HAwn6ih80qWGibVrZxEmAGs9/Lvtz80PP+B7Ee
	1Cr9Sxl9xsZ1tiqkNuFqAC6vijmm6QV29cpt8MaN17vcutbp7++z4bBQmOxb6GCK3RrIb5ZvQVH
	lmJl7goVIG4t02nd7dlVnFCYLWhnemNCyDhjYftMRNO39FlzLdnPR+4oM3yegr7euNRGGgFNnm7
	fjj0QzWLQZBnO/oXCYwA+eq5YAFwKSJI+Bfdr8+7YXO1znVZq9i/gnEktuvA5UrIoeR7ziUZ1mj
	NO9qS8ylxWuGcYiGSjuE9xNLVc7NgJcX8V1A6+yLXz+7OLi8z/OtiWC7ChpbNMMdvvfcUHrKlxz
	yuRK4I8K66hkeE2uiSDERrJDiKLBVC1hkRFkGf8iajJVqUl3nMcg7iqF5p9BzLNNmrG7nVjR8Vs
	+cJn/Zy5E/7y7FFiizmY1OrW6HAJLtv37h6eB+2AVd+H4J9zdJsa01WlyJ1UyvpB3NNJKLnddaP
	ySO+fQSzLfxHg==
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr11526645e9.14.1788810217561;
        Mon, 07 Sep 2026 12:43:37 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm30049266f8f.32.2026.09.07.12.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:43:37 -0700 (PDT)
Message-ID: <5d767ec0-a24c-4686-a157-4233b0f22212@ovn.org>
Date: Mon, 7 Sep 2026 21:43:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: openvswitch: fix use-after-free of the flow
 table mask array
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/26 10:21 AM, Norbert Szetei wrote:
> tbl_mask_array_realloc() retires the old mask_array before it stops being
> reachable:
> 
> 	old = ovsl_dereference(tbl->mask_array);
> 	if (old) {
> 		...
> 		call_rcu(&old->rcu, mask_array_rcu_cb);
> 	}
> 
> 	rcu_assign_pointer(tbl->mask_array, new);
> 
> call_rcu() only waits for read-side critical sections already in flight.
> tbl->mask_array still points at old between the call_rcu() and the
> rcu_assign_pointer(), so a reader entering ovs_flow_tbl_lookup_stats() in
> that window picks up old in a fresh critical section that the pending
> grace period does not cover.
> 
> tbl_mask_array_realloc() runs in process context under ovs_mutex, so the
> window is preemptible and can outlast the grace period. Then
> mask_array_rcu_cb() frees old before the swap runs:
> 
>   BUG: KASAN: slab-use-after-free in flow_lookup.constprop.0+0x2bf/0x2f0
>   Read of size 8 at addr ffff888020b3e018 by task poc/741
>    flow_lookup.constprop.0+0x2bf/0x2f0
>    ovs_flow_tbl_lookup_stats+0x4a3/0x5c0
>    ovs_dp_process_packet+0x19c/0x710
>    ovs_vport_receive+0x243/0x390
>    internal_dev_xmit+0x81/0x170
>   Freed by task 728:
>    kfree+0x16a/0x4e0
>    rcu_core+0x853/0x1030
> 
> Publish the new array before retiring the old one. The kfree_rcu() that
> call_rcu() replaced ran after the swap.
> 
> Fixes: eac87c413bf9 ("net: openvswitch: reorder masks array based on usage")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

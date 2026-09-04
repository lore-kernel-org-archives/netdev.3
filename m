Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EF3ECBDA
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501731; cv=none; b=VFZmKaYV4VsVW7lZzLUqQzYQbfLdYJSANGDr63z1uoMybCKlzx4bn5zDU1imGM5lyglKjcquswe0zSDV6z9KzNLZMG/TEyaJ2vsMyI8EFwHQZ2tEfVs/eDbyjj/NWzTScLaQdL9Ktm9STbCT6G2OshK51wjUXfbkQd7lNWUtbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501731; c=relaxed/simple;
	bh=ryqQGJnz3UPmWqdNc1zJz5MbrqbK+oT+RMj60B6kw6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlUPc2z5ohzP68wgmKqduM3pYk/BqEEXuEf4SWw1Mx1BxjGfYatoXE7JQi/FrJYBQSOKvyiYr3Ol1KPQB2OY9FsydB/rfcyQg7qullIiMoTBdBCN+oa8nocY2jCe3gq2uG80Gd0H0YmphMpzjMzSjjgBj/q8Rrz/aE/gF/Ouj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=jsdC6YYF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="jsdC6YYF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-485850cbac3so358095f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788501727; x=1789106527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=th+FTEiS258DjNC2ZujdbM6mdKYhOZP2oalry0Zz2Ik=;
        b=jsdC6YYFe2eQa8XvibVYMX/Uvk14Ckc+Pyc6W+RmT+rUt71z3JXCVD+ecUVVcTPIfh
         wAUQTb97j8D+itEvXoWM+SDgYerKnB4knBtqnD3vDQGdZUjWM/5NARpDJB3p9exDU80K
         VC3tB0CfE11mmRLIOAH19xPPSuWFXxpU5/pKxw6vfKQ9XNsrMG1rEhhEVnDaqfxMB1Uy
         NS4jSi6J+Eqkn8e2NeZYefhN2OcJHjM5VldW3164PSvPhVXOCsoyFz7/ZF4s7hQ6RZP+
         2Y4KjnoHcjYsWEb+dBxamt3+MKnH2YCMCJ9avKFjEq1offiEkasRnU0d8OI4y/F1EQtz
         kXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788501727; x=1789106527;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=th+FTEiS258DjNC2ZujdbM6mdKYhOZP2oalry0Zz2Ik=;
        b=gHIzyezz2zHYZlvyTHGzVHx4EXqZlHspHnmWkUNi5GvSxyy77El8S+51Iq8J3iueTJ
         P9Wncoj6+DH0kBkSf2UDTh4QkvyiZmUPTi398Sm6boxC7P9Q7mPEigfHX3w9nUep3vzJ
         YZIJTkdlz6rxtS+/lCFkeiq+JHv6RDSC7QX8+Ldz7hGDi3fvnD8dRKFFxONjoCJKq2rH
         cioRHPeiRfJ6kVoyoICAsVp2RidmzHN0Cgh+6rffuU/HpaZCbidlHN4Ak7ms7UeYSrMQ
         nIk1FJYAECHMh3uc2S2ZtaLjjoDKj31D2ccG5iF7QPVdPbfESN4Kw/GIuIAAhw0nWs2S
         SDqw==
X-Forwarded-Encrypted: i=1; AKwUvBwmpozo7gBx4SztnZutKUbVWOl3oLLyr7zDhf26y3ay+Cku2wkaIWopFtHOSx4hdrnfDW3KE40=@vger.kernel.org
X-Gm-Message-State: AFuF++kk7c7z0eQ6QZV8PA4h5J+LcaLac8lZfTeZI0llFkI6woUqZe08
	JN2MIMz38CHQP9oVR36rlp+kXk/cUMRGfPOUBRSZIBLX21uDJgJZfNk+VmUzjGB+n7s=
X-Gm-Gg: AYBFou2ODjuD3U0SZCg8Udwg6fWGslqdCgAfBwcJf4alkfCqaboo275aWraKkIdGopT
	lMpWFHAozlyW+TDZLzV8ZGzWbVm5OcGjIk2K1bR6fQHynm1BHKqZshNL9j6tfo/TDJyGxN/pOVb
	eEoSwJ0Hv6uRb1SBVvmKx10p3c2M7CNBklUEz3fWmTo/sLeLHh2AHrZXvn9TLI79iqtcsS3aMT3
	p7aZBMrBRUlR+TQ7EwXkRWhKQNPaeWiPouLj+6Fa91Ma95NSsiNB8xDZ0ZgEoskBl9wn5+TW6xs
	GNpKe383hbW/VShx40D4tNpgux/kV8LBn4eeEW2VTlJo60xPZhQKPhEWnJIG2qDdAIkYQZrLfNj
	O5ftRzE1XOHWk1flhGiNMLsGgXJjTUXAe+YOe8yE0ZNqJtOj4TcX896XXO/TUDumSlLf2VGt4oy
	jnaiSfQHBZSuC2YnI+o7fM3R+jUP76zE1+YPpn1OepP087+3r6PUPPi7QvtNzs+p1u7ND2OvzL4
	TmEUkoKP3f10Rv6lhQnD+OSAHunlQ==
X-Received: by 2002:a5d:64cc:0:b0:485:8c16:a34e with SMTP id ffacd0b85a97d-4858c16a6dbmr797433f8f.38.1788501726885;
        Thu, 03 Sep 2026 23:02:06 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588134c0csm4538998f8f.3.2026.09.03.23.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 23:02:06 -0700 (PDT)
Message-ID: <f0ee0862-4e1e-4488-aa38-5f1dd5c08abc@blackwall.org>
Date: Fri, 4 Sep 2026 09:02:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: dynamically allocate frame_type
 instances for CFM and MRP
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com,
 Ido Schimmel <idosch@nvidia.com>
References: <20260904004428.1933068-1-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260904004428.1933068-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 03:44, Eric Dumazet wrote:
> struct br_frame_type contains an embedded struct hlist_node list, which
> is linked into a bridge's per-instance br->frame_type_list via
> br_add_frame(br, ft).
> 
> Both cfm_frame_type and mrp_frame_type were declared as static global
> variables. When multiple bridge devices enable CFM MEPs or MRP instances
> concurrently (e.g. across different network namespaces), they share
> the same static global br_frame_type node.
> 
> Calling br_add_frame() on a second bridge links the same hlist_node into
> the second bridge's frame_type_list, corrupting the first bridge's list.
> Later, when br_del_frame() deletes the node from one bridge and poisons
> its list pointers, a subsequent teardown on another bridge walks its
> frame_type_list and dereferences the poisoned pointer in hlist_del_rcu(),
> triggering a general protection fault.
> 
> Furthermore, sharing or embedding fixed br_frame_type instances leads to
> RCU node reuse violations: if MEPs or MRP instances are repeatedly added
> and deleted, hlist_del_rcu() unlinks the node without waiting for an RCU
> grace period, and a subsequent addition immediately re-inserts and modifies
> the node while concurrent lockless readers in br_handle_frame() /
> br_process_frame_type() may still be traversing it.
> 
> Fix this by dynamically allocating struct br_frame_type upon registration
> in br_add_frame() and freeing it with kfree_rcu() in br_del_frame(). Also
> ensure all registered frame types are cleaned up during bridge deletion via
> br_del_frame_all().
> 
> Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Reported-by: syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a9a137f.9266084e.bf0d7.02e3.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> --
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_cfm.c     | 17 +++++++++--------
>   net/bridge/br_if.c      |  2 ++
>   net/bridge/br_input.c   | 40 +++++++++++++++++++++++++++++++++++-----
>   net/bridge/br_mrp.c     | 16 +++++++---------
>   net/bridge/br_private.h |  8 ++++++--
>   5 files changed, 59 insertions(+), 24 deletions(-)
> 

Thanks Eric, but there is already a patch that should take care of this.
A week ago I pinged the previous reporter of these issues and he posted
an updated patch yesterday:
https://lore.kernel.org/netdev/0345b9d5aa60ba416f6738ff1b87140f0a749cb8.1788417901.git.zhilinz@nebusec.ai/

Cheers,
  Nik


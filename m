Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0F212542
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788584617; cv=pass; b=ajo1lbdzLTYCwZFmphFOarkz+xGviA9RLRTQZa3YuGLmvfIeOWH7lwleD3e1d3p8YGoAcb0voXzZWxTuvr7ZHJTnTPZ9l10lQfKnbjZ85uEk0oh0syLh2/+IymFssX6i5inES7HToZFrhM5b2OUHOVbyrCeWeGkJd1Q5aym3eN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788584617; c=relaxed/simple;
	bh=/21RzNPQD7xrfTM96+h1WAecDdpRBWhDl0owEilHAAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDTU1k++NJ+hnbeAlLS2RU9AyM02W2q3AzTUm1NiTbNN2hN/NqBTFg7Q63OzERIzqVe9+elR1LA6xkbdhnd6PjRaop5UzxXdQ6g/Fc1MGCfWqyGWFGHXm7v3YrR0SjpXhdkaYwKZGM3nUuyVNtZ0kSLoAmfvIJilq7O4kArSQrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P0MEWBeX; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0MEWBeX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2083874a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 22:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788584612; cv=none;
        d=google.com; s=arc-20260327;
        b=qgvaCaUGnnYR9kpkJD8qZ4oJZWhnxExeUwXa6JgG1SLz3hFOyXYiSQOunwhadkqRt/
         FflzwmcJg5XD0Iua5YeIEA4Z8LSGcs2YIirZUSFVHiWAIahASygtrvf9hi1XZYj3K6WF
         mXheUqg7upyqF9MTc+dsmdaLXfTqTaVI5nfiLNb61Z9q6fHFbL5sIt8OsfB+tB6LPDNS
         EEQJEyo/x/henMqyduac5oPq4HaXk3wDUBlXFxbTItuFf9tO5QRjhNUZV3YUUDq+Gjst
         iRwNKaSKzxKo74wgN0vm0FVm/cWdyFwoObKDCJs16m9MUc1DVjCxbh2vkeB9YV4IvTuC
         ABBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGA2Mcq21FlK5ZYfe6/lNBf/DykvEi95f+iz3baYnsU=;
        fh=uVMHaFJ8+bGfZMLPKCfOc8r2OlVUPrTVxDiem6E5wGY=;
        b=pU7gdHgqQXu9sHU/bJUnLQy/tZr6Pen846ma5+J4cgsG0QAGZqVcKPrIu0UXVoZHQe
         NCA7KBgx1JYAWz3D1sBjJBOTQlhqkYl6bi04b/7xSKYUyEfpwyWXGA1jwxBjQnACk/9x
         xv7kz7Jzi5jQu+luQWQ7NEHDoEyUukGFCcVzH9VrdJ2YXBRhxdfkdbG3IyfH1/5+K7oO
         0b6lEUPe47MOiOEnhh1ClmpoKM+x5dEXHKVcDJS41LcEiKy12K3LFUwCl7bVVPfjUmFy
         jC8MT0r7tyzrMLJYhRFl604xoeykkumCKVP8wiu9nRrDTyqAIgi9MAaWyL7u9i/ambuf
         3SCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788584612; x=1789189412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dGA2Mcq21FlK5ZYfe6/lNBf/DykvEi95f+iz3baYnsU=;
        b=P0MEWBeXBEvHAgPRLTxnRMQro8Wg3zzYLfTKiH4le+Wb2MNJUtApzKqwmvT6tksk8H
         JBT5SWa8OgjbIKrDZfIqGwcVPMnL5snuqoADBr+7ZLoef+VBfFVqYWETprQsdG8goESO
         WwidGxjtXC1YSO1XI22toeOo682r1gbwV2WKfj6V4tcDM90AXNQ8XAAq9wJdRX5VBmdJ
         rNGZ3fQBebkrDliONbQjAPJED12lSFZqp9c5tOKXvyvMENoYovv9jir6jbE/J+KojR4h
         dUKjHcxjgdmxgKfplIGvvRcfiprhLSFkGe+ybzocmg+SKaFLb7gTw4lvpOkH2vhz8jtL
         LZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788584612; x=1789189412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dGA2Mcq21FlK5ZYfe6/lNBf/DykvEi95f+iz3baYnsU=;
        b=OKA3/YzKBlxEC7w0N0eqx1IgJz3z7PXU5St0AfigE1l/vJp2Gh7oSB7zFF7chHuVHI
         fTGps1CiBZg465Pr4V3Uw3ty9DRUgqdLm4IaWyuFCKJnZgGFsxVE4j1nD2bj5N8L6WYL
         25Yx1xlcVSaFG5eoaAkR16jOeIwuCXbRbzV/9urm151VdoGFZHPhXB0zoZOP1tUzTQe+
         C+3nh8yT8mAsohzPrBldU6sFZcZDw5Ld6PNXwGLBzGztZ64gltRe9qepoyCJvyDcpitQ
         zp25qHGMj68cw6u2DfHc7mpeArMYmqblWFSu6doAbpl9r0sUtZEsS/U4YRIKEuxxJAS4
         Ubww==
X-Forwarded-Encrypted: i=1; AKwUvBzRgtOxZtpd+2CL/tVv2IxVkgLR/Xa6DQDkUeWp/byV3rotrBb4+o2otFW8F4vlEj1XrgjnYVI=@vger.kernel.org
X-Gm-Message-State: AFuF++mU+aM2V1pzEJIO9k7wJFXHrXLkZLPzwI6GvW6H2dDrgvOaoZjU
	bX8H3NQ1SHF+p2vx3wy8NOHMTc135i5KFofjI6F+MmkApD9wQmx7TQW3J7GY54sBLMZ6/DhOxRv
	q9PN578Fcw1VIhk4A7d4292WN1z9Vn4ms46bJnex3DK9lnuY5rgQtUNt6APM=
X-Gm-Gg: AYBFou05RcjFSjbRzx+qDncWo2nwlVoosOqJGN37ddwpinIoZBSB1FQffwzK1vIRbKr
	dCsXIH4zJfU7r54L9V0CXjcpvVuwifecJ1oebmz2P9hddjQNGGPspQOzRWwo41HSWLI5Z+Dk78g
	5KUMhLuFlisL2KnDHm6AjL3dIuMAcDIim4pVShRWLyh5PFmFcOKJtEMMVcgZpcsPpRtH0uWDJdW
	6OdjiJrPKPJUZbJYkfwRi0qFOumGirtyt9Pq5ryGpQKambgBgHIK7wZuJqN3vmx9B+OQGex2vSf
	A/Xoqs8u9LPwh+qgChWX8S/W1c0IRhxsmOO+m0f3gwA7NuknzmiKadKVdl2YKFImznBPflRekeH
	rv8WacEi36vmJxjcqV/WMN41+e7cJlACZEvFgW+R60RkCPZIs01v9LUbWnJKyDoeq3sBxQw0aaC
	itDYtUGdcrWTxzrW3v0+mtkso=
X-Received: by 2002:a17:90b:3d48:b0:396:5f7f:52f5 with SMTP id
 98e67ed59e1d1-39b260e13e0mr15346017a91.3.1788584611809; Fri, 04 Sep 2026
 22:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902073334.397685-1-ruanjinjie@huawei.com> <20260902073334.397685-2-ruanjinjie@huawei.com>
In-Reply-To: <20260902073334.397685-2-ruanjinjie@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 22:03:20 -0700
X-Gm-Features: AcwNN1UJ7xwWxxQ81tPyjPpyE-hF9bqjWtpFyW1Lxujb4Xxpx3uiU1MQORH7rPg
Message-ID: <CAAVpQUAw4ybYXUuosJ2esyhjW2q-o73-i+sAB2bJyPjE6ZaOUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] 8021q: Fix data race when publishing vlan
 net_device pointers
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, nb@tipi-net.de, sdf@fomichev.me, 
	liuhangbin@gmail.com, da-x@monatomic.org, jeff@garzik.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 12:32=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> A plain C read and assignment of the net_device pointer
> in the vlan_devices_arrays leaf entries lack proper atomicity
> and ordering barriers. A concurrent lockless reader on the packet
> receive fast-path could observe a torn or partially initialized
> net_device pointer, leading to a potential out-of-bounds read or kernel
> panic.
>
> The data race occurs between the netlink/ioctl configuration paths
> (holding the per-netns rtnl_nets_lock or RTNL lock) and the softirq
> receive fast-path (holding rcu_read_lock()):
>
>   CPU 0 (Writer, rtnl_nets_lock/RTNL)      CPU 1 (Reader, rcu_read_lock()=
)
>   -----------------------------------      ------------------------------=
-
>    rtnetlink_rcv_msg()
>      // RTM_NEWLINK handler with RTNL_FLAG_DOIT_PERNET
>      rtnl_newlink()
>        ops->newlink() =3D=3D vlan_newlink()
>    OR
>    vlan_ioctl_handler()
>      [ADD_VLAN_CMD] -> register_vlan_device()
>
>      register_vlan_dev()
>        vlan_group_set_device()
>                                       netif_receive_skb_core()
>                                           vlan_do_receive()
>                                               vlan_find_dev()
>                                                  __vlan_group_get_device(=
)
>                                                   // Speculative / torn r=
ead
>                                                   [Loads bad net_device *=
]
>            [Plain C store]
>            array[vlan_id] =3D dev;
>                                                   // Dereferences bad poi=
nter
>                                                   // during device status=
 check
>                                                   vlan_dev->flags (PANIC!=
)
>
> Fix this by using rcu_assign_pointer() in vlan_group_set_device()
> and rcu_dereference_raw() in __vlan_group_get_device() to enforce
> proper ordering and memory atomicity for the leaf entry traversal.
>
> Cc: stable@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Nicolai Buchwitz <nb@tipi-net.de>
> Cc: Dan Aloni <da-x@monatomic.org>
> Cc: Jeff Garzik <jeff@garzik.org>
> Fixes: 5c15bdec5c38 ("[VLAN]: Avoid a 4-order allocation.")
> Link: https://sashiko.dev/#/patchset/20260825095422.3166067-1-ruanjinjie%=
40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

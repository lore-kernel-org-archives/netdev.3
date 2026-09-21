Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2C4A7CA7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023870; cv=none; b=NslIrA80YRnnOc7aPQZyJy8zJCno8HUjuzfgPRALQoriExtWZWwc/uDj07Nyl8DvK1oD62I/oHFnrufH0a/Lq6l0wmIoNovJWB3b2UDgsTdZE0gE14I+ZPS5GzQSZA6DlXzY90kmh7PRIra3bsX21nqK3zqgBubO7jBC7RCj03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023870; c=relaxed/simple;
	bh=woHjxgbhlntc6UMVC2Q56QNtWFj9iT/K0HfOjx5NOsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIBu/wqqIJmBF+0WWTF5DyWQaYeRytmJCXFaReM9/FrOS4P+TGK9+0+L9ZHFqkUG4svM1idLEjdJ6T2cQIny+6AeRLz6dS6nCeb+Gee3ZAYLBsOJHYfgxvBv8XIPwtbOAVFq5BijZva87u9nDjzHJY2VruiEU7SCYskACUOzd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5yOFMAm; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5yOFMAm"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so2828166a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023866; x=1790628666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7NpZW2QKvKVqZ103EWFAok1hCAUC6BJWKfN1Cb2G2c8=;
        b=Z5yOFMAmBgbOxFESNQ7dWTgY+0JmrHPmXtYezIV5EdJpEIiCWR3a9G9FkkA+ZUrLBg
         +2yR6lkcJQ0daoxbaYIeL2K8ZLHhgLAUvQw/QB3fdu7WTXwlsEMTw3ppe/qz+EJzZqI3
         GzKEbh90eDVrNVRnp9+CDW+Sr4GRFk5KvcfvpsncIlxD4Ql/jt6CC8UbhFiyMeE77XEX
         v19+oCnc5VcNL4x0XaVc8ck6NiQSQh72oQNQUKCtwsbYgdropgR48uUUmX+RXlRqk886
         6mkGgmFIPs+SWjdl3DeN6DGO/6omgrXmkkEiHQzn9+p2+2dISj3TFtHzpdaRaNu9oFyh
         0yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023866; x=1790628666;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NpZW2QKvKVqZ103EWFAok1hCAUC6BJWKfN1Cb2G2c8=;
        b=feY88EgiFUdgWz+AzWu8h5srVwhBb0kM9EvZu6qfK4FUlv0PmR03qWfeoaJShRknsm
         zwpIpELERGZJZQ7D0l6UeC/gXq6XDuAWxnKIQ/+OYwmFXIiyQ4LjTpiJ3vm6RiMpDTfd
         NzFtFESe30dpX3ZKgWtZrnndTQHzvn7UxjUW244El7uXHjUHucdVDsU03UhCt7f6a7J4
         G1UlxDAyBQpPya5ZBMCkdSZQsZ/DxT73fzNMvH8gcS0j35N3/EdFrcZ5AJ818bxUcUj5
         niG3O8N5fD9aaY6IzmZxbFRA5ImVEGysXC8ZEfVgyXQJqFy0winEJIHy8rsm2Y66Wg2N
         pixA==
X-Gm-Message-State: AFuF++lBljNZdu4U5qWlGyrVx2gUbYi3yJukb9VNKoXQsNDZSpx3XFaU
	BMAV5cmWYlV/LNmzIfV+bA4jBVcYQ8vMc9vkzrjpE+wONUhOpKHnLDqT
X-Gm-Gg: AYBFou1qv+WULVlrMKv29O05z3MFze2MyzdLEHpHYLH9Q5ANJO4nKZGiSBQt8fJWp+9
	jkMNnyqE3WvK580ADN7UlJrWK7sxSdiOv44U2ay92QsJdbY6+5DFEMko42OA+nr7d/ZCSOP3vFA
	vF6vcMOUydFYVG6Dssb9C2ennvGwLxOXKLI4e4HqpmCQCf8xjzVOyhdUDV76P74uLZhJrp1+Rqg
	V6tHAZaZYXIcNXR+bS7oWTBTd7RcNFOd7PtjUjF8mhetQnuH3HfYe3T2mM8o1ZeJ4qTNwMWzfHS
	95SzTGjkwFxRKoWq8TMyaRLgdH8MXr7x1JW1O3qs6U+d3N78xMVWEM+16r1fHxjmPYAxtmisBzI
	BkBR08ri/vEq8oDQJvGh5g1OK5UGSevVxPQ6iCWpnp4G58mlv+nYsBbvSdoSb3uiRpFsoi5r8JW
	zQ4ftEcMXfQukRc1nUTUINReUXWf3fMlX3yx8xe2KmWOZaw0DTiVKHrX9N1gwzd7imgMnyqPR0J
	Q==
X-Received: by 2002:a17:90b:268a:b0:39e:6c69:34d8 with SMTP id 98e67ed59e1d1-3a06afaaeb7mr156705a91.60.1790023866276;
        Mon, 21 Sep 2026 13:51:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0699ba81esm490739a91.13.2026.09.21.13.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:51:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:50:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v1] net: devmem: document that bind-tx is
 unprivileged by design
Message-ID: <arGYqUOdDXccGVBB@devvm7509.cco0.facebook.com>
References: <20260921195545.493253-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921195545.493253-1-almasrymina@google.com>

On 09/21, Mina Almasry wrote:
> Unlike bind-rx, which configures shared NIC RX queues to steer incoming
> traffic into the caller's dmabuf and requires CAP_NET_ADMIN
> (uns-admin-perm), bind-tx only DMA-maps the caller's dmabuf so the caller
> can transmit from it on their own sockets without affecting other traffic
> or device configuration.
> 
> Add a comment in netdev.yaml and above netdev_nl_bind_tx_doit() to make it
> explicit that NETDEV_CMD_BIND_TX is unprivileged by design.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

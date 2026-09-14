Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE9473C64
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393607; cv=none; b=ujP3krhTn/cWtkFBHkJdOgx+YH6otduWX+ac0qhlnDHt6wJ4T4HvLewlQXKVMUelyxWyv5f3surGSsSWS2xKxN9ARuF0L2lIMdbjNHohcVCU4PBMmViXod5+OF/sydUFryZg3OEpMfp027fH/swd0HCB5BeqiOih5P6jUs4IUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393607; c=relaxed/simple;
	bh=OueWNPJAtMeRT9tAOf/SNItTLh11VOYa++V5fUJ5R6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpBL7hObq9ARkU7q2EjjU3E0eOa0zcGS/KUWmeejvxDvi5XCPW61xnGEBGgcXUc/VaFtfqZNNcgztjFd3us6bC/M5i1BPwccP9KqEjDIDaV+zBb3fhusRHEBprvR9zLznnwOf4yjP1A7mTxNnetzIYoO/ZQuEz2gmGWOQYuefWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJRVg2Cg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJRVg2Cg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49e6e69d528so20800005e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789393603; x=1789998403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OueWNPJAtMeRT9tAOf/SNItTLh11VOYa++V5fUJ5R6s=;
        b=jJRVg2Cg1fsmWKJRE5y3raHgfN8pVTy/bO/2m4Cxmi7Y6uapPXXuHsFV2kgtomwn4m
         NAI49d0O29uUU20ixokvS0FvjevtBuQOQEMcR5Stnl44n4OfXReIlcCbG8n+auOxJ6qR
         pVBF0OqFZNISyKtxkTagZKRIbDROkoYBYpSFbLCa/W7kra2NWNjnlP+fGOX8ttbA6HvI
         Pj326GzEwK+NiwzYZA+C7SKsGOamjUkjYAyDccqS2DnlqlHuv0OcEhHCuqYEH0OAc6WV
         300/ULeGk2f/5Uc+ygj6OrYOT/bDvVk1/UMbVovFJ3vUTkUBmgu2+85FYq7b9/kwJMBN
         2IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393603; x=1789998403;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OueWNPJAtMeRT9tAOf/SNItTLh11VOYa++V5fUJ5R6s=;
        b=dt7kpi4aSwwb09xJ7SMJtuj0QAF4Yc0VBxUNO34mK3uAXUz5hUuLDqfxfY7/4AY+lG
         fIwVHaUMBfCkJHGNjDlGXxoyl5+b2eIXXuw6ujBdluQSPF6KUH+yo929qzNBQbXF3GTy
         ZVrgxRcW0I0chmck725N5besc3ZqkhmDY9oaMDMZUftuJUp0NRi6qkE41jqauF+yHR0U
         SkUaWXDnhpzxTuE0hLfGpb8b2GaN/3yhJtdejLmhxmGgiqCISUPcBcq6BQyd7sK6jfMB
         LFvedlv++fuAn0i8z28Zyd90eMTfxlBIrW+dchQFd6axfp7m/HSbSbD0x5Ae8MOn02Y2
         Yc6Q==
X-Forwarded-Encrypted: i=1; AKwUvBwVGNeEgCL7MVCtbB8D3UlMwmZcJfpHvza75PMSjILpWi2wvX6ncgM7N8mM5Cd5HUMc8u/gKEI=@vger.kernel.org
X-Gm-Message-State: AFuF++mE5dP7XcUPMDK5lGllHzzZV6M1oqDFPmPRbjPZjmma3EpmNuZ3
	3rH9YewQ0b4LwIEz8om7vIhZisaBrklZWtYtqRqKOHLyOKFCdhHebYdo
X-Gm-Gg: AYBFou2smZSa20reW3rtRtszQFNevwb27YyRxC4nv4DaTfvvnWFfpWBQmMiKo59ovUC
	z7/4sxYzZcfAvsSKLIuxW3SXDL49kN5YD7+vhJeQ7tmIlOb5xXQqiMtvCjp92kF5QUqb7V6Fpqh
	sHSeNnZxVMtn5xeoxbYL5uBW+elE3FWZjRPbMyVgMDgvqWsez+u8+KeyOUsqOpjATx4cfqQilzQ
	3KyFg6VUXJEcNBavLo1VwURSkJPvvs7KnkIO+0jgQXJwYjmS4vDpyaLtzqHMHQJb2VVPZ9SN9Pg
	M7h6vkEeHdob9p06J/EQu3F6FDse/J38PjJhEVOa2SGYl7GARccEC+B5TtrMQGMEAS71Px0xSLJ
	IxeSSK3P/BOotmdGVLzjIy26HJlbikhcP9KlBGQyDaHcZh2gzz1yPYTbdovAx17YHshfpV/xXsV
	smIOGdVi51+p4LPh0QJKsPnSsmttC6Xd9mveaIuU+xT5uM4s/UQEb+VtjPjLNHbMZAKQrOHR97C
	mr4NkTf49sBjNFDvYqNdcoBHVjDCG8VbY4/
X-Received: by 2002:a05:600c:4e41:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49e7a65cec4mr34147585e9.3.1789393603344;
        Mon, 14 Sep 2026 06:46:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d2af31dsm1341885e9.4.2026.09.14.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:46:42 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:46:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/2] net: a sockopt_t quirk for the options
 that write past optlen
Message-ID: <20260914144641.68edc88f@pumpkin>
In-Reply-To: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
References: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 05:20:06 -0700
Breno Leitao <leitao@debian.org> wrote:

...
> and ipv6 comes next, and TCP_AO_GET_KEYS has the same shape.

That is the sockopt I couldn't remember last time.

It is really horrid and shouldn't have been allowed.

David

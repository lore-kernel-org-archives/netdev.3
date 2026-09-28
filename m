Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D349739D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590345; cv=none; b=EmeiLa/3iAr5K+KWCFv47JZs4Td7V4owVI7XE8CViUa9ew9zdOK17Lagu4q9DFLNUGqZxsRAIFMnLUDgT4Wh+RrP9VTLzQmiQBMLdVa3dW601CZ2UZC9ktpzQkVC5yvwET3PEAXltS4z19UXotIgFGPYdfO+vzsSrIuaebCgsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590345; c=relaxed/simple;
	bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTqTb73ieFNmdSyfGXdLbzauDTgXlfD16dZh2nF/EBlh9oW0J7/h8UPDtAJzh1Vk6VxuFHJ8zlv9NrBObAqyGzskeuEGjNapmz/ZfAGX5PygDfBaVkBOVVLcVHei9aFlrZbXdkyXjKAiNmTVCCLEQGGvnT0l4JZisilinZjeuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbU1sgCW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9VtdMq3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbU1sgCW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9VtdMq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790590342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
	b=MbU1sgCWFx/DMvWxVd9W0y/NvxOESu/txFx+qy4fNLaduvqpThDjGO0QlUIPQkDRUO9Nnq
	txtvKnREwkPE9l1ss1M8NvrfYsW/k6xDZcOyzvPqxNMR6nY6+tMW9K7RTmWT35KnZ98Fy8
	INN174qjP6QitNTwFlDDv0Q/CTlaYMM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-n6QuWy3MP0a9LLCqCsgZeA-1; Mon, 28 Sep 2026 06:12:21 -0400
X-MC-Unique: n6QuWy3MP0a9LLCqCsgZeA-1
X-Mimecast-MFC-AGG-ID: n6QuWy3MP0a9LLCqCsgZeA_1790590340
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so2620377f8f.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790590340; x=1791195140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
        b=R9VtdMq3bW/zo1qzDPtl3athhA2y6oB32PcYX+epo2p1OzunDtf0CqCA+A+ZoasXRb
         T/flNfWvqO2A03ubU0G/FDM3MhpO4i10VT4464m8Szdog8IpTFZq67fuATxT/n3n0BPA
         vAUTP2gLaKkIYTWPsGJ/cyeWo1CYhqkkj7Y9ry2p9o14LoNC3sBpAKdZNZ6BNvR13tB8
         IjfBvkjQrerPn0T3V9HojiHOUnRSZ6uiUZt7HnEWDmSd7VyoIVLQyYL99pmzBYRwSp2Z
         Qmqr8CFEnNWEu94i5acOxgy4zqHbsAL/bg7lRp70NaXjjFJLde25GpUmEgHjinVifZ3T
         +qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590340; x=1791195140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
        b=IGEN8FrwEjNL/frTCGbICJU83FjPFoYr/X4QuQMqMTBMTG6kaMivTJlnmhK2JA5fzR
         J08VUSZDVqUt34I8IOyqtLrFJKZCxkgIpFogxr2UiDvDQ0es0s216FoYCi+V3m8O7dN4
         xNRjCWfVCI54Cst+9tNtlUFtCEpnE06DQFpYnS8zD1LfNJXFnV5tciLq5dHBpzEyl262
         wsbA32n755LM5uON6FWmtXnGVRDilom1MJLOsbyoCHlfbOwGZok8Q/CBIyWCvJNvFPZ9
         Vkdp8itBzMMHH6aDYv0l1Z/GXZz4/JqU7ginvVywSjqrnFtDSEUJprMkwQ4YGw9TcD7+
         w77A==
X-Forwarded-Encrypted: i=1; AKwUvBynxOaFB0MlPORllwKRckHh49/1euFgpVMUpxSGSjXMRoGcF7iyMYWLPwJ7Gg4ak8oyoAuwG2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHWHYZg/JMALybJodvh+ULxjIHHvBRAw9Y/r977YxdJg6DI3sz
	/ZXP5t5mYfE+Khm6H1ryh5rEZOpxQHEh/fzbEEHWL8Tmz+8y8omqxIIA9pc+h0KqSdQF+NjHiiE
	0RTfaGKFoY8SXikSX+LUaWZvAVJI6iWSFWFEgOZPBUlkyVTAB8Po5m4/p1A==
X-Gm-Gg: AYBFou3n7mDioqbNmvzDRChE4vO10fUXZuySWgxYoPxioMhqcOs8yrTHipl6leFXVIc
	ltnJybGyRrMwoCthiIvsbFC3fH8Lb2+00A9PJLFtcQI5nVrjFd84ZNZzYfQcbmDFzPud8CSfb38
	/qzX7WzqXA59E0xAHb1ddLyiXLt/1BFO9quIs0JEHs40zJ/Ol26y7reSYRAcF6C6xGRf82UCQ+i
	yINSrjmf/J3OyiYS9t+mr/czmkgi97lz6/5nBXpUbQzutw9cxYAeUjqm+nBg8LjUifBW+pjGBUP
	w1KQP1NL65cWPbxJoUtR/NoAtj52eBoVEct0yo2cPRGtQu0nuHgNLZxwQLtmbWmncQzOdglK6M9
	Grr3viKfKfnfJvj37oTvFKVaJOQnNLt3QYxU=
X-Received: by 2002:a05:6000:401f:b0:488:8111:6f56 with SMTP id ffacd0b85a97d-48881117121mr15322481f8f.8.1790590340161;
        Mon, 28 Sep 2026 03:12:20 -0700 (PDT)
X-Received: by 2002:a05:6000:401f:b0:488:8111:6f56 with SMTP id ffacd0b85a97d-48881117121mr15322447f8f.8.1790590339801;
        Mon, 28 Sep 2026 03:12:19 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm25765327f8f.9.2026.09.28.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:12:19 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:12:16 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/8] vsock: simplify error check condition
Message-ID: <aro9DiEB3GPIMnMu@leonardi-redhat>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>

On Tue, Sep 22, 2026 at 03:14:56PM +0200, Michal Luczaj wrote:
>On success, vsock_assign_transport() ensures transport != NULL.
>Drop the redundant check.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898903AB27F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818575; cv=none; b=mH+PNBya3KYPfCsMbSrq4vSseQJEBwo85Fo16W0nxWQwXGEdGaIPCWnHIDWVnWn9Hd/odwSYKsEdS1LcNlZtuGm5Asc0wosIW04CFhDaODOo06acvo4E7iUZ3AxY7K/B0t9LCLSIDO4qjqi6poWCD+6SE5puOf02D/k95NXNCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818575; c=relaxed/simple;
	bh=5Wil38iMvpsIZK11IUVvoJ5BScZQ47Tf0YA6/5qz4K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A563Hn53bztJawpSBK6aCrHa0zEw+KAN7rJTGRdCwNAZH/0gp54ll1Feuy0FCi1WFjUQA+8N4D4YeH+dHxIbM5yP9X6z9P8SrZttMC5KksMsi3MoMoBquZjzuJtLqI9Jr0zis8psdQWQKaNwu8RieMREgkRQ0OnGNaaiVfuhaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxBnwFzG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy1hf5lz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxBnwFzG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy1hf5lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tp54ta4RHV2vRPlzgplP43voGXKdaE4x6ZtC8ibQyt4=;
	b=DxBnwFzGVp/vizxprD5TydllWa9y7vAcdsItKN8R65ZaJNERe65E0bev8csX1nYLQumt7M
	SHPzpobUG7DdOc09f6bJ5KjoQMyyoOKadPnzV2//03uDoDgpJ3PZL+/8rHOaRjO0CzI2NL
	tgL01GOH9A3AZaRU7kbZtcoGsU3pKvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Md4MMa_JPgSGaMnZ3pac-w-1; Thu, 27 Aug 2026 04:16:09 -0400
X-MC-Unique: Md4MMa_JPgSGaMnZ3pac-w-1
X-Mimecast-MFC-AGG-ID: Md4MMa_JPgSGaMnZ3pac-w_1787818569
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so5354795e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787818569; x=1788423369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tp54ta4RHV2vRPlzgplP43voGXKdaE4x6ZtC8ibQyt4=;
        b=gy1hf5lz6TjgyEgkigHt8QU11Ko1pwJzzKqS0LHUcYtrtfaNbX4Iuau/7KZ6Ekao90
         loyNCFswJYRqHCWjGjpWRW6fmMZCEquhxTYGv12uZIHF/NLn2maFM8T817wNKNjJgsmm
         bqXp8enU/59ma7Yj3KASvX3ehVbCKJ1UC9bfHdP627mhUxBCxq0Kh9GfRo7eJCKVDjQg
         Hir/5qJg3mvj+CSlmGyOZUh6lyaE2vlbd+9H7oE26kU9agybdryOISosapkoUNTBsT2F
         RlSfgYsj/c88Abtc+O/H7nUhzfSGPYZj9GcIoGdY98XMLr4MxE5lXbMbHuy19hGxUxmP
         7lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818569; x=1788423369;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tp54ta4RHV2vRPlzgplP43voGXKdaE4x6ZtC8ibQyt4=;
        b=kEUKZqqTj4+eIKWovJL6L6MLSNXVRdGdSswPOin0uR+EhgdthFBRc8NB6jO9wp5ZYO
         jVSPPGdzIWsbt0FPY5a3kgmq6eoKG6CJtPrIzaMmlW8xlPhgyrmfTeoodcKZcntuB5ak
         pmbUudAdHf8C1gr7mtu1SozkzkohQTtNiygAjIY2OLznBYe+31ZXVTkvbbvPuo5OFkic
         amdw4cLqqQ5ajSNWbCu3iJPIY2mx3qPcLQeEViZqmEEIxZUgh6OmGtJ7VNk28VZTXs8i
         c/VFqVXEyOkNRGOfwdhjBqfYGRKa0av8NLiUwDLOw7f0t9l1mIHRhg9vzMKEnrOEhU+i
         k4tQ==
X-Gm-Message-State: AFuF++lWsBTTJ68kYAtLaQc0R5MbzXDvOJhd3XA2tmCl2YqQXHQjeS+1
	lYqSVTLk4BrYh3FuECMY7H0NHO+swz6l/EoRIW2YahRcriEMM5jm+fAnGxORxJ0kznSnVj88rIN
	TQdZl8Jajgvu+1KceQaHRIaOineFDFBfuir6VwNlnYSDlKrHQixxVJwA6Hg==
X-Gm-Gg: AR+sD13xdnvdQSouDbars0NMFfiWvDfxGTK4Ad74FnA/zwH27OmjIqGt4q8Rzn3iQdi
	HxVOEx8PObJ+zGmBX4qXWovlLm6zRj8R/h0e+3A/yONhZUZTgvkMi7Cq6zOIHBPIfTdGeTW1D+B
	IxwVTLUPLsYwUdh9MDeUCZFR/V9ppmoeWFpQ+h3+1+zgbnrx26x0sWlbLswQiD/4yF0Ja1F5s86
	s8POeTRqObuL1Rz1gmDdt9suMOby2gpb1+Tr/2+euQMbmnABp++ASZFaG6Zj+maV+Opa9v1ZQM6
	Um9XkxFkQHaTYtvFFvaBLI+UkDUHWociRpfGtfhQe8uJbdfMc+eSuizmcDF2M3BFHq9k5BVszH3
	eUtknyrqFkPBogr00gayNWaEKh6kWKiaSW1SFBVhMiNsKB+jNBBH/nMeLgr7HiOLCxnAoC1Q=
X-Received: by 2002:a05:600c:46d0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49b0dd5821cmr54084695e9.0.1787818568699;
        Thu, 27 Aug 2026 01:16:08 -0700 (PDT)
X-Received: by 2002:a05:600c:46d0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49b0dd5821cmr54083825e9.0.1787818568254;
        Thu, 27 Aug 2026 01:16:08 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4af00fd2sm29601255e9.12.2026.08.27.01.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:16:07 -0700 (PDT)
Message-ID: <9397cfcc-03ee-4269-a9f9-97df1f454ebd@redhat.com>
Date: Thu, 27 Aug 2026 10:16:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: pktgen: return bool from
 __pktgen_NN_threads()
To: Chengfeng Ye <nicoyip.dev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
 <20260825185313.239861-1-nicoyip.dev@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825185313.239861-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 8:53 PM, Chengfeng Ye wrote:
> Callers of __pktgen_NN_threads() only check whether a pktgen_dev was
> found. After the RCU lookup they never dereference the returned
> pointer, so returning it past rcu_read_unlock() is confusing.
> 
> Return bool instead and keep the pktgen_dev pointer local to the
> RCU critical section.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
## Form letter - net-next-closed

net-next pull request for v7.3 has already been merged, and therefore
the net-next tree is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


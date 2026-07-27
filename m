Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138F3EF64F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144107; cv=none; b=dXwkLCHGdoqTHOSG0YY+4Q/hzeSt1ChnDSWeeVMohZgfy0OloI6+VA9iHO7lGAR2lyH2YGEm2uZueNB6o0iTeju2sauMB3rDpsnQ2Rpzi+ABuH4dQzzfgoEf0nzps+yA1tKOd3MQN9QfWnT7qyUDpeyxv/Ab4GLzA5k9oyKwplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144107; c=relaxed/simple;
	bh=KLRB9j0l9uMddZpmJJ9UMuI1kj950bKHl4XW5e2xjJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHlA1RHa2lAzp5861bW6lRpomfUx/0TrTXYmjbJZi+AeoEnXYdp8NRCa9/1eSZKXA0+epNzQKD2NaCzUSpbdykWqoaWynP4AoZzGmwlTShSxxAlfM3K02J7OKofRz4yCnWjIATCU6720dGpcxLhNdOzx6ghRoEzzBpxiD25A9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9UfUB2g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t0F0BR/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9UfUB2g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t0F0BR/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785144105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0MPGVQRHih57669NkWtWN5eklA8oiohWAQ6frlW3Bow=;
	b=c9UfUB2gJ5QTHuvVYKJV9NqOnOfmowlkEMpChbGKfrGIb5GAbaouTxF8XkYEA5nB2I0nyQ
	9BqXZP3slkEDPuz4F5szQGmbKY3M49dt+t5owaLDIlvxeOEf9aIUbmYxkOTgzqLRi5CW8c
	WGbksXjpuhPbmyWoIkoN9fopnRdrqHE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Beow4tHQNNu_yleXBm9PkQ-1; Mon, 27 Jul 2026 05:21:43 -0400
X-MC-Unique: Beow4tHQNNu_yleXBm9PkQ-1
X-Mimecast-MFC-AGG-ID: Beow4tHQNNu_yleXBm9PkQ_1785144102
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1f472eaafbso57939366b.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785144102; x=1785748902; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MPGVQRHih57669NkWtWN5eklA8oiohWAQ6frlW3Bow=;
        b=t0F0BR/WcHzMPcS1EYw/nc/TDps1POWjLvX/4i+zQZlFvrXxl3/Q01BOVzLLze0rR2
         fDd1/3ZUB9Veyzl1p79frLxgohgmPpCjidSDKW2wqFeyWroEhmXQrKaSkIBF1gAe+m5E
         aC52BsvSZvq8ifLkyWNUTXFFgZ3VaQE0+CeKNSk5b1mLfrOyHd55spAhZOVTSZ+V5y0P
         QlivNbu2ZYBlxuAx1zfjNi7cR2l1cGWOhpLxLBYDF8NW8EXBLNUfK+YjsyGEJvOyc1w1
         WFGAfWy5M1ENwiuQ+wBFkYLWaNnZhEEqe51RjuZ582itO8GXiU5bSd5iQXU7GUT61/CU
         veXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144102; x=1785748902;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MPGVQRHih57669NkWtWN5eklA8oiohWAQ6frlW3Bow=;
        b=IUqu8DZDrB4m/tT+h1ddejUmajjUipG0pZ1bOgUO94kpIUXbDEO+zBRihi3xL2IOMc
         Nia32qKxa3kUjwUF038cbXLwRB//WYi62R3CL+zRcJNj+oBDNKLVVLQYQa72yzwJnG/b
         c/44puiT4MzOvbkUzMuZqjoqLywA5DTie6/lagMUwuL/U6+K7+rajBO+8/zXsrLAn+o4
         hkLeMiJ6HzmOpZqIXvENDHxV8hP1SEjA1tpIKLpnmm+Eg3Dy+tUdGoV+Rp7s4DMyB19s
         gczx627ab1Xi3MoSMSy4Av0Ow/vILJL2DlnKtCygex/WdYwxQc5UEnb3KQIMWQcvilqG
         gHZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTUadMg4csQUOyyWGkiQNrP3hhkXWjcvjkW0AqRAwj21zNno68RQKOmc1aD9wE8I84sVerBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/170r8D4Cm4Yu5cDvSbnFfyn627FJBm0Bl0J54VCurB+HDU5
	YIINEv9jw1sNr6hsbjIZwWecm1RpKmrSht18+Ab3YcUKtBWYi2jjifhIVaFAe5WugdZUhzwWVH2
	hSRZ0FXKi/2HLxdRA5g/8iyhaZ5XzqE/Cb12lu1ypiEIUtIux3uw6Eo/VJQ==
X-Gm-Gg: AR+sD13kfMtAaZPwVv5kqXDy9pLOKksHhkGadjcyNt3jZDPv1qXdt7MYSzLPFnKu/tR
	7asc/NsLg83LVyDFBueKcUaOH/vvLzA7Cc1e23mvkFgg7nAIUJobNnyu9TYhLO+JppdSjqiKNRR
	uxYxv2T0t8BHHiGlCbeKt8cETuESd1NFVtOzg41OsMyWszrtNkMsiQhXPz/iiEYll5D2EqyJe5+
	SWvdfRbFUx/3TAEF99A24F4pqw6S0zUtC+oDeGmTd+npZe4TqmEMyKsgstGmrcwfEUZAXPKdvd5
	zLqVr7GrnsIaoNaHsI9HMojwvWRkclj1aWf2A2O+3q09sey84VTolQch0tkh4u3uFjNGG5XwImO
	MNYqZPnmQLpW+uIB74hpj+nG8z5q0rFx4OKUZlGb7cciJ9OFVkg==
X-Received: by 2002:a17:906:4fc8:b0:c16:744f:5bec with SMTP id a640c23a62f3a-c1f1f901f56mr328637966b.0.1785144101942;
        Mon, 27 Jul 2026 02:21:41 -0700 (PDT)
X-Received: by 2002:a17:906:4fc8:b0:c16:744f:5bec with SMTP id a640c23a62f3a-c1f1f901f56mr328635666b.0.1785144101495;
        Mon, 27 Jul 2026 02:21:41 -0700 (PDT)
Received: from [10.44.33.167] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32af243fsm605357066b.26.2026.07.27.02.21.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 02:21:40 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: aconole@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com
Subject: Re: [PATCH net v4] net/openvswitch: check Ethernet header length in
  key_extract()
Date: Mon, 27 Jul 2026 11:21:40 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <8FF38AA9-D6C6-4791-A742-064156F53527@redhat.com>
In-Reply-To: <20260725043128.193164-1-blbllhy@gmail.com>
References: <20260725043128.193164-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jul 2026, at 6:31, Cen Zhang (Microsoft) wrote:

> When a packet arrives on an ARPHRD_NONE device (e.g. TUN),
> ovs_flow_key_extract() trusts the user-provided skb->protocol field: if
> it is ETH_P_TEB, the packet is classified as MAC_PROTO_ETHERNET and
> key_extract() is called without ensuring the skb has ETH_HLEN (14) bytes
> of linear data. key_extract() unconditionally pulls 2 * ETH_ALEN bytes
> for MAC addresses and parse_ethertype() pulls 2 more, either of which
> triggers a kernel BUG in __skb_pull() when the linear area is too small.
>
>   kernel BUG at include/linux/skbuff.h:2848!
>   RIP: 0010:key_extract+0xa7e/0xd90 net/openvswitch/flow.c:933
>   ovs_flow_key_extract+0x419/0xa70
>   ovs_vport_receive+0x222/0x390
>   netdev_frame_hook+0x3e0/0x630
>   tun_get_user+0x2d0c/0x38e0
>
> Fixed by calling check_header() in key_extract() before accessing the
> Ethernet header.
>
> Fixes: 217ac77a3c25 ("openvswitch: allow L3 netdev ports")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v4: Update documentation and move variables into the Ethernet block.
> v3: Use check_header() per review, fix format issue.
> v2: Moved the check into key_extract() per Ilya Maximets.
> Link: https://lore.kernel.org/all/20260721143602.64677-1-blbllhy@gmail.com

Thanks for sending out a v4 with my comments fixed. The change looks good to me.

Reviewed-by:  Eelco Chaudron <echaudro@redhat.com>


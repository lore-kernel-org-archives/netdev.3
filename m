Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977465;
	b=1HqbJZ2Pi8jobJSDWGe0usBa+8lJMcSUeKSIhtmprn9OI4ST6WiLgVSJVOa+x92cSnNS
	 NuxdZz91XXQtaheC66UD030gDgJHjgbC2ncE/uzLfooGBW+H83tATtn7E/xnT5X8yVoqp
	 34lK7qYVUQaawwpIaTo8NoWJ+f5H4bQ0bmj18msGTLkJtGntLcCxDCeo1y2e0tmvh3oaC
	 9H6YLWiyPOyDhY2PIscXc/iCO+iWcEWnw7wcKZAXl4cOhqjgMUR9jhMAilMABuYS2O5w4
	 AyyqiDQgqSDAbm5ur39O0IohD4WO0Uo/B2NgobGQ4WFiVRprrBLevkjRIWndVJpwDCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977465;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
	b=c7afriQ6rKZYUe0mxSh+jcnQ6aKzBloII7txd4ZLUShY/DVV6GYd0mEM7x8UKCPxoEqa
	 scZWegTS1s4ijozutqNaw1igGViEcs20BwZCQ6UWpuQ7McMj8O5AsXBhzxPiB/BM+aFcG
	 avjdjjfvBSTRgGQf0fjWfh+86cxpQw3QNC1zhXBCYMew/T9n8ebrFfoAEFmixqCqrK3v3
	 +NmivJZjw0Eoe9/MZOPwHZfoy8ixe5PIFVNKh6Bhli1zQ6jq6AJYxw9u9YODk6oXx7G7T
	 JyCDI3eYnMFHNBtCZn9Gk9zHb5xqDFKNIDZdL599VvINptcsrfAyZOt8zDLGJv5OXiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWK8mNFL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S6xiJ5wq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104D606A334
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 15:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A104D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWK8mNFL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S6xiJ5wq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793977463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
	b=WWK8mNFLyxjC2j45krxL8GA94iDaW8S15uiC9+1WBaG7x73VUQEAmMAuKCzRsZsRdaTK+g
	1k2eorJfUNkTsLpGqbF+ZpSpEQgEaFRobpU/hibCOzwzCPTqDrvZjJr+QZXG1FtPZ3r4Un
	oYzpYEx1zYQeeCH0q6qA3D0owybM+70=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0h5U-VigP_-UeITxobCEpQ-1; Fri, 06 Nov 2026 10:04:21 -0500
X-MC-Unique: 0h5U-VigP_-UeITxobCEpQ-1
X-Mimecast-MFC-AGG-ID: 0h5U-VigP_-UeITxobCEpQ_1793977460
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso787568f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 07:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793977460; x=1794582260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
        b=S6xiJ5wqA/od7IZeJKfPCBCmLGnEDEfekLmT15O1Ac+R9YG0Aw0ZvJzxQjJPtRHpsL
         o1APzKoVg6LEr1p8ZDdWgP4NhMgVdovYLS6OB2R3Zn0BKKFo0VX84vpYZgejxXTackc+
         ONSCixlpOKR7RORqTMhBOOzLuFYBJsc7pCNkqS6CkLESwD6CsLEjyya50G6ZNUAkkTHH
         Jx6jdsD9/TPpXQGP/SIQDji8sWl+5c3hxCDFQ9i/Wy+OUbUrNL3es3PNYxvYnabwaulN
         epOf4U6AvYLKS7xhkc7+rOl2+JKpGmKEj+2ZeotAWLctJNwlUl+MktF15EncOy+LKERg
         XUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977460; x=1794582260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VFHEfM7uSHxmbeEDYFc714iPr6SLeYV/p8Cpk1n20G0=;
        b=Ldxjin8h7G6HrYBKrcGD72LS+8afo1PQzgXFYmOQtazGct9WT+j/JHhWuyHTw7kMfb
         wa3hBaknRnJ3KgWj5J9PricR5P/MC6VLKpkO6jklCZhfekWv4sOeLvInpOW9HbsFGdoP
         WsbreiRim/aw+xaKgWCfhDNxzf6lqxjz7ARSJUrdBpV7Rcqx+nER4OoSsxLPmzZVuH9h
         R1Nv9B8FVUAekHXtgNWL/KvTQzg/AEI9CGXldiv9D1OMnpKhb+9MOyCFTPS7HE8QAyzs
         aIkWcAPbPwJfSnmQB9xPozbVEMQytHILJR1VsS4oAqP1iWiy6g6XVAaYSBc3n2zNiE+c
         MlCA==
X-Forwarded-Encrypted: i=1; AKwUvBzyrK4AoqyBrtuvra30NqdyESuJuH0VvcO8OC9+/nYSuLRbLrN7504wClnTeV4kMpzVIcvD7+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q5BvNtbA7hIL+qpCjf79rViRG2k2jXmJQDwTSwX5DwBZ/Y1O5
	QVvVzc/sEgl+nAceleteDLwY+pfi44g6s4CZT5dnE87rv00a0eI5ehHaRYR3bqCOZSSMMHGUTSj
	cMDFTyUKfD6fzAUIqggzXeBv7O/UujXxjIk5reaR4kuELuIK74RRNy+EfrA==
X-Gm-Gg: AYBFou2z96dAyemY2fydvb37c62duOYQksyv/j89aZUems8wD4R26KQGwjyJ1n+LQfc
	V+q5ZPzkrSgNLiLYLm7PdrI0B/d3Ehkx0H+RxpiJlBAS367qoYxl8piguVpdqLjmeAGeH2YvyNI
	G2KMom4w4BqVYoPxnRannMQtgRhhCqo4bB0Agb1TsvstITlIHQ+ZHQMBufYVQBZVPAQL+wHqcJ3
	yxq2+J5ap4l2Ytj7ypw8rV66muS6taBQ/WKvdIHNSm+KmFH/GAOLjnvmy/gngwcEi4T16xionk3
	2UR5SviX9PpIo5UOdmA0TWPJKVN+5cg4cDbqaok9YWZ3RiHS0l0RtBwQzwhwygplWb6WYKsFeux
	OAfcihkYm2lbXtdYAeR9uqOEWG19QEU0nBhPmfueBTnD7fIAfewgYGpb7pTNaN/0Fe9SLmbLkFT
	UbDCUIX2zN
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr42830165e9.21.1793977459573;
        Fri, 06 Nov 2026 07:04:19 -0800 (PST)
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr42829535e9.21.1793977459116;
        Fri, 06 Nov 2026 07:04:19 -0800 (PST)
Received: from leonardi-redhat ([176.206.36.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7626a2804sm29251095e9.4.2026.11.06.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:04:17 -0800 (PST)
Date: Fri, 6 Nov 2026 16:04:15 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Report no unread data before a channel is
 available
Message-ID: <au3sW3i2qjKDLMzq@leonardi-redhat>
References: <20261106123920.162131-1-parri.andrea@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261106123920.162131-1-parri.andrea@gmail.com>

On Fri, Nov 06, 2026 at 01:39:18PM +0100, Andrea Parri wrote:
>The Hyper-V transport is assigned before the asynchronous VMBus channel
>offer completes.  Its zero-initialized hvsock therefore has a NULL chan
>until hvs_open_connection() associates the channel with the socket.
>
>SIOCINQ can query the assigned transport while the socket is connecting,
>or after connect() fails once the transport has been assigned.  Unlike
>poll(), that path does not check stream_is_active() before calling the
>transport's stream_has_data callback.  hvs_stream_has_data() then passes
>the NULL channel to hvs_channel_readable_payload(), and any user in the
>guest can trigger an oops:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000178
>  RIP: 0010:hvs_stream_has_data+0x23/0x120
>  Call Trace:
>   <TASK>
>   ? vsock_ioctl+0x74/0xf0
>   sock_do_ioctl+0x42/0xf0
>   sock_ioctl+0x27d/0x310
>   do_vfs_ioctl+0x700/0x810
>   __x64_sys_ioctl+0x7d/0xf0
>
>Return zero unread bytes when no channel is available, before accessing
>the receive state or ring.  Leave the existing channel-backed receive
>handling unchanged.
>
>The oops was reproduced on an unmodified v7.4-rc1 kernel in a WSL2
>guest with a small user-space program, available on request.  With this
>patch, the program reports zero unread bytes and the kernel logs nothing.
>Other vsock_test cases were not run, as most of them need a host-side
>peer.
>
>AI assistance was used to identify the issue and develop the fix.
>
>Fixes: f7c722659275 ("vsock: Add support for SIOCINQ ioctl")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---

oops, thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Luigi


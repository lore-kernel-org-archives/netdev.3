Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787105;
	b=tU1kQymmyNXcocej3mQ8e0O3AdRy5Zx9U7wCjFwkUGvJQZ7hdn7KZUAP1ik/Ppp5FsdW
	 UCZjbReHsJRQGz0f2rABpTsRl6+u7R2mzfExwNCZ5t87JJezjLnu1760TtRoQparb5htY
	 IivfPJFvdwngakhs47Scc5U9f8uITm0U9VHFDo65wCkRrYsFViZOBPBsrKZ8PIcMPPx+q
	 nHE9asPtjuaQskassWUdfZ1foG5YQ8InjFLX/yFBp+qrbcbfy7VyZDgOViSguRYZVHAiu
	 +Fx0T0GG/3fzoMkKuUBHR4wzHuShCY4wOVkCUOFWmaUs8dKrBsUfz99fgLUwhWv7rWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787105;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
	b=G4gycSiGjJJ8PLOsMqJXu4Djq1n4hHcMVdFvEucaUz7qll+MgtAGq5Bd03f5VU7ixLTA
	 f8RwQyv9YG8RjizHrOhy5gfXp/HPjSdJpfBi4GAWbBQMTLFmpP9ltJ1g5X95lm/nV5c7v
	 j36+YajeQj9mi9FYYCUReI5xhES9tL0UduVKZKkQlhTtWv800z6XD5j2U1acQsJ+qUbpa
	 hk8tHV3jmTwkc9Jtn+XnuGDiVXTO/OAIfnr9i/BiZADgeYjVSoyj/NFfbtltyfgF6el1N
	 scV1brQcRgXx7s56Y/f5WRNM7LJ5v6rba+yupk86v5o4Nk6Pdhdib0thWxAc3VQnetA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DMxfqLM1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ARyq2B07;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A65606A33C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 10:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A65606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DMxfqLM1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ARyq2B07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793787103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
	b=DMxfqLM1OeoinGXprJ4HKCTd++PcuBPZWZik4x95OGCsh5ZTxRNvan5Ax4pNW8mQJ0/SFw
	8QKcXgWirxT3tkLcWDgr7sHgF3UGfpsAUrrPmKDeMD8F4LXYFzI/1ViJiy6Ea5Pcm1WJcr
	SlXF6BKC3cS5VZEPE/hjB5i//4X852E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-l1jLBkJjMWKDnGYeN-2eUg-1; Wed, 04 Nov 2026 05:11:40 -0500
X-MC-Unique: l1jLBkJjMWKDnGYeN-2eUg-1
X-Mimecast-MFC-AGG-ID: l1jLBkJjMWKDnGYeN-2eUg_1793787099
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso408205f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 02:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793787099; x=1794391899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
        b=ARyq2B07sVI7UWCqJLjDG1Fp1kBBO4hBUEDYM4VF8wi8wMoxVhe6Xce3O8RbTxTfSw
         q0tbzawMnnFgBiU8Q4dH/fYgRcW+JvMoV4cu42sBPD/tG4RWsCdfPJq+pMW7Re0fmL/H
         LygfXBpaD51nJcQYMEDgDSSRaDBAlKS/LeLyW/fJyaZsbuQwkK1+4q0ah6suDgpKQxLX
         ri2RxFrsy3XT9m353pX5ryFJbhXy4rrFjPxpTecnHNWmqIlsU3L8OMR/XF8uS1iSvImg
         sd4xl43WuKeLrorp6Uw+d4bPKaurhdPn9Kdqn5ykbydQBABgyCOrsv/LBbDhUGqQE8s8
         4szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787099; x=1794391899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
        b=Yz8fkcl0O7EzdGaodB2F5JIejKs+WIsGIbTb7roILHLdiWrUMf6jJ4sbEhllE+Vgyr
         iSlvuYr+fBhJGwQY8ybiOW2eLEgxQTO4cWII3+Vo/216F4emDmi00gMwDDiBf4idnUSE
         evYdcEh/wWXzuYtrRrnzCnskjN2kktS97LeTq4lsmqxd2pDZ3N+4rsbXiSiuBSomKxJB
         vLmRYoAs1PTbu2NdLFSp7cTnfBl7FZt58Gm3lhc1ZFH9B+iajhwiHUrB6UtCuQWimQrC
         XupodB2isNdPovRYUu9ZVA0MMkd2J1sH4KG6J4CP3g+dhugijQtDdQTaAxfFxh+YiFkf
         c8Fg==
X-Forwarded-Encrypted: i=1; AKwUvBxpKLRp4yE+dF4BWG6R49mDRB1gVCC0tZAr29qkgG6AcA1f1t4IguEpgF7HPHd9uU9Aiu/gqGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z95ug1MZVt0EP58Xsn8vgTq+0/s0sxCr5qr3/DXiGz0ud5uy0R+
	qml60yY6HLcSZWal6DVI8Kh2AdTZhlNUxtjRucc6RDPD3pq6oLqbSPbzoBs/ImH0XiQpmBZ8ZDu
	2bzQ9/Ttf8SMm95qVsp7wOVAMD5HksLJAnZs2n+Hkz4YEZUS3AqUGHxM/pQ==
X-Gm-Gg: AYBFou24YfYDkdStSrlWP+PBhQBGaPWroINQJdeFjiRHzL8NC65shfQeZMGC4HwNznx
	UuAgA1z52SI06GUIZVxCe+uHxK5H1aS+RRxp2ajacjKNGznQ59VEhebsiO0qLyIh7TtSVxNWYHo
	Ut394GJayYvLCOVYGO98ig2yzW9oVWW/R7GifjiPqotYkbwhB07MkBfdLKUddAoNWwPXSHd1lA4
	l8V06fbhlR4yhacWjleGw5/TcXe9u7bDXgdqmnu+Wc+e1cmPoc5niRyd4fByxHsL04nRVXy/T4R
	zeoaAnXkgJdiVDLoxveFl3a4yPP8nSCCeY2QoVVlTqCu6uNN2TE8/LfV4aD8OSoC8FeWBoyI2Uf
	b0l05WSRDFt7dpuNgy8FTkivAIGq/x8uWiuhOtG6rQQvi21F1UDJE
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e6e2e76famr33250725f8f.15.1793787099112;
        Wed, 04 Nov 2026 02:11:39 -0800 (PST)
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e6e2e76famr33250672f8f.15.1793787098615;
        Wed, 04 Nov 2026 02:11:38 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm3214680f8f.6.2026.11.04.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:11:37 -0800 (PST)
Date: Wed, 4 Nov 2026 11:11:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <ausD3NBfYVn-n5ra@sgarzare-redhat>
References: <20261004235101.1464007-1-4ncienth@gmail.com>
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
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>

On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>guest controls the descriptor length and hdr->len independently.
>
>A guest can therefore provide a 64 KiB descriptor while declaring a zero
>payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>remain unchanged, and only the fixed queue-entry budget limits retention.
>This is not a lifetime leak: the skb is freed when dequeued or at socket
>teardown.  Repeating this across connections can nevertheless exhaust host
>memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>a 262,144-byte receive buffer; a full-payload control retained 265,984
>bytes.
>
>Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>from the descriptor length, introducing the allocation-accounting mismatch.
>
>Copy the header into a stack object and validate hdr->len before allocating
>the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>capacity no longer determines queued memory.  Check payload_len against
>len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---

@net maintainers, please can you queue this?

I just reviewed since I missed this. I also had a quick chat with 
Michael and he didn't queue because this was marked as "net", so let us 
know if you want Michael to queue this.

Thanks,
Stefano


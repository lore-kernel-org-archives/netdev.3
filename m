Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785369;
	b=M0bwmQ8c/hc/QuJ/51lU6oQEutXPqJs8MhqdrUfCRomzOSseFocjcDUjR3+UMvKIT2Jd
	 xhm/xmgosQ7ycxG2P/RB5g//rSVwgTjq7STHPbgRw4Z0u8S75NaRAJH1GoAm9y1EgyhFu
	 yBfR0/vfpY7c3VKxvmbnaIn7aTmCWKQlZbs8/cupAwUA8YhjywmausmYJRhFypkX/R3GF
	 4UjjNv0PHTOCHi7b3NlzLDdK2uHec+aWgfM8vSmpdx+2UIBqNrqOe0ZVNNkBcsKbiFp2M
	 zhDrKdw6OSyPpVlM5uHm2x0TixVxBkrcE4gOXLyMDKBU7nCm/DncB6N56etigsDBwqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785369;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
	b=gOTfXGLwckIxKx4a5TtQblQxG9bomY0jJqojZGtuqC8RlIKxnmPk3NH5GYnDWJfz0nnQ
	 UzDlgif9e3UJGum28bXWQRRGobSItxDdR9dWNTJjmWrzzuAcov/zNppuSnHWUrDJSaOp7
	 x1QM1r99WtwMfImHxF8mgMMKgVAGIXtBs7zd5fC3AQhFE1P7Rl5fGXp6CS8qxmyD4Q+9B
	 Bij9V+jmiF6zBcC3l8D8ztOZ6/P5GroktnOIHkboA0RnsKPm3cDGrL9pxUiJ9CmkTW/zA
	 Ti9TrEwlGEwXc5RDkBKtHEWp/ftFfOVJ9TzVLKRj96KoA7h/iNkNNcZs/QL75o9tGIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXJafjbT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VLcMq8w7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C690606A32C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C690606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXJafjbT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VLcMq8w7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793785367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
	b=aXJafjbT7H4OqzEMgsF1+yzcsgWy5doA494RWx0/MZN6rVyZ627kSbteQzoUbj1LGKZ1ZB
	GyMK1Yyc3d3QNeqs77H49a6hGNntABHrQgH0SIPrcbz4rc2R14r9Un/NhOuTm5cyKMos3I
	84AWRdkaSXPh0VwF0daByu3xyY8UjXw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-OPy7EHa7PxKY6wCfRkwEGQ-1; Wed, 04 Nov 2026 04:42:46 -0500
X-MC-Unique: OPy7EHa7PxKY6wCfRkwEGQ-1
X-Mimecast-MFC-AGG-ID: OPy7EHa7PxKY6wCfRkwEGQ_1793785365
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so10312385e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793785365; x=1794390165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
        b=VLcMq8w7NjA2seEl+JweYwYbf3dFqMh5ATN+rXrN1ocdvXoR+o9tOUiTCIf1sDgJbe
         0ZLgwNVv+cM4P7T8o/rWL90k7KUO96QvBSkJMsHsSzy+s/QKEx5p05PXiR9E7Hzb02j8
         0cZA7Fx4oe8weJJy6MLMtw46lzRnGNYN8rv86oQZnVVCe1FN/V6Dv6Bdm/W+SLwOfyHs
         6dwvyDNHpBSyPgZM1yyKhaxbzOsMJ34b/A4gqpBqDFYeffHXvEgxLH4IjGeNqHHs6R7/
         JdzxUOJ7bQaIxaRllZtcdFynh/cugCIMqnXB/ZUyCmDN4ujkN+EULfjHwJfardfLm9wp
         QzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785365; x=1794390165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
        b=NPrPw8rz9PlKdQWuCm1j4PteqmQyYBBbwgn7vDApmxJwSuUOfQ7QO58iwcgsRgDWsI
         gkTlx/C405WLL++5dHqfpx78+NIYW07q2bElSKEwrmbMifVCuHm19+EZjA65Thw63eon
         uQ3zWN3zdt9HITVJxs9hkmf4q5O6VbDGdQb4cbfUg+9WW4bQJ0yTl3zUjVhdVyPJk02U
         Ke6u7EGWydX7vqk8HGNdK/pDylUIyy72m2GyuI8js0WG4bP8XnmTcBTRrMZhyW+TIyZD
         NlyMj503EM2HiCFserIG3Uj98ksYI//ddEFLr79ojqc5HLyByuCZNnidlSyv9ukS2vpK
         7YeA==
X-Forwarded-Encrypted: i=1; AKwUvBzGhvrRLSFcmhS+r1qI5j2O0smgLvYJZKW2sYlf2C2Cy8c/PQgb4lv754Nb7n0hQkPvhrGRm/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ASMnboHEQR1KnuEI3ytOmePgOPiXd1L9id2O9gfwHKZBaPKCN
	qQc3dCGz5CKyTZtzbCzL7Oak0zqZqEdq8uTr66yrzhcDqzc4ajUp1phZerdnhhReHQqb1Xo78A9
	f5hj3pp6983vKr3wH7YGP5oA4zS7sCfTBPnJ6InNizm8GMkOzx4nDooh0XA==
X-Gm-Gg: AYBFou00YtXVZgMSIykOg84V3GbNnYJbG5eF9yLhPiLyIJaCaVmrIbCQvgZruHU6KSf
	qX1+tfPefrIY2m10OIcIBk6jbKMoUB3SlDZBPsSr1bpCmEmhkwbL9yR/b71+50xdVYt3KIuHk62
	ubz4FKgDrqnWWHKJmTfTwrm5UJhBdebTnsLckPqQZVAAHGak7PbcSc0WRX9w/AY6fiaOTCL6hdB
	+qnQW5YB3MQOxlJdC01Uj4MCXjHQ+bTGzHVu2E7GkZOYn+Yvk/vjT+s6wuR1iXsGaaj5KCBwZzn
	34d1Fx/oLZSVtgA0c52KAHVBPA6ya3Fd1snkc2vRZ9Tjz07cA97yDPFMSaspRw90mCbjfXesvxh
	I/STUpsgBAiH76BKiWiCjW01thVOXF6mA5VeybjjqR1IpA50Nm0Le
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr363922195e9.6.1793785364721;
        Wed, 04 Nov 2026 01:42:44 -0800 (PST)
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr363921935e9.6.1793785364240;
        Wed, 04 Nov 2026 01:42:44 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm144133585e9.5.2026.11.04.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:42:43 -0800 (PST)
Date: Wed, 4 Nov 2026 10:42:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <aur96eHKMVO5zMml@sgarzare-redhat>
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

Oooops, I missed this, LGTM, thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


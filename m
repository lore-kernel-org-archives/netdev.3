Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502970;
	b=kPjWL5CGsnGcHLlaUKk4UJhAxXIh24qjE2N796ZFWpAtARcg/A1BkKTE82v7hC/XBQVz
	 mxYGr8B2lIMbBUfQUKDKsEB25HYVWPsNsYHT3sHNMLuy4RY+yVY+Mnn2dAZ2OGovLYf4t
	 mqiSQH1YFnUNOVT4BmPzctLyzlzl+bHX9DJ5Rz6BDPAWZeSjunVfofLT5sdSjYVJXHt+f
	 t1newMUTR9nqnQbJZ64bngTXXKP4JxJlIY5ZsluQOoan/uvklCHb5L/gJ/wwgBhT/pOTX
	 hnO/2TM79AbBU21XqXoMUBtI+kKJ0J8ZE1FTo/zTqI8GewjB2oM7Qabm55IwGVNdvaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502970;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=EhEIRCVXOhl/HJDjHkcZ8OGB71yyKqt+lMtATwR/bFfnBKXPjM/sqQp+aXPkgf9hqmnT
	 5U/urzsE/SnBCsNv6VNCCPNjmBqixWo4mnUYnzqpp7Jn++tSrE/rN3y1j2YZ0xL72JRH/
	 G2SlTTMdWKGXu8+IWIR4OJjSBkfM3s0XZTOejCTiON/OEJi3/g1WJL1O/2f3wHo5pfsqx
	 3e+GtaXqzhwpmgHyJpmNoxXI2xo1Zy+Fwlno8pi2Sevj3ZV6Uw6dAi6Ni7vsACq5HRGX+
	 M242bST/yGxZtpD7WvfMd/YdDbzhjIF9u/1OElsknEXnBxp957IKHcuZie6BIR0Y3/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQ3lHNAj;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fq7YFxue;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C9606A32E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31C9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQ3lHNAj;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Fq7YFxue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=UQ3lHNAjeOXsmCES4hWjxHOYer6q8c+25QErNO+A2n1KnP5/5APW2ESjNvPWYQc56JgQEN
	MZGJmmOZMVt05+xi0OZ8C8iW+paIyNhLJDRnWxxOJm0h/+h2YbWmcNVg9v9IkOfsSl1Fnb
	kudmPfuvFpNzGevPcZUjA7CKnZWu05k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-S_MsFjxNPx6fm5WBf099NQ-1; Thu, 12 Nov 2026 12:02:46 -0500
X-MC-Unique: S_MsFjxNPx6fm5WBf099NQ-1
X-Mimecast-MFC-AGG-ID: S_MsFjxNPx6fm5WBf099NQ_1794502966
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-7170b84e158so3947807eaf.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794502966; x=1795107766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=Fq7YFxuew4y7VYWcjll5e78rzl8lIIgzpNXpaYN/Q8NWnVIoAajywtbu6NvnCpqxUW
         +1IAiKP12pJlcr+LGTE6q7iwkNzffOFimZkthIQn5OnHflCcBpuOIU4F2vmUVcgEigUo
         XuvFw8xYfhpop8HoWiKm3c498ITO9JXm68E4K22WtAijG3eEqrT4s0Z2oJMcj3QxRKV1
         JPbF2XywvRdd+B1f0ik6ycufeWJuRVIF8Xa2OS9nDUvAIJhq8q6xdaL3vBluXbncjohj
         GrWaYnh80smBPTcYIj4VqyDEw+RsqxujDxB13NBxbkVpU7nsfJToThSwbqKFLRBVEKK9
         gjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502966; x=1795107766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=sX4Lkr9tO9h4fRSXSps08z/wZbraB6q3kTIZkbFwaNVs9ed8EmY02CMiEd6pCJYvHO
         MQovZC/XHvtqQyvGjVIDCAItpdIA9Fm/xAMuw8ZQL5zLa22GQAmIDfi3Z4R2oO+oqkIz
         wv7SauQwbQkzvM4Nk0XayHYR0ygGWEBbRBECS1UwudCt03lbNUJFV1TVYHDkX2P6j7ir
         q6ZIpN0na48ZlrrTWrLR9f/Iq1+yKaCKyUjUvQxYGI6IsWfXm1v7OxjZKUvievpsrabf
         Int2891DInCU0Xg3FZnkiDULFdD6Efd/rdZoRWhc38+eYdQD1nV7q3HKMQgdY20+0XUQ
         RQdA==
X-Forwarded-Encrypted: i=1; AL+hErGpEsLGVXqlwIoWnHappU/rANQMvRQoxtYjjanLnlP18idbsovE35/NrLRx3Zli1QhJUKfDk04=@vger.kernel.org
X-Gm-Message-State: APuU4Z96QfHaFajZCM4JyggXhG/Q/RRG0pFY7lpn4dE7HyqlNq5orw8m
	tVJW9inKElW3ba2Kn9BMi4ofYeKMIWlYBNTf1BXXfYXBpJwpbI+DAa5HuKQx+lXCDsw8+zIniud
	PInlGihwxYxvCOdC8r1yyF9OCcDMVzqmgCcj9uloIdDib9Z0WBpu5WT4L9g==
X-Gm-Gg: AYBFou0EXwTLNSOn+zxqvz7KZwzhpiZU2Y/815FgmvoJ0m6hSJ6gZu+7xVZbvPK5lup
	yUyg3oBoAoYl60t3wKxQ+IdgDkuXlcLD9rseCbsnfi5xF+yKkAHbpTwgcGYs6mlynGeX9my3bQr
	DmS+Tt2mr449gmIcYDG+WB95kP+9w9byw9p+hy13oiCJmJ6PHhhvXUMbKu929k0s+6jjwanBHD8
	SDzHaXgC3M1kr/tlQJ7S26onDUl7uZzH9+6T/+BHtisahowUIMZbds/o/PwfRs65L9OLTTD6evG
	cPtQ0V6EO2GIKqnW62CuxKqlQye4XuG/aADJWUsoOEGaOVBzp1pJ1tcgIzgars1GMWET8r274fT
	PpktUsd/EpzE/9DyPOj3vidQ8B2MqBmpi+jaYEaQT4rM4XCiRA2BF
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797263eaf.73.1794502965960;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797227eaf.73.1794502965373;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm5433524fac.6.2026.11.12.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:02:44 -0800 (PST)
Date: Thu, 12 Nov 2026 18:02:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <avXxFnqVLMgBMjBP@sgarzare-redhat>
References: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
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
In-Reply-To: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>

On Mon, Nov 09, 2026 at 08:39:24PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
>pointing at them. If virtio_vsock_restore() then fails, the driver
>stays bound with a dangling vqs[], and the next freeze or unbind
>passes a freed virtqueue to virtqueue_detach_unused_buf():
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>  Freed by task ...:
>   vp_del_vqs
>   virtio_vsock_freeze
>
>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>early from virtio_vsock_vqs_del() when vqs[] is empty: the detach
>loops would pass NULL to virtqueue_detach_unused_buf(), and a second
>del_vqs() would free virtio-mmio's IRQ again, which only WARNs in
>free_irq() ("Trying to free already-free IRQ").
>
>Found with the help of Anthropic's Claude and reproduced on virtio-pci
>and virtio-mmio by failing the restore with failslab, without other
>kernel changes; the virtio-mmio WARN was found by the netdev Sashiko
>review and reproduced with v1 of this patch. With this patch neither
>report appears on virtio-pci or virtio-mmio guests, and the vsock
>vmtest.sh single-VM tests pass. A find_vqs() failure after some
>virtqueues were set up was not exercised.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v4:
>- Say why the early return is needed: the detach loops would pass NULL
>  to virtqueue_detach_unused_buf() (answering Stefano).
>- Say in the message and the comment that freeing virtio-mmio's IRQ
>  again only WARNs (Stefano).
>- Move the send queue purge before virtio_reset_device() (Stefano).
>- Message: the use-after-free also reproduces on virtio-mmio.
>- Rebase onto current net; rebuilt and retested on virtio-pci and
>  virtio-mmio, and the vmtest.sh single-VM tests rerun on this version.
>  The moved purge ran with an empty send queue only; the ns_* tests of
>  vmtest.sh were not run (they need root on the host). The reproducers
>  are available on request.
>- Link to v3: https://patch.msgid.link/20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


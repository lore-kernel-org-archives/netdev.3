Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A4378D87
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989407; cv=none; b=NDVXL/OUKAWGcKBjaMfYGC5OtL5MeEsS60rBqc7CETcraX1YusHbYd0iwfNzAIKXDT8NNLh7pLMrr74gjU/cFunMYe7F0sDFSJjGjlixfOj++Zg7KMze0S5AR1YHUElNsnHdwnei1TRrNRMc/0157SL+kbHeyJWH6QHylB2Zkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989407; c=relaxed/simple;
	bh=9JWIDMRvb6uL0k6LrrHl7ti08cD3k8wEjt9ZJwkEjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0mz4KaE9+47BJ1Eq6AkqmDFGWnziMbugdYTSV+xrRCkkr3BUdntj0IBi7l1nkqVApL2ZoOebjeToPspYW9Izwjey2SvnnmHQGb7pklzbYSw8jmO4VTFOf7J0kYoeOAOK6tP8kGt85KtLXmtlAvx4yR/8ii5rBYW60q6RYW+d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDq3okXP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDq3okXP"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f3fd905828so1295549a34.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989404; x=1787594204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8k1YxolwhVR5S1sB1XwRYtHWGpS7hH+697FP1h9LyqI=;
        b=ZDq3okXPQY+r8zgNNn8FwMUpvlrpBWVXYnLW7IBDLdtXml5iac3Yq7ddEjkMaCFmzY
         Oy1Ssq+8g9nXd0t3qCVxqk/Il5GTe078VJdreyXKpLPitm1LGHhcJbybLCo1yMaOBxp0
         t+Wno63MUWYpsfzFQOfw08oCYeIzlIVoevymMzKV1WmWSl0nBDwGjSx5aQCgTbDI2Dcl
         Bca/1UDosFjACirz47dp7zhTs1vPL1vCPl+n+kaJZNjJcwa29+lk2/WJnG3EvDampiwT
         CCUCkhHc4uGJfm6qUC2nEmMDfvuyQ1NcAkNGMNhTKKK+aKcDg7ZMdEeK90wQh8hAPWNt
         Ca/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989404; x=1787594204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8k1YxolwhVR5S1sB1XwRYtHWGpS7hH+697FP1h9LyqI=;
        b=ZKGQnGjX/N8IXib51+qpzTObORe/qUyx7u33Xe+xhlVbrFWEeyYeJsDRl+3ux+BL6n
         9eZ14rgncYT//9SAFb+tAr3dOw6LHoN5nzr95bA74i6nvsI0hzQ4K2ipsSRqdcHGVu2E
         O9BfHOafDjqZacoXL+D+M300MssPQlZaydOCz4SLHqmnUwJ1P4GIAl5XcDjmr5aYmqd4
         tVIU5M7FxeCaStknyEFsLjXvVQda+5BRvvV7R6SRFphytPZ95+imvEWo4e8dkPLeWFC4
         3O/TH78310uEnTGhy9iixbyRHCpSDzW01spOxG7zFyZj9c3qrv1UGpM1wubZqDt61QgF
         dh8Q==
X-Gm-Message-State: AOJu0Yz058JpBvavQlOTU1Ml6xoFtV+5QnDvEC1dppTgwAnoY7i8GQrW
	z5923wlWXj+19XgTdkEW/+4ctiGvSysZsjB58DL/uqE8Y6wAf9fBPxpj
X-Gm-Gg: AR+sD12/aiBtHPKH8rwyMQ/gVN9Ae6cI9hJduhCr7TpRqbeV15lkZr8F7+c5he+Hk++
	WnFG2phnmz0z5jbNc/xsFfkWHstq9vi5rFUawBt87pSiHM9vxlaMF8uGegZVg3eMQVoV7jBQ4O8
	ntyPEBXtgXi+r1DW6Oc361x+86BVJFv/K4UGI9p4/owTXdjYOkdDlbHOIhrQqNUrn4bNrLFT0yU
	70G8dZpnzm01lZxseUiTZX2dX2O8tJ+T+WwNei2mMIuzGZlsFyZ1t4OYXPa5nLHzIS/ni+4x9CL
	xp5rvfyt9WL02APtQ42q6F4r4PeaRl+EW/56RhYkQf73sxHyD1yzUt6jWTEJDdj69xR0tiF6HhH
	Tsp+sWEBd4F+FbubMshc8cUAJbbm4MjxBkptM36kHS/jJzYaa2pcFYuab2f5kPhIT7hIrLHbiYD
	04v9IKUGZBmGo4NQPBvtnBrloHdOhyRsFE7ryvm6bBpouQ/2mc0+W1C/Xei8TKLQ7gK/5K2Hiwn
	xEw+n0BlA==
X-Received: by 2002:a05:6830:6809:b0:7e7:5e4:ee11 with SMTP id 46e09a7af769-7f3de809148mr27312808a34.16.1786989404542;
        Mon, 17 Aug 2026 10:56:44 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0b935bsm2004457a34.14.2026.08.17.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:56:43 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:56:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected
 sockets
Message-ID: <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
References: <20260813121236.2328599-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813121236.2328599-1-4ncienth@gmail.com>

On Thu, Aug 13, 2026 at 09:12:36PM +0900, Daehyeon Ko wrote:
> virtio_transport_recv_pkt() first looks up a socket using the full source
> and destination tuple.  If that misses, it falls back to a bound-socket
> lookup using only the destination address.  The fallback is needed for
> listening and connecting sockets, but it can also select an established
> socket that remains in the bound table.
> 
> As a result, a packet from an unrelated source can be dispatched to a
> non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
> selected socket established while retaining its original remote address.
> Subsequent RW packets can likewise be delivered through the
> destination-only fallback.
> 
> This was reproduced with two capless processes under different UIDs.  The
> attacker discovered the victim tuple through unprivileged AF_VSOCK
> sock_diag and injected a chosen 16-byte payload into the victim established
> loopback socket.  The legitimate peer received none of those bytes.
> 
> After taking the socket lock, verify that packets for non-listening sockets
> come from the peer stored in remote_addr.  Listening sockets continue to
> accept packets from any source.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8becad812..f73e0406a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check if sk has been closed, assigned to another transport, or if the
> +	 * packet is from a different peer than the one connected to sk.  These
> +	 * properties could have changed before lock_sock.  Listener sockets are
> +	 * not assigned to any transport and accept packets from any peer.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> +	    (sk->sk_state != TCP_LISTEN &&
> +	     (vsk->transport != &t->transport ||
> +	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {

Does this equality work for loopback, when the CID may be
VMADDR_CID_LOCAL and/or VMADDR_CID_HOST on host or the guest CID in
guest?

Best,
Bobby

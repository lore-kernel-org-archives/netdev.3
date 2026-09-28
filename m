Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD284E36DC
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607628; cv=none; b=TmIUi+FiUui9Lt0zMVlsCHsuytaMVeqi4cxcO1l8utryP4YaJuOTP9+BMlTIOGFNoPuUr9Y8H7UNT7uExeY+IMF/BPMEqB/zt/JvXPKgjy9Zb6PiuIAYKGFPTRhfCvXFEgm1xb9GnxfB+2Fk86REoxLyEMtwMGgGGArgnnC28LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607628; c=relaxed/simple;
	bh=FarrX1AXajp0rcAMMevqe1ADxQNLZJK0VOe0E5fUEKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZByuBU5k02StFLYt24Ey8FPvfYjARmRFH/k/tUK5R5gqxRXQj2vIZa29/wXc5tjK7zC/8xAHNxULdR3mJPyy6jt9vMkYEwDW6Du/SK3Z6SoLisP70uznoFs2wm8wPEvthoHgsY9e0vqA/Eqz64AwWZ0rEYr4XHzo4/vkoEwsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQEXO095; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kVUhd8t6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQEXO095";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kVUhd8t6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790607624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eLs8yZfJYGp54djsbn71UyAfwiNLWW6mOvXDf6yGk6E=;
	b=KQEXO095cr7w/2y/QKSIbVo3b3+XPYsgB+4hJwNH/Js/WDxs8RK09aHO0OYs2J9NS3BAMP
	t+iS3dR0skWgZo6Cs+Of0HTpM5kbhYSAUADRZL4HUNCUhhiGy8ccqzHeJdfCs4COvjLDw1
	mWsmkwS8ekVdS6/7wJEkpssAzEvdBRs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-sBPcBHVaNna93DfVK-wp0w-1; Mon, 28 Sep 2026 11:00:22 -0400
X-MC-Unique: sBPcBHVaNna93DfVK-wp0w-1
X-Mimecast-MFC-AGG-ID: sBPcBHVaNna93DfVK-wp0w_1790607621
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48589603501so2123858f8f.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790607621; x=1791212421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eLs8yZfJYGp54djsbn71UyAfwiNLWW6mOvXDf6yGk6E=;
        b=kVUhd8t63D+j3O51VASIOK0p2f7DLjaWKg1FZ/wrkFTfosbtaAz9e3KZrWFAdVnpnk
         fdsEl8YlwVYUHNmLal+tuOzBsMV5JPIFPXRIvunCbhIFsE+ZTqJdbyNhRIbzvx83amZb
         3yMzFjV/TyZZXOBJokYzd6F7wAky/tQQW9NXcWnIfLukZtX6u0d7MpXHOJo60qOw4zUh
         O425Mw0y8qV3OoLE5485BVMrjtNdU/YYXavj5UjK0dkKo+xhaGPYpF+wdi+XsNhMpkLI
         aeJSg9TzT0SZTI/b/iW3tGFjtjSuN3+M6FX3dZrPHuDKgnPc7eFRwvYWjyjTBq6z+Gyb
         oWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607621; x=1791212421;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLs8yZfJYGp54djsbn71UyAfwiNLWW6mOvXDf6yGk6E=;
        b=tyQ8IqqSJzHbrv1RPhkC+3P7M9hPXZtG95hpBukE2bzkw/XoktB1GqO6q6SAgGZLUv
         Wl0y1FyMXjtxfArABFrqQC+BBq5K64dugZaBn51ManKjqi8S1N55n1R8BpPIDBcyXQte
         58tr6om3SaxN8980VpVrbw5bQNPEv1ol/P8iGQXnHd9vDb8fC+UXaH41LHMAI9BLQogT
         eFZuVDAOOAg1ezYm3J4F9tLO4mdyOVGIyQbSfO2g+xiKMNkE40jLwB/IMeIDglM1leNm
         XhWiY1DD+OPKC/TylXfILt+dbV4e5W6plTH2gGZVGELaDUfcWxtu9s5Pt/ZkLjCt5LMi
         +3zA==
X-Gm-Message-State: AFq9FYKv9+sAfnG+UNsSDBSMKC92k/s+wCU34/z1megA/VaOdCwz0ZnU
	qrhVPgvwwGKFL6MWHdcpUhMLH+JjBgmwU6XbJfvbJ3pf6i3iTFJxl2r4mJhilaI66opRf3jhIjs
	B8MBjc0gT+O/JcEU8PUkZ20TcpbzdVTFL6XYPmWNZXqyVeeaSAc5zRFBEXA==
X-Gm-Gg: AYBFou37XWijgMwt8MZMMAE7R0pV4O/GSAIe4couqpDfG3inZjzwk0E32YYIkYsI/EF
	7DXsR1EqiLUD/fgc1J3HVSKplxvIdeB7vdsgkvD3ZiOFY3jFy/7O/tXsIoY51MYT0tXj5TjWD2c
	F+ZoMtDzJpR/z1Vol2axIGRRMHdQzpc9Wzuh9Az7qq6VaDXHiy12E6/TLWKjvrApdk5bqQFWbFA
	YD8asjei4GCoL1L5pu8NVTMhqdrZ6GEuKm5DV/wV7ByN5c+2H9qmwYrwGaJXzUk/TvC6JerAzoy
	hgInOa+4WyJpGiAaJGweDdToNMA21OX0yLmZ+k+/lrgYOlMzBDJb0pQZ23b11ZlsIp8T39kCiTJ
	hK6w=
X-Received: by 2002:a05:6000:4b0a:b0:488:823d:507b with SMTP id ffacd0b85a97d-488823d5296mr15209805f8f.52.1790607621387;
        Mon, 28 Sep 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0a:b0:488:823d:507b with SMTP id ffacd0b85a97d-488823d5296mr15209714f8f.52.1790607620571;
        Mon, 28 Sep 2026 08:00:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.146.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28558683f8f.12.2026.09.28.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:00:19 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:00:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: report pending receive data to
 io_uring
Message-ID: <arqAF53k2arP4enr@sgarzare-redhat>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923184008.153541-2-devnexen@gmail.com>

On Wed, Sep 23, 2026 at 07:40:07PM +0100, David Carlier wrote:
> AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
> IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
> queue has been drained.
> 
> Fill the hint at the common receive exit using the transport callback that
> SIOCINQ already uses, and report 1 once the connection is finished so the
> caller performs the receive which observes EOF, as TCP does after a FIN.
> 
> A vsock loopback ping-pong with io_uring multishot receive drops entries
> into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
> and receiver CPU time by about 3% (25 runs of 50000 messages, p=0.006).
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58af..20d6f9ca6a96 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2543,6 +2543,35 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>  	return err;
>  }
>  
> +/* Bytes a following receive can consume, 1 if it would only see EOF, or -1
> + * if the transport cannot tell.
> + *
> + * Called under the socket lock after a nonnegative stream receive, so a NULL
> + * transport implies SOCK_DONE.
> + */
> +static int vsock_stream_inq_hint(struct sock *sk)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	s64 data;
> +
> +	if ((sk->sk_shutdown & RCV_SHUTDOWN) || !vsk->transport ||
> +	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
> +		return 1;
> +
> +	data = vsock_stream_has_data(vsk);
> +	if (data < 0)
> +		return -1;
> +	if (data > 0)
> +		return min_t(s64, data, INT_MAX);
> +
> +	/* Empty but finished: keep the caller reading so it sees EOF. */
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  int
>  __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			    int flags)
> @@ -2606,6 +2635,12 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>  
>  out:
> +	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as

Do you mean vsock_stream_has_data() on SOCK_SEQPACKET doesn't return 
bytes?

IMO names are confusing, but it should return number of bytes, we should 
fix it, but of course not in this patch.

LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> +	 * a byte length when sizing retries, so only streams report a hint.
> +	 */
> +	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
> +		msg->msg_inq = vsock_stream_inq_hint(sk);
> +
>  	release_sock(sk);
>  	return err;
>  }
> -- 
> 2.55.0
> 


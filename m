Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E863E0220
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084074; cv=none; b=bouQji5HfNfTlOzh5ps1JX5LaYEEKOWTie2q17KqdWpDkCv/9Jm646W7f+NK0utf95polwoI/Ig7EgP/izNXNDR2Z4v2RSdxCab5gz6jxDARkrs+dbV4LruCR2TPHBOSouimGdIHzpPrJJZieDUlIN231X8H8A1WRflYyuW686o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084074; c=relaxed/simple;
	bh=PSVBHJzDjf+cebHOc9eSx8giEVaXgMK5QQ9c35c1xLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzLm+re367Tc5+JTBZETlgc1H6MoUD8BBd3+dp6JSqXvBJm/xbc116z4gGEWgSLDp3i3Sdvr+fZ0sEmc3BKqwRPiEPK4s09ub4vdUQCo0gnhHDamcjdC2hxjAJaCt1MJBnVxkliGxDlAXZ51BXZX2sRUfvj/JLik7FxurUHI8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKvQfHPv; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKvQfHPv"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so3504606b6e.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084057; x=1792688857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RGKsANacdZMd9ipQ62NebQime+gEaLlPbg00vy9J+5I=;
        b=RKvQfHPvNsn4brKHCdx1edPxiMGZY7ioHqz0O1ePeSYtAHzzu0GaUAMCIOLMRR2DFv
         RvJphd7lFk8zIMOe1Dp8sCMVQ0dv1CFv2l7MEHQFyg8ChLzST+1r1BHufdoljoWBmdjg
         L50usyOidBzn5NKI/AfqaMIXZk0sQLzTkvT2DbaxS5XNw8IgEWRIDR5q7fbw/LbhckmE
         bL8H7noBayaX6PVS7qxNZS8QzKIOENnd923QMvp6ariY3MNqiH1Runw6+SJoV0E+5v8j
         rjMi49FYO4Qn+7yN1Izq3wBiHI7GRqGvrvBaFl25LqMPNjq+0Zlv5fDkQPRqu0JTLRHn
         bFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084057; x=1792688857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGKsANacdZMd9ipQ62NebQime+gEaLlPbg00vy9J+5I=;
        b=AN/Md2igqKfj/wPNaVE9uR7igEqRzcQmV7PDe9JVS7Y+2p4mEabojSrP7uJiQOSe1h
         AC4ZxYG44CHR67VSarsX0qcX55jZwmtoEveSQ1kqLqPLewKlsrgAsVSHpvg52bl7DpZb
         ER6Xgv1hz4ZeJhrq+jPhm8lovIT+9C7KS6fG0etvL90pRnnKILUqz9alUTN7CIc3kiP5
         +JUKVBuF/+OCoMJdT/v3EoHLgAq0re79riBZYcJ4gOWNJcxvmTLBobRQ6F+ddoxZ2DuK
         l/c4THuksdMUyHkhl+hLcbtLUFGFrguaPTeCYCXviOt+07Vw7jzygAqE5deeFk0enksQ
         V1uw==
X-Gm-Message-State: AFq9FYLRmFH1bMaJCBs0/LbFbnUK/Ctk+pY3ZWUzpMVNXJO88lfw5GS2
	fM12O49mAYfx+qGBPguJ9lE8UVIA9dgw6i0l+i6yc5XvNITBs7OB9YXy28nRXA==
X-Gm-Gg: AYBFou0/tzP03GLAscx60SNqK4ePSQo2QhGpU5bCJOSAq/I7VZm7JHm+Gks33oocNyd
	ljnnDeJ7oWRhIaSN1KW12ca3OSriUfFUCsnNzy7XGw7fHPwCrLZKDf9hdpW8pLgb2CkMnMgHk/5
	6U9Lv3sbBwicbD0MT13m94Eaydx6eAWB7IEBNdx2IZd5ce2zFofO/LU85O0k01WGV0LPeTgFm4z
	PE+f+bxZeNwkhBeYYZAruakbLcJ1DSvJgIldvXz3g9Dv+qT3M3MSEdmrvH/j3vMpJATsLDrShYr
	jm+/bRuQJQWWkew5UFrKUT6GIO3feHwx/7Zy5q01SomDOsvtMuHZJm3UL1Qeppt/B21pnaKco9x
	rKRIO1Qd+vyd32O+9+l8EZzC/IjTIjTvbz4Ln9HPXSWxjZyHeNUQL9Z57bwPnVXi1qsyr1GsTGv
	ejZDiWfdugmaMNFOIis1L0amlw/T4WOdDbqkdcsoFizb2A08CBDD/QKyNsRTcbIcCY6g==
X-Received: by 2002:a05:6808:4fde:b0:4f3:e98f:fa26 with SMTP id 5614622812f47-50c56deebe6mr17460836b6e.58.1792084056686;
        Thu, 15 Oct 2026 10:07:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-537b247b531sm39258b6e.5.2026.10.15.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:07:36 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:07:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: support SO_INQ on stream sockets
Message-ID: <atEIVxvrCELGtdmM@devvm29614.prn0.facebook.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015154334.3217358-2-devnexen@gmail.com>

On Thu, Oct 15, 2026 at 04:43:33PM +0100, David Carlier wrote:
> SO_INQ makes recvmsg() return the bytes left in the receive queue in an
> SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
> support it, AF_VSOCK fails with ENOPROTOOPT.
> 
> Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
> As with TCP_INQ, 1 is reported once the stream is finished so the caller
> reads again and sees EOF, and accepted sockets inherit the setting from
> the listener. No cmsg is sent when the transport cannot report the queue
> length.
> 
> SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
> messages, not bytes.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/net/af_vsock.h   |   1 +
>  net/vmw_vsock/af_vsock.c | 111 +++++++++++++++++++++++++++++----------
>  2 files changed, 84 insertions(+), 28 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6..e8481f12312e 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -68,6 +68,7 @@ struct vsock_sock {
>  	u64 buffer_size;
>  	u64 buffer_min_size;
>  	u64 buffer_max_size;
> +	bool recvmsg_inq;
>  
>  	/* Private to transport. */
>  	void *trans;
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1c2d1cea67f4..186ed57fd797 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -984,6 +984,7 @@ static struct sock *__vsock_create(struct net *net,
>  		vsk->buffer_size = psk->buffer_size;
>  		vsk->buffer_min_size = psk->buffer_min_size;
>  		vsk->buffer_max_size = psk->buffer_max_size;
> +		vsk->recvmsg_inq = psk->recvmsg_inq;
>  		security_sk_clone(parent, sk);
>  	} else {
>  		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
> @@ -2014,6 +2015,66 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
>  	vsk->buffer_size = val;
>  }
>  
> +static bool vsock_custom_sockopt(int optname)
> +{
> +	switch (optname) {
> +	case SO_ZEROCOPY:
> +	case SO_INQ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	int err = 0;
> +	int val;
> +
> +	/* Use 'int' type here, because variable to
> +	 * set these options usually has this type.
> +	 */
> +	if (optlen < sizeof(val))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	if (val < 0 || val > 1)
> +		return -EINVAL;
> +
> +	lock_sock(sk);
> +
> +	switch (optname) {
> +	case SO_ZEROCOPY:
> +		if (vsk->transport && !vsock_msgzerocopy_allow(vsk->transport)) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +
> +		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
> +		break;
> +
> +	case SO_INQ:
> +		if (sk->sk_type != SOCK_STREAM) {
> +			err = -ENOPROTOOPT;
> +			break;
> +		}
> +
> +		vsk->recvmsg_inq = val;
> +		break;
> +
> +	default:
> +		err = -ENOPROTOOPT;
> +		break;
> +	}
> +
> +	release_sock(sk);
> +	return err;
> +}
> +
>  static int vsock_connectible_setsockopt(struct socket *sock,
>  					int level,
>  					int optname,
> @@ -2045,36 +2106,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  	sk = sock->sk;
>  	vsk = vsock_sk(sk);
>  
> -	lock_sock(sk);
> -
> -	transport = vsk->transport;
> -
>  	if (level == SOL_SOCKET) {
> -		int zerocopy;
> -
> -		if (optname != SO_ZEROCOPY) {
> -			release_sock(sk);
> +		if (!vsock_custom_sockopt(optname))
>  			return sock_setsockopt(sock, level, optname, optval, optlen);
> -		}
> -
> -		/* Use 'int' type here, because variable to
> -		 * set this option usually has this type.
> -		 */
> -		COPY_IN(zerocopy);
>  
> -		if (zerocopy < 0 || zerocopy > 1) {
> -			err = -EINVAL;
> -			goto exit;
> -		}
> +		return vsock_sol_socket_setsockopt(sk, optname, optval, optlen);
> +	}
>  
> -		if (transport && !vsock_msgzerocopy_allow(transport)) {
> -			err = -EOPNOTSUPP;
> -			goto exit;
> -		}
> +	lock_sock(sk);
>  
> -		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
> -		goto exit;
> -	}
> +	transport = vsk->transport;
>  
>  	switch (optname) {
>  	case SO_VM_SOCKETS_BUFFER_SIZE:
> @@ -2581,6 +2622,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	struct sock *sk;
>  	struct vsock_sock *vsk;
>  	const struct vsock_transport *transport;
> +	bool do_cmsg = false;
>  	int err;
>  
>  	sk = sock->sk;
> @@ -2637,13 +2679,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>  
>  out:
> -	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
> -	 * a byte length when sizing retries, so only streams report a hint.
> +	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
> +	 * io_uring treats msg_inq as a byte length when sizing retries, so
> +	 * only streams report it.
>  	 */
> -	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
> +	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
> +	    sk->sk_type == SOCK_STREAM) {
>  		msg->msg_inq = vsock_stream_inq_hint(sk);
>  
> +		/* A negative hint means the transport could not tell. SCM_INQ
> +		 * has no encoding for that, so report nothing.
> +		 */
> +		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
> +	}
> +
>  	release_sock(sk);
> +
> +	if (do_cmsg)
> +		put_cmsg(msg, SOL_SOCKET, SCM_INQ, sizeof(msg->msg_inq),
> +			 &msg->msg_inq);
> +
>  	return err;
>  }
>  
> -- 
> 2.55.0
> 

All LGTM.

Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>

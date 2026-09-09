Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A948F02C
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993888; cv=none; b=sYdq9d99jnMt4Vn+/WSAR0XN6HAlSVxWPXWgDiVLPUnPgXVtu/tPFzph+TJEi2hya6rHzksUk5jbL6ZFYAQiBr/tvcwsLkA4v08867l5t8+UKym5CDkgkbznkVl0ZiPCvUCMw6js2VbvgpXtyNx0n7pXdp5v6MPMid4waBnUCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993888; c=relaxed/simple;
	bh=T05NvHvBe6jr/5zMRdBfL+ppGgLwUsijA+cXkh/ecoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMJdpT4uYyBYlT+dIevv3qK6XoqtOP43amzw/tnCU4YumYr85a6Vl+DXGVFjc2qS3skM+pHTkapSRDcEj5GxjE4VPgJdLe0XvaE8jn58cD2inncIPfxdi83uYt25Q4ZggaaH7/pKpc6ElxDJ/94x7sr+1fxlw7U3RkpcBhC1KaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKNiUhgp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKNiUhgp"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4c18e5e9745so443966b6e.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788993878; x=1789598678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9BgiwK82Q/ir0W+AfKhqhG0iwn5MN55494Vi6I3LH0=;
        b=gKNiUhgpG1qL5ZzBRD8krH6Qqp+ypEh8XaB2rnRO5ve1GzJLGgkdeU5ZsD/S3pOASe
         +9XBsy5sxi0eqbU1T2v1WrhZvbCeU6vRqqTeRkTMBgsyWLnf8uDCovf18Sp2eiNBes3b
         rdAIaWVvDa1aNujhmpGxoSGL0ICxE5MAmxUiWP3QKKVBdrGIkxk7MeXOnh+PiZIUkMvm
         wEUp3dEg/34dkF0JoomvZ8fzVnnl54joH9orNIsoHIUmFxytJhJzbayVbKIvKKBQIBkR
         BwOu6a6rSqhzaV3+22hR9o/zeOnLgEtYE5m8a+G6DDoj8gU5wLnp+lASsZJjUMjtlCu1
         8zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788993878; x=1789598678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9BgiwK82Q/ir0W+AfKhqhG0iwn5MN55494Vi6I3LH0=;
        b=gddpLY+g6OZt1DoteQagdx5Q7yw40a58SsKEJMlbGMByZix1ve5M6giR73Nz13ulJN
         yPZY8pkNYaq9Yx4KwsaR4o7pAPvLC3wza8fYSr0P3/p5TuOevgXo5czv1nR1zbqY6qs3
         TN6Spc0d1k+bXzgjuaysyng0uKlNRVftzSYg2VRkGpMHNUTdqigc+YJOd55LpDLnju1M
         sG3wW/GElgzyVbGPSwSTvrsIENpmeQFBk0bEZIljuoXls/WoTjT5il/MnGFHwsk56JQ3
         W/qPIeyZLwJ/OYEFp57xQalW8eP/LFb4NYOXSOaWN5/Uix0/Zbn/cYOB5LKmO/gMkRTT
         KM/A==
X-Forwarded-Encrypted: i=1; AKwUvBwAMZhU1qbQpbWazlX9sGDrFPkqbsqY72nRlPmW7H4GAGSq03wGPegHzK1qxUyw3dZ7FCzhfXI=@vger.kernel.org
X-Gm-Message-State: AFuF++lWwTZAj+Y2CZEc3QuVVsmr2f0SAv8ygRSCFw24oHei/W9/aqtK
	CKpCGCMrMctytR9qwPiwp6o0OSdetw+qaPddm79LvRMK7jJ5A8zk6UZv
X-Gm-Gg: AYBFou0V8/MqrTyGWoa8V8ju/lJ4hP3UnvfTospAM0/rxC4bTFNo/ERIZC7J+2sS8lZ
	roYVGSV+sL9eywTfzt5ixumar2ZW4rnkqeGOosJq5s+0UXqNriUzpArcsiH2Vz5YBZsN+NIzmSq
	vBKvcyXuJWVuEGB6OogUreaHm9beLQ4j7dEE2e32lckwFf7uQb3p439oNr+54oZ4D+rfR4YvPGg
	qyJc2uOtH27iinp+tVjEwAB+evh+AGQhD4N4FcvikwfVZgQbJq/7zy1eFd2EqKaJRapAm/e7Cvw
	MNPzNFAfvGyCu2+ayyL43pUx5TxEtvqX8k+8DsOn24cO6sDoKrlX3EFIxb+RDZeldXWv4rJetLl
	WH8LbpkGADAtCXAYo4AcufbVbY2V176AI2G1A7flD3KoK8UaOIMkJsqUNeBfGg0WAuPp/z7ihKq
	Mn1vl9+630hSSAFCMx6EDWsiaBvktY8c1oQLRlN0eKFUFrga1y/V0ceQb3daRfjuyoWCplH5f07
	QP5yi7XetyYL+34P3H6
X-Received: by 2002:a05:6820:80f:b0:6b1:4250:6a43 with SMTP id 006d021491bc7-6b6fd2ce67fmr21915798eaf.17.1788993877718;
        Wed, 09 Sep 2026 15:44:37 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bebe8d3f3fsm1833474eaf.10.2026.09.09.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:44:37 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:44:33 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net] vsock: Do not reset a TCP_CLOSING socket
Message-ID: <aqHhUROhqyNhPJDr@devvm29614.prn0.facebook.com>
References: <20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co>

On Wed, Sep 09, 2026 at 11:58:26PM +0200, Michal Luczaj wrote:
> Ensure connect() resets the socket only if it has never been established.
> Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
> transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
> loop.
> 
> Resetting a socket that is still present in connected_table can lead to
> memory corruption. The reporter noted lost transports for in-flight skbs,
> and I have reproduced crashes caused by re-insertion into connected_table.
> 
>   list_add double add: new=, prev=, next=.
>   kernel BUG at lib/list_debug.c:35!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   Workqueue: vsock-loopback vsock_loopback_work
>   RIP: 0010:__list_add_valid_or_report+0x11f/0x130
>   Call Trace:
>    vsock_insert_connected.cold+0xe/0x13
>    virtio_transport_recv_pkt+0x10e9/0x1460
>    vsock_loopback_work+0x305/0x480
>    process_one_work+0xe4c/0x1560
>    worker_thread+0x4f1/0xd60
>    kthread+0x36e/0x470
>    ret_from_fork+0x47b/0x6b0
>    ret_from_fork_asm+0x1a/0x30
> 
> Drop the inaccurate comment above signal_pending(). This fix is
> supplementary to commit 002541ef650b ("vsock: Ignore signal/timeout on
> connect() if already established"). Details at Link.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Note that this is not a complete fix. connect()'s schedule_timeout() can
> still race with two other functions that set sk_state = TCP_CLOSE while
> keeping the socket in connected_table:
> 1. vmci_transport_handle_detach(): no way for me to test,
> 2. virtio_vsock_reset_sock(): tested by unbinding the driver
>    (/sys/bus/virtio/drivers/virtio_transport/unbind).
> The latter appears easy to fix by adding __vsock_remove_connected() and
> switching to a _safe iterator in vsock_for_each_connected_socket().
> ---
>  net/vmw_vsock/af_vsock.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58af..eec5dd6daebb 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1834,23 +1834,20 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		timeout = schedule_timeout(timeout);
>  		lock_sock(sk);
>  
> -		/* Connection established. Whatever happens to socket once we
> -		 * release it, that's not connect()'s concern. No need to go
> +		/* Connection was established. Whatever happens to socket once
> +		 * we release it, that's not connect()'s concern. No need to go
>  		 * into signal and timeout handling. Call it a day.
>  		 *
>  		 * Note that allowing to "reset" an already established socket
>  		 * here is racy and insecure.
>  		 */
> -		if (sk->sk_state == TCP_ESTABLISHED)
> +		if (sk->sk_state == TCP_ESTABLISHED ||
> +		    sk->sk_state == TCP_CLOSING)
>  			break;
>  
>  		/* If connection was _not_ established and a signal/timeout came
>  		 * to be, we want the socket's state reset. User space may want
>  		 * to retry.
> -		 *
> -		 * sk_state != TCP_ESTABLISHED implies that socket is not on
> -		 * vsock_connected_table. We keep the binding and the transport
> -		 * assigned.
>  		 */
>  		if (signal_pending(current) || timeout == 0) {
>  			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
> @@ -1875,7 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  	}
>  
>  	err = sock_error(sk);
> -	if (err) {
> +	if (err &&
> +	    sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {

If the OP_RESPONSE + a blast of OP_RW that pushes past the buffer limit
arrives while we were scheduled out, we end up with sk_err = ENOBUFS
here. Then I guess connect() returns an error, but sk_state/sock->state
is still TCP_ESTABLISHED and SS_CONNECTED. If the user sees the error
and tries connect() again, they just get -EISCONN back. Maybe the
sock_error() needs to be moved within the conditional here, and then let
subsequent calls return the error to the user (it looks sendmsg() at
least will report it faithfully, but not sure about recvmsg() or the
others).

Best,
Bobby

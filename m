Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70E51D52E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806158; cv=none; b=BX+izuxvo4x4xQ43UeGFVX5Pt0nNwFCgjLaPqXaHWveIGsbsLCLz7PJ2IxtuA7Mi570LjdZeNOH6Krfrhf+vWG7MHcjlmahoIMSgx3tq+jT29EdCZdyO/njHuUfZOB77GtzPWBNVpfCF4CqO2H2cpfTgnxQnuZbeFjMU7zen1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806158; c=relaxed/simple;
	bh=cv04HKy4otmKMhqnEPI0LZjhku21UWf61AeAHYiBERc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsby7RqzQyCWAde0UraIgAma+EodvTL/5sDQPRd5S6xHfkKrEcTJTpfZKZQQVUTVRiURaE0Z9z3ByQVK4cqDYLq2x1i55Z3SaV3k+XDM5FS9yxrvXWkcGkAmYLyD3x4uDn2Ee/YqOJPY+/UliqHDH4qb9PsvbWDuor6b48d4mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGqcIyYh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGqcIyYh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so39592455ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788806156; x=1789410956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/QhyKnaiEuCX/YyxX6dbFuiwyxx+yL27o8G1/oLGwk=;
        b=EGqcIyYh/BHPAWZUcSuC/5axcZEipKmgNqUa54xcT5rkO/UrURezwCeFR5LUx2Ibe2
         5MOSBNhsdxGXdTpu66eJh0QMxhTeOCwc0I0qM6wnXIh7dWwj8QFf8mlMvcFiz0VpZa2j
         C2P5kw5UEu9dmIMC05SMc/76aRQbxZaOj7288ZJRYgepdUJSVTtDJGE08FIp864ofVd1
         iMijz9ZKAY4t+BMhOBb4ss4PvBKg5Hy5955APsu+DIWai2DsSgJ8saZKs6tGMloB1Wfz
         9p/Nt/tLGeaNLjg7cvbi6wpzvjZ6mzYOt16wxcwvcQ4CV6SJRujH0BIz8L2eZ6+Zt1HP
         jYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788806156; x=1789410956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/QhyKnaiEuCX/YyxX6dbFuiwyxx+yL27o8G1/oLGwk=;
        b=MYixz9Pqizkic/eDFZLsMN1hIDvuY2TkmOJCFzgWaotKvvKFO8xoPfkOk9+H+a9f4m
         TnKbSkxMmbTc4sdy5rii4nqz4JkGTVJGtHu4UpKGdePO/SOfzfijstE7MGBjQfwPhemB
         +F2kd3isipWW2fcPe9Jshwu8QrD6gzROoxiCQ2ChjtTCyelfIdNNLpKJi/6MXC8/wfnI
         +kIU5E9lP4hsywC7cykjZbTBhxG+kS8YcTP/Y2T4kX8Wt6h+aB8XT3icMKNduvX80H6v
         RKYlWs8g8Xs4VvZz7pfiMeeNaKtK+lzZMWQpCNvZJsgNxHISWKT4N6yifWoaR1wZehF/
         VzRA==
X-Forwarded-Encrypted: i=1; AKwUvBzxwVw4mLltyiZ3RHuEPMgJrl6GI7J5diTqSccO0pumFjCnWLnpzCRm68tuiX3p6QSmYi6Quz4=@vger.kernel.org
X-Gm-Message-State: AFuF++lemRkTNNbY5ZyoO7ovHmBb09tyqbd5YwBzGvvDAwVA5NehAy8k
	HlT8XDuLTp/4+5R2oS9nY1wWb64GrjrgsMx7DC1cJ6j4zmQ0433bozH0H5qZPw==
X-Gm-Gg: AYBFou0cIU+0yQ+1A2pjHoVjueNf4Bf6gu+Y1kSXuPFSCdzY/J7LnWjtbmdLOcHEjOw
	PIdW2XYToep50Lzub/DKdpWHZx6EP9PV25WgXLc7skAiWchzuJ/jihRSBkf4/vhWA0MM9Gc3ng5
	IZK4h8OUfq9bssUJYQrPTFBIvqvEzO7LZkSUFvLhX8XwlSukzlXk0w7v9HA7KXES/OVYXfny3VH
	72bayTzeH01HCn6h8yGEG0dFtiaYhn6DScoxIUFXNIaWpIvGYeO7KqzF8WqK1l1fUus+i2rXn5i
	CzIwP4lNW9OA7kRAyrMYdLoCxFF7aRYx51Q1CLzAdtDlXFRg9fhdEtyAqY+eLUSjGs0Ih6S6fkw
	+QZCFml2VpQjApS1Yyj2V7O/P8UaZvS0P2E+b2rCHZuPG65hCfbYlacecVu63uULPObF3XeToHH
	M4/7YCVWKxMS7UKL/800aLEeeOjqFzV5+0Foz+5lBSLyxjQrhBgVdtQafbpwf22oGkNtECXZXf0
	ec2j4J4
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr39934040a91.16.1788806155950;
        Mon, 07 Sep 2026 11:35:55 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b51eb40e6sm12393181a91.16.2026.09.07.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:35:55 -0700 (PDT)
Date: Tue, 8 Sep 2026 03:35:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, leonardi@redhat.com,
	bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it
 has connected
Message-ID: <ap8EBx3pkSr5Csy1@v4bel>
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
 <an5zJ9Uf94_L9TyB@v4bel>
 <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
 <aoVnp0w9jlyFDPj7@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoVnp0w9jlyFDPj7@sgarzare-redhat>

On Wed, Aug 19, 2026 at 10:54:38AM +0200, Stefano Garzarella wrote:
> On Mon, Aug 17, 2026 at 12:29:11AM +0200, Michal Luczaj wrote:
> > On 8/14/26 03:45, Hyunwoo Kim wrote:
> > > On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
> > > > On 8/12/26 22:13, Hyunwoo Kim wrote:
> > > > > commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
> > > > > already established") stopped connect() from resetting an established
> > > > > socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
> > > > > that moment, and the state can change while connect() sleeps.
> > > > 
> > > > I guess this makes my fix incomplete. "Fixes: 002541ef650b"?
> > > 
> > > It is incomplete, yes. But this has been triggerable since d021c344051a, so
> > > I'd keep Fixes: d021c344051a.
> > 
> > OK, I get it.
> > 
> > > > > A peer RST moves the socket to TCP_CLOSING, and it is not removed from
> > > > > vsock_connected_table on that path. connect() then wakes up, fails the
> > > > > check, and resets a socket that had actually connected to TCP_CLOSE and
> > > > > SS_UNCONNECTED.
> > > > 
> > > > Thanks for the details. Do I get it right: connect() misses the fact that
> > > > socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
> > > > during schedule_timeout()?
> > > 
> > > Yes, that's it.
> > > 
> > > > 
> > > > How about:
> > > > 
> > > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > > index 622dbd046799..39c42ef016c3 100644
> > > > --- a/net/vmw_vsock/af_vsock.c
> > > > +++ b/net/vmw_vsock/af_vsock.c
> > > > @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> > > >  		timeout = schedule_timeout(timeout);
> > > >  		lock_sock(sk);
> > > > 
> > > > -		/* Connection established. Whatever happens to socket once we
> > > > +		/* Connection (has been) established. Whatever happens to socket once we
> > > >  		 * release it, that's not connect()'s concern. No need to go
> > > >  		 * into signal and timeout handling. Call it a day.
> > > >  		 *
> > > >  		 * Note that allowing to "reset" an already established socket
> > > >  		 * here is racy and insecure.
> > > >  		 */
> > > > -		if (sk->sk_state == TCP_ESTABLISHED)
> > > > -			break;
> > > > +		if (sk->sk_state == TCP_ESTABLISHED ||
> > > > +		    sk->sk_state == TCP_CLOSING) {
> > > > +			err = -sk->sk_err;
> > > > +			goto out_wait;
> > > > +		}
> > > > 
> > > >  		/* If connection was _not_ established and a signal/timeout came
> > > >  		 * to be, we want the socket's state reset. User space may want
> > > > 
> > > > ?
> > > 
> > > Yes, I like it better than mine. I confirmed it fixes the issue.
> > 
> > Great, thanks.
> > 
> > > If you don't mind, would you take the patch from here?
> > 
> > Sure, no problem.
> > 
> > Stefano, does this look good to you?
> 
> Yep, thanks for helping here!
> 
> My only doubt is if it makes sense to leave the `break` there, and add a
> similar check before resetting the socket, I mean something like this:
> 
> 	err = sock_error(sk);
> 	if (err && sk->sk_state != TCP_ESTABLISHED &&
> 		   sk->sk_state != TCP_CLOSING)) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> 
> Just to be a bit more defensive, but I don't have a strong opinion, your
> version is also fine.
> 
> > And should any sk_err be consumed
> > here, too? (`err = sock_error(sk)` instead of `err = -sk->sk_err`)
> 
> I'd stay with sock_error() to consume the error if it makes sense also for
> you.
> 
> Thanks,
> Stefano
> 

Gentle ping. I'd appreciate an update on where this stands.


Best regards,
Hyunwoo Kim

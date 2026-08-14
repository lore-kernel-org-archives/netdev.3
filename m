Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023F3D1AA4
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671920; cv=none; b=kRxSQX6y5H7tVrMtw27oiUlPwOfPO9WPgHIfLhPfeIU8WmtqHLIGFFGZdfA03kJeTeqQ4DKE85Wv6dArDCPf8zJ5YmbG39+Dj1ORmNpeQMDEPw2iCLdgsBLGh1UluCydFhHlNo/V85gT38ETSwt0nS2PAaRdCjc9XpUqyw3rKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671920; c=relaxed/simple;
	bh=heykRPKxHEV0qeGdFAlsBWMKyo8f6xdx4ceOTJOlyac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbS7UKt8HNFr1ajKQpYHALzEG+NkijTWwqHQV3oC2riVHtvwxqfvK/Y9fX3tauAub+dE+3EeJqaphPBpVrQidMnFOdsME0/Zz8lYCs+ZCTElUerP7E1wxaO7xQmlPcCMEoCcNIlOcwxnvX5akEWMIbt5D9MVYQMKl+L+/JpIpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwrDRU1y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwrDRU1y"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so355135b3a.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786671918; x=1787276718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mi5MeuhJzZM9OklNSe8gi6ctTiynO5KFec8hcGTI+Lc=;
        b=RwrDRU1y20OHPd0MAgJOgHx4jXC+LeBhkmidspCBGOviTsJLTxxH33AO0A07Xtt7Qv
         joUJIKsBXg4IE91YVL5WKkz83MA82DZ4g9keiqdC8IOqrEqd8zprbSl7zvX46LXK8tsA
         kMwDIbyFl/Ytv/kxa+eyG4rnAydww/vxF1ISTtVgaM1DQWsXv+5DZyjZMHa/ybOzFUoK
         0l1c1awCc0tFI4Ep5on5hIBz10luqoTTbR9wXZHapNi8EPygyWYyGfXl3JEfltuxwA8H
         0Wvu45DDr9eqJKbXKKw6scgnnc/mteGoNy6/cE5APn/OOrNQCeq1pBJFqEH8RaNecQKK
         d7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786671918; x=1787276718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mi5MeuhJzZM9OklNSe8gi6ctTiynO5KFec8hcGTI+Lc=;
        b=DECnPs8GxADeZpzvJnzYgkERtn5m4Y2qa1l6iXCreHt/5tnMO4D0ReeeE2gGnECZEP
         Bx/oLWqAhvOUze4Xeu6zZjB2p33bkl8Tjl4S8yq/amEqFUReEM6+F9vGRSaTdBEGkYXk
         +AHEGClpbfncCYaX361XsEon/lDImgIfv2X4nUEhAK7IMaZOKmzWByJGH2m5unungsM+
         oewLelmb/cc5Rbsexl7IdvdI56bEhV/Gf4Y1QchUkFHQ2PP6X0athCCrIrkTpeWalmWt
         44qsOVFDQQZ6k4LUfpZHry4TqAJMvtH+9+z6Iog5lndlH2ht/hNwFUb1gQwlZAmEU5Qh
         T9lw==
X-Forwarded-Encrypted: i=1; AHgh+RreaNJZxneyiH99dXr/vCUCTt7NZiH+E7aCmfs0qBpyt57kqgB+X9krbepkGYtxT0TVh9RR+RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0NbunwNYLfe1xzLQ517BgRm1Q4u2ajmQAwbfresj8TZw/3Q7
	HtTbtkxhPw0CWlcGnMyDoaZDCSc0kBV1evXFtkjTEqJZXDxdQhTApNkl
X-Gm-Gg: AR+sD10RmewnWtvBJusQexpqOGIEndiAZMLr5C2HcCxx+1wcU5BcXlfgOTVFwxdR2kz
	gWoUBTyEuO0kGuRLiLn6Xj0U+3F54AqwNKGhX9WgPEp0/AJF9ITIazruNzLyENA43sCdksdPpAR
	elEcCG+c6Sb4/2FBKI1Zw91LOw7O42e3ATK4Tw7RtXLUssBcxIf9q+Bnhi+B3mij9kD3vXmippB
	cNvrH70pYRnHW1zOuM4VvJ7wE3pCUDGlzxLCEvl32Tsa1ZVB6VKCr27fB5YAMb6WeDhiyB3iFFV
	IiUe1unBysTaq0WsFvXH0GnuB84aV/v4HEuhjXJv1z2e3UQCE2rMjFHV7mFiXR56w0jAheglfCB
	BX05cJ62AkonXF9sk/BQ9Q1yfQrlPHXvqiOr9/CiVY+mCHGZXPSMw7UvdAMwQOhEePAvCKwyD5Y
	myiPXyb8DJYN1omFvCb3bShJYznV7R5aSoek3dYi535V1fQM+/fiwOy2JR8es4ArNhWPOC9QCQw
	J1TcQoY
X-Received: by 2002:a05:6a00:8d5:b0:847:926c:582c with SMTP id d2e1a72fcca58-84fde266faamr2008039b3a.29.1786671918198;
        Thu, 13 Aug 2026 18:45:18 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4563649sm1508027b3a.7.2026.08.13.18.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:45:16 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:45:11 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com,
	mst@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it
 has connected
Message-ID: <an5zJ9Uf94_L9TyB@v4bel>
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>

On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
> On 8/12/26 22:13, Hyunwoo Kim wrote:
> > commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
> > already established") stopped connect() from resetting an established
> > socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
> > that moment, and the state can change while connect() sleeps.
> 
> I guess this makes my fix incomplete. "Fixes: 002541ef650b"?

It is incomplete, yes. But this has been triggerable since d021c344051a, so
I'd keep Fixes: d021c344051a.

> 
> > A peer RST moves the socket to TCP_CLOSING, and it is not removed from
> > vsock_connected_table on that path. connect() then wakes up, fails the
> > check, and resets a socket that had actually connected to TCP_CLOSE and
> > SS_UNCONNECTED.
> 
> Thanks for the details. Do I get it right: connect() misses the fact that
> socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
> during schedule_timeout()?

Yes, that's it.

> 
> How about:
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 622dbd046799..39c42ef016c3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		timeout = schedule_timeout(timeout);
>  		lock_sock(sk);
>  
> -		/* Connection established. Whatever happens to socket once we
> +		/* Connection (has been) established. Whatever happens to socket once we
>  		 * release it, that's not connect()'s concern. No need to go
>  		 * into signal and timeout handling. Call it a day.
>  		 *
>  		 * Note that allowing to "reset" an already established socket
>  		 * here is racy and insecure.
>  		 */
> -		if (sk->sk_state == TCP_ESTABLISHED)
> -			break;
> +		if (sk->sk_state == TCP_ESTABLISHED ||
> +		    sk->sk_state == TCP_CLOSING) {
> +			err = -sk->sk_err;
> +			goto out_wait;
> +		}
>  
>  		/* If connection was _not_ established and a signal/timeout came
>  		 * to be, we want the socket's state reset. User space may want
> 
> ?

Yes, I like it better than mine. I confirmed it fixes the issue.

If you don't mind, would you take the patch from here?


Best regards,
Hyunwoo Kim

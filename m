Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887092;
	b=3P3BGjqUbX0I54ip+ZJfIhgFdrKGRTutJNuLehvgNFyzbverRArXbS8henUkOizkk9q6
	 Io3M/5HRvequJ1dciKMFzq5AG/HS80mDydPe3S+yi82AUfywni6fb3dGq7vf1mWCqT0sx
	 UrNTGaSAn+e7o2AZz9e+U6Pqj6PC17ZmhJc6ZtVrNmVBeP1vixUd8LUJC61+nRnWVCfFC
	 7KnOwh42+QZgY95UsqtaeM+tQlPe5L8+hwHf4EmT5CofaK1ed+LsvPgeC8mW8h7gDVax/
	 Hp5XT0xr9wW8t6Pk1+eFD1slBIZX06LwhWHJnC7LgL5cWD5WdsuVtvq8jzXdDcXxbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887092;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4LXZbxqzq4LIk7WyW1SeSNbJHlBvjgXgeoFuHhkgJ6E=;
	b=RA99N3ye3YaEWwJ4APty5QF4HR76ZHDae3YwUKucpkMtiwfFc/toI2orbWpTiij4/u7z
	 IJzSS8qMIkA9qsF5NFnRwg0SMWAAvNXFojVvZpAQaOXlTBK+mRUodyXikmaePvXBv04Qi
	 CBFwIgZsy8OJLZxCxqtp+5U4+1Yd3tr1WOZo2LpVrv3Gv1Xf6adO5c0MHW4QClseDosdK
	 Yoq12kU5BYq/phQ2IwY79xgoZgQtxClGaO1AiIEgq3o+0tMWbiEymS+0HE+NocpYqQ6HD
	 YCYM1HvtUaNXdMrJBh+GKYZ63/IOhpxfdkC3IvQSAdof91BO0Wf3xBklznkl6CXQPZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9kYmCTr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222FC606A32D;
	Thu,  5 Nov 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9kYmCTr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B321F000C1;
	Thu,  5 Nov 2026 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887092;
	bh=4LXZbxqzq4LIk7WyW1SeSNbJHlBvjgXgeoFuHhkgJ6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z9kYmCTrQnnY+UT/aEMKUdjk9MYHLJ1VXtv3P6vKMzrySojtn9nW3bcMW0YRI3rTc
	 D+Nxhn3sutcb2SW5UlGF1ylXi3gG10NmRFILINIk/7oSNqf6hzMC27Rw5sKfca9B2A
	 Jg6iLQKVAA4I63hUsFsTisRvl3QD5YH0r40NTcTUGjsfFeYEk2NE8jT1gUEg8sTQfv
	 mzt4Y2IzwqIfiQHg+aavNl7QJxZOzwPrJK59z6XJDT6NUqChiEV0yHEB60BUBNpJS+
	 Qi3R2sZIbx0W960jcM37z2Fe3Tip6A1QF2mOKGNLuYAWjTDuKXL7+yTGpKZKanlZnC
	 K9WUEq6pRyafA==
Date: Thu, 5 Nov 2026 13:58:08 +0000
From: Simon Horman <horms@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, kuba@kernel.org,
	pabeni@redhat.com, anisa.su@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mctp: accept MSG_CMSG_COMPAT in recvmsg
Message-ID: <20261105135808.GS865646@horms.kernel.org>
References: <20261101200331.1956836-1-dave@stgolabs.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101200331.1956836-1-dave@stgolabs.net>

On Sun, Nov 01, 2026 at 12:03:31PM -0800, Davidlohr Bueso wrote:
> 32-bit userspace running on a 64-bit kernel is unable to receive MCTP
> messages on an AF_MCTP socket, even though sending succeeds. There is
> nothing for MCTP to do with it beyond not rejecting it, as af_packet,
> af_key and can/isotp already do, for example.

Hi Davidlohr,

Thanks for your patch.

As prompted elsewhere by a bot, it would be good if the patch description
included some information about how this was found. And also to what
extent the fix has been tested. I know you answered that already but
I'm going to ask for a v2 for other reasons. And it would be good
to include that detail there.

> 
> Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

This seems to be a fix that effects users. Which I believe you have
reproduced. As such I'd lean towards this being for net, CCed to stable.

Subject: [PATCH net v2] ...

Otherwise, it should be for net-next.

Subject: [PATCH net-next v2] ...

> ---
>  net/mctp/af_mctp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
> index 8af5e2b3c8d1..aa22c0860712 100644
> --- a/net/mctp/af_mctp.c
> +++ b/net/mctp/af_mctp.c
> @@ -292,8 +292,7 @@ static int mctp_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,

Strangely this patch has been mangled - the original code is 7 rather than
8 lines long. (s/,8/,7). Because of this it could not be applied by our
CI which then did not run the usual tests.

I'd like to ask you to fix that and send a v2.

>  	u8 type;
>  	int rc;
>  
> -	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
> +	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_CMSG_COMPAT))
>  		return -EOPNOTSUPP;
>  
>  	skb = skb_recv_datagram(sk, flags, &rc);

-- 
pw-bot: changes-requested

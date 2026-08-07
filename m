Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462047ECE5
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121050; cv=none; b=GQfDxLfFZH60aQKa80O5LEw1g3UK8CRIU6ogXbk1O9hobIj3RvoF4kHr4jhCas3Hkd0Lwb6lU6mfBjAcBsufQQH1O1tMXjmq2yG7WTMkOPLettpfjI7HhhRDGmg6+GQI+b09wUCWqUMyDhb9E6rrGjOiIY4pYNC+3IdeFUyzTcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121050; c=relaxed/simple;
	bh=uPhLGPhcYhdMfSp4rrZp74jm8xFS8hjXR/BosdftPU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyzOoDBsJVl6Y+vpxg92suxZ4LL3gUu3CbTS/vsoAApnxw7oF9HffntRixLnnfof2us2uXnoVf5QLWkJIMKGjrMbJc8QVkLKNFdgzckoO5vVTSgpO6IbbzT2dkBvaB3kCdwreP/twjnOHGfkqolgOxYlJtiemG81yLiMQLjC2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcT2M3h9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcT2M3h9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956242332dso28268725e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121044; x=1786725844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QXb84XN1127M+aZY6/SeCM+ISG9Q4eDpoIhqwUcmGU=;
        b=UcT2M3h9RMhWwlsYKBJV4IzIj8IK0p8L6BlAMqKaHKzJ90hXgWWBUlqgwRHRMBu3HP
         zHInYBcMuQXkiT1I2mPxrGCNoltKBHnVz8wZAbVkAtjoN2O03c3K00G9JiHsnisc4ztF
         TZaIUYe0JEEjqw4HZV1LrYrWp4QQFk4P4VadnUQc0mi8nUfyWp/yAAWdmP8zDGiDE2q3
         3OKxdlKbL2MFiwuTxa7evZraV3ekmPpCr66dgH3PbhNcG1IiK96TDjvgUbr88lyFX1Ol
         Eh/AiM8gXCkoLesPfVRow1Sz2K8GnEnjSlfdjPyZ4Zlzq9tiGS0Mmt8UIKjwoQ41bHK7
         PATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121044; x=1786725844;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QXb84XN1127M+aZY6/SeCM+ISG9Q4eDpoIhqwUcmGU=;
        b=jDQw8cNBm+ecPnZ7wdTDMM/zd5nC+YDw9ZGsOGBH47sAI+RF8xP2F6PrN2dit5Xx07
         oLuHmf3Qju6kdKxg0+V/oodZYFKJD8ZxVgw5CknKHd7CCRRNKcQWx8O3AFbUX7/ZnlY6
         tgJB+TtNJrNR5Q+glfsxOkv2ZVTfUcU1hO86LqibAf888WxqEkMf4mPLxXAaSDQKNYDj
         tOGoGNhF2DVjgNyLQy3jF9nFh42tUet1v36iRnJyFnh73paab2rQ++j4vqdN4z3cwShh
         ehRF3ifU+KwQ6xjCm2hSv14ShBYjaWZgkUUdcEmBkKwN9918VN9Tb1XFE8DjaFuk5XNm
         VEmw==
X-Forwarded-Encrypted: i=1; AHgh+RrfBIuEShJ/xdaOdCqGsVksT3/N0RMOC4Gn+1SIFqi1h74wgfETpDaTCENeRLpbcy9qOCD+Uuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKqu/8JNMroZDYllK3HGjRAVEJBcaYOJdbAbpOryYgyrQKplj
	VLYlfe6XzuIMidUDGEBgcNanbwlauUNI59K3JuO/numOCHzM3Vqz5msL
X-Gm-Gg: AR+sD11qJXxrES/uLp93W39yWWeaLav+bQOAkBJbLdd2FSgL/fhRS4pwLLoaKp3UHYA
	ivFXvEY4EYrfp99jb8nhkkuXF4Uked1h4X6XPwgAIh6dWiQaroqs8kPJsRSsKc7edzG6LJ6/AaF
	kvJA29FugOWQwcQXdDYXdr7bANSdryWYfAyOf5HMZGIEUo4j60MvVDtLRle6hjFEgQXLbS3rGyD
	XkDeVOnLxdY2crODOrOGi+mCXJLON+gszNYHDksmfTDfDyckPm6CYi0LthGZwAOSzcyN/XpdTBj
	XJ0tNoqaj7WFzRyZGEz4ThKBWmJbyAKKqnacjWRcin+9Hz51tTwV/5vSqH7GZn5W9CMSpJV5GPM
	FPY1V4M4s27/EPH0bRmonrisn145hUian2ZyRfTqajLY9QA0ujdFrAs2QUk/CLnAM4E9vkuUV2A
	REGKTyHjFYKRwiNOvli0RZIOiTtvfrl5G09ctWK/B4FyM6AQpgPLmx2hBMPTCVDOHSgOI4DRliQ
	P3w0Z62Bm1XoFfgdRFUyzHrMg==
X-Received: by 2002:a05:600c:46cc:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-49961b8a027mr11821095e9.15.1786121044328;
        Fri, 07 Aug 2026 09:44:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm7368787f8f.28.2026.08.07.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:44:03 -0700 (PDT)
Date: Fri, 7 Aug 2026 17:44:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <20260807174402.2dfc12d6@pumpkin>
In-Reply-To: <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
	<20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Aug 2026 02:42:00 -0700
Breno Leitao <leitao@debian.org> wrote:

> getsockopt(MCAST_MSFILTER) can write past the end of the buffer the caller
> declared.
> 
> This is because the copy_to_user() does not respect the optlen, and can
> write over the allocated buffer, overwriting userspace undesired
> memory

Nak. This is just the way it is defined.
The application provides a length that is just the header.
As you noted the header contains details of the real buffer.

There are quite a few sockopt like it, you have to support them.
There may be some where the length isn't checked and is just assumed
to be the right size - they have to continue to work as well.

	David

> 
> The amount written comes from the numsrc the caller left in optval, not
> from optlen. do_ip_getsockopt() reads optlen once, to check that the header
> fits, and then reuses the variable for the length of the reply, so by the
> time ip_mc_gsfget() fills the source list nothing remembers how big the
> buffer was.
> 
> The copies go through copy_to_user(), so this reaches only the caller's own
> address space.
> 
> setsockopt has had the matching check from the start:
> 
> 	if (GROUP_FILTER_SIZE(gsf->gf_numsrc) > optlen)
> 		return -EINVAL;
> 
> Clamp numsrc to what optlen holds rather than rejecting. Another option
> would be to reject (-EINVAL), but, that might break userspace _more_.
> 
> For reviewing purposes: size0 is the header size, so, the available
> buffer is len - size0.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv4/ip_sockglue.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index a55ef327ec932..2e4e19b90645b 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1447,6 +1447,7 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct group_filter, gf_slist_flex);
>  	struct group_filter gsf;
> +	unsigned int max_numsrc;
>  	int num, gsf_size;
>  	int err;
>  
> @@ -1455,6 +1456,10 @@ static int ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  	if (copy_from_sockptr(&gsf, optval, size0))
>  		return -EFAULT;
>  
> +	/* Maximum number of sources that would fit in the userspace buffer*/
> +	max_numsrc = (len - size0) / sizeof(gsf.gf_slist_flex[0]);
> +	gsf.gf_numsrc = min_t(u32, gsf.gf_numsrc, max_numsrc);
> +
>  	num = gsf.gf_numsrc;
>  	err = ip_mc_gsfget(sk, &gsf, optval,
>  			   offsetof(struct group_filter, gf_slist_flex));
> @@ -1474,6 +1479,7 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  {
>  	const int size0 = offsetof(struct compat_group_filter, gf_slist_flex);
>  	struct compat_group_filter gf32;
> +	unsigned int max_numsrc;
>  	struct group_filter gf;
>  	int num;
>  	int err;
> @@ -1483,6 +1489,9 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  	if (copy_from_sockptr(&gf32, optval, size0))
>  		return -EFAULT;
>  
> +	max_numsrc = (len - size0) / sizeof(gf32.gf_slist_flex[0]);
> +	gf32.gf_numsrc = min_t(u32, gf32.gf_numsrc, max_numsrc);
> +
>  	gf.gf_interface = gf32.gf_interface;
>  	gf.gf_fmode = gf32.gf_fmode;
>  	num = gf.gf_numsrc = gf32.gf_numsrc;
> @@ -1705,6 +1714,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  	switch (optname) {
>  	case IP_MSFILTER:
>  	{
> +		unsigned int max_numsrc;
>  		struct ip_msfilter msf;
>  
>  		if (len < IP_MSFILTER_SIZE(0)) {
> @@ -1715,6 +1725,12 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  			err = -EFAULT;
>  			goto out;
>  		}
> +		/* Do not write more sources than the caller said optval can
> +		 * hold.
> +		 */
> +		max_numsrc = (len - IP_MSFILTER_SIZE(0)) /
> +			     sizeof(msf.imsf_slist_flex[0]);
> +		msf.imsf_numsrc = min_t(u32, msf.imsf_numsrc, max_numsrc);
>  		err = ip_mc_msfget(sk, &msf, optval, optlen);
>  		goto out;
>  	}
> 


Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3B314A86
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259003; cv=pass; b=aopTlRe+pYve3k/qgRpwX+7DFeVUvXAK9E/rKS6dx2Fd5b+GFLx3eVnJVVy2N/ZuJStD0XKL2rbihNqek6y9dayhg7E5Oz2TKL+aRvqVWB4Mt6ZJ+J5NOxRXeaU1swqQZy6zcic4PWnTAyG6DHb6eCjUi6rHCsY5jNj/cIGmjOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259003; c=relaxed/simple;
	bh=WeifkZ8waSG1zQ5SVkzx8LC9mIMj4IJdHzkmu1At7Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz/tjZ8eXPXvevSxRVKR6s6Fqu/mzqB2zjHc51MCcGWVSelrTphy7fntgV6PEIPoqsUhtCcb4S/FN6g/hed+yNfngwXyrvxSIBWDGjjeGPfH5TWK1LcphthjXG+wuwSW3tFaWrrknYaa1dp+wfoZptAV+UKvyzMPIuzkioBNV8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPh45LYp; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPh45LYp"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b2b01478d0so29128b6e.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787258999; cv=none;
        d=google.com; s=arc-20260327;
        b=UFVZ0yG9bok2zOT8gi5N4oG2EZFJ/F9SBlFzr5X79oEm5bWBsT4peAIUdcWDQbelNr
         Bf2ucP5vRPp7XJOrubyOH4JbHmAmZiL9yfDY/zp/uBaMM3tUoJu3ojbiFM7AGWFi8uD8
         YmfEY8GbLIXd8XVdx+MH4dl4rh0JYJSVLN8FsFKrySdU5cBT8R+P3GFYOhlLAS6dHawL
         m76lhjSEXCMzo+XSwWQh4osPchG5+R8EdQIU60nOtGwC1sUONwUxg/06BBChhfYJyRXk
         2uYW6sNjivuGL3yAU9dlT3a4Wj6euyfpCcZKEtkrVyI1yzRW3KEguTkNJmggRnT5jPYA
         TOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kL4VnCS6BLfpWe4s99pA0EQMN8CrjjCS8Ah6F2nU+Ts=;
        fh=wFmu0KDUCjaW8MY17+nrCykEKSUmzPu4cjTSaxPxDLw=;
        b=NuzuEez8lk65KPGiCBJfD/DA7O2Elmn4jfvSuQ0/TEC+y4TLlHwjhQiJ6rP4HYSD4F
         cKFCcLNM6PIPGjcnbzMRoAfbtowOXVOUBpHkW9e4BlDNjshp4Cl9vygwXgcfJ0JWVUW4
         70F6YA1QZbh4KM+txogypdZUxoh6xUZOJtzLCC0UWBkSsZvTsFGM2xZIVtlovNTPtccn
         1VH1mbQxTIQyIpVdM/NIefgmrk2sAUL/r9pcoig/lIwdhl0p/rVS6GR00RUfCvInrqhK
         b7Lu/zfCYrPLH3zOA5v2rwticoIGla2ncTIL21gs/Sw9RZn+M/t6EGuX02S2VMsERsOX
         hnwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787258999; x=1787863799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL4VnCS6BLfpWe4s99pA0EQMN8CrjjCS8Ah6F2nU+Ts=;
        b=lPh45LYpk3JiBJ7KUt7AuvqNy3fRfYdc3MHtxaVWMViu0M4AXPWhm2tcy7lDLKYDPT
         IZyMC02bAMNme29XHhA+58aVCdXezOCxzpzK2pZFeI8Jy0YoCpsezDFQl7LUljANDoEi
         5PYgOlaS3/KWeuO1ceeKhpYBhIaSg479oajML1XI1N/9cCsHK+2cVWq0I1rYkNWXRC+R
         DEoKkjGEuiSaacR6TbGbBiC0Hv6FqR85T9UV/mdM70XUD0QqwGJaAx4L0O+WXlXCCz18
         Qfh3e2+6WkCcGh4azTj/Su8V3047jLCevheRuAcGhU2HrnphJ6SpCLkbmMeRHugHy+f0
         L6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787258999; x=1787863799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL4VnCS6BLfpWe4s99pA0EQMN8CrjjCS8Ah6F2nU+Ts=;
        b=pqvM2D3RP66X6glCQkdlb5KrOvFoErEyBt6LCjYuS22yBWvTGOoKrMDVh4IdOyI33z
         0LnJ3N2ZsmwFI3OVw/N+kAz7fglaqZV2zP3jTvNTFGe2VdnseXrvmaw3shXFOgM3QPrv
         Sx39OFd1iFrtM7v1H32/Dx1IQzEp3WIE08mREH3U9JkoIEJ/IsT3hzDaOv0ghrN111uB
         vcWMK23OpOQGw2aNHrMO4K/VgjLWYNvOnrxXDondtVLpMRhkZ4nmmDPsKXwAU93t21ha
         FV6ule9JySvFLlZiiuWgXXyvIDE52xhCAhTojOyCdENYELFK505xRIkWe0oQjtr4e6dN
         TMGw==
X-Forwarded-Encrypted: i=1; AHgh+Rpsu8jzNfbrt+cT097MNlH0jppNXMb4vCnkPQCjog3zva832JWx8wWBa7O7NBrrh8TbzpY0ezQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfx/Hvoi1IzvItRhX5nsStTBjK2L1Y7stxns9oaVNklQPE+2g8
	qGBlPFQtlfuhNGMgG9PUqlUMM2F1BbktSZ7qVdd8xgehY97OOWFZZ5/PAAoI3uwXXXJU9pIe73Z
	jNgmmOZkENmlS+Z/ML3ityB015pKEPOw=
X-Gm-Gg: AR+sD12FpPsvVgF7SusVowBh6vz1AQBVtb1QO/tcjfk5asxRRScRs9iVZ5DoZt7HqDp
	4xqZwTSvkIQrdZpHtBnZA/tVmZG3xtINycPBHCoRfyoFurZrnlTH11KM/hn72TMwc25VnayxO5T
	+QxpzOhgRmfeca4dIhRcCHsgWcpgjS5tygpYswbkyvWG25gpqR6umh44CgTBn+28t/5aaGmXZN6
	bfDE40ZihVBvsSrykvLBNTP0DIZITc/yx6oZyP1GpHJD3L0m7LnKibw2IOMZgQjgN9zqhlHC7tc
	hZFKgUQjibZuuH2USw27HM0mvJHzgin4X+uGwZgztmBcpZaF8dyNuNletkI=
X-Received: by 2002:a05:6808:178e:b0:495:f643:2785 with SMTP id
 5614622812f47-4b2ef459dc7mr601810b6e.3.1787258999047; Thu, 20 Aug 2026
 13:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-netcons_ratelimit-v1-0-8c5d2d17789c@debian.org> <20260818-netcons_ratelimit-v1-4-8c5d2d17789c@debian.org>
In-Reply-To: <20260818-netcons_ratelimit-v1-4-8c5d2d17789c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 20 Aug 2026 21:49:47 +0100
X-Gm-Features: AcwNN1UZ8BHLW-xlVhw8Rsj5Md0elven6hi7UKRdpaKG-ODdLl-u6nPmZ3yH5Bc
Message-ID: <CAGSyskXshZTuBwiOPzp1j-d3He07Sx9OZGqRq4k6SG_kBwuKMA@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 4/6] netconsole: tell the target when the
 rate limit drops messages
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, paulmck@kernel.org, 
	davej@codemonkey.org.uk, riel@surriel.com, asantostc@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	samuelcrossley@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:30=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Keep the number of messages dropped since the last report on the target
> and send it to the receiver as soon as a message gets through again:
>
>   netconsole: 45 messages dropped by rate limit
>
> netconsole formats that record itself rather than calling printk(),
> which would feed the console it is currently servicing. Nothing here has
> a printk sequence number, so the extended header carries a zero.
>
> The timestamp comes from local_clock(), the same clock printk stamps its
> records with, but it is taken when the notice goes out rather than when
> the message was logged. It can therefore read a few microseconds later
> than the message it precedes.
>
> The notice rides on the next message the bucket lets through, so a
> target that goes quiet right after a burst of drops only reports them
> once the host logs again, and a target with ratelimit_burst set to zero
> never reports at all.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 53 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 6d60a5188bf13..0af2e5b4335c0 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -50,6 +50,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/delay.h>
>  #include <linux/ratelimit.h>
> +#include <linux/sched/clock.h>
>
>  MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
>  MODULE_DESCRIPTION("Console driver for network interfaces");
> @@ -177,6 +178,7 @@ struct netcons_userdata {
>   * @sysdata_fields:    Sysdata features enabled.
>   * @msgcounter:        Message sent counter.
>   * @ratelimit: Opaque structure to ratelimit messages
> + * @pending_drops: Messages dropped since the last notice was sent.
>   * @stats:     Packet send stats for the target. Used for debugging.
>   * @state:     State of the target.
>   *             Visible from userspace (read-write).
> @@ -221,6 +223,7 @@ struct netconsole_target {
>         u32                     sysdata_fields;
>         /* protected by target_list_lock */
>         u32                     msgcounter;
> +       u32                     pending_drops;
>         struct ratelimit_state  ratelimit;
>  #endif
>         struct netconsole_target_stats stats;
> @@ -297,7 +300,20 @@ static bool netconsole_ratelimited(struct netconsole=
_target *nt)
>         if (oops_in_progress)
>                 return false;
>
> -       return !__ratelimit(&nt->ratelimit);
> +       if (__ratelimit(&nt->ratelimit))
> +               return false;
> +
> +       nt->pending_drops++;
> +
> +       return true;
> +}
> +
> +static u32 netconsole_take_drops(struct netconsole_target *nt)
> +{
> +       u32 drops =3D nt->pending_drops;
> +
> +       nt->pending_drops =3D 0;
> +       return drops;
>  }
>
>  #else  /* !CONFIG_NETCONSOLE_DYNAMIC */
> @@ -345,6 +361,11 @@ static bool netconsole_ratelimited(struct netconsole=
_target *nt)
>         return false;
>  }
>
> +static u32 netconsole_take_drops(struct netconsole_target *nt)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_NETCONSOLE_DYNAMIC */
>
>  /* Check if the target was bound by mac address. */
> @@ -2554,6 +2575,34 @@ static void send_msg_udp(struct netconsole_target =
*nt, const char *msg,
>         }
>  }
>
> +static void send_ratelimit_notice(struct netconsole_target *nt, bool ext=
ended)
> +{
> +       int len =3D 0;
> +       u64 ts_usec;
> +       u32 drops;
> +
> +       drops =3D netconsole_take_drops(nt);
> +       if (!drops)
> +               return;
> +
> +       if (extended) {
> +               /* append the extended headers */
> +               if (nt->release)
> +                       len =3D scnprintf(nt->buf, sizeof(nt->buf), "%s,"=
,
> +                                       init_utsname()->release);
> +
> +               ts_usec =3D div_u64(local_clock(), NSEC_PER_USEC);
> +               len +=3D scnprintf(nt->buf + len, sizeof(nt->buf) - len,
> +                                "%u,0,%llu,-;", LOGLEVEL_WARNING, ts_use=
c);
> +       }

This additional message with sequence number zero in the middle of a
stream looks awkward.
I don't think we need to send a notice about dropped messages to
extended console targets. Those targets can detect dropped messages by
tracking the sequence number in the message header.

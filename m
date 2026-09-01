Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AF43E4A2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279609; cv=none; b=fV6vJwGdFu/a+KhZxTtQoo7jWRBlcY4zx6B+HlgGOiPCD26MISmDHxTZM/8rgFypylOEeYm4C+OMMPbKeSLjzrfPj5Akx50LWXCUh933nXWpXAKVQWmhX5xJpVJFSQgBy3SDcXMZoHTdINH8qKrGooefIZuw4h5RjwDckR8OtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279609; c=relaxed/simple;
	bh=Ph8PvSY4jSqoOfFA76v8Y19/URES1/E/ItNUd86GafU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axo+S6yV8/GS/CQnWWdzdJg5XeUi92NzZTKJD+9o2F4/vEg7F57pf/Kbr79nvHtjo5SIcAHF1MALCxpImNgMUszXuPZW8xE5BjFbyspVGEd6ve77uS5h6M2fcSsCoP2+jhvc0Dkl+t0wapzCjuii19mqXNpeGlCjetgHhLUCz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UlM36j2H; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UlM36j2H"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1712a04ddaso814334966b.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788279606; x=1788884406; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xt613ZL56XxGaY2+kHrcKG3IPyUonAahqlih7qZ2NEQ=;
        b=UlM36j2Htpj87uDzTxIa3W42+QqPM0tcZylTckJfK00n1X2/Egsf/2F2epjgMAAeW6
         X7/kkZWbDQ5F2a2B36pPnDknMaUJinACS0bMqtmfu5HU7w9frWjBLb/2M747q3/uPL7I
         9JhTItBv1UPx8CY64Cev/YsJNrWgQBZlvVuLj1/P5G566txlZy2AHgkH02cAxXh7DerV
         dowJzMUMrVPpKsaj/AmiR6AlB/TDhTtWr9IpKM8AtadL6zbbiaSVox1zx8KOgjPwUfX5
         fG7FwzuvZyRfZu+4wIsX5iTGSl3vuRe6kliVC8aMHlDsbQA4j18z8fJtdb48f5K93kzb
         dfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279606; x=1788884406;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xt613ZL56XxGaY2+kHrcKG3IPyUonAahqlih7qZ2NEQ=;
        b=lbiRHlxO0RyEpMa32jFq7MSSJ1wiEnaslpm+7y/me3IsyEC048c+tTXx4P+iqCNa+3
         0kwopNHiKirGuq7ybn+0t5Om8OB7RLhjxNZWn9gmOB/EhUY/lDcw08HeUVX8rNcjR4Wa
         rT+u0irLie0OLaNxlsPsnK+/MUdYR7+lfO1D8dHuxgeQLHRRoymu3ClhNPnBEGgLP12J
         jivkOHyA/Zaf6Jzg4RGXZ9rXpkEhkdeL0rqQ/FDzDBN9rrirFrYmY/wSoSuevNzfouu/
         FJPdxLquxuxhA/lms1oL6B1kugZyz+63VFKCiRtz4B0hZchLxMjnmzN2X3O41egL71mv
         84Rw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/LenJfkNUDx/h7Grzeuez5bA8CvbxaNanWSpn7zAp5YoLheu7oMIyWJwr7jGAXM8dRI31+Kc=@vger.kernel.org
X-Gm-Message-State: AFuF++kxwnoa5OKVD4BBPg6ju031ERvcEtyXBw28jqFU93zulUbYvQyj
	g/2gUevghBss8jv39WXMIbOQqht1QhRixOCxDR0Le/4ObM466/vDSk7qEp7/KRhvgyA=
X-Gm-Gg: AR+sD1363xGJG6t0Pf+SA68gRsk6KkE+sBIqzTyyFs7+BR5iZGM6E7m4CenGr3Yswh+
	BNzGdh44c4qeimZK35PdoRMmRt7Oa1fJredUETdW9BCFd0Q93p9+vjH/dAoOetNmXuYNFfz7Bd1
	01FKmW43mxJkqqk0bJh7PnKVbnen9GeTZ1QGPkl3qNSGeTXLp69ACOC4a4W8//2hCB5xk/TDKqX
	8epIqrh42WNCX+q/ysaNS5trXvmrN+5PUmhctJZwbVB7/I4V4ZDNO6zcdmjtDIbsu1CA6oCQcmJ
	FFET35PT2bKRzxBGCgcKUuYvTmQYTMhI+3A+CIR+7ZE4RjHnSsNdAg3TotGQdt6yLDlediiWkul
	kTdDShgUkLJVo40qM97BhabPdYNRZfS81z+OuVVwdLCVv7U61tCN7xCX7ImDGpyr9mOiTr9oADC
	Wz935NOkCyTmO6NWxe4cf3REpKPqeErGvST8HtfAmg/7q7BfI3/KOaIfKquX6cog==
X-Received: by 2002:a17:907:5c3:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c255741620bmr2353708366b.20.1788279606104;
        Tue, 01 Sep 2026 09:20:06 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f249434sm618644366b.55.2026.09.01.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:20:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: David Ahern <dsahern@kernel.org>,  Ido Schimmel <idosch@nvidia.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next 1/3] ipv4: hash uncached routes by device
In-Reply-To: <20260826-hash-bucket-route-lists-v1-1-fa9b9f30eb74@cloudflare.com>
	(Chris J. Arges's message of "Wed, 26 Aug 2026 15:20:07 -0500")
References: <20260826-hash-bucket-route-lists-v1-0-fa9b9f30eb74@cloudflare.com>
	<20260826-hash-bucket-route-lists-v1-1-fa9b9f30eb74@cloudflare.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 01 Sep 2026 18:20:04 +0200
Message-ID: <87qzjd2bbf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 26, 2026 at 03:20 PM -05, Chris J Arges wrote:
> rt_flush_dev() currently walks every per-CPU uncached route list for each
> device being removed. This repeatedly examines unrelated routes and makes
> teardown increasingly expensive as the number of devices grows.
>
> Replace each per-CPU list with 64 hash buckets keyed by the route's
> netdevice. Keep the owning-list pointer in dst_entry so route removal
> remains unchanged, while device teardown only walks the matching bucket on
> each CPU. Hash collisions are filtered by the existing device comparison.
>
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  net/ipv4/route.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 604cc51dfd9b..3f9bc1ec72cc 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -74,6 +74,7 @@
>  #include <linux/init.h>
>  #include <linux/skbuff.h>
>  #include <linux/inetdevice.h>
> +#include <linux/hash.h>
>  #include <linux/igmp.h>
>  #include <linux/pkt_sched.h>
>  #include <linux/mroute.h>
> @@ -1552,11 +1553,22 @@ struct uncached_list {
>  	struct list_head	head;
>  };
>  
> -static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
> +#define RT_UNCACHED_HASH_BITS	6
> +#define RT_UNCACHED_HASH_SIZE	BIT(RT_UNCACHED_HASH_BITS)


Consider making RT[6]_UNCACHED_HASH_BITS a build time tunable.
We've had a case in the past where we had to carry a custom patch [1]
because hash size was hardcoded.

[1] https://lore.kernel.org/netdev/1295041688-16550-1-git-send-email-wsommerfeld@google.com/

> +
> +struct uncached_table {
> +	struct uncached_list buckets[RT_UNCACHED_HASH_SIZE];
> +};
> +
> +static DEFINE_PER_CPU_ALIGNED(struct uncached_table, rt_uncached_table);

[...]

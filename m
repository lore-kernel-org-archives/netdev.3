Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1983749F5
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032603; cv=none; b=kn2NybhWbxCusmag/FTlpn1wId71eLoj1xaYP5gHxxpzZ5Kj00LUojTwFTlPrwjh9A2uh8hzPBZmwGHIduvYz9Rx410rpiFSVb3W2NpAFpIxciuyvzoY8FzHG2c6Wmj6QqwnDYEQtLjZFkWXopSZzayQBsUH2Jvlr4DpE/mXVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032603; c=relaxed/simple;
	bh=UyPcQOrg37d8MiwZ6bScuA9l5DqWORbCemQ6xQSSu/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq6sMeUj8wtnTc+l7hgU3QcfbaSNdXl4eHdE/6P7fqFduwRQMUJeL0eF9AuuTn48cNmK9jNjZSOK8abO5QJnBcDapbHEh8CHqTR5ozSK/TZL8DpLark7OIYmChCA5Vaj0dvoUIqMJH6JOaoKht7ImAB4PKdUsL2zKU7IkbOm08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX4bbizj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX4bbizj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf125989f2so44051665ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781032601; x=1781637401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdMgFvbgb7XPTpNB131YgOTOm20ORM4/r0OW5MwXJCw=;
        b=TX4bbizjiGr8NoemW2+7wV09FRSpt7NT0ub8LoRDQOU7ywsTxSevIOIG6z7W4vwEre
         vCumEon4283ddh6qt/DFnJEg3aMnupx3g0YGItOuOYWiWyMzTwNKd8t/wOgsBGjQlUwN
         SFPqn7XaXr/tlZmQSMX7t9SD8SOqsxZVGDR7gjTOhmdcaIGQ/1vqERvG9AiP5FOW9eJ1
         BZPK5TXtd8e5YhbLqEKwFs00n7m74DSWiX2Mu0/KkSYIPJu6sgtlKTbarQdeh1xKk5qT
         JTX6vZd1L4aG2cWwA0iZ6cvfPESpNE5Dq5r4xaljY+PazGo0x+zAjVOuh3usZUmLKjHk
         urXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781032601; x=1781637401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdMgFvbgb7XPTpNB131YgOTOm20ORM4/r0OW5MwXJCw=;
        b=fPnRJ4N/bkVi8kesUV0vF0PGQEJr3hGnfU9FRENPp4f3zzgrz9l2XUV844NSDx9WHn
         Z0hRVmJirC1GXv2aunEJkP41GEbrA4Lhi9o9Qifon0/2jwj3y/F8Ayc6xR3zK8G9ZQu2
         XmiT9UokXDyTGE9eW6CM1ZpQuEJg09JWB7uWtt4u/klto/PiW8VXxp26O8PenRLc0tjQ
         N0yk5bch+C7dRPuaQHPPvv9gKRrEYGSIevtinKC21M9GPzLmsx3Pkq4eubskTeNVOuQK
         5a4FpkRR62IS4Gvbe/qTBYBGXJVaRtitarLCczyQWJzByY86HJt2KSXYB5nhiWokwt9v
         qJ/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9l2OeHJ3yZo5PH07HHikdQ2WQi8Qb8y+2Wo6wLhQuO5B6smllWzRvjbRBEA3Go5+yffEv+PSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGxZJgYLY7JWI+SAsajLjeL55R58hTDMxMMgn3aC8eoL5qGwD
	uEYRMWdAq32ehTVm93sOBwqTEguMiE1c8hr/j2Wq2i47gcmWJnW6Rf2j
X-Gm-Gg: Acq92OF7gN0R8Z5EjH4mC4DbtVML9P13BDjpa4AU5+la+OyxEYUhaCa0j6rfOOMToXz
	mmhcpSTmYt9YdPbMVt2ch2osCFgw6S2R72bPl+tJ3aj/6hwgZnmeOuHIQtT1ytGArJKGPjQqNNR
	lTU1NS94lFxKV07O0nND/pXso7fZViA4/igUjHyVLoiDPfc1/ctAw6b3+1k7MVdVShSfORMzuwZ
	gupYFCgwcRYdPOlFfbQvbZeNvwCTqUUkLCWFWaitzOXelK/eyXlBtzr3T/k2kZOoqFUI13mZ7Pw
	eOHhpgCZ3W6YW4pLJhZwK+Yq1eCKU1EmN8x5sjZqJ1FI4kTBh0Rksi4vg8AveCQaV6d7VSQZPxg
	s1AWzYFA3hgBQ6K+o9bYuC70DwLuXQyWgMFnz/lcjqkaASsw5sqQTli9wOCI6Ks4Ui2v4M2/zZX
	wdUvnYYkyTxcDsNopRQ1SK+t1GRpcyG5j5LO2YUzb6Io3aZoA3iYQkj9c=
X-Received: by 2002:a17:903:1252:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c1e8102377mr241228685ad.32.1781032600986;
        Tue, 09 Jun 2026 12:16:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1663981basm219631985ad.67.2026.06.09.12.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:16:40 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:16:39 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dw@davidwei.uk, daniel@iogearbox.net, razor@blackwall.org,
	sdf@fomichev.me, dtatulea@nvidia.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next 2/4] netdev: correct error code in
 netdev_nl_queue_fill_lease()
Message-ID: <aihmlz2pitHmcF6E@devvm29614.prn0.facebook.com>
References: <20260609190804.1137085-1-kuba@kernel.org>
 <20260609190804.1137085-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190804.1137085-3-kuba@kernel.org>

On Tue, Jun 09, 2026 at 12:08:02PM -0700, Jakub Kicinski wrote:
> netdev_nl_queue_fill_lease() returns ENOMEM on nla_put failures.
> This is wrong, the error code should be EMSGSIZE. But it doesn't
> matter, caller of netdev_nl_queue_fill_lease() just checks if
> the retcode is zero or not, and uses EMSGSIZE.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a10d353d5eab..d35af460e886 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -432,7 +432,7 @@ netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
>  nla_put_failure_unlock:
>  	rcu_read_unlock();
>  nla_put_failure:
> -	return -ENOMEM;
> +	return -EMSGSIZE;
>  }
>  
>  static int
> -- 
> 2.54.0
> 
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

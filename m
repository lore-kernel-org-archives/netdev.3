Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBB4734F3
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376504; cv=none; b=rr16NKVIz3Y8gqSybRaudtPKEsYsHfqyltdkuXoO62I8H1yG4O0gxHLJGGPOLMbqv9z2b1vdCg9MeUtmKDIsmaV9zV97CQhAKXp+l5wANuTc5ZD1NOA8YYqBCgHiubv4HeokSNlBPgtpMrup9ncMYvupykfaHsyMxQVYLIubBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376504; c=relaxed/simple;
	bh=X5ldmMZ8oVc3uhLMHuL3apnRWJjXy5+ZyFq1ypFigeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HMcvT5FT+s5gmqposUAn9JGbnRbzBoROcwVzeb2WgPrViJeKaK54sh01Gr7jrG9Frs3iVJ428XqN4FuKncbkNrRR0EJGVRp7nu/jWBO35LgG4IKnHd6HZI4GvDhu9zQF/8mBMROK7EvVJhn9slVrMj/dbm05Lz8Aoys8xv1RaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso34534405e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 05:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791376494; x=1791981294;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5ldmMZ8oVc3uhLMHuL3apnRWJjXy5+ZyFq1ypFigeQ=;
        b=0UQmBwKdAUWk3j8eXenc3CvUE+x3S4NLS1wc+yUeFCmg5J6UMoHJcOCAM3ge4Va1Ui
         WpBa2ms0ZckRPtdfaOlhFzgEGiQpdQvnlItTsSb8X+/5LyZhNQtxR/y4DQToEzEpjo/C
         w+J0kJvz5LMuUaf5CLLQSvD5PwRubl8mB2vbc3Ncy0l1b46NS0cEZj5z0dbJOKuVP9ee
         exM8dxJzaOc+vRs+6jXsFDwuSBuWWRq9FGGiLRFCLR9wtu5q69kXgpM95c7AY9OzpPap
         tdI6xLTpDDM975UeQ4suIqQM5buCB8xYy5MhI0W4ZeteC4FqcFgMn33XYMVA1W2Ne6KY
         Gfqw==
X-Forwarded-Encrypted: i=1; AKwUvBw4SUcb6jEt02a1JhyjEcTfLXOAKRFJZF5sedImFgF7XTyPq18kqvWFQzGKgTtVz7/Z5KEpZrY=@vger.kernel.org
X-Gm-Message-State: AFuF++m52MIS4g9rBi9YEJHenJ8A/t62l0YRIgl9LsASkHM2RwQpwfZL
	eUmgVeFa539qAWTadVGrVq4Jk4Z68FOr4SwgN2pueJY3LKlpQYEl4etH
X-Gm-Gg: AYBFou3zDXE/6Oii3F8GubE+HY9LzBy7hnnDYj6pheKVVdIXBNGg1OOTReWx/l673gB
	e1p9yPGI3bibLT8bgUaWotDfIwfgTbrcuzjI3KAw9dG44r2oAE4Q8wZr24UZbY1/jIS/PcXozdt
	Hnhka2g+EVdxaYeTM2IpeceDUbHSnBiJLHp5d8Bvf+kOSe8a4BoxgJ72xv+iPppi++5uzqan1Gn
	V6HlFIDBQHBvLmXCvlIpd0aUdrm6yTotLa8Hac2XbktKFLMSrVKB8DABuuQBy0aKEJfNshR0b3T
	H22fmcNJYNObkV/U24HT4XpQHXr2bGnUDVSuOtuum9vrNl8iLjEzzVjWIy019QDZLRrrTYW3vqo
	OW/nXSd9zFCsxB899uLPZ1hTkvkisDppib9xW9ejvbPUfdzZwzAgfxe3MzsVcw+XXh0a3oA+sku
	pkL4i1mjDJGQQ+tY+6EgYRpQ/18yg2Da4s83fzaDyNGJzArxf/oaSKloeJSub5IIfwEBWazn8yG
	l5Q4BHp/U3Ufumg/dqMxvySSWu5lfpAd3chW0wjdPsXD48KDlbkg0G39KAj615NKcRoCSTdnSOj
	cCdiGGfn0uR/ytGAqdvn2H8aEw2ZocOsaf92X18NvguQkeZQr/M5ClegUScowttbMC1/foKAMrX
	13JbRBEt8zDnQ5YAA
X-Received: by 2002:a05:600c:821a:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a1803112f1mr35573575e9.14.1791376494096;
        Wed, 07 Oct 2026 05:34:54 -0700 (PDT)
Received: from [10.148.83.18] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1787e7792sm141655035e9.0.2026.10.07.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 05:34:52 -0700 (PDT)
Message-ID: <364f670e60754319fab25302b2b49e3269ec49da.camel@fejes.dev>
Subject: Re: [PATCH net-next 0/3] Report netns cookie in FIB lookup
 tracepoints
From: Ferenc Fejes <ferenc@fejes.dev>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, 	dsahern@kernel.org, horms@kernel.org,
 petrm@nvidia.com, rostedt@goodmis.org, 	daniel@iogearbox.net
Date: Wed, 07 Oct 2026 14:34:51 +0200
In-Reply-To: <20261006155454.853588-1-idosch@nvidia.com>
References: <20261006155454.853588-1-idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-06 at 18:54 +0300, Ido Schimmel wrote:
> The fib:fib_table_lookup and fib6:fib6_table_lookup tracepoints do
> not
> report the network namespace in which the lookup was performed, so
> lookups performed in different namespaces cannot be told apart. The
> recorded PID does not help either, as lookups in the receive path are
> performed in softIRQ context.
>=20
> This is a problem, for example, for netns-aware tracers [1] and
> multi-ASIC systems where each ASIC and its ports reside in a separate
> network namespace.
>=20
> This patchset reports the network namespace cookie in both
> tracepoints,
> as commit 27cb3de7f43a ("net: add net cookie for net device trace
> events") did for the net device tracepoints. This allows filtering
> lookups performed in a specific network namespace, for example:
>=20
> =C2=A0# perf record -a -e fib:fib_table_lookup --filter 'net_cookie =3D=
=3D 12'
>=20
> The cookie of a given network namespace can be retrieved using "ip
> netns
> cookie" [2].
>=20
> Patch #1 reports the cookie in the IPv6 tracepoint, which is already
> passed the network namespace.
>=20
> Patch #2 passes the network namespace to fib_table_lookup() and from
> there to the IPv4 tracepoint.
>=20
> Patch #3 reports the cookie in the IPv4 tracepoint.
>=20
>=20

Thank you! With the user-facing changes given net-next is 100%
justified.

I wonder if the parameter passing itself, e.g. the line
+int fib_table_lookup(struct net *net, struct fib_table *tb, ...
can be a standalone change. It would introduce no functional or user-
facing changes and could therefore target the "net" tree, with the
potential to be backported. Pure kfunc/kprobe-based eBPF tracers could
benefit from that, with the downside of introducing an unused variable.
I assume this would be a hard sell, to say the least :-)

For the whole set:
Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>

Best,
Ferenc

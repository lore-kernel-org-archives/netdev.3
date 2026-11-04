Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800013;
	b=i0AK4GiNy8NMnuqDp/GvTKeXvibbZis6DZKTvzBbJQ5d3rchl4i2+EbL+CFwWnZZTyUT
	 NQd1eYP/VMDs5CcRbqgD+t0RBu2S12YUJsTbNaQr+CW5gRY71ofN0kEt1cA5vnlxLyS2G
	 QOFS4Lhwvp5IozelYa6DMoPG0QiZrgNy72xwyqr8gxEihg8ozhBx2m02IteKN3gGy/5Pp
	 oor4hZT5SzJ/8MBYhw/v3HjnCZF/ZvmU2H7NQyoRleULqcEw0zvc++XXnI91u7xo0avCf
	 rDWvZxA7uwEw2yqsEFTE1oJnyTGd0PbsIViGetMXSOp2+ZIvKS3C1cO9roHEwfazYAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=s2YgA9eXRC7gTaeTWC5JF61ATLOugSgGfmlk7hXTAN4=;
	b=GyzEvJAtZznVRvtlFguK3G4E+TNMVl5WVQeo/Q4nXquyw0BzKjyXGQ+LHfaHvOmmAlrA
	 5c4tQoFOTs6ZfYcphjMTn8Be6/ap5cD4CQ1dajKPkp/xxDs1vNqxOuqn9P7iqHm+MB6st
	 pzovOu0fyqikjYLO521BjX7HDAB2aghZE8nmA4bgidpfVhSiR5edIouvg1GNhyVPvomTn
	 Yj+rHnnbOQGUjTvgE3BOxyiwwqCC7PH1PMvBx+QQFSta9RjWXbJx3c0skajACJof6MYlU
	 rY+fat6y2+o/yWtLRxyCPx46xW241j0L8kmxDG9t59GBV4CVKrHvX7k1iHpzqs4ZM6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YikxubsO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DA606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 174DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YikxubsO
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so1249930eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 05:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793800012; cv=none;
        d=google.com; s=arc-20260327;
        b=jYq/gGRMO0+vLPPuYFgDwEBo4OCANtq/fNkuMriHBGx4zjY3gZ6DLHQPqgPl6g8y8c
         4iOKZzB3RPgY0oGLvVpt/3PjzUEvjCiwRzVeC0AyY6yi0NLk6A+86ek4vQj/bHApsqLe
         X7o6T+gx9t4YDBe1e1QltfMop51qz2WOoKrL6ix4X5Gg3hpZ1LciIbolLv9LMt/ldEHW
         XxZPt1lc8Uzx8hn3bNdujjOarCuF3fQ9+6KysuCTi4sTlmyWXZJbrwnptE2bMsbPt/WF
         W/pvzxbW0j1BmkGqX29cisJEVLXCZOMFtkgmCvzr66gn2OG9Xo8++MuVQcWw8a/5iHH/
         V5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=s2YgA9eXRC7gTaeTWC5JF61ATLOugSgGfmlk7hXTAN4=;
        fh=jOysKt+mjky9br0dZi1wzGJl3NnfKfv6z898M2j909s=;
        b=MnXD3B95mPlPlwffYFZKFlVph/7xgK1ze3fjD/YldjcCnSkAU8w5Or9haOEC52xQax
         lcQqrV49Cw8QBAWfchhhf9GaCFhylS48NKFaI1dbn5WaUzUA5hKBcosHa2ZhBfJEky+9
         DlyIkKr2CkIUusj90s76y367IAsom2BFBL6V8Gp0u1b9gBkCgJe13Mo2gCRvtbXrst25
         sFKWFctGG8MHBeWJvsaWqa1dbOMzFLdIMGy38/GN//rSBzR1tDg0Fc68MnGDUsiYUH9F
         b8aVB3S0UV3GujSf7O1BiHH4mDHLqEsflw0EnMltDsFft0UXo2s6bKALd43eGElLboHP
         ydtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793800012; x=1794404812; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2YgA9eXRC7gTaeTWC5JF61ATLOugSgGfmlk7hXTAN4=;
        b=YikxubsO8EW9n9tgtdFn4dkvgSt2iwtCQEraYsgw8D71xlFrgPfYSMq1hxz+s/Yjg1
         zqBWBjR3tpfKTJp3ibtGGOsdlGdO0fIg/Fw75u5adVIyd6nT4MrAqrkqBttWuq2QIRUE
         QR0dtqTzhMsrcJDTYQeID3xZ46xXUUzKBbuN4ovMfy3AYPsFwO+kXzFOEOmV9oyNcJjX
         Eb195TYG9btwnRBpGYtGMBQWm0+FVOndqpHbUzqCF42cbCIB3MWYtCGL2WXEEh/Hlgij
         MgvY/5roDMeqGTyW2sjfSHVfdevj4KaI4HdK0CHCLq23WasgWMnFBeuYHVQ+E3fdsfSF
         jGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793800012; x=1794404812;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s2YgA9eXRC7gTaeTWC5JF61ATLOugSgGfmlk7hXTAN4=;
        b=xaN2gNoi41S6prtCQ8QfIzDmJmbZeEJodiVU26UCzs7H1/u7KvCu7HRrxf9z16T+TC
         tByo4+VLaEhnsfDmDhY7CkSXgKtq2LiEAAZ7Z8sX4wzJDdDSHSoteV/TKxsqCbf+xwfY
         r9aQVpBC5u+jb/myibIPlfz9veRSlyXT9aGsxsTOUBzfu+B9sMeeNjsxwHQ4xo+cHg/T
         +NEINCi2o4TavtUraNq2PiLFKziYF8VWZA0saWFnxHixH6ccXKbc18Eu0LcOG2roAGiS
         0mc2WN6RHyE2tW0LcUDEBIrYI7YfKd9ncaFO/szlNw87Dtdt/bJNT2ekkitI75QkKE/I
         vkUw==
X-Forwarded-Encrypted: i=1; AKwUvBx5sGRQuGHiFKFLbKhZ0rIaGEw6yTi6D5XiSn7XuOW4/zm2rgC5kNOa82tpAMuYrPSP9P38ZqU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e3Snls0rwJMmdADJ0/SHe0xOoq5X10CL8kYTLIP4IsefAhly+
	H/nEkM+mBoj81KphBJTiwtW9cixxpywvKEu8I1UHuzbSCWmVnVPuF6n3NEh4wi6MuIzDcJ8YEzn
	9FCarMz7z5LepvSqg22TA9GGoeIIURxE=
X-Gm-Gg: AYBFou3XhgwEA6AC+SEJeK3+nh0EdFz0Gd6i/RrFDhHPvxre23kz+MQNepex2LCw1Kb
	udKXcrbNI1cz/TMH02KL+DMi7x7ycRvAtT8ZCCXDWdTZWNT2hyOqMDjtst1Lo0FMLY595Yo2AQ8
	8kSZOungqBcK63PaHFM0PK8N57jdgGWcxPIUJLxNtvx0/toeWL4ZXLBi9WPqntapq5DIHSbraUR
	YtsZU+MGBiUaXL6CshPke3CUvdTKmbPPyBJg3ffZ+M7UevMCP32rrJ4qgAs64kRRVPk6Aap1LLH
	P0BrDjC+vSAfWUiFyTE5Z5tzJW1DxvXV/zcFP09Id2ZoSpPisP55y2nhZnD4AYLzdsntk9SDHHV
	AfYkD+/cW2SakQ6s8c1YfluNej83QNyspYKXVcq4WOW/nwbhpq+ur8PvK/OHeXxPdUfRVSmHAiQ
	7c8Ft+bTON+L9LnObcJtzhOFQ39XdEiekngSUFNMoc6y20jxovTRh/dlAbYsWyGZPBIGhs7Kl2g
	I3bdt0=
X-Received: by 2002:a05:693c:835c:20b0:36a:30b:5dc0 with SMTP id
 5a478bee46e88-36a423c338dmr23659532eec.24.1793800012108; Wed, 04 Nov 2026
 05:46:52 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103165419.687806-1-sashal@kernel.org> <20261103165419.687806-6-sashal@kernel.org>
In-Reply-To: <20261103165419.687806-6-sashal@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 4 Nov 2026 13:46:39 +0000
X-Gm-Features: AclHuK90WkhgmJhmU6xdUm7mCsob0Cru4i_Y_AMzLhb5jcxjClGipAhE9WgIpYg
Message-ID: <CAJwJo6Z9qvw4Mig8Hs=dhMyjnZ5UPS6sRbKvnfFVqkoX1iFXgg@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: tcp_ao: make the netstat column
 pointer const
To: Sasha Levin <sashal@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 16:54, Sasha Levin <sashal@kernel.org> wrote:
>
> lookup_get_column() stores the result of strchr() on a const string in
> a plain char pointer. Since glibc 2.43, strchr() returns a const char
> pointer for a const argument when C23 features are enabled, as they
> are with _GNU_SOURCE, so gcc and clang warn:
>
>   lib/proc.c:61:16: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> The pointer is only used to compute the length, so make it const.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>


Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks!

> ---
> Found with gcc 16 and clang 21 on glibc 2.43; KernelCI's gcc 15 builds
> show the same warning.
>
>  tools/testing/selftests/net/tcp_ao/lib/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/proc.c b/tools/testing/selftests/net/tcp_ao/lib/proc.c
> index 8b984fa042869..50062b527a393 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/proc.c
> +++ b/tools/testing/selftests/net/tcp_ao/lib/proc.c
> @@ -56,7 +56,7 @@ static struct netstat *lookup_get(struct netstat *ns,
>
>  static struct netstat *lookup_get_column(struct netstat *ns, const char *line)
>  {
> -       char *column;
> +       const char *column;
>
>         column = strchr(line, ':');
>         if (!column)
> --
> 2.53.0
>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430232;
	b=gOFO0UMwmfHOzDS9qeIRIjKzYStncICEV5kzY0f/zWj/TRXVNoe8pYOpWHswOnIBbR46
	 lt37M5ffydmmszVryPPoRN4gBfyCmTjRSJ3EJguDBqYMnkMkZdsLZhoyxxWU2Q1hq/HII
	 /2BlO5Srczfa7Iq5qdJb3dbDY/ee09RJBZFB4J2OY+ExaH+hr82YYbFIW0Fu3+MUtRNax
	 yVBt+c3Fy9OfwDkjfeGVCST4myyGwPnX2sWgXEGxgRa5Ph+9BTk1PAtECCLAUJS9Ax1ld
	 c01V5cy/7oj+3Py7PZmMvwaiHLa+dmMxvguANT5oO8RvddKjqzV5zvaxYypwudSmlxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hp49m+PlmWDptABb0PwnQYI2/1Zwbtqs0bt0NWyh6Yo=;
	b=S2ARpIn3Xl9lOLX4S8BRL+t8mVsKMbN3/UmoVr2yyMfMnLQxVg2uNJDxK+9t5R5ugxHE
	 +eU+ZVsdaE+PR/VWTIauyt8Niy3u7Ll0HLxg8DqL2f+6irvXUg92LsRKDwezrs26rQevO
	 hfG/ppaGDCFXfXeY/gd34JZbgFCIsHNDZWZmlsr0US3nq7Z+2czEpOs3iblB7LbJvl72p
	 aQWR8PgepTVxtm2asxSW+KFSsjcWCu0YR7KrCOlpMWTVKlzr+AuXSYc3WdT4cf8/xVYwC
	 J0xPPvjh7ZK6yhDIh9QbOsjq3YGOM8+/fLEuA4+ju/WuJY93Vo6sePgLpjQdQ8WPKhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Vz50jCiw;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7543606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 07:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7543606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=Vz50jCiw
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48bbb06e746so645792f8f.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793430230; x=1794035030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hp49m+PlmWDptABb0PwnQYI2/1Zwbtqs0bt0NWyh6Yo=;
        b=Vz50jCiwmutBeV363EBZSdExKVPSOYpLovNtxOSkkSBzWmKtijM9cv0xnfLinhLFem
         6bMDI1kwHFldgnlCxCPZ1KY6kGF9JVh3gIvfmZj7DK0NiRFDBW9uTbOS5R16oUx990En
         s2TIgwJebIP54DV2Eb7A5Ky3xzs4qGhncGfeDQ0bfPD/TCD0zN5saWKJMwXaOIuetbk7
         VAo59PmExaM0TjUu2cHTVo3e76oaCqwTTLUxKnCZwG3XTPo5uS9vG5rKnLHCKmbXnrZs
         +2M7Be+FVbR41W42Uknh+ASbZ9lKVv7Mhxe4C2fkLw5xjuVr3NKDf1FEnLIehCD7gLtW
         usBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793430230; x=1794035030;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hp49m+PlmWDptABb0PwnQYI2/1Zwbtqs0bt0NWyh6Yo=;
        b=drGWSL6fZHkNHzB4/YBWJs0yAH7ZBHe+6ho4RG3kFcBxUy7ppBlrl7aqwzzrYQ2Xul
         Wn9QiWtGuO3gXdop77T99QK5ATd8e9yeUzNR3PgFloUS9A3XR5d2k9HVOwRVcIH7QpfB
         h7R9iWsm/D891Im/hvbxPQBF0Q7egmIti9kXJR+YDTtdHErX9TqcVrK7vpSgCHNeOVI7
         8BXiVgaFZNi20YA5uvcJZKCSXE3MSfuR6BJmhlOESnbQM3BYK0r4SoBrS23WUKDfP9p9
         ubzP4p2ybvdAbEuHudesnEH+GsJSBZG3lswEBVqkHz1CJm03QhzAY9naHETNMjZHagSX
         fVsw==
X-Forwarded-Encrypted: i=1; AKwUvBydfIxTOXNFKQHSdcYLYOGFPxt0NrKaXfGwemAt9EwQTBla+JzU87nfHR+vme6HB1I4MciFW8c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz1awZ8NXCs+hLuKDJXCFnfc0Or0JoEj0fnkVsI6WEoJ1I8nUa
	Hd505TXQZ4gKvnFkJNrxAU4yQX5nonARk5s2oITRUo4tj48JLEcJtpzalnI9KaA/BEA=
X-Gm-Gg: AYBFou01DbLe3hB2hCVruGu3tJ1XDlHzdBbthgJ6C7D/jn/y8otPIt5k6uyV8xhj24V
	tTGLoukkJPBOCBHM5mrk7I8WJG58YSgtVaT42LvjJo6xzp2yjmSnjEfbJ69aXwcp/IqCWmVBDq8
	D+6fD1c+c9dWxtxMEYN+Rd1fQwlZlbgQYL0EvtXc4ueFUxlAFgU7mFUJK1MWZysyAFWBFyjrPSa
	cgVCbC2VWllk3lTBm2616NVx6DSaWgCP6FdYNRMZ3PXPPGvlM84ihEtg5wPjKgZ8bIycVH7qQOg
	nU3nwAfWI6OQaRxLEOEiwZhTfMj1JA7Gq+hnoCDGP81C/ixG08jZjiA4wgwC6IoQZbdvi5uG1J7
	w8BqOFEA0mwuve8ELzj++aqamsNtno5Cjrs+HrmK2XuMiRBHsz8+47ayme64aoO4PDpaOs8XBH7
	SODixrwojW2MiyBw5njucSgD4LL0BK5tGQxJbpoe8+Ajt3c0f90SXqhS0SsX6RqW1WCcAnzAlpv
	Qqn1DBKGE4fMlqHh8Dlk1LwRE50QXh8THzPQPdCDQbMgfuO4QRFNuxtSrXgk+uqt2atoTPPMtzT
	tbbLUDaPEFaAo/6AMrtuof0Df8nKk3PaRlrlcIQVEd//zPJwCIPhhz9DlYc=
X-Received: by 2002:a5d:588e:0:b0:48e:6bbb:c3f3 with SMTP id ffacd0b85a97d-48e6e2fd071mr9785683f8f.28.1793430229695;
        Sat, 31 Oct 2026 00:03:49 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm7181698f8f.27.2026.10.31.00.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 00:03:49 -0700 (PDT)
Message-ID: <78c8a252-5e0b-4a38-8dba-125c0dab8ac5@blackwall.org>
Date: Sat, 31 Oct 2026 09:03:48 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vxlan: Stop rejecting dynamic FDB entries with a
 nexthop ID
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org, sf@techfak.net, stable@vger.kernel.org
References: <20261030133750.28668-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261030133750.28668-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2026 15:37, Ido Schimmel wrote:
> Commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
> nexthop id") started rejecting FDB entries that point to FDB nexthops
> unless they are configured as "permanent" or "static". The intent was to
> prevent such entries from being aged out by vxlan_cleanup(), which runs
> without RTNL and can therefore race with other VXLAN devices that modify
> the same per-nexthop FDB list.
> 
> However, FRR installs remote MACs that are behind a multihomed Ethernet
> Segment (EVPN-MH) as dynamic FDB entries that point to an FDB nexthop
> group. Since the above commit, these entries are rejected and traffic
> towards the corresponding MACs is flooded to all the remote VTEPs.
> 
> These entries are also marked as externally learned ("extern_learn")
> and are therefore skipped by vxlan_cleanup(), but exempting externally
> learned entries from the checks is not enough: vxlan_cleanup() reads
> the state and flags of an entry without the hash lock, so an entry that
> is concurrently changed from dynamic and externally learned to static
> can still be aged out.
> 
> Instead, remove the checks added by the above commit and make
> vxlan_cleanup() skip FDB entries that point to FDB nexthops. Such
> entries can only be configured from user space, cannot be learned and
> cannot roam, so there is no reason to age them out. The nexthop pointer
> of an FDB entry is set before the entry is linked and is only cleared
> after it was unlinked and an RCU grace period has passed, so it can be
> checked without the hash lock.
> 
> Adjust the test cases added by the above commit and add a test case
> that checks that dynamic FDB entries that point to FDB nexthops are not
> aged out. Without the fix:
> 
>   # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"
> 
>   IPv4 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
>   TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [FAIL]
>   [...]
> 
>   IPv6 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [FAIL]
>   TEST: Fdb mac add with nexthop group and extern_learn               [FAIL]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [FAIL]
>   [...]
> 
>   Tests passed:  44
>   Tests failed:   6
>   Tests skipped:  0
> 
> With the fix:
> 
>   # ./fib_nexthops.sh -t "ipv4_fdb_grp_fcnal ipv6_fdb_grp_fcnal"
> 
>   IPv4 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
>   TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [ OK ]
>   [...]
> 
>   IPv6 fdb groups functional
>   --------------------------
>   [...]
>   TEST: Fdb mac add with nexthop group and dynamic state              [ OK ]
>   TEST: Fdb mac add with nexthop group and extern_learn               [ OK ]
>   TEST: Fdb mac without nexthop group aged out                        [ OK ]
>   TEST: Fdb mac with nexthop group not aged out                       [ OK ]
>   [...]
> 
>   Tests passed:  50
>   Tests failed:   0
>   Tests skipped:  0
> 
> Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> Fixes: 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a nexthop id")
> Cc: stable@vger.kernel.org
> Reported-by: Sascha Frey <sf@techfak.net>
> Closes: https://lore.kernel.org/netdev/20261028142928.GA8406@techfak.de/
> Tested-by: Sascha Frey <sf@techfak.net>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c              | 14 ++------
>   tools/testing/selftests/net/fib_nexthops.sh | 40 ++++++++++++++-------
>   2 files changed, 31 insertions(+), 23 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


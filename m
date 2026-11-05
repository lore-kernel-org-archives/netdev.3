Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793839672;
	b=vgFw7ZMSO/UTB7j5hn60TkVbudbzncHXGEaHLhtAIy1R7S6gqyciDMKqkIyZ6S/ZSPNZ
	 NjbRledXruVyOsFfokF0AgCM04V1G8OUx7s++N0ryGqCkw9aaDMClGi/nMBDrrBy1BZtG
	 +hCxwGlF8JKUgN1xq1oTunBinrWJpS8lnUvu5cV3V9WdapS/gwEq8QOVavpPKH9zsHRIE
	 n11YmuT+jzsTfs+ZLi+N8D18FmClyol8N1qHqz0WFJBMKRWna8dqW9J56j+D/D2h9Zmiw
	 Irc7NZ/JminEkzAj7VqFoYvwc0OMjf+HMOcwlrzUaOiYkvSnwMEPrUn+iaXq/acpFqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=q2bMGTlU38WOqEBy2BRm4WnosFb6mvI8Tp4cHwPDAPE=;
	b=Qie4620Rkrng5fa46BgFsmPJ8ECmiw+oSmZFo6FNUi2jsrfD4Rb4gBhTMOWz7MrzKt1F
	 3A3bNV1m5jXNua8ZrMi5VeII/0WpF1MLgBHwZO+hdYYFPSxHoYhW7F7mLylt6hgYtnVaJ
	 7HUGOqFJUvgnLAdiWdrskbpn8iucpNOVFgudBz5eAhQKqbZEO0uMcs6oE/bCc0PFAGBlT
	 0UX95tLcw5og3JYOHcIWsbLhj/NMYdCOqD7oylXrmWjWF0dKy5Q3HUjyHe6mXpYD9gV8K
	 53lGDMP6rK4iO/+OEfCVOqCbwMVpqtj594aIACyWRqZ3jfKAt+nGuLEp6wg9RjWBAIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=WOXujqGQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA445606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 00:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA445606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=WOXujqGQ
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4N2M3H2263960
	for <netdev@vger.kernel.org>; Wed, 4 Nov 2026 16:47:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=q2bMGTlU38W
	OqEBy2BRm4WnosFb6mvI8Tp4cHwPDAPE=; b=WOXujqGQBIWho3kTZpwEYK+MQqf
	YZDPcu6SxbAWzCaJf6oW35PL8Q9BBvW02C8tWty9i2RfSiXdn5ek0kxJ/+iK4OS3
	ARMSIlRl8M5aMQWhIjAAk8gMQPdmf9DD4pUWWwMfAhMO4ys2IxXffwDcBIQrjFUA
	Au24UbQEVXURifRjWcVv1D+C09k6qevRb7nsivQ10vBVp7CaJKzLPGl5M7pj5PRU
	T4jAi4iaPdSKbRC5Ma/gMKMwZued6QuoirgP4MfRFFx0vEf39OnQVL3+IQXDGZGR
	QukslVSQ1jAw9Oa46o0Egmjm15mBmELbUEZaBxPqALeHQRJjuLBl/i+Yp+Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrb4ea6ne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 16:47:50 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so1566014b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 16:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793839670; cv=none;
        d=google.com; s=arc-20260327;
        b=iqy55zssDPf1PzdtXhM/+R8kFi26A8EUNvaze5NBlpGtWNjJcGJml/AsrrWf01p+O2
         rZNUGMHGCH663oYekZP4m1aUS1b7jICyjHzLFgw+dJ8Dq52W0IN+TU4U5e0q54cxtYjR
         NCR10Ywmk9cXtlsBpCkLoWUMLj2bPkrJlpzBlqg44zjeYWgdZRjwEUeOnOmVtRnUlpgL
         M+Nmfa51cesYA9AfqkvJrB8fP5DothSqDVOJ92rIfNE9yBddJ6ZMt14B2JnAehSQNfFQ
         ukqx514D4kUHtpZ5Vq7MBVsqFOyLVJtbobjh5kIG0OB4nW581WBXFCbsIoWn3HBu0nXU
         7t1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=q2bMGTlU38WOqEBy2BRm4WnosFb6mvI8Tp4cHwPDAPE=;
        fh=xxwFCtZ4YjG0FFbPSfg0hBw29cYwQ2uAyx9od4CEFgI=;
        b=ruXm7ndbmCyl8ZFKIzVQesw7zuoTzB9cSQFozSk2Vp/r2LS0uOfoj81TQ3cleEZFy5
         dMXVjD+7DO0TEYtCQU8uXDI4MTAvBd9NW5vWqYJCFZF1yCZQQzN9DtjsdcUOuHqrRyUZ
         Hu+wFmh0m+LJGwT5qy+mK7wBoK0TNFzPN19+atyXfnwtmGD6mIgA6NznZ2VDdZC0Uofc
         1EfM/IXisv631j8UC2h3QXb/FjySbjYRDNCYGAbF1DufQfC+9i6bnIeTW7Oq4E/D8AGr
         dJQ6KFSSiee96Pns2TejQsKBsJ4ZEzS/9asMye9mtt/rULi+z0AR3CCOqclMFHP/g+R4
         z4IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839670; x=1794444470;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q2bMGTlU38WOqEBy2BRm4WnosFb6mvI8Tp4cHwPDAPE=;
        b=swxZ6glUD4OzYoZDxhghAukrCKponM8QuRpoURM0JfSD4Y4DYzNqH2ho4sniB6pci7
         I/o0V35NNfATczXJa7y5cJVF0poPC/kK5F+OwIDewcBET63ki9q1QgF+y6iCIbQhq8hI
         D81koUCt5UZkgF7mDu2cMtQN3vfeV+LxCdBJUVG0UaUUOT0dkndJSQuHrRgCDwdeh00B
         Tj+FtAS2otl5WmTOXDuabld5VNy1y/NxVhkTJ5ilhNV9kyc2+e+/bzdrzipBwpLPw/TZ
         sEpRNi4nfn8/1WP84DIuPI2w3nDP4d1p8f64a/QRcPGlvHIkOe+vMbuEZ0D6DTS1w922
         2RCQ==
X-Gm-Message-State: APuU4Z9LtJYmYp+NEkzpYLUpK8uR88wXIu3l++2PSK0+3yxpUmHSpMwH
	8M0FZmCmlrqanpXaqxqIglI5tMpHV42H9TVFT/xQQ8QfhY9zr+/Rq5hpSMV6OEzYhPDWwHvE5aw
	CswtbgWQmGDgd1Z4FcIx1t3pGhZXRRo7Xn4sRpk4qthoE6To8WD2Yn9Bs/ml2Z7bDfmOU5CbomM
	qsAWc/1X+Pztiiolww6nJTw/rEuLYldoU=
X-Gm-Gg: AYBFou0s6JpoOUX5065desH5ddcQMUjRrW9tkbAYhFPT/fyPNsDFue/S5qiwVHqPILB
	U1KYD32IWVKZjFjyzbEpqmzban9PDDQhMGhgbL2GVKLyoFlEeAbCa6iQ6dni88YLCx4HdLlasRO
	DYs8n7ugD0j50xRprrcJEW5tPpd5AqXI0VVb9ZlTE6aWepRkaqUhIyyRkPqq6QiiaocN+9TXCHl
	GA3S2y3VvN7zvKBXOlAhrNRdqo6Bkc4
X-Received: by 2002:a05:6a00:4fd2:b0:8a0:3ed7:93a0 with SMTP id d2e1a72fcca58-8a9bfbf0a0amr14775279b3a.48.1793839670199;
        Wed, 04 Nov 2026 16:47:50 -0800 (PST)
X-Received: by 2002:a05:6a00:4fd2:b0:8a0:3ed7:93a0 with SMTP id
 d2e1a72fcca58-8a9bfbf0a0amr14775265b3a.48.1793839669754; Wed, 04 Nov 2026
 16:47:49 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103001143.246081-3-toddfreed@meta.com> <179375308359.488856.7259635335257893530@kernel.org>
In-Reply-To: <179375308359.488856.7259635335257893530@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 4 Nov 2026 16:47:39 -0800
X-Gm-Features: AclHuK8T1WOJzYaMW0E_U0iEs3j7pEqPqjrR-Cu0O1wmwkj-FUcUMKMe_4oDLbE
Message-ID: <CADh2yMwzPWZa2x-9DbHpSsn8HbOwwwAefYKS4sPxFWOX3EmZ2w@mail.gmail.com>
Subject: Re: [PATCH net v4 2/7] net: don't fragment decrypted skbs
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sashiko-bot@kernel.org, kuba@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: uGK6HU4mu5oBgJzKhk-Tdl2hMdItBYyM
X-Proofpoint-ORIG-GUID: uGK6HU4mu5oBgJzKhk-Tdl2hMdItBYyM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAwMiBTYWx0ZWRfX3VdZuQPCmLUs
 Hc5MpIgOJNJ2lgb1vBtvwiWR++jsUuk91Upfml/SeiB1OeeUwnVrfqxbLvk4Bim1hgtsOO6qc7l
 Raa2vzJe5QX76Xb+o48fmgINXY00Wag=
X-Authority-Analysis: v=2.4 cv=DJ8acCNb c=1 sm=1 tr=0 ts=6aebd236 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=SxMiDcZ0BD2t3rXD7HEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAwMiBTYWx0ZWRfX2QqVJhTnZEGp
 42HD8u/29Vny4OMPd+muL1hAy5l7lkyovdX2euZ64JesjFOYeU6p2yj73bziisP6/gIuU9Jur84
 dLCsES0JGNUeL93z9hr8ARLIz/gTFUNPSzGooc/x1ta3GhvbZ4upJsZYBPlOqscVcGYSNHGLxd6
 6gatAy0wt+N0eP/4jVx1wCeoG7fiADJ5k6XAbsfTpQBARV11vaunQzRsOMavPKihxWN4LtM6qd9
 sK7wRZIlFKdJPVa9cDvbKzVwvhmxU3x8lVz9Uad4c8jSGb574KnI0gTTlpP51R6cdJyIG4gk/vt
 ko39aJDQ/7F83C5VXGOFf2PzgO4NKjri6auRss6B0SGHqyxO412STRZrhXY1mh/mlPfS5YdJphG
 6zxodM0hMHZL+i1CJ0WCWGpUT6KUxvKZrzAzDZbCyecZKvuIGJgyWaKGFt0DRt/AQ+TmtnTkq+c
 M9kgbVpwn6Gpwu6GKNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01

> [Severity: High]
> Does ip6_fragment() need the same check? The commit message says:
>
>   an ipv6 tcp socket does not ever emit fragments. ip6_fragment() refuses
>   skbs bigger than the mtu unless ignore_df is set, which tcp doesn't set.
>
> TCP doesn't set ignore_df itself, but IPVS sets it on locally generated
> IPv6 skbs, for example in ip_vs_bypass_xmit_v6() and ip_vs_dr_xmit_v6():
>
> ...
>
> ip6_xmit()
>   NF_INET_LOCAL_OUT hook
>     ip_vs_dr_xmit_v6()          /* passes dst_mtu() check, sets ignore_df */
>       ip_vs_send_or_cont()
>         ip6_output()
>           __ip6_finish_output() /* skb->len > dev->mtu */
>             ip6_fragment()
>               ip6_frag_next()   /* alloc_skb() + ip6_copy_metadata() */

I stand corrected, and I have reproduced this.

Also, I think I've figured out why my local sashiko runs aren't
providing as useful
results as the ones coming from the list.

I was planning to drop ipv6 fragments in the net-next series anyway ; I'll pull
that into this series and post a v5.

-Todd

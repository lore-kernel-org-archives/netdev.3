Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727608;
	b=aDTbZn9+jmcxziWgL/Q3jaKhVEqIFJjLrSnIcGEYuz8RrdqH43FeMpavAhrrxQdbgK9z
	 5xHXYiMQc4ZOfSO5iIWYTyrI//JsbhhF1wjStkr/E/RrsQYA2htnFzfydFf4CAKS1fJKx
	 aWcMctNk1lkvqoz4ukSj30hrze9Z1pccmF+kV2byXfMXzhJ282TtzMlaXVJkxA8J1ubex
	 ex22zj28wq74l46p82iDLc5zZ9EOjEwKaIcWR3depmbLrYJRcUjLFlfSauD3D7MHksRgY
	 0ILVX/zg7tfYhkRkoJQjcVJh+b8Uqpy5UBcQrjL50tubVL8Ydfi/IDF4qtje6dFACVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=z0GygfKxw4B27PwG3wjW8LBVwALAwJtEQDPEKGZVDSU=;
	b=x0dIeEV1oMIbXozg4lkCMt49UT5bb8a5tvn7LOAcq6WbmY5wxnqNqSZ/iV4VmdLYQZy5
	 kLiy6DHyTXN4gYXgQOUAzQxZF0CEyMffkdeqcaVD7vRx3XT2B/GQyhp4QbUM0fS02WgYR
	 W+PPF0gcQ4TuD3BDfzn/ngkxU1FuPwf/HQrC65rqIy6fOzu9hVWMheh9ULQzNb8eI5qC8
	 IqP2Aryz95sshWPs7hBnK7Jng6xTF0VZjbQaczDUi+tInLP1P1u/6mKlwU7g5+KN6cpKD
	 0rV/A7joUEAwrl2q6phHDMuRmQGG7bucbFtbBUuITgqxL2ZLBO2yVktVegLjAQ6ofiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egji2Ggt;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA1606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ECA1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egji2Ggt
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so1925257b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727608; x=1794332408; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z0GygfKxw4B27PwG3wjW8LBVwALAwJtEQDPEKGZVDSU=;
        b=Egji2GgtKG8VkxnFY8MI7OhQDJQOYjTtc03HGW9e0YX04Mm9lrjtPi0Gp7a2LT/NcQ
         dNQ9qbVR7aj38zHNtO/eHIFry0UrPZ5p/4o8cG3V7LjI5J+fW/2ZlSImoNIQ91tjRwJb
         kR91N1plurobXIQ4JEDgVMf9l507Y7VOVSYKf4q2hV4F7jQ7SRYI+plm1i/JHfZ/5eJ/
         4iJeHBhFKyG8IG7zOr/OjF3j+HdKg8aZLqCK/rbVITTktDpYOgF/HvUZbQQ5jUCY34nN
         wVpw3RDmIRgiUArIOooIzABR6UBAJYJHbY/WK6GoZyK2v63CRpboh723SaF1/ZuiITtN
         o27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727608; x=1794332408;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0GygfKxw4B27PwG3wjW8LBVwALAwJtEQDPEKGZVDSU=;
        b=rilHby7285eOmdgHdEf/Sowg0i+C+uvbpFd4R/krvZV1blm0AVLDd/knSIeQqJe8Y3
         HizmuAzl4a7UMxY1WznTu6vnQmLFT1Np/0TZHH/AYmP4jcJNEyUTJC5bq2Is/lEKtnt2
         GSxq7A9YJ8LzNpvk/ui9j3N2Xv1mea+Y399ierAqg9RaHmrwFYjV77dLoVw9HlkQsVtx
         56v/aauiTRxE8HllvYCrwF8gMz9bNhIKDYnybXchZ5cHfzxbihyTc6kkUBmvjljmT2CI
         Tb74OPwGQwl+KTB9Ypcoee34RNAlp1+5QkkjAlEPuWm4btcqfgscj44PP69cLMcR5nwr
         KrpA==
X-Forwarded-Encrypted: i=1; AKwUvByISpz4D52XbDWWdugqEEqIBoOuOpJgWwJEzvOvb30BQcbH3/AHkE7c9GJTIFa+iSQBc1gbedA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OWRzBBJ2m5E2BKtunF6lnNbrH1DDq8LzhCe2i/6P98pSeTy/V
	FYqJxOHuMh6/7Og9K0JhqthA1VTY8woGQZgFKTHSptiEhPZANRofMGya
X-Gm-Gg: AYBFou22JhIh77vAw7S+oRupNEbJ0e2P8h90eQDooIl0Q2To6jnFXnOu/gDQ9Y6HUPE
	ZOmQboP29Rpa+nmHiSM+mlY3mu+C4udqh1kDW7q2d4gGoFGTY4dzveVVVBvdeAdz9Eg8vYCSoZo
	Hn73JPQkqGLnnoXo+gSHDpJGYXhOkvktuabjA6t0rdFhaaz4N4J7C18X5ftZEfvyz+HqcNx2zgV
	ZgJTzjR6WnjlOTztA7d34FtgbXAdNNFNtlxQOP+JpIX9c5ltpBFvTKnH58Lnkt0Ysdsw7pA1O1o
	UYq815UQPKxuOyPvc7gFB20CXkpmAMerLSE19koy0YCUrsbEhFRFkbbOY5MmgyC8kNx4wXf+Xvg
	3hFPkufuMp8t0gC7FTHavp3ZzXAojSnn1pVTPsrdyt77YTNhPzfNQQD7uw2DmYPfZt8lF5MoAfk
	OIwJBH1UyZ8raFh9RQ+mfPnDMawTt/J38UzYi7f137aFXk5jBrM4UMpSgEU/fn5X8IZ8viJ+fsX
	L3G7sLRsM6ueqFM133nz+jbU+foqK7cRHDruWTq2JECbh/V+T2JBw7A220fVMs69TseSfwV7BNM
	rZQZ80f60XqzcjwYVd+AQkzbr5Ab+eFpEXfKQVfHFaA00MFO5cenIAGUCWwOckWTwCoGjFd0Wqt
	kRKcz2+y8YZtaeD8ZpB3lIidJILh7PlWS/aczQyftncjyQgiP78IZZlSA
X-Received: by 2002:a05:6a00:290f:b0:8a3:df84:4c14 with SMTP id d2e1a72fcca58-8a9bee525bbmr10517197b3a.57.1793727606391;
        Tue, 03 Nov 2026 09:40:06 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d3603sm3435238b3a.37.2026.11.03.09.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:40:05 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:40:04 +0000
Message-Id: <DMLRD9KZPGMA.17182J5DEZ43B@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>, "Qiliang Yuan"
 <odys.yuan@gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <aunq4v24N-Gzx_n3@sirena.org.uk>
In-Reply-To: <aunq4v24N-Gzx_n3@sirena.org.uk>

On Tue Nov 3, 2026 at 2:08 PM UTC, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/fixups.c
>
> between commits:
>
>   ec274bb4665c2 ("bpf: One may_goto time slice per prog invocation")
>   1ddffb57b3623 ("bpf: Emit timed may_goto for JITed progs only")
>   1ddffb57b3623 ("bpf: Emit timed may_goto for JITed progs only")
>
> from the bpf tree and commit:
>
>   a7a767c66a2e2 ("bpf: Queue the rewrites of bpf_do_misc_fixups()")
>
> and likely others from the bpf-next tree.  Given the nature of the
> conflict and my total lack of familiarity with this code it seems
> vanishingly unlikely that I'd be able to do a sensible merge here,
> instead I will hold the bpf-next tree at the version from next-20261102.
> If someone could help me out with the merge here that would be very much
> appreciated.
>
> The conflict is:

Yep. It wasn't easy.
bpf tree is now ffwded and merged into bpf-next.
Conflict is resolved.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550820;
	b=QpVew9lujEp72ZpPs3q3ipueslxdYeUTJL1qxf+YFRH2RCvpxVtMi8g0vO43nf/bmLof
	 OaLI88G8a7XBdL9GdPhotUW57j5LyTJGAWHP3ckKSqP4GE3EF4lu5tQuIIfzUxNiMm7Sy
	 fOI0lL/QuqoGDD3VTQHVJ0CTsa79EF4JYmF61Q2/DlCov9zcbrdLuJRLddUuXXuZlUxm4
	 6f2pAR5hCovVQnil5o175ij0OilkezgwhWIgSSFkTLiFIQd3u8uifSgf3SNoEvAcSpETo
	 VlEp1hLOREWv+COPhlXF0l0JALvUYIpVkOX/AAxCGFJhb2tha6/Cd5g3hk2wYtFpQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EgZot4cG8TiToY4RwjEp3dpLWr4a8L5bEfT6alqSX+g=;
	b=EuE6dcbfEi6Fb8OOKfuL2/2GSDhrcJMnKctkH3frZ4e463Gyexy2txI9DU/GkiK8s8h3
	 lW4vL+p+LHTi/Q8dybAS9ezRe+NuS5AZtYb7a2NP9MhZ2I4KVAH9HxKePEPplb/AAzkP+
	 aNvKJyzeFM/Epb2bKuCoUgvdO2jXOaHIGbH/6qbZBM5HBO0/ZOR3r64ihJKHjigvPNrhQ
	 ESCMY3U91X9ubCPkda+R0L6M3CZqsjStzRMeW6o+zYIQHyaEuJ1f4qBl0pd3FJxy+BaCY
	 X701fY1dyulpGFhskSvEocRIiFU1v/Yy3MNjm/CzZS+uIOkJQenF0y9SiEaIsrf+/Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RORT3TGX;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF9606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAF9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RORT3TGX
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9d1114320so1613795ad.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792550819; x=1793155619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EgZot4cG8TiToY4RwjEp3dpLWr4a8L5bEfT6alqSX+g=;
        b=RORT3TGXeksmKLyeTIX6YMe8zeykxBfNJLTuCT/dybfkwNcL1Bis4Ff28Q36WL57SW
         lQiCna0je1bPu6u0QzyF/FhgGsmhw+noXwS5Jwoil8irPbw/JaLrsgMB3u3bPnf5uKh7
         uu2LIbFT87+v0b7tZz2R9k41ubWAvuDuOuuhmeWtzLDkdB8RaB83zNFkKm9Afk9OLcbo
         27Ukjt8e+0ntTDa93dVgeD32AZLzNiDqtm4D/w5kuh8jj/RygEGvpEa+uKHoFUwjiy4P
         6659nVBfSozasKSzcWfOulpGyLFa1PickaE7g9TsnFDlJZClLLblvksfnsVdk5FUt2NW
         Gslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550819; x=1793155619;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgZot4cG8TiToY4RwjEp3dpLWr4a8L5bEfT6alqSX+g=;
        b=wy2/rvHVp/ciEoCBIr/AigdI85tHuHd8CwzwXO4kTs3VL2ITu+eMU9SAceUNbJxIMS
         DOavW5yT94oO9PdDsnK+EoyqnK4ETXBUX9uqPulg7zZ9ZiG0QNzeRsYvGFpWl4dFDbUY
         FFtE4PhnJamngK3zgq6s6RFo2/xLmqJ7pFy/IrhODYEZI681Yl1YHR0l6aPnW8zSsRTn
         dF6o3EJED3Uv0Us3NLfIWUFW6JpPyDC3t0XSD/NrPYzRjW4e1NS7/8o/uUfM0lPYWFn7
         7VL7J8tKScgPHs8LZBvZO2xQsWeM0R3Lt5qpa+60ctBYpMNK94lWKECSi1XpO5yntERM
         Up9g==
X-Gm-Message-State: AFq9FYLnPHNYLBG44o1G0vIbnd1FaCbIE+odl/Pjl//ZYmMBphPvxw2t
	KY/B3uM63ftCsP6wKX4sBKtHWAHzHp5T0zjBUigfjrg6GGqhIOtItliZSaibBE1dKL0=
X-Gm-Gg: AYBFou3ruzRtvTtDnDaYYQb+XKeK1Q+Jg4hirtTr2NvvuVnjuiwrxYRXpuGS6gdCVjQ
	oDVTQMcUNkpijcbkF54qDyIKESW3gb1RaGJ1gc2gE16BJbKwQZAn6AOvJ9sVi1FL+RIlVqzXhIT
	3Oo2NflDLWYbMj6c0IrddHGHuCbWlFgMLJj63O6F903tcN/AG3MWYmPkCo3Au3i74EggxK0X6Lo
	EKtKZM2pVktbtlVvZFLfHfNY6qtdhlVLZX8P34gEtAgyrFnl7iWEd7uwg40PVQA9BQNXgLe3/5D
	5xCHfyh67/TGRvWN0UH+E9V94byAw4JXjwvXJamqekMLMoPZCLKs7X2EHRC53145bq2/eTNAMUk
	RECQEzJGtUjYjSaPuyJ9al2sBYPzyMe8lijornsRvd/uxZBdVvAdYwK8Vv6W3deHy+8OnkZN+51
	DhozL9YXvGszeKPyzk6sinQ5DHqoKe1mlQ82x7NXZZH5I/Xv98e2xtqi4qjToEw4BKX4nZYghgd
	BXvXBdsULqN6EcBer7lxU99eT4KYS8/7qS36IL1SvQzHBptgB2XLefIQOpCZc4WZIuZMVgQ5qxR
	LS+btkqqsePsojyKm1SB+g==
X-Received: by 2002:a17:90b:3c0d:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3ad86f60173mr636464a91.36.1792550819491;
        Tue, 20 Oct 2026 19:46:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad811c515fsm1771592a91.9.2026.10.20.19.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:46:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:46:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashanth Swaminathan <prashanthsw@google.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, maze@google.com,
 yuyanghuang@google.com
Subject: Re: [PATCH iproute2] ss: bound fscanf width when reading comm in
 user_ent_hash_build_task
Message-ID: <20261020194657.5578513d@phoenix.local>
In-Reply-To: <CAHdA9ByY3mTg6JnwaQ2ACKSvkKLCq7VZTf6ay9BfpdmmJ4=Mfg@mail.gmail.com>
References: <CAHdA9BwQPp9ciwB4RxUd79AOkcFo6gb2t52NTtWq_52=K15p=Q@mail.gmail.com>
	<20261020110642.218231ce@phoenix.local>
	<CAHdA9ByY3mTg6JnwaQ2ACKSvkKLCq7VZTf6ay9BfpdmmJ4=Mfg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 15:13:58 -0700
Prashanth Swaminathan <prashanthsw@google.com> wrote:

> No problem. I couldn't find any definitive source on the org's current
> thinking regarding whether these types of hardening changes, which don't
> actually cover a security vulnerability, are desirable, so I erred on the
> side of caution. Apologies for the thrash!

It did motivate me to replace fscanf there, there already is a helper
in lib/fs.c just needs some small changes.

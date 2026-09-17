Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947A4D0A06
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649848; cv=pass; b=EZYVe0VOpqUsP7AyhyAaaXJWqakV17NKe2UlGT/SUH11QmHPkARtOcfWYQMwTBynXkpuq9bFRHn+52j6B2b1ATX2k2NkxqzaQmM4ySBpSvy3+NwMx3kc/+oTN4P0ttN5MB32cj8+AP9jwSgsjRoWx4ggB6JvQIsuBqJ3SkuA6KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649848; c=relaxed/simple;
	bh=PLRC+YPuVdiOsxFxhTAyruBDsU02Q6zb8qiNkV7CRZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYvKz4z2lNjKr4IOQPGORyOSU7aawqvVfIkpg4n2pU038HSNfvuL9mh5vmgYcNdQKWbscgruDxPDowE7ILilad+SQt8jk36osKY1XhGalbDEUiKqI13jzAbHAsZ6TiLCNlMPADviZQ25G8jI4uq7ZgVOn2kI1r/yiyR4Hyz7AaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JjHPZRms; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JjHPZRms"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab19127so799825d50.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789649840; cv=none;
        d=google.com; s=arc-20260327;
        b=mmb1C1dJhhYpGaEv4hzwdNkW/TGTabtgwd7yk73TC6yp1rH7O1I5fNxRKZGuWeJAw1
         wcvlFyXDhptLd37qFS9CUW4RIT+QIfQec9Td7mpPHlM6+lGfkz9ZJRQkAXmvunsn56vP
         4Z2gE5tVcV6pDoQPJJ/RGnEdexduGgxSnfUY0ELdY0z0Gg4ojKXfcUxu3ywOdylbPB9L
         a5kE0v9IXBufyYUuNfpF+PDSDP3C5TskdQxRA1KGEPwMjMWbwh3UMHRHbpUyG9VLnOHy
         zmfWiITrFZF86u4FEcofQ2p9A4D8+F8iA3xvd7221nhi2clC+ADjg9uFCIuOEgCZz0iJ
         Ec1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdi5btpvw9YiPIa5m0HyVrwEa9ZxlyRkGCQ687PghRc=;
        fh=D4Kt8AA/9rfOcRfy+nQYG8YFGSb9SK5nt0pJXY6iW7Y=;
        b=aUmsxkdIbEW3BXdt7h0YjK0cMBB+e55NUOEasQNTVuHoWOQT0m/pNgdvOjqyzfmPUf
         ac+11aU/rcohRoiwvnhOot9I5NO2hZsxwzaZZecXaEUqmb0bGwfXcuRq4j2FuYcFbZ4h
         4fh2tMt0HvwjGhc8vIO9mYeqT5bvQzYPSfJY2zQzNDE/TuaNVcN7dAe2ApZzFztRwAQA
         VIYqxGSUEhsNHTc3ELw2ffvUuJogf1dBKkixIrfUAoQ09SX6K3WLgLcxX/VZaTIhCBuC
         LcHf9WN3eBw4ACrDQSf0a4Q5xozLwy5WBrF09Rj3bNve62cZj+9B94ssEVZP7OkLMpmV
         K7wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789649840; x=1790254640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zdi5btpvw9YiPIa5m0HyVrwEa9ZxlyRkGCQ687PghRc=;
        b=JjHPZRmsmqIqBLPQt8B9Yz6g/KvVJTqsn5s9TPH4WterJrAVcqYTqu6QxAh8R6FQ1d
         +pWk33E3U5HqWuJU5AI9OG8n+BaB1tL18TtDw4/7NrIxg9BHkNcth7Wp44ueWOZUMzQN
         oLecbPYIpqHv9R879ibETdO64g8BUff07CZmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789649840; x=1790254640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdi5btpvw9YiPIa5m0HyVrwEa9ZxlyRkGCQ687PghRc=;
        b=GCc0vOClTULT/asoaRiXj9h85eMwk5VX8iASojjpN/iIUkCiMT9Zx7jmFJD8DaBfr4
         kd0W/Z1Oj6SREsk+0NgMA1pjEeFgNevOYWV5rASyrUjzsRzE8aj3faCNLb7Qgji75Z6k
         TpGhv/533M8ssmWzANchMZKMBzT7at5Z++PasQ3MwooBnykdUpY6DNy54m13sFOBH/TO
         TUC4xEj2k/iV8vb8sILE8w/b9TMKtBZ7RmnxIj8d9J0aRXHCGbai4pXW/OBWbZqzSBH+
         kiRkeV0evGGrOq1uvBqY7TJDe8Hjm8wLADQAmjtoIk0DC0ZuFZr7pWfq8BR0J0wDZi3R
         MRSg==
X-Forwarded-Encrypted: i=1; AKwUvBy10ehrYcR10kIdZvYwuA+ucP94rvVv3Sn4//ZrSxSn2aauRHeFlEfEnikNTxtSQa4rpF4Dj/4=@vger.kernel.org
X-Gm-Message-State: AFuF++nQQ0YDdsZH8x7m5gg46DL6UWhR/vwIp78qtpzeFzNRTuATqG0C
	v2o/e2lcczzp3ai5F9dTjo1vNv1JoP1VVuRHldLW32bgXcDcW9HU+ePHbGRtxZIYG7jwdms/IuC
	udCQ9J8/+Ii7QzyJoPFJYQybaZu5oQWoquCc+Xu8n
X-Gm-Gg: AYBFou3DVb4oW725PSwjW99zCWKqE4hI/CIxvkLp91ElcKC+qbfDOPZrhm84hJj5Xmk
	Dbw2POkqhvDJZs6Ot9jdFcSErNTQ2W45qpbLfuAyDdOCSEPKcoHdGuNewnG7+IaZcE5vrvGip8u
	/5yafUeRsGO7FDoGSX8bBykUfYnYWr9UldyP6HtoQKuWVetxwKskyl9EjiaTX4py7qmuffxH3TU
	ETtzDcDSRi0+bmf5BiAYUqJJb/ryvw9xN/b0akuoZHviDDiXrfmElD626g/C3OgaN9uT6KRGOdM
	owvirOMEMURHmQj/NkHlnt8hwV7eofe5dm///8ZOmdN3ekbxpkbY1CnAcXgsIrbodSDITQ==
X-Received: by 2002:a05:690e:144b:b0:662:89c8:4a62 with SMTP id
 956f58d0204a3-671631fe492mr2200601d50.18.1789649840369; Thu, 17 Sep 2026
 05:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917124725.4127273-1-victor@mojatatu.com>
In-Reply-To: <20260917124725.4127273-1-victor@mojatatu.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 17 Sep 2026 09:57:09 -0300
X-Gm-Features: AcwNN1XIoM3UDdLma2qmD-soYXkUuXkoclqf2Wnzoi90BoRGPkG3wnf9IbSQ5b8
Message-ID: <CA+NMeC_c_3iDnvx+esQSYiOnirXqbihXnw0WE=6xz1Ss5iBMgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us
Cc: horms@kernel.org, vega@nebusec.ai, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:47=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> qdisc_alloc_handle scans for a free auto-handle by probing the
> per-device qdisc hash one handle at a time. With the 16-bucket hash
> populated by tens of thousands of qdiscs, the failing scan is O(N^2)
> under rtnl_lock. Each failing add holds RTNL for 0.6-0.9 s on a
> production kernel and about 1.7 s with KASAN and lock debugging, and it
> can be repeated back to back, stalling network administration in every
> namespace.
>
> First try the handle after the rotating cursor with one qdisc_lookup,
> as the first iteration of the current loop does; that handle is
> normally free. Only when it is taken, build a bitmap of the occupied
> auto-handle majors in one pass over the hash and pick the first free
> major from the cursor. The scan is cyclic over all 0x7FFF majors
> starting from the same autohandle + 1 position as the current loop, so
> it returns the same handle for the same device state and fails only
> when all 0x7FFF majors are taken.
>
> The root qdisc is seeded separately because qdisc_hash_add skips
> parent =3D=3D TC_H_ROOT.
>
> When the next handle is free, only the single qdisc_lookup of the
> current loop's first iteration runs; when it is taken, one O(N) walk
> follows.
>
> Measured as tc wall time on a defconfig kernel in a 2-vCPU guest, with
> an HTB root holding 32768 classes and all 32767 auto-handles in use (a
> no-op tc command takes 5-6.5 ms):
>
>                                     unpatched     patched
>   failing add, space exhausted      613-749 ms    8-10 ms
>   add after a mid-range delete      572-573 ms    9 ms
>
> The failure path returns -ENOMEM (bitmap allocation) or -ENOSPC (space
> exhausted) through a handle out-parameter instead of the overloaded 0
> return. Since either error is now possible, the extack message changes
> from "Maximum number of qdisc handles was exceeded" to "Failed to
> allocate a qdisc handle".
>
> This is a less intrusive fix meant for backporting; a cleaner approach th=
at
> uses a per-device IDA over all qdisc handles is planned for net-next.
>
> Conditions to recreate the bug:
>   - unshare -Urn (Level 2, namespace-local CAP_NET_ADMIN)
>   - classful qdisc (e.g. HTB) with many classes
>   - attach ~32767 auto-handle child qdiscs to fill the handle space
>   - the final tc qdisc add with no explicit handle scans the full space
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Vega <vega@nebusec.ai>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Sorry, -ENOCOFFEE.
Forgot to remove the fixes tag.
I will send a v3 fixing this after the 24-hour period.

---
pw-bot: cr

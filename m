Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560244C66C
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945248; cv=none; b=KkO2l7XM4XsGmUNkAeib0xfgRQkrmDA3WvX9Clf4zouTB/JHAnpF1oQlN436zXqUQUApvX66rqGHVvPVJhega2oX7mjN/M5xDbHfwPfsAbAJkHk0YJpqBVqziXCF33x+YOMqhOyHB4fgIX1mukKslP6fAqMUSf2YnN4sljxmF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945248; c=relaxed/simple;
	bh=4Jz56/laT433P4anh/93rQteerAAdqQQpM12fT6LsNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q020mJS/kIOUACeD1S4zhNMxyeMZ5VherRSWbtYyeCVtkCiQyB5APMtH7HCu+Yv9qDuAmBD4KxiHTNysSgFcjZoXLNxUWLrG6L2b0TQXzVBH9ZqLoGY4igby1JkB+0jjSd/+rQhtUzk1bqL3YRky6Ug7FkpNZwKUG47NvTWo6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SXYYgXgZ; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SXYYgXgZ"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6afa5b9150eso578081a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790945245; x=1791550045; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Jz56/laT433P4anh/93rQteerAAdqQQpM12fT6LsNs=;
        b=SXYYgXgZECpp2wEM2gWOg8sX39egbNDCv0pBYGhKknAzmfznT5H73nDyGm6bhtYTNQ
         HYKH4YoQhRKhxOY/HmPbIxPy+CpVSsnymj3ARAwtyRUDvPo8kiQr8f5iKqJMkmtzno5b
         cuHtRn/PG1j3PEQIqymgfnkyOEYioSNt/pM4FxusHeSnaduKupj2f76qtWE6mBXAIRZ9
         6AX2wdUHkC8alaeeAzMlaY5BySdLwvdEiUH230vsBMN5LOaW085Z5FuC3xb/+xqCG3ez
         7ZxRZofAjuJ1Tle9C3Gjqx1CPcS7zbZ7JfbRarqA0ZXnUS0FkErvJL2tom29pIfszmbB
         1KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945245; x=1791550045;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Jz56/laT433P4anh/93rQteerAAdqQQpM12fT6LsNs=;
        b=HXuATQlLiqLw435jDxJA7M5tGPpNrOeZuVFF5ZkyLRmxud6P1eMQU2XBdvOKnjwhCJ
         5qQxpceSxAa9896q/Q/y57wbv5s1MQFz2hy4AHhFtyfurkh0W2TtyLJ+ptL5EnSnnMrR
         ztla1L7nr8USmISMRLJXZTl1P19jdmMJgTgQge14RFHr+pfAASiIgNOxvgFc1ROU4Lx9
         5HuMaNgn4lgWJ5vzh+n7ztZqtiZtWBoGAF/nuUb0Bkfpb/6UPvC0tkyf1bhSUNoHsFGv
         PkdaJfJqKHW8eIUydyeFRuH4klpbbL6U5O50CJxwaUWMehkpg3fnz86IN17lMdTCH+qw
         5oGQ==
X-Gm-Message-State: AFq9FYI+SOuR+VohFVfqri/mhiTFXnqLZf7aUA4gGCsVKsjlUvh4sD7/
	VB+z4aQNGgk0LLu47h2lFiNYq+j22U584XnkH+ge3HyqUQ67fN44H9mZLJtDG+jmefM=
X-Gm-Gg: AYBFou041+Dp0/FA5rsttzXdwn2fxFoKlcQzpmIX4j/t0BCCdOiG6MdFdtjC5h8FVoB
	6npTLCtTGr+Eg/W/vo/mr9F26/hS/RdrdnO2r9MVePSHYnROBtJ/7gikryk6o95BNQ2skOpWJQU
	dpS+Y/zZ1+mkDP495UEpiHsZ3UkNqNMbBj7GVbZMWNqBQebWYq4ro4Rfck085rG4ewrAgaxmoGo
	7xDO5pWVYBv2RY/e/af2UyFQrS2f90ye6ljggAKiBVc5BQ4pKUOE5STUU5P78sYAe4HmsOR1UDh
	Kvww+gZPNs7f/0qP9J+sOShklR+oy56a2YyCT18ZffuXniaC9n3MhWTwuX86edxTz3A9DCiTSRv
	Wb8+hd5/rXfIstsVwwPRfL0QZZ/I7O7LNJqeC61aP6AS7lOASkf9SUBJkY4E5NrsfTBkAai2LdT
	NEtTKIyrkrEOFnMuu92ilWtxBd6cKQ3jlVYoVS6MawISny2nZgkgW2x9g2/eEw3ycYv8HDDyUK
X-Received: by 2002:a05:6402:4559:b0:6ac:7868:b690 with SMTP id 4fb4d7f45d1cf-6af9e2db806mr1359841a12.8.1790945245011;
        Fri, 02 Oct 2026 05:47:25 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9dac29b8sm856349a12.36.2026.10.02.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Kuniyuki
 Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Kumar
 Kartikeya Dwivedi <memxor@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle
 (free+clone)
In-Reply-To: <20261001184551.314c7a0e@kernel.org> (Jakub Kicinski's message of
	"Thu, 1 Oct 2026 18:45:51 -0700")
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
	<20261001184551.314c7a0e@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 02 Oct 2026 14:47:22 +0200
Message-ID: <87cxtsl15x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 01, 2026 at 06:45 PM -07, Jakub Kicinski wrote:
> On Mon, 28 Sep 2026 13:40:17 +0200 Jakub Sitnicki wrote:
>> Subject: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle (free+clone)
>
> is this expected not to build on top of net-next?

No, it should build cleanly. Base was 42a9fb3382fc ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") [1].

But you can ignore v1. I will be rebasing & respinning it to address
your feedback [2]. Likely during Plumbers.

Cover letter also needs an update since benchmarks got fixed [3].

[1] https://github.com/jsitnicki/linux/commits/sent/20260924-bpf-meta-gated-tracepoints-4a731fd0ef64-v1
[2] https://lore.kernel.org/all/20260925132004.171b751e@kernel.org/
[3] http://msgid.link/87ik3kl1lr.fsf@cloudflare.com

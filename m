Received: from mail-ed2-f37.google.com (mail-ed2-f37.google.com [74.125.228.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667D33A014
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041160; cv=pass; b=K/2weUVXpAjaMqkpghdy+gjFRAo5CFtkh5ep8JaVxA3AM+vVTq9q+ooaskXthLBc3klXdjmWWYmstGy5rimv9JNaaJnMeHg4N7Hj8+XNVJ4LYDjZvZ1JIdUw25EcKwjDWCEOhkKlFuVmmpaRHJy5l1L3RM9L8lBWvT3nH4s2qlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041160; c=relaxed/simple;
	bh=nzKayMpt5LpI2eLOKchl+ApCZGT1r93JNTtN1iAm+qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJLPhOmkFtTq7zZsfht7VcfLxWd2DVmGjz0TbCMznrHaUWpJeRYuNDr7TkzdfqjfyPbIZA9sNrawocvx6va47/jkN7RrXS7S3cjdiKtj0Qk53aHDAAYQIxpLS6EspwNi38gVynaCbswEFS4kBR2Q54tkgPi81r2MXTgPpm6JNng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHj02wF+; arc=pass smtp.client-ip=74.125.228.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHj02wF+"
Received: by mail-ed2-f37.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so5250957a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790041157; cv=none;
        d=google.com; s=arc-20260327;
        b=HDQLvAMdhitWwAZMvFBUzNPFfwrp+1rNaC5KkqgTrB9x9GaXdaj5ZSk15YVz9uc+/C
         YA4uXVGOd9qhMJnEcRMTJEhGGPOT/0hAxx0BPyIXOU+0BuTzU6QtyUoQZz8SCAjpHXiw
         kYuyJf4daoKH/2RuGY1QkqUbY2dZbyKhxhkLvd3ygd5hAjPMCc7sOcOaVESRRxkf5qdp
         GpjiAcBx7kXIXzXlHVkw4iK8i+mAxnOI6OLaaSYRXMIXGsdARJ92lrbdQ/592kcmiW+y
         3iyI/FKkBS1UGfnwBBDjjDHFWVmHz6vsjCdIIZozAAa+vcMQgJgFvV22etlXZiLVKmY1
         +I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3+sqL9EndfnUuC3ekBlZfho08escxH2wAgTzkVZingk=;
        fh=/7qAlWUSWSn8/gphoIC7zLXSxWIn1eM9w3o+M199Xbo=;
        b=cwcigydZntNqa8MaWhRuUam1lvEOvintoJwZACsgF9HXwKlBfFgsgF1Wp5ohrN2PX9
         HVpEGwM5vpQxGXQxjv1QUuAtYb3CSblqlGZV0UJfjNWvRTUNane8CrtTrzgnPcTzm/F9
         M+f+VkUKc/IwOLFfat7rdA6HcbJy0n/pKJCpbfHs733imds3AY0u1h/KLCsZEhnS3yAE
         lcwKGZ4svEESsCAcv7TRcU5KztIVTn9k8tSoiDcvJ8FcTwM0I9hgUWcGeJqTPcDAi9xU
         AE+f2eE79KTbE5VGqusxxCvX4Z8imVUlJ+J0qKfz2p+q7pbicX8usXBYl/A712b1jss1
         bQZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790041157; x=1790645957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3+sqL9EndfnUuC3ekBlZfho08escxH2wAgTzkVZingk=;
        b=PHj02wF+S1igaSjToouEgfLXh9CxfHR1DvJwkegHnYIM1twZ1tHdwxaGQ2jlr00fd/
         NUpCIArR9KVskYG/fAkgijnd5osUj7jCzJobZvQoaukY3GNe0yCJoebEvhzv2kTwOram
         GgX/XZXh4jr2x09HQE+Yn1oQ7msb9kwOmXWFu0QgGPLEAXUQ/y8YIuAycFkNgq4sQv3n
         D30pbtc0ZYrndZn52jGrDGl2UaXpkyO0jsO5GOWTj+d2z7ZMv0/KbxI/hZSOIbabkMbx
         GsVHB2Vq7c7Fndt6ODkbFV/ijYG+ugv3SRGfHOlzKH8ZN34Xvz+VPlaaB7iPr/ghAhF4
         k3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041157; x=1790645957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+sqL9EndfnUuC3ekBlZfho08escxH2wAgTzkVZingk=;
        b=cmVE72WGLLVPQL9iLEtBMMifQ1MBrtK1ImcrD5n+HcQ79u7W56C89xIxvP2D9+Q6X0
         QA71zquhTYQ9S4GliiBWStJQTAo0BW1a+YEl2o4Cvbo5G/B+C5i5YRbNNACMWR0k6UXu
         s3L0F1nY5JkVR+pXoNOzG/QlkRAgnK2jhuBzVbmeWVRwlXn7TlePLCgwBrBcOPzr2BHv
         VvtxAc4m7sPDQ6/XngdxrOB/k5i/2s74Nt7bxRMKiLlT7w8hcYib7ifVEUSBxSzq0L1F
         uYk3h2YTFDYEGiWgbk8NNmSFBg4IzsRpddQrYm6qgUiYIiOpH2qnLTPrghgdUfVy2NfL
         yKsg==
X-Forwarded-Encrypted: i=1; AKwUvBzqWSDprAP4uH9PRadU9LREjmCDRfuf2MdGuF1QaEsV68PuwrQ8we6GBZyAigaI8KGZ+3zoXMA=@vger.kernel.org
X-Gm-Message-State: AFuF++lw1bL2effPatnZLpXSTQVRnCEOlmpB1HUn4v9NHKh+4QxzpKeG
	yKk7FsVqx8WmQQ5vrJG1AevkBeoVeA3AiflaiHFBA2VFgoaYaJ0TTk+EzSQJ1P3fg+DhZR7mR/c
	FNlYkm6S2QGBU0Qi6tRUak6pBqm8cl2WTqrMC7ku8
X-Gm-Gg: AYBFou2urnivR3MGb2xQJS29zbWXQZI9xKH0YEnETWm1/g72b0kLg/K65Ofuc+DZcLU
	37PW+iASQxwU+rn8wE0FNd8XSLWcKmfge51tac7qunjEnrG+E+YSFlWKqvvZwQts+p2oiluaYAR
	YYle5vHagiWYIU2F2d1VEBiHEKRZEgrzAPeEdbI2SoNiCyEV8VBw5sf3M2bsUS5kczNpR2oddz6
	80EfAz/vifFBKKMYbIWIfob3DduL5vHZoMKySa+JBRuHeZS1JYAYEWrJIgFi0rIoTTxnjAb+yrt
	E5XtuwmjQ8tB38ODohS5zw+x+/1zFIU5DIAI8CfV4pfJjuY4lGULocr7KxsLSyDGb59BO+k11cR
	1d4e+xJvxXfgwus3woHffbm6Pi8WZVnK3zj0oy+u7OZESJ2oIE2iqdpsuVXBgGJmRiAkxRgFRYc
	a6xaRhKpqesQ87CWkJ79L0KKkT
X-Received: by 2002:a05:6402:1ecd:b0:6aa:a6e7:b0 with SMTP id
 4fb4d7f45d1cf-6aaa6e70422mr9471a12.1.1790041156323; Mon, 21 Sep 2026 18:39:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-udp_hash4_fix_v1-v1-0-718891af0d7a@mpiricsoftware.com> <20260917-udp_hash4_fix_v1-v1-2-718891af0d7a@mpiricsoftware.com>
In-Reply-To: <20260917-udp_hash4_fix_v1-v1-2-718891af0d7a@mpiricsoftware.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Sep 2026 18:39:02 -0700
X-Gm-Features: AcwNN1VS5-tmQwdV_hNQPnVds2HKZ6G4TX5VEKVnNrvmlJfpkS67ooCdmA57lA0
Message-ID: <CAAVpQUC-QN1meeJJedRk7Go3+nUNywi+E+XQpzXFvpWPEtmHWw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] udp: remove a disconnected socket from the
 4-tuple hash table
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Philo Lu <lulie@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>, 
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>, Willem de Bruijn <willemb@google.com>, 
	Cambda Zhu <cambda@linux.alibaba.com>, Janak Bhatt <janak@mpiric.us>, 
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Shardul Bankar <shardulsb08@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:26=E2=80=AFAM Shardul Bankar
<shardul.b@mpiricsoftware.com> wrote:
>
> A UDP socket bound to a specific address and port keeps its entry in the
> 4-tuple hash table after it is disconnected:
>
>     sk binds to 127.0.0.1:21001
>     sk connects to 127.0.0.2:20001      // filed in the 4-tuple table
>     sk disconnects, connect(AF_UNSPEC)  // still filed, peer now 0.0.0.0:=
0
>
> __udp_disconnect() takes a socket out of that table only as a side effect
> of ->rehash() or ->unhash(), and it skips ->rehash() when
> SOCK_BINDADDR_LOCK is set and ->unhash() when SOCK_BINDPORT_LOCK is set.
> commit 6996a2d2d0a6 ("udp: Unhash auto-bound connected sk from 4-tuple ha=
sh
> table when disconnected.") fixed the same end state for a wildcard-bound
> socket, by a path this one does not take.
>
> The entry is counted whether or not anything hits it. hash4_cnt on the
> hash2 slot stays raised for as long as the socket lives, so udp_has_hash4=
()
> keeps sending every packet for that address and port through the 4-tuple
> lookup first.
>
> On IPv6 it can also be hit. __udp_disconnect() does not clear sk_v6_daddr=
,
> so udp_v6_rehash() files the entry under the peer the socket was connecte=
d
> to with a zero dport, and inet6_match() compares that same
> field: a datagram from the former peer with a zero source port matches,
> and source port zero is accepted on receive. On IPv4 the peer is cleared,
> so a match would need a zero source address as well, which the routing
> layer rejects as martian. The stale sk_v6_daddr is a separate defect, not
> addressed here; removing the entry closes this path either way.
>
> The entry can also be relocated. __udp_disconnect() clears sk_bound_dev_i=
f,
> so a subsequent SO_BINDTODEVICE calls ->rehash(), and because the receive
> address is still specific udp_lib_rehash() moves the entry instead of
> removing it, into the bucket that (rcv_saddr, num, 0, 0) hashes to -- a
> pure function of the address and port, so every socket reaching this stat=
e
> on one address and port collects in one bucket. The bucket cannot be chos=
en
> from outside, as udp_ehashfn() is seeded with a per-boot secret. This las=
t
> one became reachable only with commit 644f9108f3a5 ("udp: Make rehash4
> independent in udp_lib_rehash()"), which moved the hash4 handling out of =
a
> branch a disconnected socket does not take; the stale entry itself dates
> from the commit in Fixes.
>
> Take the socket out of the table before __udp_disconnect() runs, while it
> still matches how it was filed. This also reaches the wildcard case ahead
> of udp_lib_rehash()'s udp_unhash4() branch, leaving that branch unreachab=
le
> from udp_disconnect(); removing it belongs in net-next. udp_disconnect()
> and udp_abort() are the only UDP entries into __udp_disconnect(), which i=
s
> shared with raw, ping and l2tp sockets that are not struct udp_sock:
> ping_prot.obj_size is sizeof(struct inet_sock), so udp_hashed4() on one
> would read past the allocation.
>
> Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
> Assisted-by: LLM
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC046C850
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838047; cv=none; b=AE5ohJAcfoS+WyjjlVZ88Y4bHIZQq2vB3LomuQNYgGkD1+WQelChcA8NmKoqGn2neksjwBTGISr0hCEv494vib4pCtJVF6pGMuiNdJie9pF2djs+xuR3ZFKfkkcAYRbOT0jbXOGQZ0sqjmsweE9IFUfogbjs9ToXNrfBr97Pevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838047; c=relaxed/simple;
	bh=jepb+VUTDpbcYOcoiP3c8KCXVj2f5l9bEEJUCWbsoek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KaGEPTuDvXhdaj+pUuPC6smDRS04c8mYJNRAUvq+wBwjaKTEcNgOnGcjcKQK7kbK9fJk2ipCf8nwe7k4vru7zxCGuNMCTzWHYl1K1oxuC9xiHY6bj+CbauGw1PSQ0P2yfDeu/Invhjw/80SKfsC91lh2GRAIBzlZZz6awBdjzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NgUpmUg7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NgUpmUg7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a051b73866so7071573a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785838044; x=1786442844; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jepb+VUTDpbcYOcoiP3c8KCXVj2f5l9bEEJUCWbsoek=;
        b=NgUpmUg7cQii/IkFbGxBuBK00C8eBks2U+xWy0LE9cz//yNS9Zz/F280DcPWxnm/ds
         75ubtCxGsi8bohJvB/I+V4vYGsOI/qNd29uEiNj0G5vsWXFTYhcyZb8zSepxNGxGLTwS
         k1L18HbNKW72YJeOu5FPXDyn0f3M6K5rgdq5QnxPJrHBdt82WgNi+xxUZUQa2cLWxzC0
         zVg+psjfgLhJFCVnefQF7Px6r/JxnxQ+z9x7R7Aht0Wg6aeMsnX1X8ZBnWtRHgDnZ9yy
         NDkCqFysjUJzedLAYsFn24GKqPnwc+auWtmMsQ+2r6LCH/aHiRVw92CGEB5URnD9brhG
         jgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838044; x=1786442844;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jepb+VUTDpbcYOcoiP3c8KCXVj2f5l9bEEJUCWbsoek=;
        b=ima1ZgmJvgKm+04Z3hAN5NbqihXjG5ATSmVGwuqWDZgigFXi7yMYNBpOGKqZj/YLbt
         R98lfi6m1jJkVdpDIxRoEEaIIoTxPPXf3AWFi6RE8JG4ssKpOwgHn8IZv/y2e+q5wfx0
         uADDegrZQCd/sg67h+d0Tobuf7tILbu1tN74zC0lXeuO3TO4EkWbIzHG8jrl6NRnGxxb
         S2odMC4ovoDCn5Ey2k44/PLSluSGdwFv0gOBxzPXopO14B+kTowHGn2lyiaWF6RBCRoQ
         6RycOgA1QHK9y6tP02nAN6zXnpvxVTXJwky2xFdmFm+efOK8MqrQXZsDJjdNWM1uLjUf
         bZOA==
X-Forwarded-Encrypted: i=1; AHgh+RpkWJ+QgfbRWNArsk27JkP0cIQZNmR6d1XyziFNViuJy43MnsHxRA/HxQ7HKXQveIzjGJMDWXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS22LjpZ2djzjp30k0H6oR3gX6ULqp82K1qGzyshUX5gr+I245
	UIQ+5RQajsKIdonmNzrsg4XH5iT4u2f8jcml8Hv+G4P6nPTsm2G5KSGe9PC+nKsZRFw=
X-Gm-Gg: AR+sD10M1/RNv5bppLP5fQ8t+PQADbC3gx/gLkU7ZqERaXwFtgp/LM5t5hbXn6D954Q
	LLPGZwR5VF8K7EN8Fzy2G5IpHoeyOKjg/DhuvdvYrFyNlOSSwT4w6VNmZd1tO4yMQlKm37Vou0s
	Xj/5i8uGUVLZ2f9/YteX20+aasx9GBjxX1NZEVFTcqSO7d9Rdikw5wWoWdbfqJyGG6oHndFuW7S
	Eb2p1xxE6ArNiuMKhh+6QMTrw9KjS77jx6+MEGvWkBuPuB75lLQhCWToCdCZs+Xge0kny3nFuK7
	1p9UTA+Qes9iU8i90C2TnKMzuLO3U//GTrZVu0acV4h5ZJ+rXB4Vuh9PZf58D2kml/tTJO24BNj
	JZoQrB29zEQvC8Z1Ld2aEl9HQ+e9GygFp7D7rXm9V4novDlL0C+E6YOkQwb5wU3WNtBK8ghTtrg
	qnK6P1vscsLRpuSNA9QUQoSI7EyBsgmZXMb0wjxjR2CIh7AdeB3SX1XYEddHHNx98=
X-Received: by 2002:a05:6402:24c7:b0:698:428e:9177 with SMTP id 4fb4d7f45d1cf-6a0a7c899c3mr9512823a12.11.1785838044186;
        Tue, 04 Aug 2026 03:07:24 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a09acsm6317456a12.4.2026.08.04.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:07:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Willem de Bruijn <willemb@google.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  Joe Stringer <joe@wand.net.nz>,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Extract shared reqsk-to-listener upgrade
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
	(Michal Luczaj's message of "Mon, 03 Aug 2026 11:00:42 +0200")
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
	<20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 04 Aug 2026 12:07:21 +0200
Message-ID: <87bjbiyzae.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
> __bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
> reqsk-to-listener upgrade. Extract it into a helper.
>
> Leave the currently unreachable WARN_ONCE as a defensive assert.
>
> No functional change.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

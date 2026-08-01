Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361631715D
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 05:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561192; cv=none; b=GXy3XxT2FyB9DrBL9KsCiC6gpU8cyCVLQ08TigEqUc4VwE1cfaom/MdUaUBOqdSGueOo35XWg2r5D+4urBnw5ZnRy99sUaKYFXLjQ0SmXoG6ujtNswZPeDA7QpvUFhuD68wYGQlO06PrpZZ7ybfOHQG0swM1c6I5EVZOer/V6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561192; c=relaxed/simple;
	bh=25QkIyti4jfl2dpoGtxp57JIya14rWwPoMAhxmEB9A8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E3pm6UkT3QpQANjshl3wQWxTJunVcXu9so3BItfmLc0VpxT/70hJpfO8zRXjGkODgoRVYiPNNSO3B6EWV0vp3TlWgPzt7j5L8CodjLXb7LHawFtZ3O3O1G4QEYbGO+3JOKq5f6nLsPxpMv+P0fBuvqZN418l8XkRfsyjT9/2bxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncUqAk0M; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncUqAk0M"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so3017869a91.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785561190; x=1786165990; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZyjRsYLJLAU7i/3YxTAQp7fjMphrbBH834dIHuncHY=;
        b=ncUqAk0MGWv1nsUYA3UU/CH5HH2kCoGjSOep/Db5Kvs6XYzXHZW64ZX9F6n/qTEmfp
         lBmoO/1ey72co7qQwr9tJEzr01lvs8wEq2aBkmWuQuWlWL3mOYXiVqTJTppd+41mRueF
         UaVXBl08mH/6QEUmSI8s/3TQU2IR9qXYJDbkkoPcomzdYAdRNcrC1POirOhS0US55TQ/
         aodZTwajK2giG44/NtPqsm/f1EZmE5UnS0Ab3KAolZ7tgusJldqR2AC8tX66yav/mh71
         lUdVKFigW8/egj58dJx8zB+HIxAlDeI2PBSlgj8fTOqqvJxBvAKInRoWNePWjVDC5p75
         XW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785561190; x=1786165990;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mZyjRsYLJLAU7i/3YxTAQp7fjMphrbBH834dIHuncHY=;
        b=T8qqTet4Q+k8WSwoj+To1yoxBzVvGMtI/yw6wW+rYkyl3xNgBxOR4SSLFqRlNIosP0
         5/ePj+hvMUvXTUM35BgQrKlm/ZDVptgM9qSfUqQCm6C9SLHzW9IddX+GeHak49PwbJBv
         cDV/KPH1OTX2RNIda7xmj2bz6M66CqZx+sfOzI9EsUHgRunbwMk/os+rmc58KeM4AS9e
         Ac6izDfRN71hY6I6Alc92aXtJ1pAa4tkZtzcygVmmX0Z9awjL/Uxw0rBylWZMF13b1m+
         QhRwXD7WQWkjxR8CTprHacuamBG0ah5KWC6SJ2Ac18S+Y60QquXoCcza9eerKgRfJpPC
         rjTQ==
X-Gm-Message-State: AOJu0YxOVick2jiV1g7IsW6h9YqP1KX7Q+XiZjh4CkxI+T98ak2Njstf
	S/fQj0RhoZwah67Y5R6hjPRuMs4MjcqNYqHIG9Y0uBD9XaMY1mNQMSI+MNonaxB2qFEXrajZp1X
	iQtMwTCQMUJkWw5cF2HK2pTrMag==
X-Received: from pjv15.prod.google.com ([2002:a17:90b:564f:b0:38e:b851:fec5])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d4c:b0:381:23d5:693f with SMTP id 98e67ed59e1d1-38fbc4ea9f8mr2221027a91.28.1785561190254;
 Fri, 31 Jul 2026 22:13:10 -0700 (PDT)
Date: Sat,  1 Aug 2026 05:12:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260801051307.478469-1-shivajikant@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Allow IP_TRANSPARENT and
 IPV6_TRANSPARENT in bpf_{set,get}sockopt()
From: Shivaji Kant <shivajikant@google.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kuniyu@google.com, anubhavsinggh@google.com, 
	Shivaji Kant <shivajikant@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Currently, bpf_setsockopt() and bpf_getsockopt() for SOL_IP and SOL_IPV6
only allow a small subset of socket options (such as IP_TOS,
IPV6_TCLASS, and IPV6_AUTOFLOWLABEL). Calling bpf_setsockopt() with
IP_TRANSPARENT or IPV6_TRANSPARENT fails with -EINVAL.

Transparent proxying (TPROXY) and related networking components often
rely on IP_TRANSPARENT and IPV6_TRANSPARENT to enable binding sockets
to non-local IP addresses.

Allow IP_TRANSPARENT for SOL_IP in sol_ip_sockopt() and
IPV6_TRANSPARENT for SOL_IPV6 in sol_ipv6_sockopt().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Tested-by: Anubhav Singh <anubhavsinggh@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index c21c1daecf9d..04a9f9d8d07b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5645,6 +5645,7 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 
 	switch (optname) {
 	case IP_TOS:
+	case IP_TRANSPARENT:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
@@ -5671,6 +5672,7 @@ static int sol_ipv6_sockopt(struct sock *sk, int optname,
 	switch (optname) {
 	case IPV6_TCLASS:
 	case IPV6_AUTOFLOWLABEL:
+	case IPV6_TRANSPARENT:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
-- 
2.55.0.508.g3f0d502094-goog


Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706F36F909
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623170; cv=none; b=gmEKyr38461HXRXIuvO1w5xQ9JY9R5DFKNJYp8k3wfSmgQ03+i03x+3p/EyJR5G9jneuoREWsSDUwdug2W5kP76rtxW4y9KRnsMHXz6ko5B8Jl/0WrmDoTQ1L5A149F61seLyvdUF7wqY65uH8ITYtOjGkLogbaSFsdZtjNaQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623170; c=relaxed/simple;
	bh=cKRxNm86gzxnVgmkPil6uvSeyJZxMrBzx9O2/9KRxls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0mmm3XXtN83AYGLR7Blqk0vhIt/W/G6bggnctzAWiUlHP34st1c34US0lgVRp5l7wA8nNASygwT9gfi3O7MxDtuvrcm3QfiD8oJLZE9Jn5wYMfljI+wKaP0GDe4H4GLV17yj5yc5ux3GuMf7KL++6Q39vRBk8bsQV4E5TrulBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=gk+CwX+L; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="gk+CwX+L"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-354ba08cfd1so834221eec.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791623166; x=1792227966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZs8U0ZjQ35oS4ozK838xXyPfIOXVraWP2I51EAkJ5w=;
        b=gk+CwX+LRz8ORl6Q0IvKrzDJV+ECVTG7KteaoM7bYAlJHNcSqlRndQPqp+2EsBuYeN
         DWvdQWpevv/vg6KyLfayqYfyHSA87Ty7IaDX/M5wwSUN/qmRiPCeoNkPq8I/IfUD6hHW
         PUgygYE49ss2bZFLxJE06/GYaGtotmcEbGA6CoRINpqY0V/NLICnJYbJDicgTVLfEPkw
         A1M4OL4hG3iJHvozEhyKtCqqBIEXvTp4uJa7uab2bqrFWC9JvqsrARLxZ0gt6hFYBxME
         btA5fdpIC0cmzz4GkT7SeJeXAG7iKFi+NHH6xpEpby0Gbw0AOEx8rcE+ST1WsIuvfRkf
         JJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791623166; x=1792227966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZs8U0ZjQ35oS4ozK838xXyPfIOXVraWP2I51EAkJ5w=;
        b=2lz8n+PsCwcQ6x8D88kxVq+CE9C1y4qBAYygFnNtxzgFLZKtVW7yqqknvS38TV11Vh
         IaUY3pxaBX8LGvXQn1Qw69IgV6NlPhWjOtoKnUekiEBrxsRis8gR9M/Fp5zYMEfAZwWz
         jAPj7rSJv8l/KAOHQGKbJBLoZdc7a00dXrn6CQCX3AHRwBXRr2+5PZwIWDALfV+lG5vt
         iTqLDyL6UW1WI77+olJojEAtC9jJnAN6VeZRO91nd5AO1vYaF/HWhPCG61RevpT8s+Fl
         K8FBjID+Ej44gWF3/dbpm1fjU8GTsxKsiZ01IYS3Qq9DEbvLeCz5vd3jUmahpt1BHirS
         lBjg==
X-Gm-Message-State: AFq9FYIOsoKPP5wXpYiZh9v+zY3tpQx63khWa8x0xyiIZjZN8LLAYbxQ
	DPvHM2FMkU1y14EYwTBB5xtl8Gbhu4olJuVFEQjFAdWP9SMZ7po7Q6RoOTvvtvpl9+SqIqtYLWl
	PjvqiJuVS8f8U9ClBEHU57paqg1glYeGPKBXfGjEqMXaJc38/fjURYw1qcMguN/7zwuwODgzw
X-Gm-Gg: AYBFou2DfGvCedVxUMMuk4BYXrs3xlUZm+q7I+IvC66G5bD3VeKveGyS+BFtO8sVF2o
	GIYT3hqAU7niyvJgt42uLAH3WhFBZPaabW1GojlCgaNmhmfS++BCTYksZhjXLTX26VaBwoqeYvR
	jMVQmT6HtQEX2Sn1p5uGtciz+SeKTK/vCWfgA468p+ZkBz0N4m3IUO18Mj2l89Ym0WUYwGhHBHO
	hGneuU2jxDY3zlUG2XJjizvOYr4TXLBhV92mUPIyEnt7jBntxaFpG6oJfJuISi0wHMdsmzIGlPn
	HDC0YT/rGMxRdHjn4F5BmYH5b487mRnEhjVokBuKk5kHpNtH88PdXkID61I2QR4dVCpFeswmfVG
	Tj01+uzd1FLngUaVxfZAYz18QUNEFD351s+apn47cM28LzxWXPF1ofQWknmIOEgDvaPF6aEK2Qp
	0J1AY5IXk27v0uNgDSsnUfSvx7u+EgYdGJrniLAg1ZvpKNjpxQ5T7TKU5w3tD1M8foKYWyiBrIg
	GzHsei68Ro=
X-Received: by 2002:a05:7022:ea48:10b0:166:5552:780a with SMTP id a92af1059eb24-16a5afe59d1mr5532791c88.8.1791623165597;
        Sat, 10 Oct 2026 02:06:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1699718c547sm12212587c88.3.2026.10.10.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 02:06:05 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-security-module@vger.kernel.org,
	Alice Mikityanska <alice.kernel@fastmail.im>
Subject: Re: [PATCH net v2] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
Date: Sat, 10 Oct 2026 17:05:34 +0800
Message-ID: <20261010090534.317149-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179156155963.36253.400481753322266658@gmail.com>
References: <179156155963.36253.400481753322266658@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 12:59:19 -0300 Joas Antonio dos Santos wrote:
> calipso_skbuff_setattr() adjusts payload_len by the length of the
> option it inserts or resizes:
>
> 	payload = ntohs(ip6_hdr->payload_len);
> 	ip6_hdr->payload_len = htons(payload + len_delta);
>
> GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
> payload_len == 0 for them; ipv6_payload_len() then falls back to
> skb->len.  For such a packet forwarded to a destination mapped to
> CALIPSO, the code above writes len_delta (or 65536 + len_delta when
> shrinking) into payload_len, and ipv6_payload_len() no longer falls
> back to skb->len.  nf_tables, conntrack and sch_cake rely on it.
>
> The same arithmetic also wraps when a packet grows past IPV6_MAXPLEN,
> and a BIG TCP packet that shrinks below IPV6_MAXPLEN should get its
> real length back.
>
> Set payload_len from the skb length with ipv6_set_payload_len(), which
> stores 0 above IPV6_MAXPLEN and the real length otherwise, as
> ipv6_gro_complete() does.  The network header was just reset to
> skb->data, so skb->len - sizeof(*ip6_hdr) is the payload length.
>
> Tested on one kernel (arm64, QEMU) with SELinux permissive, a minimal
> mdp-generated policy (network_peer_controls=1), "netlabelctl calipso
> add pass doi:16" and a NetLabel mapping of fd00:2::/64 to CALIPSO
> DOI 16.  calipso_skbuff_setattr() was called through
> netlbl_skbuff_setattr() from a test-only debugfs hook (not part of
> this patch) adding a level-only label; payload_len after the call:
>
>   case                         before fix   after fix   real length
>   1000, unlabeled                    1016        1016          1016
>   70000 GSO, payload_len 0             16           0         70016
>   65530 GSO, grows past MAXPLEN        10           0         65546
>   65540 GSO with a 24 byte hop
>   header, shrinks below MAXPLEN     65528       65532         65532
>   1000 with a 24 byte hop header      992         992           992
>
> (0 means ipv6_payload_len() returns the real length.)  On the forward
> path, with a client injecting unlabeled UDP through a router to a
> server, the router adds the CALIPSO option and the server delivers all
> datagrams (Udp6InDatagrams 5, Ip6InTruncatedPkts 0) with this patch.
>
> Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Suggested-by: Wang Zhan <wang.zhan@smartx.com>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Claude:claude-opus-5-5

Reviewed-by: Wang Zhan <wang.zhan@smartx.com>

> @@ -1357,8 +1357,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
>  			sizeof(*ip6_hdr) + start);
>  		skb_reset_network_header(skb);
>  		ip6_hdr = ipv6_hdr(skb);
> -		payload = ntohs(ip6_hdr->payload_len);
> -		ip6_hdr->payload_len = htons(payload + len_delta);
> +		/* 0 above IPV6_MAXPLEN (BIG TCP), the real length otherwise */

nit: consider dropping the comment, it just repeats what
ipv6_set_payload_len() does.

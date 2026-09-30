Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4347207F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758922; cv=none; b=O4h/2Qdh7owunSlvih/D28rnJ+Kt0vRpJ0y+yV9L4oY8vmsHJ9oHBRj5cpGWLIw1KouwZBpVXTOVJmQiuSb9iTWBY9uXaQ/jFuv1cPCF7GJI4NK+LRVUAhCkpmWnoyg6+D15MkL6FZ4CTh1wVd1LCaYoHg9jdllp9ivLlLH6LZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758922; c=relaxed/simple;
	bh=vUgSmNgYb3xPR6GE41yrOSkOkZp4hMoyauJEOX0p9L8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Nx2xtJQAMdjPWl+7cUzYFi/FrMgNLxWUkBuvUlNgY1x+TbdV+F9d24EJq12VPr34DKZYG3yhJg6COYvNIBz7NU5cT9CCFFwyycCKzTlm/rWjPl+Rd5kxWT/vq9dl0yqC/7V6oYxXVoDwL18tf1PxKLmdkkyJh2jMRliA7In1LMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzZiQMh7; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzZiQMh7"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2da4743b0so2909615ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790758920; x=1791363720; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=valg39DdEk8sl2YI17Dx/FsaQPmRarO/oHzT/4W/5sE=;
        b=qzZiQMh7DnKSeCHllSc/0Ox7SWd4gI7lAxYbJUEhIoq2XE7B0onLSFx/hPaemWbn+9
         wm/I1t9l3ab3+zLXygBf40YYlJBLjlpPyLnuHc0TGup3ElwuGCqWfTX++9cw0oiWaWPy
         BmoR7oIs+2hmS9pXmKZoexTAtVCYHc/akWHe30m9aHvCHuMgUCP36RjbwcYjZIP1bWp2
         LrKckrmyElI2KKcmIKa9PUE8p16uOppwxoxptDoB/1KZbGbnNra53O1DZk+D+moOdgtd
         DUf/DhJoGdp+ctuuwnPDZpj69AQiKIaOrtLhuzJqp7rs7/RqESVcCF7bGsABGnA4JuIB
         lPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790758920; x=1791363720;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=valg39DdEk8sl2YI17Dx/FsaQPmRarO/oHzT/4W/5sE=;
        b=FzH8VgGM3wK9iXkOk9ZmzFQzy4Smh7lEQElxBL4X9C4/McHkEyeoRutLhej/yjpNTp
         GptzWf6OR93Fp5KwEMokkRFnaEsHgLrj66WG59mwPkVjqK8hPAFthXXYnjI4Fplx4Ky4
         OqY66U+k8WhVTvwzDo8pkgPX+qvzk6UuKxteGM8SKnM3EKikm4c5udUqZVhL4YSRQ/+W
         r0Ke9WOJsLliWiquWe2QFQ8TQ3Kmym9iwEJ01Oi9EA35ekWVsvc3IAH3jZjfseoio0Ox
         ZTH6Ig8p3jMkHzTdg4znMUZrrV7SXpEaBjiRjNQzN/nEomTVeHhJ5Fgnrb7XXymQLEWe
         j43A==
X-Forwarded-Encrypted: i=1; AKwUvBycvigw2f70CNeyt2Ec0NjCiiUhC3zS1bsRLHPeIwJiq7YlEu55YTxcBhKdWQVMrk5h26s0ILI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiDjeG6e+AWVC9IJVXmVjK4wigBYVRoCppNAWWnK6pJAiEbeqB
	LX8c+dOAu4sAW1dsNEBe/KPSg+prLhDP6QZsNP9sTZZztZuKBuljLWb3
X-Gm-Gg: AYBFou2/W/h4S8B1tc2xawJ3LvgP4/Xy+SoCIzIlZ7a41uw6WgpHZFGEITajrYDVB2a
	HcYaQMM8O1xgfU9MYBv6kJ982xV1AK2gbq0TzHSZon2pFnInkLjyCevN3IYlY5lVSxONtbCca1M
	UspdgF4hD4mX2nkm6gkR2ENHTi7DDFYrzcUUPX3+k7Bu4AxAICuRNnBfpQ+m6vMbspr/NkulLg9
	Xai1UqeKkZtax8OSKd2Ztk/EFtKl/9Qp3KDsBksmXw291Fi5okZZYMflkTeG36MK4vpHKTKKA0/
	jwEGftkmz+/+lwSECiaTKxBrtzIxt6t2jdduPSgSnhN6peOmtXO1/Iux6B8BLt9kgEHZo6fw+y0
	VHhipPOUL+yQvqXci/WfYhzXO0HTn1YfylUpHjIldS46XIoE0KFb2WrUOxKtrGMW8i4Xvrlks1v
	cFJFnrUqIncAJqo+nyD6mumawFEaIKK/J1H/GsmzvpGXOcjvadnnY67D8p6SuLaDWrziMsbk1is
	9lNQA0/PArZAzrCz6lGKA0jd5hvBN/f4yPYxmDS3mgrHd1qZrLz3pgzJaQXX7yjf5/fPFRMzejA
	xZ6xtUWqw1kL5Ew=
X-Received: by 2002:a17:90b:2888:b0:3a0:f4ee:d2b2 with SMTP id 98e67ed59e1d1-3a4d2895ae0mr550843a91.32.1790758920501;
        Wed, 30 Sep 2026 02:02:00 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c9938fe0sm2567574a91.0.2026.09.30.02.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 02:02:00 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 09:01:59 +0000
Message-Id: <DLSJ22P7T6BZ.FCF3J1JWCOET@gmail.com>
Cc: <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <daniel@iogearbox.net>,
 <cong.wang@bytedance.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf, sockmap: Fix udp_bpf_recvmsg()
 spinning on backlog-only ingress
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chenyuan_fl@163.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20260929083447.558818-2-chenyuan_fl@163.com>
References: <20260929083447.558818-1-chenyuan_fl@163.com> <20260929083447.558818-2-chenyuan_fl@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 04:34 PM chenyuan_fl@163.com <chenyuan_fl@163.com> wrote:
> @@ -91,7 +91,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>  		data = udp_msg_wait_data(sk, psock, timeo);
>  		if (data) {
> -			if (psock_has_data(psock))
> +			if (!sk_psock_queue_empty(psock))
>  				goto msg_bytes_ready;
>
>  			release_sock(sk);

sashiko is right. This replaces a spin with a hang.

pw-bot: cr

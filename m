Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B742E7165
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810616; cv=pass; b=MiUCnHrhR/p3eBOwM99EmpJ25I6iBISRJWWWb6nbspZLIsyNTxUwaZLi6cToXKW720b6F8Ki8jMfDtMG9FjvaY7wGap8G3dbLCKaSj+Y2v5ky7AdvX0jlc+UorwLU8Jodeh3k1RhI9XEpPFqUhtDqBxf08JiFy3vKvdikKlr93E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810616; c=relaxed/simple;
	bh=KS5fJCZ8ctzebd44ctlhnELVtRUtZgQzMsOYk73p5oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJIbPHaRiKHvkP3EhAjjk+qFBaazTijtgBdjciTs30ldBEa5FSbBe45/iOFRnP+ctx7LHtG5t/yz4axWA8WIR7zQjJmaYqxaqSNB3W7VjnMNiusqwbNHBR/kg42ysVeywxFHjgGjzeJmi6mVHnSz2r8xZpLDAwzomndEs2MEp+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlDlHQBp; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlDlHQBp"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2cce930cso5474811cf.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 05:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784810614; cv=none;
        d=google.com; s=arc-20260327;
        b=W+o3uGmoHEEO30RmSuGvHSOcxQ3wCKKMHEaJBpYJW78b7CpWU/Z/yb2zLDZeG1Xji2
         BorM5UZtDJWJYQbvRGKKJm/FhP48T53npczsTdPyXOU9s3wBI5nREG392oOB6yO5EHJN
         VUb/8EEml1/DsZn7gbKdEVjSkwEDeuxLJXIb8LWIgrMfHgLi4DHzDdfnisP9wpLAFPTm
         wF7wqGzFgvDG38no0JzixDV0YcuRltv5aOQarPhxDjJOpmjrRZNEHhVYYI7gc+N/hKtZ
         wkJ64e/nWrng6GHWhp/pYE3h7zRmfuEhG1Z4vtqHrdOrGhe6n/4Aci+iuD8KqdnmW1GT
         hvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p2hkU8oFWcNP1C8sUin70jbCm77xzRBbMtEY1Fj3Jzc=;
        fh=yCPZaJYJFXK1Jx7C6UmSpsxSReG6nApiWMYoAkITouQ=;
        b=S30W7v4FZibbGCumiY8ODWq6V9MEDpFA+c+bhBwSNIG4rgaOzhODl2gAm5dLTGLkkF
         NMq/YQeRZWQPYauBsmliFsqvtj2vIKgGFMH3AT0J2NkaBmn2G3IdXDYAMIL91KeO2o6m
         EDZWeE0nU+HGNFPRSyp2RIONel2KX4c/xzL5H13cE8h6/BktQxhwpMbhimxjY8swsvXk
         b9Yri8yI2moVdV9p6c3dQJ0Kq2z+f5JqYgGEc8Zke+DanKMQsoI3x80llMKL2IT1Udcf
         +wiJBHUuLURNl5PZDkb3UoFpMKzA2/D2B8oENNJoYuZpaY0iLUVVRBM3KstboseXueth
         1ZPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784810614; x=1785415414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2hkU8oFWcNP1C8sUin70jbCm77xzRBbMtEY1Fj3Jzc=;
        b=QlDlHQBpPVA5IM9XwLtc9/9LABT0LtC3Enb/PVZCcwZcAFBZdp9VNcqMNG0Z5pAEuV
         KcIRFIJuB52h5cdu9JBVVYm8lPXJhLcON00DvL49Rl+n/zvJOFAMjVkSpQPxqf9KC6mB
         /hb1EyyoUUdyLvhx/B97mKAoLw4tJagpEmKAmRqTErFTd0ATG52P1ZTwuDUJgYxGtwH1
         d9eO/W1u2GAxXjpk7MEKRM+L+Tgq18EQzlCpehKYKWL3X1KYly/bD65wXyA9eNQ2JBjv
         JILY2+YxA42pbv08h5ePm9JFMbfZfQBqJohq7MKRV5SvPpwCZiYAlQn4l27+97FJkmf5
         0r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784810614; x=1785415414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2hkU8oFWcNP1C8sUin70jbCm77xzRBbMtEY1Fj3Jzc=;
        b=H6+RYaub+9zm+Z15nr5Sp/dXqLJVTghFfY5Np9nYPOUw+lrCt3ox0UDjEeCkuPjd1c
         8Up8b/bS39ZqVqmxVXHJ1koEVh81aX5OL6EflJcd+J4oxMYP5ZxjeqnJtKvIiOSKLWbi
         43ZY3N9Ouphw6sWemj9/ISMsKkSM9I8SUpvxjvg4YO6SE6N3z17KxRKI03XVgjkCmY+/
         WGopJ2u5/xHLao54+7G6ILB4PwBnpp1ikLfmIxtSLgOFovgEfD4gvMVopg/Qs9ABpi5W
         X28RH0Se3LYyO2Auvlui63vzALw4tWPHmwwYecdqJ5vBR1vuimAaR7705e18t++QzmNT
         ebdA==
X-Forwarded-Encrypted: i=1; AHgh+Rooj+1N3VlpckZEDhqZeNSN+Wh5kD7WqV2EJU0lDEUwVvE6aDIeRPfc1kALPRvmxFecastjR3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Iej2Z5fVaNiGnGz3vFSMENJTPQpXSd7sttqTIEDSSRi4qHS4
	VsjExqKJ/vRrPrZXvDUbpi5l7qCnUQOh8EZhoSUK2OwwnWRTlsA/AszBf81dML2e43+fStSRzmW
	qaBB0CuJHU6vx3fSOEEjyNqKjJT/AiVjHeAgRs7Tb
X-Gm-Gg: AR+sD12pQdaIGElY6s2lTyecEbMW8xI+PJpnNqU43xqT9ZrO3aOyimVe/rCmb9tlOy9
	hxbqnBGM+HT4gxuYY0AUEKiW868IoV6AD5YShpjmZuC/lx8UWcvy52iD9QqOWmBp9ry4FSYe2vt
	li8syLay48SgcwSzqVk4t+NDvWK4hvrfxvOYtjFDKzmCFXo6M0Zymn8us5QH6TJa9ZG4Gzq6oAX
	1onFMyLUmusscMpzMK7SPsKesePfApbnse6XdsRrznz4yxYmr7BoRwt+HfqhWyz1C/Yb9/54nMp
	PFPFQDs+EsnWpOkLzLwCBuzlf0eaaM132ARNB6zVP1qMGeSJlPLKQ2BpoWr8PzB9IBXXLxGzyyt
	bSGVdSjGg
X-Received: by 2002:ac8:7e8b:0:b0:527:7d0f:709c with SMTP id
 d75a77b69052e-5283df4c9a5mr24835111cf.42.1784810612641; Thu, 23 Jul 2026
 05:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723120654.577578-1-edumazet@google.com>
In-Reply-To: <20260723120654.577578-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Jul 2026 14:43:20 +0200
X-Gm-Features: AUfX_mxpP3rjeHH7L_-TGuf8g4DiQInQfUQmDm4m7cMLi04o3PTy2WZW_k3chQw
Message-ID: <CANn89iLgThyPfX4VJ56hEjeqzUYJgx6s5Pw72y62rz2drYhLMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv4: do not send ICMP Redirect when peer
 allocation fails
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When inet_getpeer_v4() fails to allocate a peer entry under memory pressu=
re
> or tree size caps, ip_rt_send_redirect() previously fell back to sending =
an
> un-rate-limited ICMP Redirect.
>
> Because ICMP Redirect is not part of the global rate limit mask (sysctl_i=
cmp_ratemask),
> sending ICMP Redirects when peer =3D=3D NULL creates an un-rate-limited I=
CMP packet storm.
>
> Fix this by failing closed in ip_rt_send_redirect() when peer =3D=3D NULL=
.
>
> Fixes: a853c609504e ("inetpeer: do not get a refcount in inet_getpeer()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/route.c | 2 --
>  1 file changed, 2 deletions(-)

I think I sent this patch too soon, I will send a V2 tomorrow.
--
pw-bot: cr

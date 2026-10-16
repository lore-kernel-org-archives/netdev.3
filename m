Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73692419FC5
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137256; cv=pass; b=DyLuxanziY1C5dXNkbdqyUjmRkc6eDcEcU8La6PALkO4hxfaFTeIeCtKLN3wVTkrK1vFaX0NRv2dXuN9ULDst93ltQ5v6h3j0mdxlUN4GvxyOaUszd2ViWVX+kXUJASOecOws+MdivLvvfymLzm+Y/Xh0IP8v8v/eBTwPFHBlzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137256; c=relaxed/simple;
	bh=KLwhpQm2UjBGZ/IU6JuN7xThtHaXDHsHEC+uZW/NhEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj40rJUiDMWe9tmi9erhbzQ7b7DLmnd2O3l1V9d63XsAonbas/9GgFOI3VBt5+jPMSPeQ3VbrYUQwbzkWYMvhIFz3rhhOkfuibDUcbX2LFwDB/E9wEU8VMJq5JMNy3qber5Ux/BhtkqGa6wbcGbHT4NzKeucBBLdRMeOFISBaM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weOufLrx; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weOufLrx"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so3557930c88.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792137254; cv=none;
        d=google.com; s=arc-20260327;
        b=a7P62SfowDewBX3CgMKaoVTLpDenDSaPa/k6rI39Qfppi+N57LGr3vnR/snx2tOOw6
         gwf6+DkpJAx0k0JMGbzaQlxdEQySWy5vL3F5P7H0lqNGsTrbkq3zbsx/ePpcKZnckzOf
         4+NSGqU3E4yzbD7goymljuFFdVTM9ecQo74O6ph2eMYmVLPJa+jzyGk5aIR3MkqZAhVj
         NwygdMIwIJSKPa4CO+WXbhsfzLGJnvBAD3YgWKb0cR4aE6pog4vhMV9cUeucUVRIUUDl
         tDyyk/GcDUmiMsLuO547DKj2LBS9phyOzJgL627wyBjdyMtXxRrJ69Si501g6ZP0QBeG
         vF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KLwhpQm2UjBGZ/IU6JuN7xThtHaXDHsHEC+uZW/NhEQ=;
        fh=qW1oXw/U31Dq2TPgrKrt1osxITKeLc9HyihD7PbeOFA=;
        b=n+3mX7JuJAfRwpdTrShOXZ2NG4fSpv7ReIUAEw2fdBB7BZ9lWYo7C2j9LKJDgHHbtD
         aQY8Q/SvxMf0ElG7tfhpkbgEnwtFSE/xjf/6C10tWMdiqjzUXs5PPdul+UVtRLLlO2BG
         wdhokeBv3yyVPmyZYep8AfOWXnHamRKNH10hf7it1YxUrD2gsT5W4gPB5PDsQfiReLFC
         m05evNI5S1VUr3uAJFAnqDXWg2SdnG4W+oWiecVnS/tQsbCeLXj6/yApuzY4FDy000Zs
         u+fm7q7iLdHwniv8lANKC6Hjt2Mr5r+94O5DUh+uEiGF9MOJRlQhx7h1ZUq58Pzvu336
         kBpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792137254; x=1792742054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KLwhpQm2UjBGZ/IU6JuN7xThtHaXDHsHEC+uZW/NhEQ=;
        b=weOufLrxmXvntHLb6aF9ExyGYiZIKUoo/wDEnuwclKkgTxCAGctFjtSmJnXOS72Ofc
         qZqnR3IbGTjlvL1FnptfQqgOTN973+u6UXJ9zdgnALbBjg+uqkQchzrbOV1dhocS0hyw
         uiDYJcSljRap9nMVOV5hEPLDefUO5KIt3eR9xoSTS4xCWPojXifLN/F9ofzDC2QVyN7z
         b4i3UOnks6IZa2Y6GpdDRL2zfzDgNh/Pv5KxZtkIg/UtnekGCrc7bAyUUzXwD35Vy/6H
         oQ9cWw9bFOC23EeU/454+2xR2JmYSlRXkTiZnln9xaq5kMlVMLIHdzcfhxxcE886xcE9
         P+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137254; x=1792742054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLwhpQm2UjBGZ/IU6JuN7xThtHaXDHsHEC+uZW/NhEQ=;
        b=f/cL3ewJCRZR/ldoVZNxxJYLzGMHQR8QOLdYF3LSrTzoTV9lnChviSy4F6OIFuPjRF
         x0ra/gtl9CX7z4kbDXfT8+Vl7BO3b5vij+cVtS1dULGF1m2WFQ+ITbpkGOec1m5EqdFi
         3pzpK2OKalrluFXHURYjdT6dUo0qnZnMdRmjgqua3MrfPkZ16zwrsysmVjRzjpGu6x4+
         0eXCA+lbx1Sq+85fMm3gvKOrRv+KxpxDzu8Pq4PTytOYVZg2BBdl34uaXCJl7s2GEs/A
         zf4bg+ACxtVsWAt6Y0crCfDZfgvHjp5lm7MUpSJwkkDyyKWKwFbtkwmXGcBU9LwScsLW
         4dNg==
X-Forwarded-Encrypted: i=1; AKwUvBzhwNKFvo1A3DSXdWCef7eIQ+KHGf0F88e5G1utMsR8kzY22IVAnhcbH75i8azjk9Au5cO0MD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqIFULq4Lok1YVsAXeqvjp1MJpN0DSuQFyhbNOC2IyCGvQhmA8
	0FgOmWrg+ddH6z0n/tUwWgVGMyY5SXLFA8ZmDNt+/mUL+YegPgY5Y2/SGgMpqcIxprXlrur0wA7
	Wjw8SscUPJ5TaeWMdv04DT9Id9mO0mJfC5UFoeLl4
X-Gm-Gg: AYBFou1QxAQ+Mcbl29s12nP5q+dppcg19E9KzqhwgiFeUbA0tvaz0RO+y/9sLG7W38Q
	NA+MLoEeOSjReb+6s3tAhod0v1mQ9lqsq4Oafb40+IoMfRwccQlRZJ10qI352OU3ATwA6Oznd1c
	tV01YpD3ipT05z3TMVSnQTnVmbUeAHwNwbIg272es+RR3JrmMse3GbNaP+5XquMsJrwwknLHW+W
	tZ9a3EfsM0TSqvE2Ajj0Vc0Kzsq6W1qvg++Q5t+12tT1yKadA3SEC5zEToIn3477nQdH2k3X2Fy
	0tzasQ0Uz9ZFKJuDmX95G1/6xgrJzpCj6c9O8nXDMsNQmz1rNGmCf7oKOkrd/6U49HFTN7jIcNC
	dxll0pmu0Aral/z7/aVqkG8/7Wazta530+6x1jbmeSow1HpOw7TyDY2unKtGy2oD2vqM=
X-Received: by 2002:a05:7022:ea86:b0:153:7a27:b7d with SMTP id
 a92af1059eb24-16a626f6e93mr26850863c88.20.1792137253208; Fri, 16 Oct 2026
 00:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015073736.2944215-1-tavip@google.com> <20261015073736.2944215-3-tavip@google.com>
In-Reply-To: <20261015073736.2944215-3-tavip@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 16 Oct 2026 00:54:01 -0700
X-Gm-Features: AclHuK-X0MEqM-qiZR_C1C8OlSnnVfLtG_uH9dpCSScAmzQL4uL378qfzqDiPp8
Message-ID: <CAAVpQUCpFC-7J=uEgBfh37hFb5BCJvhJQZx7_YKEDCtvbGrGWw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: net: packetdrill: add test for
 negative sk_forward_alloc in tcp_wmem_schedule()
To: Octavian Purdila <tavip@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 12:37=E2=80=AFAM Octavian Purdila <tavip@google.com=
> wrote:
>
> Add a packetdrill test that drives sk->sk_forward_alloc negative via
> tcp_collapse() on the receive queue while sk->sk_wmem_queued exceeds
> sysctl_tcp_wmem[0], and verifies that a subsequent non-blocking write()
> under TCP memory pressure fails with EAGAIN rather than returning a
> negative copy length from tcp_wmem_schedule() and failing with EFAULT.
>
> Assisted-by: LLM
> Signed-off-by: Octavian Purdila <tavip@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

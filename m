Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BE35A388
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327196; cv=pass; b=dJ9dGrT/V307ifNEVnKi3wGu1FT1ndh4u8rQ2Bc1dSgzqUrV7pbmpRNR1pK0L66K3CEzV8PkAhNKZ4AE0OyoRtekh7IeKrmwG6Z4J5AOAJNRiueSboglI95tZkevSMRfK/EjG9EaGRtRJth+Z2rWyWK84lqrQ5ZqtM2qcro0yug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327196; c=relaxed/simple;
	bh=5MQbgMQhyhhkxgjZnd9pG2ijcM4hjg4XrWIMy823Wtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scAh1hvZVRVbHHjtd+MgV3NAyOv4jvFnusf2ttD3u95DA707Er2qFmgfrppLbu+WMWdx/mgEjXJUXWfDPhTdlqv9MZGKBitxAovxHo5dmDHxq80UK54oIj3uG0QduppOp4+HLmZiuaQ0IK2kc8cDucI7WP+QKmuA2D3GyNqZpqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGwtJbL4; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGwtJbL4"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7991db3dc98so11396457b3.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 07:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773327194; cv=none;
        d=google.com; s=arc-20240605;
        b=XkC2O92sdHlpyaFkSBrVvo1O0vEP1y1iMDMfo3u5Jdw83DCDR4i24nA2V5dJVYxslC
         UWcTxtuRFtGlhvYTBeY7eIf+ZJMnqnPsioSF6lz+MtLTFJ7AeYpB8hLP+g1PR8B7zqRN
         /0JlzP2TbivcW3IzhWH5WDX8+9pJp0DXfnCqhkiyg2Yw+qCbXJTo0ysOfIZ9e8WfjJM/
         6q+t6ZabXpK3bshY2Y+Nz0LII0o/neEAtHtaljiteOWVLLNEQPFLr4u3DfQ5hW36mWel
         xi5ESFYb4x/Uj7ZZpMNPTCzBdInmgLjMBaUw6tMu3AXU+Ex/bab2kXOwJ6u7ZcXFfYp2
         Uf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5MQbgMQhyhhkxgjZnd9pG2ijcM4hjg4XrWIMy823Wtw=;
        fh=os9+Cg/JCp1hs7fCp/WU0esHCLLZBmZxjOwcjS4UXH0=;
        b=TPR7KUlEYhVDH5qgBY1MCY9LY2wTv8SRa+VZGpNrc3AnTAdBP7FTTQAjP1vSCM7A33
         vINr72RDAnXkFdlL6DXD2ph5PDZlaS5nJ7NEJHdQoQ04dA2qXd2D6dxC6PiTBv+qMsbx
         qMRPhvg+s/ePSz8ZWhYYZy2vJ7HArFVF9nUZp//drjGLPNN9um6RuZY9fKEtRynOhwl2
         fTD3a98/z45RRnnBtqYFvhpzC8yPmQ2e9tUEdRjOq4TvSv/+vNb0s/f5nvXedMB7UXzv
         /PXIbwIgsM/zSYlo05o3cWTnYM1zjBBsMEC5XPb4v5ihP3jGL25sOLbHbuJazQ9Dj7Cz
         lBnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773327194; x=1773931994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MQbgMQhyhhkxgjZnd9pG2ijcM4hjg4XrWIMy823Wtw=;
        b=EGwtJbL4b1UvIV9xPiBEFH4kUMrMLfQjMGO3HtSj8qBjeF5HAJr+n30Yayc2073h0s
         TOkz0rKtTfkzRupfT8tF2tsJkZZVlz+RovlEJLYI7tfTsR4G04YA2YFpOW4QwKTQtutG
         9+vTUqVqWmsa6wQKYnyYO7ow7HVWojXvbxrzDiRWHU6Gk06sqoDA5G4pazZe12fZG1jn
         f5USjL7uSJZIUsXnAgShNC36UoRh9wreW+tquJlhiyyBznnBrtQ8fpI1zNurgsU75TG1
         Gin2327RPlqJ1lGfuZD0vVefcN/79KharRacfhCivrLeT+gVY+JVRv0ySskWchil7Iua
         FKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327194; x=1773931994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MQbgMQhyhhkxgjZnd9pG2ijcM4hjg4XrWIMy823Wtw=;
        b=bzHaKW0xm9XB2wKoQ8U5vEHUs0Noai7oR1XLaePICTbc0UWjBkrDLWx7opVCUiodRf
         ioUjur4Dz8wx1U9y+KK6bT+zOnqRGdZjNfeB56wiDInOMxFCfZkFWUzZzH6n4lPL5ixg
         Q45bTkbeaOEYBOKmoamUmQxHd2RGlfr1ruhOVTlTHb2KlugU7S+EFD8bguxzWDYEb4es
         sFIuPWV4QsAicvASWkZusFKx07GJRxkEX3Qqt+x234KtXGzsmLsri0ig6cEDwJUye8yU
         gL4vdS0QlhKEG+ttJ80NzW1H9DdzKYnsZ2yoWb3Z1o6c2rJrZ0xeN9wRWtCJwINbJVN+
         lXSg==
X-Forwarded-Encrypted: i=1; AJvYcCWxnRZzaJ7OgVL9KXu/P5PEyXatAcCYAk8bpZ6elB7sn9vqJZh9mvP7OWDDZ9zz3ugVbz7d7aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ09qfXr5s99lswN/Fyd9o/mCF05hRitDhLBNl/3SuxPg+1Jz3
	aDwTwhJ1GU/NSS/dUuWnTpi0Birg+b1Mb0WgUhr6PfuGwGnHO0aqZhHHdT6jClKtpKGW6BQQKbO
	Wlc+saMVdBUxJFLH1QC2jcZSdmEIKBINB1lWjGIn35cyqLCNTxdsHV8sZ
X-Gm-Gg: ATEYQzxS93t3pWN3utbzv/M7HCeEcABW+xkOcFoYqqFAwZJkJW1svE4HsJGQzGhu6F7
	/hLj4RS5HUpObuNFd2SANwJ3F4NRCtDS9m+25jBZPmbQVQ+o5oEcjZygLJTh43RygAS64Mv/lPF
	Hxfh1d2TBTtROvSLq0ANaEi9FMe0dUwesEDZ717h1V5g02iTbG2THPn1K7PW0Xvnb+jcLu3OeeD
	lmzlnxmli5bJJTbUhQaMAEWQkA+EkNmR5HCrZ767kGXuNPFphcMQKtIa/isEwWay5zCdDfnrL4h
	foVdwXnQ
X-Received: by 2002:a05:690c:6c8d:b0:796:5a14:87c6 with SMTP id
 00721157ae682-79917e81028mr68624897b3.4.1773327193647; Thu, 12 Mar 2026
 07:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311123110.1471930-1-edumazet@google.com> <20260312074630.52e7a311@kernel.org>
In-Reply-To: <20260312074630.52e7a311@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 15:53:02 +0100
X-Gm-Features: AaiRm51DzUqZS9-rk7PmraDgsCtiytmRlhUXUEfPIT1Ko9M28Dmg5IPb7d2hH3g
Message-ID: <CANn89iJbfsT5-j0iPWpCSsoDuOF-PmfbE9hL4YpEU7ucT8ipxQ@mail.gmail.com>
Subject: Re: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 12:31:10 +0000 Eric Dumazet wrote:
> > @syncp offset in pcpu_sw_netstats and pcpu_dstats is different.
> >
> > 32bit kernels would either have corruptions or freezes if the syncp
> > sequence was overwritten.
>
> And moving syncp would be too much of a hack?

I thought about this, I prefer doing such work in net-next.

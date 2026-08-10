Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7A04398FA
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386957; cv=none; b=tt9/diRgNQyS7MoWk8jGRTIwVydv6MCSE55gWKg552R/g9wR+VdptyCSE0ySM4ErJQHecvgX7JMHKyHNlgdOJxWPaBAh9gIRvImvKqRkj7y26K30LFxq0o1TT0PNklWQOt9xNI8OVLeCsKnElj0z+3BQHN3CMYm5rF9k9SkQckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386957; c=relaxed/simple;
	bh=DO3s9BCniAoxyDO1HNnd1VAYEwXmmI5rYbE75SfLv24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2hbvD8qrMrEePAuhjsao4pYo28lMkcLUELgXzpHaHzFRw0Ktp5eY6DEzx2Bczrk2378yWhfzdZAte7OngMVEzs41H8jRKb4DlRMieKyQVrv8Y1UfoXDWZwqFUEPsUhhebkIuzzHsv4nkOFMSFi9OwKzE1qIOnK1zMcLmCWQeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5T4dWwD; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5T4dWwD"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d0344e1ce9so11051125ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386956; x=1786991756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+o4vST46CiWorWhpB33vRXmQWSzdNOY7/3XtHUVi9yg=;
        b=b5T4dWwD5LaygCgf4bAFvOY/L/RBPVMdiR5ngNS6FejfJo1cKu4lnDzjiUp2knR+8p
         vDGPP57zZ2Y0nUbJiDc3eVzW39ValQZugD7JkIgQd/nkyOFRajTf26fUGD3P6+/dAfsT
         FnBw6RHKlFa/vlDxaP8eQRzRRxnQZemGqPLTShpFjuLnXwcYFaRNaVxQyzoxZRAajKVV
         NJxUe0Ywq7iem8A2evgChAaysds/brgnheBlqEYzecZk5SXN7qf9G2dh44cWKrfS2cpC
         sk6TudS7iPk8azU2nQp7ZqQ0/ociQfYCMkl9wNTlo3Gf4/ZZ8saw+j9qJRDhSwZT4ky8
         ys2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386956; x=1786991756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+o4vST46CiWorWhpB33vRXmQWSzdNOY7/3XtHUVi9yg=;
        b=ZOXen0lAUGq1OKafkrqc4H6TmlP9xM/35HAcB8SvupDLZ+6Uzfc4Xt6b1bWij9wsPa
         jbRUKLrsScn5eYOcvI+3Ni06qF2Fmom+eRE2w4gJQkniPKFDlD3C+fGVGjh6FH/Zz1H7
         sd1jNuUjqQwTKZjq0Q79nTDZUdQSucQ1hCeJNH7QGMtcstT7sS39UsjSImjY8x1BUFjP
         SbfUhFD9emHw5MSr3N3OJHUiyjIJL8OBbCaUoMORr46/TrUxndztTQ6J9uY4K7qobDJj
         0Ak/jPWstcwIcYJ5rKsi/DCqUYGpoJ/rbBEN4Io8YDCvuT2UqJVL41hx2ug/ViqB+rWv
         s4vQ==
X-Forwarded-Encrypted: i=1; AHgh+RonULDI7g/ssG7KuPezCAR0i2w8vnLBKoSYvONANVlOjcISJ2zyqWgnaVCZ9XzkD7YhNdL7ZKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuKXq1Ff3Wk5M0w0xYTDwP8PkK0/esfcd4PoaTU+kEyl8GY6/
	9jsghgEQuxrFFC0Tn2zPs6+SlelkH+tV2hzYLyILj5ePCe3up1VxogcISxJ42/qo
X-Gm-Gg: AR+sD13tUQoTZJleS8aFmhD5PESAbCorENa/LFTKEfXRBv1xA90MwB8/29ajbLM2/6z
	F9ZiIjCLz43TS8TxDEajh/h5nE26YMT1JXc4tqYCTU4v0sgKHv2OnDwL+e557DIMlq3ZGWbWaxL
	BTeGkhwbIJSpdjhKulqCtvBcNkueVgLNmttHXLztlK13TpKdhyDs4Mx25ItUaADTeA0WAv/7M74
	schqbAEyPP6dHt+6Y2mk0aDEc4ptI2BLavG2uYmR33I+e92xhqU98nY4qCLCCzy1fXBFJskqXnT
	3ZGST0ur4gpPbDY9ipRClpLR1O9oBHQXQRTXqG1em/QMvp3zx2KRvROC9ruKCGN3m+UoFfUx6uE
	FPb3rZhetPf+/0XKSHTLoMOkyJmabCPjVIG6HnL31gzYTmOXKq51iK03+L2ef1Y+YjRnzYVUdBE
	riOVajz1bQydeIC71AS91UBZm0dFVBokbTR9Ir1g1PbUrntUpvGNCwHIqeQmbcJ1rL
X-Received: by 2002:a17:902:f70f:b0:2cc:a977:4260 with SMTP id d9443c01a7336-2d2a8fb8adcmr279979815ad.21.1786386955834;
        Mon, 10 Aug 2026 11:35:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbea7e0sm39841335ad.53.2026.08.10.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:55 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:33 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 4/5] selftests/bpf: Test forbidden
 bpf_ksock_send() LSM attach
Message-ID: <anoZ7E4EpB6iObEy@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-5-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> The bpf_ksock_send() kfunc eventually calls security_socket_sendmsg(),
> thus creating a possible recursion if a program calling the kfunc is
> attached on that specific hook. A filter is added on the kfunc
> registration to prevent that at load time from the verifier. This test
> exercises that the verifier will reject such program on that attach
> point.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

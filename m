Received: from mail-oi2-f26.google.com (mail-oi2-f26.google.com [74.125.231.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B73C5DB6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109099; cv=pass; b=s/s0HpNXBMwAxYX/xIVVjHJvV/xZGuDbFvclMI3ETdjF8pwhILV8fLiIYoja/NWWPjvakBe59H4zVpPDj7NSepqc10gw0RMieP0J9ydmjEP2MUabldGrsCBI1PhAOcaunNHelOQoGmnLjSBkRcIWeXw9Bkxj4qn33tvqmtiSXfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109099; c=relaxed/simple;
	bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/C9wbRlVOiiWsw4kT0K2qDEw9jJWHVB5ykQMqyiZrqroevSaCQnoKgrYsl1bnmvCGbcvvR35SRu1SL8LPuilvXlki+eftaiPN7VydqrVkmeVaaJUoFz6PS+q/42nFviRQqadkKo3ljzEWt8A1z2c7E2timwWJe5IfnIhZrYV00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0gY6i1Z; arc=pass smtp.client-ip=74.125.231.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0gY6i1Z"
Received: by mail-oi2-f26.google.com with SMTP id 46e09a7af769-80a18990c76so281977a34.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109088; cv=none;
        d=google.com; s=arc-20260327;
        b=SlWKMW/WjyfCg+BWQ0xAcf2YNqSvSr39nhnNfmC4aHW4eCuzEFjLSz/0M3cbek8DDB
         Z9KcUlTW99QwiWYbzHLm/++rHDJyG9DNKqvBVpfzYHxvkKAW8GycKJEiZBTtFY/7jRHR
         W7+jFIliClTuqOUQ3eEofcxSSlOAdp1yi/i+KGI7bjLgo6Sk5ixs7kPIby5VAVUUL0BE
         2VfV/9iEQAsfb74Zs3ais40F/Rd6gCfk1eDwlJpY3HTxh7C1FEiryWzssgtrsLlwGNP2
         iqIl7q7oRwIE+1wvN3X/06CRvnhwwpG2rCvVEWK/P6Xon+d5paCt0HY9K2ZTjqzhy+D8
         K/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
        fh=Dw+SU76GjhTWF1bFuCcAlzmfBmFaGYLXqsiIqBUW2pw=;
        b=pcNBtfx/Qthzlw6WGyfHqUG8vvwtfwt5wvEeik+0FuygAzTVHuBv8v/LyKgyXS+a4z
         kAvBIYJ3F4a25MzZUNWiH37gflctILaPFD64dkUHjWj/Wruy7OKc9u3ozzwdi8+4uhaE
         TmHXtT8N43ksp9QiR2ZkQsvt13hM5lk2QwWlm1JS/MQkkyilOfnFA1XkHiNZSduI/4j/
         Bgeb8pQOSKnczU/qYdz83GYVx75FLvFU+X4BLcFYPfg0518ja4zH6bVvmtzKC3ekptWi
         5SJtZtfkajgvUBxc4FRSOsRCMnw/03Bu9qThzkeCk5g7tNJySyU39nzIRUCyMKZBjfnw
         qxtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109088; x=1790713888; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
        b=W0gY6i1ZQGKY1GhTGAYJT1Zysmc6u4VOq4inZtEwpVPrSt3tcJJGzZpmHOE4DdRM0Z
         OeoGLxhhHimmDgtdjmOjT6J2nrLUUZawwRD1XveaYcNuEL1YzGAaqRrDFPX6f+6b5eI2
         x0nia3j+mwbHL0cNzDNb4wcQ5RWdI3z/QHotHzlWZRuL5g69V54X78cGb8iT0/YnTh3G
         QzgqUAT3ZrzvRJsyUOtajzC8SnCZGq/TLNDLoN6HfzGGHvxngUUNW7gzEHqvELMIa3wC
         7X0CJYACHIHDjFZ59YVV60l0P8gsG+qMhu3AdCo7iijJtIkJSQV0cl8FVIelnLONwblg
         iF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109088; x=1790713888;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pyQVQX6jKLamp0uCXxk31zCcsl4nBlJoDrluWIu4huc=;
        b=K5iEqixvR5KB/90dsHv3vYtymSBScThI160AJ5LcqgLPI7835w+WTqDqmmg1V5KEeE
         O+7vPG4i6/Dco/l3l3t43gRjYeVrbZUNcIkfbjPWw7dCsQ/ZIaNFYu2tJApol/qqlhW9
         xhrBrIdUcPdGp4DE3R44Ecl0fVpRPrXh48VIK7rcu/ZJaA1MMf8zN15VapJIxPWgPkTN
         6SFlj7dKXfJdXwKI2qYZr+rna8mGHS8isXF8B6SCnwG2zvVm1f6oaAV8s3gXiO7qCNKj
         m0oTdL252uWRJwV95a0XtnwWFhG1qZbK90+P0GxKtpimFo6tc3razeKXi5itVfPtaKb/
         S/Kw==
X-Gm-Message-State: AFuF++kkjs2YvQtvxjfvCE+DPIHTZvBYtGn+Df8fv/5sdiMmltc8Ssak
	PLlrmVbdUsEWQMHuv1DTNrbNBeTY76YyYAc7MNnB1Ahy7fhWuxVa3ha3t0iYstWovKxo8tJzDDN
	QbmBissrAhRGd/ekG3MPUz2PJx6tXVJQ=
X-Gm-Gg: AYBFou0GdhjaAsVhg8pcGTfjMIhAfD19ysJCccjRZiCabGJJYadunv7GdpdzuS26p+d
	ZSUGVw9/bK2dsVcNgIJU9Vd3jehPUm7J11kDp568OSRV8SmrvEkMOsEcI3It7WjyJaGnPqcY7cV
	SFLqNKeDxl7IHLoPjzsS1mVzcMKdpKMOifBN7r7or9qnWxvbnrxOegdJSuM4+XFwq4Przt3dzQu
	L3RkPkebIluMdalsQzRnF9DwbffkdZHZC4JObsZzTKnugn+gyUc8F45w8IGDZzjowyzQjNgydUU
	I/8mXA9b0O1K+z11a5422to6RsOmDxw21ewxqN+TKK/d1Udf0r79ydhXB4QBUcsrtjdJNU1wE1v
	8rM8+xmLokw==
X-Received: by 2002:a05:6830:4109:b0:80c:d34f:5f5f with SMTP id
 46e09a7af769-815f242b7e1mr808405a34.24.1790109088330; Tue, 22 Sep 2026
 13:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920194710.1114748-1-devnexen@gmail.com> <20260920194710.1114748-2-devnexen@gmail.com>
 <arKF7P9gqq7ehX-k@sgarzare-redhat>
In-Reply-To: <arKF7P9gqq7ehX-k@sgarzare-redhat>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 22 Sep 2026 21:31:17 +0100
X-Gm-Features: AcwNN1XSk4_n-Pw8whwf_qkZon5EH5z4YSuf40SxLSGrNh11a3Xo3EAHx4U9uBs
Message-ID: <CA+XhMqwsoW1xyq+URGSuTrwnPo2CR5297bskaAsgHfMyyPPSPQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] vsock: report pending receive data to io_uring
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stefano,

> Maybe this can go in util.c/h
Sure.

> nit: can you add uring or something like that in the function name
Ack.

> Should we avoid to fail if it isn't supported and just skip the test?
Yes, will skip.

> Why we need this barrier?
That one is not needed, I will drop it. The others might stay; an early peer
close makes the hint report EOF.

Cheers.

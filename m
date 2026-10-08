Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B42D0617
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435971; cv=pass; b=ixzu3a+BS+28RNvrP7/lBGDqeIHJr8cozXysUssXR2e17ww5CKbAxoTltr8ivLxqQKkJ8ZRY15fGd1kIh91YwK374Qws/uH+DPMZe1Xf3J/SikW17mDECyUK3RBlp6q1bkwJVkVCQFWsU4crOAwKMS/CAtyNjJRPq2vDecl3qqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435971; c=relaxed/simple;
	bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dylr/Qciq/vUlqXJWv2thhsPnmhfFKqOKkmkshM2nRdzqzVSnQB/C1SkhPAPXtQ/KuJIlZ7Oarj/TIsw/tGgTcxxjrWv3EY7vwmEH1clqu2tXNGo/6iCacZdvfeYTNKWdhHF0k4/NXNVcEjFgK5agckZDGXGno0COAUdtVXNOxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2fWoIcZ; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2fWoIcZ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3515f9a5d25so3575666eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791435969; cv=none;
        d=google.com; s=arc-20260327;
        b=n26VK4Gi5AM4hsM+8XmWaUgl3TB82vMjtTNNJNM5rJz6UrV7hb2mY9CYXNeOKSVymK
         OLzscLwmQwhseQr3Sg7Qwnfv5c/LICJ1q8IZiQg+HEHnN/JCWVwVjKub7eNkYGbTxbef
         /Z/ifsGDMIAR2Jh+1l0cWQ2KFPdTzcVrbv5HAzCr3LxQQEq9lqa3XTzjpRZqwRpcCYPg
         XX/HRKtaq953UhYHxPUDUGWh9Klc6FX2U+LBzMe+zbmPsQLyyzs3XSee61vzd45yyeQM
         F0SrF02dHElZFtAEibqkFThy0M9v5GJq0w9HCif1od/QQ4os4NS6j2rloUOnK9oZLI0n
         cAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
        fh=SAqbRJyZOEK7HxG5gBRdqpmoiVGiHY4s3DusrMdCmSk=;
        b=qax9iGRGxoaovD62von/j5ShWhi8olx+/LZo2lg4SPeIu6HTEZTNtTTrmBZETrEgN9
         5WbEKJArX10sxsTz5U9oah4UPpmHudqpkm4TqZkGuHOl0NA9D2v0bLglsaeK78/R0rFn
         37S67fMm0abYOjdXx23dY5Hvdvl6RdicQwQh0lQQzjKtNlswB7JIBCLPISaRIoIDpeBQ
         EatxyAVocYEOUqc/GhJuoayHRCBzGoB28J+Os4B9cPpRYY0NleZ5sRtFV9uUg4cWKJJG
         TnQTo3xqA34403GZJ0zYBmpo6ZkE7DbDB4Fqf3zyXle6LcFnktW759vIn906N1gjm4jn
         tHXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791435969; x=1792040769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
        b=j2fWoIcZS/tDBrGxb0MRjhLY0LdvvVptsmSDXaXMwBeCzA5hDXnCAaYF/lm6r9+xuY
         DTHA0LJChgow5DQ9Lemfb1vFhXjc4Q5v+n7/pyXlbRJe4XPffgvtkfE+vX/ryzh/Gem+
         3h6YAgR4QSyr6aelvtGrmdcWAhCzrSCD8HsboXZ7A0bKSAC0UMOHxsVO12fLYUs5p2lm
         Lds9w1I3labq7J/wU29kPvvOfEk0PiINsOhAl4RpNAjf3FRBnZwsjD3wxLgHIKe/KI0v
         sP0lY3tZ+WZ3t+F18SrZ055ABY+NUHiXIhn4dsVsP5hf+fYYbje6CBbDBIxjfk0M+FIx
         Dt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435969; x=1792040769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhPFUP+norEZwv0KY7wpIyhM3OFW00KpZAcEkkSv3Ro=;
        b=DtiEVfyfEHDeK/jzY2HIth8OoXBlNQPc3G4uNX9cLw/my5lNIM6YpRVMSnslXwtXYL
         DsEiAVuhpEBDjuE7CPsma/d/oyxM0tC3K6CDutDo3DBhSQpN+sin5eCAjX3nUO7YP7To
         5GxJKULDP5rW0B+pUOlb45lsPUx0yDDyTVzix4v2mXGVEeDs3o/YXBn8sNgTnWXxk/NZ
         68pH/y1HInzqTyQItxXNmWCph+HMOV8ekbIcUpqhLbNub+fo7cvwDGIGSVdymDCkJoQl
         67AxI73rzTwj4l9eNf7911bvHCs5qQ+d4XksKfzwiiAsCXKIuSjcRWAPr5vTYzRXFPDq
         r9eA==
X-Forwarded-Encrypted: i=1; AKwUvBzYUeqaetg9YCI04SH0yBr60K2qkV+Barci6d5gkmRerKPkcqMfKe7HuI7FXNdFf2F86cBj1Yo=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ+G3Mp+tY7Oj6IrDwd/+cWMqWO8zI7lX3lCt1bIeW/u40DIZ+
	KIYHCfdOc9EqpUoRGc7eU7kIW8YksTspqyUicpHWXlZEMMj7pX95iiii9656lgOxf5FNuons6nQ
	3UzsHhwY0j521njCCTI0YXVIk9Ou/KuyM/l52HyYM
X-Gm-Gg: AYBFou3Hj1uL2GlbWu5MtgC5UToWZG4YOGuNsT+xPeFGldgs4P048peY4Qs97GCV0YT
	gzufqesucjZzFvzUxonxPmsL31S5XN8rgJCPXjQKC69SVlBkmlPTFCq0qtppJo3hxYhVSwHzxH1
	A1cR3BQq9iKZuDOn6sJu7ti5k7ha9hLGsaVEwNF/PSQ3/GrlKSMOYxVCxAcn04x/wx4bR1HshYZ
	ajaXkfZDnXeajr17/ywWQgs8rWzkhnCmHoCcuH+CddrcgnKS8/77rXt0kJlQG0FiWeGCeDyGQlG
	IFOKorsn/rwCATD5JxXOzYlRT080hg/U6JkHqcblZBkvbS17VhlN9oVaPaCbmA/NAeDj7xHiJHg
	i+Hv79lTEiD2AzxY1hArFs3iRqf/ByEKTH5+Kge4LFLRGxrNIhP+KMJo38g2/CIfEPMgyBRJ942
	VYdcapIoE8aHvdSE6h+TaGxvFX
X-Received: by 2002:a05:7022:7e8d:b0:145:287:ce91 with SMTP id
 a92af1059eb24-162059dc702mr5384569c88.14.1791435968320; Wed, 07 Oct 2026
 22:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-8-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-8-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 22:05:56 -0700
X-Gm-Features: AclHuK-LcxOkOXzytf3Rr7yhTplfpto8Gsq6TYrBSnMDE5_TeVNBitGO6FALDu0
Message-ID: <CAAVpQUCGbFYwbJ9GjTTFr79Z5-NqQ8_V=_hE=iRRSGf4Vr5w3Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] selftests/net: SO_PEERPIDFD_THREAD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:10=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Add tests for SO_PEERPIDFD_THREAD.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

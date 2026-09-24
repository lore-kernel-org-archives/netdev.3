Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905C30E827
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268402; cv=pass; b=PIcTYQ9gKHXUL3VBhnY93OMVPNudlc/1lP8dL1sQ2cTJjKwLY4aM3jSzwvsWEWzXZ+naTlPzI9aUA8zJLGRK6EuasjZhWtJt6kM5AVk8pZoRvY1EfcXk0CEFBjxoqRNsxdc6tJF4SgWCUaxQsg+TMnluNZwYVuNKY0qxkox1ffg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268402; c=relaxed/simple;
	bh=1cXW3vatV8F+/xKYHsIZj6m0oENun3ZkfwN0yguL/Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+g1KJ/Wp8MuR5EXP554vFd8mwinCq8v/weWJrr/JENi4rYd/FfvQJemG1pWYHvA7CKFtX71vRSEzLjQcVuh1Sfbp/ZBHeXjsKWXw8ZjNyeROtXGgGrivmANPNT4W3Q6RNCyHPjd4qymMjIj0nyBGwOV44Yu0xCk+MzGi30ur4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/xn51l6; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/xn51l6"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a9d74e8292so13406a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790268399; cv=none;
        d=google.com; s=arc-20260327;
        b=mSMuhLSKLe4wulIXAGBlmQrCRB02MvkjHt0ASJ5kz+rB9IhP1hUFiJjFfl04AtLEhP
         +d8SeHoPTzACSCiarxPTUY7f0xoUD3V8F5wfQY3TQbZ+GIFaEnP5xWs1zHO95y7KFCC3
         C5zdduGXT3p+FT+MaKB3RgWhBhehAqHM1vmq60nwyaAa2ZeNfUP0Bd2NQJfOCJihnnlo
         xLI/Xz/BtjtKfGTgAWSVOcogZQmnUpJV2EtpRfKFAneNBzqZl5fS1VaGCX9ETVZFmH7+
         IokMDJz2R2ftDuGLrTW+fO0/gYNgGLuMHkSFeo7r+5lHzdcZnfIzf6RKC/oYYrpvm/pg
         Cucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cXW3vatV8F+/xKYHsIZj6m0oENun3ZkfwN0yguL/Jc=;
        fh=4ZUk5U7c9nUD4wgmp57hC+hIzWkmylNRxB6RTkYSLgs=;
        b=SPC1HsBFTj+W1wnrBXXKPj4gvar5aWDW0bPlVTHbbRhrEz3+KpeLD/SN9BOZaNwKEp
         b6veqjSRNqmAlcwT3hsRaY1LKEeQvBrAMfskfk7jozmsV4aI65WjERybWDA/hnV2heUD
         C4zXjcwHICnnSG5g/52wm7aScYTTpEGXfZpD54CL6reRZ55b/3n6HzBdgMgylSvFgOwS
         mWOQqJyBx+jWrPQ8teoMtsPzwfiq9gsQsLFJFMDt5drrQ1FRSHKMJeB59Hy9UsKuIa7M
         g0ZWZOjBy07P8klUBGQoL+11Zj7kjR0aVnCjSSLIcMAK92kfyGzPbsGm0tiILFu7CFeM
         LsrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790268399; x=1790873199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cXW3vatV8F+/xKYHsIZj6m0oENun3ZkfwN0yguL/Jc=;
        b=W/xn51l6NzSVih2HqUKdXGxxmv4Tmrv+s9GKT+U2sVRnYb6kjsQqjfomhLL7OKqLrG
         iRvRfa2wKty6g/b69ByMQYVJfkaZnJPOrv7yBvpZBC95kv5LDAPdD4mAvJgbG51cHXjw
         QNR2KSdquQeqzvbe36+RKwMApMamenkJfN9UGRSSFBv+b7ffUEs/X9hBqqxpuwMyOhp8
         TeQ4RosMgzmFeCNPxn40ZB0/kwTyt9r9/DKs+bPAGkNQmVUmRb7rC7qlfEbTLPvM8Y04
         3uogy7aVb4Z+dNZ8w8hoRLMV78VdDBUXsRZ27I9ehpImH8BMlBWKy54iikmSfrpmuqZ5
         DFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268399; x=1790873199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cXW3vatV8F+/xKYHsIZj6m0oENun3ZkfwN0yguL/Jc=;
        b=owM/xU++q0EcdRCXy546MFQjq+Af4mbX3PjqEHJ4rU3fiWHfAnZq/tiFhRit2l9El8
         Hsrte79u9kjaoW1I4ue+K5qeTnuu1tEyl6DZDHI02z9iDjsG7vbckymPzMamJm/CrwKm
         dFKEnu0ohenEfn+vWvij0j117CfxZfVS+6/9ZRujt2O3K6o8zgjNtwzv9y/BF6VO5ffD
         +pzgVCY19++HvA47GhFrzPDFVSV6qdEqSaCtxorIGhKGuM0zCUIx4kCxxOT+KIxMjDLj
         kknxMV2QjC0/MleW5Rcir4uVWAg5nDRr60xa9tH0qaun/Aa7W/dw4r3cwjcwYRniVHhP
         KTJQ==
X-Forwarded-Encrypted: i=1; AKwUvByyLVNfUOFkA6FkrFyuMytdI1+u1/mVhm0ZCJWCn0uW2BfqHa3diQcO1/TfxsY+ldlPM+pej1s=@vger.kernel.org
X-Gm-Message-State: AFuF++kTCbOe7FxglH2T5XcRrsQGB4AS0voIQklMnwUkSqp2spqmYH+0
	MUZyv2WBgKs+a75VI7Zjfy0lfPQ/cy7XkIuGpKRvOt0k7Rqhjaj+QA8YRO1jSjr/oWcj2XbL0cf
	Ol4AZu6end9zSlxMBAi6vFwWAThPItn67oeIufdXp
X-Gm-Gg: AYBFou1JWyjAJ4aaIY1VvKJsR/HfSUk1tE25ZqNlghIgVAUxUsaJTFObbcplgrBpk7u
	nCQmql3ZJD4yCg4DHl3ajWnsPaTHrPWaUyKj1vKDzJBAM8OZkmTGiTeptqAIVRBYSt/Kx3FyWLO
	Q1SuZoc7mlt1IxSJpO1e7jEBvN2GVoQBIEt0BwWnS1uMevEz/K7rIIb7O+PwFh7RqXRAI+tDqIc
	8ezzUTDAozp7/105y+uGxPn3ToM/DtcfsWUNF7emNxac/L+GYHcway4452sjzwR5g5oS/7TlCiS
	x7Ilcde72k49Bgm3R2GXOAyudkRmrk4x/wUiGscMwqvo50ko8GW6hZRnnr89FWORmjcMD5A50Jp
	BA4Alcw==
X-Received: by 2002:a05:6402:3245:b0:6a1:4eba:f09e with SMTP id
 4fb4d7f45d1cf-6aac81acde2mr45538a12.7.1790268398282; Thu, 24 Sep 2026
 09:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922204348.717198-1-sdf@fomichev.me> <20260922204348.717198-2-sdf@fomichev.me>
 <CAHS8izPwLBCJXM_0Df8P6S-FVwAq+TaRKn3uTh1h=33Ffj8VmQ@mail.gmail.com> <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>
In-Reply-To: <f566591a-cef3-459f-a39e-86addb0c5d7e@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Sep 2026 09:46:27 -0700
X-Gm-Features: AclHuK_lFxOWKHj7XdxYi2ldzbsg0ymUR3nA9hy0ZeSa1JCd6RB5vZNVqgY1d-8
Message-ID: <CAHS8izOwo2NZGaxtxaMcjDu1APY7ERLjsHN4B_Oucqs4jZafqw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist helpers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, axboe@kernel.dk, 
	sdf@fomichev.me, bobbyeshleman@meta.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:41=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 9/24/26 16:02, Mina Almasry wrote:
> > On Tue, Sep 22, 2026 at 1:43=E2=80=AFPM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> >>
> >> io_uring zero-copy receive and devmem both maintain a bounded LIFO for
> >> net_iovs in a contiguous area. Store the freelist in struct net_iov_ar=
ea
> >> and provide common push and pop helpers.
> >>
> >> Leave synchronization to area owners. Keep devmem's area adjacent to i=
ts
> >
> > This could be a follow up change, but I think synchronization should
> > be provided by the netmem/niov infra, rather than the area owners. TBH
> > the infra providing an unsynchronized data structure and letting the
> > area owner use it and shoot themselves in the foot feels error prone.
> > For now we could use a comment.
>
> I don't think we want it. The duplication is minor, but I'm not set
> on the per area index array approach, and it'd make changing it
> more difficult.
>

What is 'it'? I'm guessing you don't want the freelist array put in
the net_iov_area at all then? Because even that change will make
replacing the freelist array hard to swap? Or are you objecting to
just letting the netmem functions do the locking.


--
Thanks,
Mina

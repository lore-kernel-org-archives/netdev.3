Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40783FA5F0
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750834; cv=pass; b=IKLxacib9XlnFU3jC5kYzR8MVkYDrK7j721yIDhz7AYUD2Qfu2+4++Nkz4n6Cu0N7oQFvwY5iTzsN6WRESYlGIaa5RfyhzVl8GxnB06FgH68TEPHgcx9eyk8eZzDGpGAgRhi/ahhrk/+fOlElGjWySkqIP1sVcxC53XCu9a5f1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750834; c=relaxed/simple;
	bh=xHcPaISUtz1B8fOHnPYorZ9jbOCvXaMM70oogJXim0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6wi4Ewwb48S0U/9nO141i34T/5F7NXAnTbUhvE2pT+p8x6F5hrjFWc3NZqdBcHokSQh38w9HDH7Yg21Htz7hdeOu8yMtqvs5wkywXNd7T0CAQQFdEl7xdxKXUdqwwtonDHw58OXusm9wOq66OCo4FpDK2pm7i7WFww2jNNeFEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cVWOEzHS; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cVWOEzHS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848743155bcso3816172b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784750832; cv=none;
        d=google.com; s=arc-20260327;
        b=Uc5eXvpdEa6WMNbEpkOpMpORx5DHczPX2k5VnXnXUuJmfqixQ8U7rdRf0iwXCjFux4
         JPnT253uVnASmKJpwsIb5TytTDUSeqn0M0IsDMrw0VNeAgv5ppkEDe8BFiJGWMdZHK5E
         /7R3u0wQ0kJPQvaJGE0HYoFj+JxunuTIybSREbwg9EBtHlV7fOA+7f2qymgHRBpH5SbY
         B/6FuxhH2VRprUQdW8mhgx3KIijFhd3rG5bocfrzJ3mtc8wWw0Ly6RKxZcc+q0vory3m
         SsRtsgTu0JvkmQMfOQjLdKiIdkmcAcbg/H8Hb0B86kEY63LyTkHjeD1iaBSKxrVLCX5w
         FZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fGv3sKwue91Jp1IMJ42L3qkjCq6etFSBQOQqlp9Euxg=;
        fh=Nzz69anz6nMqcoMUAmA3gfpsneupBE4a5F822c7getE=;
        b=OwlgpBfNfCKvlFdw5FrYHqjNbfyTxH7Bu9/zJuvsit2vbOY2ZIUDl1NSmwE5Q7E7X4
         aLZdf/l3U6KdtmqE0aRb4L5d48EoQhS/ej5tKOaXR8Oz51KbxA42N2Q2tWcL5ryAbBuz
         SJ2LdJJMKoomndf1jcon7F0vPyNFfZBxpvaLMrkjIH1KZXBBF6nwnIJg9SUfss6NNu46
         jVefByuIY6NZ9kBPvEorYe2hH+J0lP7ZcMDajLcXC42Xt9/tF4NoVEW58uhfDNk19ivh
         hqk7lpqjB0MxQu5PowLFwp8N5e7oD2Iv27nIkeVX4HrIDn1NWxzO+SfDJKrbo1tsGlT3
         CmSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784750832; x=1785355632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGv3sKwue91Jp1IMJ42L3qkjCq6etFSBQOQqlp9Euxg=;
        b=cVWOEzHSNo40xIvYtyH467HivPDMnsF7F/hcWX29y6uR4jRTCrDo5on7Y7X+HKRlC+
         ao8eXTLAxZWDoWEx6br+F2JyFRjQl2ROvWL/2wRM4Ex/KAGafEQ+euYNiJwyev9/jMNQ
         r7kHfSpSZkmj4IQPODpij1ZyeRBPi7cdEvl8tUovdh2H2Kdrhe98RrC54G19lUmCk97w
         8hHb0cQf4AgWCSchWlBpjtrFIvSU/5EvUabM6p8CsxayINc5CAdJO45kdVLRj9y81ZtC
         uhEuERDhVgnf02jmDjDWUfwTwd9A+r5VU/3JCrI1bG74isEtzkmOqF4jW9L01U9iyJgE
         XjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750832; x=1785355632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGv3sKwue91Jp1IMJ42L3qkjCq6etFSBQOQqlp9Euxg=;
        b=b3n1P3QxN249ZuOOlK3KBWZ295x9T9HAstpbgKHQ7n/jMsNV0bkkF9R5JGpExrZ3Zg
         Sr5nQQ7Y8n2hIJmYXPb60sMFTzH862KYIuYCqsN5aSpNFfSjziRQjSips0Kp7A+1srlK
         J7phiR8we2L/jGVDNwIbQ6yYstd/HFaJ1BiNpPJFCfHvC27trneef+LB5tLJFRgD3UvD
         R0pT7Cd7tL/VYTdq31yCtZvsaBKlBtEl/RxW47Y/qrAi2QUjIZ0c0n6Y0JRvE5BvilJ1
         TguZXcX5pmymNOC1UEoiLAVZZaxUKlGLgiR4pGOdEgDPBoC4z8OjnhD5J4gmmPEDYBBP
         IGMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoCCmokWaIj8UTmJCo00dJORYtryMld1Y7PN0PUdZGgEPJEaoWtdVoUv/3NXbnBm7pN9qr8Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJDUhqVi+h0Ftrg9OrwhQuTXmOtfJ4yeiVQewOR61eiYGSrkj
	eCxkicms/L+E0w1IOYYw4qNb6OI/Y2cZB9++Tgt/o9zri8YXBOTnuAhKCC5vvaH/AfbETNTuxfX
	GlHM0Xok/wzXljl3Z6hueqHDMA2gj5O2bVFwdllbW
X-Gm-Gg: AR+sD10/u+0762KfB1yzlSDhm8xra4Vx9XsGihQ+wcSEOZz+AyWsnpD3HsixEMVPNg5
	hrOn36Ahojol2M+dfKM0u+pMHcX9kEQ8FJEOFADU/fNhax7m81dooXsdMJpu5UKgBcqIWr7T2D5
	7VB3VoYJ0VuqNsdjrBiTTFn1l3nkQ/Z3rZdOwzClbAEyeNhjhZ9L7iJC8ZuoyQc0hpNdQj3ItNC
	UIkUNubtR/3UTvLXiY2jPcDzi7eDmM+KVlDGEpNWP+9tTgiZyKP2pZ31acbd9Jvj8R9RzYXzz1Y
	RTtyucflPbbdD1UXgg==
X-Received: by 2002:a05:6a00:278d:b0:848:2e3c:9955 with SMTP id
 d2e1a72fcca58-84e2b82f7c2mr359711b3a.4.1784750832014; Wed, 22 Jul 2026
 13:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714212239.1511269-1-xmei5@asu.edu> <20260722112719.17665461@kernel.org>
In-Reply-To: <20260722112719.17665461@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 22 Jul 2026 13:07:01 -0700
X-Gm-Features: AUfX_mx-yqJnOpcfMEPOaEX19bsQKnvPlcLtmh3BL8I6eGX4G775jKjDpzEbzf8
Message-ID: <CAPpSM+RURyJdL_bXC_LX+ai8R_s3AP2zK9tOq6KnEjKG6ccdDg@mail.gmail.com>
Subject: Re: [PATCH net v3] rds: tcp: hold the RCU lock across ipv6_chk_addr()
 in rds_tcp_laddr_check()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Allison Henderson <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 14 Jul 2026 14:22:39 -0700 Xiang Mei wrote:
> > Changes since v1:
> >   Use rcu_read_locks instead of dev_hold/put
> >   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference wh=
en IPv6 is disabled
> >
> > Changes since v2:
> >   Add change log
>
> Why did you(r LLM) leave this portion of the change log in here and the
> rest in the correct place below?
>
I added that based on Allison Henderson's suggestion of v2. I don't
know how the change log works, so I may misunderstand Allison's
suggestion.
I'll do some research to fix that in v4.
(https://lore.kernel.org/all/f69ec0975481ad04dc7403834bbb6b93d1092ecb.camel=
%40kernel.org/)

> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Allison Henderson <achender@kernel.org>
> > ---
> > v2: Use rcu_read_locks and rebase on rds: Fix inet6_addr_lst NULL
> >     dereference when IPv6 is disabled
> > v3: Add change log to commit message as Allison suggested
>
> The patch does not apply, if it's still relevant please rebase and
> repost.
> --
> pw-bot: cr

I'll check the rebase issue, thanks.

Xiang

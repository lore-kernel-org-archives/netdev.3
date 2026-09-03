Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB839CD0F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423371; cv=pass; b=uCL9coWAbBEPg3mUBtN40qCqMqpsgNTXeJzwSp9RXVpo/dnzJLnQatFvB9c8aRzGOLBemz+jED86BJPYiyMG4QVHazi2oOYDRZApx4FufbJMeb7Duhzn8XRfmZ8C0XiyLWH7url4onSGpwMo98jyvMLpj8LIFPZGkMj+6sflbVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423371; c=relaxed/simple;
	bh=6VKF61Qh6cq44dogm7XMikkysZ5UlAE0+1Jes2tyn7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8RCfZDf7tdoiT/A+nxhiVZza0alwz8wnIHy33OHqI83IL/HDQUIBr7iSQsnBAAAfc0JcZhzLV0GyXeIBNFjFZXqjS7p7ZW1bFMLTf2UvFoe5qTXOjkGd3hWJVpl21xLrL42/sK607NdeOrI/jR0uomDzpN3ux0EQ+J0dayd1zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fu75ePYl; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fu75ePYl"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c0c45c580so21015011cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788423369; cv=none;
        d=google.com; s=arc-20260327;
        b=L5hQ7r3kRyOu0bWbRei9VN5V43Oq1H/Jhbi+1AbqvjDzt6gcYMlrzM2f9wUXdXiRgW
         CKZdRgbWWZdvG8LR5tBbMi5BZYhYwdFPofe1vUABvfgK3eVdhD3mGtyXSSyIp5KROMfp
         70viJYOAsc36JgZ7sJeHsuGnj0GoosW7qW9gHbSJ9U3VhsPavkwjieuTG3ZJ7zyDM5Yl
         zJn2fCNresiMsz7N8ucPckp+wiH5AgYF2XLv0NLRPuzC2ydDLyR2XcKVSCLrIVJJVMCy
         Ag//LJPTgohYLiGgJrReKJ0PcoCkYGwNuzgPXvy/ug1zM3qtWcPPSZtnfq4tT1LFXt3F
         NhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VKF61Qh6cq44dogm7XMikkysZ5UlAE0+1Jes2tyn7s=;
        fh=lNUwulS8ccmV6DOczJJEFxsSgWdGk5piWzrq5CBYcVQ=;
        b=FRYqzB3MpZ9iFMQRaOAFksX4RCkFTv/PAOEgMPkm9L6WZMpE7BbsXkEKze/QPYH72k
         CTTrwr7jtLe0rnCyZvpUcx3iOtH3fCDzYmJpnAEukgBlCrnyIBUuWLL9850LY4ofKa5X
         aSBgl6cS3vBkKXt9D1GK1WJrn5c6MUvfK0t/T0KjppFH3DoCprzFijBR5atAemmOxQP6
         c5rwrl0IkMYobMag/ZHhufodqk9Q++9XdW5zb9J+kGfVc3XyBnAraABvy84IKgnPUK5y
         wMC1WDPj4aZ1XQK0tcFxGCb6jQUp4bc78ow2ZOWg+I0fJzShF8QdSOQCKJdmsAgqTujn
         lx0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788423369; x=1789028169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6VKF61Qh6cq44dogm7XMikkysZ5UlAE0+1Jes2tyn7s=;
        b=Fu75ePYloe302tn3PPn8HAavXkIYmW3KNa8FzzRjNB4XNElNFvXRkxr8H2MLNcICoy
         qj1BVxz+PqW7gl7TN0Kt2/b/FctV1cIALDS/Pflfkz864KCBgh/TqPMywKxV99PmDjGQ
         0HAn9r2PIVMw4LLMVULgKriT5VfoUkbZPMD3zgxiwB7zhfYon5wP79/bUZHsaXd00wr+
         rSE6SBqLc/xU8eYNNi+9iRhmzjsq/i0RpEQfCr+DV8OUCzzraPpem2GuWihb5yyhGLhr
         5b13G3xQn2NEBVRCxTFshpWLQNI3clsvoAPTMw3nrgrYY9ZZg+Z7qLaNZWWjjt3taI4W
         6OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423369; x=1789028169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VKF61Qh6cq44dogm7XMikkysZ5UlAE0+1Jes2tyn7s=;
        b=NrhS3cDexkTZB2PBqiWr7RbiKLAk6W9e7sI1EMpu/mvLJdBF2hZW8r9vtGHzG92OUd
         GADE2kdvdt82AnXfR2kw/z8djd4GSfW50nl9smEOqFrCkjpT1AHT2Ll+//gHxkcnNDZS
         sx1D90eAMNcF/BdNR43Vg3WeRN56Hk31/PLLRKJm4CEpdEYGFEEPqhx92pJwO659fjYF
         54z+P61prFGMmpMP9KAcqGTyHKQIBuZpjkDkpCAWl1uKZEDUfYuXbXexiOTH/vcH8XqC
         nDf8OVadgjZc8GNy68Xi78ZDf8d0DX8+0u9JIIU9AlaaKBgyLW84ck6A1g83k4IgilNp
         8Y0g==
X-Gm-Message-State: AFuF++mMkOh+wXJSfXJBeq575ZIAI6ogu0qezWpZ0FnWyGSDavTNnp9K
	XBdI66gC6N0czN0eUKi9Uv2ibriUtTKhhT3ZCiNKYOZpeTFWxUqJVB6CtMAj2N8wYGc9oZMeMw5
	RtXMTgKHiX9srkrAG6XD48rwXHN5OKsS/4GKpf/21
X-Gm-Gg: AYBFou2vJZUtqZqjCnSEgKqkMAzkyfI/d1C1B+UNiL3ACD8WbpSovrLMOyyI3xNORYd
	JJnoV3pfqAkPVbIxQcmGwAwA6DuD+WQC0MPOPAreZ4Ugf9zVeL1FGgM+fnVqQgXuKUs9Ramq6ZR
	CsmEdRKw8oQId7rOZxPkzLW9bCRKEAFANLsRtU6ikmWK9uL9UWa+NKj9G4U+KB8bcwLTBhY2J/D
	bYSrq4IicehC4zPpkshUniashhlj1fvyC3IPHt979UwO/Enw3XELyZ/37o8XbLjha2sJkuEdBEB
	eYaoNTuRlnOG9uR8szxBo6W8FpyyzXAV1/edZGeUYsp5IY1Ld61Nnmmx5luIY1iEDcljGt1Lgct
	2+d78EjX/MFb88uvdgcL0cPJy10pnYBcqG3t2IE/AKKW8MF8SdMkDW4LzC11lq+9HvzXq
X-Received: by 2002:a05:622a:cd:b0:52d:8854:3e61 with SMTP id
 d75a77b69052e-53036c85c28mr122279731cf.22.1788423368155; Thu, 03 Sep 2026
 01:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903080259.10378-1-idosch@nvidia.com>
In-Reply-To: <20260903080259.10378-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 10:15:57 +0200
X-Gm-Features: AcwNN1WlHZOPxE6l56sckreWuI1XoxKxh2_dYn5inqWRdTh4GG-0wa0YTvUUvL8
Message-ID: <CANn89iJhRa+Ut+fFk=bb=Zggx4ROiEQEGz8u0h6+c_fx8nnkWw@mail.gmail.com>
Subject: Re: [PATCH net] nexthop: Initialize extack in remove_nh_grp_entry()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	kalpan.jani@mpiricsoftware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:03=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> remove_nh_grp_entry() prints the extack message when a listener fails
> to replace the reduced nexthop group. However, extack is not
> initialized and listeners are not required to set a message when
> returning an error. Neither netdevsim nor mlxsw do so when an
> allocation fails, resulting in the dereference of an uninitialized
> stack pointer.
>
> Fix by zero-initializing extack, as was done in commit 6347c5314cee
> ("nexthop: initialize extack in nh_res_bucket_migrate()").
>
> Fixes: 833a1065eeb1 ("nexthop: Emit a notification when a nexthop group i=
s reduced")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EE3AE6F5
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625803; cv=pass; b=uv0Jw0tTSt5tUZ1mf3KAM7t/yfUHq9CFLA3BvPQRvFYt6MGUSqCi24uBDVem4yEBxNbom/rFj5VMoCsEOXBcQz8rSF282yO3ADxdIB8yjmCIyfmUFj4VG/wbkyHuQRhC2XCsQWILVE+df1iVRWx0A+pAfoT38C4WZqiykhsa9k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625803; c=relaxed/simple;
	bh=nLXEP04A1YohlmPKKMxDDWZc9Vo4kBu+XUJyHp0Ehbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpWJt4jdEGcLq5AultOQfDkNWYQ916c4U2uxMqZmI4VjT03H/R/8KFS32wDOF3tZcAcSwA2taMWMa2xNMJkrik+kdO2G8q0Ji0Mr1wL5pnYnwiIZfEZkJ/qOYIieYPONlS5KMg8rPYEwGdouUo07nd4kP/HDp9ENu0FfjVpKUoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzuw+UtJ; arc=pass smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzuw+UtJ"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91784fbb60dso2492496d6.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790625801; cv=none;
        d=google.com; s=arc-20260327;
        b=UQ0tjPqGQRP8QaDFmat6S6gx5T6GUGpSwXcR9p7A88N6NyrL8dJWMbcZkDr1QzyZLM
         m9QmY/nxNReW7QcxrkrNvwCyCLvuMHeJSFMQK1XV6IleXDJcYCtad2gxKZ1Q7lKszfxw
         O4ZwXifVpkvj+HpBbrmNKkKZ6HKPkV9penlSuLfnQp4NXxz1W+nD0dsrw3yxjwtpOTqc
         HjJR0B5xTk7wTO/URDeeTQaFCNaANru3Nwk0a4hg+/uk13eY+2AGp4gPkXFPiiMamohO
         zMOorJJu0kx7IiYkfl2VX+zLv3NlEOYrAZr5Hrv3OIu7tE7RypZWReWamE70lkuqtx8s
         Ry+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nLXEP04A1YohlmPKKMxDDWZc9Vo4kBu+XUJyHp0Ehbs=;
        fh=ogqMU99nUk3ef0tLuwZ5YxPAxqr9O8wGu/yjRb/a9zk=;
        b=T01K0Z3Q7hrDArZXVML+agKCMt+dXEQho+ncuu2HrdrSh1yxI2gAK+BVr4v/wXosLo
         1XHmgXhoBW7kdYvNRUA4lAJ1YoLYOQ7E4iSwdEMXC+MYQTt0Do3XU/Glr47uCZJGJOyp
         iMzU3MTOTolerIGfFegTHwBtOeDVmPFUl6UDxEhbjdy9DKKzFKDfK+FAIfGLTKmHWVgz
         /t4Je0kgJ0Ul0JmveNzdLUS4kBdeLjtg5d4TZ1W2UEKsfXTaBif8btj6vIVjKf31F9Dd
         ZQWv/5QuqXzSpdZRJedBIn8K3PIlTx0OOjqJcuEKFGttPAMCBhu25cba9r6xLPQP+Xlh
         aj7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790625801; x=1791230601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nLXEP04A1YohlmPKKMxDDWZc9Vo4kBu+XUJyHp0Ehbs=;
        b=jzuw+UtJtp/PA84IvDBpVbMvFgohhTdyYMwltnR4KH0IERHMAopDbp95PfvoQAB+2l
         MPNYlanLF5tWvUJ5FgOYCOlWyV0DtV2gdJqCpxBtBnLb804UqQV9OywuNeAtbXTWuyN8
         J/GJd33gjQjrUCn9N5ZfUTO51W24gmYdNiDwK9bQzUjqhjroagWb0ISGW5b96MzpgYPT
         oitjjM1rznJOLVtUPQh3ANs6vly6BnL6QGd4cEktLKSURSQBQ70nG8y/t/PVepD47zot
         jfzYf4jf69xcI4uYL/EyCxYkNIlbD2mG8JkOYhQ/qzTcm0ulsj395z1xUUOu0KICRbPu
         iJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625801; x=1791230601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLXEP04A1YohlmPKKMxDDWZc9Vo4kBu+XUJyHp0Ehbs=;
        b=pARjUI6UBtggV3ez2vr5M1WcK/BeaQRiAozf/OTjR5DGPGCSGji9PLRXILPI2ecC/y
         P9iC+g4ebpRJOrHNNTjXhCQggV7Xuf+VNyCmSzI19njk1D6W82pVaiOC1cs56qq7h5P3
         BQJBY8RjltNuEf7mlo8IFjgy2oeUjfTrxafL/dPTwrkJIiAiCYZks4ez76000TTeMrmz
         d/pFc9Bq4kIAF5i3r8FuOOBM9DSvIMfOHvFQZL7Sjjjbwp/L1uv0gfgqxbYtVmw74GPP
         u8HIl6kEXPItZyY6raziRTNGOw8nnab4N4O6egTkCzp/7+lt+Y5Q5BJhMi74YgqQ+aNE
         IMBg==
X-Forwarded-Encrypted: i=1; AKwUvBzAcp9IqvsubYNU1DI4RHP0qiNdg+kjZDabl+oK6gpkULmdOtp8NAJkvE2qFK2z0zx3ck33T2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nK4UJzeV1yMPvbKl7WepOeFHtOAL1KlzDW56dB24v5YCuSuKlT
	MvbvgMFKSFaC7vhUb0tb4gsEbNz6dNq7lbRfOQ83Q5Bjzwc6U3ZhD+aKVwIm79yDH7FJB29NpA0
	8ri9Yg2+bVZpygOH6LWPeZK3TPciRDF/BG5XF9RN3
X-Gm-Gg: AYBFou1RddllJ41Z3iZ9LADUDNZU8jtAvi/uHte4TEvua38qbhZJjZJEpKyt5weBTHV
	rdXPhKrGZo032R8hqfG8EI1vQk+89bMXx6VdMGihcApAipa28eCYl+qI7HjecYXFWtIX+CqwKso
	cptOMW+Me3V333k+QX0e5VaCu8Z+qBdPH9x0a1IU/NwH3rzqe1PBnUuDe6ji4mIm6NXnCxve9io
	tqgSXzsV0TSViDgcUy7wS0t2E2E/gzMUt03xVVPVkiFjWhPn3QCZR7jHBDQj1Aatk8nRhxksRke
	l7gifarevvEtYCPKj6oBXVh9baegl83l1rqzjsbAnSekCa2E7VTDE+2h2fiK+kG3qusO2pjLRgA
	49rJ3L3DGk5XcNfd+Zdxww7Eut+XT2JcXSESrBi+nnTBDrpc6X38T7/Rpo2E/EIrcs0JovFfc5P
	vqnew=
X-Received: by 2002:a05:622a:4016:b0:532:b31f:820e with SMTP id
 d75a77b69052e-5330b5b8118mr250222511cf.18.1790625799883; Mon, 28 Sep 2026
 13:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925135244.3715196-3-edumazet@google.com> <179062524319.3145.1235142898193592641@kernel.org>
In-Reply-To: <179062524319.3145.1235142898193592641@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 22:03:08 +0200
X-Gm-Features: AclHuK_fHKq59oDf5KEqkWAVwdWezH4SCRv09WLrOMOSngYiLf1Ky7sluNnbGWM
Message-ID: <CANn89iJkT9E7UdiPn25vCRKM_J9VZEkFGi_enYAteJAnsfiCxg@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] selftests/net: add SO_RESERVE_MEM test
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, weiwan@google.com, 
	horms@kernel.org, caixinchen1@huawei.com, netdev@vger.kernel.org, 
	edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:54=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 4

This is a test. Lets remove it if we have to work days on it.

I will not send a V3.

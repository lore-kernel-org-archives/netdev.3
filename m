Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E49426D0B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224796; cv=pass; b=u0bgwnFNDPRhBSI9WQGuMMWivDJi67HziWv+yk5oKdiNlIiBzykspTk8mOvGJrI5njdxUH3B8gPnG1LQ/mkJL+/Z3Hf88ov+pbjxe2mzSRU3lPER6XxbsPoU/hNUrsNvP/lLXOS4fgyoGOlKx2fTGiK8oRHeWPd+RBLuZW1VOuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224796; c=relaxed/simple;
	bh=ZURaZADyFYuCh4n+xDVLpaYHqRawfBxPTS6bs5K8cu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOciOSHz2e3OK7ER2gdoQoHMBlEAVMby3dvM0iLcMPtyRhVGiEXmUxCKLPsrLdCIBPCmRoRmHZiFy4mUW4ogKZ1nLy2wTODGpvLPnqbGhk5SiVwlpic0IkkMU/9hUZvKcjGEbVa2iZqNOBUGKUHWbamfxpxrV38gamVb2ecQwWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8h2hI/w; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8h2hI/w"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2870524a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224790; cv=none;
        d=google.com; s=arc-20260327;
        b=P8bQZZ9N7vkVR5oQ5QW+mwaPDf08kN7pFcjjbOY4R+ksPkc9mRWSqegwEqesfWSEb3
         9ip5J0QqNr4f9Wm6ILfmPFref4EXfl5amkmmoCtRCHajqe4XpmGYPVlG+cfTbdHT/c6Z
         8cbs3r8sZ2F3cWGopU+51apcAdslkIWi96Ykb9PkkgI17kGX5ib7paXa8ONqXRYfdtHU
         WsPbwnh1q7gfdpSPbEVACdx5qI1/gVJTdxczWNDC4g49ahwWnncJFtqLiHAZ7XgKZ7Dg
         c5RYcMsM73SmbdPS2hYQragj5zduqO4dv6FFXvfr0FsJL84/osqF4QhBN+bvLaNV8npH
         xE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZURaZADyFYuCh4n+xDVLpaYHqRawfBxPTS6bs5K8cu0=;
        fh=nDtlfMt6k0PJ4YrgWUDBz2V/1RdmL+c37nuNXiKjiKY=;
        b=VHNJVVuDyUx4j36Cf+HTjj07YpNTSIEXd7RvO4sPHyuc+5ycdBEqGqDTr3aj72GT/l
         seHPqR12j8OVdSyJEZMZ2DFvWmwSqAz7GbK50SS/2T3KEuTZO2g7ifJ8eOpKS7Oij8Fu
         K9xni+3LDy0MxZkV+hjHtan2OIn8yszIrZAjk8ed/yMA5ix86YIk4QALX8laY7mm9Vlk
         2JahueVG6FhFppx2Lj0NtWZzMHj7pS30lLleEyMCfU2+/2C5bsN3WwWPwWmIYPX58+n7
         pltvmDtFMXQZCiQj8Y+GdH0PKHpTfqadp+PCFBvazK25J1TZlO2Gh2LTnpZVUxRHFW1n
         14yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224790; x=1787829590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZURaZADyFYuCh4n+xDVLpaYHqRawfBxPTS6bs5K8cu0=;
        b=C8h2hI/wF2pGJjXjJSrx2H7Qkx+hCP1vcJsokrLfCDSffpT2RBAO9iWQrKjPGkTmzv
         ypDAIYgu1b/L1MkVL+OYn8j5ftOJpTpScgco4rBBjx7m45zgvFXq3vqNu3SDlgEMN1hU
         H9zbWX2yZmPf0ELPlg+kytlpw3iwyzYq45z2o8bc+8ILCiVb4J8Is5FfRbOH2J3lcR6l
         iR6rWDaq0vI3FKeJoL1J5jb1YHzqQfRr59S+bhn6osQwY4SWFkxg2wstqV3UVh0G2p8X
         caD5fz3S3xRkEryVK5VrUxHxvMMQB/dTjYWeb+x6j52RgxhIxe78taagtPVYDwS4k8J2
         KuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224790; x=1787829590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZURaZADyFYuCh4n+xDVLpaYHqRawfBxPTS6bs5K8cu0=;
        b=hLoxjVIlXJHqkba2AT7/+wIaFfq7J68f7e0pELNU7DERW49N6uVzKu050NhSfm/iC9
         xQj3htJ52zqZ1ZzXLhhcC9kna3cBd14pnCWG/VDTPUdjaCvVBgLpxdCzTsnOpWbM0+zC
         /9fU9lF0JIu3mpf+gfIXb2QTSBWcjygZwjYtSgj7FO+W2WUy2r2tN20qkL//vFgQx4IJ
         fmPfsXtMFihMjTYf1iEUa7k5IIzcGeIYVuWI9ksBvIPz0MKo+J+QCpf/XgvLtJDwXCw3
         VogtoWxSlfRWAVJFIXlN/BwR7Pxtlu5vYOOceLfk7Mga5dNY/luzC+Qxpui6UDtzXTDA
         /3Xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0WkGgq7Bumq0V5xUY2MXsmy2AoObE4uq1teFdW/gJjihym/qljnZnn0Vm1PhWAA+d2JatzHg=@vger.kernel.org
X-Gm-Message-State: AFuF++n6UuP8aHHipu1TIcAJkm+KdAHZn1NDuJ5FG4L/r3Tg8gEq0zf5
	LV5W45+pMgfwUrEYfBVzQT26cL2jeRARnJkEecdrA65sGwjxFl/4lHdhgYYN5m/PIuOuGQYmo+5
	LV1PMuLWKw2crXv2B/+YJzIHlxmd5Ves=
X-Gm-Gg: AR+sD101usz8UQCOLVNsiAre9ehI3/EJ2kUaKAzQzXn5M+Bwk2CxIppLm1XV0MyZpt3
	L3FG/fC1bsNduS7xxQPzJM0MpUA3UbPZbxC22yO5bGtlp7KrcGsuZs1TVRW7Mc2ofSjPc0n5vZa
	EeK71DM501dzdVdBpB2DYT22gQ99OvMJC4QWJ/wSYFF7OpEBnb2NINtWK+0CP2pSq2kRUB7bxNX
	Uvy85yGrd/QtK+F7rA/cgDF4C0NOazNT7Kq8/C2tjKD+cvcn0WuEYzb/cp2AZzt8SowJSoqYJEw
	kQNAoCn4qmI2KWqbLuAfPgBoII50rLaVGKzx7T4a1AMCo9daCZyd4OLOWr8XJ3jXNjnCGQ7WhY6
	Gl2HtIUeNGUXQochchaSS5AtHl65M859CjrruDdduntEXCiiw39BXkoS1
X-Received: by 2002:a17:90b:2e42:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3958109a525mr23605663a91.13.1787224789626; Thu, 20 Aug 2026
 04:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817105241.63345-1-phucduc.bui@gmail.com> <20260817105241.63345-2-phucduc.bui@gmail.com>
 <38099370-269b-4d3e-a686-5b29d806e6a3@amd.com> <d6770227-a034-48e8-ae36-ff49ef3f83ec@redhat.com>
In-Reply-To: <d6770227-a034-48e8-ae36-ff49ef3f83ec@redhat.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 20 Aug 2026 18:19:38 +0700
X-Gm-Features: AcwNN1WzHI4syJa-mKxrmkNkTCREoFGUFmrgxJZIoDJhUBI6FkiWfnEalSGXbBs
Message-ID: <CAABR9nEkjBkvhfqED8O+nMWALf9ssjkPHyFbaFFVxnPfidG6=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] net: xilinx: axienet: Handle optional IRQ return
 value correctly
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Pandey, Radhey Shyam" <radheys@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for the guidance.

> IMHO even this one is 'net' material deserving a fixes tag.
>
> @bui: please re-submit the whole series targeting the proper tree and
> including the needed tags. Be sure to read and understand the relevant
> documentation including:
>
> Documentation/process/maintainer-netdev.rst
>
> before submitting the next revision.
>

I=E2=80=99ll update the series accordingly in the
next revision.

Best regards,
Phuc

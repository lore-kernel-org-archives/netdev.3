Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D446A5FE
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960564; cv=pass; b=S0UuMkf+mNF4v5XAInDMcol1W2ThuIm1Ot3jXxvgo3K/vOB5ywNTYuxCqEodmB/HmYxLQ04cZ65irXXMevSO3+459f5go0DZPsgr4QP1Fq55bF6Mc55+d2X2z0Kjxpgr8IXNLqV24cvvlxVC3dC0tUWCn04RBeY2YOcVKD0jwG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960564; c=relaxed/simple;
	bh=aQp8oRIAczotXzqSiIFfwp9CnFohJGLCpjPmm7TR0FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUxyv+WYDLVu11qD4g6lj9ydyp2Cy4RDec7+OfWO1IiIrFiewq9dy9Ir+qQnFMNGCmCjmzBKZ85VABIbHRPb0ACi27QLnyrzspn0SmBSFjik3KTdYDAyYzAAgzNsTKphBxwsA21T6Tjcj0XluWm8UV/FI/uPNp8ERpLDysFeaTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWjG486G; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWjG486G"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso34504a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791960561; cv=none;
        d=google.com; s=arc-20260327;
        b=FMLPwy5eAicNMSoj2CX+k3wI/IgV0H9L1af7t7Vg+9BCHN072OoiHBoRyWn9P/0jgI
         XrtERSWhJKCjxJE3kwNW22Ne/GRQnZPZO4BAJxlW+5MzE8CyzVUw9jaHH9QXeDtLFRbq
         JGH7dY+byhud10PDVK0aADqp0G1poCS1li6Dem5tn1ZQSmgckaHplFfMauDjhbjT8C+9
         0x/yX6Lxr3YYuGEeoLm7ziDvwDOu3XGp98c/mEo0VojLvjmfDITQ23LtOb7SqByYiLTR
         ptl1sZq3XpnadcPBtHlBby+vRbp8JPCQARctphNlZ/d4rlsypKQUcZ6Mh7EXJaWbH2W4
         5/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hzNLroY1rGs3lSGbTgXAw9YTjwc3chJEBfBH/eKMZdc=;
        fh=cmMBgqV87PKv3DEqgSdwSDxlNZXILwQKjJKz5BKikZI=;
        b=a08j7fx4pW0MUUInAu5ypA1XMFqatAX+gcRVc8JsnjueQBD9K3sDc0fo0Vq6zdEJwc
         +kBp5uApU0VKsKsB4D4L5FnJ9U1J+LRFx2omU8mr9hpkfYz5BhOsbIOvXKzPXZCGh91z
         E6vt0o18yZRTciJgGjBwWq7YB0POm9XH5SOo2snl7g+q/7Bsg64pCAPGtWywYXNibVHB
         Ormths09H6YZ8UnkwcU74SiMEJuG50gNLWcRl6gQZFW7njCjPEEvAw83S1wHAn/ft7XU
         EzqbmVKvcv6tpif1YtILCdKBZtFbCKE12ITeEFiF/Cx1ATVejAt1viWDHUi5unJXHVzm
         BCaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791960561; x=1792565361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hzNLroY1rGs3lSGbTgXAw9YTjwc3chJEBfBH/eKMZdc=;
        b=FWjG486GXpUj3e0LVRi171FwusyIn1i2DWnpGEyaMq+NBB3vJ7TXGW8YOo4NESEwKH
         NnM8/VstPFYQSSmxXk29eryt8gJqYU7TcvpCjQHIp5nDdbtVNS8z4nN2qQuLVMLjBJEe
         RftBCs5N5t9gTiQD/x4Pfz1y2tsTVVhME9abr0Ojz/5zinIIM1chaolYT1Knnq5W8kin
         XoSl/Svo2qYyKhi4qM6NGqhWgXHB15Vf83Y7CYbzwtLQQILvrZ03BoYIQcv8ndJSfTDu
         dN7prpwJxctDbR7LNdkOyzJMxx8k72dE4q8d0BUxi9tSu1CDcWkJ+kQyMwWOqjmqrmgL
         tFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791960561; x=1792565361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzNLroY1rGs3lSGbTgXAw9YTjwc3chJEBfBH/eKMZdc=;
        b=V16P+3MspXNVG2a+e8jXdf9v5kBf+DxBv+yZhl2k0YDbMbvxzV7HJUpFf0oP1T3JPR
         1Dnk+d3VETIBFsGBbTqTDJlQ6EktWA7RNdfgl1aO7WlHIA5SQDhmsLEVQkQxIYGG+HBu
         PylkxfCJguMJ3i7PM1kFCQVTKz9PmZKPU9kFDx1Vqy6GYPcMeUFrsWVBUmF4hwU5Jbey
         VcDjDECTUVfZ/BwMMbfXAqDqPvqdQdcO1dzr/9VqRU6DIlJDDOV2FXt3rWHgVPmkiAZ1
         KcrGCPPB4XfmTgbhsEO4R1mO9OuCz+RWT3w8VxLtkG9oj7uGKYaCsjGss2oWVHWsgJHr
         SvMw==
X-Forwarded-Encrypted: i=1; AKwUvByvZypVpNPo73Zrickhx09DxDVqppnJ2sv7JjAJ1i2wLENAPFyJmKqApFXOlmkddGAx42J3Ef0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUl7w9uOWR0zHjvov8ne1rt1PqMAexoz/VqILpbkeFmJdkL0qA
	e0b0atEz4Lz/TvcDL3iRxvnxWkzdH7auXh9zfOxwFzVvmnCDTpIAuuBdFLiOcC/nWFwP6napS7y
	j64HgHU4upMmNUQsqZi6qfNo1dXnbZQ4dRLuI7GHA
X-Gm-Gg: AYBFou3Xd2xkOigWBxA8Xw2/qAoQMC0atad4DUGHdGd4Jb73Uqljy6OBMsXz1Co2Mg7
	NDZncchAg6uYYVoL8b38E3ZCoLoCBllQHGHKssSQT21ix5L4edBfZfd19vQGEH2J1nApx0o/5i5
	Wf9E3UGqi5T6Elwv1sq5pwP8ZpuR9+9QV6xNldY5aHtGGE+Ldl95APbomt66md/fj9bf5+6ZEzJ
	YrTbSyU2zN10XJU3ZvqdRtjYEWAXTyoPgDHVS43sbFArTOBWFp2vJmxBnqaYIG51GmP+AVljAUo
	W1rFzOu+4HWUXzbaQMjERHX4IjNlQisfDWf1FWcxEwD0rmsvRuBC1W5NgOzHCi4N
X-Received: by 2002:a05:6402:683:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b20ab049f4mr17118a12.14.1791960560065; Tue, 13 Oct 2026
 23:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012174300.2338784-2-almasrymina@google.com> <179191526299.434549.7888465945343049764@kernel.org>
In-Reply-To: <179191526299.434549.7888465945343049764@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Oct 2026 23:49:07 -0700
X-Gm-Features: AclHuK_pUGXFUw5Tdds7zQVYPdcRbxQWbgDPdlpfKDTpq7eymZUOA6XtUrz1B90
Message-ID: <CAHS8izOppdgVxeHrUpR6zVxfdTHw1Bv4JEoYGYGodAjyijB+ZA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com, 
	ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com, 
	bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, razor@blackwall.org, 
	daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:14=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The same dma_unmap_sg_attrs() slab-use-after-free the patch
>   claims to fix can still happen for RX bindings made on a virtual=E2=80=
=A6
> - [High] net_devmem_dev_unregister_rx() adds a new writer of binding->dev
>   (and a new unmap).
>

For both of these, they're issues with leased devices AFAIU. My LLM
found just too many issues with the leased devices. I'm hoping to have
this series merged to fix the lifetime/revoke issues with the physical
devices binding->dev =3D=3D binding->vdev, and rework how the leasted
devices work properly in another series. It was just too much to fix
all the bugs in one go.

--=20
Thanks,
Mina

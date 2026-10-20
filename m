Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792533508;
	b=HSvoxaC0ECDer9V7zOuF+grFMn/GTT2aO6hZlfQIeMklAWCl7TlekGa6+uWDEeCICqV0
	 mCJWleUdNhcuySP2IfBFjBty7IB0EIPmYnve0YKOlEjVlc3J2fc7gBv5H6yduAF1KMVB4
	 pebc4ay+HVy6biWOTqSkutak9ej2UDyUUGAZ/9P4Xxx3ZKxipzefdGI/2yUGiONCVWc2N
	 apGCMDYcG0jQiqf4hLzh8smGqn+x7Y39zQpnlhBSr+EjA1WoEcZVgS87dYij0l/OBbPdu
	 x7i+nnwUyZEksIj7DrL36ToX87g6Pf4cCO5ZTBPY/73goFR0rGND3HzwvRC0Ul3bhRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
	b=Gx43tSiEGjws3wejMCbYZnyVRUuSR/ba//fJh6fUTx9oQZYEQacTiTuzh0VD3DCVlTMM
	 787dytuGpKbZ71PrBogW0O0U0gmg25dOEbMBTRrOuI+lLqLoZNJ53otQtEITLh/egE3Gq
	 mwKD96cwnkakX3E3OsPOLh1EWNgJq75MopOv0RZlzvwZ5SUeW8RDXbjFlnKccbNIUQd08
	 My3c16KtUWS1Q+i9KIy2hWmg3WOnztWN/wya49t8guH+UipZbKwXgD4nyD8VHEkmCdaLL
	 zO0nabSPzauQtVAw46nsvDD4XfEO0d1L8D3Zry0anS44rEo1nHaQxSzv+njWSmWFYMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZlCPSaes;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B23606A31D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B23606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZlCPSaes
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5fb79ce82so338715ad.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792533507; cv=none;
        d=google.com; s=arc-20260327;
        b=TGIm7gx41Zd1EgMSOnGtetnUuRqMhew8emLE2T5w0gTrOf4xICWEPwy3S5h1YI0tGe
         Hw+IL3FCKKkN80OhCmUi0Z1Lk64LHz/NvAASTvQLilA+8yrkGMyiq/LqmsbA+Jj/ROV2
         nmjO53VDxMHdfqUklN8EmdI+ZOCdgYTIFM6C3rKmqCZPnYNedPNlIth5Eiu+YyDmxHs4
         S1Ly6o8zbMsDM2ekgdutrKpaPhi/SC9S5yziZWDgJal5Ic3CJmlaiMtlrK8KDGOJHvCg
         2WNNjGtzLyTOTx0mlJghztcNy6GTVp291U7UJ8ArguCdWnkzCF41mcb01RnLry7N33hN
         jzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
        fh=DUOjEDVvtgWYRHEAPAymTOAr+RfDOB0HlfebCKH5OFk=;
        b=ExLmvkD+qGY6NeD5kHa3dCZMuxXUhvDVRBgmGXyiZUGN82mZnoK4PCOybQU7uQV8ho
         yoxaL3VTYa39uCEhUCwgBTzB++cnBVRLu1MM1x8H4adKQ0uzMsOkRYvUqVIKKc4t/O64
         +n2jaa7JCovP9P6Eh2cIiZRFK0SFfAJMZuFt+EXuAwzV2a/nurOYkEBDmG9pJYrH5fUU
         ogZbn1g8AiPTGweWxNKigfgQSeLkVYpALqOrsO7ARIfRBIZBn4R1N8IK5vXlxlKheP5Z
         j2tU3rbzkcO6Qxs1jP0CzjzJo0D4vdGHzK8zpb58sya3LN3hciMQA9nfjZ/XAQ6e3Hg8
         2hQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792533507; x=1793138307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
        b=ZlCPSaesvwK6ytevnWbTHn0TkN/ILYgKMLvVa+tEKPUiI/PXEgd7eOMiq+SnfX0kRJ
         wqPZqYXGzmDSfSov9ygbM5FaoZsi8bAJ5yPxoeKuAggi1uuyppnl86Kf6jIq1ueT2MkJ
         fNMdSChgDXaIEYSYaeWM6YWOdsxPAhe4AbIEkCaAJAsGZ9mOy/IhBXPiNSjTZ3GHubiU
         XwoZ7vMLO/o01Slg5yXTFqwib0as9ToE5VFmGl9Kq8tH4ULUtbFXWDJNOFVY/oZXWiMe
         dHnNiznLoItrj5HNuMEJDE+1IKIutN+nzKD0M6XegYgQImAS2CNtMjD7ojkhTlY3ZSpW
         ZnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533507; x=1793138307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
        b=GWgBiC3aYefeYsuSRdTsVzl3kW3+8t7eLAhv010vrGOKyWo9H3/IGgFfgmB6RLAqW5
         LVLlrUOKPkXoZzuiH3Kdm6h82dKzah2l476S4jcJNqVTnELR23HmsapRNrv/YXsaEZ2y
         5WRzHlrCL43H1VbF+ar2NNxdIfTBQ7iWIruCbuYYsflabWcpf9jwuVgLn/ofKECYCUQW
         IljFZFca9fEQyHHcdPu8paz6/dPxelsnxr4T3xyHt5JiLFS1vLtvf08E017zPo1JDV1z
         lxagDkbfp4P24xRVdan9KH0zFY57QMI4XpctHaIzeP1q1VwudQFQVR+ZvLHlPMokHArl
         5cBA==
X-Forwarded-Encrypted: i=1; AKwUvBxSWX0E+nU5Tcbi6KDPIBhRDP9gkFG0nr8il8AOCjGka66s90WkttlIqUqJQFPnOz5nKf/zw6o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhRG919hxO3PUNb5kGn3REJnO9W+grNG+xUhYtPospLai+ydNL
	YvnutGKWzhxCrJfMRaYmQbKhOx7KuCZ+0VVeSjZvmP20qeoNeNWO2/bKrYrNPoa4lR2CeaK1N4E
	f528rJ4rj35V1meUBbEtLfPy0tXmnFKTcnxtDU7/R
X-Gm-Gg: AYBFou2+HvmFtWhQ3t/LvbeII80iyFIWRV4vPgAPI3AwOW5GOhv51BYOwiVLGM+kvxC
	CcWcb+Xcc3EAaOhnvrNy6L5gW0QVmjKGEhn9VHKLOY0FE2xEK2jykC5IcaJdezJm/JGGwK7LH3d
	XggG6WeCQat6/v0hXjDW7E/u+ovVbf0Bazo+9bD0Jn+gGOv+3zFGEJYjkAMfgNvmOTX3IucoxYT
	2r9KGvvXNxltzCO7DG1z72I/PdnfZ0exk/9C9KzZCHKPUICqxs6o7pyeLlOubBOMuDrGZT75eZ5
	PhYv5YpGc0axG+acyC9XbWly7TSdcEhVMBkVzH1+tjSfh83Je9c9SEmHXp54y2UoEo5C83EoJOK
	q70sD+Ag6javI
X-Received: by 2002:a17:903:98f:b0:2e9:7e90:8a3 with SMTP id
 d9443c01a7336-2ea43c649bcmr890865ad.39.1792533506693; Tue, 20 Oct 2026
 14:58:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179138670045.80227.16292613517250896744@gmail.com>
 <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
 <CAHC9VhT5w3K1MvmP=1Mxf6KKWZD5BbK14bVHJGYFN93080j5jg@mail.gmail.com> <179216077404.22091.15636720633867774901@gmail.com>
In-Reply-To: <179216077404.22091.15636720633867774901@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 17:58:15 -0400
X-Gm-Features: AclHuK_bFa67Ysq0EPlVn9haOjzs2jVy9717_wwLtZiIrC2qKhEMo2q1W3c8W7E
Message-ID: <CAHC9VhTDnwGkX47vOLvS_1HTAcqg7qjkXCiJwn=qGhdy_n0Jvw@mail.gmail.com>
Subject: Re: [PATCH net] calipso: update payload_len when removing the CALIPSO option
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:26=E2=80=AFAM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> On Wed, Oct 14, 2026 at 9:39 AM Paul Moore wrote:
> > while basic CALIPSO labeling is tested via an automated test job, this
> > particular code path is not part of the automated testing.
> > Improvements to the tests are always welcome.
>
> Hi Paul,
>
> I opened a PR adding a forwarding test to tests/inet_socket:
>
>   https://github.com/SELinuxProject/selinux-testsuite/pull/106
>
> It builds a client -- router -- server setup with network namespaces
> and checks both directions: the router removing the CALIPSO option and
> the router adding one.  On Fedora 44 (6.19.10, without the fix) only
> the removal subtest fails, with the forwarded packet dropped as
> truncated; with the fix all inet_socket and sctp tests pass, both as
> unconfined_t and sysadm_t.
>
> Until the fix reaches the kernel used by the CI, the removal subtest
> will fail there; I'm happy to gate it on a kernel version if you
> prefer.

I see you sent it to the list too - thank you for helping with this!

--=20
paul-moore.com

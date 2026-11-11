Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415531;
	b=Q4ZL1hEhlp4g94N2lHP8fulSX9FcS4W2IZjEXGIosjiOPhNRtM5SUKRbfOGIBmpOSOVN
	 JPW1cewIcoJT1ZBDvRyvPlgATrHIhk2g+oEswVSUqwohwv4dTcOxf292nZXsE7wdWFhir
	 LzWXrCCE2ZATe8+vdxYrIrMy+ZavtGLLoXWgANIJ+CDqM3SGTs+DpW8MI5qjs0JQc8+EV
	 i2cgADRAMdVE3dmWqlx508QMsUHpuGsIB1eUyzhICA2eG6+GYB/uKbSsrj33HEEJY442X
	 pwdW+wsJjuU3QcCbTFcIsUn6jb9glzkVuxvFLgiB3iP7NSgCHQ7Z/87fFLZxspjfEXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NYfQE24rcCL3ET4V0w0obYmaTrEBQ7wONKSMJ15jXBQ=;
	b=Drg63cZyuLwIPEpoEDN5QsPGtJaQvSyIGdSOm6wbPE0OEInf4LNGkioGlxjJTUO7Kzr1
	 urG5mf8ra1xAD1E4cpRbyvNQzNNJo6rYwOShZAXjH+0HbgWSoUmFOcHlqwSFEjBVcVl4P
	 s8UGAuHT/2wnfCkocrpMohQFfMOjix4zKKaXSviz2OoVA9kAMukneUmyL6rBJYMBKZLy0
	 +7t/HX7JKVp7qp6y8pQRTL9XYmDJQEMIM5p35XGEDHuwwIk3VZMWnkf7BifwA04seZRCY
	 /BSx/StqXPdk0bY4/vLd/rIPLda8SSRNlpUMf6sZDxCr3onC+10iOveYG6DrqgIybVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIZH3DQY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77F606A32D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B77F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIZH3DQY
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6ddef424972so2838780eaf.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:45:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794415530; cv=none;
        d=google.com; s=arc-20260327;
        b=HXdiEgmEhvcCvgXIJOUSutIcQ6zX+WIKHtIJLX0zYIRhgnUXRIE3qrtP7HX5YQ1kBh
         Nv2dbJnJ6iqwXUkIcVqe3DV+RWYJPWavVywqXb9FUBowiWQH8evKAiUuo/MQ7ROR44nA
         OPIZXUFK52PhNwAW6BB0huTnnC+cW3FMHNfprZc2nhdLF9TCDulafQ//8FA06QUvvJdI
         PSd5abUdVpCGRDCu4I+cbust7Z+Pt6pCuWgut5BEm+Pe23IqQaL9GqI5Fazom8QEAgZS
         M2iBHEAH9F1yyQ56bssZPRljJPLHvFWYxPjZtrFkFdS0sYOO6yoET+HC7oGKDoyEdRzt
         JGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NYfQE24rcCL3ET4V0w0obYmaTrEBQ7wONKSMJ15jXBQ=;
        fh=yY1zpqLqNn55J4w6Oht7yqBMKbVkF6Fd3hYF+7qfxPo=;
        b=SKHwuGzQBIeULYrgveI59r43Evsfb8A98CDck1uWYuHnCLViaP33u941LaR18aDlX7
         GmCrVovvkyt5ZFHgyYyNRbRNo8LRuF2pYEax8PNHanhdmOEbr3Nk1aYua6viAl5KGqQL
         kDPVYL4Jz3w74oBy6y+MvHIchHP4cDiOvz+h8fTihQ0HStDl+qT/bL5ewmaIq2wVaU/b
         xkgNqs/hPVh5OWSkodrYCyLmNCUBw0DukeHyuv18mEW43zBZ/H2lCbJYKBMjDtmzilZ9
         rxyXA6DQaIortI6XyHQarsiQ/V/+aawWJ7UiE9+FNJ8qo3sitdv5YKN4Bdj/50RiPiGx
         ktYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415530; x=1795020330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NYfQE24rcCL3ET4V0w0obYmaTrEBQ7wONKSMJ15jXBQ=;
        b=eIZH3DQYvWCLFcN6b0w6H/jQlcOtH69HbdfA5AKWKoj+GEuH3pSVkFT6/4bDSCqiZh
         S3HyDCED/cNpqq6pgpSPimiopfytOJ4Pve0hPfFmyMtyifMNrHKxOblqWMj4az49i1L6
         zyqMfXaFNHYNfeoL4sp42w4z60VvvD01/S1Iz6/wbhyy6tdr0+5meIhlvdKesTaa5/HC
         5jO7Y+5Nl7sTYQjthFE/pqP9xNqK3U3RU8e3Jk1Ix5GtQB9vcIo0JI89+j5MgiRgsE8t
         LdPsR3jRT+0YWV7fE8X+K0v+zA42O/eQQknE1sqQt2j0URdlzr9sTYGSiEe3AK7nv1Md
         kb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415530; x=1795020330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYfQE24rcCL3ET4V0w0obYmaTrEBQ7wONKSMJ15jXBQ=;
        b=2Gd0Z3NUSBXaOIvLc9XFe2++bxJnhH28kFgl4U4lOjVhVKY4t04DC6yENMN+9UQs+o
         zlbPre4gNpjRYdjGIAxHA8sHbAMSRz64Ea3QGsbx8llnK70/zOUAWN+MdiMRHXgTy+LY
         a3wQYrw4plNenU90Gita9nzxOIZx5mdliLW9CEOiXd3fqG6S4DDJtpdoLqvyuc7sY7v4
         UudNfyxl1fgKjuXeZOj+YLj0cW3zkr8QoqCJXYON+T/ihJVGJStt+sgZkKOiCtUgT4o5
         R+gWjpN49P1k2XwAudf5/VaoJp07WFMnu/28GZzxJXT2YA5xn4W6AA+GHixJCxk2NWyc
         X6JQ==
X-Gm-Message-State: APuU4Z95qjvGECAVJJ8hRogIk4NZ0Zdz/ER755bUPXOvDpLP5l9X9vWb
	8q1DTrDe3/+kXwIX8y5TI6wz0AfgYA+taMX9Ge+VaO7l8pPO8jFjKJ4BgCdofhTlLzK0esMivgR
	a/dC0zw6A6mESJfgFCs3W62ATMtfhV9o=
X-Gm-Gg: AYBFou1CkwuFqKKxLv24QLtQE9Xgx+AFksisRspBE+smPf7A8L/W45IIEHzv4j1usQJ
	5zZsRCKl9YN2xq8zIhDnr6zutabA6rSBPoLcAlMBbMSY2MYh/wyhd6iMmuDqjnti3in7HsmKtQw
	uf6QNxRCaQtWfAbxEzptM+AxRItcQ4TMKvzl8HJTEXpiEmzSJ9SvyEJ5Ni09YqNwZzwItL2qVgY
	hQ1nEe0CTOPnWfWqwQFniJZQm7+7lptstp3UrPrjfstE4t/w8XHJ8YKbVozyTU/0m/1QGZCllhA
	107nRqsf7dvIL3PSoRry0aDEehlVmTDOqZQWYIAyE0dRLQe747522XA5KqpylT+zaTxNoUWbMdD
	S1/8nC6OWDdMDiaEHrPkYCCyv0CZKJwDpGrj8nouti4tigoGK7sljNBntCmHc5LKvyTjA/Jrth5
	OSx38ls0Tffwjri98=
X-Received: by 2002:a05:6808:4442:b0:4b9:e5fa:8903 with SMTP id
 5614622812f47-56b961943a4mr2467100b6e.22.1794415529378; Wed, 11 Nov 2026
 08:45:29 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109153407.1761032-1-mmyangfl@gmail.com> <179441151084.2199510.11035302452325241587@kernel.org>
In-Reply-To: <179441151084.2199510.11035302452325241587@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 12 Nov 2026 00:44:53 +0800
X-Gm-Features: AclHuK9SuMIDImvwgyuePoaTCeasdPT2EycqKe2EK8Pk9ehfERFg1PA81NN2qcw
Message-ID: <CAAXyoMP5hQC8Jgg9LgY-X59ftAGThOMXVf3jTCmRzUPjvC+Qrg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Do not inherit ports from
 dynamic FDB entries
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:38=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This patch replaces the egress port mask in yt921x_fdb_join()
>   (drivers/net/dsa/motorcomm/chip.c) only when the existing hardware=E2=
=80=A6

Looks like a pre-existing issue.

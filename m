Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793636129;
	b=qBMXcFh++hY8qyddnNwHyMmdzpxAlUxAIC20mLtoUFXhCy5FnqhXnhHRKy7vVeCTUDVi
	 HgvgCscktotWUbsvpJYSpi0vv5FPzOJeaIlKyVFw1IAEQLTRc0DunBoCp8pKb4fvYbX8H
	 xYPLkU/WxpX+qPzMh1fCMxgWzxck/lA1FTa1wRAsbqJPuMVAF5f73qF4c2K1979TvgLLn
	 JyQrena+aQ/mfeSCAZTmLzpjkrY6ET4S5JcHcTEj6zzSp7eQ4Lq0MkgD6LuNPJkZOJ8DQ
	 DDprxFVZ3E/20c+k798ymOr2fjOD+zn63nArFxpNo7qRF6ZIa9NRIbpvSFksS8rnhBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=3rtlA1RqM0KGrm7tNu8wdRQ24zHOnzxhHT/j4INc3G0=;
	b=10+Cs7QlZAoqE/xVbF+8gOwV8Zm0Zb61eEiNbiS5BqebfQRVzyKJ34X/6pyueWsr5pPZ
	 EP8PGfZNxTa+ROGyRwi2bBo4r0DcdCUAnRfiYhF+dsD1ZVtV0EcBzwWi1UIb9Oq/bePfb
	 bPMbm60J2rhygLxKj8dQy+oxO6IyHJPJp7f23K7Ns9QV5R8Asqaqud6x2JKbzmITfvrDv
	 /RvoNy9KiAWB5a6By2GqdadW0EtM1U+ROaofi8uzJcKlYIi6yG80lyZ+h2iXijNWYZykT
	 UigYA2NBas26c7Jo7Xt3qKJIkMM4jJg1+NkdsBHm/N7zLw783PC4x7HyZWkrb8J0LtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yb/lReMR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A76070CB1
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A2A76070CB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yb/lReMR
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso1265279f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636128; cv=none;
        d=google.com; s=arc-20260327;
        b=RKxPMLCicf19AMFmfPqB43d/uxFooYgjhyhbsDA65X2eL1TRyL4LGVEjJxmh5HgV5X
         PSDAx0+uNeGKUl4pPZXeJY16hyYBzkyN324SOXisz1zUFoMVnkt+M2gqcZ0gJAu1agpB
         yJae1wUpTJR9mCtmApfyMRQGHgZWR23YbPhUN2osy/E+aaINBYRKFGQfTUO5lgh0xrXh
         XQk6SerwA0nv9VxycwEJ/afv5UQdM8EJMOVV7du7zgjE6CmdFoA35s0peyN1/p2MuMQD
         Vmuz5hqFVN9wkNuMUnRPoOQOPWvg8tFZe8mmtFXb7RN4O6hwwbpou2apl4/98dUSLncG
         VqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3rtlA1RqM0KGrm7tNu8wdRQ24zHOnzxhHT/j4INc3G0=;
        fh=sgMlnpPIkoatpKB1xJDHQICPZqesERPploa6LoXqXLk=;
        b=gtch2uXr0xxKgNghga+FN3bykYNt+kmw46JL94iimqwYdLSKpebjgvHR7+rV8ArJ17
         D2bhnSKztALdq1n1jc0gIcEC4qUaAI+rXdi5xV3ZZVs7zIljE7LRs6Wmz+LJbEDyAg0G
         eFcd9T0QuKghH7j0j3KW0sWlFbgKhTBquglL0rg3iLO59+gfVtMi5ddu67dHdSfu4OZ8
         vDDJnuYeCC41wuUT8bk7plgmonxHLNnCn7WpUSTb5vrL9djTamcqGcJb0nEsxed/4jjw
         3Za5EMO6Rg/yY41HvNE8pAnVU+k+7uJWMa457xwzrwbzImr1p0BNReIE/5gc6VISswku
         Yqqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636128; x=1794240928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3rtlA1RqM0KGrm7tNu8wdRQ24zHOnzxhHT/j4INc3G0=;
        b=yb/lReMRlHjZsLb3c60cIXRzI9rmLKz/Ep/K7DOWbGPqk7R2m8FYMPwRH/lxG+lpMI
         FOxPDKk7wAafZ32iTCH6tSJMvx8ohPMvIfYOs4JRhZo0QJ5rLy5hPic0mF5owHu9JlGx
         VDlQ8D2zihrUoYJ8AklLUTFPw1itsnpozlVBN0sSznLFNNDQZ6T4zVo6NF5ixgTL3tox
         JWRp2KaaMFw4iChboFi07aIYB/biD0Z+e5BikRPFnhKGPrDI4CexbLKV+HWle3EQoggL
         AddVHg72wAtLE3WM0ykSUdR9urv65M0gkP1/M74UaFRxqBPealxM1LhLAsiyrjVRjD6w
         JPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636128; x=1794240928;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rtlA1RqM0KGrm7tNu8wdRQ24zHOnzxhHT/j4INc3G0=;
        b=XW6lzhO1o4uw43k8MECamaEqp2rq4h9th7u1lQInKbWQe7kT5oLOXMPNswlQpoogfv
         WiJj/nMH1el4m8cR9+nSuGiscXs5V/+DK/nvWpFn+cHNoo2pYe3lcOcDH2PMK6QI+8aC
         OvIEO8cFhnbtgK0PC+euMbu7kQRGX5g8exZXD3OwXHmr5IvaLY9IfIvebYlXII40IIud
         hh5e4YepRG+NkuUarGbaqmdURPEmR1Q5A9VzH6RcdQKtAIsX2YO6eRRvqgt7PVJZvoaW
         N9/EEPFypi/59HXEdOrWM5p/amUv2941mD2x2XJlfqsB5Nw7Tc+i/KDrZLmSsVgiLyVY
         yaPw==
X-Gm-Message-State: APuU4Z806bhpwb+H/9iW5dJO/xASVl/6qGYfKNBAM3butZzzhKQ/D5YS
	QDuHk4BdvbLodBnx1g+FKTDZE+ztBKt/8VaBoKigDQ18me4Kc+3e5l1BdnEvm0Gv44Z0zSzeQ4z
	cqI3NR1ul9/MHBbG782dwMLmF1q0bQAY=
X-Gm-Gg: AYBFou0Tb25iP3eV5vg/l+ub6mM6Se5HMG07/SGfan42A84Vxfd8xFB1DtSDCSiMSwR
	aHLmUnvH2BDoeV1SWsrYxYfeyboGeEdkn3AZFRUxDKSNHh9DPiZZ2BU9aRBehMGI7eSwILitb2Y
	3npNOdDDTVRCKxoZhJQ8FLej92BsjaRBgK6/Oh95p/aK83U1tiENNxKP2vDW0175mRRPlbMKkG5
	SSyJ8igkH0NybfPBLjHxvsY4BOhrYx5XELbI57Vk5xCCBQgzZkUlmbKVMlW6P/gYcB8eBaTwH9Z
	E52BR342E5qS+qKBzI8hE8UOIqbnO5/6WUpV5EaZSRD07UjBMBwhqLFfZLPKX6KDh/fdBFIjpUL
	JKHLWLmOd0BUJDilZt3qjp8WFoMcK1q6LNxHVmFNDB3Cp666wAAeKCi4dBHh3+UQuln6PXXVmb0
	4yOb7CLtVWGkL4PozFlRr1cWZ0z38cXWucw56r1Rate6teBoJ3lCOoOEBKakKlyEoYwAa+G1svL
	tY=
X-Received: by 2002:a05:6000:4a19:b0:48a:f8fb:cd49 with SMTP id
 ffacd0b85a97d-48e6e2fce72mr22163028f8f.22.1793636127567; Mon, 02 Nov 2026
 08:15:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179322338727.40667.9687403297682768724.stgit@ahduyck-xeon-server.home.arpa>
 <179357239570.3131.6726877389205316280@kernel.org>
In-Reply-To: <179357239570.3131.6726877389205316280@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 2 Nov 2026 08:14:51 -0800
X-Gm-Features: AclHuK_QSCCfC-A9V_k7yIjDGgYMRsGuPRXLJl0xHS-D5hSkACY8SWY9QhuJwk0
Message-ID: <CAKgT0UdW-UMJPf=ecg4f3GLsMgxEx9KKWWZ0WLA0SkFvcHRjgg@mail.gmail.com>
Subject: Re: [net PATCH 04/13] fbnic: Retry the MACDA sync to firmware if it fails
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 2:33=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch makes fbnic_bmc_rpc_check()
>   (drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:345-356) set=E2=80=A6

I agree with the review feedback here. I think I am going to need to
look at refactoring this patch or possibly dropping it as it would
just make a bad situation potentially worse.

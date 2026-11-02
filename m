Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578564;
	b=p1wPvP5NTXnSNvJQhBoTiUT8LBBJIvLX2Pu3WdhVSYwcNtUmw3PqVwsQEhle091KMzkE
	 ghj0QBYKA+VvHqTLSGM8h2GV9U0D9ARBTXptC6WevWj0umQsk0kz+6ZnnhcEEk4qrj677
	 sdKia97NsGV8Ac6KCNlKK40hLeqCgNGJNep2K49vWnPTLYdxqcFCvawg30kKAPhxmcVO2
	 aHOB/GaCW+5KpG4XA+atp2CZ9o1mC4zt7cDWtWG+DC2Y1+TMdoWddVD6WndwSRXAWklKS
	 Vf0pED0BJLUwPxbQge79EeThzu57Lou4Dz+l0maUOjs4zb/i9Lv7VQFXTGQX/oLXAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
	b=QNECAyYLcodBOowEsQFYZLJiuwIGeOtXpFuBmqn2CX/+W0CNBUwB3TLwOAHaWRHUS8Og
	 balCe3EqtxOMnikGJtfmhOzHGDshuOL5lchV5A1NMPQgIfl3cuqzt/v0HzDmKAjTAorZf
	 XOKAkrUURcFuo1FYL0KKDszdaSl87iI43eLJ+LtVtKjgnWzMAdQrWB1fktnF44ddFnIlk
	 S4IbgxV5Fzqs9J4eoVRz34DEucofXSipkuLesVpYiIiv6l6sQROed+Z5jHEfb4FqBzIwV
	 SdNHdy/v1OFqGOm0iBurft/n6NyI/h6qSgx+cC4MFtw/CYZww7aETXC2pyQNHwKWNEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6E5FGp1;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3290606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3290606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X6E5FGp1
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9f6a16aedso14566425ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578558; x=1794183358; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
        b=X6E5FGp1fRWEJvP6dFCEW6iONcxuuBTQCHYR9GuaDNiD8qpWJSbE8dGdvLcN0FeWcg
         romalqrs22M6d/uErTVRWlezi3rBd93vifgzSxl+aCFEoFudtOqnLtCoB7DiOBIYflDr
         UeL/PEABYrr/OJOcthGljwOh8vFbjt2HXU1XeuPX2VSkuNTfoGVLXud4nIA/Tfy6oCY+
         WFFes0HVKOfTIWHsPLNxql34g+fwc/H9eke0Vd0w+NcnAQ3YmD2MYYRF29lv00DuihBD
         OqoujEZkbeTotxebCHzvjqUhiDLOyJpg3tKxZzzNisdwR1OZhZEkZXllOUWe6xpYkNnn
         lmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578558; x=1794183358;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
        b=QRgAK17q6DvyA47xvmgzJ2TzFkIq69vyGhrShT/nbqe2UNl4/E7TMIFl33Xm1w8sN2
         W+CEzC1ikNah9kG2LG1tawmhiLHE27eCmSZ+iPXRo8zQMZHNkeJFAUZW+18tF+Jt066P
         AtzkciWy2obOAKDEThfc0UiUtWC2yZGriIweNyFn4xM8aLJXuvexJU+Xk6J1dK16UaCW
         JT/T/Bmn8XseSoAENjH9g/LNQF/2ouh5bvnAG/XJ/hRaVL7SC5F0XVnU3scAOCtALFC9
         t++s/vHPTSXptYjWdkXw41zS0GIQtGDcb/AhjYm6wo72lJzsm1j0AeXm05zgStcOjiTc
         tELw==
X-Forwarded-Encrypted: i=1; AKwUvBxfJed9jZhviwJZqceNzOwHPrCR4cB23vClgICr1wIIQaTvNXHjOTPQODyz68Rj4zEjMqtW1Ws=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uS5cxHNFjH+IBrf3OrmJZ+xclGrDweOWqXdvmZmRVdfpsILn6
	4quKjnFJ8QTahkO6mURm1tL9XbSgVotkmgPSoKv5dvatFcSyG7xXGkuUFKVucA==
X-Gm-Gg: AYBFou04QXwWJWXnCnqR4OHmhEPQgMx8CgwwdKGgLp3/X2AR0aLCOPksjSsDQAL5po1
	QhHZ2nRaRYTBwXE1KjEAl++1ObqSG1wyam8cWkFYnXMGcGGsF9SGciebfhh2Px5IKQXcpNX17K6
	+0OZ1meS0HeeEpVlUDGure0gMFY/MvZHG8Bz3jxL0jDvdOYT5FM43wZlIvEcCjFKSWkoL6d8Xgp
	nSuER8+M2iJk2hF1PEYH4/XpTlsJH27nR7heoFqn3xQOxgg602krVA28s5DvIFCFNEj9JisO0Gh
	AhXXbOTiGYTHhRGkVi/x9nvoBpGV/tk6rJ92kgD0P/zTrL4+eJEM/W0z0aIscrBXtKWdP9Ri4tv
	aeORHGU1ZgpeWwLhDLCsPAbJwILcLU1Wj3/AjG95j+Ppj/NHS+6MVbb5PXkmnpsUTR6r2gQkvZp
	EFFjvdv77BAnYUv9NSAbhIqGPuD7aA5ZSOYAb+nx/ZoU22q0/6BSEQMHJwE0q7mYWpDdsZw2gRj
	viszlQLARF4JOzViwi4A4WRyttjghSam+in61rgSE40PdWrxmHqZXTYjD+7WgzkYXZ45+CNC+47
	PJ+9J86Up30gS8JFSFfLomqd9/+5Q4H48bgc1bmcFpwWybzW2huvN8MtadiwkmihqTou7eOfufl
	yWaYBbC1kBCG0RQkR037XyO3/3VuMejezZU/HQ5fDgmsCEc7QIc39EBVD
X-Received: by 2002:a17:902:ce04:b0:2df:9a7e:d41b with SMTP id d9443c01a7336-2eb36462d49mr84627265ad.37.1793578557953;
        Sun, 01 Nov 2026 16:15:57 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm20149455ad.6.2026.11.01.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:15:57 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:15:56 +0000
Message-Id: <DMKAJA4HTOBN.O8XO807UAB6Z@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict
 stick
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
References: <20261101192057.2296489-3-alexei.starovoitov@gmail.com> <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 11:39 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Now that an exhausted SK_DROP verdict resets psock->eval, the prog runs again
> for each later message.  Does that make an older accounting problem in this
> branch happen on every message instead of once per socket?

Only between patches 2 and 4.
The wrong return value is an old bug. Call 1 hits it without this patch.
Calls 2..N return -EACCES today only because the prog doesn't run again.
That's the bug that this patch fixes.


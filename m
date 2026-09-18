Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F347C0F1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754166; cv=pass; b=P1M5u+WrRq13qrkmAGoSVLfnamMjIcbgefEvWJK6kD4JJA/yhQRUT+l2t3EjSSIqZykwIoB472zLVx0YVDUSjmvaywzkvZ9kfuxhdVnDrHfzTx0OJ4QDdvY2fRqPGUqyP12Z7vsfZISsBijLfDeyyTE0YyIO8rXxUEpWv7qU5w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754166; c=relaxed/simple;
	bh=K2wCVeSuchgF+6YBCtVhNSkh+TZ7w975CTM84EpU5d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tApYxX9VQSF5D5OpCCMpxHv2tBX+Ih94vzODmABm2NS/4wP6fgpyO+r2GQQ0ZXMwcoeOBp63fvbfKocziFleZObkHX21hGFCnoC5xWaCIrAdNP759KOH6JrZHPL/Gv5TGDjNN6AnMRBBLcVeGMh7jiiKJl6zCM1I4nLzG0qj0IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDMDFFXJ; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDMDFFXJ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso773957a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789754162; cv=none;
        d=google.com; s=arc-20260327;
        b=pivDJTqpOfm4cxTdh0qTUc2D1krW3+lvlG9ou657VugDejsgjvwI4VuXFY5HABJ9CC
         Pe3w/Bbu1utQ3OlGO/1BPdgghR3H/l1c3mTC3/ftqnFtA28q8nCY34PumdnGtQD78Ps7
         2NtavFNOts+ghiYl6gda07m9f6R4QOMlljMZI6HChcIb6213ciY347VntiXCrR13aNMo
         IE/LsSMky39Qi7Zx/3pbbxSIQyp5Zxrn5XpCMq5DkYW+zn9vkHGI6xJbDD+DwxezxN0u
         8nQi5gx0lAAdUZBF9D1sV/V0IoiLandxcstL5i36sojYHTa6M9UOiifrTwTI97eSy+Ey
         pX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2wCVeSuchgF+6YBCtVhNSkh+TZ7w975CTM84EpU5d0=;
        fh=y+oUv6YIAlBhIW/4ppDL2lONj7DAJgMpP3TJ2zZFBi4=;
        b=cagO4m/pNR2bFgzem9rdXVj3U0B8eiK/pSDcUKnZmYHH75YdGoGmzV+9dtOt42BPUq
         rvtTkVyFrJJ9xY/LC1FtGpg6TCa4/6SvNXV04VRbbuhiRC3h4drT0GoGIIJE4NOYNJa1
         iprIYhwBILIDuW6fWDPYyjDyATABTt/3Pr834u5SjeEFslUmAvod7jjLHVKLD6lrqAWW
         wbyICcCF/VkUH5vhIxwbjOErU0BTxC/VZIiEY+1tq6ZaMP1UNmCseKaG8HinG4nh4nwk
         3l7RZ0qaSmIuilTOHlCgsu5meyQZ+BMr3UW2IninQELwvCA6KH15AfsCUiN+8BrgPFX1
         YIXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789754162; x=1790358962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2wCVeSuchgF+6YBCtVhNSkh+TZ7w975CTM84EpU5d0=;
        b=WDMDFFXJJ6GyYsFRoPt2FYWUxc0Bnp5s2QYAbajuLMFWSGwnf+lDXYi7ttp3i2aPkI
         78DbjrMFNiE0VKZ/w6kLuSubFsCOU1Vm7iY6DB9xittkk8Wx1iFi8gRnlee3Xxsm5CwX
         LD1STote2VgVca56xRaeFevMiPIDZ5UKgqMtqF6Ue410jExndN1vgy5SAsEXr4vA8O+C
         rjH+d1K95Ij+NyG/I1WsKCEvkhXfOmtnyAdbrMN1JCLq4Ox/p32KI5Zy/u/BI5Ty9flf
         sGqP83Tt96tqnMOdW0DOlzxPlLiQWGvE0HO65yjyqHYvN/12L9s74EtdojFKwTuClZWP
         AK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754162; x=1790358962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2wCVeSuchgF+6YBCtVhNSkh+TZ7w975CTM84EpU5d0=;
        b=JoOWGrjaJcO05XavMFWTkzD7/JsnlNux+yOKAsQd2LJ1Y/stb1hvLnwntN5HMm/JTu
         1PhOtLSS+vYYA3Oa+5dKnzAwd0jyuXe2V/nH/l++i6uNPwF/KuLINTbdAvcxZpAhgwF5
         fWIxiodt6ArbhURZGcAQGlSqBZue5ZKWeB4t2QhQq3+/4cCUAmMCcJluPFOVz9ghy5jc
         p9RdvUKdnz3BX3zaLUIkfQripymUaYWQMhuJ41VSCs+Y8l6pP+8qz4BN/kc55kTqqMZx
         XsIEqPDMiMRwteM28RTHvGf5tuedc7mFoW49XB7K8hR5mtUdUgkwhUhUnJfjyl4JMn3T
         R1mA==
X-Forwarded-Encrypted: i=1; AKwUvBwb0q9q7fCH0b2UOluqcikb/Z42aHjfCeLqPF9CI9PdQThFVjFvqBkI5G0t30vQXjPBw2LMdhM=@vger.kernel.org
X-Gm-Message-State: AFuF++mZ9XXZDXnPBhVgitgV4qD+SdlM+uKd2Z7BwTnWn3c+iEM4NsTR
	XT1DIC3VO/M0LFGK9MW1rWXTBpmRjcd1ldzaP6+jZB48YGbPROtP4rdZG2I4ifWjYvidcUQy9gA
	+4lwlnQEvshU31aoR2SLOricfYfcDl+c9iJVUf5HM
X-Gm-Gg: AYBFou0jeDckfoNzvxvDK2dfVEOZDauVWnI6mPfS9hn7yRb8Whf/Vb75By1t5C9Hoid
	eQxBZVW+WK7+9z2tTzcmEPTZ+l/FCA6Pmcu+0BLwzwxFwFIfHEhaW3267lGj68azdlWo87zQYi2
	4yjHIHoceWbzl+oN8B/q/12voK2Pop71oaBFdUdN7DycFhPr+vxKiq1szMILO4tFhkG/DpENTgR
	X4rCJM+rXPUH0THSKtYzp4ODXuFRbXHDVzfbH59nG9iRwNb51Y/ooTZZjPCCn7m51OJe7On0o1S
	lA/oRMUWx12pdhf0vTK0NldvrMhHDf5PcsmpQI9hlwnFAkMdGeOsBxB+aRFytrBZtUI1SfUIlP1
	Raj9BBKx5FYqdAfBz722/B3ru9Sl0tUbqgYs2YkUugAJR/zqoGOHzJ15t5xkziy8vkaZosSYzud
	HwEh7a/WRjx1w3kqSrrZtNSyDAc6Km0MS3
X-Received: by 2002:a17:90b:57e8:b0:39e:6c69:7774 with SMTP id
 98e67ed59e1d1-39e6c697961mr979973a91.29.1789754161489; Fri, 18 Sep 2026
 10:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918153604.579277-1-mbaragiola@linux.com> <CAAVpQUAmGAACd1rBomaY-B2vRiE-VX9u4JRCteVB-940RhRtbg@mail.gmail.com>
 <20260918170042.609084-1-mbaragiola@linux.com>
In-Reply-To: <20260918170042.609084-1-mbaragiola@linux.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 18 Sep 2026 10:55:50 -0700
X-Gm-Features: AcwNN1XB-YqU5k_r2rnPCRh-SjsxnReIoR_iBjfhUznrMsSgjovAPq_0TRW9qgs
Message-ID: <CAAVpQUCnoHDvP4eK_jRHMDS3EaFaKi7XJB9k=xGjGVbkvwrB0w@mail.gmail.com>
Subject: Re: [PATCH net] udp: resubmit encap packets for secondary mcast sockets
To: Mariano Baragiola <mbaragiola@linux.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Anton Danilov <littlesmilingcloud@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 10:00=E2=80=AFAM Mariano Baragiola <mbaragiola@linu=
x.com> wrote:
>
> On Fri, Sep 18, 2026 at 9:21 AM Kuniyuki Iwashima <kuniyu@google.com> wro=
te:
> > Did you see a real problem or is this triggered by an AI report?
> >
> > https://lore.kernel.org/netdev/20260415203624.4057135-1-kuniyu@google.c=
om/
>
> Hi Kuniyuki,
>
> To be completely transparent: this was identified during a code audit fol=
lowing
> commit 3cb8d4b9bfeb, not from a production crash report.
>
> I recognize that standard FOU configurations do not typically have multip=
le listeners
> on the same port (returning -EADDRINUSE), so this primarily affects
> multi-socket/SO_REUSEPORT encapsulation scenarios. If you consider this a=
n
> edge case not worth touching, I am completely fine dropping the patch.

Since the patch adds ip_protocol_deliver_rcu(), syzbot will find a
way to trigger stack overflow, so I think it's not worth a fix unless
there is a real use case.

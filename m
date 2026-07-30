Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E98381AE0
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441524; cv=pass; b=B09YQFfFwzCUOVFMnMQiRPnyFNbdfT9s7EZB6NbhIUcwbbrOM6/JX34vTByZZV8amwhXOa9LnWdTt364iSKwaPazp+FHyJ3TtzsNs+YCELTuCQFx48fnlIUDzv7NufReo19Ya6mmEPW5VhfJJXgbCyyqMJRFtNTcQQ86cwBJ7BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441524; c=relaxed/simple;
	bh=7Cednh6HquBPiU9W3Km1kMvqqC5DEB4MFkVgBiTNJT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Izkj0lGxuJQCQ77gR0pN83RkzuMuUgvQhduLRUenO3Hq+U5+jk0HG5aDUPm2wAE1wWauhW3h9CRpDDEzti6HBehYCDmpgoE+wjh1ScmPJYFIPQDqUnIZpl+04Lq0yJHPM0H2XY+ybb1y16i2yzy0P+DY8pte/USGzsY2tZfFnRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKw4Syvg; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKw4Syvg"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso133822a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441522; cv=none;
        d=google.com; s=arc-20260327;
        b=OIvbp+f8MEaEgHEZLufIKXKzHbK9tO0wD0bhbQh2m5qb3OA2iMAqK8ZYownld7rtHy
         n6eEeI2l8Q9UwawLaiTspIvms1Xh53CLaz45QOF2VRUH9Loyx3baYjwwkypyn01A2H3e
         yehrUZ+z1qoHFvomxHV4O3D7BRbCqeySnCET8UFEeH4YBdSOFfHqWEeTCuTSAWcM3ZJ9
         PVlU/73T5vEjCUHw8yxVoF3ci90WLoRdPLvnGcXY3jR6l8YGjF1QWDozSMFS6KGNK6zi
         ykpwoHVulhRLYHeGx6zShI5ONz6yr7YEqWgNc/FGLfVza6tfevdJmjdOFyupgGFfsqWh
         Ae3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o1ChQe06Osz0DBqXcvVnbkdB0plpgG2sLn5i4gN44QM=;
        fh=OkUqLB//8dEEz02Hco7sz/V6xOQnWK8XusONGNJvglE=;
        b=Lh8JxhiYtXBQgiwjbiOXnwAK0Qct61fOo/F4122jrxoBDeV+f32Kc6dk1ScTJC97dE
         1SW5XuQ1Z1+ucchQ3hBDAK4lAreWE0/736uvSZHDRUioCX6PAzaHELemE90E9a9fuMsD
         TmDV4KEymvpzpZneRboxtmfoGMQD+LpGnA9mC4IlD2rj9yvcp/5FvTkDaQzPr8/zLjnc
         zJJHLTnvbSYvrGGwXb0XZotaAdC0ZWBCUGK8Ny4OSxNpQnrBIA+kWLHT8tdDNF8mk67p
         VO0Wo1OPchSyXSKlhPIl7cO0ubgifmqMf1QXlMf51ZFnHGiVMGvBxJGDdRA6Dx/uU7ww
         80XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785441522; x=1786046322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o1ChQe06Osz0DBqXcvVnbkdB0plpgG2sLn5i4gN44QM=;
        b=DKw4Syvgherfn1VzhkCGkpfcA2wcrwqr7H7Dp+LYEnJ2xo74GCevPdz7+gT8H0cB0W
         FG9oUqBDxTj0sxPGDqgcmgC8/Xdh3xnGsGbT0hprcSJ2E3kkfIMnPyGLarm2J1qHx6Fl
         zg+MsauInTM/zuKZ3LVxobRBeblsDznbOHhErL6MxfSPXKVuTqx2ibgBTH5UQMmyoGLG
         qOtFClp2hXNXDGFoyjbv66+YZOC+ZFzAgVZ4vpVRf4olQMek9VblOu4mciZcQtTA6svd
         KfWjp8bVIWJGUUh7G1AB1IZ164YSpvfoPQNmH445xfnZdvCMMnh7BtTXBNZA3zMHlH13
         RYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441522; x=1786046322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1ChQe06Osz0DBqXcvVnbkdB0plpgG2sLn5i4gN44QM=;
        b=pVSpE44S280S55VNQEvBERYmM0m046TXX/xPnzUBVe9SXssXenD3L7xqs5cb95SC3i
         oyBrGGOqBoxW6RF8tQg2lmSY6dQKFg9IaHW9t8hawa7l2kXgnQmA2qnqADS5vHiuXgqE
         2Pdku/ryklin9W3cH5gPLMjMufM9JKZz+2dOW+Uy1nyB3t16EXV1IXsn2/lxGTdCQChi
         HsMj+UFd23YKqzIguKDqOmvEajJpcS7Nf9pmM43w6YQd2PH8+jlQGI6keIybhHfFj+wx
         wMxD8TUaNE6JlLR6b/iU2p5QZvTyQ2xcjiZvso7eMfe4VYQaESJWG88E+jMmSX9FsO+l
         K8qw==
X-Gm-Message-State: AOJu0Yz34r7K/P4XfuAai9krVHy7LeIXWFypiUCqdDgzGirCspSn6lE0
	1U4SLmDs8TvqP6MAn+tvESkPrRDcARfC0Prm4851uoJ3ORQHBQBh0jQLA22pXsdLxK0XD89aFcc
	pvAQyf4U3x1WpiC7jFPE/1r9/01+qVQlqx3saTN3H
X-Gm-Gg: AR+sD11mtVUZYnZ9o3DFTQNfqi97TKMQQPx5KOxZ5dxF20yCWjRovbpxcOUCUNmbTwz
	56ykT6oTMA7Z8H3C3S4LPIu4oQy9RYz7LwlHPTM0ov1grw24sErjAfZaUKXgrlS6aXUFo+N5RgS
	e4oxquxiA5U76o5zD31vujV2LHFjgfbozpeFiGvhXf/cUG3ZHcazzbMtjIuARkFyLUnFRM/Q5ii
	XjPEGwOQwY2HDI9zPl7s6QAXR4ECYvN8YjV6O1dAvMjnTuvgl9WqoLbqy/hL63HCANgj0tPrjID
	QKlBi5hOkSPtuqtr5aYmtDxbk8xExQRZhyQp0Y0Vb9r30OBorhed2bhySDiQVKpAtH7aE7/o1Tu
	opCv8/awizsYJTuyC+f12c6+DaLfL35DBl2I/TW5k7Kksx1Ug0p7zXwuFbqjS3l7m0yDp
X-Received: by 2002:a05:6a21:6f8b:b0:3bf:b8d8:8296 with SMTP id
 adf61e73a8af0-3c90d44c15dmr1630970637.26.1785441521698; Thu, 30 Jul 2026
 12:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785307984.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1785307984.git.zihanx@nebusec.ai>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 21:58:25 +0200
X-Gm-Features: AUfX_mws6f-Jk1VhHbkEH5LNm4teTltMrpUt8ATwGTSQqakWg2aBeHgGXcQL_QU
Message-ID: <CAAVpQUCLAk3qwGuxg1nHeRR5XX6jFt-9PF+Qq+1TZZTEA+DTmQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: diag: fix unbounded bucket lock hold in diag
 dump paths
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, dsahern@kernel.org, kees@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, fw@strlen.de, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:29=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> Hi Linux kernel maintainers,
>
> We found and validated a issue in net/ipv4/tcp_diag.c and
> net/mptcp/mptcp_diag.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
>
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
>
> ---- details below ----
>
> Bug details:
>
> inet_diag TCP dumps currently execute attacker-controlled
> INET_DIAG_REQ_BYTECODE programs while still holding the listener,
> bind, or ehash bucket locks in tcp_diag_dump(). If the bucket is
> heavily populated and the bytecode is a large reject-all filter, the
> dump path can spend an unbounded amount of time under the same bucket
> lock while walking attacker-arranged sockets.
>
> The reproduced listener case places 131072 SO_REUSEPORT listeners onto
> one colliding listener bucket

This sounds very unlikely to happen.

If you cannot trust your users, you should audit them
properly (e.g. limit # of FDs, use BPF LSM, etc).


[...]
> ----BEGIN crash log----
> [   18.495442] watchdog: BUG: soft lockup - CPU#0 stuck for 3s! [poc:1034=
]
[...]
> [   18.495449] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S unknown 2/2/2022

It seems the soft lockup timeout was deliberately set to be short to
trigger a splat, but 3s on QEMU should be much shorter on a real
machine and it should not be a problem.

Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF83A3834
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667061; cv=pass; b=Wv0ItrxWSIK4qZNKb1+HXDYwze8pYMbT5ujKLuvlLNsK35h6eV68EPD67qVWlGxnal6DCePZBA3K8TmzMmB6aAE8m3J4iGSEYyW7TBiJQ5Few24aOEoZRrP/PA0uxSzuYK+UUUcyKtSod19y4Yr2yCSu7Qq+F0d4cQJ6D/INwSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667061; c=relaxed/simple;
	bh=I35gDNGA4fpIsc0ElTO4/D3swmmdD1nD0eRHXQrQQRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLIxgTcb8qLY4WaJeK46bwxanaE6WCYIBlQMra2X5CaKFN5ViAM2KUh/gYbSctBK6SwBQjaN9HOx2kHkkgcpvbXQELn/lbzM7qId1h+Tr90F/fJw2azKC8mAFInM0En9kHqHPgMk5ivyDaMR0Yni7U8X5BE+eo4qrbQ6K5MK7IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEz6fVnT; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEz6fVnT"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91434eba587so38935696d6.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790667059; cv=none;
        d=google.com; s=arc-20260327;
        b=K62Hvg3UBLRF7RZAwKbaIKY6s5dfMF4zajC5KtSVvEVaMhNsJHZu4fxmIrH5w8klAK
         rFGd1B7Z82biS4EsGsDXOvRs4m5nz8NhdfrEQAS0vnthO11No8UG3rMVt5jzeLh3pgcY
         rnUxsl+HPjCW3U3oyDKRqMtrciCXoPY91PXbFgDuUdFSJI5FhFiButa0nQT08W5yXe5M
         ufE7GGVyEJvA6djfIKrdfYHIvHhiIiFkBHtXtj1UyfWFwrw2jLVE2h6I6iVOaCg/w+h7
         N0Jz/u6sNNRnUeXULAxj7a/AUuFuqffzDOgTcjlkWs8HYIhMtYQV2f1168BtbmRonv7a
         dw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        fh=zKGZa4Ez3YfJfuJzQ2FKNkH7Br/kYgxQm4O1MJF0Eg8=;
        b=a6UbioNoJNpUnQq+iJRPAL1QrMIrADl5zmsrE1qq5tl5F7On+d0XD1D8g90zTUsHgQ
         qVHd67m24WFT7T/CefvIucTk1B1pX7eCGFTrGnOOsLfVsm5BZdrX33OSsHgYT/6n2nZJ
         Dlwg6ybPobEJHFT2srdJkU+mxmMTPCFK186hZAb0AlI+klvccM/OVZm+CgHM1Ay3f8+6
         8CmyPWTHtu2X1qrqMJvxCwPUSrRXqDUWqhYEDFh8xHE+R3/yJV8N/IKDIADFHFKVD8gm
         Jco/RBMqYCDav6DVehznTjU8ED310G9AYy5xoKF7Wj4z+VgHMcAVuDlcXwqMGlGg5a2V
         x9Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790667059; x=1791271859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=bEz6fVnTttyL2gBz5ZoudIT1eHaMMJx80l0ZTmCNvha+RTrwZxHgvV3QMIQn8Cn8xv
         8bUrnAAi6r2V7RmxeFvFJVUF7VpyFhwU0LMs25betgMEwF5uUU6bdk0uNnrIqO8nFrev
         cCPrOjMAkVTgcX4veZuXyjiyZIdMlx/mDUCCt/3XKU2rhfkMEoZXtaOANWGfSkNhR9Cv
         eAZbKbH7uFEfLN4ldYH8J81qVTJTSqqH4AXb1q7WUHqFVg/ZG5BD8eOO7WpaebhzBNcf
         LY+0+0lShac65S9s/ZOZjxDsIou4uYvOPHBQ5aXfxRCozB9TRuowm7BOfav0d6yyoNGG
         GrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667059; x=1791271859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=FKZfhsWl9snt7LelNR9sg9zZqabnjnWRp4HItJ1P6yoVNAuo/Q2ksL5DzVLfUinvjb
         RX3cLsvPkgl67XZG1BpTQOk5XS85Z3w8KVjJiHdi1f1ictwy9zn+Wx+kbUR+jx3I1jRh
         poqzAMGW8kZsB+8ipn6E4VM/+wz0D0DQI0VJT6yM206D0TJrBYp0MsCwNiGbc1zFPzm+
         XlVi7wAlwsH2Y024llH7aWfs6o9mh57vjACs9SDZmx3FGKuNl0Yq37OFoQxW8lWh+Dbv
         xcvPZkv5V9PyqREmEAEeYMmi5KMDsA2U26yFzN7/kwWZ0r1sjmj7pxXupfrqA4jqtxUq
         mHtg==
X-Forwarded-Encrypted: i=1; AKwUvBypAbWYWPlyHrdvZXsXUyk0hPXcyzYFGD/IliGxyzNGNpBdcEQBhB+9aZRU+T2q/ZbwGivdG0E=@vger.kernel.org
X-Gm-Message-State: AFuF++laRGRnPlUzzOMrfW+ORgX+eI7ue/EF6OoXMcGvJaPW9EN/GhXo
	/mU6yz/4ev+NPEz/AMrY5bU0M++B0moEpySM8AkySZM3vUiR0IEPWOKYxhLGbEbjvVk5lMztNVn
	klLeH0lfEX8qIM0vbSInNB2oqiQSKJ+25/cmZl7hd
X-Gm-Gg: AYBFou2aywTeiEplVRgJ+Poa+sv7zM51q/yeHoZpUufxGy13c9/8LKn8jmS47okh84Z
	oGyovSQcXJk0ifuDH/c9fqVQB75nYSG+/9gfQ8JHHre5EXtct5NXkRK6U7hSTy/CRGGsNoOvMNO
	cx3/zu3X3lfNRr1UyEculPtcEkMFMePdKJyQ76T63nJ3rmanoW6Y5AqbwCZa4dpCyI04uS9MPkH
	3Ycv11/nYbxiRrnjLawQR2ANafUNtiEAq6tLImg63AAOVZnCF05jVkC92/+xtCA1it5IUk0Vrzz
	O6GlFj2bgyOQJ3fP1mF4L8X4tzt5mrexk2j9XMOnvAvH29JnYzsBCQNY5oAwHBSgLTZQHoA/qQg
	S22iGwRAos7NqYSe2PeR/tjgIty2qDRS0lAxveQn3EZt4EY4RqVnpiqE8EmlMNkqiqpIh
X-Received: by 2002:a05:622a:580a:b0:532:d3c2:165c with SMTP id
 d75a77b69052e-5330dbe7682mr252226541cf.5.1790667058017; Tue, 29 Sep 2026
 00:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929071743.23624-1-edumazet@kernel.org> <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <179066667444.31693.3326934466907750947@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 09:30:46 +0200
X-Gm-Features: AclHuK9CAnCUx8smImHilXsTcocuUN-fbbX48CMDJnYU9QbhFatMhZFb2tpvc_0
Message-ID: <CANn89iLUKHZVrUOEtqDwuAghCRAkddigPwSWj4uS=fKyWdk86g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

Patch 1/9 fixes a bug found by code inspection.

Other patches are not bug fixes.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

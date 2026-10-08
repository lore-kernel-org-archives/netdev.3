Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C7493623
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453591; cv=pass; b=Pmr5pRf97t2Gnk+agb11m7Kj7vfs21+PHpBMrxfiymHMTH3iNJT5CnAUv0ttKah5vTL3GijJzRc6iT8/12Q/ekc6uIQcHexOs2sqa5abbOrn4lnmBdz1lTC1mXyjBbgUHHwosVt5jmTLUOZ8n3jBfCPEJql4aqCk34OLCw5ksVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453591; c=relaxed/simple;
	bh=vGEabZlK0+CeQ/pjYwF2a58KwPzkGrqiGm4U7jtESLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEAl+S3gmPu05o6q6VVOatExFu+8xye57NFzX2hVC+ve0bOCYG5lh+2v4/IEFASadQf2/s6WsfkpHR5ufmN/LbVhjLw8eGyPELZcjKGCmABx+uZ0jL7fDuVEuE5wGda7b2dA7lV3H+Wi9yVVsmQY5KieJpgD7lx8dGCRAsEHQrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish; spf=pass smtp.mailfrom=ink.fish; dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b=hVzizJns; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ink.fish
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b="hVzizJns"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6afa6bf3b45so4429492a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 02:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791453585; cv=none;
        d=google.com; s=arc-20260327;
        b=LKap8XSCZeS0dCf+Lw0KwG0/LHAC5aYY1pzLeLsVh4vVHFI2ym82VYyrqdsjKQ/gpv
         5Ybak1StTPaSrhDnmojc5AP9/q1UE15fct5UDjwvaE1guA1Xe0wFNQXzE61VCTD1vFw1
         rraP2N1lx8MsKxVWTWGORBGcUD//3PzIRNT5QIr+JqJ6/CY1FfsiL/HD/3B24HVoHbow
         qdHG9wwd6am1wEoKGmdBDfMKEUN274hV/wNw/cdCvcp3MBs5hlFlh3ax6WLXSPyYjVU2
         BhtJBY/qKHdagKetEwlST9+LjXv4M8V9rcileqnDXNVuncuO9wpWkTQfld0W6vSVvcwH
         BnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJXr7SMdL2O4zud2v5umGR1pHKL3RTbPRwBEIieOT0M=;
        fh=r/cwR10yVO9qIcqMlyRqluOzdaQC2W+DB32Bhiocx70=;
        b=dqesVAR1D4Z+pWaoLXWsyrLlBIY6UXnChXQeH/qKgxWFYbMXvGrzriDNdkchd8ThbP
         1ZwgLZwbC2eRpjfchZJCHkc2OAblSGnn8UpBCdHS1tKKy/vLkykxTVSvhmgwdJpyzhYj
         +PfyFWSDAQK140mRVQLXIYxChsQkDPZsxuoCSyZ3Dys3ZlsoA1NysDj9ymqEhXLEVxIY
         SCqi/C85/fAGbLXnI+Sxk3EeEjLZ38Y6iOHjt29ktpzVMx/cf3h3kE/cE3oacc47Ekn6
         +Rv+cFLQi4p0oIm17QZdu2P2uvwfDThpDvl+FjHbYz7e/VA+2gLjOhyOcpwfMlX0Af+J
         12Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ink.fish; s=google; t=1791453585; x=1792058385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJXr7SMdL2O4zud2v5umGR1pHKL3RTbPRwBEIieOT0M=;
        b=hVzizJnsehIoL12EupU+tym/lF4owraB7HNNDBAF9/afcvh5zDXU5lS176Z58i8orj
         TpaXfRKrbTQXHQXW00eZqmlGFgyJEhj2hk5dy/TLJ3jcg2tLPXZD0cHMVY3D5QGNdv2y
         DtY0Ew7hzDnWha2rytwUm5SUV3FUqcH02odVjqiPuZr/t8lJXVYNMK7WmHf4GRbwPSJI
         2VFwipWW4/EIsbUfZEAEtWxlBCFtywgpKSSshdWND6+HlFanJZBV37CuCtiOQ3Tt60nF
         dxHvBhB0aEupNA/bW1V2evcZ9VdR0bAdZvSqeFK75DyPO3T9JMR5r2FcVy3F7JeU6eO4
         +b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453585; x=1792058385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJXr7SMdL2O4zud2v5umGR1pHKL3RTbPRwBEIieOT0M=;
        b=qd0vtnd0FQGcBIFC1di8xOIBEJGWJduUUE9CMxcd4cOQXIBWSYOarDjBlFjQgcUsuo
         MPXblJi9y011lmJsoecHAuTQ8eAahgiI8ujB5MjMjpCgINH8C31u/ZH2z+6Oe0hU8Fik
         MgtLYu7WxphbgegJ9CHUP/kzVQARdpiZ3ntdGerN4wzIOnFrWz2Yrum4DH2f+ydukAQ+
         R1X+eBpq7kOFMY/kWxrmmhMBIOsOp1oUbZktvT7V8hMhISYAnbyXE+T9LKETtdn2689x
         KhRQYmcSLjix1jywDUrjm4akZT3OxQ/m8WSWq6rVirFW/9OBnYEz95zx4ddPoAUgIQ+I
         CoiA==
X-Forwarded-Encrypted: i=1; AKwUvBxf39DijsDn1bo5jC0dQuSvM66oCWJCOkG7ElqFecQeZWGAekmVaJkEMrgKlTf9qrkxyEZcXLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJKzQXZpg7Eb46GZv6yVJM5kEArM33Qw6vQOQm67gZewBgriEv
	mMNbU6cWRWXSJ5SgIcugMr+kQ1Qlc56+ziZoMa03g3NRSC2nfZdy/KoA4DGNt8XFnvB4MvIo34m
	E7FVFHC7ewoZMJBfFMxzeekmz/hib6KUzxJTBewWHfA==
X-Gm-Gg: AYBFou3kvw9OEM8mPdSphw2sCLaIJfw58IQsBoLw2VXmdlWWYtCEq54l+eZcrtrdIvM
	7qLt8xLIKWlrfIDBljWD+BXq77ikTjb2HzejZNgXoOch7hJlH1I+3iims5FpwclQSsqbgRB+plC
	pEDi3nwIjalq8RIvRVNSkbC7RqRJOQBn0zxCVQgKsSJXxpmV+FCipjPRCDwPGYpsRO6adp39tKf
	BFGE91mpdh90WVEoDRT4GXz6f/kEB/74abkeoLGbo1bpNxVddpmT3I0llDxQqBcexniuDK6Ofiy
	uHcN1Su8s6YLHW3fmnKAh8QBGfPsAgE9M+bRV4fq4Kn8GDCbnVTX287RfKqX1ColJ5XK6wM3O9D
	mxdU3KYoKCS5iw7sPUvJWDxE8DWn1RGmqk1XgLT8B82vEEnub69CQO5Iu+UBi9GdACpG3mUJbag
	==
X-Received: by 2002:a05:6402:21cc:b0:6af:9d70:6d5c with SMTP id
 4fb4d7f45d1cf-6aff458b1edmr3946654a12.23.1791453585259; Thu, 08 Oct 2026
 02:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
In-Reply-To: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
From: Petar Sakic <petar.sakic@ink.fish>
Date: Thu, 8 Oct 2026 11:59:33 +0200
X-Gm-Features: AclHuK_4uVXrewIIMOoGuldSrX8m4_JXXpcFPLw8nKMC2Hd5ZtIFNc6jpiCVS68
Message-ID: <CAFPPu1ivuG_z9Ko8VUq8Ke4Qh4vWkr4xXGZMdeouKf75qf_bpA@mail.gmail.com>
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows becoming established
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi T S,

Thanks for picking this up. One note on the Fixes tag: we reproduced
the hang on 6.8 as well as 6.12.111, 6.18.15 and 7.2.6, so it predates
e00b63056fb4 (Aug 2026). That commit is related but not the origin.

Cheers
- Petar

On Thu, Oct 8, 2026 at 11:53=E2=80=AFAM T S Rameshkumar <rameshsv06@gmail.c=
om> wrote:
>
> With TCP Fast Open on an MPTCP listener, if the server application
> writes data while the passive subflow is still in SYN_RECV (after
> consuming the client's SYN data but before the MP_CAPABLE third ACK
> arrives), __mptcp_subflow_active() refuses transmission and the data
> is queued into the msk write queue.
>
> When the MPC third ACK arrives, check_fully_established() marks the
> subflow established, but because the third ACK carries no DSS data,
> the queued bytes remain stranded until the peer sends more data.
>
> Fix this by:
> 1. Invoking __mptcp_check_push() in check_fully_established() when
>    subflow->is_mptfo is set.
> 2. Setting MPTCP_PUSH_PENDING and scheduling the MPTCP worker in
>    subflow_state_change() so that once the underlying subflow transitions
>    to TCP_ESTABLISHED, pending queued bytes are immediately flushed.
>
> Reported-by: Petar Sakic <petar.sakic@ink.fish>
> Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=3D=
X3qf6QycjfKBw+8snPg@mail.gmail.com/
> Fixes: e00b63056fb4 ("fastopen: only mark MPTFO subflows with SYN data")
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
> ---
>  net/mptcp/options.c | 7 +++++++
>  net/mptcp/subflow.c | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5..d5238fa11 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_s=
ock *msk, struct sock *ssk,
>
>         mptcp_data_lock((struct sock *)msk);
>         __mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +       /* Passive TFO: the application may have written data while the
> +        * subflow was still in SYN_RECV; __mptcp_subflow_active() refuse=
d
> +        * it then and nothing else spools the msk write queue when the
> +        * MPC third ack (no DSS) arrives. Push it now.
> +        */
> +       if (subflow->is_mptfo)
> +               __mptcp_check_push((struct sock *)msk, ssk);
>         mptcp_data_unlock((struct sock *)msk);
>
>  check_notify:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2..f499073a6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1894,6 +1894,11 @@ static void subflow_state_change(struct sock *sk)
>         if (subflow->resetting)
>                 return;
>
> +       if (subflow->is_mptfo) {
> +               set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(parent)->cb_flags);
> +               mptcp_schedule_work(parent);
> +       }
> +
>         /* as recvmsg() does not acquire the subflow socket for ssk selec=
tion
>          * a fin packet carrying a DSS can be unnoticed if we don't trigg=
er
>          * the data available machinery here.
> --
> 2.34.1
>

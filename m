Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D4344DB9
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117291; cv=pass; b=BYtKECOuP6+HRnGV2vaq9R6nHWLniFlNfKrPdlJ48fYi5Bh3auuBNMGZUrAvM06oi0SeD1lf22xrKRRnnw/6c0s7jBJKh9gJkl32ApiSfJueZAMqHAMy/0H3UuzfwWSsA0qy1Bdo0fY3jAtFtwWwNEESZBjmh10LpaFqSPaHzB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117291; c=relaxed/simple;
	bh=rtmriYEiiXh9AiGf/ImslMhlbJqXEvvwuLm05PxWEhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3pbRU3jd4ci8CqVL5WmjuL23y5gDL1VNo9+/whNFWxH+sUg6ICLx1jBg50HvNuRQTY9qRlA3KBZhdJh2eG6SJUiT1OYAzP7UDIpZu86FaKKapi6f37e4vA9gBvibdOeAP67BM00l5R4V/KXx9BKDQwJd4wOcv6HAovjg2E19bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf/KhVGI; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf/KhVGI"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3006830b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785117289; cv=none;
        d=google.com; s=arc-20260327;
        b=En5/bPNV9Uj+dSRsWIYDBetuh6atlPOEv0Z7V/dnJj5uKxV+mHel2KtL1mnzIIQbNC
         +wCuh1eMvH/fvH328XNB+THCKMFoxcb3NJWTuYbXEkuCFHUuMbkoimbXZGBUYgGG2+LW
         1yRKN0gobdb+YMUvaul+QpzQVOXuo7NSUv3mfXyP1It06Jv7srb2eBlRZTwX08gRPAyZ
         JfTtdUCZmTebwSSHuUA3g2Dnd1zpBdAW3cLYAkPZjgxFOntz72YeilJ5mQbNJ8A/0x/L
         +6N1PvcMrpHFSdUhthlUg5tzbjVY8IneMR/4qW6/Ln6KFNPa1fiXLIjJfVU03O4co2Fb
         RtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ecSEh+Y8e2yI7Di008PFhEfYZS8V17bShnvXF3pJHY=;
        fh=jmwt8+Dqw++/vbNhcS255exKMc2GCG1Gb4C6JfetM90=;
        b=mDJwB8zmFxgAsMCH6VRVhbW4NKWoFZw++FtCygrt5PPLAyPBgPY1rXYg4S3XMF7Afk
         wIuX8rAvwZG4OTxspBQ+WBMNIN6SnHsvoa50nAGuzllYg176bRoCJBfgDv6pqWUeA2/9
         T1Bsg1S6jWsOsRqqRCFkA2U+YrDYmkIe7SWzU5/e7jT7PyETbjhvFDr0DGdEIKGHC8WN
         cYS5uL0o4bOO8vWP1HrReBSYUWdtC1r7Jv7qLhgJwnGgsod2wRgO6hJh/0SJgfSYRJuj
         NL1i7DgV+Zkm5ptiICxEe7QOAiGpZ2aszvpryfVOJtSyPfljscGoAyQ3UuSaeMD16uuN
         m+gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117289; x=1785722089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ecSEh+Y8e2yI7Di008PFhEfYZS8V17bShnvXF3pJHY=;
        b=Qf/KhVGItvadUqJWNk5XSKVNAtT2pGPcWJz6OTSgezZUOe2ymIdwFH0CCR0U8U9HRd
         f26iuBjOHvifrwWzonhQoOCPjhMFtUXULrxzoxgKupu7mWh6WDCa/0kbKuV7cc1XrbWa
         2I5N8zOBHgKcOJ/HixIitwBPfWDVkk5qugHBZyx+8gzn4vCZDfq+qdhezAa89vInG6EJ
         zF757IhshgukK1UGiOB73aQXyl/HxOASEcVlf4VA43OMrKKHxD9VfWeZ8fH3S//Ab2hK
         HITlYKo4R7alaEY9JtoE3jzfbEly++sFBbua+pdYMgczCtPo2jA4b0q2KsehFxzuzNza
         xgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117289; x=1785722089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ecSEh+Y8e2yI7Di008PFhEfYZS8V17bShnvXF3pJHY=;
        b=a3hPmEpeIElgK3ph6BCk5VlsZaBqSgr+pcZEh2ReQ+z2nLFmbGTyF/m1f7bQ7v3K90
         CblbxQsj/4hITcDUfsfDsvY0lVehEjsgbFLZFbmITwtARCQgs82mCNnmT5+MyUmkEWIw
         rEUReI6dCi4M/7Hsx1e3a1TcsLm9I/dGRaYYu6fXlRx9tEaVOdfCjgvP8dXyv2e+/xH7
         oBS7hLzg1NwgpWOrx8eOMsX+E9HdIRGskm3kFJkuzzn471W3xWQQmuQWXsCKXQbgyuri
         rSaFgXuHJISF85c59aLD5Ko7awkkhIcC7oLDau0jtj7nUMzh/NoeegN3IRxJJBtlKn90
         hRTA==
X-Gm-Message-State: AOJu0Yx3iacswdsgYFJjwPr6KUqM2GEtQyGPD9gzAEmLczKy+lVxdTLA
	KqTPT3Kp9qh5srgGw8NLotCVeCFAOoWwjuq4nuSaZXQTCE8X73y+/gHdgpDRscZ1j3Zwwmk/zA3
	sDwru4Ep909f7ssl2x2TsanTpKe5/dHM=
X-Gm-Gg: AR+sD113WJMrFCkoyi6UA6bcmsLcZEg4KyRwRL0b0rCqk88TfJxMG8dkrWtfVeOjPEj
	L2jlS/xa04x//DETGzOgiVoTj0nBmkiyax354VdtJ3f0Wu7V8gr+ryVOdGZYDRubPn9thN9aS5/
	gQcxW5eGBPfNZifZ9q/BLbYbZC6AdbvFmDaYQj3j5tXN07JngbHBS1+4f2jwOJpusOgtkKfjgHf
	lbrxIh3/QqyHibRpgfg+ILepv/T75NssWT5xHv2UMboZXduDc7GThV+tIqI9sHtSrYleEtNr6G/
	o+Aix6VriYMdZHttjbaT6+I2nq+CPKkS7nG/vaWWVYgIYiaDC2f0DmG4fpmEJQ==
X-Received: by 2002:a05:6a00:1947:b0:848:6895:b754 with SMTP id
 d2e1a72fcca58-84e5946ff2amr5220235b3a.28.1785117288699; Sun, 26 Jul 2026
 18:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725032053.521705-1-manizada@pm.me>
In-Reply-To: <20260725032053.521705-1-manizada@pm.me>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 26 Jul 2026 21:54:37 -0400
X-Gm-Features: AUfX_mwsbOAjAfHSNJPFMow5jaMI4QuDx4UrQ8_46JnLFLe9Upel7JdQzagr2CI
Message-ID: <CADvbK_dkGGDe=U5SP4nNGuFRgT4FLqbBsEggh2k7qtnhU1XfxQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: prevent peer transport count overflow
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:21=E2=80=AFPM Asim Viladi Oglu Manizada
<manizada@pm.me> wrote:
>
> sctp_assoc_add_peer() increments the association's 16-bit transport_count
> for every new unique peer. Adding the 65,536th transport wraps the count =
to
> zero.
>
> SCTP sock_diag uses transport_count to reserve the INET_DIAG_PEERS payloa=
d,
> then copies one sockaddr_storage for every entry in transport_addr_list.
> After the wrap, a diagnostic dump reserves an empty payload and writes
> 8 MiB of peer addresses past the skb tail.
>
> Reject a new unique peer when transport_count has reached U16_MAX. Perfor=
m
> the check after the existing-peer lookup so a duplicate address continues
> to return its existing transport at the limit.
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
> ---
>  net/sctp/associola.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 62d3cc155809..b6ac0966420a 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -614,6 +614,9 @@ struct sctp_transport *sctp_assoc_add_peer(struct sct=
p_association *asoc,
>                 return peer;
>         }
>
> +       if (asoc->peer.transport_count =3D=3D U16_MAX)
> +               return NULL;
> +
>         peer =3D sctp_transport_new(asoc->base.net, addr, gfp);
>         if (!peer)
>                 return NULL;
> --
> 2.53.0
>
Acked-by: Xin Long <lucien.xin@gmail.com>

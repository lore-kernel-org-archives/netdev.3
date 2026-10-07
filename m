Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855E1D5174
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377616; cv=pass; b=Mb+p75NnKuj0i2jJgQbPXxbq9Fh8UjD3O8BAe9dktESRNZfkZPUcR5oMBxxQuYhmKlP1aGkipmk9YiS5gh32xGZl5e+ggLMLMwc9kzxMm3ISUfglD27ZZOWLMar0YaKJSAr5UhvWt6sp7AeCr+YEtBb2Os0Uib/3t/SHB1VBM4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377616; c=relaxed/simple;
	bh=7o8IHTHMGS/voyHQzhmgvEE338B91PLKSiRWBKqVlo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWDC1REBiOUEpo6JUwPrVv1DwmUDJxvsNAWi/m5cdqaTDyBjsGSS0L5XH2x8omDc0Gj3Vs2qx8hZ45BDgMqgwKHm6UPLUvWIw2l1Drw5YtHcAqhJWdoTA2At4t9UCMIO9ArI/df3nHnOVoSCgsHPbEGZqZKbFP4PrGN19mLffYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIxG2N49; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIxG2N49"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccc7a6070b4so911398a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 05:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377608; cv=none;
        d=google.com; s=arc-20260327;
        b=kmh9xMcWPL12YQjPHdaiAwVNgOq8zJZtHI76WG+YnFLNi4fI3GDcHrOB0xBXyZvt2w
         06cSgEGy4pchc6d9MasSWi5dt1l9PfvncuNfpdQHT18PmbTNGcPk6Xk/MxjI4SrEyLQe
         yJxlTF7fsrIF54jstA4+IQ4IPRj37RKDpPcU9QXMUcbjWRua8sUPhSCACDk1OFpXGZP+
         Im+Xh7La1EkMGal60b/CaDZe5ovOEvWKCBlBTAGGKZWlYNVDQctZkCOrnmbe4C9tesN+
         W2QWjok7tZ9YBG0u0aNFGbgmRUTaqyyo2KOab110lsFbkm+aFvToHlJz4IqaCUw9tCqZ
         6ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bvmAYJ9uVcHWwdsdUVnTxzhHRQGok8mw2i6i7B3HO9M=;
        fh=Zo2qOUpSN20g9EUblC4lmnAocDD2BZWLdFpMKDFUbaE=;
        b=oPMdrqkkuFDAxM6mkOnNS0Sw1PduUd0EkMvsbnDEoiFoiCo3DEUiIbkjK4hpiQUU2i
         6CbEP+dGCPa/doEuh1g9dDoM7r4SudVZApfKNQTG/yZsDkMMb2ODIR7/qocaLymtcZFf
         oLB7HHGWg2rhUQPN483AZiOcd5ubaSvoRcogc35QAf/QZ6DqGacVcwSiud0DHmao07ne
         etv4e+SuhQhxGa67cOskcmkYq4CzmZ529rKgZ9vdy4692+o6tR/HgprAEjMgqUQRxWga
         3lWh3xXjvXsM2OknAAHkBGClpweUd5znTRkBZtAg/TE6BpifenWqU5KYVPz3W96NTa70
         qoqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791377608; x=1791982408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bvmAYJ9uVcHWwdsdUVnTxzhHRQGok8mw2i6i7B3HO9M=;
        b=PIxG2N49285eXSYCZn2gLCqbp8bjI59uxYeCx2TPVnB5M0DbL482ZZcECgaviONelM
         eEEhQLo0LzSIvpd40MbL6Jq774G3ddQ5daIuSeyaEpVYvxNWS79+jgzJuP3Yzz7ZRcy0
         gjYMa9CKknD99XA6mq5iOskjJ5jdMtDrd+OffKAvyWhWtX0yetE3KOIPYWs9hHJrqdTm
         QHqUFyxtwgGT1J985bMrIsoyps/R08+1Jv4QJg17QJWFMrwWhc8IN68dGUIKCaQ8MDPy
         47zjW2m1Ftde0iIMMJu2UyOdbFtZF4gza3fBOcFbFJlniC8WsAD9yqO1lDRyTdDqzpdb
         4o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377608; x=1791982408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvmAYJ9uVcHWwdsdUVnTxzhHRQGok8mw2i6i7B3HO9M=;
        b=H3PRGZWZj5wgIs1BggqQ/kLX1VsLks/qqvxIKxV3s9t8BtO40tIyD91NlPnXerc+VK
         cLUec1FoVEy1dZ79l8FWwG0R+CA9RtbzLCgv9wC4W8JTvKDS7bF+WlKImMZmDwD13QPU
         BMDbg5qc4QIy9WnvVo4Z70eqhDD219CicrWCk8rkDAFiTAfmaFoMqt7CFzuz3dOPhS7O
         pDXK29Dl8KJG5B4L7ujfAiEQwntOeDZQ57JQHSeMiwzsW/Log0UQ8xY6AulXVU28NM5f
         HnvHYgTPSte3IIQ+OcXrOAWPHErvmPWMYKLSLpL+cusFC+i3PNI0ASRtSG68XTPvGNRw
         jxPQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8W/8xl1Gyy2/MfOjqiCRpCJOpLH0KIcIq5EadAax2gYnxCUjDFGaFl3+5yifNzeng7Mn9djM=@vger.kernel.org
X-Gm-Message-State: AFuF++kR1SAt9YWO9G/opZAp8EFSsJGerRs4guOIvpx36Qj1k6bV9qQj
	KKYpkKMtYzz+4ZW2bkEBZ+a7ikFnqm/NtK1UdZ1RcQ+V3/rBVrrYX3yGs/0FrqtCeM0TapSBy5F
	ugqJNGLcY2iK/8tWHtN2Cf3pyvOc0q3U=
X-Gm-Gg: AYBFou3I4TTIH6mO6ANdoFO1TO5gsvF3lUOe7kQr1DzcyjpPYj93pgjt/itamFy7fK0
	ke2a89BFLzEo+kxXC0q11fYTortSRxBwAKz1NNcF7W/nTaSnMGVQPYAJUSBpX+POZA54sBW3596
	+WYxKZPt040dqBtiX4jw63hzxScO27DJwj7YIRVBejb2w7hxpjLoENQzVJo4saccqzuvQaBlQO3
	k8qTlFTRRJBVG4u+qIFsX0EY/rzONzzJ4lEeEKqBXYUYfnoXHhfrqHKw/4e7IJlOiVBo/qgfkmZ
	NngVepTymROv8z3PMPeicNNU0pFa7SYSyNkiVhRy4D5CB+yhJtBV/50dLU0NaL6b2VbAweGVbss
	hqdVuWECdflGIVxa5K/qW78dn45e3nopI/SLus1HvPJjsmV7tJIR5+GD9HBUimDP2
X-Received: by 2002:a05:6a21:394b:b0:3de:b0cc:b0ed with SMTP id
 adf61e73a8af0-3e134043d29mr1761808637.18.1791377608192; Wed, 07 Oct 2026
 05:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007095128.1370109-1-benquike@gmail.com>
In-Reply-To: <20261007095128.1370109-1-benquike@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 7 Oct 2026 08:53:16 -0400
X-Gm-Features: AclHuK_HAnf8AxibDk4DcYXebRklfeO2nu44MIRw5S2vZVI5Uo2hAuf7krbvADw
Message-ID: <CADvbK_dOXrS+3JnqmRyssAJQ0v+WLig-i8Nk-M65Qg51AtskvA@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: copy zeroed stats to user in
 sctp_getsockopt_pr_streamstatus() when !streamoute
To: Hui Peng <benquike@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Yasevich <vyasevich@gmail.com>, 
	Neil Horman <nhorman@tuxdriver.com>, Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 5:51=E2=80=AFAM Hui Peng <benquike@gmail.com> wrote:
>
> When an SCTP stream output extension structure (streamoute) has not yet
> been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
> variables params.sprstat_abandoned_unsent =3D 0 and
> params.sprstat_abandoned_sent =3D 0, but then immediately jumps to 'out:'=
,
> bypassing copy_to_user(). As a result, when an uninitialized user buffer
> is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
> success (0) without copying the zeroed stats back to user space, leaving
> uninitialized data in the user buffer.
>
> Refactor the !streamoute check into an if-else chain so that when
> streamoute is NULL, params is zeroed and falls through to copy_to_user(),
> copying the zeroed stats to user space and setting retval =3D 0 once befo=
re
> returning.
>
> Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
> sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) on =
a
> freshly created stream: on the unfixed kernel the user struct contains
> uninitialized stack garbage; whereas with this fix applied, getsockopt()
> copies zeroed stats into user space and returns 0.
>
> Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")
> Cc: stable@vger.kernel.org
> Reviewed-by: Xin Long <lucien.xin@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - Re-target subject tag from [PATCH net-next v2] to [PATCH net v3].
> - Fix Fixes: tag SHA to f952be79cebd ("sctp: introduce struct sctp_stream=
_out_ext")
>   as suggested by Simon Horman and Xin Long.
>
> Changes in v2:
> - Re-target subject tag to [PATCH net-next v2].
> - Remove redundant retval =3D 0 assignment in !streamoute block and fall
>   through to copy_to_user() as suggested by Paolo Abeni and Xin Long.
>
>  net/sctp/socket.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index a2235905d2ee..bc5b78ab589a 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7568,9 +7568,5 @@ static int sctp_getsockopt_pr_streamstatus(struct s=
ock *sk, int len,
>         if (!streamoute) {
>                 params.sprstat_abandoned_unsent =3D 0;
>                 params.sprstat_abandoned_sent =3D 0;
> -               retval =3D 0;
> -               goto out;
> -       } else if (policy =3D=3D SCTP_PR_SCTP_ALL) {
> +       } else if (policy =3D=3D SCTP_PR_SCTP_ALL) {
>                 params.sprstat_abandoned_unsent =3D 0;
>                 params.sprstat_abandoned_sent =3D 0;
> --
> 2.47.3
V2 is already applied by netdev maintainer with the Fixes tag fixed.

We can drop this one now.

Thanks.

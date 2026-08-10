Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D73CB561
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367375; cv=pass; b=EcegpcXaK6uLN8CFckXOakUShKyEkIeX/5nUEbYSf1Yv9b95c2Fn+uTT7RDXVJE/v98wGjzXt1OONkj2ukSuRDY+XW+phFXXyEfRzyJY1oWFWQhSKnpRbMj2Tqn4PaI7ykympMBjivHhNGasPJR/jBVjkOJ0KeeL1Y2Xta6QdTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367375; c=relaxed/simple;
	bh=/OsoJ6WFMuNprCL2My0grk6w6fmGF77nobg7rrCwVqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud97TqJ+aHJjOMsKqsjac4RnNTtksfxsyg4W1L35Y2o/g0IA94oPLBR2u3TQpZpAbCe5OcJQdYfb/y23MLExX6CSQaloVGePARdhHXt6IHj5RkZBNwTEP3pHujJN6NuwBuWdG7FxDs6siGg2oZP5/iqv3YRgnBIsjO4mtFA4GqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6DnQ0Lz; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6DnQ0Lz"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7389cff36bdso203345137.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786367371; cv=none;
        d=google.com; s=arc-20260327;
        b=cZ+AsRk0bl7c7QP6taagc3cKLYDbfk14oI+W3mP2RfGjnxtxCQOus/KQHUbKvmUxNW
         4OB1yv7q8RonUDwJ+wRdAAvgfDvOxISpzRF6T+U6+qpxdKtZq/YF3TaYeviDe1/pmtT5
         Dj8dYgHGmVxEOV1ZcwF4Cq5zFMaucgGkTrj5+3i96eBOR6+4gHX9DMnKURq8S7QC9D51
         WBrdYQcTGmn0wUnymVL8Ijpwd8aL08mOKO6T4RBYhsjUkhkdXrxiJAMT6kexfNbYsr/Q
         9o+ckO2SKTI+Bh43fF/i/itUnJP+4zNWubDLLrW1VaRrwH3JpIltT/qQnvsEN/gjiu8l
         Tk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHKwQBIE8Wzfaah998DNpv9XkkL4runk8ryU+O/Sfu0=;
        fh=4kekgCMt2n5dxDFk13/mMP6y8UzUbhkcjnRCQHlfi6M=;
        b=aEXfZloxqPpujPYG+GRo7wN7uJDAk1eSKCBL3wzioIBaXAeVzPiSzsFeAdZjXI4py0
         IDTAHOrpCi0XaoVJU27pq3FoJdmIdQqvZDEz625qTnWEKNpMb1cMUo5kgvA6D9a0F/jC
         drTuHfpKsAgtLCUDIW3AayX8PWnoDwhG6q8XZ8RV3k9KaQ/HQVkxEh8mG9Bi0qvdbqFk
         bd5peIfcE6NC0BtxlJ+2/cC/73+VveSwvsLfsu1upbvZS34jSai1o0kXouMNfJ60sIHG
         4q8lLP+BgXAlyd1hf0j0OYOY++QUyYffobUMMOZDP/KrqxoQ1NvvLyu80xVgItqPRVjr
         0pBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367371; x=1786972171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHKwQBIE8Wzfaah998DNpv9XkkL4runk8ryU+O/Sfu0=;
        b=L6DnQ0LzA47xitcNNBNQLWHnYPE19sdz1coiB3IPO/kpJ26H9gBu4G9AZ7fiL6XjDE
         AAzhV7AzPcmm07tYax+nxgWDisgvw/2RPlXmp3NHlPhohLxZvPKDtxxFSxL8on2WFyWk
         HqWfBZZEaH9uOM4WnOKc6jhK8JKhf+iz2Q+cj3isgriqdlHWE3KFEDvpiH7/Jt/pDtC8
         k1s8us28Z0vjE5xFRDx1CcrORzfoepNf1JBHaB22jKwvDobhO2sr81fGA6ef+scx15OG
         TJWMs47plcfp+gnGGL737PS/rf/o1BiqqqEr4f/QFDoVrxNSGIbeLVLwMHtTpCbEnP8p
         UOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367371; x=1786972171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHKwQBIE8Wzfaah998DNpv9XkkL4runk8ryU+O/Sfu0=;
        b=jlBgzB2rQb0oZkZvJZ2joIwSSAOxTUIzXveLETVwaE2UXL26JDGfJo6kfkrpnMELih
         +HtLPjtue/r6D7yE8Esm7GPlSUFHbR9tqcq+TBmdVggw4KsvXoNZbsAs+V3Dviwurpsg
         8LjMew3iIOOSCt5OlBQpFHi6Bl2sJ8/gn7S1ptgAqCq3rCHMHxfjDRbtHD9nwWyvVHJV
         KhaLhnuNP4B3Q85/3kzjyind0EVikiipEK3Skc/kXOUuneDZ13gYJrmp4S3JO/vVxTM1
         zmxoN9DRO+tEp5ObOs4jOIIGzEKAyaVbAhj8OXB4pAmevYpIpuoBldFNPnjupxhIyFE/
         E2KQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+hb7RdsegKblLuRNVenZGmOGTvYeMp7Qiny9qF7zk36qJsAPFEqDFbk3dhN0GupLZzJnuE78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+HItmvAZ2hzVBHk+iH3nIV2zuos71JsNrLJU8QArdCgT/na3
	qwFEsjNugosyH9rfZs6IjkQbpiZhofBZVwD0A5VwdGMXtrDhnhQ26RaHcu2iybJbUL6YtbJ1beb
	wBgPheyEqCSoYovkXmTWye3/Ko8Eiric=
X-Gm-Gg: AR+sD11U8pUO3qetR8yGS4CWfqK3Yz9XhcZzqLRRe0etbb4xq3CVhM8TATAtrH694tV
	jDwvyODbH/ObO+1S+Nenv2JcMEX/7RaNDe5z5uvHubwkEZz5n8SDvCb1ZkqUpholU3VMZbhNLj6
	OXCHi9osw65GFI14b5dql0g/9mmS7OTBg3xvEFWxQcAEZVrPCveq1ugniVwu860OtFEy5M9lmKW
	YzDknjSRIuNmD6B6YUCZfThiIAbaC954IkRZY13kmgZ1HQKGPX6onLMHobYIhV7R6FxdUGttZpk
	3+f0EC2BikolrfFCXDO0fuB4lxMLFWRzdJ+ocWc51d1cOSdNLmszyRNxVxnqXBClt64kJqTPAzf
	/rzEPdypVRWOc+juE7mPS+EevF7ZWe6nvogYRuzyjqJkjHQ==
X-Received: by 2002:a05:6102:f84:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-760e8f3a718mr10041605137.14.1786367371255; Mon, 10 Aug 2026
 06:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809043806.2768302-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260809043806.2768302-1-yangyx22@mails.tsinghua.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Aug 2026 09:09:15 -0400
X-Gm-Features: AUfX_mzsbeYdYkOlQZHCVgoV17rwfrw_tCfsBSPvbAc2yHIWo94HLmGEcrDrukY
Message-ID: <CADvbK_cv+Wkb5r-8_sGnKsuA5tfErvLoiPZYVN=yXALbWfBOGw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix use-after-free of cached ASCONF chunk
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 12:38=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> addip_last_asconf caches the outstanding outbound ASCONF chunk. The norma=
l
> ASCONF-ACK completion path releases the chunk and clears the pointer.
>
> However, sctp_asconf_queue_teardown() releases the cached chunk without
> clearing addip_last_asconf. During peer restart handling,
> sctp_sf_do_dupcook_a() queues SCTP_CMD_PURGE_ASCONF_QUEUE, which invokes
> sctp_asconf_queue_teardown() while the association remains alive and leav=
es
> the pointer dangling.
>
> A delayed authenticated ASCONF-ACK can then reach sctp_sf_do_asconf_ack()=
,
> which accesses the stale chunk and passes it to sctp_process_asconf_ack()=
,
> causing a use-after-free and a second release.
>
> Clearing the pointer exposes a race with T4 expiry. Peer restart handling
> queues the timer stop before the purge, but SCTP_CMD_TIMER_STOP uses
> timer_delete(), which does not wait for a callback already running on
> another CPU. Such a callback can reach sctp_sf_t4_timer_expire() after
> the purge and dereference NULL.
>
> Clear addip_last_asconf after releasing the cached chunk, and make
> sctp_sf_t4_timer_expire() consume a stale T4 expiry if no outstanding
> ASCONF remains.
>
> Fixes: a000c01e60e4 ("sctp: stop pending timers and purge queues when pee=
r restart asoc")
> Cc: stable@vger.kernel.org
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Assisted-by: Claude-Code:GLM-5.2
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> ---
> Changes in v3:
> - Resend as a new, independent thread as requested by pv-bot. No code
>   changes.
> - Link to v2:
>   https://lore.kernel.org/netdev/20260808005748.1981039-1-yangyx22@mails.=
tsinghua.edu.cn/
>
> Changes in v2:
> - Guard sctp_sf_t4_timer_expire() against a cleared cached ASCONF pointer=
,
>   as requested by Xin Long.
> - Explain why the T4 callback may run after the restart purge.
>
>  net/sctp/associola.c    | 4 +++-
>  net/sctp/sm_statefuns.c | 6 +++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 5b0ae61..737f8ea 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1713,6 +1713,8 @@ void sctp_asconf_queue_teardown(struct sctp_associa=
tion *asoc)
>         sctp_assoc_free_asconf_queue(asoc);
>
>         /* Free any cached ASCONF chunk. */
> -       if (asoc->addip_last_asconf)
> +       if (asoc->addip_last_asconf) {
>                 sctp_chunk_free(asoc->addip_last_asconf);
> +               asoc->addip_last_asconf =3D NULL;
> +       }
>  }
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 708fa07..3a8e16b 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -6145,8 +6145,12 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
>                                         struct sctp_cmd_seq *commands)
>  {
>         struct sctp_chunk *chunk =3D asoc->addip_last_asconf;
> -       struct sctp_transport *transport =3D chunk->transport;
> +       struct sctp_transport *transport;
> +
> +       if (!chunk)
> +               return SCTP_DISPOSITION_CONSUME;
>
> +       transport =3D chunk->transport;
>         SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);
>
>         /* ADDIP 4.1 B1) Increment the error counters and perform path fa=
ilure
> --
> 2.25.1
>

Acked-by: Xin Long <lucien.xin@gmail.com>

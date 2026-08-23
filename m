Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70E342C9E
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787521335; cv=pass; b=IKtd4OQTJYsae72a8hJqdYrVDwQ3UDAAp7wEb3R2uo/JaQSK4nMEdkRoDGOr/Pcx0R45xttMdnHbgEV5ntC9fWO68z7NVVsu9xyHOYZyi42tKboMSZ2JhF8ljNXbRPAo9pCANl5IIoiaFuESz+cVHBzXj3u+RGp77cdtF01iihw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787521335; c=relaxed/simple;
	bh=UUVZ4QEhiifkU4/PdlgixLKGOpIioQqZ8H2mXpqOKwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDQ4HUyib9mbU761jt66xVMrKtRUvGeCuuHSzoV28HxUUcGr9VGVBb99EVMBX+JnjDjXgXH+Tkc6u7AqSDCv332SuaaBagQp+31Txo70XKpUgd3MSsnYcBqVvKdv/qLChl73W+PUHQ0IdPkgk1UnmOQGbGRbV4Ha2IrrzzFHooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzLDOo66; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzLDOo66"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e507b079dso1622865b3a.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 14:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787521333; cv=none;
        d=google.com; s=arc-20260327;
        b=o/IEcFhfIZnKHUTQRYjt9P6ihnjJeYyz4hx5igrszx0/Z7+5D2aP5GGAtW1x//FqLA
         oj8d9dDkfoP76/mtj1GwzvLFgwUA8FgH3DQRFpOGXdalczAMQwK2H0KUK7Q9iQb8luDK
         wBfa8b8R3/KvTXSWHCOCfpeqqV7RjmYvEarGg4MZVKb9SfN5YmYbeD25rtnHNhJJ1Mjl
         kPLf4PfL7MFphA3dqjbYOXPzmQiJQgQP3Ic/K38AaMHhuNumLanqxs4lbMw08FAfi/TK
         u86ksFpntAhKYVOpVJ1IZHTv+/fTxBFLVRBEUNb5v5usijwiCJVAd8mAjph2plN9kAOP
         1EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MiBiSqEstYsBT9CowHcGMjwsGGy57PEcAXTCZ8mkb0o=;
        fh=qwIqDjkBFNzqIqQRjvCKK4NLpSSC+4wQM4G6+l0H+Hw=;
        b=UwSj+pRytRCoLOnYVNx4TUx/o3EbajLBANUHuTSNYRn9tFnxjiCPtBuA3t0bTcXO4X
         N/WK93AukEcU+Q7HJHs5Mew87P3U0E0DGJmBh9xBy+mcZ1EdqSU+K6XqGRDnut+xi/X9
         hD70jIAWZzak2HpcPSAn1PPcUKdRJrtftPTNtePJlbsVMfjBGOUyjGUpyqnexVqW9BPZ
         x+wS7MnpbaDp44bNHKbreWJZqsqQJUnM3YbbCc0MbOF+oJQOSCz45F6bY0fA88/Ehn3A
         /TjzTQF/YEflApbAV+q/9Mjugri8bgpvKW/vJy/IHLpIQdScC8yVS54qky2uL5Nl6ZeW
         BqHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787521333; x=1788126133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MiBiSqEstYsBT9CowHcGMjwsGGy57PEcAXTCZ8mkb0o=;
        b=TzLDOo66deUWndxnkcuVLsI+dUfFk9AdQgkn3ZayVHlPH3qdWS1WKfextC0SYNn4KY
         jjQ+5b9Na+zcTqZCvfFKLYeBhXTvcn+LKds9FwI1sBpFifvVaOLLaYbqHdOFE0skB7E/
         sHGERnP9gHiMMGlXlQ+4jwtqFFalY7LR2Yr8iv2onnpkFFLxdlHWIqmlg4dIHnJXSI2S
         bYiAiZuKTCyNTxa+kc4ugeeTCB3wxItobDuT7KnUnS6bb/sGg/1RCwsbtx7wEMK2ZOnn
         RgvBgEXE0c83bw+BsH1ZgNYCdS9lWjxpY06nzT369htDVps3oZetrj3eYUtT3jwZRU92
         Bcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787521333; x=1788126133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MiBiSqEstYsBT9CowHcGMjwsGGy57PEcAXTCZ8mkb0o=;
        b=MedVZw2azE7WQ5f7MJ3Yl8PcFjHIALEg3mx1To2hKxc48LlhOiVTDij214zmHXhrZw
         GdEoJ0q1aBonTAjC/prOUNc+8zTt3IsWWiNDDTSqKBVAHOiW/uoekXQAyc9rYZRnmRNn
         H2+f/ZMBfbJrOAOFHx6PvkiH0KYd8QyDrO129rtWookKJN0xTbxFwyiG8OV84PCb++kA
         HQj+egMNBTqpCJ7xBrDGjXltB2WkAJbX4jRT97olEJcSiiJZaC48lcIJNcPoqKpmRCcU
         FDM1OwxEhwUY/MT09MK8GqSa7Orx8FFFaAMvQ7fCWyGGJVVMUVAgUFL7XQH1SgK1BnYN
         zskA==
X-Forwarded-Encrypted: i=1; AHgh+Rqpo2Lep+6GyEmK7WAFmUyseoxRMLvd0Xv6Ll7j+gjaDE690/nBsMcxvM7Zt83tsbyVTc6b+Hc=@vger.kernel.org
X-Gm-Message-State: AFuF++m1BZVgOD7PGUDjBItt7WkCP0pS0kUlES94QiAHK1LZKG4YNF07
	dL9W56D7Dw6OpD3trm0jPusY2ualYe70TXq1Nu7lZ5ZYhsgnE+YgI1RcE7FPuuOZaN3ReDQKfvX
	uxBYHwWIdiMTfBRuynV4KuMtuk2nZjDQ=
X-Gm-Gg: AR+sD1271DWTUF9fAKKTMNzrVPB6fA+fABzO3yPlq2IIR6q0TFbdiyKwosKH3HOFiy2
	R59tHpgvL6ljjTGpXTdcWJY7HLGMYzB2rl4Ifk5BXyXf64w2DKZZZgQ2Wtpimxsd68Nb6XeGFum
	hr6kC120z4UyDaKnKP7i0xy4Orz6NIwP7xVxdAE2RMhHlxP4lGrn6n1G60h6mWogTrwc+IuWacU
	J4opIbv4oJaXa7IhpuDnej6XeEJ149MxgYr6tts/tMHAZ3jt/nvl870VZR/9E1c8aISI9vev6MY
	ZiHpIGjbBH6YDeOiLC+gxdkF/VO0VcqzI2zQmH/iBNGIywW1CfcwjeRxjUW/NgZe7R224sqdlez
	n8/D8jTRO9nVftV1ppVVwUrgcjARAnW02Oq7Gnln1jzU=
X-Received: by 2002:a05:6a00:39a1:b0:847:93f3:a4b6 with SMTP id
 d2e1a72fcca58-851fa0667d8mr33292027b3a.17.1787521333426; Sun, 23 Aug 2026
 14:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823172857.896146-2-bestswngs@gmail.com>
In-Reply-To: <20260823172857.896146-2-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 23 Aug 2026 17:42:01 -0400
X-Gm-Features: AcwNN1XZvnlzQT-i245u9UsXUJjCTtcPxPiiTlaJcAj7ZTFwxNFgd5I0mNBreL8
Message-ID: <CADvbK_c6rqUdxyMSC=XF7ShHbjHSY1d2wEUmYpr0RGO+E0i_Kg@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix NULL deref on untransmitted RECONF completion
To: Weiming Shi <bestswngs@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 1:29=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> sctp_process_strreset_outreq(), sctp_process_strreset_addstrm_out() and
> sctp_process_strreset_resp() complete a pending stream reconfiguration
> request by stopping the reconf timer on the transport it was sent on:
>
>         t =3D asoc->strreset_chunk->transport;
>         if (timer_delete(&t->reconf_timer))
>                 sctp_transport_put(t);
>
> chunk->transport is assigned by __sctp_packet_append_chunk() when the
> chunk is appended to an outbound packet, and sctp_outq_flush_ctrl() arms
> the reconf timer at that same point. A request already published in
> asoc->strreset_chunk but not yet transmitted has neither, so completing
> it dereferences NULL.
>
> Two ways to get there. sctp_send_asconf_del_ip() sets
> asoc->src_out_of_asoc_ok without sending anything when the address being
> removed is the association's last one, and sctp_outq_flush_ctrl() then
> leaves every non-ASCONF control chunk queued; as only
> sctp_process_asconf_ack() clears that flag, it persists. An unprivileged
> process that removes such an address and then asks for a stream reset
> panics the kernel from softirq. A peer needs neither ASCONF nor local
> help: sctp_cmd_interpreter() uncorks the outqueue only once the whole
> packet has been processed, so a reply built while walking a RECONF chunk
> stays untransmitted for the rest of that walk, and one RECONF chunk
> carrying [Incoming SSN Reset Request, Outgoing SSN Reset Request,
> Response] -- or two RECONF chunks in one packet -- reaches the same
> dereference.
>
>   KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
>   RIP: 0010:timer_delete+0x67/0x110
>   Call Trace:
>    <IRQ>
>    sctp_process_strreset_addstrm_out (net/sctp/stream.c:832)
>    sctp_sf_do_reconf (net/sctp/sm_statefuns.c:4212)
>    sctp_do_sm (net/sctp/sm_sideeffect.c:1172)
>    sctp_assoc_bh_rcv (net/sctp/associola.c:1044)
>    sctp_rcv (net/sctp/input.c:243)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    process_backlog (net/core/dev.c:6680)
>    </IRQ>
>
> A response can only acknowledge a request that was actually sent, so do
> not match asoc->strreset_chunk while chunk->transport is NULL. Guarding
> the lookup covers all three completion sites.
>
> Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Ou=
tgoing SSN Reset Request Parameter")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>
> v3:
> - No code change; v2's changelog linked the wrong v1 posting.
>
> v2: https://lore.kernel.org/linux-sctp/20260822172352.63025-3-bestswngs@g=
mail.com/
> v1: https://lore.kernel.org/linux-sctp/20260820162235.2668698-2-bestswngs=
@gmail.com/
>  net/sctp/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 34ffe6c945a4..2012f61e250e 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -488,7 +488,7 @@ static struct sctp_paramhdr *sctp_chunk_lookup_strres=
et_param(
>         struct sctp_reconf_chunk *hdr;
>         union sctp_params param;
>
> -       if (!chunk)
> +       if (!chunk || !chunk->transport)
>                 return NULL;
>
>         hdr =3D (struct sctp_reconf_chunk *)chunk->chunk_hdr;
> --
> 2.55.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

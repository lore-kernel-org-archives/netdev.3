Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793715766;
	b=CrLBsv0gPtSyZokOsgFVzr3B8AnxnAf/Lkypf6AUiUcMvg2FYOKqsT8nr1QMQCEn+J2y
	 5svcqvURBcUW6CLM0K0O72z3t3HAd127dTabtoXmTE4GBDiZ4pUHHVyx16SRxMai/59ze
	 RzzVlqOpndN4r4a8SWA3AbgOT6KyighYMlFwJTKqNNoXWHWDK0pTO0Ge3RqkUL/33xiiu
	 /kKu/TzwaZTGYGtn0YvmuEhALBlxZmNACYzmNWlphNDKtAUGTYmqRT+6xKX3t2Mqih4YL
	 82SV+ca0L323ZhYTNTNi+DTOPjJqSPTrMzPVXS7pYCOM+++pUZL78f2l2DOWPqGVeNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=goUEmUyHzHRn/JAgbYWl2i7yvd0k17zq6RZVq6dJndA=;
	b=nPgrqRU9A6ncaBFQNb03gX4fhEcGasY5jwLBq7HYDbZ2V00ZuZNJkfv/G2lF46rESVgq
	 X/0fuWqWPDsxjyN5iXHjrpuD5NMq1Z7VKNhibNMGjYipIcim59/7ycNRRnZ1+vAj9Yr95
	 cvEphVzgQc6TXVN504qKvY1CQQtHflvIWOTRDlCeSKbrdt3Clkg8Kz6mXuhyVLaZ+Ufa5
	 scnl7x6OFwR+vbMpncmHf+aEeFVXsXm0QLzXuslm93NY1s+eMD5qAAaUK6O/TsnjgWCd5
	 o6I3FFPfYebVCTI5D2sqJetthuDyxAQgvr1LwlR3Z2Vv9hYfJmGcJJ8YLkETMvjq9Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jhkisa2S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB72606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB72606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jhkisa2S
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1697650a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793715765; cv=none;
        d=google.com; s=arc-20260327;
        b=LpBiuuvK0iEQULP40BSPasTz7bRgelvioBVZuDxUtN0UlXtQRLx0KakKW8vnYv2CIH
         RzIZZ9/ymmV+xybIjE5vNP4+N4Vbb5kt35sbTpA6KGsSTIu6UPtQk3Z3Qo8OM91YfBiq
         fiLj0eAdQERkewZ86hnvu2h3zwKenLcMalWPKUPw4JkWZ04/RG7EL9jn6oQlI4M7E3zj
         lJiNeZxsSTy5hy9un96Nq4EdGk0y5iqNJKdm8dss5TNJJJMakXONiOnwJxofoBGA22Gy
         udyIsMBGObml/gmFr2MdYKGt32M27SE2vL/tijMKV1vGPMHNaEyXRwt8Pr5l0E2RGWgH
         QgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goUEmUyHzHRn/JAgbYWl2i7yvd0k17zq6RZVq6dJndA=;
        fh=ybSHhKyUGTpz5z1vpJjlPW5lfzgR1bAh+Z2a7r0KBDc=;
        b=QOJ29Js9F4md4uvmntTFdxMBoNjj0CM5PdoRSmxw6CIwz+eMjhPjx2t7Hdgt7MDASC
         Lc9zf+BOxl844fDkVGzezm71hA+IHRY7zwPTL7bEQRBY6TPqz75973wdrLMrsfvxyQY/
         1Aqwj66QU3/R4mAs3X7j0CCM0R95xWzdHUb8TVKI44lHU2RheOSCMPHfHNdSOG8jFrMX
         +pb9sHAy1U2aiJNzDAPWF0x58iShMFH40hLY3zwXtafnIoU5Az+h6+pbJcGqr+HkjV6o
         dbRmfZUYJUPzNtEeKE9+5AsPGV30VbN/7evYnJuzM+M7aeicQfwvK+i40d2nM7/Qo75v
         yMaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793715765; x=1794320565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goUEmUyHzHRn/JAgbYWl2i7yvd0k17zq6RZVq6dJndA=;
        b=Jhkisa2S2vXFBSNqqCyZnrR6JpuM5BBpw/U1ykOmBCVbHHAGBHiG59udh4q4ocSZzT
         B+VLP21mZOHIS1JiMcrm4hn1l7sTaZeW36g+3nwf+SorUXmrDWEMCYf+9/iaAtGkWP2Z
         jvIaLLuZeQ4HOU+rRp31Qy0Y1c0Y++wgaT0ywmdFgHf/MWUk0f+ANbMLe19dXKYipBm3
         DqkuIdu20GgR3QdxoXR+SnZkJh1tFg0zTOIXILFVjTGAuUeaaF6fXdUsYCZwgoWvaGzk
         AFufwdIM3Ds11CGHgak7opO6f4y9wacjoIffPeNer/sXD3iDcQGEv82oJ75qb5JfHozX
         bmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715765; x=1794320565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goUEmUyHzHRn/JAgbYWl2i7yvd0k17zq6RZVq6dJndA=;
        b=yw0yNzq00HL4sdTsbp31LdL2yFb8fxlxUXuGmDteK5W+mZsa080+oU7m0Kj11sq+1U
         fRT/zPgJtJa+4FpB+Ii+wrtojos2KFNtxkltAuMd9md8rIg+NiMi8s079NCOYvdpjg7O
         ZGmhkYlgtTrsYeM8JadUXFgbh3Dm/tvQ/k3yzAeXSQVF8jSgFt8TuU2E5s5+AVKw8II7
         3Bc5U00nk4iFFFerzb66KBYTExQWiyPOgimoQJarMC/nCYWUZxA4wG2dyT19Ib7LwORt
         kB8ER5JxuuEGn5Apzhr2hqJ4C+3SbDjYZy7GF+gdzyC6Ho+G8D/N+CbOO8QzqBlVStib
         /6lA==
X-Forwarded-Encrypted: i=1; AKwUvBxdafduBtLEOVaMM3onm/b60o8E6KjQuh8dDLn0x9l21k58W1qzTkD2c60ZwhXMRDIQUBrkrzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kRfhO2DfXUDeog0Drh/X9rqhSPIfCaDplQPLKBa2JfvU3vdIQ
	PMgnr12D75OqVZOqjHOE5yCTJVMRmpfDBTj+AzfG2+7+q5C4pLqkAt3jxJvPMyibK6vQBMnwsr1
	oiwwCU8uP2CEnkCNWUEHuJG1zyEyAo/2Eq8e6
X-Gm-Gg: AYBFou3FlcIlauTg3FExuY3LJvujePhxP22qDzbBEuIOItHNDqP84yWZ8GtnDwpf9+O
	8yUITuBK7NZn5Hh1XrEU3ZCXm/rcuSii+rgvrWKHcgsW8dPeL9DpSNZ8PI4rz5/RvQFXEibHCkO
	aowp1b2voOBw1MvJgg01C4ZkOD5WvV9i+IGq5ZO9ba8WsK0mzgkgCDg+L9LfFrgSpx4Pte0Sc01
	zhwAzv5kRHtul1H4UypVPFBf5Wv5DK7kJD7xNfTd0UoGDBta4wHpV93Q4k0tW2+az9CDw5CP2mH
	4Y42y8abTjb3fV0ymUqWuiJAblXhkxjgbRw2lkh/xNnmwCrHGhqM1BXF+kUXki3BgjlGSNPkSy8
	lbtsVgc1mD5EphoEGDtBSUsnDRrJJ4vTOwm1Wua0ObUynNKsaGptkJhufrxgqhcOWo1YxcPV77c
	GlPOQ212nuXwj3f/FUP4ET4GE9cdKMd8tUWq240A==
X-Received: by 2002:a05:6a21:3f90:b0:3e1:d119:ee35 with SMTP id
 adf61e73a8af0-3e928d40e11mr9916793637.12.1793715764802; Tue, 03 Nov 2026
 06:22:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030042321.74407-1-kylebot@openai.com>
In-Reply-To: <20261030042321.74407-1-kylebot@openai.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 3 Nov 2026 09:22:33 -0500
X-Gm-Features: AclHuK9rygcKHlFq8M3zeAsoFHUWP0OF3Dg8S91AWQVg--msS91soOe9ITJpZK0
Message-ID: <CADvbK_fwt6s14a0yJjRa5whAT-H+7RtaDXi4cR0-XmrvoJkeQg@mail.gmail.com>
Subject: Re: [PATCH] sctp: avoid requeueing pending control chunks
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 12:23=E2=80=AFAM Kyle Zeng <kylebot@openai.com> wro=
te:
>
> The T4 and RE-CONFIG timeout handlers take a reference to their cached
> control chunk and submit it through SCTP_CMD_REPLY. A previous transmissi=
on
> can still be on the control outqueue when output is corked or suppressed,
> or when sctp_packet_transmit_chunk() could not append the chunk.
>
> sctp_outq_tail() then adds the same list node a second time. In particula=
r,
> re-adding a non-tail entry can corrupt the list without being caught by
> the insertion-time list checks. A subsequent flush or association teardow=
n
> can walk the corrupted list and access an already freed chunk. The T4 pat=
h
> is reproducible by an unprivileged SCTP socket owner in a user/network
> namespace, with KASAN reporting a use-after-free in __sctp_outq_teardown(=
).
>
> Check sctp_chunk_pending() before adding a control chunk to the outqueue.
> If it is already linked, release the extra reference supplied for this
> enqueue and leave the existing queue entry in place. Continue to the usua=
l
> flush so that the pending transmission can be retried.
>
> This also covers RE-CONFIG retransmission after sctp_assoc_rm_peer() move=
s
> the request to another transport and starts its timer. Keep the existing
> timer handling, corking rules and data-chunk path unchanged.
>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Please add a "Fixes: " tag for this patch.

> ---
> I have a reproducer for this issue and can share via DM
>
>  net/sctp/outqueue.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index e92fb9da4647..a5f9f0fcf5fd 100644
> --- a/net/sctp/outqueue.c
> +++ b/net/sctp/outqueue.c
> @@ -304,6 +304,11 @@ void sctp_outq_tail(struct sctp_outq *q, struct sctp=
_chunk *chunk, gfp_t gfp)
>                         SCTP_INC_STATS(net, SCTP_MIB_OUTUNORDERCHUNKS);
>                 else
>                         SCTP_INC_STATS(net, SCTP_MIB_OUTORDERCHUNKS);
> +       } else if (sctp_chunk_pending(chunk)) {
> +               /* A retransmitted control chunk may still be queued.
> +                * Drop the extra reference and retry the flush below.
> +                */
> +               sctp_chunk_free(chunk);
>         } else {
>                 list_add_tail(&chunk->list, &q->control_chunk_list);
>                 SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
>
Can you try to fix it by not sending it in sctp_sf_t4_timer_expire() and
sctp_sf_send_reconf(), instead of touching the common path? like:

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 8dc65498763c..7671bb0ce946 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1122,9 +1122,11 @@ enum sctp_disposition
sctp_sf_send_reconf(struct net *net,
                return SCTP_DISPOSITION_DELETE_TCB;
        }

-       sctp_chunk_hold(asoc->strreset_chunk);
-       sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
-                       SCTP_CHUNK(asoc->strreset_chunk));
+       if (!sctp_chunk_pending(asoc->strreset_chunk)) {
+               sctp_chunk_hold(asoc->strreset_chunk);
+               sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
+                               SCTP_CHUNK(asoc->strreset_chunk));
+       }
        sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE, SCTP_TRANSPORT(transport=
));

        return SCTP_DISPOSITION_CONSUME;
@@ -6197,9 +6199,11 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
         * chunk, it MUST be the same (including its serial number) as the =
last
         * ASCONF sent.
         */
-       sctp_chunk_hold(asoc->addip_last_asconf);
-       sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
-                       SCTP_CHUNK(asoc->addip_last_asconf));
+       if (!sctp_chunk_pending(asoc->addip_last_asconf)) {
+               sctp_chunk_hold(asoc->addip_last_asconf);
+               sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
+                               SCTP_CHUNK(asoc->addip_last_asconf));
+       }

Thanks.

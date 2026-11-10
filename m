Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324164;
	b=s8RXcnhnmKhR9htxkpZTs4V87oV/H1aJNJsJlQ1/NB/mQwQhiwdRtOuoEGCzxjo/lr8o
	 Lp7BH6BQC3lAC0k7uVwaFwWOoGCILuFYJlDLtrpQtDWNqOnCKy0ihOo/XYan9A2DYx+yV
	 +BCQ70avJY7TvVccn8Db6FsO7Fd/jL9vVyQrqZRty3hX5Mb+yAE+AOIdd7FaPgdYSPgQH
	 v/Hl3hDtcJ0SUaRnygfvU/NECk9FLASMELCZNquipDwI3utCTnx93w5Pfg2EEB2n8vYvq
	 Ia3LaJSM5JhEQsJ6GrzYQwU7GuM+/3fWeAdPJFZaEH2Lw9rtclaR0XenpzLTa/jrHCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CJiQL5sKqyZVeUNg8rOn7a2I+JT7y6AYk1VYUPMSMjA=;
	b=NODPY2q7utNuRsfhD5bM9+l4pClunoSfsUjK/6jpqN9/s2gld69Y2RQ2wqU9k8veUOUL
	 THyY4gUyqz8z3fMo8Zj/XgnvVScONZbMHj1JaIL+MqHRwAI6DOke/J4B8KZM0bxj4ZC8q
	 PLrEy4S+y0D/JPr7q//kwXbQj2DJLbOyq2X+kjXtV5d6FfVLZD5n5Pe8etofbBOuuTCTO
	 g02U7N9/Z2Pjwj5fGoyVx+Br0N3oTx8NCNbXiodWcTYgeEgYi7GURsz0uGwBQXuXd4QFO
	 osEK9ZBa71ecSqrWDuN3ImdVQJpgZRPYG//BMVUgZFOZ3ekLYMdOGBfKsVgYjmSBTRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpPk5dhh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE5606A339
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DE5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vpPk5dhh
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc81984fceso785736137.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:22:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794324163; cv=none;
        d=google.com; s=arc-20260327;
        b=rfLmQgO0SP/oPi2BYdjjehn3Ds0UoQSF665GQ1uveOrOysWYhiRHBRpG3DjsS3wLcS
         ga8tLLpGy3wZcXEJu75qIyEQGS6CNkwIKEuWzFNpItT6x6YTADA+8qwt0YOTXy0eD3Bn
         edHdtdY5/kDEHC3kUyEekELTsYyDFEeFLYJh3Za/quyLzlh2hakfdi2lFfoLGui5N+CO
         UPgCtE7+nrFPeBymqOcyrirxuJSuD3tMypHc5kEmCARHFALJOW/qROsun55hStPJ1y4U
         GFftrrB2tTbcVW8UIjq/5ew2Ueem51cEVXqrXCmsC5QRTSr6Dn5N6LXuj+dHTttAgP0r
         +4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CJiQL5sKqyZVeUNg8rOn7a2I+JT7y6AYk1VYUPMSMjA=;
        fh=OMV+oUVzMlzCLEhZv2c710+TxY19g0/JYOUX0L6JqeY=;
        b=fK/E8YEUXyrMHa+rFh6xym0df/AuU0h40g2SYgLwBA0GLm1xauBCB9XDhW9W9t3eNk
         kOH2HP/2Y/N7xU+LonpYHQkwtuqeyMxE6bLyos4fxMJaNJhcbH1BUeRkoEJ7kTos3IuL
         cmBPx54E8ef/wjr5JjlDCXa2YIpDpRWsOlVLpThEmPImWxkaATfAjHyjQOpmQvtXxAit
         nOYlobhZT2h4DpL2wZSmX0fuMf+lOGoYb+lGlm81YlKnENEgcoh6JuVtl7gIIbn1NIVP
         MTSu9czkgr2aLnnvvKIfX5qHmtTWRvSdJe+Et7h+IWL4QJ3UsY1rRZadNjOqbTTS7kZ5
         RUmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324163; x=1794928963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJiQL5sKqyZVeUNg8rOn7a2I+JT7y6AYk1VYUPMSMjA=;
        b=vpPk5dhhI/RU6k/kmNTxujQ8ynYzj/ulpvfjhDI8C4HfIDgv9TpbrH9qB2B6IhOLhb
         XnJC6w49DVW62pNYEsgW+CICmDNSLQ89K7ocLHaXQIcQzxN1VuNR61e/wfH+r47HD72j
         9fNs4c80+R+6KUQ6lIaIRzSsljX9OoaRPiH883FIRRx9gNJBx6X3oOLDGIuvEd0U7eYr
         Lx5ztZC7X31XPNfaVZMaUTc5gtFrUhu4cotfxnYYjbutuy1VOnRacmaslrgMI87MSrZ7
         2XxwoFiZn3HHv1AED277aqYeuIFlkEX/tI3JV3g81UDiqIDlmo/b9wXlbqAvCiqjgm3b
         VXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324163; x=1794928963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJiQL5sKqyZVeUNg8rOn7a2I+JT7y6AYk1VYUPMSMjA=;
        b=EH/p8m5NPW73TDXDRgIYhmPm0IxYb+bkyhBeQQAkhaj+4MBdKGhPPhTYeWM1AeF0EU
         gAux7CjsqVM1KHqWXYO+syshqnjoMK688PjSd4SX+ltNf2C8EqWbZpXg/ROJLqzDB+0S
         hfWMeUHWmmiSTxA9hXINA1Y9NIdRET1SkOwWqlgsAw14SOnqdMo8Jla0y4ymED7DQ2TN
         Rnq7w55ILp7qkRG3WWPXXtPXdDGq3wRn3LVAWTundNGzF5fDj3gPhPkB7JuDV+zYS1I3
         17lE7gAPYp1BHPnPPAVoP0OS8vrddtUhAX/jWS3AlPpips2hz0qQCCXpO032DUjNwyHB
         b3NA==
X-Forwarded-Encrypted: i=1; AL+hErGzJWGN8mm0RWtYgkc2sTKDndNIfj1jnsCbcxF1s1NmUIgrPm05+fVzJnxfXDGjnsv8TrRD/KU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BVNJJEafSnFnurfe7QTbwC87Fkc5Ht7knzLmJKciStxH+Akma
	vHDFcNrceq/RMfXz0Esew3Rtd1yHl8GIjVWD+fHb6Jt5aadKRaoDt0QsnH9bzuefwTNUzPu1Xap
	zpOuboRbYByxaZ3YfyJutd2kEmx7a9Dc=
X-Gm-Gg: AYBFou1Bqr2GTXUdfgROJpuAO2D36Ouf7lnrhfKad6DUUZV8uWnQ8qis6W89y9tcun2
	2dA1F2Etw1PhpaCzl04Gq/pgk+Z+mK1q5lqFJVGJJMoG5j3zG0WYykL5zBzBUdeL0XlvFztB/6/
	sxSoDH8qeNlS91D/oqjj4NiMFekSA/JHMw6BTno1In2ftznYbYaTeAhQu00maGJBrKFMEYy6oAZ
	pR4eUqQu82Ozvv9b3UPuJwhDuOHVu0zL4O2aYWueM2BqWbgyA2zRYtJ7JayiJP+tE5wZ05A8+tE
	8Ss/jaD9S1P6hD+crbBJNDBGILeUqFBBoTpPmkk0fPd5XsH3wIsK3Mf+kBjgiyq5eeMKe40tUXr
	yqSackbI4ysDcOBTAt2NqX4GMZQfEpzO1Hk2lLZopeBGDOhdTbilSRc0KfcOtJsnFOkK7/CaH94
	MoFNhxDxKwXQMMwLZa9UYb0HCuEN3ZoX2+73c1AA==
X-Received: by 2002:a05:6102:5087:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d301bc9d82mr797847137.14.1794324163139; Tue, 10 Nov 2026
 07:22:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107030532.32310-1-kylebot@openai.com>
In-Reply-To: <20261107030532.32310-1-kylebot@openai.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 10:22:30 -0500
X-Gm-Features: AclHuK_as0CyVKCysZAXlMmcRhg8HgWxQZlIW2p68ZFwPAUogqt6LAxG2x9OdwQ
Message-ID: <CADvbK_eK=sgA5Yvm9fpFjmREg61Aof5ci6J_zFNp0wbQHJiLzA@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: avoid requeueing pending control chunks
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:05=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> The T4 and RE-CONFIG timeout handlers take a reference to their cached
> control chunk and submit it through SCTP_CMD_REPLY. A previous
> transmission can still be on the control outqueue when output is corked
> or suppressed, or when sctp_packet_transmit_chunk() could not append the
> chunk.
>
> sctp_outq_tail() then adds the same list node a second time. Re-adding a
> non-tail entry can corrupt the list without being caught by the
> insertion-time list checks. A subsequent flush or association teardown
> can access an already freed chunk. The ASCONF path is reproducible by an
> unprivileged SCTP socket owner in a user/network namespace, with KASAN
> reporting a use-after-free in __sctp_outq_teardown().
>
> Check sctp_chunk_pending() in both timeout handlers before taking the
> extra reference and issuing SCTP_CMD_REPLY. If the chunk is already
> linked, leave the existing entry for normal output processing. Keep
> the remaining timer and error-handling commands unchanged. This also
> covers RE-CONFIG retransmission after sctp_assoc_rm_peer() moves the
> request to another transport and starts its timer.
>
> The issue was found by an LLM.
>
> Fixes: 2e3216cd54b1 ("sctp: Follow security requirement of responding wit=
h 1 packet")
> Fixes: 7b9438de0cd4 ("sctp: add stream reconf timer")
> Cc: stable@kernel.org
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> v1: https://lore.kernel.org/netdev/20261030042321.74407-1-kylebot@openai.=
com/
> v2: Move the pending checks into the T4 and RE-CONFIG timeout handlers.
> v3: Drop OUTQ_FLUSH and use the two pending checks as suggested. Leave
> already-queued chunks for normal output processing.
>
> I have a reproducer for this issue and can share by DM.
>
>  net/sctp/sm_statefuns.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index b2f609f177fb..64519fd8f943 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -1122,9 +1122,11 @@ enum sctp_disposition sctp_sf_send_reconf(struct n=
et *net,
>                 return SCTP_DISPOSITION_DELETE_TCB;
>         }
>
> -       sctp_chunk_hold(asoc->strreset_chunk);
> -       sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> -                       SCTP_CHUNK(asoc->strreset_chunk));
> +       if (!sctp_chunk_pending(asoc->strreset_chunk)) {
> +               sctp_chunk_hold(asoc->strreset_chunk);
> +               sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> +                               SCTP_CHUNK(asoc->strreset_chunk));
> +       }
>         sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE, SCTP_TRANSPORT(transpo=
rt));
>
>         return SCTP_DISPOSITION_CONSUME;
> @@ -6197,9 +6199,11 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
>          * chunk, it MUST be the same (including its serial number) as th=
e last
>          * ASCONF sent.
>          */
> -       sctp_chunk_hold(asoc->addip_last_asconf);
> -       sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> -                       SCTP_CHUNK(asoc->addip_last_asconf));
> +       if (!sctp_chunk_pending(asoc->addip_last_asconf)) {
> +               sctp_chunk_hold(asoc->addip_last_asconf);
> +               sctp_add_cmd_sf(commands, SCTP_CMD_REPLY,
> +                               SCTP_CHUNK(asoc->addip_last_asconf));
> +       }
>
>         /* ADDIP 4.1 B5) Restart the T-4 RTO timer. Note that if a differ=
ent
>          * destination is selected, then the RTO used will be that of the=
 new
>
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> --
> 2.55.0.openai.911.g06873a30d2f3
>

Acked-by: Xin Long <lucien.xin@gmail.com>

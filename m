Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911038DC7F
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340056; cv=pass; b=ZeHc25AHuLZrxVMue+sJeSeVQzj6ZRkpMR/IoWt7uLPnQ7frPFFK2VlCDhrVIkw3G7Xac3IuQSTLALzP90mxVhqnr+xW3qDXedJV7eJoBgWViGPKsolXjZQA0zk5WmcJ/HbxNvrON3vdUvMowJe6EmMPKK5U5BRsnt0PcBbBA9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340056; c=relaxed/simple;
	bh=mgGDW7odZQJtTZPmsadDeUWjf7CLsPvSwU4pVoMogJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwHU4ybbKgSYgi4A3ItZMDOyZFL0Lf9u2BQIXsrce4b1QuU8JJxc0jliqJihhNkaakACLpxTGC5xEYtqpjR7/zVcGi9aLN/HvI+HZ8OH1v4++xQQyeAAvZrF4X10RbmJ8VP/ElgnmVdOpjxaJg0TUguw3zzu0x8SjjDzG0o2CEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFdG+0mv; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFdG+0mv"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9725084c547so608008241.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785340053; cv=none;
        d=google.com; s=arc-20260327;
        b=Lg+cKRhY13frg62XQ/CRDzz3ANRI8WRjdsklqxXxMeJjcML/FBsWwaGia3whdF+X0I
         nq1ENnEW1aZIFnNrjuyprxr1FK8FTfIwmzZI8u81AOrIQETrn7X9elbzr2vhmLkAs907
         oOUQ7DRvURqfXjA12gdcMzO/i4knSOLfTjCqYiaDnr08P3NGvt6bPp9dRZJJHvQq1dNi
         sZfHBNcN9Ooh1QbVhCNImop1suLwtf1Yqd9f9QrTXOpIbvqfPst57tcjI2veM2VzX2rx
         3eB1XDD/6+UvXKVCpn5fnFsFFMEm3YEuLIma0B44Ksv/Qr/XkVe91WV6PR5kg/VBhXyD
         q3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPm1Zkyu3BaX1h8XC4TjYemj4kfTSOFBWz8obT4dB9k=;
        fh=ygEkiqqxlxo1JI2Jldj29rFfS7cMo/FABL2jpS7C4+4=;
        b=I/PjtEw/worGUQ0IGlzomXHRyZEWh7XdarThuWEgnKzum9Pxq4Osjq2dhOjNWuNMIW
         ywM2o3Kn8o1otaMhZlIqCv0QfzjbVfQLDdCcjUjfXtBQ6wyJdCBu05Fk6ri0R5CVH8e2
         Hwz6wRSK25vNKrhKP3PRo3eC3MuqUFAqamJervN2b65xjXNSzhfksRn/PCnL92lJAuDJ
         XfayChtiBnRf6k/8kSSspqhMUDKyJ7NLaPiRao/HbaNiypBwLrLGhUX2yd80LkEmw+FX
         RfTXs4mTzzzsUTWwz75g1EFaNVSNM4OZGjVA9bJswBQ1Gp0sB6tV2kb90sb1uzWCZUed
         w5Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785340053; x=1785944853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPm1Zkyu3BaX1h8XC4TjYemj4kfTSOFBWz8obT4dB9k=;
        b=kFdG+0mvD9EcLXxllv4ahYIH+C+fdXF6/i2UbccqNWiIkDQcxITIoalcJqczDUl2W1
         5WIhowg2UA2mJvM7BQRZit2SuGAVRosT4Wb/OKm8COE9w+/NSHmYo0vn4RMiewKKjDyo
         TyWNrLt2Dx6/e6/M10T4GAUNZCdIZ0Bvnh84+u6Fts4iGz7dtBKOFSE7qFK4aKLGdWDf
         nyDU6Utmn4FaEBmxVzggZmoYUBjLbgOVoz9WwERUib+soQvnNV3WbPI7eHCUuX/a1uOG
         ui72zNlX7pvMAbxQvd/hLa3Hm6p3vAm69cKRohFWpfnFHYbIN8EEh0U5I35n2wRvQzcd
         1Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340053; x=1785944853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPm1Zkyu3BaX1h8XC4TjYemj4kfTSOFBWz8obT4dB9k=;
        b=L07InWHl3udWra77bhNz5mM491hYQkOfQdhnnomos0fEQyTk0ZMqSVFWTaIgPa3X+O
         I+D0XVJUu7BTOR1RCyyi0Cozn+VcRGSGVFte3o7s5zF11xdh3YJBRTi9cS7HCKD8Rh7z
         4jm7G36BtYMVKHJu/ZBpYA/mWBhrf5o8dY/FvGYlZ5zuoiRBGFteN7AICAOJKxSa6WUL
         OJlYbZZMoJp2XKxPqT266TB1Z9LVjx5cxvAunbwhlj9PIXwkYZrHC3P4zzOpBoSGVzAv
         zLK7ptai0HHYGwfdzxZgk/G8VMUOqAL5WtW1VPW7Wb7NuvbDy/Q4fP1x9osZL1PdrNAo
         mdGA==
X-Gm-Message-State: AOJu0YxFMrYPZIzHpQN4XvD+7CR5PlNc2/Gt8yQvUBG2wcomSEEjHuvf
	MtDL2EKtsuoqZk60bbDCWRfRsLz9fwITobVYGDUaZMC98jwA4tUFYpGRAcSxqhulKR5QnJGJPrt
	S0CsSdTygW/T9LgxYkUyaUGrG1w3UPOc=
X-Gm-Gg: AR+sD136jaV/n+gIgly/IIH2Jhapfgnsv2vE3kcY/8VsTuXUAEo4bvwZJkTXwmbN7FC
	HHAb+3NNAeuh3/hlhqzESfE31L42M95xDzWMhNewRh08eP2krBB4zSvfFXx9Aj+jT8z9pVKt55E
	6GA6R8ErbAIP+fpiCM87S1kghzLT+NfwPzbWC2c05NI9aomuDjiMn7m0er5S0ULmGpJQxociHlx
	aAW4GpfWcH7YHXCdekwIwN3jT0Md8edwZsP+7Jxk8DDSzm6fz8yVLkxWjUHKctwqRXvIf8QUUJ/
	Gzwf/YKgwZ1yyTxEgYZ7/JJtHwbTMLtoxIklLMAvXpoUeFtdNgyP2RwgdHPy6mrC2IXbS5SxVYR
	h/jwJ3THjHERrLlqFP4aPxW05/E0oiSSBQAL3a+MZU8E=
X-Received: by 2002:a05:6102:512c:b0:722:826e:1423 with SMTP id
 ada2fe7eead31-754a23c05ffmr3550572137.20.1785340053326; Wed, 29 Jul 2026
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726060453.42730-1-baul.lee@xbow.com> <20260729124929.5885-1-baul.lee@xbow.com>
In-Reply-To: <20260729124929.5885-1-baul.lee@xbow.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Jul 2026 11:47:20 -0400
X-Gm-Features: AUfX_mz9nZndAK9KdmKF1YI91jpaV8MXnQ4Zg4xcsY1aSJ5xem0vHknyrBE68Uk
Message-ID: <CADvbK_cv4CAqN4sX-M0onYZjCeF03==vpkgt6AfvohFn8qvLnA@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: keep chunk->transport in step with the list
 it is queued on
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:49=E2=80=AFAM Baul Lee <baul.lee@xbow.com> wrote:
>
> __sctp_outq_flush_rtx() moves a chunk onto transport->transmitted in two
> places but only one of them leaves chunk->transport describing where the
> chunk actually is.  The ordinary resend path is consistent because
> sctp_packet_append_chunk() rebinds the chunk in
> __sctp_packet_append_chunk():
>
>         list_add_tail(&chunk->list, &packet->chunk_list);
>         packet->size +=3D chunk_len;
>         chunk->transport =3D packet->transport;
>
> The gap-acked path has no such rebind.  It parks the chunk on another
> transport's transmitted list and leaves the stale back-pointer alone:
>
>         if (chunk->tsn_gap_acked) {
>                 list_move_tail(&chunk->transmitted_list,
>                                &transport->transmitted);
>                 continue;
>         }
>
> So a chunk can sit on a live transport's transmitted list while
> chunk->transport still names a different transport.  If that transport is
> then removed - sctp_assoc_rm_peer() from an ASCONF Delete-IP - the last
> reference goes away and sctp_transport_free() RCU-frees it, leaving the
> chunk with a dangling pointer.  sctp_assoc_rm_peer() scrubs the
> back-pointer on peer->transmitted and on asoc->outqueue.out_chunk_list,
> but this chunk is on neither.
>
> While tsn_gap_acked stays set the dangling pointer is not followed, since
> sctp_check_transmitted() skips the flight accounting for gap-acked chunks=
.
> A later SACK that reneges on the TSN clears the flag, and the next SACK
> then reaches
>
>         tchunk->transport->flight_size -=3D sctp_data_size(tchunk);
>
> a read-modify-write inside the freed sctp_transport.  KASAN reports a
> slab-use-after-free read of 4 bytes at offset 216 of a freed kmalloc-1k
> sctp_transport in sctp_check_transmitted(), freed from
> sctp_assoc_rm_peer() via sctp_process_asconf().  The removal and the
> faulting SACKs all come from the association peer, so an application that
> speaks SCTP and accepts multihoming is enough to reach it.
>
> Assign chunk->transport after both list_move_tail() calls, so the
> back-pointer always matches the list the chunk is queued on.  Doing it on
> the ordinary path too keeps the invariant local to the move instead of
> resting on a rebind that happens later and only if the chunk is appended =
to
> a packet.  Fixing it here rather than by scrubbing more lists in
> sctp_assoc_rm_peer() covers the chunks that were already migrated before
> the transport went away, which a scrub at removal time cannot see.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> [Reported privately to the maintainers on 2026-07-10 with root-cause
> analysis, a PoC, a KASAN log and a fix; posting to the list was requested
> as the follow-up.]
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
> v2:
>  - fix the root cause in __sctp_outq_flush_rtx() instead of clearing the
>    back-pointer for the retransmit queue in sctp_assoc_rm_peer().  The v1
>    scrub could not see chunks that had already been migrated onto another
>    transport's transmitted list before the removal, which is the case the
>    reviews on v1 asked about
>  - correct the Fixes tag: the inconsistency is as old as the code, not
>    introduced by df132eff4638
>
> Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.le=
e@xbow.com/
>
>  net/sctp/outqueue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
> index f6b8c13da..1b2d08f2e 100644
> --- a/net/sctp/outqueue.c
> +++ b/net/sctp/outqueue.c
> @@ -650,6 +650,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q,=
 struct sctp_packet *pkt,
>                 if (chunk->tsn_gap_acked) {
>                         list_move_tail(&chunk->transmitted_list,
>                                        &transport->transmitted);
> +                       chunk->transport =3D transport;
>                         continue;
>                 }
>
> @@ -715,6 +716,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q,=
 struct sctp_packet *pkt,
>                          */
>                         list_move_tail(&chunk->transmitted_list,
>                                        &transport->transmitted);
> +                       chunk->transport =3D transport;
>
This one seems redundant on the default/SCTP_XMIT_OK path, as it's
already set by:

  chunk->transport =3D packet->transport;

in __sctp_packet_append_chunk().

Could you please remove the second one? (Sorry for not noticing this on v1)

Thanks.

>                         /* Mark the chunk as ineligible for fast retransm=
it
>                          * after it is retransmitted.
> --
> 2.53.0
>

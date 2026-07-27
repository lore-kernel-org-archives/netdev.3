Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B9435A92
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174162; cv=pass; b=LjUqkv4eWoBbCw/MpnK0kKLbIbmqmabfSbsvN8JOYfqJY6r9Y0KPJjtZrzLMRb5jTwxr5rBkxeRKooWnwVe7ihpddXruN2vNm41PfaKv8BaqHj6UHQFqLo+K1T+F48q4986vkvWzMnVQ9qGVemnmYVh8AbY1T0zY7Ld+HqI76Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174162; c=relaxed/simple;
	bh=fmw3ZK1Zy8eC2d3FwnmI6CzZ0BTv5CWLe3Aey1QFDTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuPtpIoN1ep8KJCJJejHGOp8kiVcc0tZiaXNESV9z2fwUBrGZ6kEIVOdjPF8u+TE14g0M2LhDh6ENoIelosqi4Gj2SizQGKb9xGXDoKxo8NUwJU51kPOcViXNE5z3186ri1erI8eTVQ8m0lh3E7pdC1nbuo9kdrCR5ps4Y8G+EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7Z/KXl; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7Z/KXl"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so3064745b3a.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174158; cv=none;
        d=google.com; s=arc-20260327;
        b=s4Ty8FPCSqXIcL5qpX3bytqV3HEonc+I4rsx9N1l1LJ/K9loo/BLLpQi8zPF/UNW7Y
         szBctkb2mBC3uWUskXijzwMIBh8e1/bKnqehvuoJQ7B45a7sKS8XXapO/s58foaL+RFE
         eedOZrvnWV13XskN/WEI21oBsdSRWB8R/DN0qoyud0w4zPL/Fds32I9feIZDaZ9iYjGM
         G/0xSN87s3yE/henXiB+NkHlk9kQjWm0kWCRjNKbM/eq48Cq32S7MahK6A02bCt9fInf
         NIwBI70DwECxkAbrmGKGd054jGZe1cvohZ5u04f08hAsUN/INOTHkPIMAh/M5fZ823BZ
         xqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QobJDhQM3EFzE5CfaULEs1c9Xyh8eT+RN0WimZuC2ok=;
        fh=DApqJpJOYzXHhrslWU/3GFq7dijYP50YjiNEef4F5cQ=;
        b=UPPG6PanjAuhWp+jNpd+K0nsKgpVWS8hY4eM5XyCCSd8dwfwEX8Rfy4cS94tAjH0Z6
         kNbAyn7C42qLEM7eiSdOhQSf0OFoDW362deWEJJAPJb72o1MyeXgQ/Ch8Q5hQSTkJy4D
         kOKEJAyn0q8Rj0vxSoTmX7Y7hvtkwGUwYo2GjKF4WU14CLLaRBNu8/MxW1OaYOh2dPWa
         p95PnNgm4o+alkU50deLRpR0JLlwX34Ux97vl9vgjpvHOyyjaQM7HdEjeCgSTs4Cp1TH
         A3WhhlabV08pjmlj1KyYe3hvmA1pG5OmpxfZOBR5h6whaCu0Hbz3K+ruqP/ekkc+gk2z
         Lk4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785174158; x=1785778958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QobJDhQM3EFzE5CfaULEs1c9Xyh8eT+RN0WimZuC2ok=;
        b=CZ7Z/KXlFU3s4q//cZq5HpablcbI70i72j5T3k3CprckIf3SdC12ytVjLTiZylbcmY
         pFeu7CO1HNo0UUHCePK564zxANRBLQljdR5yOcbAr1CiZZGi7E/mvNUIYHVfpNf0jh+x
         2VN1C/g7vu/D63LTHRYiZvF61qe9ssvLVnIcw0571j4dTujywKIAGnjEVW4SQA472e+e
         G5pkQCD6wHykXvao+b+TEyvVCfzo4/kDN3bYtysLUzgyE1wKId/k4G9ZXuv6Be6MAIMa
         40d+TBacUX09x4e5FFbFZ+i0pwQkaQmkGfJwsjbH9EzeCrJM+b0+bBTxSgIB98PgwQpS
         yHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174158; x=1785778958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QobJDhQM3EFzE5CfaULEs1c9Xyh8eT+RN0WimZuC2ok=;
        b=eOQauuNEo0V8MIKMp+ydtIejAetvoW3RFh1o2q2GvP87Y6tHUt8a4Rsqesnq7wM4GT
         3em2BMgcX43uEFfGFE1YiBpU/+vODQ9eHWXy7aiLGh1XJN374CzzEW0KoGfeFom/+GdN
         UDKMO23ep7RKRtv0POLHuypn7Y23AShWkx7hNsChYWPYA4dXZPYW5qPtMLB4Z+YuVYkC
         BEfNAv4TMP0j1QYt1khEVVemCDAXC/2sSd8rtEXTYxQ3imoYOEH12rN1bvFeN6NFQfwF
         rOWHHeCmUHmGOtSVGxNOIRi9Flr3K+6aXI4FOfq/eC18zN3dmSlmbUMEhMAg7otbcEVP
         fNxw==
X-Gm-Message-State: AOJu0YwDTdheb1MH6/b5yjvYEPh1KJ2qPNI4WxIl0x/KYxWHSWmU6lsY
	TDne8RkouWFXecCg+h29G56TcpOGYpCCXCpxBzJE4rRCPUByIMDQKwHGMD6B2zR1/Y+aIgC73Nc
	g3fiwEGOL0bR8WWjU5wonPYU4j79LvrM=
X-Gm-Gg: AR+sD11L6JkCatB/tSnRiOzOpoJT8Gd+//G9hH/pwiLJ3FfI4Dy3/aj3RQAfBynD4N9
	yUDlUVv2A8LHZKxVn0DaxO/4AfWtRDy/Zq0Lf/ffVwDqQsnQEapOLeH1CZHWrJaQT751NLVBdfM
	oX+t4iYlgsWzuhrr5LvAFl/1XhrQICo3KhRZ9x4JCiTIUgwovDPX6ZmWeq7Rjj/6bEVZo3DN8Ro
	psG3T4dn8d74+0m5rckZAgV4VQa4REavYDidKxVE/9KP6NHLmY9+Vgg8NPDo+ALBF9KA3DWSEZf
	v67NVXKDuMN27WSzq8Bny19llxLshlMZeLjkzjiuaSvBwAzmnYCgCuPn9WXm
X-Received: by 2002:a05:6a00:9a6:b0:848:2f73:8ff6 with SMTP id
 d2e1a72fcca58-84e8d4b0d15mr331661b3a.63.1785174157906; Mon, 27 Jul 2026
 10:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726060453.42730-1-baul.lee@xbow.com>
In-Reply-To: <20260726060453.42730-1-baul.lee@xbow.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 27 Jul 2026 13:42:25 -0400
X-Gm-Features: AUfX_mzQbBCIW_SD0RyVpIs29DmCPGe-cmG1TE8bleV2eUauPaK-NJgYkr5m9vg
Message-ID: <CADvbK_f5RdD0DAzXZJ8c4-Vm5EDEWRoz4Jz-FsfJBvdEDVS7BA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix transport UAF via the retransmit queue
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	federico.kirschbaum@xbow.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 2:05=E2=80=AFAM Baul Lee <baul.lee@xbow.com> wrote:
>
> sctp_assoc_rm_peer() clears the cached chunk->transport back-pointer on
> only two of the output queue's chunk lists before freeing the transport:
> peer->transmitted and asoc->outqueue.out_chunk_list.  A DATA chunk parked
> on asoc->outqueue.retransmit keeps pointing at the transport, so once
> sctp_transport_free() drops the last reference and the object is
> RCU-freed, that chunk is left with a dangling pointer.
>
> While the chunk sits on the retransmit queue the dangling pointer is not
> followed: sctp_check_transmitted() skips the flight-size accounting both
> for transmitted_queue =3D=3D &q->retransmit and for gap-acked chunks.  Tw=
o
> steps remove that cover.  First, sctp_outq_flush_rtx() moves a gap-acked
> chunk onto a live transport's transmitted list without reassigning
> chunk->transport, unlike the ordinary resend path, which rebinds it in
> __sctp_packet_append_chunk().  Second, a later SACK that reneges on the
> TSN clears tsn_gap_acked.  The chunk now sits on a transmitted list with
> tsn_gap_acked =3D=3D 0, so the next SACK reaches
>
>         tchunk->transport->flight_size -=3D sctp_data_size(tchunk);
>
> a read-modify-write inside the freed sctp_transport.
>
> The transport is freed by an ASCONF Delete-IP and the faulting accesses
> are driven by ordinary SACKs, both coming from the association peer, so
> an application that speaks SCTP and accepts multihoming is enough to
> reach this.  KASAN reports a slab-use-after-free read of 4 bytes at
> offset 216 of a freed kmalloc-1k sctp_transport in
> sctp_check_transmitted(), the object having been freed from
> sctp_assoc_rm_peer() via sctp_process_asconf().
>
> Clear ->transport for chunks on the retransmit queue as well, mirroring
> the existing out_chunk_list handling.  The sink already guards with
> if (tchunk->transport), so a cleared back-pointer is skipped exactly like
> an already-acked chunk.  The sacked and abandoned queues do not need the
> same treatment: chunks there never have ->transport dereferenced and are
> never migrated onto the retransmit queue or onto a transport's
> transmitted list.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> Reported privately to the maintainers on 2026-07-10 with root-cause
> analysis, a PoC, a KASAN log and this fix; posting to the list was
> requested as the follow-up.
>
> Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list ch=
unks in sctp_assoc_rm_peer")
I think the issue exists since the very beginning, Fixes tag should be:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  net/sctp/associola.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 62d3cc155809..c95f68d21670 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -569,6 +569,10 @@ void sctp_assoc_rm_peer(struct sctp_association *aso=
c,
>                                 sctp_transport_hold(active);
>         }
>
> +       list_for_each_entry(ch, &asoc->outqueue.retransmit, transmitted_l=
ist)
> +               if (ch->transport =3D=3D peer)
> +                       ch->transport =3D NULL;
> +
```
[sashiko-genimi]
This isn't a problem introduced by this patch, but does the new loop cover
the ordering where the gap-acked migration happens before the ASCONF
Delete-IP?

[sashiko-claude]
This is a pre-existing issue, but can gap-acked data chunks bypass this
cleanup if they were already migrated to another active transport's
transmitted list?
```

Both AI reviews report that the change may not cover the case where the
gap-acked data chunks bypass this cleanup if they were already migrated
to another active transport's transmitted list.

As you described in the changelog, the issue actually was caused by:

> ... sctp_outq_flush_rtx() moves a gap-acked
> chunk onto a live transport's transmitted list without reassigning
> chunk->transport.

Can you try fixing this in sctp_outq_flush_rtx() by updating
chunk->transport after both list_move_tail() calls? This makes sure the
chunk's transport pointer always matches the list it is queued on.

Thanks.

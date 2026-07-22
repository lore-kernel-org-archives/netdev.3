Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5F4399DB
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745104; cv=pass; b=QtTtYuU4qrOna/cQvyPc50dX+nZ/3Ry34X2zjtfiuwYQaubVC1nj5VsOfh0P25rz6RI8u9LfaRLru6tTJgF7biFotdsr+cqIZjsyCW2jr0baqGorIBkGqqj9ApdnL3/Jhcd3hTv+bBtaU7nJAhaqvtNX193fp8UsTqgfMiDfAdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745104; c=relaxed/simple;
	bh=IA7G2u2vV6NVKEZyHe3wo12TA7/PxKbDJFi3T4dwUg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+QmD5apCO5Rn1zZMC6obscgWPGZI8x+7euH0CjIiZE0HY3RMqti6dY2MXQnYMBFwyZcHTOSSjWUnbioFHeqpA86JdZvJR+wppOk706W3W63/maXMtMGg5Clvy007e7ECyXec/JTPYnWkkRflwP6BvOrJtEQrp0TBdZVShakV14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzUCiH3h; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzUCiH3h"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-736eea06c3eso3705757137.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784745100; cv=none;
        d=google.com; s=arc-20260327;
        b=rfnS/5rdjzoG8fnUNUrhk9poN4K3aD85gDoD3EY2XkV7BNP/jaUq7EduFmo/0PbO6b
         ERn6HZdbPwsktUNyDhnGj2fq+d3dZfzqzrPLKU2ZVPcVQ6PcjoDxlm7bknQtWqKhUHdf
         z/r7UGhnIcIcIFb+JSPr2xeiuaSZtwqDd7CgBMHxEQcExKDimFYM7b5nteq+uA547WzL
         K+RU1eCqIi8cuC3wMeS32vp0A5yxq0PWx/z23+DtkCuZdzmZpSgiaYK3lpGOKmK9sqD7
         774x/P4Uk9y/LXEBr/eMUEh/cJZZMc7Bx635VDcVTbwF3LhcKKFacJS5WhmvuIdzgo7G
         Xlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/hMBR9xdLLcYOtadOuetEIVcftCz2uVEGlsfy4vyWE=;
        fh=USywc9ZgLwoXn8pXs3EFCgjgIG78UKeXx/ujv3Dfs8A=;
        b=pLinIIgmjhTPXWZp33CoqLB/uoY4WnM7mKempFYJLMM+1Mn4gm8BLuyjYCGxCg3Ipj
         dmThxvo0kKMTQwvPNUWbPZyYM38dYM96j/Pe+tbXs8SAP7UjiXJul9Q/IGffjnGExZka
         asJyHb+3a8DqEgtF21q6QWQy6ScF8lrQMRXyEGPDVrFzt18TIwritIDLBFvBXZcIg1Dt
         676uJvPPMK8O+HNGVpo02VaiG0si1/Odbf2ODzk4IcJbCIelCQrDEPycwj3sG9fSBQfX
         exfrXXatHuAHJx6QAF6Fv1FnNfZWU57X7kfQgUsSjQJFem+RdLFV8jHpwn0LyZ8HISyx
         cfSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784745100; x=1785349900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q/hMBR9xdLLcYOtadOuetEIVcftCz2uVEGlsfy4vyWE=;
        b=YzUCiH3hSfkRGHFlshF0edqY7kbscGdIzXEJcUIhu6g8guZkPI6/YP5qp574S2CtOM
         QNySgEXtju9t6NOlNYfRaNxliqNv5yRIahQ3PmUQwKu/v/1otn84i9riVVWxQ/O88T2a
         7KtodXS05WbBnwyyEJkDqQrb+4pK3i0asoYw7MCs3Jz/Lf7oj5VRUhyNfx6yd8HLbcDU
         EXtlqXuU64mnPwNpy1WG/snBijS9mv7GGwQii1E580vs/pvgZ+55WZYfEGVDc7s3j+01
         X6iMNeoeeZPv0n6/yyno8pAn1pP93GALEjXabfvNA/R6CuDp9fJWhsX/lT3Uh/8PTLn3
         TrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745100; x=1785349900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/hMBR9xdLLcYOtadOuetEIVcftCz2uVEGlsfy4vyWE=;
        b=fqabJLrvX80KFJHrst8ZQrNOzpe9jJe5utrcZ+UJsiB9SNpcaog2Q/7kdWz7tmKHpP
         HG4D59DoDKnv7dC6FvUyn/2Ei7LbdCBlwl1sxz6Z2T+qdZ3/0j8K0c31VRhkSMNgWYfW
         VybR/1YIEFi7qyHGqDNm0XoEM1MLVPCjIq+bc6enl9bamrDu61SGdTGCyQfElHVey08l
         /OZd7901fw+ly3Lnffrtm2mWtmBrxjFtM4rNU00YNjKLTSXbHzY97bnF9zLm+bGgJ4Vz
         eZMFX2xSihwSq+E0Kt9aSUa15wL9xYZjv1Sn2Fh2UM1FtC3yWIz/nr9Vo+ZwhAFN9XMw
         pyEg==
X-Forwarded-Encrypted: i=1; AHgh+Rp38RoN86ZJy3OfQnJhB7bKYq57hscraOOlDRPGkmJRxDG/Y5Z2dZp8iUlqxI4HZsUT1F2+Q2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3emNxMXgGNMYvOT2T1/r5Z1FnYOLjgX603+b9IhSKwW9VsmxS
	ljiPbWm7u7JQ5wZqyHR5p1XUCPzS51wmUETwc2tzLfXets51ZRWbLhMSMcAMwlcYFsvlrOyyhXX
	LmRotu44zv3ph6NLpZ+s9H/4dvPmLFHk=
X-Gm-Gg: AR+sD12hHBrAlpt+2iQt9VJ39WCoVgXQMz8z5wd+Xj3tYMn0mMLAIuWJ4K5qK6LvrBN
	DN8Gv6jV29w6qT/N88zt2lsIc9c71WyQioPV/7sb7uelnH0PbU4Vq9VlN0C6+vVinLriMlLFTZx
	I/u4z2vKL6xOF2P+KsMl1lEZg3Gi1IhhSx5eYN/OBQC9BtPtsf6FapsTAarZx4EaXoPBSuIiouF
	EyEUjpYP1WKJB97Q/ap56CY6A2XDEvz7CeI8ouGdw5IKCnawy3RPI3Zrts+k0LCdpVHuT4fhk/2
	AXucQmdRinLalQh+BnfvY52aCy+h01RfNARBpy1VM6rujiqZ0RCzOEa0RqTg
X-Received: by 2002:a05:6102:3f55:b0:745:6721:8c2e with SMTP id
 ada2fe7eead31-74753465622mr8799641137.2.1784745100524; Wed, 22 Jul 2026
 11:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721015532.120157-1-l1138897701@163.com>
In-Reply-To: <20260721015532.120157-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 22 Jul 2026 14:31:26 -0400
X-Gm-Features: AUfX_mzhvOZLH9_yULd7m7gfTrtt0JvuYGRzvviB9G2wTum39x2hRL_f91lWRpw
Message-ID: <CADvbK_cb8Q=9nv5Z5eR3cf=NLb=5=wSg_HKHrtCtPU_bAN=qvg@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] sctp: auth: break when skb_clone fails for auth_chunk
To: luoqing <l1138897701@163.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:56=E2=80=AFPM luoqing <l1138897701@163.com> wrote=
:
>
> From: Qing Luo <luoqing@kylinos.cn>
>
> When processing AUTH + COOKIE-ECHO packets, if skb_clone() fails
> due to memory pressure, chunk->auth_chunk is NULL. The original
> code still sets chunk->auth =3D 1 and continues, leaving the
> COOKIE-ECHO to be processed without a valid auth_chunk for
> deferred verification.
>
> The intent of not setting auth was to drop the chunk earlier,
> but in sctp_endpoint_bh_rcv() asoc is NULL for new connections,
> so sctp_auth_recv_cid() returns 0 and the early check is
> ineffective.
>
> Fix by breaking out of the receive loop when skb_clone() fails,
> dropping the entire packet since the AUTH data needed for
> COOKIE-ECHO verification cannot be preserved.
>
> Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification of A=
UTH chunk")
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  net/sctp/associola.c   | 2 ++
>  net/sctp/endpointola.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 62d3cc155809..7741f982e368 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -999,6 +999,8 @@ static void sctp_assoc_bh_rcv(struct work_struct *wor=
k)
>                         if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO) {
>                                 chunk->auth_chunk =3D skb_clone(chunk->sk=
b,
>                                                               GFP_ATOMIC)=
;
> +                               if (!chunk->auth_chunk)
> +                                       break;
>                                 chunk->auth =3D 1;
>                                 continue;
>                         }
> diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
> index dfb1719275db..9675370a46da 100644
> --- a/net/sctp/endpointola.c
> +++ b/net/sctp/endpointola.c
> @@ -368,6 +368,8 @@ static void sctp_endpoint_bh_rcv(struct work_struct *=
work)
>                         if (next_hdr->type =3D=3D SCTP_CID_COOKIE_ECHO) {
>                                 chunk->auth_chunk =3D skb_clone(chunk->sk=
b,
>                                                                 GFP_ATOMI=
C);
> +                               if (!chunk->auth_chunk)
> +                                       break;
>                                 chunk->auth =3D 1;
>                                 continue;
>                         }
> --
> 2.25.1
>
>

The sashiko suggests adding chunk->pdiscard =3D 1 and continue to avoid
stalling the queue.

                                if (!chunk->auth_chunk) {
                                        chunk->pdiscard =3D 1;
                                        continue;
                                }

Also, as the original issue was already addressed in the other patch,
you should delete the "Fixes:" tag from this patch. This patch is more
like to discard the packet early if the skb_clone() fails.

Thanks.

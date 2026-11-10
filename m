Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325666;
	b=RFMM/yPonPUhKuywG2ALf/UvzM1lJ8V0dVnG086eHOtmQqFuzb3+bDlO85nVvADElDtl
	 0th7qavS+NNQD7NzYoCfYiCKQGIn7vnfsLtP+eQd8Fzpw2pkqyPRnNjLSuM85b3P/zq57
	 k1qAXWnZ6mLpX4NW0tydDO2U1cYAJmBNb+sDmMzSqjGg+uMikmR4Y+5vzJXj+IkKp4DVI
	 x9w/xhHXmSooEQcHmFLLscEt6dzamjERpPlXHQ8lAIN5K1CqPEFveDm8BuLNsp4PffK+o
	 CQC8/CnhbTG/adfM29VRXEQ4w1IiFmK+rhVv4KMIClCy4uxu5VMwkePRS61Jya2u3vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
	b=FHcu0R1SAAQ+Op52aNRBsGPLFF4zE9/ZjTNd6LlJZBcSJlO7Dt9JEtC2aLnNpCiUGN6z
	 MPxO2ZffBBxczLIGNkJOzvZt6YU2/lAmpAbX0xT42/r1aE9AB7CaC4kgvCC17uuJBxTqp
	 4bzABwuGOxqMuhdgdJIHzCHdFQFMauAPzgcCsLxc4AlUcbyPL9FmVhTHKtlHM4LW35Apr
	 OID3G4NhVqBapsNUbV2SqYtDkKqKFpqYJWmKyt6CcqTH8oCaYiEm1XfmN+ZH+hdKo+gW9
	 VrNYWWjtpbZkQ7DLDMsNtkP10xSa00C17I3fZRh2YRj3e44uHLnavl85YxQRQdiwgGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I/Lw8i/b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EE606A323
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A9EE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I/Lw8i/b
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso1026814137.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:47:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325665; cv=none;
        d=google.com; s=arc-20260327;
        b=J0H/gvGRqGt7WPEKdUFq2OtI3wk9kZExwYaCNVs8n+wlzTxEVuQ8bxWiYTbTM2z673
         jNYibF086TMjEbyqAcsrLEcpJWUxJP0NTESFchWfRJPcydaXlBNQqKlKrUjSsCHYqafS
         chUgO+BF2c945r2bYLUT4SBIBFii4Opfmz+HAjKf+Vcc6QwZeqUSHwdq98noWYtpQNkR
         a0VY+vrcGQaXlUZlItlvGnNlmpTZMxSmwxCPhfGXTbBzSQ0sDPH11TkgYbeCzaVpCcic
         m+obQFqVP6nu23BMTIAwZ2X1klhC6haGYCPzZtXQddk9Tv6vu2iSRbtm9OKFx0hXgUie
         0CXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
        fh=decuLPkoSrYHn/UAuyrZIKclB/9cIMEXfc79VtDtkY0=;
        b=Aiw7mQJ9tmdzT7aRoNhAjb/K0/BfgisgdQ4GIbBXVGTJ4bSyWSZL5amMqFUx9Y2iBt
         VxjMTClfl4kex//Gvo+QYhy24qhuZ9j8LnYaextSWrSN+7hDrYwvrvjcSORQOjJtm4JH
         PxggeXA40Vo2OKGZULHnxyrthEPLQlzeOecZXWDOLg7CKjVTWTWxB+eyTb2CM3bJ9T4G
         j7h3w8CJ8rvFf1ef7pYOMRUOmNEqrU3/8d1v9yL9TwBcSxZSFYvhAVWNSNJ4zXah6Jxs
         KPSwex0iJ0eLqeYIQTvaLcsvX2vZsqrYMm7mnZLk3YNWmQPIr5LXZNkDd7cfrM4B4xeN
         N+sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325665; x=1794930465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
        b=I/Lw8i/bwk9+5IhcqVCZ//ULNLAb1ddsCuYGASvGUAtyPg5imkQGj7iIi6g9XzOHft
         BYd8pOWh//XX/U7aTv1AlumnSHl2fuaM336e/9B/kNktK/7WZQdorEuxWpAQETEf3v8l
         ZHO0/DHb/+jabyFywg3NjkTKHajEtGyJ/mmKwAr/U804Ezjph5uK8BSRbopqU+PfHJGg
         G1zQdTsvH8ZEma9FpollCfKMGD0QMGV25R4SD94smgtLwY3tp9Vwzmqc0dNmSvKjCBAq
         brmaxPH7SXPwJw9514sCKmzKCvZ5YxW9h8FSc6P8fRzgNGJvIM5b1dfu7Tj90kbhErfg
         Ajug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325665; x=1794930465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czf6TxvkDXLy/zkO0/xTOB61Eq7kaspeLRCs9D7lhNo=;
        b=K+VRo5bz2ztKzIsDPJcwn4T3ckComnIWeiCBrqFNHdCiWtWs+CvPh01et8AMJlSW6q
         qdavCyOyNO0aLCcSoM2KHhnocRGVlquPb54qbJYVxWsjCqcPqNJVsYVJU/7hyp2gVGv5
         3ciqvfLPFvxdK9KdUl/NW4SaXueBn5XF3Vm6G4M6gw2RvRY/d2T9y5P//rMIHqVsBI23
         jD1wuI83hjPS/wxonIDT8Nqo7WQTHHrVFkI73O/3M+r/pkhPg7qCVWySTEZv6nx5+8nt
         rVIc4YbuE+pZIAkslhApEkDNDxas9UGL9zTSvTsyAvBVF/A4+R7GothEcHvQ2VcT1Y6W
         rIzQ==
X-Forwarded-Encrypted: i=1; AL+hErFXP8QqraM9aHFZDX+8L4HtwxG9LefEYidi7qCDJLtUWCbhFQyWY94CihzBzBE3ozMtFYOpRII=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rug8sBid14OIN23lH26M7NEX0rYzdydfmEsDae9eHtK19zjWe
	bnXHp6ewqqdMb6LVHG9RzXM6NTjYEry4B32NwcvDTrfE1d0IuT3EHkkOOADcbK/HmtAt86oxMqC
	mc8/Y3r8zfJj/8SFq9+/imN/MwhGMlVY=
X-Gm-Gg: AYBFou2+5qedrqRcwMDDP1pXsbD+XEAcxHhtNrIckH7SHAOGu1zLahPr0I+EX3lrlHK
	kRsJwNYJcbOubdhwdqCUAH7HX/lA8e5z0nGsHQ0zqwlJw0RZGlI4FsBRB78J9MstqzU4ksF1DGJ
	ElcqSbPTJHSznTxSOgnM61cOQNoyeJiyrCLuSrALb+iOCc17mngNhqquFgscxoPYImJTxF+M3MX
	GgxFPt53F0zT41oKvlV7tPZXpdI8BTQINM0Uvs+2tKFOF+80suRGcfc5A9oczFVIVwgBmy6+bFp
	8zJpxKh2WZwKuFlx5NBJs9qQIWvKkYtK1k3x6/od0SV6+pkheFA1Z48oMZLluPjg1pbc956RIJE
	7+WpSGMbAcsiNHcMTeFfJcwE4tR/3RLRlhIw3yjGnygdd8dXuxEIJ3Y164FX3F8vuHTjqpIugvm
	AWQI70Q0tIu+ox4rJGNlVhPIy2sZCTBv4HUNYzIg==
X-Received: by 2002:a05:6102:1606:b0:7d0:5688:f4fd with SMTP id
 ada2fe7eead31-7d301bdfadcmr1347648137.17.1794325665086; Tue, 10 Nov 2026
 07:47:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106185203.3326303-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261106185203.3326303-1-bsdhenrymartin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 10:47:32 -0500
X-Gm-Features: AclHuK-W2zfpJA0Fe0m-8dv7qSw468L0XRBR04aNiVAdKPvb2KSOSY4FgSHidEw
Message-ID: <CADvbK_daN6zZNPckkGh=r70ooNwTz59VViJy5jPp1w18SDPrzw@mail.gmail.com>
Subject: Re: [PATCH] sctp: fix skb_over_panic when adding addresses with a
 pending delete of another family
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, edumazet@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 1:52=E2=80=AFPM Henry Martin <bsdhenrymartin@gmail.c=
om> wrote:
>
> sctp_make_asconf_update_ip() accounts for a pending DEL_IP
> parameter by reusing the length of the address being added. The
> write-back side instead serializes the pending address itself,
> with its own address family. If the pending delete is IPv6
> (20-byte parameter) while the added addresses are IPv4 (8-byte),
> the chunk is allocated 12 bytes short and sctp_addto_chunk()
> writes past the end of the skb. E.g. on mainline (05441d697f7f):
>
>     skbuff: skb_over_panic: text:ffffffff84859c77 len:392 put:20
>         tail:0x188 end:0x180 dev:<NULL>
>     kernel BUG at net/core/skbuff.c:215!
>     CPU: 0 UID: 1000 PID: 379 Comm: poc_sctp
>     Call Trace:
>      skb_panic
>      skb_put
>      sctp_addto_chunk
>      sctp_make_asconf_update_ip
>      sctp_send_asconf_add_ip
>      sctp_setsockopt_bindx
>      __x64_sys_setsockopt
>
> Requires addip enabled on the endpoint (net.sctp.addip_enable=3D1).
>
> Account for the pending delete with its own address family, as
> the write-back side already does.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Cc: stable@vger.kernel.org
> Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host=
")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 90de272842512..18947ec5ff9f9 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2886,9 +2886,17 @@ struct sctp_chunk *sctp_make_asconf_update_ip(stru=
ct sctp_association *asoc,
>
>                 addr_buf +=3D af->sockaddr_len;
>                 if (asoc->asconf_addr_del_pending && !del_pickup) {
> -                       /* reuse the parameter length from the same scope=
 one */
> +                       /* The DEL_IP parameter is serialized from the
> +                        * pending address itself below; account for its
> +                        * own address family, which may differ from the
> +                        * added one.
> +                        */
> +                       addr =3D asoc->asconf_addr_del_pending;
> +                       af =3D sctp_get_af_specific(addr->v4.sin_family);
> +
>                         totallen +=3D paramlen;
> -                       totallen +=3D addr_param_len;
> +                       totallen +=3D af->to_addr_param(addr, &addr_param=
);
> +
>                         del_pickup =3D 1;
>
>                         pr_debug("%s: picked same-scope del_pending addr,=
 "
> --
> 2.43.7
>
I think with no longer using addr_param_len, you can move the
if (asoc->asconf_addr_del_pending) branch out of this loop.

Thanks.

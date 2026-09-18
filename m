Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A69348C7B
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745552; cv=pass; b=X6DC0vLFK491eWIIsipOTW5go6ytLs/g/QcVBJ9zk5h38Io9r9MOxoTyKDMyCaAH7LMyED9gxlObAJxRAHhICdKmlgBcN7s4/TJOCGyUlStR8xclSLQ8eAjHJnYIH+wrSjCjFGB8r2fz1TV0BP+vffzNON4lP26K1XcQ5MqxYLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745552; c=relaxed/simple;
	bh=ymSNiHBv0rxNjhBEBzAQ3e5pEXSbhOPJPBVgbAV4qGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwje0ItC3rdatB0ZCU+48Bu8vpOvslKX2snm/IX5ten6c9974pgSA05a1QJ4jKjZxoMTnhs5mztpJ/ByexFvOgcYgxJ17I59quAh6ZsGDUzYSDq+G6UTSWvyvvBfAgVxLgUSeBYF3nvBbtLCa8HSZ6E7xJ2N2D+BRH6YGgnxYZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6O1VpwI; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6O1VpwI"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8686f46e4adso795008b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789745549; cv=none;
        d=google.com; s=arc-20260327;
        b=Wie1GmbuQC58/9UVhenLAHKY704FzTQjLK0Vt54RSXCII3Cf/8TGrJIGW1YPt2/De6
         S7eNB+dVZqchVXngK5NkBzolu6nQaHtYut55qq1KU6xWnzK67f0/R5LKF05ILloj3GTy
         6nwAkk1NBqLVRB+3tnvBGrg4KmjBM+3GGOvOd8VGm1Wyn+v8y5QCnJo5pGjrqqEMpXDp
         lHtndNKMoVS19ozVzrGz6CIzOYy5V2JUPw3gPLxAT4BvJKFlIc8zmvO80/Qv0ngtc8Rb
         GF2f3V4cVdWIno6yNoFcUzahu9PMdnyxN5rytoYp0b4mLOv82OpqAqttM0duWxzrSA3G
         fS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W1ylXOncdQ/xqG+G6xMvP7qzdxs98+NQiLMh31Gq++0=;
        fh=XlZDrSU5TY6a01AirO0srhCfaFtKDaDcuYL84HuIjq8=;
        b=QNgb3p39slUdrDgOg5z8ZJvtsM6rSKg6QXVofBoA/lc2jG1kg/40g1gBoV23SF9G+d
         A06R6waY8cQD9dB/Sm1OIq/9H0ohCMk1eYSn2vIxrTmgkqPjNL8UrWEgZpqxIdcUubnk
         DNTc/1GR+PdbI+7FsZtJEXmSn7IhWlPqtGjqp3vu0f/MUwqeP2Ea3ofQVJdKz1FlFC/S
         clQiqsspadqYOVMyiK1x7bjR6eiHqoXgFnsckw9xwQ/J0txGrTG6lLoVPboP/fFtgiqO
         RXVtEWkrD8xC3XLn5ZXp//j19sF/2F1jhAhl1IUFRe00InIcs/EWXGU+kXa/0FmgkA1I
         Y73Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789745549; x=1790350349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W1ylXOncdQ/xqG+G6xMvP7qzdxs98+NQiLMh31Gq++0=;
        b=Y6O1VpwI3Meq1JdZzi31TXfQpcpanZ4wlV9iuXpd5sjIig7phQgfCU47aWyfR6vo5k
         fF5qI7YbZKJqfy+x8XAZFltiJon4GuQN8WBUzqUeSKaguTIN3WWM42KofwVy992IGB3D
         A/KwLB5orHlmqbo35PsAsbVq8pWeMtHNIK0XxYEMlpSTBYYH6K1HR6U62pwvfxU6uZZJ
         QX9pHkygNT6TFTQDXgl7UFGsE89L7ug/iJ1SDQBdIjMEx4okR95NWxfMUcFzo2x7Tnf3
         0vdbG2BYhFcpGWJ8wwNFfDRQ8xHV1NJxG+crmfcpyiZ5BtlOGzbEKTHAhPTV/xTWj6Tu
         LwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745549; x=1790350349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1ylXOncdQ/xqG+G6xMvP7qzdxs98+NQiLMh31Gq++0=;
        b=0OWX1AcA7m2U+5OQ8AYJLOBOYOyH/k0JJg351LB4gAidiOfEsVea2hTF3fJl9rIIKq
         fc+Q7RPDbddtppJcqlupl7qM+zt4FtsRaDvL/tUbZ2PRnW36T2quwDkp1K6CBu80pI5Q
         kH753oXauG0i17d4hGsEt1PFko0uPau8Wu7Vdd+jSxKkwvczlTqv+W2fe8uYAZ1jAVC1
         tlzIq2DKy7VCNrsW+MZwSEcfMiKFBUSbPXD8U0xMD7e/V9iEyI2y0ntN1KDD4FPoJGJx
         BAqBfTUVB8tLE9p3ImKnDn3uqNbIM4QPV9rnE5QTA8t08iIvesXj84jd9MYJp41SNHRa
         +S1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxsPPFjMbUVSToLE6BLKgrcGw+Rjuleb7BNntknm7vn2iKqxY7sNVam6I8diT2T2SuUGDNx0X8=@vger.kernel.org
X-Gm-Message-State: AFuF++lRq0ItG7/WTp4HdYghFPCCyNxYlbzBpkRq0XXxJh2aSUVyNPwK
	aqMVHhGDY89W1Y5Lk+qsWlQIe8wRl2B5kPX9/DpesOljRipaItVFvDS541pR3hxYI2z2zpzvCRR
	mr8NS/PUMisbouQBaxQjQsfrjyX4K6iQ=
X-Gm-Gg: AYBFou38gTYauwoNvqJV6eAoGF2JRP0ku4vSMzEScFisJ/fKqjxKKvnfNutGufOvv67
	q7HripBlSQuQUhj3ic4ZLiIGdvUw7IGwo6L4fhdFxppmr7EA78NhlOJF6RCePWP0qbIqu2I5SF0
	x7HXTnoini5BY4PZlBd/41edH7EkhdYPXYAJpsTw5/52al/AmuWmtL8MpDDx//7EQZAnpgXa/Mi
	eXd2srTXvZ795tdy6WP2TxEk80m48d4z6k4jHd/lg3WdjEJVBN7UYHYC/lKiXCvCy63N8lmFHih
	LDw69XvePSp/whUSSeICUcg7TmN/6VSUz3pw9hYjMewKMyQOGdG5MkNAQPkSTYW/5HEKyMGOomn
	nXQl5Xx+yo1Hr61MEjxNy4/kE2XlQp9HpjX1lCoDOO8Q7ImOyE0z2pumA
X-Received: by 2002:a05:6a00:300c:b0:86f:394c:5c68 with SMTP id
 d2e1a72fcca58-874dc0f8b8amr5619824b3a.13.1789745549406; Fri, 18 Sep 2026
 08:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918033942.85061-1-ndaugoing@gmail.com> <20260918033942.85061-2-ndaugoing@gmail.com>
In-Reply-To: <20260918033942.85061-2-ndaugoing@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 18 Sep 2026 11:32:18 -0400
X-Gm-Features: AcwNN1WmYHIGdIjR33SQlazp2k78HvrE9WOuXYfeYWpG_Q_w2uIVAZW-9f1-pjs
Message-ID: <CADvbK_dQdro_x-=ma2=bRgosYf2cZfEaqrbpeg-8odoBHnzqVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sctp: check return value of sctp_get_af_specific in sctp_process_init
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:39=E2=80=AFPM Yuchao Zhang <ndaugoing@gmail.com>=
 wrote:
>
> In sctp_process_init(), when matching the source address of a COOKIE
> ECHO against the embedded address parameters of the INIT chunk carried
> in the cookie, the address family handler is dereferenced without a
> NULL check:
>
>         af =3D sctp_get_af_specific(param_type2af(param.p->type));
>         if (!af->from_addr_param(&addr, param.addr,
>                                  chunk->sctp_hdr->source, 0))
>                 continue;
>
> On kernels built without IPv6 (CONFIG_IPV6=3Dn) sctp_af_v6_specific is
> never registered and sctp_get_af_specific(AF_INET6) returns NULL.  A
> remote peer can reach this path by completing a regular INIT/INIT ACK
> exchange over IPv4 with an SCTP_PARAM_IPV6_ADDRESS parameter embedded
> in its INIT (ignored at INIT time by the address family gate in
> sctp_process_param(), but the cookie embeds the whole INIT chunk), and
> then sending the COOKIE ECHO from a different source address, e.g. a
> second interface of a multihomed peer.  sctp_unpack_cookie() does not
> compare the packet source address against the peer address stored in
> the cookie, so src_match is 0 and the walk dereferences the NULL af.
>
> This crashes the kernel with a NULL pointer dereference in softirq
> context, remotely and without authentication.
>
> The other from_addr_param call sites of the same family already check
> af (__sctp_rcv_init_lookup() and the ASCONF path in
> sctp_process_param(), fixed by commit e40607cbe270 ("net: sctp: fix
> NULL pointer dereference in af->from_addr_param on malformed packet")),
> which missed this one.
>
> Fixes: 0c5dc070ff3d ("sctp: validate from_addr_param return")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
> ---
>  net/sctp/sm_make_chunk.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 84a4c97d0f75..ff1c013e2575 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2381,6 +2381,8 @@ int sctp_process_init(struct sctp_association *asoc=
, struct sctp_chunk *chunk,
>                     (param.p->type =3D=3D SCTP_PARAM_IPV4_ADDRESS ||
>                      param.p->type =3D=3D SCTP_PARAM_IPV6_ADDRESS)) {
>                         af =3D sctp_get_af_specific(param_type2af(param.p=
->type));
> +                       if (!af)
> +                               continue;
>                         if (!af->from_addr_param(&addr, param.addr,
>                                                  chunk->sctp_hdr->source,=
 0))
>                                 continue;
> --
> 2.53.0
>

I think this is a dup of
https://lore.kernel.org/netdev/20260917030505.4176635-1-hdthky0@gmail.com/

Thanks.

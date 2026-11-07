Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794074036;
	b=YUM0bABUXPNcCpVJm8xhPfePoXTN5pf5DiUkiEZaPnU/qIsf/LhF9OUfXS03GbAoR9iP
	 TTdTte1GUKqetgntCDlbmxpmkS6Kym5guK+jScuiFcCWEk9Xj2snD6LBpvDcdnpxv8y6T
	 Xa2gvvSoc1E0aciw72qgETMgqSQVdrfMLCbCYyUd0zMxuCjmiRsPMf/1/lpPznj91svVk
	 EKUnxIyJRejCpc/9ZVnNfOMVhFHSNKi+Nvwa37RMrJVPfYHRXQ/sklmwsClm5LE5oE0Jd
	 5Ci/OKtfFQMbXBy1cv3a70I/S3Y3I9td4oQHGbGuKRu2qjX+Sfubmqa14Cp07HnLYiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YuSKW80gEdEKIMIUHnhqL5O2fdz8zV/R82jKMhNdzM8=;
	b=UvrCv/4KPnHiiK3u6gTFkQxQL+uXzYO1hSUgj75ldS3ehykxQnyo0mjtdWKAPtRwbjbn
	 P909MybfAJ4jG/9VAzsXn0gQzVThmVhPGCesNH57Ld45PgG4vMqtRK8Psq9q43BlNC/pA
	 JYQqJHTwNx9Gsj7tOfHz4J1lXLwo4NFOUUCcudXwZS6LzlcqI9GuweLPoNmKXR4G5+w98
	 zlz1tMdzzHPo+eDi+9AtY+5HBBkjP+TRzEPVh0SuYPg38gOKxnmw/cWBQqOVL1w8w1/3J
	 KWpaus8ZHvOwaTDMMoBJOgPmXir0PkTxmSuie0k7dR/vLwEcjzfDTm5MC9boKFAJeiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MA43WfmR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB3606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 17:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MA43WfmR
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-535f598d126so85651cf.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 09:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794074035; cv=none;
        d=google.com; s=arc-20260327;
        b=h0qMGhWwxOsO812WrqdKD/Has/fMfGv6I1eBeKHxNevQ2laDZSlff3lRdmcaB9a+JF
         eNsxX2zfX2GAL/8XJboYSvQKVaOtO22v/j7Z/ojemZZRb9OSvH0DTuVdyciEcV2lsGI0
         oqvPku0SRIfKmBz92g3fJWftEIUu9ivC4+4RSOJh9uh5ngMwlT15VsyfP0XdhAzGbe9b
         P0dcuje2qrDSuRqeNVZmdkPIrqSsQFXG+L75YnARhmgY1xjU7kaAWEF6fVO56gE030w/
         LfsjigfUREOxHoCM6B9zRWAmSs4gDS/3carV1q+RmibiedrD3d7ZGmaImbwfJ2L25dus
         HlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YuSKW80gEdEKIMIUHnhqL5O2fdz8zV/R82jKMhNdzM8=;
        fh=xu0xa10olMaUMMUwwEqD1VcLi4Nr/EwL7Z1Y81l0Y0E=;
        b=JzfIjrZuwCGWhfBsxZnkqDwqfdo5zNJQqsfQndG98zdoxpDS68IWg72PAKashY4VNI
         oNDF6HTj+djhzYzXXcTdIE3VkAWX3RydzowWHIvM6yUVdi9T4BuF7qWOhEuJukVfw4dK
         jXNkpNXdRrhfE3YcqR1LdO/YQ0hIbl75Y2FwDungOM9COmFT4oBIlY85n0i1tJGpEZMe
         oOInbYSCzcT3jXhaWbu/VwYbk9t/vTJpYbGCpi2vxpvgP+fGyFkA1W+AcvFloB8Nbm3u
         w3wB0A3o7LFVxKh/APUDFrkeAy78UzZxznFhgBtVVEmy8Pm0r7e5y4Zn8cjSVgSRssky
         3Eow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794074035; x=1794678835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YuSKW80gEdEKIMIUHnhqL5O2fdz8zV/R82jKMhNdzM8=;
        b=MA43WfmRkdNpKUpHX5S3uJIFs7srnYuG5eT22TXmuwSmQj5p1KpLdBHBIP+Sp6zNLy
         Fcluhei+8RnXNRn5oAghsrsoPykvQsbaegnV/ATRS7fzB5Ep11p2KyqXwHJXKWJLNKOR
         faFXYBFCFQQbazi8ZelSEiNdJfLblkuKbBf5Xltl1CtXOThd6wnjlbkTsFandUb0Bnxs
         HWxu3tnEu8ZeHdAfrb1cr3MAIoKJJtYIZSf+T4vEpczx2cOaknV/0jJC4xHW73MMlbRO
         +Uz9LpSuFbtZLp0kiirEy1I9tpRJLip/Wewawl2FWNCwMMfBSEgnM7UuwpgeoJ8sniZD
         2qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794074035; x=1794678835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YuSKW80gEdEKIMIUHnhqL5O2fdz8zV/R82jKMhNdzM8=;
        b=L4z9WWZWWXTCdoFuqO4saVpeqtXjT6yo3SpTUjMs5l9KItAuc+yeQlKfmWuxyNEzpz
         kZoNljnpZlE3UI8rg0heUceaGV6XEtsMG4yXYQ1552SeZhhRGNOH4O7Mq2qwPU2D0Z+4
         h/wK5PjHaYNtFohlhpRmzm1Ssg/pFELGiJjZwdK2tkHlzFNmxgvwtJKnMcLUUE1MN2dE
         YM3bWoOyREryO+OoGokmucULdYzSvuPAwb0xjp7LDyl29kFXtQoVFWDZgTJRCBML8zup
         H7fiBb4wwz/Bc16cRKYzjeYCw10H1aqzA7H74f+cs1jD4Mnz53IyGqm95159OFulxF74
         U6KA==
X-Forwarded-Encrypted: i=1; AL+hErEztC/S6D2LrhDzVDf/MlbJrPEHmzEOUL98jW9ETzyFu+ijmX+HSur5yZ6NEltVkLVX8JzRpeE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6G3jHpbV9XyJX0C0VcGLER06FpYbsrilOifkvTOkowf9+J4Vm
	0Jo11e9JjVpj0NDEisgPUm7TDSP5BJHWlsSFPRj0oEdgmBGHwRQDSjqMXHXLGLSNJluw/j1oevg
	eVo/yWtMZX4DjRVC/5kuN6iBnTY3sY73oWsuFqRq5
X-Gm-Gg: AYBFou1kczMDWWik08YXElzJHhbW85gCIpi46jc6FZr53uTGrNO46s8VIui84QehtvU
	aqmpoMQBa4B0Uk55c3tySb1vss2Piv/qL5fa5z1XmBELcL7ANdGN6DqxWjMzvwO1iwlUjYWnK7i
	imYB/Y/MzTZ0lJbN6o2VnCIYP2lpGAdVkTWXf8retrSV3UD3FlQfEtyRWRpg69G7+LbL9ChajyB
	+n0C9T9PCvRJ7x8YPb9/I8GReA62w46gSuAHSiEChR/ddEnh8VQrk7oZ9f5oG16B0fnlx0X72ZD
	qkV8Dnr5btxO1vPAOWUaCal9sPGnOPf45VI9xxFr3ikYUfnPW9u+V0wNShTcBaapPYALFSh3wWY
	yqm6LgD5gQWV9xxqBd6ezx1zIMFJmS4m/gawl+MLe5H3iiJsQPvi1/czECnmjCkSBWVrBxlHL9s
	O0DpYucYSQAr8Uuw0D+sQBNfNzK+k=
X-Received: by 2002:a05:622a:c07:b0:545:7949:80a5 with SMTP id
 d75a77b69052e-54fc4047021mr12339661cf.12.1794074034132; Sat, 07 Nov 2026
 09:53:54 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-mtu-probing-series-v1-0-a2809e725aaa@gmail.com> <20261103-mtu-probing-series-v1-1-a2809e725aaa@gmail.com>
In-Reply-To: <20261103-mtu-probing-series-v1-1-a2809e725aaa@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 7 Nov 2026 12:53:36 -0500
X-Gm-Features: AclHuK-b7qc6bzaZz7ltF4_Msg4vRZBtYtjjIeLFeqwo1Hd-sWVco-4G452TJu0
Message-ID: <CADVnQy=AHpy6UoiAFopRUmHLNv6Arw07PysXVijiR=qERuzeww@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tcp: sync MSS after enabling MTU probing on
 passive connections
To: echoowall@gmail.com
Cc: horms@kernel.org, edumazet@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	shuah@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, panweiping3@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:09=E2=80=AFAM Yongjian Wang via B4 Relay
<devnull+echoowall.gmail.com@kernel.org> wrote:
>
> From: Yongjian Wang <echoowall@gmail.com>
>
> tcp_v4_syn_recv_sock() and tcp_v6_syn_recv_sock() call tcp_sync_mss()
> before MTU probing is enabled, and tcp_init_transfer() enables it later
> without syncing the MSS again.
>
> With net.ipv4.tcp_mtu_probing=3D2, a passive connection therefore starts
> at the full MSS instead of tcp_base_mss as documented, while an active
> connection starts at tcp_base_mss. This has two visible effects, shown
> here with tcp_base_mss=3D1024:
>
>  - The MSS drops when the first probe is acknowledged, from 1460 to 1242,
>    although that probe has just shown the path can carry more.
>
>  - On a black hole path the MSS never tries tcp_base_mss. It goes from
>    1460 straight to 512, since MTU probing is already enabled when black
>    hole detection triggers.
>
> Sync the MSS right after tcp_mtup_init(). tcp_sync_mss() only applies
> search_low when MTU probing is enabled, so the other tcp_mtu_probing
> values keep their behaviour.
>
> The Fixes commit kept tcp_mtup_init() in a single place on purpose, so
> sync the MSS next to it instead of moving it back into the
> syn_recv_sock() handlers.
>
> Fixes: 4d83e1773031 ("tcp: delete redundant calls of tcp_mtup_init()")
> Signed-off-by: Yongjian Wang <echoowall@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e1f2d9765..c13f005b2 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6760,6 +6760,7 @@ void tcp_init_transfer(struct sock *sk, int bpf_op,=
 struct sk_buff *skb)
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
>         tcp_mtup_init(sk);
> +       tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
>         icsk->icsk_af_ops->rebuild_header(sk);
>         tcp_init_metrics(sk);
>
>
> --

Functionally this seems correct. But I'm wondering about the
performance impact, and whether there is a way to achieve this without
adding this call to the code path for every connection establishment?

Eric and Kuniyuki, WDYT?

neal

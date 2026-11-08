Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794166030;
	b=a0/vAqy+K1oeJgXPKdMd0nVpdwehYKnQP/pzRbnZLPb5KJFTnLnuobVfQpWyOQNv6HqA
	 oM8il99FJjfbKKTAwdnPXJIk+HqYZRRI3xQU7Mw2GfoesF7lxHeewLugYW9nub1LjKqQw
	 9s/wQLRv3NaSrLUp9a2khWKZ5SEvSgldgFcJH2CvhyORwOIRQZykElYZ2VlPvX1RiMLLH
	 D9XwG/uiWOLu6GqbTgOtGJuVlZs1+883e5gMBX3FxSrHrdwM6Q3pDpiWnNnrNQI20W/Z7
	 iiIlqfiSn5YsHD2U5tJKByBoVAaeKMp2sDgiLc+qA61vxMU46clxln3nNtv2m6/tOsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BO37IMunpFsRap9NM4xeqnXFrjMV86qXDOv6LcF5YHA=;
	b=AOPRAAW31jr3QUP9d/3wGWOG9BefcxKt6V9JWuhnfokHecVe+4kiMUbLBxcr6k578itP
	 wPygA05X1BaesCyNVxaPul5P3HaRU1DwLv9IEA7vgwBjJYKuOfBRFtG4Z5o6ve89iS3E5
	 rOn3cJJPF01bBJcOU3F/KSXaWNKpk2D1CSa24LnX6Oh3nC4gWYqoup1HGt57w8/DKqiX7
	 hri190ziqV1DIgLv1R04FgV23ePte76MbAZndehwRrstF1ZLAaWvdbw9G50UPNoWYMsFS
	 Qv/zjKC34RtD9siyx6V8iIf+AVen4r+ldsREBI6AVV4xiqCHUX1ZAIc6xVK47O0af6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="czutAw/j";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EC606A322
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 19:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75EC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czutAw/j
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-54492d8a988so46841cf.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 11:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794166029; cv=none;
        d=google.com; s=arc-20260327;
        b=TmhFeoNQKW9GrWbrh2/dhGm/QddmyBVen3jhvtxiwISTrpjkgYZyj7vOX84WKYU+2+
         V1h8+IqpxP7po1GbVRvQoXFRbYxSpj3P6l2wLdSm0jGqamJuCxe5oab/6QGWwQy4LfOE
         vzXr91oa30KGBvvp8EaTxtY8gKicSEGTqXFm6q2yl7gjWbRHHMGSNKqzPwvBgZ6tOJr9
         EQaJ8JkuAvPZZ787B1sDg+8M0F5OA+eNt6K0GQKDaOiFrnYozEg31B9bNHqcsd7HWDlz
         aXnalm3gl12aIsADefsrBVE+ZAekn9Z2YcQznE/JR7O0ZaFFkXHhP1wbR5+gn0hJtMGW
         QVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BO37IMunpFsRap9NM4xeqnXFrjMV86qXDOv6LcF5YHA=;
        fh=RJuiP7Qa+8jA/rvMoJZbqi41uxS+FutsBmB7m0fe7lE=;
        b=g0i9/dN/df8ud2jMYFr8bayZv1fHCAxwOUEu94YFAGloyex7+HDcNDotctSNI+4PyT
         LHvaC1n09krVpLIfj+GuW5pyITwP5Fnur+nz6PsmxNXpR1VewRbE3r5wVcI9HGabxmW9
         sKmtpNb1KLSlZ8J1hAg4QoqAmB1aUC+Tv+2NvNKVulnRtq8ny+O+dC+wfd/tGePlRjJN
         SAkF4WMIg7LaS4QBOk4dRVTF2NIWTxoz2GFYpRhpnSeELyulWXn280xmhf0qzFaV6NZA
         ApeAZ8VVVHrCdK/5JY5qCGuhUMCDIviMIq4BDhbyFulyHtH2UbUKRavp+gpM9GHcyulc
         kBlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794166029; x=1794770829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BO37IMunpFsRap9NM4xeqnXFrjMV86qXDOv6LcF5YHA=;
        b=czutAw/jdxttlNeAE5hjzfXJT8dJ0d3urmQJnKzcfRWAZR2oa9LY5teW/l9LiV+5zp
         iGm/vKnvU5qbpNbkDdDMfyiwuwBO9nSK+xNSNQhqcg1ACm3PLri0AtSCurgN/awEoVBg
         z5uj+II6zPHXH9ub9Unwa8ZMPEcpvuT1WmrJaxEoPk3MJ1GI3X/wy8JX6Y0FctFzRTpf
         dzg3KqZnmzLlkTSaM6HYMBQSczmEgITk4eq9lUSsPrjDG8TGbgZGi9zBgPQaeU1mWxsv
         hyHu3Xr1zxy+YZGMFFP8jBmBpSvyzT2WfIOMtXxuEtE6N5WV73zUdRCvT+8BKfGJs2+E
         86WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794166029; x=1794770829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BO37IMunpFsRap9NM4xeqnXFrjMV86qXDOv6LcF5YHA=;
        b=2BkzKdJHfXZT3c3nJ1a7VTWZRFyOSVbZkQEwKAoqLNY8Xih9iLRUaxQJkb9dKYc9qS
         5GgrBNBZ61rEhsD81zCATSDau02agWSyepRgUcZzdRWkE8f8JRsElChCXgdwxvyLdo7N
         fXOG+olvwS8iA3V+DaTtf4Zww6iw8Er9w/W8VeVpGsXg6CeUO8DOybQFGEEt4F2sFg5s
         DvL+TDeh95qvk0VZ7AylL+y+p34WRtsb/Nl1bccbXsF0VT4YWIiKIRMZUyT0vbT069Vm
         NIPcCcYEf6IPs/j/LEgKGtLq86T3CmcytS6Hh8hDC0FZhMW/vw54ZewXrYFbOVI/LL/x
         KWbg==
X-Forwarded-Encrypted: i=1; AL+hErETbezCRGRnYkI0TQ1LmG0xfcJ+gqAO06ULO/IBE9wENF8ZHDa4hBEJVGPsyYaKItemAuZpnKE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NVFZOVcddrq76KQvU1s0PrvMxbyoI49uRR887Ahb53jR5cWR8
	1qM/YiZfQIw9Vm4C7TrJnjfOZpuKC2tBJhhqvaqCqMCuDcEchAQpvwGx8n6lUNfCWrdEqOpwHxk
	TXVF4w3WfPxvKGBvZliqpKJuNLPYGfTUsZ169D4XJZ7q7peblgbUto9Ht
X-Gm-Gg: AYBFou0HCV/ayqSa7TVhhMgw+L0mo2aEGb/62zsh0hZkpeATJpDSUP9on0SLSlaqfhM
	q7KOkKHlW+LgdGTGVwUdr55yxy/IaXD+kpWNndDkk3dpXdsEX8qKmXMQUEJ0YifKyV7NL5yovDS
	a/U5vQzAR3XRmJKTnZQmMyEVhgPtBz+2ZoUJfnOow7ow3hgREZ1j7YR4FgXtMpY1hpj9AWC8Zeq
	qAuq9UsdaAgFNseRFh+0opJP2fBCVUMp+XO0AqZXJ2YzcM+GV3uWNEDjvH0gQ1zUrNLx7Ia1jmI
	55F1TlGRRp9yqZWrDR2LJwSG2RHmo7UWAVZ8fVpMtbMYzbJewJKFU5TXU47iI7e0zHuKfOmucdP
	JTF+aixMJ7xAGPBXaxrV2eNU66A9bek0KirC/xkjcMmkMHLetknR4BR5k8n5sIWbv3mE8KyNuJa
	7Aw4yLKrqEJ9SpSEWG4VJlvRQyRQ==
X-Received: by 2002:a05:622a:4a8a:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-54fa22f2df9mr26125631cf.3.1794166028049; Sun, 08 Nov 2026
 11:27:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-mtu-probing-series-v2-0-355d6490c3db@gmail.com> <20261108-mtu-probing-series-v2-4-355d6490c3db@gmail.com>
In-Reply-To: <20261108-mtu-probing-series-v2-4-355d6490c3db@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 8 Nov 2026 14:26:48 -0500
X-Gm-Features: AclHuK8zDFeFkG1trZEMSppYXF-uzQmF3qY-1kqhwEX4JZnkZedZbD6YsibKJOI
Message-ID: <CADVnQykAX6Fw8_86emqtTUDWgFzRd_jXTZKdDJLb0s8AUmfUaw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] selftests/net: packetdrill: add TCP MTU
 probing test
To: echoowall@gmail.com
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, shuah@kernel.org, edumazet@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	panweiping3@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 9:39=E2=80=AFAM Yongjian Wang via B4 Relay
<devnull+echoowall.gmail.com@kernel.org> wrote:
>
> From: Yongjian Wang <echoowall@gmail.com>
>
> Packetization layer path MTU discovery (net.ipv4.tcp_mtu_probing=3D2) has
> no selftest coverage.
>
> Add a test for an active connection. Check that it starts at
> tcp_base_mss, that it sends the first probe half way between
> tcp_base_mss and the peer's MSS once cwnd allows it, and that an
> acknowledged probe raises the MSS and leads to a larger probe.
>
> Disable TCP timestamps since the MTU search range is computed before the
> timestamp option is negotiated, which would otherwise make the MSS
> depend on the header length at connect time.

AFAICT with patch 1/4 of this v2 applied, that is no longer true:
active connections now call tcp_mtup_init() in
tcp_rcv_synsent_state_process() after the timestamp option has been
negotiated.

So I would suggest removing this paragraph from the commit description.

> Signed-off-by: Yongjian Wang <echoowall@gmail.com>
> ---
>  .../net/packetdrill/tcp_mtu_probing_search.pkt     | 43 ++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_mtu_probing_sear=
ch.pkt b/tools/testing/selftests/net/packetdrill/tcp_mtu_probing_search.pkt
> new file mode 100644
> index 000000000..65e466fbf
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_mtu_probing_search.pkt
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Test packetization layer path MTU discovery with tcp_mtu_probing=3D2:=
 an
> +// active connection starts at tcp_base_mss and raises its MSS by binary=
 search
> +// as probes are acknowledged.
> +
> +`./defaults.sh
> +sysctl -q net.ipv4.tcp_mtu_probing=3D2
> +sysctl -q net.ipv4.tcp_base_mss=3D1024
> +sysctl -q net.ipv4.tcp_timestamps=3D0`

AFAICT if we drop the tcp_timestamps=3D0 line here (so our SYN offers
timestamps and the scripted SYN-ACK declines them), the script should
pass unchanged with patch 1/4, and fail without it (2072-byte rather
than 2048-byte TSO packets, i.e. 2 x 1036 bytes). So I'd suggest
dropping that tcp_timestamps=3D0 line. That way this test also covers
the active-side part of patch 1/4.

neal

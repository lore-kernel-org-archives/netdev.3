Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A73D0BE1
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132702; cv=pass; b=CbRUFgAhRmRfEAESLBmoB3ywI3jLsUgeBtD+JAk+REUNIujxqobJp2SXuXQSfmjxJtNfy6r0LPyP4Nte20G3TGBoWcsf7mYVulSa/fyERqjGdJrx3vADM+NeOgnmeh8R+qPU3Cuoll87m2xCLrZKApt5ZpvcfX8l+/ldlCT0Sl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132702; c=relaxed/simple;
	bh=CyTiCm2m4yB35bCHchnC4FG4q2lSGsB9mNkmZicxkwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO4badlp8qbleNDg6gBdb2L75pOqpe29q40pySF9sfG/K/mgixFCG8hknNbHbBhIIZUq+GFPzRTZLs4NfCXC11MTEcm66/teBQ4ZZUjwjXUVP+rTacuhtUrpOOnWe1+alMeUotNPKNV3zROmV78xxeqzHLjGQOo2CuL9xRzCLFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXROAksk; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXROAksk"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so1680726a12.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791132699; cv=none;
        d=google.com; s=arc-20260327;
        b=kWDF1UeCBH98yfXaVDRqvepePrd+V6AAnpLVd1Etw3x+FyDoaRlO1+YXkNrBjJiyqf
         q3zajFD4Ykpy0c+kt05AncyH5kGUS0acDvCpXazNxBUdlWm82478X4NEUFZInZgHk0cg
         J1u0v7ZQ/GhlOvda6Vy96jKQNJLzMmOkx9Vv28tSkocXFtElPSBjQcWuOBoS2cE7yrlW
         BeSyrO5KyRyDde31psPBz1LPItNsvAdfohhNcZ0j2u5JMess+rxiYKjP965fNDhejldI
         DJyfFAhNgOJivgx8e+08cYiOWIkk2lPPNzWbv+wUEen4lh3Y6BVBqPUqiEHFCXY+q/m5
         J1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZsvGRH+8euiJS5TrBP/livxCzuTN3rxHi+EABC+GKCk=;
        fh=/Q1NS915AuIEKbZQPUZAfZJ++byo7fEsM604gbuvJDg=;
        b=EQ4ptBjcpoKOmjYf9IUegdumY75FIkVmJi86xvujZqmCDVb3Bxv8wWg7HAJidu6lJ6
         HzcPGJXfvQKz/L2LKMRFjSiIhRmhvyOb8ETQ2Se2S/7tiG0vyPQmjrHuzPVM+ktrZqF7
         ObX+OJ/l09rWU9FuB3H1AvuCWqhlKKivTdh8u3Zg1HOJmGtyk2RWTkI4kmXRB8pW77jG
         gFYtH2PX3RHlWE39c3t6Za7p5etaf2g80YszDUxk74sE8q1w7B8YXkSWhqBcmQw7KWZA
         uZp0Tr7ds4dvbMARTuC+OhyFhSaf5S11KwiMA7s/7qu4kjCS0okThFFoiXyzhXcL9ngF
         WJug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791132699; x=1791737499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZsvGRH+8euiJS5TrBP/livxCzuTN3rxHi+EABC+GKCk=;
        b=fXROAksk7e7Az2ubW+jdPKfT93p6zQKI2vm/mNcC+MhvSoCDZp2BovzadwJ2j4K8aW
         oFR1gBpjh9/iNBRX2Yec5OZMLrY3qZbQl7EUtK8QpHiSlf+uyX4lja1U9JF5hu8W61E5
         IsFIHVry9E66CY5N5GyLhfsFxPgcQw00V8ufcSJdqLc4qLahza3+81/q8s4Ued8Cusqk
         xF1TGGrzevKoDbJzUs/w7FRkfKQpdqmfgTJclvksu0biCuXMNmw/AlYREfaVRKKT6GLg
         UhRT+tSAb49VA163OkYL3kxNiKvP+jbHTIr5GKoLZPgchJ6g2TMNdyHIGEJ83V1JQsOP
         BEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791132699; x=1791737499;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsvGRH+8euiJS5TrBP/livxCzuTN3rxHi+EABC+GKCk=;
        b=0GMuzrdkc83NGv3426506FqkuniqJV5uGQXQX3zuY8FqONrWn9rLab16trdqv6B1xm
         lCX7VTcScVZkOc9RcVQCln5cRij1ViKdf+rCtr4eTfNt5rOZYl7qlsQDw4tKCafBJ4W0
         N5RP8U2IiFNcCDOWvIYaOJ0tB2fDrGT7OsMgvXhj5Y5ZVOiMumB8EzeqWpHDdsD5RU1f
         Hkud30rCSImTEs7pbKxKRflf/96mT1gYgXQkYggLaWPHNBpQDqJNDRYQaR6bTr5tlfB+
         IqGNMRBnDchdfe1dxBCBDBKWYzQ2bx1DpYGvs6TSrP1hDIqonKwGs4EVDjTrG00jpKn8
         dPHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMMxyjZ8FqoW7ehScfXapBLmPYf/aslyhEHERm1WXKobn3INuFdKsXFylg01yuLLE6+WZbfQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIftMmAP8axD0+7jaz7fPzdV54OmW4+gBFOXs+N7MvggZ/EaiI0
	Rgr5XJW431twZYJvv1XWuWAF57Kmij61+sBnU9/lbXpZFHMJOjdYmGUzj9zSoSVtf8AfbfWRkS7
	2yfhKkrOcbeKmxOAsvcRuOnSqdMSuZL0=
X-Gm-Gg: AYBFou1Z7+rhUBI4JVI8H4yq71QJbMHlcJg2lsqqQTpfwXKneSfZ18PhGVRqO6vZdh3
	CzX7kdl6in/EcnkJU97JC3vSC9lE+tMd2dP6hdRwg6YHSZkqqW1uRZ/zKBykuC6KYgP+EmjbTc5
	zk0oUAk/M57zMV8lbPO6ymOTQo/J1o8uY8vtb4/jo4k3+a6bwg4Jwb8sY7kdKJ1fe2ZxcHWxwUg
	FYizpCUeaDh5W7Az766u48vFxslBxbcC2NoTl63C6dxC08NKP7tlQXg4n48E2huN8FFNYXsr6ZC
	ANyT0+tdnwLQQKp4MnHgB8kx7obuiAZc7R/11/J19Y21ufI54YuoAlysJxk/CYHjmqXZQAIyLB5
	jdpTkgzto8gOIFAvMrhH0
X-Received: by 2002:a05:6402:4595:b0:6ae:313f:ddfd with SMTP id
 4fb4d7f45d1cf-6af9e2f25c1mr6851212a12.27.1791132698273; Sun, 04 Oct 2026
 09:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003153224.2683219-2-bestswngs@gmail.com> <cec4b256-da83-40df-99d5-44710ab8ea63@kernel.org>
 <701a85ad-2403-41ff-8ef2-a5a71a7f068b@kernel.org>
In-Reply-To: <701a85ad-2403-41ff-8ef2-a5a71a7f068b@kernel.org>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 5 Oct 2026 00:51:01 +0800
X-Gm-Features: AclHuK9E8fYQYyMgXuiqHCjN_0fJj63idmjhasBzRkzoK1OKyC5onamfPa8Ns-U
Message-ID: <CANgPUi2PE2oj-XKunpjVehRaZvtdi=covFtX0pgGgUnxjrwpLg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ignore locked zero CWND route metric
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, netdev@vger.kernel.org, kuniyu@google.com, 
	davem@davemloft.net, horms@kernel.org, xmei5@asu.edu, 
	co+71b6509cb791e531@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=884=E6=97=
=A5=E5=91=A8=E6=97=A5 01:09=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 10/3/26 18:10, Eric Dumazet wrote:
> >
> >
> > On 10/3/26 17:32, bestswngs@gmail.com wrote:
> >> From: Weiming Shi <bestswngs@gmail.com>
> >>
> >> A locked RTAX_CWND route metric of zero is copied into the TCP metrics
> >> cache and then into snd_cwnd_clamp. This sets the initial cwnd to zero=
.
> >> With a cached SSTHRESH metric, a later Reno ACK can reach a divide by
> >> zero in tcp_cong_avoid_ai(). A user with CAP_NET_ADMIN in a user-creat=
ed
> >> network namespace can trigger the oops.
> >>
> >> Ignore a zero cached CWND metric when applying the locked clamp, leavi=
ng
> >> the socket's initialized nonzero clamp in place.
> >>
> >>    Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> >>    RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
> >>    Call Trace:
> >>    tcp_ack (net/ipv4/tcp_input.c:4440)
> >>    tcp_rcv_established (net/ipv4/tcp_input.c:6678)
> >>    tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
> >>    tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
> >>    Kernel panic - not syncing: Fatal exception in interrupt
> >>
> >  > Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local
> > cache.")> Reported-by: <co+71b6509cb791e531@bugs.sh>
> >> Assisted-by: LLM
> >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >> ---
> >>   net/ipv4/tcp_metrics.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> >> index dc0c081fc1f3..ff41804ad086 100644
> >> --- a/net/ipv4/tcp_metrics.c
> >> +++ b/net/ipv4/tcp_metrics.c
> >> @@ -484,8 +484,11 @@ void tcp_init_metrics(struct sock *sk)
> >>           goto reset;
> >>       }
> >> -    if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> >> -        tp->snd_cwnd_clamp =3D tcp_metric_get(tm, TCP_METRIC_CWND);
> >> +    if (tcp_metric_locked(tm, TCP_METRIC_CWND)) {
> >> +        val =3D tcp_metric_get(tm, TCP_METRIC_CWND);
> >
> > Please explain how we can come to this situation?
> >
> > cwnd can never be zero, so how a save metric could contain zero?
>
> That is to say :
>
> The right fix is in ip_metrics_convert(), one time instead of at each
> TCP session init.
>
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index
> ad40762a8b38379e4ccdc505e3885adb8dfff763..50a08e592b207e85ccc2bb6f917379d=
e61af4579
> 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>                          NL_SET_ERR_MSG(extack, "Unknown flag set in
> feature mask in metrics attribute");
>                          return -EINVAL;
>                  }
> +               if ((type =3D=3D RTAX_CWND || type =3D=3D RTAX_INITCWND) =
&& !val) {
> +                       NL_SET_ERR_MSG(extack, "CWND metric must be
> greater than zero");
> +                       return -EINVAL;
> +               }
>                  metrics[type - 1] =3D val;
>          }
>
> pw-bot: cr
>

Thanks for the review. v2 sent.

Best regards,
Weiming Shi

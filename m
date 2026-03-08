Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45B223DC9
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939505; cv=pass; b=p+sVHAjg8eBWpoidIEHz8t6w2dLNGpGDOma1Oudm38pKjjPuNJN8kn27Bpja7jZ9td0woXZoW2xBc72Nt6fWXBRc8SQRbdBVIccoSf0dfddQ5qM2cMnzQqlBvwaeD4IetsNJLLZxJTOeGbwSHm9Yrx5IP/qmtCGkovWvfQrOkfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939505; c=relaxed/simple;
	bh=YwX0S+s/mH+NrPegj5cKLf+BpSzkVt8udsTCnwtOTH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1XVyMjb+1iwIAZ3nNJG3k89UqEzgDD1IOv7cFdQGXX+0+y1w0uEfLgjMSzaVs+0/HLV2yoydYVM39W7maO/5bNHSCbaSw/vM8NBpcDlZfO0etQXxpBeA75TdvyUSdv4NiuIJaYsTm0OKBKmmWcafMikzYYOuI3eUyt/gMxB92I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htKG29P6; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htKG29P6"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12732e6a123so1168422c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772939503; cv=none;
        d=google.com; s=arc-20240605;
        b=c86pve2FibEu+yXalMXF/5StO448d8afLrhQp+BNCSH4I3m76Xl6DeStIRBm9zFjfc
         Bgfw4qH0Soai20bZqmoJ76P1x05OvaG9lM+fkeOPqPZthmyed4p2ovmgSYUDgj39YVmM
         6gBJz/KFnZhFac1edL5KJqZcpbDO42m3SV9Yr44ZNtj8gdhITOL4LM+gssuY0yvorwSB
         iDvrD1B6jCHPwr3QkOSZvtEFoU3U7yCvHYLJuyIzj1M9dmHZvbA0g5scMZ76AWTyh8sb
         bvR10CBFhO/p0K3smzlQD1qm0aiGyFMYoZct6sMrLQZVgMxbhxg7EyMJQY6K5bYFmWiv
         JjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YwX0S+s/mH+NrPegj5cKLf+BpSzkVt8udsTCnwtOTH8=;
        fh=ALVilHoVdBURVbiwT2nTCdDqYZlAtOwR5oGIszLmBm0=;
        b=Y8GugdoQh09R8GDuV50eEKJJl5qdMIG+oX7w4jFZ1B1lAHMp6Bru3f+eNISvawzgvg
         8j6uDWXNt89x215jBO6ryCB8hgf6xqDBUiKNa7t7f15X1vuxXYoPbECx2+npferEHGbo
         6HagFrauCuaoAPs3gFHqmZE0mx9kOQ6DzC1ZPXZVEy4/r7NW5+bNsJbCTG1RPBsSkv+7
         o36U1DC2d9kslYahw9iPdYeJQgqXapPa/gQ4GihiOTqMp3gMC13gIqjWrXJqnQpg140M
         ATJQorzDaHuVorLLLeop8W5fxSsM6WeJP78CenAl/x3XIHAP9Ly2S6Y7rjuUvkbUKJjc
         GESg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772939503; x=1773544303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwX0S+s/mH+NrPegj5cKLf+BpSzkVt8udsTCnwtOTH8=;
        b=htKG29P6dWVyLDu23iVnA175JWFfeo5hNClEOVQa1B619CA+1raqEVzF0B15dOrhgx
         x7CRowWdKoLKbU6er3rCCvK/Rfzi8eIDIqmWpcaPrekmavswIam+isl3xjy/7XbdhV9p
         Lk7l/BbaoOcUwdgHEEqESOfqutVb+o2Nq/6OR4UFszsQ49Pghv8F2GohEETcYS2yJEMj
         Sz7DfZxXl02wsGQAbhHsrf6zNC5Jf5zemM9Ukc802JXTugvScX8ULPyxoTqapk0MT/Ez
         JHGmisZ1KxbnNneSyly5wKVCo7iAzRaaTJU8XspTVT6/QI6BYbnge8CqfaZgS6k564uX
         8OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939503; x=1773544303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YwX0S+s/mH+NrPegj5cKLf+BpSzkVt8udsTCnwtOTH8=;
        b=G2X7hXAsI/izV2YfttdC6kDRhVd1d0+mFnHlGgckrWWkhBYRZIrkoE1Irxq2K0nVWA
         mzKvaeDXVDE+gUQZhwEzQelRVY0RmYupZSr2Q8PohJgP/WsCdckW/hnJ5cJW+ynJnF2U
         66sZ1Sy/m39L0fr9J/SJtPpE4H/v4Ww35LuGmUWebP7NaDhyzU+ZBh+GiftV473rRafM
         1PT7dqp3FSuJ3nvsd2nHdo9sG8xkPKnFcnGle3gX1W8QicuqD5YGK7Evjox9vFX4yMq2
         e9eSma1PiGr2gHBfZy925X4hiNJI+/uB0pUjaPXScfSHcjMcCv6Nc9cFYcmQB5Dj8OAG
         Quxw==
X-Forwarded-Encrypted: i=1; AJvYcCXUHEPjlF+/jw0kXQO0rUVZjRSP0niGTJwmkWxCq+vyZTDtIuHqrPjbg4/Qg58brN8mxG2oX08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaAu2bJ2I745xqoApRJjF1RLzFxyb5QhQpdBlLKnK0nFn4wq6
	/6sZboYY7+CtkllR64l2pKLHvovXbwrfoAh27H+AI8IN0WaXjfaw1LVbddtsB4neWVzAMq44/Jo
	ZYadz8pmjliyDnSmAIIigDfmwOgXsDhXPYD/ZrPUQ
X-Gm-Gg: ATEYQzwSfW22y4x6itmpbU8MqDzhbhqZM8C0fi364o7aoDbSCzBlfpHxJ+wrbEAUtdR
	nPgaBoHxpN4WFwlSmxKmpYRvOWC45OyBhNWHvRFAAGgg9NzpxV3vhpb5co+l08MVnQTCIlaT60v
	yBQT+kBwLJUioqBfBonUBv2qje5zpCaAzcN9YW5fHYInOmKMMf7596lcdOYaJxkdD1uSwJJRRXi
	G2gdfJweec9Wgewkd1CdNgYtHYOvx1fv107zNCQrKaG4ztUoBd07hkOw9IuPdQmTyVJlPjqM/by
	gT2iqi4WjhiVzzcFFX4P9urzV7bck7/dMUBKJZxo0v39ucWDtzZw9w45GRGiExvuF5lm/CO6
X-Received: by 2002:a05:7022:f85:b0:127:3440:e5d5 with SMTP id
 a92af1059eb24-128c2e995e8mr2904639c88.21.1772939502822; Sat, 07 Mar 2026
 19:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306154322.1086539-1-edumazet@google.com>
In-Reply-To: <20260306154322.1086539-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Mar 2026 19:11:31 -0800
X-Gm-Features: AaiRm50R8vap_sWtLsO-TNIYEcQLs3dbXZrEzE_0JXzMNAqGwkBM6gyRmrJsZ54
Message-ID: <CAAVpQUAi7EskEmPOMonde=cO_7ashkqk7+iTb0zJMmOpwDXwCQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid dst->ops->check() call in tcp_v{4,6}_do_rcv()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 7:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> If incoming skb dst matches the socket cached one,
> there is no need to call again dst->ops->check().
>
> Network layer already validated the skb dst for us,
> usually from tcp_v{4,6}_early_demux().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

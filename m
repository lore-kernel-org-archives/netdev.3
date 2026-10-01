Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C10238D54
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790828387; cv=pass; b=Kj/GAy9hG4jTxNG/j1zXcMKav3AHSiPxk8j9dWrpVbpOpSUN2looksDHFLcH9tBm7GCz9J6YiwpucIpdcRYwIM5T3U5MlltGZACEGxrg2mI5rkXbI4b43Oc/9w3637xs2hBZ74TGAOh789FkPE3ZfHXIxUBH+kpmZHAWGgZOTZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790828387; c=relaxed/simple;
	bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc3tx+9htd7ZG90pL5uZ5r0czOS63z+FJjhqylbs5oWK/l7aqaXB4M6QT2j2/He7rQfJAvB1HGmyrV8syCJ/xvbjwcBgGSLAhHK02083pplNizd7mDe+XAJoRg2m+BVj113tIg4j0LlpuZSkZoYBF4C2GcGTkXF9eSgBZaTUYiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nosstv6I; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nosstv6I"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d06so4492339c88.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790828385; cv=none;
        d=google.com; s=arc-20260327;
        b=SItSONak12Tcgh/fsjJoUvywzlDJViZCIuOQWB7ANYL6yDZSrY8O3y2Ekguc1SDrt0
         FbxKAx8En2F+uX4tPP3oARKOf24eGA3pDVhDlaQSFb08BGifEH6Bw94lWCZ3L5FxvlID
         2lTvSWMNbtzDuFnHqBlix9R6INNm0YvJGgcmziVpkIE4UF19YdR3Hltv2NM97x6GHcIh
         Vn/kxf78lmc+ecfbHdYWVWXi3mrFMz8Eth65Lxiy8+W2NkQF27I25xJ+nXdJ8NfdLVao
         8/zGb90V4xmfrGjpWk/ut7pX/hTXlKvijY2nQOc0f0e0DLllyeIv9O9QbSgHLLnxThTx
         ptOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
        fh=ZjWB5q//eliunTuXq1GOsxllSC+MtoIuB7mGhYuwS68=;
        b=eya6kGIoFOwZC84Vvfd1y8AjWDX5Vw3SeIKZErLRRGBF/8kR/WEpSAUT/RuQ7Ke5ym
         nQURHk4FUCwSjGinB27dPxx5aloANPbjJb6rWnKp9ZZ3jB2QZB4HlfBd2cLSdqSoPISf
         Kbcu/lW7NkWwSC0rjL3NC43E67viFmqs8cFa8OzkT+mVGs972NPA3oohEfush9ujdWku
         GYeGyXTN2RIVr9MIgmoseHwSU1b2RxCbaziHAGTQ5ELl7Hslt6L4LVFGhGVvg9Rreupd
         tMbiLXBtVAZ+r2MG4al7G/kPGyVP3zvS53SCT6YAbgO3tC/pGf+QxM2yRnlbyandpfOr
         SE+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790828385; x=1791433185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
        b=Nosstv6IC2Cx2DPWSXy3kFMcJ0YGWTOTGNANPlu7ZTtISnj2FzwVrvM+0nicYypziu
         eLcbvTG2EuFXNi3HQzC3XORitoJxTF4QO4RU8VM6pB75tQwPRehBxRJhacu3+NHBd7xL
         Dz8OzmnVWiq+/B6vDO1Ub8Z6UDwkVegCHvEuNxP2CuskbiR0QI4sDrXSuo5vTepyKvG6
         aj86sqI3VsJ9ocYjpQ1voGVdH1N8gGP47OrtLqesvAzHuXbQroPPwm3lk6bbzc26EhtY
         TjTB4EnzK1keHYuprM8xODc3RF645oxTn7oKKMw0rrvjKLxEvy+k2EMUhiueGw8DPZmK
         YNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790828385; x=1791433185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlwyKjfoR7VaJB7r+rozJPFGwYih64AWsVmx8RjDE44=;
        b=rtljj4dHjcQndLBOOjj6MIPP/fo7JzmBaUUm8M8gi+UyivAMPG2c1Q2PpnyRbtZE5Z
         Trbj6MmAcI3p4J+FEfHp6g0LKpB0Kdlf87q34t1grsNCCRC6HzUcwstdXcc+EDFllVSA
         fHHpnkp/AtPNGHjLMPxYUKYqcvLI/3wSf9eLHv54veXcQ5pRQAM3KIV7tmq2Mv7XwU3s
         70yOvSc1oY29V9AutTQKdAYG4rGneoKArAPeZc+Qjys5Ec9PA1NEshfja7DRIz9lwdLg
         uY/Ye132hSL9CLpT3yglR8L3dyMEwps/PCJeygEX1v0VAKYNJ8oiX18q77eZHAzP6cus
         Kx9A==
X-Forwarded-Encrypted: i=1; AKwUvBxXeueRSIIc0yLM2gAG0O4t40gjhw1PgkvuqJLBJ8+jVi15aPbn9SQ4z89H5E2ou1KoQ/XTOhk=@vger.kernel.org
X-Gm-Message-State: AFuF++muHn8AURzM9aeEqQKlu9hAOLjTeHR4NmKB6g0WFqSBcWaRufwt
	cxsMO2qN3jiYc5nFsZ/NqD1vIequjVos8vOnU8ygv2XeT/V/ODyykhR3pcQmG4NU/Gpw2pUSz4Q
	dkNEVg5aNyy2KsXJNOu15Wyei9sSDh4zMgkg8V5aL
X-Gm-Gg: AYBFou2vgwNTVxYvT+h9q9loOOw4MBWbzSwa+TC/4sLtAoDp1n3y8Nl1hK3L/zWTHXE
	yJmYpVqO455FeHC8gwRiwzyd5i8ro40PDxN8vhD+KCnz3d03pb2NYZk4MNR9c3wTmV5ddvG8z71
	yb3uqEq4hu8fc1AvS5F//tfy/1B8ClwSEmHOKGUSABLW1OjgCd5IWjJm4F2gakmbuOU+xswDUR+
	BTEVbsJ+KZUyRSXr5SMvE9N/x1RVxkni2D2aYhztcBksYuJWeXOwRYHkNyyngcjiPOM4h/ek51C
	3nBKi96+XbmI8BgMaashPKjdZT6OMtUGdltnSZXOdu5iLuQsAdUkO4SVlGJ5Oi+fNCO5VzoCKEo
	9+lPdDa7pizX7Fd291SJWv6CJKAPD6h/N8W4Miq2KSQTVz4+wgz1vX+rj3bgBJ+yp9R4=
X-Received: by 2002:a05:701b:2406:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-14d332a2be7mr3924860c88.32.1790828383999; Wed, 30 Sep 2026
 21:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-5-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-5-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:19:32 -0700
X-Gm-Features: AclHuK9j8Y3QqvxsWyBt02R9nnTt-bXIq_uC7eCGDMAC8dhm7oM4Sg6AFvi_bSE
Message-ID: <CAAVpQUD69=MBzg7QcE_9rhzjm=QO_Jp=WU+z=ihFYGPoawrR+w@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded
> for a socket's peer. To make room for the struct pid of the thread that
> called connect(), listen() or socketpair() turn sk_peer_pid into an
> array indexed by pid type. All users, including bluetooth and the
> coredump socket, keep using the PIDTYPE_TGID slot.
>
> Nothing fills the PIDTYPE_PID slot yet. No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Technically, sk_peer_pid/lock do not need to be in struct sock and
can avoid bloating it just for a single user, but I can follow up on it.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7E395254
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013657; cv=pass; b=WX0NVChUuF7w78lm6OILQNmm7RJocG9Yx79XSyqhlR3MwoyyuZAw1gaQ9k5LQluxjJ+pWrN4TDYY5H4YHX/dk5rHhawFuljFGdDlimW9qEZxTEqZFYc9mWbSJgsN1FxROBwwdqUhh+Du3p9Om/1KLw0CM5jflYAZi9xrNLRicq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013657; c=relaxed/simple;
	bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ39q2KppcGVzNWfc90Ji5+is4ZBgQsJz3GnxIhHy/mlVjNVgnUU/SVbAyN7rW8FxRbqFupUxnPhf708P9M4ova7vQ8k+vyyt26hJwHGJ6+CzJP+oJ+rK9gqKmPXakU12FxZJCiap/yvvlnw/Rkv/C1w3pqq6pHMa8rTYzULb9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzRMhbT/; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzRMhbT/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-395cf2535acso564436a91.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 21:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789013655; cv=none;
        d=google.com; s=arc-20260327;
        b=BGjp7K4dmxyOg3Zzj2LZSnAP/CsQdDUPXtBQXAraenWusyZ426YUTzNDuoWAvjWCti
         vrrD0jjNiMwlvEqTUfBlIMi9N5W3IrbF/aWlVEJg/2vnXZ4GnwX6AGbO2DevF1+ohm/X
         0ZeHq21Dso6kteLsrL04YwawlABlrwajC9l1qREMR7w4ytcK7+0QMxzh9n1hTmaG1Ou/
         LFXsvBckOixbfuGI5Gu5QRkMeE4nAyiY+mHwsdZr7PS+AvcA2gCRdijGyTgh1SEkHwiw
         633ah/8AKeM19KB9Pqbhon5rQc4KNtGaJni4N2bqx8T2FDRWnylsRvezcbY8hdj9tPTZ
         Sxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
        fh=Gw8kkT2vW0C6/AqfSDC3MQJP/WVDIEr9LdSgaxcuVhM=;
        b=bV49l2uFkPyUHZ/4n1HdZwuBMwsM9AC0fi+NDSCw3fk+UDbMuPudwZGHKKOMovw2Dx
         OxIsf+2NfcOpNOBPeIVfIZ2h9XJF+DrKdyaUKjztAMjZTdGIG84XJyG5H+6QB0PKNNNk
         qb3ZZSIsM6QK/KtvCXOMyWJ5vQFq8e9dVfSEh80cvgm3HwHs7w2MiHvvGbKtNFpVIRRM
         /uHfwtib8rs9wck8F1spJ8EOGSWbjPeOJSwFKNu/zGDOjMqIZb8vIr/oASOpLwYotywh
         CFn/+hPF3JwiNOgpjJwEHVs8Sl9aBMqJNChIuxC+y7Zh6OdnCQ7+UvqtjWO/kSmg30oD
         3cQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789013655; x=1789618455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
        b=dzRMhbT/4WSBdYt4p+UNMBCgWiHNmOfmnCh/4EzpwuoNyUEKo5mAHVh1yeMjVHO6FI
         bP/muVJOLbEMT+x6LTLb6HJk7lbhlmandyGa98XVuB+QH9wpZxFMQyheLE3Ua4/2MaU1
         gqIKZxtBbVYAmywMp0QG1+gyN9QZaGEU0+drhCmP4XkMc929kFvR5fPWH/+BEhHEuhAL
         bMgr8D/YdfpqFCCAxqWQCfk8UwWMNsHduIrCzBmxghxN6/Dnh5AFzNoxvgK0bHOc4U+M
         qau5XH+uSy29Zolnjmj+63GCrsyEtVEq1cmpBrLp4HH1CN6KQs8du/qQJ/dI8+g+5hu8
         APTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789013655; x=1789618455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
        b=jUNCzH4ocKibkbGokjH88zBMYbFipTCW1A+NkXxgLJJwtHXCkrPhWYwZFbkqqIAzMx
         bmo6dgFzxx+HFcJJCcPPn9ZrdSmfJYbVG36VI1lX9zNA+k2itb2bfxsJAeC8aH87HY9F
         sxg9HOknJkE5tDtLa+rhPyoUOtrNzEQ+Mfo9dCo2zMxdJqAgJ9auwlBlZFmAMZqarci2
         2ZGmsBJRmvGzj5lmmFP5KV0pxjBub7G0RcbVexB2UIvVYDHfvTeAS5l8iUkQIRXJ80mX
         2saEaBuhRkqp0nc+4wlL0wo4on0MvzsSG4Cdhb06zcYCJBCa4uQSwhb2zxPHPkSN1l47
         aWZw==
X-Forwarded-Encrypted: i=1; AKwUvBxmKSZO0xQIGcHBA1mAbJTTSvneHGg/FtIvYsx1dSwc+k0CKCSqhPtapBhTvzEvbmZ1qxrDMF4=@vger.kernel.org
X-Gm-Message-State: AFuF++lPEVqQRtDPTxhk+5thNM52W+KdZAPy8XprbIRVnN80imr/JkdE
	kPu6wgUykDS3YfHeUAQJwzzLv35pdDynmmR3oH6d475jBm2N/ld7eIsXYGY2gMCaiF/zUP8uZ6n
	54KrV8E8Zw1blOulTtjyvi3XNjc5kEvTk4UObgO0X
X-Gm-Gg: AYBFou2KuIGNpp9qBtLN1OEGL33mZv6FkLE66Mk66RyNpocJWJ3QPcI6S0UCFIS7WoD
	6eJCjkBGW03fwjer/sXQ+R02bhJ6Mj+6lv5jY0UrZ0ie51m79yno6H5z2FtKRTbTVsrxdiyNKN0
	fgtNU77X+UhroQw/5U/faI0/zckXK1fbT59FMzxhy3HtWODngqmaz6KgK3Iz6v/1/SeOz4TPFBW
	Is9jw9xQm8YqxmUveA3wT/DlG8TxPwAMDGz6gU0pqFVIO5px8V1i1j2jnKurrU6zTWBr26nEufA
	kTriJiyLNJYC+WiyTiG5MaHiERXGC9FZamIf7CbTPi13YEv3O9jRCCFvVZsCvWvsZ1afcYLfR3J
	zhVfTACz0Lsogc284U9jQtsp6vLcUB7+36k6gP9D0ZIyAGwJKpPYgItu6/Qm0gk6NFaeYRNgP9P
	CTrmiQtAx4oMzUIsd0lzpZNbIP
X-Received: by 2002:a17:90a:fc4f:b0:396:669c:b5f6 with SMTP id
 98e67ed59e1d1-39d7796cf16mr3552487a91.12.1789013654775; Wed, 09 Sep 2026
 21:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org> <20260909-work-unix-passpidfd-v2-1-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-1-7bd342abb2d1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 21:14:02 -0700
X-Gm-Features: AcwNN1U7qcy0Xgw28VWEZVf5s3od5zIgdwEciEhER1kE6b7z6Yof-RR_xDF3wvU
Message-ID: <CAAVpQUBC0zZqv5iECj4YvE=oA2hWR1kbxiG6zOBBNkaALwQXEg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] pid: add helpers to operate on a struct pid array
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:43=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> We're about to extend af_unix sockets and coredump code with the ability
> to hand out thread-specific pidfds. Add a few simple helpers that allow
> to operate on multiple struct pids up to PIDTYPE_MAX with automatic
> bounds checking.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BD289E13
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585069; cv=pass; b=tviG4oAubOaE4uc2LI4nf7xm3svLq40f3rQs46i3Fainfll6PuUzXndbvxD5xZcvloxhnQNJs6lELKtsAw72rMvSkkhuJYD51UcCMBHVkyEEFlQ4Xgl4ibHtiSubXgH9UTYgQa5/u6pbzqWPk+JD7ELjqSx3bX+pqoIMH4fW9Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585069; c=relaxed/simple;
	bh=fhG4nXFbkT+J9F0H9mpjkaytKCMY/uVxDVHhPpBelN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVYHf3IOSH1Pmm62E7LuV722njgXxhRtC17L4IRkGSUj6AuTtdD2OTNQIW/DgRC1Xq5snUklG4UMoWgUmGClwSCpzBfveXZasM6fRd7YGI2iKI/2bjCPEiW/K0Q7t8aFkotzAL12VMFJ/IFRWKgPum9T6de7NGYy7i78ULXuaBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRiJ67W7; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRiJ67W7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1758358a91.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 22:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788585066; cv=none;
        d=google.com; s=arc-20260327;
        b=VAstmdkTZGpnSmYw3nZnek8woPerSNtX5cDtasSQPn1qWCtUJ+qWJSbgltKeiNZQwY
         ndtgO1d1i0EmhLhr4ZTdogD9/HJNfog2qyEemdqeaLEub/9ndZuhWO4wQTgTs/lMAvmI
         nEt9IuVHzp0FQAdgH8NRGX4bMAoByVhp7HlC9Ej8nRbw+W/BzwuEzcRHgrQrHhzI4eHR
         Osgt4n6/Yep+Ulr2NwoXC0CNvjFKrGcYgIgaqHqhddyvyn4Tjil4WrNNav3Q9xmrPzQP
         T/n8S6fV0iAQVRuJxDDuoa/DThI7q6fQ08v9bL9g5D3y/e+iu6Aep+D8smjtrIjSi+UD
         /T6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fhG4nXFbkT+J9F0H9mpjkaytKCMY/uVxDVHhPpBelN4=;
        fh=vWmZCV0vJNBqUO/dvlm3XZ3lNvA8xpmB9qoewzq6Dao=;
        b=sYlaLb8r3lKgsV7Tj6RpXILaLgV21L3XxsKCDYsw5h9aSmGN9mcvMUmAql+yW1JSxt
         4988KqwQUIQiVSCUKvwfDHb6j4v4LQzhwzMYBTzHfJ0jM969uGozSjR8gJmz5vRHMG7Z
         kLeYEvqfqHmvTpeRIAqzjIEP0N5fNrNP8o7ONVOh8kSH3N7v6YD/PTklZKuRlVP6UfMQ
         b+WqGaRp0aQzxZ+fLsGIWltvBM1F3VNQtY3Zgaiuffe41IAHSgEEosyeWqsDpU3BclCv
         bRdoUZYBJfhIYIdSZvifea+7TlKSxlMjTg6QQw9xRB/p1ZkKTrsRpYoqiejAWLfdIcY6
         H65g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788585066; x=1789189866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhG4nXFbkT+J9F0H9mpjkaytKCMY/uVxDVHhPpBelN4=;
        b=RRiJ67W7REQTt//CZU78ne+RG9IbU0wh/ihLavLbVe2n7ZZ9DMcCY6gHSUn7ieWTZt
         crmGmsCMnw1ZN46N+2QR395CQqQioyzJ4ZQxnkEyLME5DnnviR3YYn+CxZwHOcCLFlnD
         9acK3IpPqEaj/uTJMTnD/tt2EAzfEmCOy1DCx5kb2dj0QAy/ClOZeFobhHLLB9lUEfqa
         x9t46G97ptzUIWW4Ge6K02q+tw7NF7uqR6ArkE12FsKTLdUJUZIU61ukgFiuF/NI1tQn
         yKvegQY8rz2pRnZ/M9PjAxYG+xlSMwBjbDjYcKeZpMK4kQcepNTaUGCY+qUkv3dotmrb
         9lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585066; x=1789189866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhG4nXFbkT+J9F0H9mpjkaytKCMY/uVxDVHhPpBelN4=;
        b=dO2B1r1gXQ77oJ/qz8zPL2tHFVSAbPbLFVpgBTODxptN4VcfsE0vw40+Oepmb6IObd
         pIWSylwwuSZp8CZ+/By4gXfBz8/8fZ11qZIgJQtTxy3GW9H+nR1Ajd+8ybdJQBLZ9RF2
         R8Ub2p648T/hQheXXWQwxKmkRawMoOGyO8dw6imFZpfoHbskaoCZBVX/1yakXjT1qTd6
         Q9WMlc0OUq0UAXvg8+By+GzFcuLiZAnauvoOJIscZMVydWZl9a4gOAo4tOfwnhNjRj4S
         5QjAPguV5jXaos6Pv0K2QLztmSF8pZyhp3HgF7m1548hCfSxqFHL4einC1AyDPwOgIY+
         Q3hA==
X-Forwarded-Encrypted: i=1; AKwUvBzjEE3SvrBAwlok4m/577GyZkqmXK6ZdgyAChi0vcT5hRZfSMEMWn4DEZ3YbT8VBsR8KiYOIbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kHVPvGNHTcQZ4ZuM2mYPvHXEXlLlYtnCtqmSDyOIS/NvXgnh/+
	SMxswV95TXjNvyaxmCoq1GW0uF4SKTW64qbKZdwHCX4wW7CJDfoX2Jo1x+cQBxeAIoJy0D9AyC5
	fILK/xvtLgK/RtgskuuaLv49BxLXcNSJGRCm+GVnP
X-Gm-Gg: AYBFou0YDCYFyQiyCmhfDvKL4eFgC8j59KZARoWj0HXmtanny78JT9omr0JOiti8xOn
	FLFCxN27wefuFfyZ4IYb4HuIWH+ls/wtKM3jr8QpxYCQoVqgO3yBp1Exca/I4oHZPJa1eVh3sD/
	AkoljnFJm931w/VBzB4KOiofagiIOaELgIJoGNRTYLirk9MkNgfkyhii4d1g6HbVu+waPaiqOsW
	sJkAWY4R9KWxt7WmWgzzOqkYCDawSTQMco5EkoI72KoRyuLKGwrM1oL9KJUNLGNWRN0bkJE+tac
	ZHBx9U/5sEC2FukXgZiCMgVLFdcZFzQjyvACZduJ3+xrcrasdrSu1p6iFzxxK8NYNuOPXdgqAn3
	yyx168h8XZUTnd4eEXvVq6PMtb86GYo2zqJsYo+yzejc+N9kHyg2VYrQfoAs/4uVmdLm6Tzc+eo
	w0sq34blwjBZ8OhzQF0Pqxcf4=
X-Received: by 2002:a17:90b:4c41:b0:398:9bd5:490e with SMTP id
 98e67ed59e1d1-39b2623ac0fmr14663530a91.21.1788585065754; Fri, 04 Sep 2026
 22:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902073334.397685-1-ruanjinjie@huawei.com> <20260902073334.397685-3-ruanjinjie@huawei.com>
In-Reply-To: <20260902073334.397685-3-ruanjinjie@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 22:10:54 -0700
X-Gm-Features: AcwNN1U1mXJm-r99X5J4Z_vJiviQxDJYtqkupNfbLgXgGVTAVmVPzGaxcB3pd14
Message-ID: <CAAVpQUA_75Gj_=EwGp4-ENU0wHLjBEn+OCPg6OEUqy2TTXBnPA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] 8021q: publish vlan_devices_arrays
 entries with acquire/release
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, nb@tipi-net.de, sdf@fomichev.me, 
	liuhangbin@gmail.com, da-x@monatomic.org, jeff@garzik.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 12:32=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Replace the smp_wmb()/smp_rmb() barrier pair with
> smp_store_release()/smp_load_acquire() on
> vg->vlan_devices_arrays[pidx][vidx].
>
> vlan_group_prealloc_vid() publishes the array pointer via release;
> __vlan_group_get_device() acquires it before accessing the array,
> ensuring the allocated entries are visible.
>
> No functional change intended.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Nicolai Buchwitz <nb@tipi-net.de>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Assisted-by: DeepSeek:DeepSeek-V3
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

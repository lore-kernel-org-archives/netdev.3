Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58480222597
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788582820; cv=pass; b=HR9hIZsqEaygufl8vWbqvRJKdOU8voWowFIX0c45Vv2lNMAvpD/PYhigZ166HrjR2AW6Awh66BcxLUcduejXrQZttlTtedgb4GzwAECX5TRrt8CTbb3/O1RWOEwbFhIwinzL1llKlwAUnltnEaAk5hhEZJSn5A2No/gmhvy3hb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788582820; c=relaxed/simple;
	bh=Nccf0Jkaf28V+zwjc1Cc0zLcDWcCGbFdlxIBfQwQk6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCRyQ1jUsa5DQRXs2ETqmwbNY1Spn7NIioaDFqZ0jJIZI318Ka24Ge1g6eldG3UYgH7eeg2jkcWrI0eowosZzIg1kAicVbIzt13ihzAoPDX+Rz9YBkdY4H93nyDT1CEGyEW51NTob3ZRO4ivKnsDLpkd1yKvjw6PMo/AWMkPjXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kl385biL; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kl385biL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39682983a0fso1882990a91.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788582819; cv=none;
        d=google.com; s=arc-20260327;
        b=dYhKx4LdsPlcbU1lvwX9oEkpE1tqCE6OONPfBUgfFpSR9vx4A+SaLiYA7lkxnV1pqX
         +0m0fPLfy3kvhFyH+z/HqMDIWymIxphcXYzNzVD6EuFj9XxI0m8AZ9tNg/f7lXbdwgsO
         adtfjpuKjkoWE2HcGMz2PsFzh9iyuW7jgFbTLj2yPFhVMpvDgsX25LyYiNw/GpJrmiQx
         qdC7hQ1GZbE0ktQ4y+VWSxaWbUKzHFgI99iMxQaGqvG8cvOno6f1T/9TggeVmaJjP+vY
         6u5q4G5A+vV96ayHWgNrt0NGNuPI6ONbMazMK1BsWPFsmEr1tvCANoJAcf+jlH25MiXl
         TicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nccf0Jkaf28V+zwjc1Cc0zLcDWcCGbFdlxIBfQwQk6k=;
        fh=BhMh+0Qa9d5Cfl3pFqNrKr4GuhushSG/+GkVDIdO/U4=;
        b=WKMV++8NkVVLwnTT4wr0wq0GBwQfPP2RJiOG5zuIynmSJ3XUER4Vjc+IOwTLaJt1/D
         tt6Q7uvwGmdU3UrK12yjY6kIBRwLpdxibhwxT8+ez2+7d3xxLPwMkeZVfg0rKrpHfQrJ
         Biv47+4Hrhw4aJSOsWAsfnmy/Drz6+5T5cL/BD6yB05wKWclo85qxsRgjX5hbSXQiol1
         Z7XteFMYpg1LV1lgR8mby2CyXj8knGIN5738B8DU6zYW8Y3h6oBVHeKO7RgBG2nUYj9E
         s5k8iZFRZYIJ1mRKQuYKTDde+IEugX8Zlskg4Vf94ct+Q2PTanVwcvKoO+Ft06wfbmac
         c4wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788582819; x=1789187619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nccf0Jkaf28V+zwjc1Cc0zLcDWcCGbFdlxIBfQwQk6k=;
        b=kl385biLdZpeu/LLyty6dSxQoSJxYlI9qcQSTK4HPoVKwOE9PnMerZhnxXBK8IpLok
         JHjtYjkCFnlBUpf8LvTr8GPiNZrbRYhF9oFtAbgBRGyh6QL5rFzZD9MQf/hZomy+JxRe
         mnSvBB7RgEoa/hvNZLs372Yy5pw0XikVk+ZUzUkIufpoGb5LaTlCBj7KXDO4QvSw3N8C
         FMxUyHOJm6Q/oynEXgC9OHs4/LuIwNX6Db4AI21wCDLFZrJ9zZ124IacV2yldgBBbJRP
         oEG+msSZgOYSRqp8H5d17dbqgPARvf38OkNtqvuGXlZtPtMpuYLHHGWnUmTnuy7DYqbH
         1bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788582819; x=1789187619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nccf0Jkaf28V+zwjc1Cc0zLcDWcCGbFdlxIBfQwQk6k=;
        b=Qaf6tVL4Ptz9Ci7uqEFzEz9BcdCrUtXyoJmtpYikg3JIJXzXh2amJKkeIUMepq//63
         gEddZe/8ZVH7B5v7Bg8YVs2/vqiGITE1P0xwYAcLURIhNOPV7YNnLU0KUNuwnzx0eqf9
         57b5lf3eTRRXkXIyzYyCUQVWhvt+QnHPyE+2JJ319TS6/rnVzNgUGoyHwaismLeO2Tts
         hNzHnmHc2xgJD26Y0eVhk6O/dJniW06QMf4S7sNl0i0T4A0QiIIbheEers8CN22tEPH0
         QujejrsQ3LoN2rTbjr2Bjwy0wZHv5YBgs9UNjiChzyVkVjmrLrv3zLWuRP9U8UDHfI+l
         gByg==
X-Forwarded-Encrypted: i=1; AKwUvBwL3g87qFCgTT08751N2Kua7N16eM3cYKlLgFpy7cp2VWbhTzF1FmcYH3jWdOb7pU9w6eMzGY8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+cGKjoexvdYC+y8/GAGBwMbJ2Hu3GSdYbgUzeiKv4hRpYjBB1
	7ZWCP3Rl9tTs47AGMWq1MEHzlsB/x4gRmUDGCcMBP9mmh8f6FFm5xbdRkrhW2jyYtYUN8sqD+Z6
	Q3rPKm0wmbB/I5l+D/WI+Gv0HpqxhCSSnDalUEdFd
X-Gm-Gg: AYBFou3cOOwElfUX20T57aqowQ1ttsPoeceOuYUuHeOeqLnRB5O05QbyXeGbuVYH/+G
	FsUiTAjApfDJRRcyLh+rJ/CIYyMbCe+zbp1uUVuLbW3fl0xEHqtVlZzfD3nsG7RYSqHy+u5JD9O
	KFo/bl0O5McxJhrVXnvbEMkGPbADysn7e6cChaUc5cQnlhBjTVVD726KdZy0BxH/voxUOJ5IEXb
	S63rfB/rwfplJfavTA37PZphQOooHn3Sfo/WVnBuxvu46akrkckEKHmvMvUp8vL0bEfOBMTJfVY
	uOB7if5LZYszRe8oKZJx0LbgssL/n7npDD9uLBro5/TLOIhwtx4D5uUGGKoN/SX3ZAhbllZoADR
	MbQUkiVil8mlCU5ccmx/Ru56mA7W8k5Mu+zfAaecFhzWzTw4aEJnEUAu1xek+c9NCEuqzl0/AiM
	82mWPog54LBQDvV+q9zvDPjA4=
X-Received: by 2002:a17:90b:3809:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39b261014e2mr13676379a91.7.1788582818055; Fri, 04 Sep 2026
 21:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-8-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:33:26 -0700
X-Gm-Features: AcwNN1URiwTRBGsis2EIoLcONKmdyKwFSKr6Og02kRGFai079KXb4uJYQsEc2pk
Message-ID: <CAAVpQUCvJhKWN9P_bXWWgEEghP+99-sSBTqNGyhY22TE3oM9gA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] vxlan: convert configuration to RCU protection
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> In order to allow lockless readers in future patches, convert 'vxlan->cfg=
'
> to an RCU protected pointer.
>
> Updating configuration via vxlan_changelink() or vxlan_dev_configure()
> now uses rcu_assign_pointer() to publish it, freeing the previous config
> with kfree_rcu().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D044F85A9
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177960; cv=pass; b=kL8FGL8rZpVWKtDEy9rSR5X+dBhoyA9yls65eX/kpbWFYMjvvw3XhB+SA6jMJOEQ94sEeVIcFsFTRDrwU4Zmm9YXHRs9siLEPtlq9WECO6DkHfurlB9zq+uAmdMc5tpYZs3sPt4b7lWqEiBLTm5kgt1u6yrlGrI9wA1dtuKPIM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177960; c=relaxed/simple;
	bh=J0naHPaOnpDg2ShJmNsHR0YYIzm7VxWMF7m7wt3/EMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEcCBExNVn2puM3ujZx1S6MXm3sqUUrZKaK616VPn7KEP73YyqA5LyKZcUZKxSmzVB/PUPO2BzFwHH282UhKcdgJMQ2lkWPSOcg6YCFB7t/gA7Ha7hPG6K+Etnk2J+qRmUvANOVlDGQkI+/p4djk1QNZu5LZVvcmgLG4A0T1qw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NupUiLUv; arc=pass smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NupUiLUv"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b18f29e9f7so105790eaf.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177957; cv=none;
        d=google.com; s=arc-20260327;
        b=MVHCJX2kSTscboIrcwUGUM8jh3Zmmo3IolvLLtLuXIDzu3D4saTHA1+mNnJasLhRT/
         6eSoHBCaeKNG+cNG0gMgHezbAYK6J5bUs2YrkYIwu2Frkw0XYCvrGxYHgzmBGOlDwtqr
         lRvRxFVY9Ysa8tne3ysuyrxNbf4qN68iOwmHIs5uhWl0J1dLANb5ntqQgg7NzwsbSsmy
         +iTX+VFtJ4oBZeoqhGUktlaSb0tHudikdBUd/RmLzItu4izerma13/ro+KhYwPYEjzcF
         pWxFP+JU83/sLNdViW9UHjPmgfwkTtbEhVRGNH7j1feIZJCNlfAFmrc/qNDOx+S4H+ed
         xHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0naHPaOnpDg2ShJmNsHR0YYIzm7VxWMF7m7wt3/EMw=;
        fh=cBFeFkQfAoL4zRNgugCR9T7RWh5bQxVIMbq8iOO3gxU=;
        b=csC4xQo3+CYpjBNpjvqAwHlomPBsex6rRREthO7YwhtkPMTg9JN0JrLFQ+5xMq+sXK
         oF81xmQlULAmGiiS7y+BbhCFFNrMnFDNUxJZyypi59rq6f7+GI3JTUKE1H1Y9KIA7loE
         wKNxt5tsgzwf4dEfwFrT9d/IeadyKwii5r8BIgxbfAd9HGlG1Nts3ZVr/z4LlwSCsDQY
         CI19cJ0Z2XCElIpBfmbTth9FK+SOTgo+/an4BbZW2FCng5H8yKEhaVVQw/fiyqlkYJMi
         Eg1oN1EAyeZbvEYV92N7vJVxfYLIMPnLuKnofX8IzIsNcHURacqjgoGgwxvgwKXlW71q
         4Szw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177957; x=1790782757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0naHPaOnpDg2ShJmNsHR0YYIzm7VxWMF7m7wt3/EMw=;
        b=NupUiLUvsu7Z/KU+xCkZqtmp0YGwaKf2vFfzWTI3psJf+nZDndqj7oKzKwel6Oa+zn
         UJnv7kzrnHUMDBFcZSybsFOqNIFZbuPULSud2P3bNbP/TALLyXdEQxCjhi8JbJgP8k+2
         YC5fk/IwAQBmq+SFsJudjKD33Kg50M9NDqoEDaU30/Vpdd4gB0U0DccQIwLc1o8fw+t9
         jN/Ap6YtFAWbLyHE+zKF1cJV0/uempDWumF/e3nc0NkOXXjaZ4vXjFpMKXr3trUQPMxK
         DLGghUoUHdjiq0G4j3EItTz2pEWVSX0f9eijA75om7V7I09HT7QJ2c/+eHUEFrsWxwRE
         rq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177957; x=1790782757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0naHPaOnpDg2ShJmNsHR0YYIzm7VxWMF7m7wt3/EMw=;
        b=j5WtFcvJ9C6i7+/yWV4LfeQn4Zx6//CJDoJnXQ/WRGUxzQqdcZTbnrIkM1YOlGCjz+
         RljBF0tHUuDtwk1lTyW4G1z1L0QncMKk/i8vPtNwN+3YOrT1+gX4cY9VwvtIQpI1JOgt
         y7HVxg+uIKgdybyBNgZv3IfHd5THjIy5DBTm/XFs9URvesY9NHb7Z8YNllW9wrxZX5D9
         wauCiFxhnEFMyOSDfsAOd7Jf9PMYcMRf5cndNONvEPtq7zfw6tidynNMHJnUbH5R9zc5
         5VPLFc8I3n5Gap9QGdLBVoEy2UJ6VEjSdjdMHGDho4JcsalPPa7Am90+FYwzr9ZHA9YC
         1wfw==
X-Forwarded-Encrypted: i=1; AKwUvBxsxtREVyymdQgJG55WWQF3Ivzyx6PBnynsGBxmaH8hh75AcpQn6mF/o2d8YVnNrvSBf7QjedA=@vger.kernel.org
X-Gm-Message-State: AFuF++lvRC8OGl4SMoko6/jVHcNdrzFgPqbUnBSom2xWSrpDXbtc6tt2
	4SXBXCUg8nQZV8KtLLshegg3V3HazaITaw7H1yRj1Tr7bYFo/oVHxK3If0KxYHzWeEV4kGcW2Y4
	h75Y7BVTYQVuGAagEdDsdwx4BaiyCDcg=
X-Gm-Gg: AYBFou1f5LZB82RHqBABGx4fOl+sCuiCvrI0GkNMqjGnHkp3WqBGThNj4vea4PfUy0s
	u2xoxavgTX8NjIKHoM8Z3SfEH5rhM8znc1OJT2H9irdRCVpv+a9ESLw9oqmOlXK96FewGgv5YJZ
	bE7ZOIm/P4rcuAy/Q6l5II9tjGYnZyw0kvCIQyIRntJ0y6loHtsNJRK+Vcn4JcdRJwGuqvvq+tS
	qQGORlpZu9QQ7V7s/BV9SD40i6mAoMH4jGZ90jtSy1jR8VNXS2tsIqy6EWlF+dCe2tNUQbk+DME
	WJ9m+XRTL38dT8C48jo9CZ0j9PwLhN2gWpw8qNgbly6M1DYWO0PdJasXcNml10HbTGY3jbg=
X-Received: by 2002:a05:6808:1582:b0:4c5:6b14:a2d2 with SMTP id
 5614622812f47-4d5b89c0affmr3913291b6e.3.1790177956718; Wed, 23 Sep 2026
 08:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-netcons_ratelimit-v3-0-8e81b789ab37@debian.org> <20260914-netcons_ratelimit-v3-3-8e81b789ab37@debian.org>
In-Reply-To: <20260914-netcons_ratelimit-v3-3-8e81b789ab37@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 23 Sep 2026 16:39:05 +0100
X-Gm-Features: AclHuK-QgcIqftUxh16QhJeV_h-FMaPzu0_1xOVp5f_OWxqLY_Kv1c8tOFDe05M
Message-ID: <CAGSyskW1M6ZMrSK6hTOinHOZkHH1H15Niq2-GU13EdL2BtELGg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/5] netconsole: allow configuring the rate
 limit interval through configfs
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, paulmck@kernel.org, asantostc@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:10=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The per-target token bucket has no interface, so every target is still
> unlimited.
>
> Expose the interval as ratelimit_interval_ms through configfs. It
> defaults to zero, so a target stays unlimited until an administrator
> sets one.
>
> The write restarts the interval instead of only publishing the new
> value. A target is configured while it floods, by which point the
> bucket is empty, and ___ratelimit() only refills it once the interval
> it was set with has elapsed.
>
> Reject more than INT_MAX milliseconds. msecs_to_jiffies() saturates at
> MAX_JIFFY_OFFSET, which is below INT_MAX on 32-bit, so checking only
> the jiffies value would take a write there that a 64-bit kernel turns
> down.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

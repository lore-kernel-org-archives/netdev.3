Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE513C65F4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932484; cv=pass; b=S/3SiYRK0gRC4FKACRqC6modKi8oJxtbRH3nybeYzsj4c5CASqZzNMBIQr6FlNk7m8cqaa20SOSDnS+xOyJzEuja5lxqcqg3AEZppENLYI535ZLCD+NAP2e28Z3bptIfmQSLK6LIjZBKw54ZH2p7zWj9bczYvcz1KQlWacmtXmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932484; c=relaxed/simple;
	bh=5q6nOlmS063SvKK8pwkarrfZeEMnP1Jz3nMYjJ4gwsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWIs6S7fkQ6oGOCbwGLeFava4KFjQuBbnYF6rONw8TTVXci6t+0UTpJpg1CZsNO0rAM3pqiySMY+3m2vUUwiWkexnbgLZmhIRLPulKiZZ8W+jJz+YhgKVoSxvvL38lH19mUh3oyK+A3v46dlO2muO3MuQ/eVo1vmfIYAF5puJ7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXeVkbwe; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXeVkbwe"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1984638a91.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789932483; cv=none;
        d=google.com; s=arc-20260327;
        b=DPvbxxZwm5QzSabe53eyy+ZtroWyb2SlMdN+vqJJB0cJxKeoQ809HMF0TYsxTQTCiO
         UKF78x2uiGyi/S/Tp45y9DaGb/9CYyrckriSLHGjttL+pDC1mXY8pwwoTpnyBugJJb5v
         wNDonD+qtmn11LpmUD3FplMGuiQgWZydaVa4eeHm3jKJ674ZFtE4xtvI+wvtz74lMPB4
         pAVcHqXpLXNoajI9XVAhkbErEFhEGGBUOX2qpQ2kd3xmIz5YkYPLKZcBemeruCC6yWuJ
         iWgkUFYqm6sGcpQFI734E0hhAOAXQcliV5N1eCef/Bwtw+Cy6lOknmh+PpiXjrSA4h29
         4ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5q6nOlmS063SvKK8pwkarrfZeEMnP1Jz3nMYjJ4gwsQ=;
        fh=qOzPeyjN0wrRhnfKwoy7ebiVv4AckjnFalEQhmLpWas=;
        b=GzIrVQ6YR9b7H0ivZPSP7QoWMD9FnSk00Ka551f43XdXo3J6XCdH4H8CaujTzGucI0
         K1fGlDVjD4S0YdnTgIsUgy0GqaGg/pLn+WmBaHlaP9gWndvueQOZb6j6XJvG3H6E8+Gi
         m8ZdnO0WCMBYnFhPtf0QfxZj3y7c2DKjvaMusS6erQCYs5OkLyHTZJoqG86j37PwB3cO
         xAWF2hQFWuDyojPxcyFWz0Gckwy17v0GLGR0HF/lt7fOl8zHFC2qwimwKvc4VUMyDrX4
         fF4qwSSfUQeMmipMtotPNHQELAMCvYaZvvPd4zbrdMVpF8X/0LScBurADO3LTCRxXvUA
         6ioQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789932483; x=1790537283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5q6nOlmS063SvKK8pwkarrfZeEMnP1Jz3nMYjJ4gwsQ=;
        b=VXeVkbwe79aGtyXnXWCqsikoRMO1Mr1NaeTxA6xPIHJUr56ezUn/f04CQ9SWpjgS01
         6xZ/+KgClkHDzGkcpgovrfGaPkd0J934TAjUDowAdYn7bctHH7mO2uu88JTI9A1YsyU/
         YvqoHyxODf5qln+CzHjvPFwEIRwrDCal/8Y4qq3MRI/EAmuMMub1jIP8uulgRgz7AEIi
         q09JTsE9iF7x7FZWaae5dXxKFMVudGPFpLmAgbuR6csEcTxD+PAF669sLsnxQPkrrTvl
         SPxbEWcsEzj6COVg+wic+GfACxVjH1xCvlumLmUGeVJUANJL/CTVwcadHhMnWfzDKX0/
         Oriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789932483; x=1790537283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5q6nOlmS063SvKK8pwkarrfZeEMnP1Jz3nMYjJ4gwsQ=;
        b=Mwbk8U+RWPB6jMtvXEitjnHTdlxwubwTaI5nc7AiQRjwn6kzFoFJbZKlH+4nMyYd1Y
         1lJbYWiIAWGiw7Aa0hEOBOkFRIhArIhiTis/hQ/NdAOzY6d6z/2aVPY6mksNfOxsIP14
         4sifZFZ5PBxiQCQwbt+00Hfb+ATExqantvSQZcZ4j9xWcd64B9nqGs11qbROZH0GmNzo
         lol19ygjfDIjjMG8YOB+Sd5iAiBRUijRci2uJd1j22xJnGjiYxoJu6tjq+gaEmT+bZGY
         WUNaGG5RJ+o8M01+2swOOl6PEK8QkM1DhWqLZD9xQtuNfq4iarquVOpbGP+p3WFYPP8E
         Ok3A==
X-Forwarded-Encrypted: i=1; AKwUvBwnZX0H/E2CpeeLV2T4kjf0AqKAFsQFv8STnwrRLWKWPtoDpfCHnjTwbjdfaLFFBlll7N9JfAk=@vger.kernel.org
X-Gm-Message-State: AFuF++kbVZ2dkjOrVEZefn6tAGpjkeHyB1peeUth4kd3mbsPcLvuxnSH
	Ub8DNJA0BHSQ7IxBjf0WRW3rz/0HKO0r6V+Igq/A75c+9PQWjA8DOs5KgY/urB8rjGK6/jU9Pc/
	H0YlbU2uFiskKHyi49qwuuMW9HhG0/UFKH0NPlgj/
X-Gm-Gg: AYBFou0FLycpzVUAf7A7UAsDWPlg9a1iwsLy17n+8xEtsduK7HrkGtpNnSs+KSCdzjh
	HzuXAneWL8vN7dxXxq8DQfQJ95UwZx9ySFy8KTmRnSz2o+XKt8rVJlH4sBtFyrtUTyefE8QuapU
	gQCTrigqOsY53zR/swO1Nac7cF/l4T8o+sbT4v399+QZUqo10OjbarkceVVld0XYrfTEqE0UBmS
	v97Fup+oegdmeXJhesg5d71luPr8px9dFF1Y0rNq9SSWHxDUTjGMMWpmlRCAEvnd9aJdF+YRy7p
	bhIZNc4U8z0HtUPShhdu2avFn+f3eVoDUdmdII2nNE0sT3nu3LSRsd7DIGkRG19BupjZ9d8rwIg
	QptOGs4Ryn2WccPStFVlFiVasajaz3Mm9Xs8R5pxRpAofrZfZrofxf6Ot2529jVVvgwtbKjs3PH
	KjjgIcdOrkHwTr9ls7IjeK0RS3
X-Received: by 2002:a17:90b:3fcc:b0:39e:6c69:34d9 with SMTP id
 98e67ed59e1d1-39e6c693748mr8339160a91.61.1789932482399; Sun, 20 Sep 2026
 12:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919221735.3708237-1-benquike@gmail.com>
In-Reply-To: <20260919221735.3708237-1-benquike@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 12:27:51 -0700
X-Gm-Features: AcwNN1WcTcECHeuPJqJUvpb9g7RJVrtN9kMqByZlKkqiNCviuazi6W8b0DYzOYE
Message-ID: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
Subject: Re: [PATCH] af_unix: fix u->inq_len accounting in manage_oob() and unix_stream_read_skb()
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 3:17=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> When an old OOB skb is replaced and discarded in manage_oob(), or when a
> fully consumed OOB skb is skipped in unix_stream_read_skb(), the
> discarded byte count is not subtracted from u->inq_len (or is subtracted
> inconsistently), causing SIOCINQ / FIONREAD to report stale positive
> byte counts on an empty AF_UNIX stream socket. Properly account
> u->inq_len when dropping or skipping consumed OOB skbs.
>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Assisted-by: LLM

Please tell your LLM not to mix different fixes into one.

btw I'm tempted to remove OOB support entirely.

---
pw-bot: cr

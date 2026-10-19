Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3E25B098
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375038; cv=pass; b=qz8H6hhKUIWp21pKy/WWLbCYOauvKH3pGFZDtlyg+lAM7Vnn2Rmzt7GwNQZjk9gJqYR8RHq+oab6AX0LxDo/9jPgCVKrsJE/4u4ugKu0wnLCuJHkB9y6cpoFuhQRPFaXyT18eNFAceSYg9V9S+mcrTDMTymVnIzvsUn01JFROPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375038; c=relaxed/simple;
	bh=VViPh7OnXQ7WsZkAwbFjPgPYCAuEYt1IC/1sZX7Ven8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeV18Il3Ch8DPEYXMIB37Fapz5GJz5dNBQCeDbM0HOb82Q7El6GzxImZbO5FB5T2GORYjPXbzw/j4GzR3I3VyPkkHpUfoohus0pF0bzxEnBblmurgcAVgseho8CEtlTrTglWfPTb3BBsm7FIPT78ZVN9weYYKT8fLfx36GkC3TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9Fhstd5; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9Fhstd5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1687571a12.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 18:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792375036; cv=none;
        d=google.com; s=arc-20260327;
        b=ApFipmkL7S1JerEaOwmRObOlRAILWGrsNa5oK33v7+YbeSj7x+ndd6aCjpg4z180mv
         aNty+QbtdcDp3lFOq9xkr4nuvxEGeJakL56V5kEOPx7589e/vitERi6qAhzy1E9rz0zd
         uT3n00yJ3jiorhGYkufcO/GhgYycjULZQcv7lA7TlHtaJiv4N+N9nMg6EQUWpCTPUiSL
         vC7LTOBgvWAGPHbVz9GU5xsbjoZRkKWMa8pCPYYuIXL4j39bth8Ss3sJsK3iIJ01LLYK
         Wocd3VAe8IFWvowNiZ4Rmz0XwU67vgf8BYQoLCs6vEsTJ3Om3zyLrWxDvW/DJHZZEhhF
         1abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uu2T5CQkhWnsUGc0Gsza1QExCIhxJWw9L+EYhkzHHCQ=;
        fh=1WNhE4g2hSzuzrXYunWZ5afuNIChqF94MQ1JuyWgSDY=;
        b=NWjXKyX9rgsV3s8ZYScGG0SS6cXzQiQbHKRQaGNnTw9Qqe0vS5VsftPM+Uf01JHHTj
         JU7CKjMn2Owz6kVQwrbLD6bMbjh9DZLXmtEoDmgX4xrCNyzw1iJMuIVhRAf+A4hM+eRR
         +k4R24z7uTsLszKE4Zw4ZOC5dcCkTiVeEx9niy+Fzz7MsAijagufrR25hj1jP8PiM/nW
         jD3Kgeuly7qcsPgYNHt6Gi0xor4p65epgx9oTiIw68V6sHpQQlfmrU7UuUcAxR4cGQrC
         ZcQgULosH91PT55GXEawr/DoCzkeXU9DHDldINwYaDcbpqXi83nA9LKgl+zBot6Va23E
         JN9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375036; x=1792979836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uu2T5CQkhWnsUGc0Gsza1QExCIhxJWw9L+EYhkzHHCQ=;
        b=q9Fhstd56PDdL5hsKsQnp3CDKcDE3gemaB7OI6TnhXl1BY8HKm5i0P1av2w8GpPxFm
         K4p+3V+Y1/2SX4aaYogTMupe9NtJW97B1YROE9s3BxPHOKG+zFK2qj3/w/yoVSfDp7oy
         TA1UyecZpfPtE1C8AgFFldbTkdncr0prfHSK77VCP26oP1Aq4Kb7HyRYf7xUlEvKHNXS
         tnWZWKWDkg3gXh2XrIGCSHIx8DA7rWT5s63rREGjItdaX+MVyg32vIQ/qqqW12jmpuhz
         xoyt/baRKAsFAD6kNaRQfrGABEBPSb5HqObx9aF9OFqVPk9uNBhvO9MD3ZaR5E/t3tPh
         AQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375036; x=1792979836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uu2T5CQkhWnsUGc0Gsza1QExCIhxJWw9L+EYhkzHHCQ=;
        b=MJGVexs7oMYoiMwjaTu4v6I+eDYCHo0eYdowbvRzfOcQVPgnRCVkBz6g2SoMBVl9rh
         Iql26r/C3BOQJ32kUO//3FQnDg8jfiNTNGZniQHcfcSK8eEEnulawsQODARvTJqGXDB/
         JDltuIVfHm1v3XsSsL1mb8t/nKRqyx9I+kItsGQXXiKbJruq+4Gk7tHaLYz0RnL49Dsw
         AyRkAFSnklhkctKXQdRGYVmExl798vDV5GqQwT5Nk/n7ynhBpUbVQ+kYMACqG8gaUGCJ
         KtOKTm196/DWHmkVdxJshIkJ9ZCGyu6HFifJzcJz4iNUUQkn9NVyvktSmkE6N6X7bK0L
         k5Tg==
X-Gm-Message-State: AFq9FYJ2KyCi/2D8EaS5IHhVd9EoKxfob+qooaEnI1ALw3QyNF3WHef1
	9StW/PkX524BasvZefC23nzCAe0Nc28aIJe3v5d6CXAiaQeXs7lVcBBdWrtBB0ARdsRRbcriQnW
	Cah2GCqNMAoA9Mm04SJkqYC/LsNmt+OA=
X-Gm-Gg: AYBFou2+Z5x2YCc3CRMsBCFCEX/D9T7VJk9PatJDSz84hZXGzOt74z2+0kI7LDZK330
	VHED2SylTSXv9jcVRPRcAjoF0b2o7A3RAy/ft6MGCl8okuklbLD5JbNWzG5Iwc+bsjFR+Ih0yKv
	tQqb4ZiyeQYsrb1jETVy7YthRJhC01YD1gg2S8oT6Fl5dGIbkMpEaH1cbm4PA0pwUshG9suATpQ
	yJHfRre3GpO4ehjRfva2ZlyX2Um+6c8Dravm+1Jlc/OWfY4t18eHOkdTJgybrO+F1sNV63j8+20
	Sq1v/wAO2DGZFGrOJB3SL+1isloOpBUygWpykd9cEPLiqkzqP5IiD4BuWSylFofJEgk4CmiDrwf
	FItVs4gxZ7r/PRNccAQ/hrTEPTuLLDojSObcOhqnvPiqd1dA0aEO1BOg0th+UR6WBSppDP8Nwa+
	Qnb+Ubb84KsdUYiDxV8MucadQeMBpF1ug2gjY31+ZOwMmFeduIlC69KpZckkGlbCSwuw==
X-Received: by 2002:a05:6402:46d7:b0:6b3:af2b:3aaa with SMTP id
 4fb4d7f45d1cf-6b3af2b40d7mr2758333a12.34.1792375035596; Sun, 18 Oct 2026
 18:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019014438.199718-1-rosenp@gmail.com> <179237452010.3290.14331369140080870388@kernel.org>
In-Reply-To: <179237452010.3290.14331369140080870388@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 18 Oct 2026 18:57:02 -0700
X-Gm-Features: AclHuK-is_PhbKGnyMvnRjhFXlqCIscHeBJ45h-hIVHRpjpoiN0ZUW6yNuD9i8w
Message-ID: <CAKxU2N_zyLN7=MOvB60L8J+2nUfRZM10B5S+iotU9279JwLw_A@mail.gmail.com>
Subject: Re: [PATCH net] net: ag71xx: reallocate rx buffers when changing the MTU
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 6:48=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
Sashiko flagged this on a performance improvement for net-next.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAE31F99A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435832; cv=pass; b=ouBncbCV4X6vjmFpOLkElGV5A9lgi50g5gDkKaZHEtvitHyxp4Hq0nzVz6tzuspyTOI0QgzP1DRVu/OPplkSCDMDph7Pz+XVvU5PMHraNRUpBb0ZZr4vNoG5J7qnMzAIup+Pwh93k6Pmo7CuER+3FD4IyXotSnSVGlwVyzp8Ll8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435832; c=relaxed/simple;
	bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inSJDGoVJgOWVPB2+vuDqNZjryuLkhdHJatL7ympFnqFrXjAo1SsEoIdbNB9QfGnb6L6aOESRMTDT2knnOLK+Q6RuDlGrXorxnXPzIUnlV419waOFM2iSa6y0AGeHgYNCu3YAyFUkNKBEqqGsPy8HUU3GRWnLwQ742B2yXJNJYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+0M9OkH; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+0M9OkH"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-150f88d22aeso1779111c88.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791435830; cv=none;
        d=google.com; s=arc-20260327;
        b=YczVRbc7wdardhP1C6rEh3H7/57e5xDCT9f+IqqKleo1wB+9zmmQj2xgN86/UyaHpU
         ZAEMonNPABeVMSZC+L9MBxXhEA+ASoAqJ55QG45URFuY+sSlqbPR6gcaUu40zCgQM7vP
         eZI1ytqvsLLVbcK6k5aqKNaYZeOW+rR6/Rh4VALJYTBl6brKVu+ku6EdNQANkAUaBASb
         EhHaqMP3V5JofJvTE6DfpAU8HQ4CEvYjHtgVoZjz4CgyFcJhet5NTRxoaE8nFz3X74w4
         exd0TyHrUq43O2Ud+eEd30qB+lS+ioFJDGOMEWRNOkGcBFzkoF5G9CpoMJLKB0pPLfiO
         jAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
        fh=Xwq6gnj6QBlVVwY5EdpQVDYGBRx8NytafnEPrug/xCI=;
        b=fKWFsgWUR3jM9Fr1WNhRwZdSd77AP0RG2M1nNDmdHX5/YnUxqy9EufpG4c8eykBIVX
         +m2dMqlDn/lTXRxpeC+ebyHKGjDeDz7IX95oCoXW/PfKkVDyQwgKBbqfsgxpON9RKbT/
         4DehGeGVPiZZ9i3YVqYA+4qR6SWJUhRDQT+2M/h7Nn/Ajow+Gx/ZM3FwbQH8vlR8zpqd
         SDkqwIEAtaQEZPNEgLxMTUiDtOouilJXx63CJ8wvVS/gZ0QkDgwTYXpqxJeEd/rUeVHv
         yzQi1SiZCEN3XTaf/zeiR/LQzLAwXv/HkYxa23w6q4lvsVYzbGkUTNwo9iJvsp0cAk2Q
         O4Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791435830; x=1792040630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
        b=A+0M9OkHhp9Tget2ZYLxzNjBw36MSmHXwSc8DDzeiBAdV+dUNLENoF5uHiJdbjcGF9
         yP/F6UGOnOrROR/xL4TQwndA2vtxAKyGRI1oi1ecVNAnfmdhdtMucv/gGgbzkRtY2xzD
         ao9CagdV79GkOtCnM1V5zBWOAdRvVRxceA66HV9LKiUUTSSQW3g+OB8wsZk5zq9M+6q5
         IdXPkIh1uaDX1c0XnNaKXiMDGWMl/eFGbIdTslViMbo6z9LgT1vYuuomm4tLdH9FIRUV
         KZLzhChlzrYsSs+LHWOVHlfdB3Wiwr/B3VJc1j0EMTaq4ihqQHF8oTJJ/v4qZBKQxGZH
         Mr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435830; x=1792040630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
        b=Qt9UyuwlQyXb/vUSSVNUYybgP8w71LaLL0H1MoGUnFIjU67NrPgdelykndn0+Dnsrn
         bts1Prt2/nKiwIYn5mlfzc5VEEEMn4ig5rTp3LZdVAluEn8yQy4+Ur3ZUDaMOktsIwt5
         nMYERUxVaiGG8R/aRgktVAZdlHXlms6HTWarTeXGDJecMwZskSODgcUGOZHCQIh0zz+R
         F9fn59SE5phpfgOoak08Lr2k394vM5KTiG+zlSgyEusjnIarFcfPPQAaAFd2PupKvpu0
         jZ4tIXTBHrZkql5mv4b8rf8scpS7JkgrLhKGUEbJT9rQ6yZj6H+G8OJ+xaumu4mLv2cY
         JdGA==
X-Forwarded-Encrypted: i=1; AKwUvBxxjj6CUH1XrWvWQGnsw/d+0pJnu7p303TgnruL3SeQ6w1xtqRwjBYuvz8BgsSl/pk4nqeN6w4=@vger.kernel.org
X-Gm-Message-State: AFuF++l1ZSqAVQke45bjcA7GXOXE5k/7BSV/X2BQ2Ccfd9yh+81Dsb2Z
	snAp5pV85qZmwPh54sP2uxEVKmhsRlu/NnZB/sBitQhzrSl1mH+d2hprVhJUJ6hLHLbtDEdIWpI
	k3NzFpA+5cpKbBci3aIKxh8Rt6mvQPpqF7+C1Z3pW
X-Gm-Gg: AYBFou0SyXfUWW6N8+aXVp7ZM1MHrVRbhCtxzzDa/vy0WyiQpc6k4Rch75xYwrwVlg/
	voYfEo+z6EJmil/Rvy13QR2kRHh6wQnvR5vm8DBArLUyID8wZxdTmgW8KbXgb1p4nep4THtHTZm
	/dhPmdHop5Ewj2wE1QGdK6b7hzMU+hcf+JDKRDARWAjGQ2d8+UvpKdr2/dSUAxwIUVVAAsTAczq
	XXZX8ZuHatrtHNJ50R8MaNOd/O4Py/C20QvrIXnBEgvD3lDDvsIA9M6YlaRuk+5xh2ptLCGUS6i
	WDK50k6av/Kh0jxDkHqhPmFeSL2yRvHJs/aQtYPyhA+4TEgAWtC49v510r3t6ZvkTfo7OJ8trIv
	jBVHufV5qgLn0dPtolYJ2WWnLOkQOJenUxgVfQgACyhydficbzv+paUmd8NmAeRweUBan750VPY
	FFjkALyp2v8k9MSk8NXnu++ZEC
X-Received: by 2002:a05:701b:2602:b0:161:3942:c07f with SMTP id
 a92af1059eb24-1620a9a5ad6mr5199767c88.47.1791435829062; Wed, 07 Oct 2026
 22:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-4-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-4-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 22:03:37 -0700
X-Gm-Features: AclHuK8bNKhRRVOZdGlnqbecyJoiNU6TF2RIFHGHC-yiG-BKj77USuxK7OP9UOM
Message-ID: <CAAVpQUCK-AAQWMP3nM4maaHAVE1hvh8Dt0yLBhq9V_d9CVETEg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] selftests/net: SO_PASSPIDFD_THREAD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:09=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Extend the af_unix scm_pidfd selftest with SO_PASSPIDFD_THREAD tests.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Co-developed-by: Andrew Halaney <andrew@amutable.com>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

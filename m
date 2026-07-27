Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46317360ECA
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119407; cv=pass; b=jrvWmtThO4aIyCk+pQyFFOL9fuoEKMvzWMMZspOzPJNL4ou2sNlDJ8Z+JbON+p7fF6aWlYLOksUG4d2O9wCPJMAf76AoOeDMNqMs271GV4ecxOkXVNACu7zCC5FRN7MF25ohxKxEQEanfWzJypTQsEDCvdkSONgz2npuI5v4uzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119407; c=relaxed/simple;
	bh=ReuxBzaOtVHlCqApuW8p2jvia0Ckgx/jUCdpkh5ftcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1WUoA73V8o1jDxajxEsOb0p5J+lSyVE2HflWbbO9NoNO/oATzJGbvEAwHFFLSrVhOiycg2tpEmriCfCibFAcQuHH/udy3W3yFS6M7R6sJvFa/r2alT046FzWTTydxmaMtPXskP+ZazPubg8MI9NlzN4MFRhFDUb9pEH77scrTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZBb8ldL; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZBb8ldL"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-448de0cc236so1826095fac.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 19:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785119405; cv=none;
        d=google.com; s=arc-20260327;
        b=YQ9pqIuaUMrhIb6lYVzDIdgKkVLwg384H1pTclUFnbRukylyl9QHcZQpdd6UTy/Xc6
         erKOS0Jj+9L7N1Xhauw2LzfNYnSqTga4/X9SGkoqFQauM1cgjN61qs6VvrislNjSoe0P
         g0xwB8evH8q1EO4wHcmkQVbYTRd0E4P2nLlTq8K4gA2r5ri5lJ/6NFSMgpO7HvZaHFYW
         Io1+T6mrCDASRChe5ha1uV+lCMbYQxo7G1bt5DXIdXfY4vPDE5JjDhzzOIYKZYaLQen4
         0sRzzr50s6cbuz4s0NdroTWuVaAvn7OhtFp8Y/ChONJy97GiwEFv2YXTAOq6prWpwYPi
         uiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ReuxBzaOtVHlCqApuW8p2jvia0Ckgx/jUCdpkh5ftcM=;
        fh=crKn89e6MEl/uHDR/uEpdp9tUVW7gomi//VdaOgrgCw=;
        b=J5QidpYdiPgUJCchLNL5EH/RPvmCu9grDWcUzCZiF6LPY0Xk1yD7wf02rZpLNYv+Ix
         EhPtczgAd0dbx3R8voo+96lSRfpahYFFQz/3WO/HU8pZ4IY/+90+BbngoAkpNs4DgwG6
         W/Gx5zck/Qfl7HpsRQZsjyjQoT0QVIQ5jkxvH9XzvGGsqWX34/QeGD+zz/7fuXxFpJvI
         lwxWOvEB1PreBFD2f09IMgMgjRWCzc1bEPwgTxsQFVRct9OMH3Ylc3pRNAsDiBgZmiUH
         2D9poSo7KxZFrTL47zg20oKQD91Gh1erW5JHV4ZlhyBpjYa2jPfGiqGymqOcG/Qt+fkj
         DM3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785119405; x=1785724205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ReuxBzaOtVHlCqApuW8p2jvia0Ckgx/jUCdpkh5ftcM=;
        b=bZBb8ldL0t3mjlWCTWyfK8MnQgFphYJj/f2r0SUDTKCknCQLgZuZVV/kN8Zz3I84O2
         bab8ARQJ3buUsTgssVZ0fnTdBHnqoxZvrcjh4Hadxz46fuF+XewtG4Lklt6oL6/qB+Fl
         aVe5D/Z1vM3sV7wpNmo83cgoYN9XQA6CycJN6CKK7596zvbpQig33KbI9t2L95k227re
         j0Isfu++TebJ6nCZhaVSC5dXBRTIF68mf0OWGFWvpeQigKC1/aoberaelBtQff2ToDP4
         COW5NKHpIYR9SpHXkdPdURXsVRSAUNcG3Shds6+DqS/8ck9G0pDMSmx28A7IujogX6hk
         2MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785119405; x=1785724205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ReuxBzaOtVHlCqApuW8p2jvia0Ckgx/jUCdpkh5ftcM=;
        b=Gb2bUEopMn0tJPqKkoxCH+fOPUdel4xyddVLXbNzBpQ9ugiglxLNei0h7odZ5bIh7z
         1ieK7VKAiS7QmMMkyRK4Q7jGag22M7dB/AA2KQEYEETMrV0sbmOY4Nd1B4NRqBOFzqYa
         ZbgIUdT8rE16HCVDbGUEkASybpBfHskH0k6VIrqaGa11IZYMLgTMNdmbYJJCKln4RVSf
         GND93If4TmbzOkD5PdbAGxBp26yvJTieQtWLXUlz3+Suz0m/WhN8rCg2pIzKEE6R6hst
         RHm5y5xJJ9JI60poEVmHgrCuB6XNf2VVeX/uKxiSFAyCAyUGkTj670dWOcsy7kj7RYsj
         x/7Q==
X-Gm-Message-State: AOJu0Yylj85Byc5npVDGAKcVRX9UyTPZonektOZRPGuJDpCdUE/ChNAG
	DdYE0kh+AMX5+eChsoTbLbhlXPEt6h6MJ42ZMrOtVFp6G83KPC6dttcTJk9ReWdraYcP8BHmb76
	0k/55k6IbzVvy3j9zNVqKjTXvmPok4mk=
X-Gm-Gg: AR+sD11otSrDB6PA4ovDqT0Gm3UYjkUkKs6AkI8bVjKExk4fpuZkVCweNIkc3zBHD59
	sT1v4lFQBW8vDR8fW54ZrEwMoll3sTUihy43u11mm+BApm7b8S1xqpg9nP3GaRS1erKc92i9ol7
	K2zDbh0/4b5myDs/+iHRtf0LLHwGIiRLF3mdsJnSj86Wnod2nL2LDTg6s8VT9COlrrgtqKc+Lfb
	9hx2grHXMjdAhPxKqsuDm9H+68GoYo1WYkTNzWTNZ3M731VSXH49f6yROKqpNM1kUQA1GPw
X-Received: by 2002:a05:6870:255:b0:455:e2d8:179b with SMTP id
 586e51a60fabf-457f239e7ecmr5805728fac.7.1785119405128; Sun, 26 Jul 2026
 19:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784645321.git.xizh2024@lzu.edu.cn> <b196f448f8f7e452e0f6d1d3d72ba57b5f25eba7.1784645321.git.xizh2024@lzu.edu.cn>
In-Reply-To: <b196f448f8f7e452e0f6d1d3d72ba57b5f25eba7.1784645321.git.xizh2024@lzu.edu.cn>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 26 Jul 2026 19:29:50 -0700
X-Gm-Features: AUfX_mxKTKNmroxafzvlExPGKlNOvY-hwVzokyyleY4dEEJ4zjqdQcKfiLWBWms
Message-ID: <CAHsH6GtCD=PC+FzmhQhdPPypHo+8v8imzhmyTH2YvX3YF1ZJJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] xfrm: avoid lock inversion in nat keepalive work
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, xizh2024@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 21, 2026 at 8:25=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrot=
e:
>
> From: Zihan Xi <xizh2024@lzu.edu.cn>
>
> nat_keepalive_work() walks the state table while xfrm_state_walk()
> holds net->xfrm.xfrm_state_lock. Its callback then acquires x->lock,
> which conflicts with the delete path taking the same locks in reverse
> order via xfrm_state_delete() and __xfrm_state_delete(). This creates
> an AB-BA deadlock that is reported by lockdep when a NAT keepalive
> worker races with SA deletion.
>
> Fix this by splitting the keepalive walk into two phases. First,
> collect the candidate states while the walk holds xfrm_state_lock and
> take a reference on each state. Then, after the walk completes, process
> each collected state and acquire x->lock without nesting it under
> xfrm_state_lock.
>
> Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP =
states")

Thank you for the fix. LGTM.

Reviewed-by: Eyal Birger <eyal.birger@gmail.com>

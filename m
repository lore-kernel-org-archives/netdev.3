Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215737F74C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939748; cv=pass; b=E9cprNGqax5bfT+Q35gp4zuItHe43f4zAOJlMhc3PoqBv8oXAID6WeNjlV/15mKrPrSiQYr8afbRoFk8QQcmwpVQuuxQOCvGSMkxx5kGZ8YMzMon1RQ0OFuheG73iuUgvQpRYyZShzd4zZovnqldZhnpJIf5sS0TPKpTc+Ozag8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939748; c=relaxed/simple;
	bh=PBTXPiYdjm3vlQmsRzLNpMwqKaxNZRd51NNDLZRc90k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6HNkKb7SionkUd3yM6lZ+o/UIiWfXdyU3ScU7upth1n289EBirerEmfoG0jib+iLZwr7yNADoc3TcJYx3FM7C7sB6M3AS+l4CqqxMWJei0iNL8dcmIlukgvb88pqwkR1Iazbl4+rdqpGmmx/gegtDJtaUTQGNrcytO9EUTYkzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COoO2U8O; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COoO2U8O"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4afab06b734so61683b6e.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 07:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785939740; cv=none;
        d=google.com; s=arc-20260327;
        b=GmytAYMaRjqr+dPemusNROJ1eeOPwZ/k0R3h5Ink5thvpyGo8ENJEzjIAAB/EN2vMu
         C11MSjnGiHRfuhzpCcGcBwIHNDWv+sYhvHQoQPKDgsDsKsb/K4kgwN+WPsXPs1VchPXp
         8OefEo5oxz5gyrcl0RYv2ZbL3WSI1ctZDFpxDFcRcciWq0WJDcs8+Mrjoj0zBTnv7pW9
         fxxf+1KEVE4U7d03/lZYe4Z2WXwwpL6a0KmcYz9VXiDSTQte6eMx63e+9kAV66mTfGCa
         NPdqhsIUEYi1GT9UcEwr9s4sNTOomEUldXDoPm3fBafgz99KA1/xVGgdqN30dQJA26pF
         a74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBTXPiYdjm3vlQmsRzLNpMwqKaxNZRd51NNDLZRc90k=;
        fh=GiLEaGK4nf8l4D+BDNX3CrGG/66Vkbjp2Dr1HhappQQ=;
        b=UHw4BlUBoOx4jX74xv3tTk8mH+TB6RyzT1wj1GzhSD0OZDc8NbI5ap2F+Klcf0N60e
         1OE14sbIGkfBoT33mLNzVTcNoBIThxLW3wecQCBbSxqbi4xGOgqeo5n7h3v/+qAxbGjj
         /nIQ0KpMRycqtVdjddeJgtgp9Tufv2UvBXCyE70cTqxZnKB3MzAeo2V3RXIWJ6BymROW
         Sus1BpwUxxqi7eXJOVlvoyZ+RT/x8o1NdzTKaFsz94DZq2YjG6axmVa1kscxcTOanvgM
         YF54exbaP+ghtf3lt7rlTaAWqNi+J3/A8IR2EipINqRHmJ2K4l7Wlvy6/MZ/Qep96MPv
         yL/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939740; x=1786544540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PBTXPiYdjm3vlQmsRzLNpMwqKaxNZRd51NNDLZRc90k=;
        b=COoO2U8OjkiVkhgfoS7++u5iBfYDAKH4nDzXzAdi/RivU8d4C9NnSJLYwFXgoFDq+y
         O61Gwr1GNZjhOSOX/dKZo+7w1A9rU1mNBWnQy7TMG10C0niFzQ5isHs5K1xSvQu/27/T
         ZySFyot/VDbOJ8lEMuag7404blne1uTLbhvFeuA4/95F6VJGm3H6vYZE0RKkqUsJLRSA
         gJPyOpRRwtOEwk8U3hsx5ZAFiOqjmB/CO7xp9w9oE1iYtQJdM6R3xpUeHhxqRZ3KE+Zg
         yJaGCQ4ZhIj+OQivYITgVfYpUF3FwAvEz/JYyu6kGubBTXV7AUgQJbZvulnUmgAKaduR
         8mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939740; x=1786544540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBTXPiYdjm3vlQmsRzLNpMwqKaxNZRd51NNDLZRc90k=;
        b=KBq2syGSnDorINLCnLb/KW5sqLOzi4pnAjTvxYUWRuOUFPoJ+/0eZnCr9mGEOyxEhV
         LqISuZARD7IZFINgN8EJKJzhgS/AAQsGN71tELqLMjVeVGFJLCSnqlCQL4m4BeiB+aYz
         hUHAhJYYl+JvLTNjgKVAC5mXTXgKxpDCvJMkicA5kDpfmFGzrjk7T7yPH1foV4Bdaes3
         pPbmJMqZWIHUpqyCoeoHXxVMcuOT4wsn8G62g+sFn2I7CWyDe4SkMwYnegLEwiWsO2CG
         Ogp+uQzpjipSvhlMKsdEfXihcUJpIUrKbR1ItWfae8zLxqfb9gdTV9yqY8TKjoJ+5oJL
         v8ag==
X-Forwarded-Encrypted: i=1; AHgh+Ro0c5116IqlmyxopkYLE7hSju2mjwmlu+uFzyAQmqgIPAHyJld5MS8mIhG7fXDPOIOILCZwZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QXNKUCLgVsljjrmw3Fnw9n/exOsia6Bxd9fHrozDijLOoOLW
	DsiO6bl2Tu6QKBk80g2crWAlo4R2tKD0tBi/qfOz64G4mXrrxcDnfDiir3g4YwcO5vtAlXOkP4z
	wlpCjLIjiwYQdBdQyOfQgn+7zZFjqBHg=
X-Gm-Gg: AR+sD12jssvJrrakNBCvoZEU5VV7nUt/+iuPap98p8sW9EZHdQMU1y+8cJefkBkbFoZ
	7YxjAc8Yb5af/BGxYLYrvqLS9613wTfIZtAGPrwYhW5417gjTavMWGMaogQVsR6omRbHIDZk0pT
	3qilupmytW99E9wwjYW5/Zeu4DezFWLwamDKewMXsTqIWC1dyntSVxpVa257weTEjEmLPuejZny
	o2GzI/qJROgG+o/AOm+f++sJo1P363rROO2ey8Vt/NYUnsTpIuroqGD8pt0Uh0SaHYwPHnoF6J+
	ltLolRNAAzVjRVysgRDPTGJIRM1yLmfc01ol4mstpgS/rv6BGMOdaRLPhIJg
X-Received: by 2002:a05:6808:3082:b0:4a4:82b:2a35 with SMTP id
 5614622812f47-4afadefa686mr2996765b6e.1.1785939740248; Wed, 05 Aug 2026
 07:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-netcons-userdata-rcu-v2-0-c5e80f6a7a46@debian.org> <20260805-netcons-userdata-rcu-v2-1-c5e80f6a7a46@debian.org>
In-Reply-To: <20260805-netcons-userdata-rcu-v2-1-c5e80f6a7a46@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 5 Aug 2026 15:22:07 +0100
X-Gm-Features: AUfX_myEBJXrwCd_oNjePYEUGRCdQy9tXUD1opmu4-BqJqeTjHWmE-CrsEfGEVM
Message-ID: <CAGSyskX-C3vyySs91KEUEUczGrwyxH36=UVN_chte+m-k_NAvA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] netconsole: publish the userdata payload
 with RCU
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:59=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> update_userdata() takes target_list_lock to swap nt->userdata and
> nt->userdata_length, then frees the old buffer. Since commit
> 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> that lock is also the console's device_lock, so writing a userdata value
> from configfs serialises against the printk core emitting messages.
>
> The buffer is immutable once published, which is what RCU is for. Move
> the string and its length into a single netcons_userdata object and
> publish it with rcu_replace_pointer(), freeing the old one with
> kfree_rcu().
>
> New userdata design:
>
> 0) Unify the userdata fields into a struct netcons_userdata
> 1) update_userdata() no longer needs target_list_lock.
> 2) writers stay serialised by dynamic_netconsole_mutex.
> 3) reading userdata needs an RCU read lock.
>
> No functional change intended.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F43B6BFE
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684158; cv=pass; b=HvcTu5riPWpt1kUKb8kB7gqIEKZ5WU1+U16qhWZwU5GqQrpHH9/aqPYpBxfQ6qIaTay78szWtPwk3C3X8oQ3Tgpd3Lton0OIqkDJIrdYj3xMcFyiaouNpAkrYQ0gDgXIZcZKxN+hagWn4QwI3MuhS3r6orHp+gRb45VjVciDnrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684158; c=relaxed/simple;
	bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew8WEXXH7DiFqkkWxC6fUvrvKkv8VjrwWH5mXgg+7FdFAcI3IS3Dr/sLNZp7VfHW8ZgBSyrdSnK5TtmSEHp8U5ufNh2CPzHyjKcyt1ght7Z7DrOzE0GjTMWOPHrri9bixXoGoRd1cHNGRctRywf5pAtBUzggLecGHRorviZlL/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf1QPyWi; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf1QPyWi"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a5d24ae3ddso13960a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 11:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787684153; cv=none;
        d=google.com; s=arc-20260327;
        b=rW/bizRWXSE0RdS4i1154aaIAEyw5fiMtCowOrsQia1nv2vk10YxMbHqiKBdPRZHRc
         rGYYPFQlqu8xjcbRYFqMj4dYurbOwVI8kbH5AdjckCJRIbd126rK50PCfv6JWCVgg0wc
         0KnUua7DD9DVK1kFvuZYM+tXqrjrQvd4O92BoiIWWlcVr/8hNt9Izs3MayRdoGK6N4CL
         DmNtmMleY/OQGCqBKTQK9vAfYXnI7PIxthgbGuxaZmSJEMntrPGm826VwMUNR0R1M9pt
         aE/DbUZdvqKmUQEUScBLjEuPptXVFcDogMCtQtWy+wZTFTuRaluId8LIIUMZE19eyYMB
         Rm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
        fh=S4WAcTjKr24hCgjH/KMAefVLWPBbRLqV8UWsqIXPNbI=;
        b=eeTVG6ykDiAaxisNEDzVgP/TPBs4wU0Y64P9OzNvvHY4vP2SWT1eNVaugl9wQWPfvp
         vWbS2MSqOv0vBzTTQzHAO472MfCtK0J7P21AcGeAVEpW7eVFDSv1GS3BZWIFIiVLRSkP
         oz8DyDAWzSUPZGZBOlZQzX7tAHm3x2eT9uyhD/gNtYCCnJ/yCqRhK3NlN6DsETsAjMz8
         c4PuVSv/xkKJXzJdBrIR6Q3mv155LbqRan1IlXaIrH3stKGbHQVt7oiOSAINVCZjftHe
         AQoVvfkjMsS0dnGe6u5JTpIU/4Kwp7JFOXet5PIf5xiLeUsDO/IteZWBh2lLQE2zith+
         eAfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684153; x=1788288953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
        b=Jf1QPyWisWyPIttRGdPTtNtUYSp/tutRZ6N4mek/Z5dvf3sZgfh//tluk1J2uJRAKp
         TybJdLXZev09NrkfYz3OnTUpKujRjuZtdlWOlSJ0lUsKO+Z6gwwLt3fOLBcn9a5Vnv07
         R+G3lSn3/QsMPHTOTri+zYE/iZh6hE9IsKB9ztUjByf1x9ojJbcPUcLL6u2oV76kggsw
         PHBumlhwklx/XDt9jnpvL8SGS9nHUDY+8CCnNHJQhT+D6WH9zXdztrJMmIXXtU5a9+Sc
         uB9kd5FvFGmaooiBKZv06VkSYCkAZ5WoTGd+tjBexljWx+mB0XdIOkixWvDx+llUnPdp
         KD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684153; x=1788288953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oafa7a3hagVsWS8SJ/kkvtcYmScAQTKcHCN+MR5JqiY=;
        b=dSnmvdbfOW2gjXzILOt/9clBPixpioQ4c4hEzoryoVrMnQzrviAOTF0Z07CGfvBODk
         SJmjZglumxg/mjN/RETQUi//490TzcVgOfLO7WnxhdW9Q1ZF4Mk0zb+W9HY9Xxkh4DvR
         tKCMM/Du/j9ckKXohXdgv1XVe70NkS0N6k/i/YfqXU5a0yxlJaDOlYsgzO4WHIdCrnoO
         GC8+qjVPWKavS5R/jEqdOGKJZbPQN4nkgRziWVFSU+h+jqp9SOMO2UkdvRszmMML8p92
         fEgpiS8+bNjr85gwngnr9bcJ6Z+54deBPutYp8QgVApROjjYoI4Rk5pwXpGfG5GjuG4k
         +9XA==
X-Forwarded-Encrypted: i=1; AHgh+RqNk+hTVeX7a1MnDmKrTvuQaIzLl/F8nosD+q4f3nSENvLtuw3QcYZse9zvgdY8ru8uv4pQQqw=@vger.kernel.org
X-Gm-Message-State: AFuF++nr+BJQfYPbfAxPRKqtgKaS4Gbl/XKNrLsreBe0mxvvbEpopkEy
	dpNGyWcUg9urPObkK91DdozXnVmvyU7tbAkNrBcBw8tXaONOkPmersTubE/qL/11YlZcf/ZG1MK
	LtDdIsGNbS5XmKc9mEkV3VRbL8x//j0c=
X-Gm-Gg: AR+sD10PPsku/mT1zrpM7JoObnsdon9t0fvCtEgbvIfCJxJP8QVh7n+GqrQMSXAKFdt
	y4w1oWYxp0lkxeTU2tcYqmrQalwIU+RwXNEG8v6+//OQaBQnuJmFKwT1iSC+CXsAKl1nhWEMoJR
	06DFe+tp7LLJ9zSqXd2gwbNK0YRlr0DSncYS/GzJIB9FljRnUZHvShvocjpNHYjAjpOnxJbh+vx
	G5Ygl4Z9Bd7eJzC6wn8B5yxwkqEJlH8y4Vhx1TJiAFABjlOH+pnvcox6MnW1xSBltp7v8AHueZ2
	4xUBa3Vx0oRvDZC1DlWn5JS1UQv8020VyQYn8EvGc/5UblhBGq9SDzKA/MppuIiWi5fgCywY+Lk
	=
X-Received: by 2002:a05:6402:1f0d:b0:68e:4c0:f59a with SMTP id
 4fb4d7f45d1cf-6a5df61ebbamr630339a12.2.1787684152982; Tue, 25 Aug 2026
 11:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com> <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com>
In-Reply-To: <f3a9dd1f-43a7-4644-bf1a-45dcd422abcb@redhat.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 02:55:40 +0800
X-Gm-Features: AcwNN1W9SWDArcmcz5-thOMAtgRTEFgcxQnTTIg0FVU6UltdC2HdRtGhOn0lr5k
Message-ID: <CAAo+4rUG_Y_d28bLbQdcmHY5-vtBrhV+D6rzbd3Mb6B3iTSuHQ@mail.gmail.com>
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Qi Zhang <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:45=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Side note: returning the RCU protected ptr outside the RCU read lock
> safe, as the caller never deference it, but quite confusing.
>
> It would be nice to follow-up on net-next replacing the return type here
> with a bool.
>
> /P
>

No problem, the follow-up patch is just sent.

Best Regards,
Chengfeng

Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD9426694
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237211; cv=pass; b=to+VO2+uKXQwC4VzlTEkXSr/3EY9E6Bj+XioY33fmIYbeQQ3tE77N3vbKH5kZSx5OYSrCxlBq3I/A8/IcN0WBLshU3iMHL36yumxvJrcJgQx0DlUbfwM50QHQsBZ3qaTN1AaBSAKtaXaMAadgBy9GrVHmTTD9PEdLP5pMaNg2V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237211; c=relaxed/simple;
	bh=UGYQZrnkRgeJr42+jBEAfW2EjfUaS7m1JQC4CpN5LwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk2Y2L7tSjeFiwXYBqjy6hjhvTeNOcS24wvZxo8zgjHSiQYDMJhgV2lZb1g9fBFhRO8p/vX8FoFqMuGkfhK548ikq+tfzpzECKBHdYmiO3KoyecF4j7IPOJG292SPLd7X1Enl/8bck7E0dbPc+9752Y+KKEHOHqILjmhDto5tl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=UFHOPdhc; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="UFHOPdhc"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc745abb731so906909a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790237209; cv=none;
        d=google.com; s=arc-20260327;
        b=o7eA2cc0E06nHh/vA5dHvCvx9m3FK8zRdh/ALssMmTQZxORkOdrEmX3NtK6yjaJBcf
         udNOoHMaeh1/YiySmoQOZgpiBJbhH9opZ64rwuTvHYg9TyoPw9P2KVO6O6BBDJJimujo
         fOsoMY+WskjNMLj+85zQjxNd5AMSdxLFkrjq3C3Dt9i/U/5t8b+4j3TA6oNdiYD3C/X0
         LNK7+Jk73aqfDKWNYE0nO9ggQXgAi/V6PQsC6hQCS6APp5HHmgcOSddZMdfvSK2EDsbG
         B1XGxfKjvpUXuFg4c9/yVafi/lwUkCLt4Q8k5f8KzCGdb6Rfej/BPQu74BqQLyvDYASX
         Sa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qy855CY2fR1265s2jkX7R+s0pfCSkIoNrA8ZhX2DHRc=;
        fh=BxA9p2+u4l6JY744zcsqSUg9+EZWtrBNU9FWnt2vGY4=;
        b=h4GgKbjy5308oDteR3qQk/O7kgmk8CnqPudU5nZeZTbsQFXIx+NAmQrU/SVl00n4W1
         p13DZW2ib+qQA9H99ux2uxXEz6IvYOubttqb/p86ZoRqw50wN5RpTJmDyZ/U4SaUNXA9
         VcqFL/Ngf3aNKwpIq+TFdm/Xlsv7x/3UZ2kQysuFjx8Wh6BtuaBaRwxyNm/Nt1tLdRSy
         ubj6diRD0vvaWPVBuI/PzvOsKXkhKRjHZUvwRfBvyGaakQMKvkoj/So4z5GCm/TLgIFT
         47r2KPQZcHx4IStl424IZJzaouq+MbqWe5u4xTZgpEgqTbq119Ly5dHZj9lA8AiFMbM/
         4VGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790237209; x=1790842009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qy855CY2fR1265s2jkX7R+s0pfCSkIoNrA8ZhX2DHRc=;
        b=UFHOPdhcSZ960kqKpp5V0uuB0YGBTdaM9Nhh8wzRkmUyArajxb546vOQ5klXC7b8+N
         ULvkq7JuVqsgnpE6c+Y3C+uQrGHEOLXgA40U+FROvH/9XmiWDlTcVp124x+E0UnoNjG9
         ti7xglVZ3cozrj6ZgDTh2b2/OzklpCbh8fvc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790237209; x=1790842009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qy855CY2fR1265s2jkX7R+s0pfCSkIoNrA8ZhX2DHRc=;
        b=nXOlBdS0L+ucsgi8xlT0oCRd3C7Z4lA1uMtie2espEKbQFi3DgcNznubaItTg90WBV
         1z3ObBBxiz/koWc7LTY1IBwS7RxPE43BC1YUlHAlUSCYKE2fPGHSAFkVYizjOyzVtlSs
         o31wHemk6lbDwyhTKMhfkpAJwZUWHG+VgcZRihhixT5f0J/s+vI0oNEwQFtKZhEDIoHI
         oQ7hl6lRbfppMgVswVLh3/NMzHnQ7EhWbFTJAyfdizcNG2kR/s99/9TkbQL2NZW2aR2h
         tY+aaSLlmYbFuS3lysd4N42f8rl7K1tkxkTaOgGns7ZDmnuxdzkMa2qGftKBAibyQutV
         q4zw==
X-Gm-Message-State: AFuF++lTNn1/dyr1RBR/ETHw0T1g6Asqf+bvYAg3+CzGoJxzl7rCvB88
	xSWLTU+hBXXUb6VeFUczeTQIap7ZcN/PJGIBlg0zHtpoqRc7XMKm8cjROyYLjgb5x/IVKA2r04+
	O4E46wT8QzL8KxfaBvKYYTtSAfdp8OHkcvUtkppfSzssz/nk4B13K4w==
X-Gm-Gg: AYBFou2s7Th/EZ7kihLn02BktyicnIwRDMaC4zu/XUKU7dBbc1DSkRtNJ7cieTDvUed
	64+wiZ1S7dFeZyVo+DJJKkMFw9b3xDX+l0Pr5mdbRBCzJkevrE7ad+b3pOUxskRIxSQq6s9N2gM
	i71C3QMNgX++MHVWbLMN5Ri5fMNkxblwG0WI1vuJv0+Sh8x8DqI82lVf+tmAbMqgBjIVPKLAxba
	fXF/KUydUKqWtZdWF1wDu8IyP4Ezv9RHacxTkNfCxeB2PxQXZkI1w0DJKPpk6CixesssSfbRXOe
	B7CDoRkJLkn00TVS6hMs7Hyjs2zYeHWoXRTINEkhL9y0PhsFga26CMPDjCDTWE6PTev7n9GFUwY
	y3QyNfduK5SzrpDrpzAk9lWhrOi44X2ggXQ==
X-Received: by 2002:a05:6300:4044:b0:3dd:e691:df3f with SMTP id
 adf61e73a8af0-3de0e8e77a0mr1867560637.57.1790237208727; Thu, 24 Sep 2026
 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-9R8V.v1.20260921065103@mojatatu.com> <179008581937.2160803.7117814290574262942@kernel.org>
 <CAM0EoMkooCG2s+RS53i=qo718GNDGiDz+xaUzAidZArNWO7EuQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkooCG2s+RS53i=qo718GNDGiDz+xaUzAidZArNWO7EuQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Sep 2026 04:06:36 -0400
X-Gm-Features: AclHuK9Obeyam49OTB6ufG-HbCqQCVyHAiNVJYIhe1cVEQ-Oy24kBbB86GTolJo
Message-ID: <CAM0EoMnEvGZQr6KxHR-+RZdCmWQ+PduK4286+W=WB1kcy0fSXA@mail.gmail.com>
Subject: Re: [PATCH net] net: cap skb->queue_mapping when the tx queue is picked
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	vinicius.gomes@intel.com, horms@kernel.org, victor@mojatatu.com, 
	xiangxia.m.yue@gmail.com, zdi-disclosures@trendmicro.com, hybris@mojatatu.ai, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Sep 22, 2026 at 10:03=E2=80=AFAM <netdev-bot+sashiko@kernel.org> =
wrote:
> >

> >
> > Also, this isn't a bug, but the changelog says:
> >
> >     Another approach was to cap it in skbedit;  cannot work: the
> >     redirect target, whose queue count bounds the mapping, is not known
> >     when the action runs, and act_mirred sets skb->dev afterwards.
> >
> > there is a double space after the semicolon.
>
> Sheesh - bikeshed much?
>

pw-bot: cr

cheers,
jamal

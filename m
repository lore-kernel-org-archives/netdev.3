Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E74582D4
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717104; cv=pass; b=JfXVv5dNlhoJERgZ5Ze7ujXserB3pOmrO7tSX9EmCwtiul+TAOYuhyrg6+qNlkpltlQDV8VXNG/qQ2SLuP4mw/o65nLEFfFJcyMYG0q6oli0lMakWZmgI5xyGwZPjypPuCxnoLsvIPUc/A7vuxXME+PhkjURPZZhiya4bjIdEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717104; c=relaxed/simple;
	bh=q7RydxsmSb9PvDhIGoh3MLq0I7CcWOJM2jL/MUXbp/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYqYpTUzLRNv5oGfVsTeWsKVG4eD7fWq4FkoLXOkcZpezC+8wJnexc3veWLAahOwEk0dh4ZJVJ233pRojq2sTlc2lyEJiNZnUXHJshecxdL0IXNHlwkc9F2x011tYugoegvgfNVY4GKAamo5mRjLFnwgE30vI4SNQMHSAUGd1Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4Qw874G; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4Qw874G"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6685001353fso3966592d50.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784717102; cv=none;
        d=google.com; s=arc-20260327;
        b=P/JeYCc41ZJzkQzu+gti5AKHknciwYftWtczTWBa2WPKGXqjfu46PGaKdP14XRk23d
         lyoL/lFLOWlFkADDvOAoY+xx/OOxzZ5J/rhDQCCzV1l6UH8Dw1bqCLxuZ2Gz6anKe19S
         BQtZ70Oltjw8UICEKvW47yQNqY2gIJGVXuw60DbdfmJsA2T6UsQGnhSb0Aus4nHyUhMB
         Hmyeykc1UT7Re8Ub9LREuZvcU9Gy4MEl3tO+yqj0xYCF5PC4dozuKQp89HX2DPz+vJGP
         HZXT1lNcZ0h2vv4bpEwzF56Yp/0o5HHQDRZjezrWLWaUdKdCArRG58vgMsku3D1dodyN
         4+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjuDYSr5PFBCsTe5imuh91/A/UWKypJvEabdWENKBGE=;
        fh=fIfFTJvnDQ5jBUd6qMftIccn+QwiVOoO0PJWYss2610=;
        b=SCuv+/R9hDR0M3tpMUI+VI2lZoSKKtOfwYFC2PFdMrWyGhOJMf11L3DytpEMT/oJIu
         cWsA6YtJg/+ZmuUSI3gYHmEZuyF2BjxmWxA0wEnzfGEj1IYzFSdbH+UbsdMp1Yu4S1kp
         znPwX/qx2vJuhzDB6UTyTeIJrBp2M7qOSeGdnHo/rx3OUsFcVhPidk6iswRHzuod/zDj
         9S/ziCTX1s7Y5pxXS84upUo3djBTDwAGyvGmTLib8hxy4RFU/h19jtuNzbCnSvfQcy23
         hJL/iFpJkpXUwsRj5BFdq+QN//hNfnIvqxmTK/hJB6E2jU1cZP9ploVVd3j0GQ6FNzpe
         +MdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717102; x=1785321902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjuDYSr5PFBCsTe5imuh91/A/UWKypJvEabdWENKBGE=;
        b=Q4Qw874G86H/UO2jcyJAZOMTFw7PeZ2G/JahOlwUe6doIlDTEo0HPwvSWZsj77ygXi
         PbNujksXm7N2RTQ3ejSuRM3LAT1cnYMDpsR6x3QguhPkCdtIIdqCuh4P/NgEHdsy8XYY
         BbQX1VpIkCqWI3Y598V69USyNRpn44F6Q0uIDYn+bR8+40Bail5w/u/7ng0BEste8e/i
         8a8EZYsRpQrMPpe4W4axPFVY4NRrWEk9CLe6h72INnH+0fmiJQjT4tpTFUL+IHS5wNsj
         AAgEpPU2MnQi8rjoFXo0VWx5Ud2VWPcrJcmgFhv63VNn3jCj12mfAKrBDXEmyNIGIo3b
         nPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717102; x=1785321902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjuDYSr5PFBCsTe5imuh91/A/UWKypJvEabdWENKBGE=;
        b=DVABPLX4m4qoiGmWvQ5d/cfCXcHXLhofXyIVcjP2pWrTpOHjIAir4EYgDT455yroIS
         6WDXTTE2xzoxMwC6Sy1O2NtUDLRgpXAStrT/2RIItKbXeEkZ0mVOUPe8b+XFT7MsoXfE
         0IsBLvEP9sS8W3gruLE1QxiTBuB5DtR23mU4uxMEGiMfJ9t6OWeKx7SQ1B0k31R1XWPr
         5eFFMvl3wQGNagsHINcOCHQh4fACJHZwkgj4PSvn+WrYGuAhJle4WvsmsIDzhC/m0acU
         YpNhB3fiHamaAy0E5nE79UyRVtUo51ni0zeSwKUJitWCX7+IdObBX3oYyFyeXtU+WkqJ
         Xo6Q==
X-Forwarded-Encrypted: i=1; AHgh+RryAuN0QreteNa5EKidUttadN4IL2T0P8lG6zGYFRKvTtQfixwfc8cFmTYBI5wW9tq69B4zIfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGg6v6HIj5KVlMjvFNxNCtc/OjJILErClwm3xfev63X3f14IMi
	mRSmI9J6Kvpbu0aYRTAoBCayrWT6ObqU3a1DBdvfFh9Hzk2ZveWoIipgG4koiCYCzv/q7kxS+0s
	VXXFr7ribKfxOK3aiRc1DbLSVtTrWQ1U=
X-Gm-Gg: AR+sD13zfWQzPkJEkW8h0VGWxtdQpwP6GVMP/aLMAct3M4zsHnH9EBtGOyMY63ZImJ4
	SbOoUDaFM/455bs41UlZTRx7mlTRvBwJqTkhS7pfbpvOPuN/4Zdp0UJ/TTEAyZYE+ArySfUdr/A
	RAEWpjDnHgyMh10hlFcxMq1TPDaCSPlN5uhJObN3WCJnFaYCXBUp2o+CuzbJAt6B0iM+0xQHvvm
	84BEul5u1VnuuiXgkcBVUWZdIaKTf9Mtxu6UXa7EUWDTXiVy6fLwc3dvDFEyGtuYzEHTJ4KZ+MU
	aQCBqMxJgCL2F10=
X-Received: by 2002:a53:c90c:0:b0:668:2f2b:f246 with SMTP id
 956f58d0204a3-6683bdbec1amr4588753d50.100.1784717102147; Wed, 22 Jul 2026
 03:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711151934.2955226-1-michael.bommarito@gmail.com> <CAMArcTWnP5-Os9YOv+Z3j2ob40P4crT=L6cnrM8Gbr2wcxRSZg@mail.gmail.com>
In-Reply-To: <CAMArcTWnP5-Os9YOv+Z3j2ob40P4crT=L6cnrM8Gbr2wcxRSZg@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Jul 2026 06:44:50 -0400
X-Gm-Features: AUfX_mwFi02nFROHDQdw6M-JFHpGer3itn0yLWyOfJnMRvRPwrS8PQ9-9-ulHWU
Message-ID: <CAJJ9bXzpzAd2b_TAfzZ1q9nZE7er4nNkqbLEFxGeiP+YonUNBw@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] amt: fix use-after-free of the skb head across pulls
To: Taehee Yoo <ap420073@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 9:41=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wro=
te:
> Hi Michael,
> Thanks a lot for your patience during the long review.

No problem, it's summer :)  Thank you for the careful review

Thanks,
Mike

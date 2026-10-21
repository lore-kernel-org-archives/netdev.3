Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551615;
	b=rZx5KNYrKkwCnm1EfHo97OpZeVIyT3bZpG45Ji1X9RUXu2fepSLPLe4kyNGfEpF+om7f
	 BqtSBtuLyCU5kVKqfzSOHM+jmXCJX3/RaPp4RaEeGXeE7Rjp8lJva/B9D8lYIJ4qgP0P0
	 kRk88sTmTpP5GYSFfMoxus5rXWI0ltinpxSOW0L5JCteWkpB3KRKK9EO0b0QpnNkV7xbt
	 QJReLlRH/sIrfPrXd2Uqwnv9LWFwc72rx/ZJrHiciMEwVNKIEYJEH3OdD0QEY6CqoIkow
	 Uf1Ej8EixKRSA7swdyuQxI30sJ2dmvEgdXB6lJqapirPRmTJDeFd8tW7WMAeRmpYgZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=odoVy4PHyyHu7+w2et+fTKefs40eChZdvSs2ZlLln/E=;
	b=0dTntPSqDt2d1EajtKPkRk+jB84pJvo2vUMWmWrXo1Gz2OO39SNGHIQL4LYr1ujFOszM
	 G1PGBA6Y4J5ksFLg70/DTCWteKBB8pA9v8CsrSM4sfyOLcszl1imDpwuZ9NRZSS/jUbhI
	 18Wd15p7JD3hyK2WmRXn6UoOxswYOS4Db0KqMMr22mQpfeVzNx6vjZWLO5sgRHPJHArV2
	 eAbhLCht/0B6le8xD7fRGNCo53BTxvkE9FROiiT6XnxeLaf2Y+Iu58LP4zoFeQFcONns5
	 psZ3p1FfryIvQ9UBT34zo2rROXx9QVYM98RzfR5NZEz77lijvHGsobRQWYzwZTVEdWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbQ1ir+n;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F99606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F99606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbQ1ir+n
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e977109392so1727805ad.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551615; x=1793156415; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=odoVy4PHyyHu7+w2et+fTKefs40eChZdvSs2ZlLln/E=;
        b=TbQ1ir+nzL8W1ncS5tWnowahK+SYP73smf9/7BYeWmtUMPtyv70RLUAh226zlZa7jb
         sbpre9MRmjA7gVVTUzMb1aNUnP1OOsDTE0qcxY1PHaLuptja1sM33Yl6gmhrJUPWBR2W
         DNfDqtDrl19ucJwn9azmYnYigKw+g5wRLpSMERY0EZOcrDe9+wMhieJ6rZuuR6ZKkKCJ
         ITkeYGiBawsb9Nj19QoXs5ZPuVOzHUkWVEV1JZVMR1s6LSRe+99zqTkPgU+01SAO3ZE0
         i57HlV2ecbliJRYvn/+CiVcI48hE20kSj5sshghfanzaj4A9hixtCCQduFOORM/k449s
         rkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551615; x=1793156415;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=odoVy4PHyyHu7+w2et+fTKefs40eChZdvSs2ZlLln/E=;
        b=0DhCbfCnZ4Wx6b8FIZdBb9lJn02ZNHifYTYr+tvOzEKHufldMpkCffBsQCS9jkC/M3
         eWkHyUikxKQlvOhR1d6ZPu5CHeJcCXZ7R9Nfs8RZx+XJhTSgirmKMERVTFkHU5a9qqTd
         bpxxFwm1uSWFmrCxNJOKImY9vg490zVjpvrX3pKoBMWn1BJUX9VyCoxN6TdLGVD2ugKz
         A5fqzJ2QWzyYD+buoaGHkz8Eo0Y2wVRy/PuEpazH+05BL943Z+6P7rjNG3A3TQsrutfO
         Kcuv3vh0icsmsZeMfY8sXXNtw/Hw5pfb1D/pDdT3fG11UGE/9eZZbRDDeDTxJyxIdaLy
         vSgg==
X-Gm-Message-State: AFq9FYJwaGB1/Dhr/bqgGLXRojO+gcr4o4aqv0O3ZKN1NL3ZTwxPps19
	T3H9afZCHRUODcjP/7Kpus6MKHGUoTDMPh0qcKqe/ZENAniIPUeEGXRF
X-Gm-Gg: AYBFou1pvn+WSyrAn+dKkb07wXZDUnsE/jvfPPqqWhKqXuTeSZ9/V7p4c5rSc55T8dw
	5jeWO4kGUvhYw6NMyvQIqrXFNbTaCMK1SepLRO9UCwOb0sTXVmVBvg9tu9HfAFs+8EhPXgdjvWt
	beOVej/OigQeOBZP8+TdHutpvZCcDB9OyxzxE5aPYoyFTlrYp28dlihkanm0Azwup/XhZwntPkZ
	IERXie9SgnpENCfKATFrZ2DMc09RzqpL4gWs7w73yoY4S8osL0OJfZ4qh8ruNep47ewpnCqFWa8
	uh+RnmEUE0qTnNy5Wd+2Wpb9y2sS/0q2UQwKoneT/KAul+v7Q911f6eDUhHwRLTKaiPwedb5fDq
	1QoktjyPZ1+fv4BJZf5unh5RCvSZeBd5KQIAypCEB0XzzulHjuHzJzpxpx94YBL1+fQd6gzAri0
	Hd+QB/uNU8jPtc1ygjWmxqhHLaPWs1QwnmYP8KXKeOtwv9bsKsBmkobfiSR34te3ggmx14xRYmn
	aaQG65t/OVP3AHQbdOo4rwNx+BN/uyNT3DILhdu0hQvutrzXzSG0763RzrmAenGyyC1gdLTOtR4
	oeSPLPgddyZMAz/m8hdXTYzSASO2YxkGgcJsqC4GlseBrt0WOjBoKx7qeM4kYT9vGUeKz+LTMya
	65OpBFlw=
X-Received: by 2002:a17:903:26c4:b0:2e9:7719:4104 with SMTP id d9443c01a7336-2ea4396ca12mr6207395ad.8.1792551610224;
        Tue, 20 Oct 2026 20:00:10 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b41096bsm5236935ad.26.2026.10.20.20.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:00:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:00:09 +0000
Message-Id: <DMA6IGX5XTOI.1DVKS3WN0K6NQ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <josef@toxicpanda.com>, <mason@kernel.org>, <steffen.klassert@secunet.com>,
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails
 late
In-Reply-To: <20261020192044.7c3a58a1@kernel.org>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com> <20261020192044.7c3a58a1@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 07:20 PM Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat, 17 Oct 2026 01:39:12 +0000 Alexei Starovoitov wrote:
>> -	if (bpf_sk_storage_clone(sk, newsk))
>> +	if (bpf_sk_storage_clone(sk, newsk)) {
>> +		xfrm_sk_free_policy(newsk);
>>  		goto free;
>> +	}
>
> why not add a new jump target and add the unwind at the end
> of the function?

Don't care. Fix it yourself then.

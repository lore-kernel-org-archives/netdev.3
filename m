Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621222;
	b=Jt1k7/wsYAVxIctdgbIo7FB6xM5W5X2RY/gV1hOUC6+8a1+1OfZOg2yX7YH6XF2nsUsl
	 R5JfBQRjVne+Hjigbg9/1XFY01KQAFUX4qP6/ECMliWljZW/8u+Bem3JLmal/dKtxuBoE
	 QPyRrLFymUCz71w8nlGfHA2uxFP8BHdqaJbzk7QYMkclZPj7RcP+QMbdM7zTHUVeb4508
	 Mck2Pyp+qFBcgnYEzh1lzwBwF4lSbJUT3cJFQIg2133pXb5uOgO5ajqmx2L43td7MtmA0
	 Hk+N48xYAqbtBsZyv3TV0+Tg5/cF7gNu/qMK24pHsKoUgnq2EjAuNvqfA+6Dsdh19FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cHxwMczrsd8dG0Mciy8ucuGSBKV5QcduhNoDlOIOkBM=;
	b=3if+NE5nVDl50SJ5GjCoBKLFoZCyRwu6YT02l7hqKEph97r+JH2i1+WO/rrR4jgB/G38
	 VBt3pUXMSoiaPS0CX0Ck2h2F45G6WIt6Uo8sWIsMhbvDr4U4p4SlRhCx6rarwk2Sv56Mr
	 DOTJ1Y+ab6aPm2y7s/KqQhJhN+QcOdZOI+E9cYz4/NGUVVgPgRxEi8TgZWEN6JruAI2Dg
	 21VUmtiyaaRxAT3daYiS7x2Ktk8D/ZGoT7VjQk/Lawi6IxAlBXUlm9SUDD+fWgJkOqf/e
	 gLHSmZY5f4ZYAI4EI2u1FpjlhMJK90znJLJYlaTkGJH9Ugvcz3VGG6D9jdKI70JNMfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=tftbZa61;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCD606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBCD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=tftbZa61
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c445c95d553so385705066b.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793621219; x=1794226019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHxwMczrsd8dG0Mciy8ucuGSBKV5QcduhNoDlOIOkBM=;
        b=tftbZa615LKNryZ9Kc9GKk9ho4fcnAEDTrxb9TcoyLubpthocMG+3lDPU5rQ5HwxUI
         f4JrDTvh+ehBSlzYTK6OFmWa8kfA8jX9U72WFzXk9dNOIQcdbEPi3jpvRptX5DP4QDE7
         CARGva8Q2vojgQHvJc5XCo2XM1ri8G+g+t5SiuRWlctSecNHbsO6Em8JRNxIZeLTklvr
         ix+i72KpefxTp2m9/+nCqb99dnrX6+E+hZQDXfnFhqVFW8gx0NGl4wN8OqJf6Wy6nl93
         Fb7TMTcltpD1e0Hv9k6iyMBp4Itp//HSNJCRS/tes6P+awsGZfTEKT5oUqRpcxPs7vzF
         hI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621219; x=1794226019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHxwMczrsd8dG0Mciy8ucuGSBKV5QcduhNoDlOIOkBM=;
        b=k7cA3P9FHrJO+RMCUbRA9F9HvlmxhQvCQk0+d3cBGeF6iS/Cj/gKKPLs4OVOEqJ7G0
         nTfLFfnfFN0govq2SkHT3waeoNO8R8/yb55BPrVZmoxwBFSBvisLtaq4JJA36RiGkjB3
         BzLjAIEvK8gHL74AZYF10JPSx92XxZQ70e9Al8H25kFii8KedG8gT+CcE+fPVybO9GI9
         S4YKMMBfAeZVqiYMBP0X3o8VSNWYfIGM+I4D5ow6/O9lTjM96MQrw5CwWuMPG5eAmcTw
         VY+6Fdgk7edAluxslysQfgO+6B3uiFchG2bNrVZR2/1e76ziGlMAix80beWrB4dMqtQg
         RXvg==
X-Gm-Message-State: AFq9FYJcb0KrulaXJo84bqZtjsqsY3h7mzMZy1TpOwB46FqamA27booH
	iJFdQA0h4V4IlsZ/D2gYBF/XtX9yChbzh5awtuiY6iy8sX8Cusu6TxftRHxvic/E3t4=
X-Gm-Gg: AYBFou2iY/RhiUDTOIJoaqIqRCFTp7V0AAttXQiNdSdI3+1xYKSnZcqvdcVdNnxnKGr
	T94nDXwa6wGjoiDga0ohaZEHAJFEGbnSOz5em0xDRTwJbHH09v2lEg9LjzD5GmP1tUEd4T5cNDF
	BqpFK1GB+qGbG5wgD5BZVHjEE+KX9fO/RDaXYLXTvDO0IjqRlkz0RNTgqJPtPg1yvzxQ7BQYAJG
	9wFnx5KWnVa+uTUvDcidrma2YGF8JGlsBLqe/rTO+tczhLg5oOfWpF/j7481HKr1e3TkQJmujEK
	0XPe9poZbEPuNHG2F/O3GGauVgf+qzO+VoL7hpjiJdMpl0P4Y1WYGahq0lIcKrwDfZjE1wxmjQM
	5blOLTBJCHRRaHfzU9yHKl9lCKT2RzkxklK91OejftWxkX1HT3sQfE2BeyAeYqZqvDm3Fq6ASsX
	RImGp8WXAyB6UlKC6ShAofXKjsa7nwYUkQ+6oX3VowhL8OTsufQ5RW7+7IJ6G6IJvfgv5zD97PK
	xeMGsW892tlq5uENVsCaw2pQcdQRQhUgI0VoiJAleyCxHll2/vLeLT0FCQ/yyV2u/ouvT1AlRr5
	lf4YK8Tm2Er+8fTJn4XJ206e
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id a640c23a62f3a-c4ca795fa50mr1010874466b.3.1793621219175;
        Mon, 02 Nov 2026 04:06:59 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe0f5easm381515066b.35.2026.11.02.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:06:58 -0800 (PST)
Date: Mon, 2 Nov 2026 13:06:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhineng Lim <limzhineng2@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Netdev devlink A/B firmware bank selection feature
Message-ID: <auh8l9JniT6EhK1v@FV6GYCPJ69>
References: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>

Fri, Oct 30, 2026 at 07:28:52PM +0100, limzhineng2@gmail.com wrote:
>Hi Jiri,
>
>I'm from the FBNIC team at Meta, working on firmware and drivers. I
>realized that devlink core currently lacks a feature for selecting
>which A/B bank to use to activate the firmware, i.e currently we just
>have "devlink dev reload pci/<bdf> action fw_activate" to activate a
>pending image, or reload a current image if none is pending.
>
>I'm thinking of adding a feature that allows for A/B bank selection,
>something like:
>
>devlink dev reload pci/<bdf> action fw_activate bank active
>devlink dev reload pci/<bdf> action fw_activate bank inactive
>
>This will be useful if say we just activated a problematic image, and
>want to immediately roll back to the previous good one.
>
>Before I submit a series, some questions:
>1. Has this feature been proposed before? Were there objections or
>discussions I should read?

I'm not aware of it.


>2. Is extending fw_activate the right interface, or is there an
>existing mechanism already for what I'm trying to achieve?

Looks like the right place.


>3. How should userspace discover bank-selection support, so explicit
>selection cannot silently fall back to ordinary activation on older
>kernels?

max_attr?


>
>Regards,
>Zinc Lim

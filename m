Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB933F1ACA
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812595; cv=none; b=KzUB4aB+nEjwZJpY0xrlFGY5+A88t8OXDy+Dgs5Lc5j8RXcmCs161c2AnMfPERn2xqLAdukDImTZuSh4uEdq88eraQgHgHO9SabtujJfCv5ajRFhyqDfRCZEAMWBeC86xxg1l1Ik8GgCOGef9ognkv2w4D8FKf/Chmb91V98o5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812595; c=relaxed/simple;
	bh=KPw6gb/96YeepZzTPNIKg3NI+vpV38RDv8bf79QxgNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoyC8dEo+MroMIo8YimvzZLPJ7tzqe4MXDQ/6ScqDJS88qNyvxNFwZNxVhxD5325WpaMReouXjFAs1bwjd2p0/QiTAa1OxsukTRfpZHKXDGGfLzh3BRuJFuKTLkJ57zBWlCfYIJiQ+kjLGhHSMqlKFOf8sXfRMmu+t8e3UVUrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG0cLO8A; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG0cLO8A"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e257a23aso2757714f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788812590; x=1789417390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EjCQrrE9B9KBQqXREGY9lzYvxyk/ghYu/8nD5ptROuc=;
        b=cG0cLO8AdyS5YgJPW+oqxMbM0+BVxThRpuYbSbCYQ7BQ8SKzYYPM91VRHtpe1FY5XL
         32P5Kf642/TWzE5IffYTJYeQ3oDQMW8d7bI+xIHuXmoP9PTPQmkVm8mvfPYDUQeBtT9c
         xtd4gWoYvflQbVGhPTvGSAVgwLnfs9fo1STM2kJQa80l2xBWzc7LtJF0fNNq2AoyGG/k
         m0xxqEQ8TidUsXjBTURFA2UZqthJV8BFiRz5CuD4eBJ8crJzODSCZNl3IHS/pGVCgabi
         Eb5sCCw5UF94ZBN9X7l5kPhCLWCU/1w9QzVEEJRNSDQR6dkkgepOx5Bt1YqNrtp2dlzF
         3Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812590; x=1789417390;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjCQrrE9B9KBQqXREGY9lzYvxyk/ghYu/8nD5ptROuc=;
        b=KpNgW0/7zgdR7RDNhVGnDk4mfR0MhTcjZnBbJAmdSZegZPSAAaioKBrfSO3+sWpWN4
         TwaTy/uh3UJxqxlJ/ncvmh5dAGpj6OoNsQOt3IOpJfl55J4qdf8D7PFZiMA7uJ3wHfcS
         lr/f04Q5j89nAJ/kYDYDd8U2i++i//c0/Nz2h7p4SVdRzTdXAfp6A4YEh5kLaqGl93mH
         0P81lWpXZejT+ujN9FaGGqjgs8rm+MHiBltWUqinrWmLvgkCkY2AI2E+ZNUPlTbRY0IM
         E57uXH+F6WBXQ4XHCK+dGdLcmg7IjeYFyW+NkrFTdCB4GVJuoQj6ZP39q0Dcw4yeLtrU
         ZTxg==
X-Forwarded-Encrypted: i=1; AKwUvBxRmfBHx87Ty3xIZYb2L1dOPCWW+scjqIednu/MBqdR3GQ4xblEdTQAVgK02008maPRsjk6fYY=@vger.kernel.org
X-Gm-Message-State: AFuF++nCDFaPoYfyHIhkpexPbDsjxAqT9Zz5QhsSp1HH4aOcxiQoaBsd
	D/hgZvVuiabwczfBZEYhUOwd8FdPMHSnAwmoBNiIsXAZfdCE+wfHauTM
X-Gm-Gg: AYBFou2x4DggKhVI18FdBJfWL9mM83KuMaoVwHyjBWVKdXSFcmZJDREwdzj+JGnBjGy
	n5h/2g71QIYJ8P5ZWt1LZw62BFFDbRq0JB5nBFCUvImj0s/aapqAtNBVAZdBgLNkL02bqPsv2JI
	3XQAU/D7lHy27/phJ6qaVV4ubUxgBxc82/f8KNZV7RM0gVKmBuiuogP/7L9H5xEw78eIuVlVVRX
	0mJGBeJM8ipac3dk4idHC+MrmNuL3cvdWnZZ8x+f+ZxAcauqI0a6iUtbFDVs9FnXXi+2TKGDgT2
	vhyg8G0Odvk43lWvgJ6LJUIXQ+GLf4KlBjZHKTnFx45bOk/J30MLbhrZogglZc7ntmrh2ZboHSg
	BpHMxjztsm0Bgo4IzEYX6mQKf8yMxFf70ElW2HnUW/UQpl5VnwA2ywEq6IVLisB0KyYPYCwkYpY
	u13hSPK1dgzShSGK/sybto1azXNE1qY1OvoVTs3cgHMmHaDwH+zQPd0DEKoT1FKgZ58ih4yCgyT
	PywG3eWU53EUaZV5D/j2Jn5WQ==
X-Received: by 2002:adf:e014:0:20b0:485:8e4b:3d36 with SMTP id ffacd0b85a97d-4858e4b3f7bmr13906187f8f.10.1788812589672;
        Mon, 07 Sep 2026 13:23:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859207c28fsm24763666f8f.5.2026.09.07.13.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:23:09 -0700 (PDT)
Date: Mon, 7 Sep 2026 21:23:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: oneukum@suse.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v2] usbnet: fix smp_processor_id() use in
 preemptible context
Message-ID: <20260907212308.420701cf@pumpkin>
In-Reply-To: <20260907185408.660755-1-omermetekaya0@gmail.com>
References: <6e0dbfed-cadd-4274-8165-886725413d0f@suse.com>
	<20260907185408.660755-1-omermetekaya0@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Sep 2026 21:52:20 +0300
=C3=96mer Mete Kaya <omermetekaya0@gmail.com> wrote:

> Hi Oliver,
>=20
> Thank you for the review. You are right.
>=20
> I used local_irq_save()/restore() thinking that softirq writers could
> race on tstats. After checking the tstats update paths, I agreed that
> preemption protection is sufficient for these accesses.
>=20
>=20
> I will send v3 using preempt_disable()/preempt_enable() as suggested.

Shouldn't you use get_cpu_ptr() and put_cpu_ptr() ?

David

>=20
> Best regards,
>=20
> =C3=96mer Mete Kaya
>=20


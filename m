Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793384945;
	b=34dZYppZuAkIFKzqFIciU/kgBsmLUWOObYhOKAY60syAZVyKTceJpE/HjSpdfnp/gKAU
	 bYhSGU7CgHyVObq1Z9FSF0d+CPt8zcp44sLI5yuC86RtavB1ldCHlIP2wEbAVd/qsiuIH
	 encQitiCxqdsLazm5zu4+CyodZl52qPCUc+ooRA3Psl470WdmcpBQ4olRs+7AnMOAz2It
	 ktZz/2HhI+uvuabeyHX2axdkQYR2tXCBWSNy1MpFyWTocNyB+MbRIX+CTw4fqUAY1Uofi
	 Go1J9JfikO0zNEaFrI7rVtU2nY2m/Vq10xuoU84/1OD5GtHbYVRAdZb3Kfi4RW8AaSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=G+zB9GFJNAbBfR8ZwAc3PKnsy4EPqDAbHoDAUQPIrLM=;
	b=18txxNS9tz7QVwmbuGOYfGkIGweG00xzZ8lzQJgDBECFRZhFcfszcX1kyPJyJa0HGcHz
	 me1in12DhQAPqgIx1cwnAXD1kskLLqeYSMBV6T1OFvf2IPfLBxxi1K8OoNNk0ugHb5Kl/
	 UOfCiYBquAcELsmUwcLIoxhM/kpNHZvcO+WTb9r4PB2zz2nkESLIlUHllDxYeglaZZzZK
	 4sKQ8SZTeV1iYgdLupxWERp8dbA/Z3Fi9PRaP0OFLIPi5b17EDcQTzt85nv7k1/tf3Ka5
	 sSDDpITfZ+ZDf/QiY5wIrPWYqdgdhc0l5XZIbokyc1J6iIB41tQJ+djChnUBdCN7OOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5JvoXMS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57730606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 18:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57730606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5JvoXMS
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso635695a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793384945; cv=none;
        d=google.com; s=arc-20260327;
        b=V37C5djCx6yYTWZvIgOmfMo722XgGeyzBr4XDgReaz7M7ZvWqMJ0KRPgdLMe8u0qsd
         bRGeZfciV7NA8QxUf8ow+uVY1x+aqivsy0sRESJW1DLtxa2p5LDfF37w9pcACdCVVqyd
         NJi4S36Iw9/s/e/hhx53w4O76eVXHXgqtmgjBspTyc+oA3obeOBrmbyNU9WNqE7V9rkA
         b07oGYIQVvC/aA6P36cTtDQRMaFOyL1Nkciy0kijnCD4qbcqBpbO6ND/zVyS3MwfH++K
         nMsRMKX9XxwCHoHr1Ba2UNq5GFw/h32Z9AxUn63THhaE0zEeKAnkXjbI/K8qy12iavk/
         lwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=G+zB9GFJNAbBfR8ZwAc3PKnsy4EPqDAbHoDAUQPIrLM=;
        fh=s3/y0cgyKC93uqiWqu1jjWz6I/lagqMr7M1QYuwlfWM=;
        b=sPKZJYLQHyazkHdRHSZPrz7yTweHSDuT0uMHHXw2lps1m5DqmP3aT5tEOcFPk7PXCI
         q0Zxz/1mK6BZyBRbuwdVRpKMB9KYiHSntrLPw3LbdK5QqsOtZAP5YnDazH1vcUO/yuYR
         2uTkSZDuIIIIT0QKhZlYF+UN0Uz4WLagdVtLTglNJ6/vM0FKHDDwzY7TfJGmRGQ2Pzxa
         osAIXvDIW1F81uiGUp4RbDE10qR3+1fce3WwGWJoNjkze9sBL/lCDi7lz4x2jKwNXXrB
         S7YSaAh3wBhWtQDELxMQs5of0fjLhTwg+J5zxS3nma2bJBfCLF76Z1KPgTyAu5qoHvFH
         W5vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793384945; x=1793989745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+zB9GFJNAbBfR8ZwAc3PKnsy4EPqDAbHoDAUQPIrLM=;
        b=w5JvoXMSh/TEd2WwP3yaQwlzuSqw7AFZUNSnNwd9n46bQqcN3su6P662/8PKOd+fKo
         aGqCnoS73ciUbzEuoPIYgsn3oFw7urCSbBdXmc0T8GvX4XVYAjx2WierNP57GkOTT3gB
         dtExPf/dwVdG4A1Zaz7/r4C7xYxPbcLr+gQYLcHY8OchQOkKmWsH8XcV0i4EyLsqtuvw
         ZY1uzQP5H4I4Nm1lkRd03ZCjIlauHwWjLChpOkB+n6sXvs2AmnXsSb72YWQyh2N5JQk2
         hN/mMexAwF+gaG6kzKcCDBFzlkWxVpmkvGLTEZXPmBrMmZRnAE9HFetr/e9XQV5RTdng
         9pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384945; x=1793989745;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G+zB9GFJNAbBfR8ZwAc3PKnsy4EPqDAbHoDAUQPIrLM=;
        b=uaZ1co13/wJckBta8STIXuzRPTTgPMvC1pTv60hozX+NImNFO0AsV/vo4c/LO+Y5/2
         H8bK1xMdy4ZOEVrWjKEACO7958TWqCXEQzfDjEkSrJYD2tQg67ZfLM/rPjYSugGqV1jK
         niq3mdBj6M37kJysWeYpQgBNmifpjrUzqEHi2IR8I8voNANvWytffy+JYfUAwsEaUPxF
         ld8b0ziRQuQnKy3HdXMXw9fnsftJPW8KRiynOn9FncLqwoq2R+RG9eFXDBN87Xa/Z09Y
         ovzvSMJ0ljXpMgqMyghxNyTsdqLCgjCsNY+hB0LXbzUITEzOvFhD5RuGiss/WbPYQVCd
         dZ1g==
X-Gm-Message-State: AFq9FYJ2dcqnNJ9yAqpCBo3Ok89CluuH2YO7cenyV/PMJnSUhbiBTBUJ
	78sYrdT+rvNY24l37oiQ1HYiq7/lICFxzmdzpphr0HH6fTQSSuBscjeBdyHNuLgBCBRffpYjwhG
	NBsItGS5xPBsIkCLPJ/KD1kIWEuiNMaohvF/3
X-Gm-Gg: AYBFou0V1RSOhZSrFvKCPq7611M0B0whrmPJVJVdCoMEQ2dDVO5Dj/zsOPilwmJSrC1
	ijdaRB2Pd763MjE8SIWUp9zeg1aj3yx988hr5LBieUU6sqPSPDeA/Ui24QL1oL+9Dwy+1cGCPrY
	Y6Zib34rcS3C9nHIJvOrPMqi12RRauLVWJLnelS43yeUVCx/VmthsWg7uVPzumyqS1G/8oeWAep
	rRUQKwkYT3FLmILlibdHhZnYz6oOcHXRVvenIsW+4ikMoI9iPRDQieaF2zHe0w+K31eIFeS91tO
	iqFuP/FMFjegswjzDzYA9tRcPt6T3SOsCK4DsSmW+A1+UncGf1TKk1+AiMy52GxnihoYwmfB/9K
	fChAF7d38EfNkaTVKm/xRho8aoxDGfhtwp1FZhTsM7+opYyV8OIco
X-Received: by 2002:a05:6a21:a0c9:b0:3e1:6acc:5b08 with SMTP id
 adf61e73a8af0-3e928a7a8ebmr2693665637.63.1793384944571; Fri, 30 Oct 2026
 11:29:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zhineng Lim <limzhineng2@gmail.com>
Date: Fri, 30 Oct 2026 11:28:52 -0700
X-Gm-Features: AclHuK9RPfw7WSAJluk5rjupJCtEDCjvqcrlH4YBsuGyUAim6lTue7jo8RUktF8
Message-ID: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>
Subject: Netdev devlink A/B firmware bank selection feature
To: "jiri@resnulli.us" <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

I'm from the FBNIC team at Meta, working on firmware and drivers. I
realized that devlink core currently lacks a feature for selecting
which A/B bank to use to activate the firmware, i.e currently we just
have "devlink dev reload pci/<bdf> action fw_activate" to activate a
pending image, or reload a current image if none is pending.

I'm thinking of adding a feature that allows for A/B bank selection,
something like:

devlink dev reload pci/<bdf> action fw_activate bank active
devlink dev reload pci/<bdf> action fw_activate bank inactive

This will be useful if say we just activated a problematic image, and
want to immediately roll back to the previous good one.

Before I submit a series, some questions:
1. Has this feature been proposed before? Were there objections or
discussions I should read?
2. Is extending fw_activate the right interface, or is there an
existing mechanism already for what I'm trying to achieve?
3. How should userspace discover bank-selection support, so explicit
selection cannot silently fall back to ordinary activation on older
kernels?

Regards,
Zinc Lim

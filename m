Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890A433BCA
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784505; cv=pass; b=eD8GR3gBqUoVGzjrmsS3lkjn6e086RbU5PIgv6anXNobwDk1cdQeobsMUlHMfarlKiXQ2ta7t8E8/pBsk2H8ZkDZYKGAzDTq/KTBSCL5T0wb9GxMIoQuWnGO1WWqIM+wsBrvI04f8yprv7Vikh0AsxVsfznlm98DoDYf0+uxHRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784505; c=relaxed/simple;
	bh=Vx9cs0B64lm0sgfekv6KEXx1UZq4jRor81/CYqaYzQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebyZ53nzeL/f71DEr1+/7WYoIasmnWU+7MNmob1UKLvAHimiyNcFaC9G3END3dHmRvau8GS2YTBvRoT9/4UURjZJACcm7ROANdSzSdwvn8ShD35XwcV6pRMwaF3UOm6o1YCKNQhXYqWG15b46BH5uMB89UPkI0CCcWUrL+Iw7hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMyMJZ1G; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMyMJZ1G"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c01c79467so57891cf.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 12:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785784503; cv=none;
        d=google.com; s=arc-20260327;
        b=UP+I11YGIjbAg2NylWaWX7BMeugDEXjoC6K+P8MMZQEgRcda3N8w0WJnoGFvamdRHK
         fpRhZ/SNo96pZKQJtpd+ytVkkm2cWU1GRn6FgAiqg+Dcd8XszTV/jWp8yAVOPpJqtD2y
         C08AMNXMbDM+94rfQkzty050NLZ+nVztbmgGqKJOQ3X0lDZShwlEAznoWusl9qoCmLe3
         sgV5Q2SxaB73iB+18jh7Afc2Sxe2ZcYOlj2Oc29+02fXbAY41k8Trg1Ay0op31rZJks5
         MWR2A1Et5cpcN21hKMzPTWufa4ZjpqPkn6JTgtVFOHjm/bCgsYl8PQglWVgQhmwlByd8
         9lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vx9cs0B64lm0sgfekv6KEXx1UZq4jRor81/CYqaYzQs=;
        fh=UDziFK6B+rIsE8tgjA5NLol5nQylfhY5TUnsclVBKjk=;
        b=IAb919ZsxQUTZ3NqQkUwaQA/WC59Vf+3L7jXPSUO4MUWm9wTjy2wKfzno02DA03hQi
         5UbnvzJVg6GdazvSam8CTsY6NhIkV9733565G0RBJYBdarlx44AcfE0t2FUzh4n39Qrz
         Ro/PukuY6EmY3T3xJEE6KXsGY/la8gdUx/b3RF3XzUZKCHBXiYgd39PRIWP64kmryp78
         B/7f6z37swvIyADW070dtXqS/ptSVLLeeaAe6XP/jjXEFk6UbGqTYx1bmMhRPS8+XiOm
         cesFTNLEDrJEmxznoB6mXaI41FWiZov7kaKzkHzTXedGWgkIgWsBk8X2kslkHqIaB8Ig
         BlgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785784503; x=1786389303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vx9cs0B64lm0sgfekv6KEXx1UZq4jRor81/CYqaYzQs=;
        b=PMyMJZ1G3ZBdibp1Ay2vDfNgAH8lSXqHeHX6K5KWGrTC9FpAGBiP1AXoA7qD/s3wHS
         /88jze2FeFswDCMOrYT81Rt9DpK5S69BTo8PQL9eA+tr4yIld/axZMQvMNz3OMxZgdDz
         +cNg5rMzVJ1pipzTR7SX4hm+kPOkPFItqueSLHiUTEQXAFwopoSq/CXq4KHwSDyNlAXD
         TFDzmGMD8dQoxJKVXwaS+2qVH0nVIO0WY80GtvhdPHVag5B/qGGoDpCiFYH5P4wVpGqe
         bp+euBg1DA6XjEKdfG0/1w/8mh2BOW3RHCPL2Bt3d4uM7bPpXzEu6JDC0F0Sq35f8P5L
         bqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784503; x=1786389303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vx9cs0B64lm0sgfekv6KEXx1UZq4jRor81/CYqaYzQs=;
        b=OB6p1YW7if/bzdzaHpYJFpnUJZQGFfoV+pD8rj54keVZaoYx8+ggHtidJqpUcWF/jF
         U4rMvrnUcZEk0QrrlgqUV3bu93L3erNtijaq6Acn7E5J50h8zGZUi/oPm2RXTpl4M+2U
         bCBExk8j+2c8nne+MyoGgS8d+sVDUlDYAMEqYd4sjUlrgdj1KvXPgAvLHlbvIFnEF8sp
         9/8IDs4szVCHG5T+wRLAqRldFMZzAsnoRQ9LzTUbZx076L/80Te7YBg28lvCK54qQTyV
         KETBEQSgj5tV+Dv0uVp2302xT1AJj4CetqGUU5y1r8d/1aJNdsDbsodZ6HuYnD01+TaK
         MWHA==
X-Forwarded-Encrypted: i=1; AHgh+Rpb9MJxzG0pngDQTdK3G4Dj5zQQ0SKuezox2DVbaCR1AABZttUd10xQ12u5NIzG4Jm1P94UlLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJm5ytBScyCF+LIMLpYdlfDuynWoMOIzBdFLvH3n5w5Ocgto7J
	xthyEMGhXnQUVfoTBWwFFvfrh4KUTzn9xz27b4QIgpCvOqu2srQr78ShGeY3chBHUKFud0zXsOp
	DaBs5hdlIH4ArkwvrWyLrrxqY3PJryAyva/MdTgyj
X-Gm-Gg: AR+sD10ZT5ONI/WJeRcdohrlnb8hBY1d2S6M1pyiPlsm9xb0SAmV/n60zvcdTCBxjuM
	wAviQadRgCphLmyZAPQ0H6Q6Sg5rw2JX2H4i1GTUrFsAAj76IsrQuYLNIX9rfGJZCCchXNq93l4
	CJG3TmnCeE/dwt91FeYqxcnJtav05+M+KrCKtQSeI2HemvVqWQpA7rhNLhI2eEhbic0gToVNH3b
	fSDu/s6Q5p/R8qN4yRX1eidX6UETCcwDkTJ3a4lskz0fs+dh0I2u1JvSn20IcqAWcnvZGOFHnaC
	h9ygWDBiy/851otOhYfRnjCvsooNpChQg+SmGh5DeU33cgADPvob3YU=
X-Received: by 2002:a05:622a:98c:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52cd4df7d70mr2079611cf.8.1785784502537; Mon, 03 Aug 2026
 12:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-5-surenb@google.com>
 <anBuwuiOBKXJwnhT@google.com>
In-Reply-To: <anBuwuiOBKXJwnhT@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 3 Aug 2026 12:14:50 -0700
X-Gm-Features: AUfX_mycQo4q9-oh_NeNxMl4F_bQ3PUY4_eZSLYeXtHNhrEF3IZz0lhXsltZXzE
Message-ID: <CAJuCfpG0wNiOcBmdANjL2Z8x_DPPgfh8dXsYVCeeHHtCfgHSSg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] binder: Remove mmap_lock fallback
To: Alice Ryhl <aliceryhl@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 3:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Sun, Aug 02, 2026 at 02:54:58PM -0700, Suren Baghdasaryan wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > Previously, the per-VMA locking could fail in the face of writers
> > which necessitate a fallback to mmap_lock. The new
> > vma_start_read_unlocked() will wait for writers instead of failing.
> >
> > Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks!

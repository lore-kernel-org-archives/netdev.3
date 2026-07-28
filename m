Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DC43744F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244163; cv=pass; b=eFIF1adtyLOr4qGC9iqdaORiiHAHYGNqbtp0g2UIPLwAHbA2cVm+tDuOMm3bJNWjHZoGKiLt7bj0qu5Bp3R8VGEK4xr/M9i/YR3EwJuojxpNUY3XEr1EskA8iYBb9rnjngbB8dTi1632seKGQRpEkpjZroayW8ElfF1iM7G5fhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244163; c=relaxed/simple;
	bh=WW/xZH2DAZNDKZdBA60p3UQPzVbo1xpEASFs7x1TQNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMkHwHPhFIjiv63jzpJk2bvAXD8oWwMFDc/nwOTyxKW8CNzhvgp3VhPW2a8Ye87eto5eEq/lCRw0Tj/gtwMUHUaC2RQAijtqU9px0p15v3Q6TknU00NhRYw5TXbIb7l8SfSS+BJu7YoVwBuBw6KxK27bMX+eFM7ERQQ8338RFIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6Gy1gQ9; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6Gy1gQ9"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso3871695e87.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244160; cv=none;
        d=google.com; s=arc-20260327;
        b=rPq2bf5Kkyu9BURWy4wBaMQEnmA0k6A3u3dHCOMcKA6R8tQK+koeCYAhe57fF4f3aK
         8HHcAOwORemfhY5166TP2cr0b0obxKzwnKDkA7jQdq9ylqYDrgEACunpJP2EBrgKo7zv
         KiV04zYTNLsk1AZJiLJ0czOPxGcr0EMNqMEhF68JpOc+9TZ7i8YWV/16QrI5yFab0JYo
         eDtG0/JJFRLCp+PGYLbb4vuQtqZuWgfFdJG4zRJZUTJ+Cb8NqXO0u47L3pg/QKxkDko7
         dkw7Dc/dKeeEK1xFtQgNWGqGPFwc+kGPPDmzr8ILKUJK7vg/6pK8xranoTanKdzegCsa
         G8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WW/xZH2DAZNDKZdBA60p3UQPzVbo1xpEASFs7x1TQNU=;
        fh=jQPEL4WCEAnRMOTVGS6uQX+/sDDFChVOwE891+fVTHo=;
        b=gCbG0p6fKedAF/K586j8enUTGhs5WiL7fH8nIZXghcet9CkSvc+jovuihFRNoxgAlE
         Hh0+/2foPGmyCL+f42LqdKLt6M3JCK7NEDMnFQrXHErjXhMLHyQt3PzP0/c+90elQvAH
         L5O5g0Nr3N29z1a8tt4UtSdD+xg2fkEvC4Bexhcpgi2Z7WQtChWLrOv+j3VM8QHbY3mS
         u0bcNGInfr2dOlpZGa6bkTRal3f/Yt+Esh5xnxG46vy0F1UQY7pOJYZssp8g8+CJpC7i
         Nz33FQBTYRVcRZ6opTinU6fyyKpB93Cfekae2zbgHb70UKYYyYROev7G8KWI2lPe6YLq
         Chig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244160; x=1785848960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WW/xZH2DAZNDKZdBA60p3UQPzVbo1xpEASFs7x1TQNU=;
        b=C6Gy1gQ9BNJ/OEPfxj+pLjsHXezLe9fpChkh/YIE2fyvfTgxS7Y1WjsLvXizGnMm+I
         CDjPL2pY7MokDo++TJfF+ukENZGvmD2sdo509erUNs3HCbHYiXFG3x96lra/ufMsTtRu
         zjCdczN9evTASwi+d4AZ/vZsedkFxHWiaED66WeUQFWtJNNGKM7sG6a/0+Kz1ibevHT+
         83hu8GDI9SAy5hhTBTEyF14l7r1pRcMYAwrUW08lwrDUj0DCz5C1TFCYDca5+Uskjl81
         4B9T7okJcbONpSr9Lj0FzsobJnWI48sIkZLQnTGjxIWAvEfET0EZk9Vf3HhArEYunqja
         cYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244160; x=1785848960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WW/xZH2DAZNDKZdBA60p3UQPzVbo1xpEASFs7x1TQNU=;
        b=BflkF1bvPetlPqzYUo0JKfu4YKMwPJ2Qq7zYiVrjAMSzANlGXnpFBjEEyb2YqaU+TP
         afzQ6hxWcUcLJd9gQ3tzth5Wys0pCRsw7q+BQsEOdRDGmdkYdEQZ61zFun23Ye/gwx2g
         ellRxs5PVBMR/0Lpd1A0h3rUHs0zv3hr+UQaFfxb12IHaWgfpVM5eO4BR2Bm8kkueaPb
         d8DyvmJLUV5QW1tBVCIkUfJjVSMlLC8hI0qh9gGu0gM8OHCWZQO2PbCj2mieXccGTnK9
         mjzGIC86ifymatfUcUXxcqSvUv7jI9IRrRquLCclKwX8mZH83pUX6jDC9J14oBS8bjOf
         N+OQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUg6TOEKuW8IP0HLpJlUejHU3hs7R5/w6KSM6jblwN0UW+6GP1Mn8i2qdWiBQQ7LgGGRCEC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSB713U56KqgRAXcsC/1cIjSVTHSs2i97cYGqLOkEJJ/9nZhG
	JLzmmErBcNp4IXkRCfs2ihOi7Rpvv/kJ+od3kOnR9f82AX+scRlLOUYgd3P/ddRE1B0OVcmhErZ
	J/LKoRSnDfPwL+iw9l95Uz+qEecMydZU=
X-Gm-Gg: AR+sD13Bwj8UBwhZUTiApmxj+jFXWs7/BUNnsIpWAm7sCqX60SgklUJIgUqGbbVaWIe
	XlJCHVlXeIaW0HA0s0v4ozn9Qabi4oJV6Z+YHVVHTrgcVu86pslCuVc+INwsIyMxz8l1eaK5slG
	2ozyFyHZu4rwcxwF4mVSylWbPkKTVZHgOLiP89qWYkiw6y1iGc8yiqUEw3NIZVI0FPVIfPvYLo3
	5cSvl1Peh7mIZTJK/8EJ/syng62VBrVcOsUYcBYMRPHGxE2h4Sr75+7nC53Fg==
X-Received: by 2002:a05:6512:3990:b0:5b2:a22c:50e7 with SMTP id
 2adb3069b0e04-5b2d025f1aamr513462e87.32.1785244160071; Tue, 28 Jul 2026
 06:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
 <20260723143420.672680-1-neuromoments@gmail.com> <7f74229e-15a0-4633-9eb2-100fb9cccb91@birger-koblitz.de>
In-Reply-To: <7f74229e-15a0-4633-9eb2-100fb9cccb91@birger-koblitz.de>
From: Yuan Xu <neuromoments@gmail.com>
Date: Tue, 28 Jul 2026 21:09:08 +0800
X-Gm-Features: AUfX_mx7V3gsePYk3FYgpjUYk4nuJ1-IELUE_-DOvSqrglRkvttZ_r0RjorTGuE
Message-ID: <CAMdPb80Jt5qdK_ecsbUh-D6OY+fM_qA6CiAq6bNUkAw0ogTAHg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] ax88179_178a: Add support for
 AX88179A-based chips
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 24, 2026, Birger Koblitz wrote:

> If you have time, it would be great if you could test also that
patch-revision.

Sure, I plan to test v3 on the AX88179B adapter over the weekend and
will report the results afterward.

Thanks,
Jianhui

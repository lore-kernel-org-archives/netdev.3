Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0C3B6BFE
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684569; cv=pass; b=ZFoumhrcFyFvkPpDlzKLYDgMEonEZjklwbs4/zwr4tTdFglhD5IHEvFVOeqk/vt2sz2hCGiQ/kdUyG/EyIFqz+rEDMq5uIfbE1QYM6OtHGJ0Tcf1AZb0tmQMrtEEb+AAjmyaNNTCW4wMqFU9tvCZFmOvNv1HZGfvz/oQrepwJdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684569; c=relaxed/simple;
	bh=Nh4etyOe8P0PSJodoj8gcrhLaZOm6/Ai3hmoiHe6Evw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6QuVkMm98Yxfrzhg0kam6yDf47z8eTOoOq0U7HNBtu6sLek9sdp0ux93/ckf5HJ9ak7ZmCfcxDMJUAcKjYVOL/+hxGyIN6O1Qopnzfqu6T/hQiIL072VP1o1B5rggQmdbIGt1jnSg9yPQlyLvhrmQUQNx8VorgAiouRwnnPeEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjTHm9Y2; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjTHm9Y2"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69848c9462aso15363a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787684566; cv=none;
        d=google.com; s=arc-20260327;
        b=ZzBFvv/U4SBPX3WVwCmU9ibxpVcgISf42MK+4CwUp7VX8LcsaRbtE/RhjkGpuqt8Vw
         JxMOiRqJHO2rBfLl+YmO3iJFBcFp4u+zm/wyFWo03ETENCl3UV071OAgA9t95MOqFaeE
         3WsVgr2rm7tCM4ms1WNfAc3F+XZoCo+x5k8Cum8wEJWzjhq1HiBMs8GiuzRzy4XL8AYa
         pGulRqeww53hEX30gY9Pw49YIu53NwLLNo7bgGXBJGvTAsJMZ/csJhlBQoVjQgrSDvW9
         nIZ065q6blh9s9/rq9yA4IzAQmmO2F3xxEPsiaUUZrruUsjPFsKQRm7XuXrT4GItMagO
         hSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7JjHTv2VjOYdPiXcUvz2oRLc1r7uX0OdGo8rQlWKSDw=;
        fh=UhrVqOao2KBdBHVXFCTv5wqO3+wHeQrK31aKrz+8bgg=;
        b=Yg97frBz2oTYhudmb7JFaxsMM1jonq05663EW/SdoT5AcMWpoGUthTalQ9M5IkV8ju
         NoV81qAk9cejfjaXOxx5cJ1kT7Ng+sbsNMZGniApZtiB70uPzvcb9Cm7crfaF2Fdk3LT
         CYYLCnxeQIJ7mSOUCjTBeKQo5KKFYh0PnjBoucNqL2vnY5tsgomlJnmt01qTiq3ZaJ6c
         7NBAsQkKRu2H2z7g2CT3zItI6QPkGz41FnXjm0jHNZPVuvp/7kjL1gVFYYAE0rrXanL6
         ng8KuWiNCo291rDeP/Tc7wrSiGSPrYrEvO3d9mhpEn4Y4zaQqY0PYBLDeXlOsxGXd7XY
         DyEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684566; x=1788289366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7JjHTv2VjOYdPiXcUvz2oRLc1r7uX0OdGo8rQlWKSDw=;
        b=WjTHm9Y2lffSSNqQTRbrY6EfYGoR2Mpr5eg9E32DQSCFfXfR4MZ052x6ojbmPTIsYd
         rTvvr5LrHAHdgC4LYHtDzKGvfTuUnPg9rcdVZEeoKwcn7NZNpPlWvMo0PCynkNhy9PWq
         g4gGjkXznMd0Sw3131VSEoxeyHlkE5J+AtniETli1tGTol0BoEBOe4p5OsEbY9yDFhA4
         hrtkg/mqLzh0F9r8v5fD+FZxouUrALtb7FOXqnGs+N3g9iWvoxncZDh3oNUBSVuf3BVe
         dIXMxM6xk9TC2N3ENLf0u73hOjMfHrZV5f/XFkEOmyZcKpbPRv4m2ezkDgawnpS8fRme
         ALzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684566; x=1788289366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7JjHTv2VjOYdPiXcUvz2oRLc1r7uX0OdGo8rQlWKSDw=;
        b=hQsWaQzARXYYtrB6QF5JnX3SH/WYoXboZbdmFvlEKR1so8v9uEydyjTqqz6pwLck8E
         QjDS6hIYVQi3opsqF2qP49T0Fk6HAuWfp4v5xBbi67NY6fHpyjbX/z9FuRNtGOwuqlnK
         Yx2irSirOKwXcoBQd2x65X+KWo2FjaRnPlHWIjRAa+jRbWFvNCQdNJ3YslAWzx8seZ+y
         r7i2qUwpOpqG2nxOjS+s6X1pn7aUP9d/JVYmoptryvSgcyHXP10kmNr0grygx958bTBx
         ZaPPy0gp0SsSozN0x/UV8iCrjb5w5F1wFsQ3SjBw4CDfHzazXH54KfAdtVpvOQ3T1bOP
         aQxw==
X-Forwarded-Encrypted: i=1; AHgh+RpmzmG+5harZJgruhyBnewvK7KxHGSDk5arwWqKHO8++/tkznQaQTU+INS1YXUvmlvJijHedKg=@vger.kernel.org
X-Gm-Message-State: AFuF++nZoMtUpV3DJcsUr3aYN5szdZTwaZ5mCd6JrCT8bQtMMxq8VWRM
	PuQtv+D0hwXpwXbKWTOFAeQOB5oYkoP+Cx1rle8CDNF/8zVy8+9ybomgrclTm2A2+j6jXp8uM/J
	LkYYVfcMWsaSp1bIzcsFBmdiyzk/eOaAAMez1f4d+Hw==
X-Gm-Gg: AR+sD129tI8oJFyn0PPoqyf37ZcFzrkEevkISyYYZJsx4SIJVD/Z+AAuQAB1O/Jkqq2
	4j2C7+5F9qySBqdZWzfUplFYmaoX51EDgBhJx/IJmGrGAvfwjhbQHE7ZnoENYCn5gST/SfMu/do
	mNRmKqxexbYTsTR4KIHkSgPOBOKMwWfFLhSYcLmBIn0gHopE7R4Szq3vJdiBFn+Q2LlYjZlLn4s
	E06ShHRbYWY/LTj0CG89elSuXV9OLyddXIyiONfFeYqHBBO0avuo7sw7EmWsh0IxQL4ebNB3YJh
	jXaIYAnrKjEjDAXkHZPhnkcq+iBUlFUWEKhCrfPb3h+PlVExiXlsb1zurCxW55brSENjHfkDao0
	=
X-Received: by 2002:a05:6402:5d5:b0:6a0:d5f8:9ebd with SMTP id
 4fb4d7f45d1cf-6a5df5f7fa7mr701445a12.2.1787684565689; Tue, 25 Aug 2026
 12:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824122929.210431-1-nicoyip.dev@gmail.com> <GV1P189MB198892ACCF53DC750EBBE0BAC6AF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB198892ACCF53DC750EBBE0BAC6AF2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 03:02:31 +0800
X-Gm-Features: AcwNN1Wzt_JiO8Qr8xp3XJGCZiaALV2WlVL4bnaNw27hfgpu41gA7GbZJinw0K4
Message-ID: <CAAo+4rXdQVUWUCpi6=k2--hhFMw5+ghjrwE5NqXfsW0Dt_o9pA@mail.gmail.com>
Subject: Re: [PATCH net v2] tipc: protect node reset trace dump with node lock
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:08=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> > +       tipc_node_write_lock(n);
> >        trace_tipc_node_reset_links(n, true, " ");
> > +       tipc_node_write_unlock(n);
> Please use tipc_node_write_unlock_fast(n) as I mentioned before.
>

Sorry for the negligence, the v3 is just sent to address it.

Best,
Chengfeng

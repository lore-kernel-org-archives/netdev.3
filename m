Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05D4D0CF7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642798; cv=none; b=Tm1rRzMOYFz8JgkVVtj/tYkjzS8qu2y1aoJHX05YY6X7jWfpIJ0+yVRUlCvG/LlpNYmg90+lL1w6arMN5lu+UIf0AIWCpo+5hE53jcz6rMjPBGlPnO3NYoM9YoG/f9M3E4Pehk+aC4LJZf2XfPzFTCetbClZf1UNrBuv1cpyTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642798; c=relaxed/simple;
	bh=8e8Ah+7WlZHbhtXBLLlQRSAvSloayfN47Xg8BoeWzkI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jpdeATmrIkBKN5E/+hg8JjjG6VJmkFA0SilZYP5C/KCEwxietkl5RfFz51ponUPTvcX/UZ95RdgoghIBDFtTIS0rb/c7VvY9Pr6NTCFng1hFTBI9Vo0I/71zTBQVKbEcot+yuZc//6fpVxYe8gEu6BchUwsvHiwRKvLPyeu75rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/6iZZCo; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/6iZZCo"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so2761555e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789642772; x=1790247572; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h0M7opCWPOuxBFEuwAzPAI3fMW+G/LVbMC9tyOg7hDc=;
        b=d/6iZZCoppIIVZl9QpIgklFXZXZoKkLRQJryB2oLdVbShfOhnrYe7qEzJKAGHg9Fhs
         9HaGUP3r3/vT4HfOI0wARNf9i3EP9pCxoUekepUKAPKHN4ZUo/fDlMBbPZFk4NuMEtpZ
         jEscfmibdxyykCl82IEkOU5qwoCXV9jQaErqKObXxE6udizhFIcWIRq+bO7BgB++Pixf
         //EcCX2xtTEmJksO8NE9/8ozoG8X1ZxHLDh+UTwkgVZLA+06A1Rrmdab6x9Shl7mnLuD
         bEdRFB7oiOeClRwahH7eXIsFmpiJL+daucAfypDOcx7MdGLbpe6CdPnEBNCwYZ47Nzxk
         jqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789642772; x=1790247572;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0M7opCWPOuxBFEuwAzPAI3fMW+G/LVbMC9tyOg7hDc=;
        b=t4rk0Yw0U1pJ58b/+TlkMy6a/k9uNBXqlnyUp4qUzpaPOgkyUkRIXGOU0iS3mN+wNE
         FaYo1Vglqq4boX1Qw/sXrnXvlMygY+CVb2A6M0oq4eyy1wK7+SKxMO+sU05NY+9bDxdI
         qrHv+Mvz97qBMB9Od7Uq32/inb7DjELRPK3TyPcHd+vIre8QQ19H2PspcbEjaZ1VM5EY
         Cv0nz843Sbh+s3BOrgHs9CWI4GLY7MTuz+dcxdd+hRbIM1srTGcBSIQdAP3ZLV3xqOsJ
         GSsCoWcYDYKtD0cFhc5yxoafmajLi0LCIkQVayd26KC0UfrRGWScIS7MGaNVB94zhCob
         x1BQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIc92XeqEB3m5cwC1xVm5fiY7epPue+58mZqnZlR4xDP9XeokBcwTMuZ/jf9Dn8fJ7z+yrbj8=@vger.kernel.org
X-Gm-Message-State: AFuF++k1e0Qruj57KvWK/YTE8W/PdMdQaJDxHhY5CNLcZTwP9pmf2G4y
	35U90aflVVYHeLdYYgs7mZHa11/fP4dYx5Ix1ibC0ddZGl6+aYPIALE7
X-Gm-Gg: AYBFou3hQuWKQbZSt9j6997E8KU+dYI5qXMbHYcXFuQyNs+LDm+3hV6Hx6fI+LbqcZl
	KkPL0QMreu/nY+VXgmc1owL76MM9dfWoT7/jYiTOk7D6hL1YroCcHlfzoAYJ2SHPzqYuhFYVxnP
	J6NIzehrfNDDSH8LSpMXlwuGnFizDCucHbr+/jx2LVirg41tHpcaEypBqgw4yv1omP5KGlcL7pF
	0YhdRXphNRSoVBOINrcrNAVwvkqN1GAeaLr+zF2JwlFy4RvzyHYAEl/p3k1Hne9A4ZGC2I4R1GQ
	B4u2GFEVX68nch5WHZTyE9kAF0WGXgXNFIVByRxgosMSydcbaSbAHl6lh79wtBlMMa7rhwFCTyt
	pgkuHqgH4uYdS/m6DLy4NA4DZa02UVEbwhXSgsatfjwtIsNTAzWGrosxTlqCXi1KrgMQ+A/GENg
	OiZC3foCWfKlnX3RPI4UmkeiglQEIjxKITg5ZxRs7qO/i+vMDRZFRz4jmaeCqXE1JGpWd1G8hPJ
	aojVuHqCQ1kBaVn3GT6ZdABF0iHdLa7b1QSGfZwPAHnAYmGJvho16M8y3uglNujf1fDf97pkQfv
	GjAa5qXtSsDhEnAd2rUly4/RgaqlCKXTuywNSlU=
X-Received: by 2002:a05:600c:4e0a:b0:49e:8238:6feb with SMTP id 5b1f17b1804b1-49eb73088c2mr72472075e9.14.1789642771777;
        Thu, 17 Sep 2026 03:59:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fa70sm14454462f8f.9.2026.09.17.03.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 03:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 12:59:30 +0200
Message-Id: <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>, "Networking"
 <netdev@vger.kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: Missing signoff in the bpf tree
X-Mailer: aerc 0.21.0
References: <aqvBPVcN__UX8P85@sirena.org.uk>
In-Reply-To: <aqvBPVcN__UX8P85@sirena.org.uk>

+To Eduard

On Thu Sep 17, 2026 at 12:30 PM CEST, Mark Brown wrote:
> Commits
>
>   4499609f99fd5 ("selftests/bpf: Test global subprog callback contexts")
>   3506b9a2f1085 ("bpf: Verify global subprogs in each sleepability contex=
t")
>
> are missing a Signed-off-by from their committers


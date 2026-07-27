Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17813E44EF
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194743; cv=pass; b=jFmguxAsbj9HF9+s1dAPCZXgKHVxIgXPCx4UwbiVHhHyE4YthSF62lgfoGyaiKSVoP0x+om5mURmvOanyLW9Jml8D4Y7KFoPh7AD3G2p/LXhrqD7t5us9Rc0Uz6+/PPawffbvMhTREOJ5jLxXJkjoI8sCw4/EaxZ/RD8LjB/nSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194743; c=relaxed/simple;
	bh=YDFoIeM9uAGWV89Smtv0XbfcL/VkykO4RawTgHTQgnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fe/sCapSXF3dT2b92xMs75hmraEvd6hvcWGlmzERiFqbHXP/DbkZkSVqVJpTmYL/y4ObOjwA3CZxssp4TcOJwcGFIblW/5UacoS1H9onubBxrvblKaAAZBQJ43ybDx6IelgIiCT+jmcAYeIn4fgr1ZajNEmndeRHxIQBqan4dio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcqpGiYK; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcqpGiYK"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9f4ab2a6fso221540a34.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194741; cv=none;
        d=google.com; s=arc-20260327;
        b=W3aQg1QuhGnPXlR/eaIn4pT1+bG4ihbZeu5kc3GrdIJcFP72PaagIACHkmxS54zVP+
         /2PnOlx1BUwOItNO/o+vG4Np9TLmiM9AIUQ77xS03p4avqrJlRJH9o+AGi+CsRtlWutS
         SnyULhpuXMSVlsNZjz22BG18pYRyAWLgZt1/Wi4E2EY4rdmwKrst+w2pNxrbYGznTFW/
         IKk3oJNl+Dz+oS6k/hjPJoYTwKfYRu17jUW+bKKsLEScCJcQcIuksz2xh6IUKCjguWGT
         aoTY+sLxg91N+NHmhWm6niY6dVEGqyckYTxm8Wr2vHME7BWotBh+ZT/Z6aZEE5EimVKq
         svAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YDFoIeM9uAGWV89Smtv0XbfcL/VkykO4RawTgHTQgnk=;
        fh=A+j/4YyS3CCmW0Au6rFuhK1uwrM3hdybV6lH/+zes7Y=;
        b=n6rqjE/UL8wc84qpDX+0f5xok8Kf/JrMak7K2YqlBeJg3uEc3vcQJjINElo5wlbh+0
         GCthgZVRzRnsEav31Yrm+0A8YljGzd3OkVu20MpOeMOVEgr6t2JlS67q6JdOTnNiZPht
         BfOA+u1mdgn4Y2ZFAMEBoeKvokFU9uReK59WHmnQmRsCRuP2t8LiBUHF/bh3tHALpZGN
         zoDwL0spRkIeVrkn7ydVGbZPIVi/Lv7hUPNHKOM2tFLVMprow/qCzXIsBAriM+ei3qVz
         qTcRpRu10o1CE2OaG9vhbIhz0O481pxRHUV187yCORnZzP0mxmNvwAZLEr8YaAXrvxbk
         9Igw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785194741; x=1785799541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YDFoIeM9uAGWV89Smtv0XbfcL/VkykO4RawTgHTQgnk=;
        b=bcqpGiYK1Fad2TIUQvvrNBC3TZBaHetWkJqvuM9eqRjnw//LIdm8vpX/UlVqsxm6MD
         pqCtMejnvm374P9CqgrR/LyLiIAUoOSzyHSaXzHxUlsI/KRaCjfmlq9487SspNPhMs+P
         IllLHu3x868kgtz1NF7vRMDKiiv52lu/x//WUIzUzxbur/nZ2Z+39kFgaXyIkl63Ov6y
         sb8ua4t84zaGn+nIQETji5Qh4IkxMiBk5W/Ecob6M6iDf3qxsnRwQz8XQQisIl1em7ec
         Db4efOntmGtq2zINe+zMn3J9KE+l9UDJrSBUd+II60ID5eFr9/pNIeZEg1i+hyR2oG7E
         SZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194741; x=1785799541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDFoIeM9uAGWV89Smtv0XbfcL/VkykO4RawTgHTQgnk=;
        b=XoRBuUhqpSIPxiQgfeLh+hE1zhtTObQXNchDJHjzPW0VUGMnJ9/Jv9a975yJpePDTV
         qjOg2lpVHYTNFqsZm3gE9Qw4+PTQyPI7uPXkrVkpgkD+VCd42lFWuFwH7Vmpt55Jm5xU
         fkb3NCpsnlKvC6jsdcg1NHhppEaD+kPt6kCPbXVMM5cSGzsur6x8vitQfwMQW2PYNPT3
         A6CupNhPU2uWdTDfUhoEzAg1DXceHjN/N0tYsvYVE/tff1OLXRS1zYptdtt1GiZfvo7/
         Qp5pIISWbUZ9mo/g99CB7jWtHGSl/gHIN+x+VqBeNAqNfarZuHh1QcxRWEvoqTksH56+
         jcig==
X-Forwarded-Encrypted: i=1; AHgh+RoGpCp1jfE8fPkj/E1eFaDrkRPDzk1nrXvhw8DUUQ/mYwH6mknCPIidhKMWmCcaAPJNEqyUfQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckVy67hbZMtyjJ1pQ+U5vuUYJrGXDQlCptX5j3KGlNvxbrcmI
	LPyXZmhFovoO4cVnAAu9dyfknvV1MInwLxNXdgpCgSWZJTtE1nQsT8x/soBrVhtsbFLUMaQn/av
	yUNABGmEqVU8wvGHajldPaOTju+yg8+4=
X-Gm-Gg: AR+sD12cvVvHDk7BcAppKsTsmOYDqzqP2PU9XgN1qkZfxRs64dDoUj+Cw0EJqrsdm3t
	UNhAsR56mua8RJDd8lmdlNVFfNY0zgb32EOdSdRU/LW32NNBthSH5hYPuI1GN3BaztGn0fcIy3Y
	EAWP0IFMsAaMiF2W9Nct25tDzRmP4aXh+tbxdrwjYRlKCvJ0P5+G6g/yrv7AyIXbDJ/6vjpgGJZ
	TcvZFKKNfRNaHoiCwP34VNgid8LvZYmWGaMmLewZSAJ6Fe1xMaM5K4IZ3NOSsDECuo1hFjhPqot
	vg==
X-Received: by 2002:a05:6808:1203:b0:4a3:f026:58b3 with SMTP id
 5614622812f47-4ad52fd027emr1086255b6e.5.1785194740729; Mon, 27 Jul 2026
 16:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-2-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-2-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Jul 2026 00:25:29 +0100
X-Gm-Features: AUfX_mycyfFYISMK2axGcStjvdUIBqLu1I7Ww7665ZAKTU9b9w54-OqAdZMl7e4
Message-ID: <CAGSyskVQbewPm94uztnYSq3C-N0-nMFnUEZkC=mQLKVW-CxV-g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] netpoll: export the netpoll_setup() helpers
 for netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Temporarily export leaf functions that will be moved to netconsole.
>
> The upcoming patch will move the setup function to netconsole, and
> continue to call these leaf functions here in netpoll, then other
> patches will move these exports functions to netconsole (and make them
> statics).
>
> In summary, these exports are temporary in order to make the patchset
> digestible.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

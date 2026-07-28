Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D83A9DB1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270699; cv=pass; b=Ml2U8etMlvN+UU7uY+AXQTFdO2h0bkkxWPJgJaRgebOvqn78pa1ZamumkjTP21v9E5vTj8Uyp5Raeb1T8NdWXhGG3hKFH+tKhCtBnRARZTbeNOZOM/fe7fQSKOoUOHqYE4Koa/6YURhV+WPW/S5bytc27dk1XYNg9DJ4JvpzHmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270699; c=relaxed/simple;
	bh=n8ybt3+peqNU61fuNdbTRcVpKXAT4VrWbYEA0IZzXAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lj1hw1s8Cmi1NVfUx2JOkgIohT34HVzTKkeZ19ZRmUMw8FYg1AXA995Ei5h3LITi4cNss6D8Fi/E4LkM0dhnVK22wpk8Vo/tu1/6+H9SFavag7SYrDOO1AeLNXn8ubpbiAA0g9cjJMncoEqt8wDY8ISbfTgexHjmnoy+Atn+6fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7WhS8++; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7WhS8++"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso7685ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785270697; cv=none;
        d=google.com; s=arc-20260327;
        b=eCdjuBXlKgzMXX8yd1VafoXbqVw3PYfL+DyTodXkdYFP/b/ZzhBwB++/DTikzFot/O
         E1uFlu6YUl4XScM1sj178bOJgFp3TVxP/sQlKxGk31P2Uct9t/1vThN5McYZPBDd3gSZ
         xTB6NCERoO4vTBEZGK0li5rop1OaQ2adlkxwT3XPe2FFhVRcfY+7CT2GpguIRElWxTl3
         VZ5iLzpnH/FYCOlbFtSEsugwwqUAZsp1iTCQr1nbSyykC0AK1BS11/z0B/l9fo/H57NX
         XJyKA0rMgYN5SihPTE5+hqJ5UASaft1ybzw5eJ3elvSWHTJ0bBpnmaq9L2gnINUUq80K
         K0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n8ybt3+peqNU61fuNdbTRcVpKXAT4VrWbYEA0IZzXAI=;
        fh=/ld34rKLcubzKrOdGtkZWmM5pqkfNTjZxWtLJ/MVA7M=;
        b=CSZkkrNNwZxaoLkUOAcRqd4XDkuswBx4g9KDSV091wOozOF+Z9QqyjUzlb5CSh5X2z
         iN2ll6k13KtXGfFo7SJu5IaxT7a6NWNMw2g3nV10sWw+ohv0358Pzb3oT+P1oLC1zbpr
         YoWUE/xcxvuR8nMgkVOHKIxqN2hrD5lNBchY3aW+ua5qMXtPifvainUtJjOGLCOfKX4h
         9W3VDsE1L7Bfdf5nhnGVXuwTrQBz3hWrivKVEkDPIx0G7rxDTxIQ5Ujl86px66eASD6h
         74smQ097Pr3GxivrDgpOI2llZ1dqEt7QrPMnuYJB06/oGuuVftGEgxEBhudyt2O1FHzL
         +YcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785270697; x=1785875497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n8ybt3+peqNU61fuNdbTRcVpKXAT4VrWbYEA0IZzXAI=;
        b=O7WhS8++q2bkMXthmX+tc0RLT0HcKQwZdhiKgwbdHYuZniW14AjIpjnM7Cl558utMs
         2dlIO2Rj6gMYfqb/c98FqkYXevI/FJAPqObZCCmUERbAmjM9rwXbvu9am8y25c3KwKKZ
         wzm+cEpZg87kL0Cd3ZLg6Y0MoK+eUdj6UgyaPItvMtJ0m3dkI5ipoGlLDa3pKJHYmVER
         Ft0l/sM66nIWC0qooqR3m4NsT6Pzo5GgfUMtTOeJhepbuXanjqr5Y4fExkmeJCuNN/iC
         8q2cEE6avyf4FCDe8mgv2dWQnoDhWTNdR0AQV+0ahspSe09YGNdCXpYvwkCBdpdJUhm8
         LoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270697; x=1785875497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8ybt3+peqNU61fuNdbTRcVpKXAT4VrWbYEA0IZzXAI=;
        b=RsHmElgjEGXowBRyKxkC8YxqeoYhS/qMZKXc3R0A1nAiEHVW6JRt4aPnt2VjlnI6HF
         lqxLHWnj6HEMl7kDB6Hrmab+eFAlRyF967p5dyYRNzqIDiyJ+I7FDZ6xNLMN+IQJ+39B
         nps2vCMOuL3xxCtyhmxwSRE3ammY5f7vwTHwDM+MNgdVq+mz9h8nKSou87Qdgqpel6UU
         R8n1ZXH8UTUeNDWgl6ETnZy5VQKL8/Xb6RrF4pN0eVpyti3VXXqGo7NCLWW8JPOVRC+m
         UvZq/B1bnHPdtldcbqaxmw6wGU9H5hfB0beQAkLcbfOhyfAflGzW0t2AVpGT0x8+gSJ4
         CCNw==
X-Forwarded-Encrypted: i=1; AHgh+RqOKS6U8BWRuu8SJR6qk+0MDOOqCf75sTESCgIHUKQs09vIg71iry4tWqz1V2poO25ioT2pwRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3GzzB5cywU5N6Hjq+3oCCoAKFwq+qn3/lPZcnq/D7teP+YEA
	pRDYbKiTubmJRdeT7Wpbqk0NNWWcviDytVQRhez4Iu3x4xB+fx1rTFFLuTiCEG6A4ltsQ/x1rxJ
	YicYSOj1IK2ZtaPtHqnsL70o6CZqAn1o+h9JFSuFM
X-Gm-Gg: AR+sD13Q+OZRc2i5scVwe95j+BOGwrkQORSLPQq3gPXStb81s9ufOFGIUwgg2HFT33T
	0R6yXgogdT/v2PHmMa/PqmGP/Hv7dtBM1ffMGVQrWk5v/VCjKfyPEtATMmYDvLEnjUBpnK6aqrb
	pD7m+BcEL0nVAksHFXpnPewDOkYXXKLpjwKwVPDMwT+0A2n8EiFDI3zYZfwgnKW/0Lta0OMVNaa
	yVI8oRJTdBIn9j94JikfdawchU8VHWeOlQZ82zUNTyQYTyFl/K/EL2RM7uUIQOqSNO1DKYe+E/3
	rOdzJMFqRR8mHZFiB2kcFgOPzV2t7JTqQZUBG4Hu+oovAyo5IjrFniicb4G9A+4TaDyhFTgiYw=
	=
X-Received: by 2002:a17:902:d101:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2cfde0a0bddmr15708995ad.7.1785270696880; Tue, 28 Jul 2026
 13:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
In-Reply-To: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 28 Jul 2026 13:31:24 -0700
X-Gm-Features: AUfX_mxtbGAjcBaZBwZlB-VqOyBkKjGe011qYSHDdYFxny7lODZxdnAbOBMutK0
Message-ID: <CAHS8izOdPqA5_rBdr2LcsBBQsrS_4xNY77uUnm7ZrOLz+hj7YA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 4:19=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> We should either have net_iov or page backed frags in a single skb,
> otherwise it blows up down the stack. Don't allow mixing in
> zerocopy_fill_skb_from_devmem().
>
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

I actually really liked the EEXIST because it looked to me like
tcp_sendmsg would handle that elegantly by sending the current skb,
and then starting a new skb with the new mem type. But it doesn't work
and as you noted there is some value in consistently. Also this is
much better than crashing.

We can follow up with another low priority improvement that allows
mixing and matching types in separate sendmsg calls and separate skbs
actually work. I think that would be nice.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

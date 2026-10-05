Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828464D0A02
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215296; cv=pass; b=gMcxxWS34Jr7ghfuQNQv3J8bW6xRlSptAOtSbjbnRqrSg6S1LThvjmUcwGia99SeAFbNmwJFt8bWqBzKrcZQANrmp8rtnjwVWlfMGsxjK1hu2fqWLtpUfJldzMlLHamt5t23RvbpBO/ombE8rLSawW5Pi2mjDqrA5B4JLtsiwTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215296; c=relaxed/simple;
	bh=lCgO+hyv0qYkNrN0rdtOfeWSTqt0Q1A4GeKqAbSb+WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeB2nxINqbwfkc6CXoJhwbFIvDwNJJcRSIpZPW79GCfNoa4J/5XiNtWDKREmjLvFzYGDdrUrq4wVulZQjDwO6miholhLr7kec6ZpWLuCd69Me/SQNsDY3GeFqfSekB97fOw/Irkm8W7NkaMqYYaftuFypxZOOGEKaE+2a3oeZbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SeIVELEl; arc=pass smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SeIVELEl"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6dd0088ec00so561324eaf.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791215290; cv=none;
        d=google.com; s=arc-20260327;
        b=IPJ1/599GRYrJ3/LR/Yuc+WhbN71VqesGEqsVr4Q8/LoMVXA+xoQ+xqFRf8aVixDZL
         nSNbCjdAnHIr3s/bPFcrBHzBb9U2WO7B342qguqQQNhROrjaHs+U1jZJMco2014OHqgm
         nyZbhtfq6Ds0U8PFwhhV4lc1CUP0gbbPRBXZhdpcT0JNBpNfZif8YA3FuWl03yMfdSQx
         qs5kOn3YCJZww5tOCECW7mqy+fEyw/i90U+kqmU0Z1eVHjjfeXFBMN3QtzaDKNjlFkcC
         69TwRH98stCRzOizOBE8PgpbZK1PiV1iS3ZWSbXzTsMTCXRxzAsJgyVrh7DHMdnd98zQ
         YwDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MT8ycgPPKiD3g7R22AfANrmwMssDgoHCOevjrATZjAU=;
        fh=g3xDAmnbGOMPAxn8ARL7f/dzLtvytpLxvXwUQLlM3NI=;
        b=MvmhaTw7yQLxSurpzNmtzuycwoaKVmA56SIJIGAtGZo39II/1jjmi9P5eR3J2UbN+w
         B2NbDW/tOcBz8p7hsVOgHroR+I4XRdoQO7V8jU8rlAfykVbG5o9a+4IqA5JFJW6cxCj3
         unQGWh4UY/4M5gbbWHZSY9eIkfCbZJr7O6zxSAd+ORrwlOJ7dO4+Kzrgnd4pc8bBB3vR
         vDXr/4s00/CAtM9UAfqMzhH1iqElfid400ZLn7lbEOUz6wAvG0z0PH51XHdms8YBp/fe
         Af3D8f+ewhsyPDjPuHs5+gNKbV1YwAY1ZdCR7UQ4/WqkOANf6Flk0Hde4GkpwHPTdkXh
         9/8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791215290; x=1791820090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MT8ycgPPKiD3g7R22AfANrmwMssDgoHCOevjrATZjAU=;
        b=SeIVELElWPNX3BhSmNmsQkJPhVTv5HVLRuMOp1+tVh1f+pSzRz5p3NfUJ7DdFHHSIu
         ZNzTpNfSO6ta0UCzjMV1BCmofjHl6sgfr8JfrtLAkgvXrW2U0307ir+A+JEke9ogSeiz
         QlSAmwz3A5N2rKExwu/BUoMTIHLKueoChDfyMQA2DkVwWvw5t89hel0Ur23HssrlO7q6
         La24Rn8L39Z1S8a+VYrrnrXRT1CNcIOO0loYlBBxMDQylAqtLJRrhFT+gpeSmICr0ZPq
         U07ZTzaZHMEJa3jz7KVVU4wgKMpu9qElzsPRR478fhj8825k0KpfKQv3QTLL7PKSuSyz
         tBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215290; x=1791820090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MT8ycgPPKiD3g7R22AfANrmwMssDgoHCOevjrATZjAU=;
        b=BMCdizLlkYvQgOq/6V24H7YDmQAjcdmDBqk0PXD7AY12kDjKh5Fn7w2S/1QhyFpGjO
         /xS/6h19B6jJGnG83fGq4XM/jxKnhYIq4n8VOH6S+4+Pp/iuJ4GGntkVzXbtrdFUHB1R
         vf1rgsiO5gNaea26Z7c9BD97euSwKrtJFxrbrvij5ldNJVsoHvHixMe29Uy0yhryQ5Ih
         d78llNx0Aym+RnTdLSj/9RsYJpE/v89d0U4rfStcB7gKZBBU3GWFDVvQrvE6+mukGblL
         0KWYjF7K91e0opHTtkT0OX5mXNgc9IinaHjFTGBabWbHde0MaH3AdS1JWcZRLFRPmT9e
         ixag==
X-Forwarded-Encrypted: i=1; AKwUvBzG5sezLM9FDAf7RNV+s+mLiN4xXruId6mGFG0Xn9BmH2x23ZfMfaGD9moVWZNu4NHEVTDqMzs=@vger.kernel.org
X-Gm-Message-State: AFuF++ndAQHmWXuMQmXGo6VGSimQjQvU5CUkeawTmZBX8Bh64uhsXTgx
	zVk/tm5KQjtxKmZXu8k4iYdWQ9t2zIcxCwT5mi5D4rWbGfBNMg6b6TEb5a8pz5cWRM+LNqGe7FR
	By8mQFQSeSUSfqybGV9HDiE1m1twczmjjKOx4n7Xeeg==
X-Gm-Gg: AYBFou2s3VAcTE7qHCYYdEcjz15VIFzfFWEPubbTJsAVNSHx26x6iEyfZCLuLfDpq6M
	TEUQ9q7k5jGbCpoQ9/Ryd6jkcpeLBQC908SOeyq7C2HKPc7iKbsA45OzATLhTtV1ffL0DY5ntPG
	3PsfZ/xIR7fh6Xd1kznRtE5a08vHUgxbqvqOgbAhLFiPG1zHTLR7DEvrQ8YiwvmHRdJBqKxu76l
	8YVyvOTU3aA9/JbeMJsDBsR6SrHtaQl7g2sZFksK870aSaLIqTP9V9VS5J6bSOTfv6QKoPh9h07
	H0TZxhkJRcgEuXDluXlGUIiz/b5qHYBw6ye32rwcjnKmhPFH1l/AAQ698Vt6tF9C7+qnvrzDV8l
	LqR6Irmod8IfykYyka2U=
X-Received: by 2002:a05:6820:150a:b0:6d9:ea50:f44a with SMTP id
 006d021491bc7-6df357418abmr8292012eaf.64.1791215290453; Mon, 05 Oct 2026
 08:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002102447.148835-1-bruno.produit@trailofbits.com> <179093698536.1402591.16703491801413392699@kernel.org>
In-Reply-To: <179093698536.1402591.16703491801413392699@kernel.org>
From: Bruno Produit <bruno.produit@trailofbits.com>
Date: Mon, 5 Oct 2026 17:47:59 +0200
X-Gm-Features: AclHuK_EjtDLkxbH3jFds8cqgFV0udpfcmHoFvOHa6Bnt_BLajOkWE2xSjD_Z3E
Message-ID: <CAN3w+PN2rf9eg2h3qK1yc4bkvDHNpuDpKoo5nBWUQG=gCQ3nyw@mail.gmail.com>
Subject: Re: [PATCH net v2] xfrm: espintcp: reserve partial message during allocation
To: netdev-bot+sinfo@kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, we triggered the issue locally (KASAN warning in this case) with a
poc that I can share. The (shortened) output of KASAN:

WARNING: at skb_splice_from_iter+0x380/0x7a0
   tcp_sendmsg_locked
   espintcp_sendskmsg_locked
   espintcp_sendmsg



On Fri, Oct 2, 2026 at 12:29=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

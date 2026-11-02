Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614912;
	b=VqxCIiLOs7fjZIzwkOF22virxDSSGgVuDHXQZhdp51WKQllL/MoSy7D/Am1DZiAtpBfb
	 cP+w8JpZFGq9CvdZRlULOPKTWRrppHUX3pEMP/afXJDtu9oNp2SoLmn6TldZZk8ciMqPR
	 S7euxBFKTMdcAoLPsXGq3BzAg4+Ot+tJjTvIUjUNLsJt1e5ryh9CKViZqncceE0x9rWpV
	 2NfJNQYZ0OeZK+6EuzTaL40s+WOop5DhtHj+VA3PPx+ap1/fWQxk2VH1qbPdPiScvDM2r
	 YN/05xIRfPhv/giJFfGfZ+OeGUwmlCqTDqULPCcW6F92ioNzcYaaEYGKNimLlIzAABQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=GhU8Q/cJJy3w4lZ9hTju38RhWn1kSAjmp6gv5uLdV8s=;
	b=JG9Hlhk/CaUhEP+0oPVSa9nJMdzk8OKrwbnREXQNjCfgivBmAEp9szhcBdNVJ5OrU1R3
	 uIYfTW9duLKW35V0rQf75w04ktmd/bXgQ/bUPE+HL+TChnXMwh4+FRwL40zaWkSLffqFE
	 vfn7LsgI72NaE4yOEZEgU7BFUWWAV9NXbgGTa1L3o2YvKtWXnOtzJKrwShZ0Yr9H1Jlas
	 tqfSYPJlQUQikRW8mMYldNO5my4xu2UVEhQ+CuqmrSDbLiZtOm/h0/kNRqejq6AhiriWR
	 Apgw5zDi7x4S0v6P2pZ24SQV87DHc54HkXrGlVH7jO8vs+6ii1d7fwtJnnoSu9Jc6xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5tahd3S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734F606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2734F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g5tahd3S
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-55651e7de9bso1752603b6e.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 02:21:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793614911; cv=none;
        d=google.com; s=arc-20260327;
        b=K4kSXwZU7m52sTmYpv4opLnhuHU6w2s5+zVTiqo2EpZxk2ZGJ7g9hg6es+kv/BKCsF
         Cu5T3dUwnSgZq58XqfBV9lug0s+SMJIjCKNN3XrV0tnNblLepYrWI53S9h5zI9LKA5Yi
         AmuzHZbt2+K5Ley2fsgurDIGtS+NloAJAq0buhd5LCqjUFlj+a+iu7DnKAKwQuWHfYO+
         x56TMAgrw9EwMj9XrUe7SmDl2Sj/e6kU8ZzCDuVq98B4SMhjRSZaLYzxZ07b1S3kN1SN
         tem7VM6vt6+jEeJzqwI5yvbA2r/ozD9Xr3RSuA/1X42k5TP8khdXn+TwvfOZwNSeeUFL
         2Lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhU8Q/cJJy3w4lZ9hTju38RhWn1kSAjmp6gv5uLdV8s=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=RM8bdpqDykAaV1lHh7b33ZZzAz4DMFgh0e1EtC2yANqaOMZGXmSygJNbNbmNpIpQSn
         UviwBq9u0DsesXmpX3r1x6oOPBrfTGIIgjjLz9j6opmD9WesqADmXhMSNeWq2+qYP2fv
         KPoiFcaie/eRLfaZ6jRmp980DB/DXtxon2z6wcI0h0XKBbSBjxWMV/y9zqbwk4OVIrLU
         82LC81gv//ESvQ12lsycw9dC1sNlS4/xdUAHDtH5rGByC32l1GB2cXJTEdE4KMOg9L3X
         M/meTzOT999z2X8m9Dc1xxT3tWLuKS42YXMlpAS1xCsU02pU8WJj5ye1R77wYgA+DDPv
         K/UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614911; x=1794219711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GhU8Q/cJJy3w4lZ9hTju38RhWn1kSAjmp6gv5uLdV8s=;
        b=g5tahd3SaKufBJ9hYRm4rEHjocfqSdsJCaWCYRGdcbhLM1GQuP6CIO70pzFRIZ8NyN
         IAONu6afkjQeR6S011BPEA5bga+ooXeyCBu7jOK54b0k9ehP/VXiPBevGI13n0NHPpE7
         AWBi54PjjVsU6jAS/xzbO8ANcerNTLEx11hIIhh6ktN6wlKVXvAJ/Ye3zmqkHtiwv01U
         BDx0QF3AEZUuvAnSrguzJJWXuUstoIGiCyN9i4eVggan40sz+PWjLxgGYTURMsywIZIU
         iIj2oCr2aMejGpgP2rVnlNa7yltDYijV1RNNdAy0yIWkd3RdmeCrHDxwqsR1TJYplrGh
         8sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614911; x=1794219711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GhU8Q/cJJy3w4lZ9hTju38RhWn1kSAjmp6gv5uLdV8s=;
        b=cpjNwByCGIXJDmQUSvltF8Y16AytYwJy7xsGt0bEiAwg8yJ0qpiX0uM2DSZgQf+gGl
         2MCQhW0kuq2rKUSo4WbWJuGWSLaXGGgQyTE7fupfU3ppOjm/8h25zSU7VV5Upv5Muz0J
         kmdNC8bZmoyX+KkxUvclNbKgD89+cfgtJLuLWiydZAZ8o81DdiIZ9hjhFsFC/iUB+lNa
         TQ5gXyoPLrdFc8QW8sULNMgPTstIr/uGY9SChTN/kLliIPHr0TCtri1t2iLLsU/C3zHM
         sSS/9Tczcprkt7hwxqDILdE9cLw0x1hjEAix7Ez7/CIVSYlYFmJe/fTw4JNJFe4xCsXn
         yYkQ==
X-Gm-Message-State: AFq9FYJNN8bHl2w1DlRdU25RXypxuqAPWPF6AMc6C40IRJ+st4zMMi5j
	VR5kOOhEXIw145C7dKDY4P+XIs/vTfLlhgQ3B+l73u3A9BozWgCf0QCsv0ESCL3DZZR4tvvf4/u
	qKSgVcpzp4Q+ECZNYzfmBksYtlexpNGI=
X-Gm-Gg: AYBFou30xyw1/zEHfWUZOBI4+NUDLLD/lIXrY8tRCNBUw4CevU/L74h33vtFpUIL43F
	GFFPaYtt3ya/ccBYN3lC88a/b/WdCZTHBr8TbrTLhRvBlRjNy69bHTeM9f3rqk+sz8GFQQaChz7
	oiBRMiu1p7X1Uk4dmCoavfM3vdHTWeR8cHxCX00E6rKZAKI8vOJSNBKB7dz4/moQ7SZJqmig6oB
	KvZphwx5gLYXgCsENAo6ahdGj/thMh2J8HHV21mpNbBxhp/YSG0oiLCsVUyktzQQ3i62rq1olJy
	3yosftoIt06gl7KodaftrByf/wBp93v2S5WcMOf3Qmc+2ocB3P/u25RJoyqzcgtRRe6pQCMX10q
	Q6JbMcXyO5Uqk2lj7SMZeog0kTdxaaqn6OWj5kml4GYSVC06wq0LcPXVxwSW+kariWIlsfhPn
X-Received: by 2002:a05:6808:1997:b0:4d5:295c:a82c with SMTP id
 5614622812f47-5640df07875mr7051521b6e.57.1793614910826; Mon, 02 Nov 2026
 02:21:50 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102101334.3525485-1-mmyangfl@gmail.com> <179361478774.3286.6135052914469846414@kernel.org>
In-Reply-To: <179361478774.3286.6135052914469846414@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Mon, 2 Nov 2026 18:21:13 +0800
X-Gm-Features: AclHuK9EuNRiZdYeao8ildznh5zwU0e3Sd13NbnRuHgwGqK6ee6U4mqlc5fMaGo
Message-ID: <CAAXyoMOTcNS7p9rxH7cLTDJ3Ar_Z44zQTJ3Wp+FGiEBT2ZhhMg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Do not publish partial MIB sample
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:19=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
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

Reported by sashiko

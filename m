Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8347ACC7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334088; cv=pass; b=rfXBpkc985dHZEQLuVPvMdLixYbtEF6UoIAK/s52nRBRvC0h7b6Zu+Y8aSKcpmIDws+XO43BreJBvqsx2SlyV+wS66d0rrmMTxjUr3Qk9grIABwIvhT0w2WTWLgNGofCIO3TTr6iPQZnjp/9vjLFDdUt1b0wGwgtBdxhbBcq0bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334088; c=relaxed/simple;
	bh=m0bfG9Br5YGJE6P8kfzFJXdSno2Pns6YnrNcy5pwkiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0UWpEOp/RUtku/+wmuSAd2MNDrVw3SQleB/Inuy9Vc1M/TJnVVZrGRDHTmVji7tDCbn7lGFpJKZG3Lzl5e5Z+j/A8R171Kdtu4T9Qjl9VFiwG4PP4SLENWsZd6kWg8q1D0Jwju9Hkn6KHZDWfkfrKiX2Y/R9owtxN5n6UBqqgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPiS5nFp; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPiS5nFp"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4ab246dfc90so41233b6e.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334086; cv=none;
        d=google.com; s=arc-20260327;
        b=Cb7SQvAyVMBPmddFruflhi2h4DreRkT4x0g2mIX8KGWOiCMJCuwfqJR0gt2ClTsDX4
         xtDmmXFCT3mop14AFT01TDArckJefly2E4qCmyfO2xZzfPFSE71UPqtqBJd2FZ3GRi64
         RXM29thCgE+i+Pt6gkuqb2pcoYwoLD+/IZd5QnezwAOxp0FzPICjTinAbrXNWe5paWY/
         m/q/3aAKXIiHLGuqY8yLAN0LNWsQ5q1ZlfzXrZbyIIrCNYJAlXa//N/qSedwq8KweB3r
         ZUL+rISw1nlrDQMH2ZC2tV4SYZ5F9yHCJbZaVNVr/yIwHJ11lxikW86wnzolArIUEvTs
         QTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0bfG9Br5YGJE6P8kfzFJXdSno2Pns6YnrNcy5pwkiw=;
        fh=WDFALviHMrCqHYUXOOPZ3QjMcPNRwofmy12kUNShc8k=;
        b=jMLMGcqMr7Tht61DskdVFDpTo1OCc43ADowOVQbLBgwEnahJm02LEv5gxUox3PmeyR
         02jXenDxz3popmocQbp/cZqmXnjXdiKK3fXp/ymx+szMjPeSC/1GWgEUDL9zOdeitCL/
         eUizfvrmtkbqcD6tnjZg1N8aLx8NXENmyQQcpLX0pNdnE9rv4UlVNZGLjlYyMOP0hAOd
         W5f6PaSJc0QKM6RHwR83MslQV3jdGuAL1r+NmK0xdVJQmSrrJeb5XUbzxj2rMSmkgBVT
         D7Mjy7DUr1dKzawkinF4CJawv+V0ZwpJTbHrX5e4wZ8s/QH5RfEFGJUUI5XUEjcnKNCQ
         m7mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334086; x=1785938886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0bfG9Br5YGJE6P8kfzFJXdSno2Pns6YnrNcy5pwkiw=;
        b=oPiS5nFp9TCCdEz59JcZsM60b9vupLchN0V+//GW/m84xBfn6wjNRViTy+RnRmpof+
         UBfvIVdsozJlUyjoOdP8ZC7Y6uc/dpKaObVIvtMO1PpfZxfczQ1dhMM2zNeVFbBQnoxg
         GgEFxHN5ADRrPl6vMSD8uAc54P8Cei1W41LFS/JMeU4h+NPmYgY1eH6KvA8whhPLVKDa
         aypGAUEupBvlFnuTbDBhExGjVC4BzEVqoIKMdBmrO+AaMfD+12LTodnXEhxmi2dMz7Ob
         gW+AjmkYvZvVznRbsx8qq1VgU3qKj5/JKICZJnT//UieBobJgZPZv8C2kWNUWFx+sYy6
         PHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334086; x=1785938886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0bfG9Br5YGJE6P8kfzFJXdSno2Pns6YnrNcy5pwkiw=;
        b=qBAJgKveu/HCELkx86APZjD/ePwQC79noPS0qYDzvsm7o5/3JzjxxEouSb5Qw1hPPi
         nvMfsH+3cXQoDQphu1vufgZCmoPj4YHiHVNlPt6Op8/TCsX4XF16QZeuIMs4NM29ds6b
         hGSPpqLU7TsNjQSrP3b/V+uNwpcK87ca6wSoMXMRdfPAugnDEUKBpAFPirwYbS1Z7L8w
         ePRhYiZjRENk46d3G0GgkeauNis0mUDlD9cxQzVUDVmcCSm3MgIJKD5u/TQwlHJKzf1M
         hgvcyn8eiYq88+G8ddA8Dst5Rjn5Y2F+3ZAEN9nJJajZTxOjFDKaGvBrmooQGIZSt6OG
         0uoQ==
X-Forwarded-Encrypted: i=1; AHgh+RocN3hLDjq0qxCUqvi7X8AtAkt4kh+VljSaM+SidmU1PRZQQ3GVniAxr1/ZgYfOfsAFj/qodNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AhXyREfXFcn1veTTfwzXMY1Mkm3jJxhj44fOEExLIiH+lAj5
	8EkZxqxAmwxk9knFwOPeQ29Xeg9lktEi2t0YVUwIGOlchdWWRQTpOcp6k3V+QqLhjkVW2lCM737
	qE9Lo2BZaKFKA4TjAzG6wuRK8BBDqiO0=
X-Gm-Gg: AR+sD108ihJThmdSW97m40eX3Z8g5pyICiAX2kiUT/VnJcqMHeoUXJsDBD16S4JJ//I
	RPXLF1buueIPVmD6uZAcjoQ29d2BfI3luDJqkPheetTfXQM92aATY9JcEu8NgFfAqOh2R0cYnVf
	VLiJJ3xkh++z7IrHy8iA9EWNpehcjYcc8qXoFVKBPdCu+WSI7qCyqXHewZoNhUYa4RC1joNMTlS
	W02AbzRZUmlgTX6m8lVSFRqWdgNWjzPU+KVxraAAPlqTzDmb+s/WmyF605UolXGAzDyZI7w+4PD
	4JWocfbVGZ+Lx3ITxCUvWQvk/+CPPMEMt9TY/RYloBd8PLzISwyOJDurW3l+
X-Received: by 2002:a05:6808:ecb:b0:496:d5:7b22 with SMTP id
 5614622812f47-4ad5b9b9c77mr2998771b6e.1.1785334086283; Wed, 29 Jul 2026
 07:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-7-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-7-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Jul 2026 15:07:54 +0100
X-Gm-Features: AUfX_mzXfoNqUTm5CZj5v2bLjDeLae6tJ0BEyJbZBLJ0ALGQZbpSzvKANiw_MY8
Message-ID: <CAGSyskW_t+4BG3hxuD5mLW1ifBid8oLjwfqGc13-iPHsj0s0ng@mail.gmail.com>
Subject: Re: [PATCH net-next 7/9] netconsole: move egress_dev() as netcons_egress_dev()
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
> move egress_dev() from netpoll to netconsole, and append netcons_
> prefix.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

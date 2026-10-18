Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61340EB80
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355673; cv=none; b=ABAbnKxWiOXPgC6ySYd30enEsv+9qOdS7zqdqMRaExsA3QGIlG3UU2kCxGo1ZjJj1Sw+1dV5ZgooMQ60Wi1DRzPj8oSQFjbSrVi5WgoR8wemW48ILYGo/V/SNFyKLXHZnbt8vKschC+pMVanbCMT3ORW3p+Z1IKNGl0XP2A07Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355673; c=relaxed/simple;
	bh=mGtMxGvGMAPxZX+KuCd0vFb++3GQYItv+c8z4egM++c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e48ZA6U2QTt7VKNpOHAJXhsbTDDsJtEmGl4RCOysYu79/VoES4Zl41REL6DR/eD5/GDImXEwtFucJsiE8/jE6pYfRe7YHMD0W05lIJ8P60pzNgJQEMHpe5PR59bZP2RkUy+IiuM4EeZnfD6yCSKfnQpADDiGmbIqKQhTcYifdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gqwLDKu5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gqwLDKu5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40447e25e6so160289066b.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792355669; x=1792960469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcZudtVZGXqPCpJjVd+PjoGGou1YwE9FLeXdn5NeRV4=;
        b=gqwLDKu5s9gordUFCi6XC70nosY/hZjBZv6Qb8r48rLLHMiDWFg/swEdylGSGbWspM
         uU+2cPaD8Ciz9MwAuWxhkoE1LjLgrtgsp5EGEtw5FFerYl1WGfU5WBn2tvDkb8QkSGs5
         FjQRhQrl5cEPlT327Je2O5ZAphnx0itGXUk3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355669; x=1792960469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LcZudtVZGXqPCpJjVd+PjoGGou1YwE9FLeXdn5NeRV4=;
        b=u7hqEbv35lHNUDl5IagVTNOjpshE55zO+cpZhqXDgSWPZr4J9+A2kZDfywfKG/Jd+A
         ns3PEL6y+G0T7C5rRk9kMZ785WLgQCMZHVaQ/g0E0l717wdHYz1pGfxiY5HcVqBSimcD
         1g+HX5OeXIjCElqQ9iySyXydFJ8FAfe9/8N8LdQSkZmcgkATYKUlFLTxO9RjIWPSDz95
         DReaRifFkS5XtKicG28NZe1MleeXJrmJ4gidCijvHPfN94xzz/WZ6Zn95r+NtLNos6BV
         ABbe15GEofAD1NmRevZQeU7iD4AxkSOTkp5eHirUbbmz+bpVYceL2AfCcGj9Fo1T31BN
         ZB0A==
X-Forwarded-Encrypted: i=1; AKwUvBz+c/uC+JxggZh+Gw7NbfncdouhlW+XKqizKUZuh5K9TGmF8AHEo6kxd1+x7kxku+hxrSs0Tf8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6J6QhO6mmXoNhyW09YLHh3EzJPPw0WGK4B4e0WiYjcpWJAb0b
	6sG5qUdRAdaK6sUH6iZPA7ChRl6MUNe4cycJBGbAu7tBxs4i9JUaUrVs5KS8Qb/xVeaW618RbbJ
	dDwFgHvA=
X-Gm-Gg: AYBFou2Jy8p0L0pTAOECNHTSf2yN34uX7Gwj2SywHrJ6HOwZOCmB3c6Z8JRiF1yX2Xs
	oTvIH2YNrgqr0Gs4lrs1J7s7Hujqo6JQZOH+BLdvOYsGb6etO7wOkecziZnrzI/cn141LQaJrNO
	8f6HDA/2hdXaa38tuRKct489FEQSpss8sUCZi+WiAL2r6VoO+11acn/Fs4l9+/KiJzIlTFEuoMo
	JG4eou0aQ4iEEqVnSBkv1VCqGSCcfbxrgq7ju/CWS8+in1ExJ6EnGRiTUD//Vd5wYhTebyba76v
	3X/7/53XIuEgW9PzjETdV/pHiqPmccFHxgqlo3wmyUN3CxbnPPlHbVp/QyLMk7VLWLAV5IbJR9A
	TyiB3+hqSvTJD0BP4Ro/EN6gILgU+3/2Imj0T9JIkY1BdR+hmO5ojMUfpDtHMOwS7FBvcpuiTIi
	qN9CMwr3fTmxl38JBtVXZxWz5smR64cq4LrNV1Va6mub4UszwmlvswK8IdaGMgu5uwX3i1LzTjp
	ESQ/H0mdijSS7FFDYa8S/ebHb9Pb7l/5ixYCruq3/UWDXk=
X-Received: by 2002:a17:907:94d0:b0:c41:285a:46a9 with SMTP id a640c23a62f3a-c41a08d9fc4mr376931866b.46.1792355669577;
        Sun, 18 Oct 2026 13:34:29 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb1835sm290343466b.79.2026.10.18.13.34.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 13:34:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40447e25e6so160288066b.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 13:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxrwy9ODjW0ASJ0cABfJ493ZCwF3JhBzThXnE5xU8Jnrbs/JIfXh3gqjk9OgDk/Xr6qw5c0lqs=@vger.kernel.org
X-Received: by 2002:a17:907:6d0b:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c419faf81bemr359351966b.35.1792355668398; Sun, 18 Oct 2026
 13:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261018152358-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 10:34:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
X-Gm-Features: AclHuK98aalKW5kTezoePJe0elXfnFi_e6X010Sl6ShLR7WlXp_TWSCo1UYtPLA
Message-ID: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> +               __virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +               if (!access_ok(uaddr, sizeof(*p)))
> +                       return -EFAULT;
> +               ret = __get_user(tmp, uaddr);

You should never use __get_user() in the first place. It is almost
always just a bug.

And __get_user() together with access_ok() is actively wrong and
stupid. It's slower, bigger, and more bug-prone than just using
"get_user()".

The *only* reason ever to use __get_user() is in very very iffy code
that might use a kernel pointer and doesn't want the access_ok() code.

Or old legacy code from the last century when __get_user() was faster
and was inlined.

               Linus

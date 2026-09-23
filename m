Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DA53E2ED
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177937; cv=pass; b=Oh6CLMcTGpD3e8DnxtTPV5C6w5KEj3LNFKTT8rQQugKzG6OaAgfJePuZr9lKfhExzzF0ESKgBi+cB0nDEYUQRsAhgfp6Gyn72wIo8XOmyi7Y03D5ZdlOZjpsTuy7e4dPoMUkoqPYvW1HhvTdfzE16mCcWyc4EL1RBFhUcRxUBto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177937; c=relaxed/simple;
	bh=471+xwzsHhix7zeMBIIU+C2QTB25AzHe0qndhZvonm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/r0dpUcZ9Lten4k57/x6tUix/Cv49bSjhXp2HV/QwyNZql2vpJTH9ZukTNi9qTUapUFSZCuCo103IWz9oWTIfGh+ppA6RTo4BDi8zFt07IZaU/qwXb+1WSUYIduMZ/cQ0hXfGT60qS8eqEJCzR0W/1Qx+knTinQSGH9QcXMELU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgc6ZLjx; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgc6ZLjx"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c96ef6e0afso117683b6e.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177935; cv=none;
        d=google.com; s=arc-20260327;
        b=TauTIdmZ5sD9em/51MqwLJXeB6LhQM2mcJYiUZNZlFmnFCY2qjlxsk223ebAfegbIH
         Rr9a7iXJRb/89svFxU68e+am36jDAPdT8btaJh/wcTP2eoMkn4FxeUb4QHxKU6D6v71/
         TYdIwQi/rn9FfmhgzBmgCXGUEJaca90NpYiWpj5p1oTq5S+2TfcV7LJwa9f4rC/R1WHK
         pJWi82vtvCHVNRxD6vfYg8o4bB6fecsXQxzw/DR8yWc1qtRGmcxq58IKDWbBHJo9ciyS
         6i1aPbWlgnRJZSXRTyZg5FgOXimIMVngMSL8rfcG+kYDaOA1snDo4iOLCP2T14Wv3sYR
         Tsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=471+xwzsHhix7zeMBIIU+C2QTB25AzHe0qndhZvonm0=;
        fh=a6kUVNAcf01Z+4JHC4y3mdLiPLxc2MnQqdw4foH9XsU=;
        b=jE9NZb8P3+0TXW9qAAMZ+gu8gEx2hCZ7C49hgYsva5xAiYI9PCC43reDeQPHfpCuB7
         Wqzi5Nl0N1l8Bj87m0/k1TdmlebEn2fniB37uYuCwiW0TKjlE54UAy/cN8vIgfJQHV4S
         NzLPLdFNMAmSbrAfpq6B//4YRBPTTjXEW+5pI5QIbdE3jLpwKFJAv5E/+98GJMrU5J8x
         Dk32WgONAt2NAo5pmYGp4S0dt8jjjVCtpXktkH14TIGdTEKfpvHWD0LEs6izSazSPgkt
         u1QdGngIe5M0nBJvRi52IzaalBgJ6T8amxfgHH5Y/8KjsajrQLFm9x04IIYfuRaCNFYq
         l4xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177935; x=1790782735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=471+xwzsHhix7zeMBIIU+C2QTB25AzHe0qndhZvonm0=;
        b=Lgc6ZLjxJeusXyd3EEeus6/sE1JDLDujyZs57woMUdQtc2Kjio2LZn53PlqdWY8WXT
         PtgkzzQP0ToxpHa1URnU5QbndZxyzO+oZnEWwQiIH7zzmPej8xSjBY5aySX0ud77uqtt
         k9rmz/ElydeS5nBSjOulsFVjWPNvLgjX1Cpj4tv5z5AvUTjibJznUimFF6bGEt/JYnND
         b01MckU/15AP/p7Ymcf/t4FYQM12Q30GgWluxCKw1MRqCAsPtHZfc8WLKpFviDNUoyWO
         QacCIOol8e1qIYJ7gxQyiOX1TsL3hqvUcuzvxk+OPAhBo+QpHXjDLjn6JRZO+PlIBCsR
         vWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177935; x=1790782735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=471+xwzsHhix7zeMBIIU+C2QTB25AzHe0qndhZvonm0=;
        b=dcTZHPgNdEkux30/ePAPHpExells6tfugwl60IEZ9E9+YefQzcJYYR69cicGlp+vtC
         xPRIfRALY0IOzOfWxBoRiy0jumBHhSuzhSWApA1v0WWpp1RvQ6CiBO7ejhvEdnW61EK7
         LOcvQc+qVWpJ8cKC/VoBVxGOs0K4NKFMpHaF+biCIilfCJnNKSL6wbx5Pn8+VXwD9H28
         0/tK+Q9XdRvjHsvw8QOGTLtx8jvIo5ti+vBXOpbdJqEsEYHGZeMPA1dZu2Btb2t1dXuS
         6ppLrfsN+XSVuWH8kqCWTkZcX7IASs2+gTVZ91Ja0Ivultu3tqyeXvdZdgWd0v2oekkP
         77Dg==
X-Forwarded-Encrypted: i=1; AKwUvBy0g7Czx4Llhvuqo8MQTXAOUSeBa7bvIlNes+XvLvREBnrNm5N3AJq7y5yBJFoBbaeV06jVQcE=@vger.kernel.org
X-Gm-Message-State: AFuF++ni1GvEABAInWqlqA5IsL9SpsvJJ5JGF7mJuakWmyOIqeaxVlYJ
	XQCXWceM6DNbirfAlDblR3Bwde+1OFhCBlk/uEZCSLQ7xXm8ac3pmIk3F4+NS/w4wKYYIVvyQhS
	Zj5QAvLj9lCIPXCBkVEXMoNGd72uePpc=
X-Gm-Gg: AYBFou0Hz04D064Ty/Y1cnrmRSYhWnsDnWegvcKC4u6wg7hjZTe1wDbv12chkQ99xs4
	+JWv0FExtdWlyhrSgRTNQKm/HyGVMHdLJF6KpS5Bd26eO/X5/Q8hzYhmHbfIyq/5QQMWw64pMVh
	yoPrtaWtq62lCxqAUCaODAwyaff3DsBXfR5sI/V7m2/zb6IVCTnytjW9aL4WFVuN6Kavc8jSZvS
	Oay04mt2nFUoh8x8mC3F1z4vNyDMmK84KAeN3/+v3iR1YAsepAHBDvGwkbFkXhkzJThC2LuBLFw
	IgGiik7JtZqSX+hMpJ2XG3r2AUW3bLk+0J9UxhcK9oL3/Jy5kRTK3oZFKEG10+imOsht4KQ=
X-Received: by 2002:a05:6808:148a:b0:496:9bf:c837 with SMTP id
 5614622812f47-4d5b3bf7584mr4092874b6e.0.1790177934516; Wed, 23 Sep 2026
 08:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-netcons_ratelimit-v3-0-8e81b789ab37@debian.org> <20260914-netcons_ratelimit-v3-2-8e81b789ab37@debian.org>
In-Reply-To: <20260914-netcons_ratelimit-v3-2-8e81b789ab37@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 23 Sep 2026 16:38:43 +0100
X-Gm-Features: AclHuK_jZZFxO2Dh2JWJerZTiWPe1oDb0kLQ1Sj5dw4U8L9ub-MiIvvivGhqr7E
Message-ID: <CAGSyskWZFfuCvvg8y+Re3VKhHWZiWrAxRkXXoFp9pgCrqxi=1g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/5] netconsole: add a per-target message rate limit
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, paulmck@kernel.org, asantostc@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:10=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Give each target a token bucket and consult it once per message in
> netconsole_write().
>
> The bucket is created with a zero interval, which struct ratelimit_state
> treats as unlimited, and nothing can set a nonzero one yet, so no target
> changes behaviour.
>
> Skip the bucket while the kernel is dying, reusing the helper the
> oops_only fix added, so a limit configured for steady-state logging
> never truncates an oops, BUG() or panic().
>
> The configfs files that expose it come next.
>
> ___ratelimit() only trylocks its own raw spinlock, so it is safe with
> target_list_lock held and interrupts disabled, and safe from NMI. Set
> RATELIMIT_MSG_ON_RELEASE so it does not report the suppressed count
> itself, which would printk() from inside the console being serviced.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

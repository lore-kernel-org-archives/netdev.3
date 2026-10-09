Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994E481FCF
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578211; cv=pass; b=taM0F1QvjDbEIVa6twQioA61+cIHzOZ6wo6l5thYPYNfI7FR1HQBxs0nfan7xZpgFi85NSYYY1EvNrXpESGRcgjZMYo7n4/Qgq36ieeyoQuRiNPki7kw8KsZ6fzFtlGpIzAwsdmjLs/IFtmXO3IrNU9Oszuoiy7UfhztVfHP0+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578211; c=relaxed/simple;
	bh=YYE3vIzKUzyIWt2szTE28K6cwUJ5X8wWypAelDLDJJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LokpieH/3hjxrEfz/ZbUWxPZmovxiPW9VLOQufXiYhuYR3hSIsodXHcSF7QcqSCr3uCmqPzAFN2MCLcsJGjuFWrv6qzxZ754jxtHA4aOYr5zOpZblT1a87Tkw1/A5JZ+5SDraxGlFYoYdky+wr8oGwBayi5+fAU5PcnAp9j1tkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llwQQKSO; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llwQQKSO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-88d16a45d79so15112b3a.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 13:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791578209; cv=none;
        d=google.com; s=arc-20260327;
        b=i6Cf2NmLg8dCyPm1KGnx9QD9ktL0l09qLvtIK+fkTeYUwGpQCKC7Ug57OtexgzfocO
         CPjRTo4lIH/ThAyGY2yUjoo4FGNnQ7mMJyC9RH4qvhKc6XGS9lC7J+5b9OUdBqdADMIQ
         D1IIikFmaiqI4Q1V5B74hdA1l4LXALqldZD1pMM5E4svzWn/z5hrf45VPK12o7+JT0+R
         1Ip5GBWBb2qjiS2amGUuf7qSPp44Obhq1ORVahytE0+ZQM3XxIPnkCFFOludBEB4mS9D
         a0XfgOQNKJXKJ8op9mBkvPW5jESZs/EkPbKvAn9v/1u/N6gLMN4dyMYLu++X+kdect4A
         tgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oq75LOykeXhBAHz9PJ+Sey28bzslRUQX2NhydrzoV1A=;
        fh=2EEHZThXO65LR6xOiTiJaR+OAKnLUK69rz1I6G1Ftpo=;
        b=XCbtWJtjf26Ay8HM711gCLi+1VZVe/wBYSLTFa3FEwQNnLbEru/NEVHnTQxUH/ThZw
         9wxq9+4+VujmnM3y1Qo+XgB1hjdbVxjRvG7gi797PW8yV1CPsfzstmQLHlT/2qwLLMBP
         DE2uzgmxCAiBhU+LryfjcE8cO9bGxi/EEH5G/aF/0QJfTn03RfPkU/vYneooiWg+JHeW
         pJX55VG1hZKHacZ49HLh+IU3jyq7Kq+aJRRA2hHamAwgPxaR1WJxC+oj4GNnegAGG7YJ
         5BTFSMr203v18FWHmjrPC59Tz4MlFro8AXozf8cYr/eFQvHTvpsiZyLEYu9hiqkPmI6X
         +boA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791578209; x=1792183009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oq75LOykeXhBAHz9PJ+Sey28bzslRUQX2NhydrzoV1A=;
        b=llwQQKSO1YF4jeOJpG9dk+hrB4mS9OGnvC8baJFOmewl3lI6+9ySdPzKa54uy1jWUo
         FelVNyeGcyIgbCmfq64YZl0A/gx2QjPZDt02ExxP6eIDixwQUK5epssJkezpm2tNgei4
         6tsOb67D0AyYDsOq/eyZmB6p8nS+e8c1ciAYGW9/iO/Oc3San8jNzOxI53WJKa+8mo3x
         nmq1Xv5MyhnOiRI8PQx+B3CuQt5tnReGizk5LAEmD2Yd2en2OMqwoSo8nBI5jUULhgfb
         nzotJi/SOFy1i3+b0tnPqkekI3U5xFB6H1qOH6tcE//l/1+67hSeoZ1rOLNNTV8tJZQO
         xYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791578209; x=1792183009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oq75LOykeXhBAHz9PJ+Sey28bzslRUQX2NhydrzoV1A=;
        b=QFEeGTf0P6ai5rfdrQhamQTALoFVDD2lZk6zC1Z9639Nhh9MzIIdogvbsjAFA46Kn1
         O6dDIM3ylUdnUf1mWp+65ytaZlfWWNUjZNoy7Dg7hvERAodG5/10l5C5sCtrTjylyNLi
         pcFe5u0/ShgCZSIBvjpVRvz9+yFqGtXOjDOGuXkKp0jQdX64fXJ/eHHFei+tZojWxnDN
         xCFLqJ81ztpNc+TTRBPxhmplboRuuOn49Z4Aitr+qgZSl5U9E8KgHcbqY9namSyb/NX+
         Rcb110p1tZlGk9YZQBHZHkYiZYrqAGXzbndlKmYbWsOE4e6s4LdiwFEWwAU9SATzHoq4
         yUOw==
X-Forwarded-Encrypted: i=1; AKwUvBxeQLRa4/yRCggcg/+MfhY3x4asB8qtVzyXBBFqNMJ/odCAoZImK/MUxrbKL/Ow2y5KuZBBdWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIWA2U/JwcAuHI3aP26e1JWlUc5QZE0S+spfdyP7Mg+D8JSK6Z
	u/PYpebQsHqH3Q7SLtJsfN57uv+3r1QIWcsfwH0WDcTGa772t45TqRVGcgKcQ/xpgboVBcNTISU
	SqcHODrZg12INOGKvmsEFZ7JU5lanX/E=
X-Gm-Gg: AYBFou2UPy/x4jIIZxBFBnubxAyIbfoSHRTzx8Tc5IcguM3zQNVD38/N6qpB7D1+SJr
	TGrBrEL55SzyWasKef1yDmMNp2GvjfMbWQg3/+F2SdHc7lhISESfI0o8UW8quEGXIkXVBjeYpDR
	C1MSDmtOqmbvQn3vqqVNn8oBdlsg8GGq7GRXbbW+yqsXc3wu9VMKCEjJdIq7zv+uo+4t6Stjb6n
	6KaYTpd5hJxD44UEBPdjzFQtQEbave9/sipzjvQVDRet/KouiTP3+qov/Z+fSt9Si+dtwjlEGOh
	shoe0Y2mZH3e1UqCNU5UiMOjtzS4e1plIUHDBFCTdfv6O+o64KUQgPPLYINndIwu+WalmU1uQhJ
	9dclGVQ==
X-Received: by 2002:a17:902:da4f:b0:2e5:da30:39c9 with SMTP id
 d9443c01a7336-2e84289f2c0mr38543735ad.2.1791578209212; Fri, 09 Oct 2026
 13:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-netcon_main-v1-1-6d298ab5a0cd@debian.org>
In-Reply-To: <20261009-netcon_main-v1-1-6d298ab5a0cd@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 9 Oct 2026 21:36:36 +0100
X-Gm-Features: AclHuK8cQhu9oRAOSf0i_0swCcZalD-Aryjk-1bUpbcJwiG-UgZTWwXMupX2NYE
Message-ID: <CAGSyskUgeV5cirJN4YSGT6_3SyhG37RGo7qhr49m5CVmv9zHmw@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Gustavo Luiz Duarte as netconsole reviewer
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Breno!

On Fri, Oct 9, 2026 at 4:16=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Gustavo has been the most active netconsole reviewer, let's add him
> to the MAINTAINERS file.
>
> Add an R: entry so get_maintainer.pl Cc's Gustavo on netconsole patches.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by:  Gustavo Luiz Duarte <gustavold@gmail.com>

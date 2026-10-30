Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357911;
	b=LZn7wRv23YpfD/IVdlwe5zq27L/RMSevtRltvr06B1O/NRA67FimVr3SZExQjjXuWNy5
	 YyB9zVlIKQtm7Nr5tvOMD14dUfVpx5govQlu2B3iMWXxqv8d6m6Ho1jvXTLx+CNUaMVe4
	 kksEDjY2B+t8lPiSu01CcN/X4vxhHM6npw6b4BPelnSnqN4E89sntrwNBA41WDI8ADaKB
	 rubZMdOpp/XybAedcby+Sw7P+559oGpKICZho6TC5yaBJDA6QnQL4xqGg7RK9Y0hWbhYL
	 8dbgwY1KOvRZ/BgAn7pqI7lCVyPyGPAyCwp3/QaUU/7q0qVXhQzdsjRs5qNsi55w+hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357911;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=qANwLEKHR+Q8Yt9LD0kW884nruLVZmuaF5lEr9bqDbs=;
	b=S92tnGEre1EMGHOEIx3ImDaYoyX1PNxY27jas9zZZP/6c2PBNt4QnsWEpr99eipTVrC9
	 biN/SpOZkKIIn9gdC78LlMaky0qSJ3oWhXYKxM5EU0T2WiAFVpiDvwepbNqhwcOvGnRTZ
	 qkx84goOiclco0E0eQPnYAQxzstmcrI5GuR03A+gjaxeRnGdX8zh1HBea5OoZBEnSkMID
	 Jnoidn/R+BZvsYfz/ty7UCoh8tqfwB4/G7id1vrSPh8fp/4i2C9ZtrjyIBqlcL8c2bapy
	 MwutlgsNhLLD6NnjeDQH4P4L1BVcZphz0KMfPA0ICYMxFjXJ1CC7wNA3MUd6xWIUKnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AC606D289
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674AC606D289
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ec6f271883so224693e0c.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357910; x=1793962710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qANwLEKHR+Q8Yt9LD0kW884nruLVZmuaF5lEr9bqDbs=;
        b=PPNCwhElqqiZ9tqVnyUs86ZnhxKn9UO+x44UD/JBJ+G68rXfNXPdhWIg6qFLsJEnqf
         UlmyKXJbwvOxZ8QNduqnPracWRn+WvmY4SZCiz/nxYGQzsqCbJbn6KOAzPOqqHIbLr3D
         TDOorawkpRFRzulaoF2H3+UCe437eiYwnEUUDc8bLkE0tStZiNQ2SHoANzua2EYjm3qV
         rBTKcaHB6abGsPr0lK7ogBNwFyp6eie8IvyA/IXSnT4TmzdEpUJ0LYaeCVvPS2l5tOYI
         oFcnEXTpwxdRrGCT/jHc9C/ENtnLBPLLj3Qvad8jRL6CnJX1pjlHY7j+AiBSr1G6ZOnd
         TlqA==
X-Gm-Message-State: AFq9FYK6m1wsrvoGSsJKxdTIkvMCokUdkhzZmdQhWuWS1rKZVRjfPynW
	szutlLx9wvOBpXE3jtDWCBbugMxlDK9vLc097k/2/CM8DJaKO7HlWmdfTELeLGPJ
X-Gm-Gg: AYBFou0zZwjABhFd7I7QJbKID88N2s/e2gnS+YHj2ruYTf3uKhdt4dY/s1QD9uR2cll
	MkPtaGPA9RdYMqhVVTf9ONXmXpDJuEWp1FTPUhsMrv7wAYHnAlT2aBnwYcdIiQhGTNM13bMd7nM
	AnDNf/RjBrCymiey4O53tHSA7obfFHoLoDXiwLGYAwDdq3eHpHq/UcinzXS5DdTx02TxTFsMYOE
	i+bpHJidJOUIIwzVTxBK1whf2jxtyN65pE6C4HYlGN8z0A8SkEE/5X8uuLv5XqerX0aP/yd5M4X
	xykviqeUi/LoDED7AHPFfNiMJHYpsY7XjkoN/zJ9sQSL3U7kpOY59M8HktV1xmAIn32EjRoy53A
	e4NnOyUf1dtaf6PM8LY0TYH1g7r/qlyFhBGFWwsl6QmM7zeUSbHc6IZzIU0DEJJHOG2Qx7K7VvZ
	dWjz+htcZDI0dD7h/VwtYLz0I8vM1BV2nEkf9xdckDOiykZL8Ir7Vfi9jmLxkz+t1JVT9dcrSmF
	YG82+fzZfNlLwgQBpFpC+ZnQruPBsNjpNcJdQoYNPPKtecsOPi2pcVuDx0TBI9iYJcewP9Wn90q
	WOnzOtk7ss43HkP+zyovCR7HNpGwzYWjqWSLBWC2BSF7d5QqojFRVuwOQnec7YhONgCPGbQ=
X-Received: by 2002:a05:6122:3284:b0:5ec:a9e:d80f with SMTP id 71dfb90a1353d-5ec6871c25fmr872536e0c.8.1793357910339;
        Fri, 30 Oct 2026 03:58:30 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf54casm1974868e0c.9.2026.10.30.03.58.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:58:29 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so535133e0c.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:58:29 -0700 (PDT)
X-Received: by 2002:a05:6102:3f44:b0:7cc:24e1:77b with SMTP id
 ada2fe7eead31-7d072270da8mr920373137.4.1793357909406; Fri, 30 Oct 2026
 03:58:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029153459.2257998-1-kuba@kernel.org> <9A74CA14-D4C0-4252-A3E7-256F9626B513@tipi-net.de>
In-Reply-To: <9A74CA14-D4C0-4252-A3E7-256F9626B513@tipi-net.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 11:58:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
X-Gm-Features: AclHuK9le6YNpAmBa-b_MrMdfR--FywlxS_qw1QqJzPLGdBMqrmLc_GWMKZnVUw
Message-ID: <CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
Subject: Re: [PATCH net] docs: netdev: try to force agents to disclose info
 for fixes
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 19:51, Nicolai Buchwitz <nb@tipi-net.de> wrote:
> On October 29, 2026 4:34:58 PM GMT+01:00, Jakub Kicinski <kuba@kernel.org> wrote:
> >"LLM-driven-developers" are not including the info about discovery
> >method we want to see in commit messages. Try to add more forceful
> >language to make agents ask for it. claude and codex seem to load
> >maintainer-netdev.rst already.
> >
> >Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> >--- a/Documentation/process/maintainer-netdev.rst
> >+++ b/Documentation/process/maintainer-netdev.rst
> >@@ -315,6 +315,10 @@ reproducer and against kernel selftests. If the bug is in a hardware driver,
> > the testing statement must include information about the HW on which the
> > fix was tested.
> >
> >+Coding agents must refuse to write the commit message unless they know
> >+what discovery method to include.
>
> Maybe make it more explicit, as the sinfo bot will ask it anyway:
>
> ... and whether it was reproduced or tested?

Which is true for anyone, not limited to bots...

Do we really need "different" guidelines for humans and bots?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

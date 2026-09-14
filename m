Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30F489FA4
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405053; cv=none; b=un8xjk0fmckCT1qOo1+/d0Y5lKUhbslq5XZSNwDg2UvmX1TLdkgQXJT1NhZN2Btojm8eiNgSf+k5MuBZsPkl5Qpo2qOe4o7NZDT29pf4zdEjL8hx5xYE0HN3BssNA1c/I70xjLul3FQlMFDVc56kAznzz7S3Z35gFSv4iyxMnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405053; c=relaxed/simple;
	bh=ushmip9d2SFG6bnjsZ8yz5Zdtn5SOGcJMUGcTuHYRJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7Fr+K5zZAk0dWOrYEPwphhWtT/uUVsoVu/g1SjQDCpTk1u2qvyJNCc60Ng4JxtD/j+DeyIIo4YA5+fJcH34AnfcgCFFehCDklKMjYvnWkEeTnBv8foMCaVkcztUrVlsObl5/WgjZD/M8NM15DhNmu+ENio2k/8Ux858vpMWzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7bab8eso1080790241.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789405050; x=1790009850;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UifqEQ+KQQAg0kseH9X1CMJd1CDr8OUeTRsEVk1uHRo=;
        b=kyPhpoPSMM2gnQ4s3UhrfTLwn03ZpRxeJdKmWzI1VpA8Ta8k8Ed5hONwyrEZHMeN5a
         zxxzLOhY5NQY4jAU+fRbx2VU6zhaguuuhvYbbdR4u4gPnie1Qmu7i3nVRjQlRKpzOAim
         dUruLJbHIAo5h9rVDM4v/L40OoGLRZcx7Rlr2XPr2p4+fuM1w/NHBAN/vEGdFnoQsciS
         M7jc+eGAfmgxlFusaH9M78ax1Zweh0L2J6jcWPrtdlChyc2jQHnEYAq0XLSOfNW9UMb+
         otrKSrSDxlmzhkdaMi3NCdJEX+1Fh9LCwcDDgR4QexnD1w7150xxb3eMQK+D66iztf0C
         /0fA==
X-Forwarded-Encrypted: i=1; AKwUvBz8AA3Ygs6Iow9q2fIKDE9fZfVZc58X1u3uPa2OXiqyuzYIHvuKLaV9h4F3xJlqFbIYFyGGP28=@vger.kernel.org
X-Gm-Message-State: AFuF++kpJLsIc9oD20FFfvgxX1R37mUe5zAav7kyka9M0GZDPzAK5Fma
	W1d30zk7moWXBSHUbiR6w528E+mG+OgIDrNuhvll9N4gCYIothnPv3VUQmwRVQZH
X-Gm-Gg: AYBFou10irc1zqy7a4y/UvhgJ2RLjlZEhpwTns9ksjqaAnbwG+/O1mcuQ2KSefN+ri9
	dclloM/2o5la02a3HUUqagm9c0C4PjQiB2+OWv87RFoEMPmbI0DDQLyGat2bYVWNbvAmej64sXP
	mtYG12AhFN1eIaeyPUjd7yU4IefXq7yd40rbDPIfiFNeyp4uA40SaGYhgg/WOkMuCNavNlXKfhR
	6uaV4N6aCioHL+ZMoixQyp/TpMx3aIj+ZyQQA7hIscVTlqa1zzhsGGn5o9i8uWrtJZhreyEvTWY
	4dVBMAS062GEAxlSOtSl1+WdB/EOeyqaxIBClftrAsf9ERrXDhwFkI+INl+JhvenSVVIQQ81SXq
	n2gaPauBiZTWlP7ORcRwg67v3I0ShQ4IJq1n62YFb2o+ovZuqzKKb1qtue2cvNqihK+BmH5I/yx
	2k5/6bDLtCAtVhNZhFEdzIrDXMEHKyOScyIW/mbeygXFeqSYJJV+8TxDqDXbOzVj4OrgFyhapSc
	vkGz+628pI8I9TL293367FtqwiJfSC4ehB6rQ==
X-Received: by 2002:a05:6102:94d:b0:79b:bd20:f311 with SMTP id ada2fe7eead31-79bbd20f31emr3381220137.1.1789405049749;
        Mon, 14 Sep 2026 09:57:29 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-982d7a58331sm6225616241.9.2026.09.14.09.57.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:57:29 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155b1so1243555241.3
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:57:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwvmM/j0kacZ/+sAo1iyzo4ZER/AjlmmJsffmFXl2judBAoRJ5ouNhtpZIiPRDssLZN+r+b2qc=@vger.kernel.org
X-Received: by 2002:a05:6102:148f:b0:79b:a93c:14a with SMTP id
 ada2fe7eead31-79ba93c04b6mr4018053137.8.1789405049110; Mon, 14 Sep 2026
 09:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-rzn1-miic-fix-array-v4-0-069112feec86@reliablecontrols.com>
 <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
In-Reply-To: <20260914-rzn1-miic-fix-array-v4-1-069112feec86@reliablecontrols.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2026 18:57:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVg02LSTMweWn4MN4qa5w8CyuVjynyGYH+HUxExSw6GSw@mail.gmail.com>
X-Gm-Features: AcwNN1UCiZdEM7pRQ2nOAAFuR2AD8XncIqdUbLRRpmHPk43RN4HtjN0VXTDTOVg
Message-ID: <CAMuHMdVg02LSTMweWn4MN4qa5w8CyuVjynyGYH+HUxExSw6GSw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] net: pcs: rzn1-miic: Fix config array initialization
To: khendry@reliablecontrols.com
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 18:41, Kyle Hendry via B4 Relay
<devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> From: Kyle Hendry <khendry@reliablecontrols.com>
>
> Fix memset parameters to initialize the entire DT value array
>
> Fixes: f39e968dc168a7bd ("net: pcs: rzn1-miic: Move configuration data to SoC-specific struct")
> Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
is still valid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

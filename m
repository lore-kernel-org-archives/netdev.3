Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794623616;
	b=xsQB/q2n+gTBbssSn7yDvokTCmd6RWKTQ3b0eD+3ivMVcrAqfOf4QJqR4Im1q4nss3gP
	 wxEKrFK9zL81vZeg03u/xuVjdhlfeWo+T1nBbZsfsLQuAhc9FC0+18j9mW6pXcDmCzuJB
	 ccB9hQHK+6rz6nvs8gxDMrWYN8pZGTgaOUTLEJb4Rnpua/kpvjGAgBWP9+Px0Dve2nn4m
	 6WhVMHbE6VsAu1/3r39g9lTXpZeANGS00kK/qKABRWt3HSLbsQST6MPCNE6xtlIsv+8PI
	 zU+/GHM06MtdljMJhglTEUj+VQcn62ug0tUSLbj09T0K/jQTiVu5neSppB/Ki/895Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794623616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
	b=vs51wMNnRzLNyggGpupNbkX4Yz3G2UPDODgUsyIT5GxRuvHKuGBy0+6XrNWEKjCXRf0r
	 MbuBvjRaji87OI0lTvrTPsjcsfNTmHPBm4EVj9j0xRc//5rhztmLatoYvsUquJl1jfMQ3
	 +wPl0JTqEV8FudFmVWVrajECAvnfju4AAoSrajAvJ0r8B9KNj4sk38u0YQZXXcXizDbfD
	 dy8YKuRNMlBPq9j+c93zK+TYv4A/LZdLDZCp0/QTIBz9Kzpw1PbXQ3y0oNPFDxrId6ejG
	 PmJv7mK1HrumdjEcu/LoUSgRhBVudMSShE10EoXcWFSMADGJGHan18oy50HqJ4upqNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpyhwBf2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE6606A32D
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 02:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5DE6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpyhwBf2
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ec396c93dso41112396d6.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 18:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794623615; cv=none;
        d=google.com; s=arc-20260327;
        b=P76Uw4EmpYoJZWXRB/lSQPRyoT8SawPwFngFKsVJBxu8DUbS5FbL+2nSc1ORSga1+F
         SGDPPbgxxeUYIUQcOuZz8OuddJgKEL0UqNx37RRUzmUkqNkvxAT7uAGP38KUkJzOoJeO
         +ZRS1BPs1L9N8tDFKPCBIJ1j1tNs2yGNDVEc3RTlskUmrna/gAjhyVufVT2tY1+cN2aY
         tO7EYGCt34wbxmtgcUgS9HcU3dmPiARJ+k7idaS8Ye80MYMGsk0BMCgppbRVVaZ7Rbqj
         ACjqNGJpMHsy8ZDXKeybiULbNXO8b/cK/8hWIzdoBrQIBPoynyY/w9VdM+DRNWTzKIS3
         1iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
        fh=JJwNc+kxR3VNaBp0kiU5jwm0JR4XfGIIenrpM7Mxols=;
        b=nnQFjqz0xpuoLm411biqdXBpbbJ5GXZ6ufSMQ555Mmi6owMj8imjKuTt4yAqKZh5PZ
         9K8/Hy6bKlUVEoOoUfCX4SXM/+Z1GCDmkMHHIy1UCZDFmEHXaDpMmAC+iv9ya/1Eu5W0
         P4+Se1VYTpcOH/fip/WK1PweRyTiGnyWBhJJXslS7ZXOOxnECV7tcJDMKiX+rfFL93Gs
         MHtEo/ocYnG9BLI44GDEVXI0xW5BREhSCmBdopEqOoPlSfOqzPC63KHEOehXi+ZfSKaU
         wI4CVhiYRoaIGDX61gdcCRh4RxvCDlGjVSj6sCl4J9S42zqY00PZ5l/tAQlQmqLwoQ0/
         lu+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794623615; x=1795228415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
        b=cpyhwBf2J6X2pdPgqT6uFinbC+cZWDMFfRBjSFx0RWM0tJyQlQh2JkQrnFEhUxBwdm
         cMXk0oRnH1iM2FlgUJtr14bX5lYTaDSVQvQazMr5+RMSyqpF62LcVh6Kmx7I6rkBQwxZ
         4B0sAvNZ8XfR0KeHSEAAEKS5aGRRr3Rg5rA4tl1y/g/DsrzWz/T0/uetEQ7t8QH6T5b7
         X/JjJ9X3e3L9uUvOCe5bIIIZxeuf9+o8ke9L1DANUdvR99hRRa5hXXCzYndOHnHKWJvs
         eic+kKavTP/lYmQOFaiK29aiOHL56z2kh2wof4fBxmWYGidLFGwlmO8Lk0PErdB1tH3P
         AKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623615; x=1795228415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJehl/EaRvv7fxLuacOZsocXgCWzK0RPTXvgb7IEb98=;
        b=VzI+eYK4vsjjp2z+iWW9CO4uWEj3SeitgCsc55wb1qpEJ4z73c3+SunRfhxfgJOH6y
         D8iyI0S/koK95LdMf7BH8/uqsfjgKxojjpP4gVwY5+mInicG/11go7BD7SspiU2XKxhb
         YPJSp6egENB3gYkXRgHz7Y+Xv2koItv+hrF0E8IkxqUvgIjdzoNxceYwP6xmSdBllGLU
         +UOLT66GMAaMl4xRpXF6E0aaSDqdMz+Tu0IylPxZ5jlrgu/1ke5v3qv3rL0YTq1yxCEA
         rXL8Sjwnw86ESEPgbI+a/L3KeKL5vMx/Kob6DL+btPrzUITNq1cfW3GlbHCDBZD5IKHB
         aXbA==
X-Forwarded-Encrypted: i=1; AL+hErE1VevkiEMx17Jn9gM06OSedCguBygHWDe93NHBUu+d8HnvDRt82sPv+rNnPcmY31hPDb5zycQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qi22foUp6MzUMjkMKqgNGT0kkwRMMrT3RsWwcAQsrSED/d4Tp
	K8TRvqhOKlyoeXcEn4nlilF5GDQfkxZPz071zy8cy2eESQ+eV9kcwOzKzi2FwzA9rG2abB6eBgM
	xIo2dsBlFuNcaM8PnbV5+RgBJEbb2eSM=
X-Gm-Gg: AYBFou3W8QO4/W58juPESxAqDXu5Nem2VaRbyeF9+LWwz7Sgkztg5MOep3PwpqGa1PX
	K9vWf3I7EiEuhjqCGhxZ9K/QhRI/y8bY/7VKv5a8fOW9xgR7IgclaGLIYhGbkp72FQ29KfVtNuF
	kuniIuzIaIC68dp1saKOLkCJAIviyQg/KZ+1KrkvEJPueAGeG2qON7d9UJeME4McGijx8ON1gA8
	TTQY5FRTSUwKfwJeCK2UztXaFnEM/s52J3xYk3qkt8Bk3HWCWmo+Dq1sjvB4BDaMrRh/C2lafYV
	OzlP3NvSaMe0sKiBgUihR7giSmddTuG32dz/oc5uxp8HL0Gxo3cPcpQy3YxBpPAgqkZ/u50ix0z
	7uuDZfGZ1UYbcuP7NF/Jjj14kSg+AU/MESH/n
X-Received: by 2002:a05:6214:5907:b0:91e:938c:1615 with SMTP id
 6a1803df08f44-91f242070b7mr68774826d6.40.1794623614738; Fri, 13 Nov 2026
 18:33:34 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114015554.2187341-1-zxyan0222@gmail.com> <179462149962.2168702.2687296647559611353@kernel.org>
In-Reply-To: <179462149962.2168702.2687296647559611353@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Sat, 14 Nov 2026 10:33:23 +0800
X-Gm-Features: AclHuK9PJFdnYQp60hzQr-aoL6oSJj2AKTDyP8sv_Y5ch8KGojZzj_LkveAYZWE
Message-ID: <CAP7veT+LavpYFKWuniXO8ddfXF7cYXNO-r_r=0Bj_pKVXJdawg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: re-enable on-chip parity checkers for
 XGMAC ASP 0x2
To: netdev-bot+sinfo@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, horms@kernel.org, 
	0x1207@gmail.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was triggered on real hardware during safety-feature
validation of an XGMAC integration: FSM state parity error injection
did not raise the expected safety interrupt.

There is no kernel log to quote for the failure itself -- the defect
is a silently skipped register write.

On XGMAC 3.10 and 3.40 cores, with the patch applied the checkers
come up enabled on ASP 0x2 devices and the same FSM parity error
injection now raises the safety interrupt as expected.

On Sat, Nov 14, 2026 at 9:58=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
